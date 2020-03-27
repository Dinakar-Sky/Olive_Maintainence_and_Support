Setuser Decisioning_Procs
GO
Drop Procedure If Exists Decisioning_Procs.Update_Decisioning_Activations_and_Churn_BB;
GO
create procedure Decisioning_Procs.Update_Decisioning_Activations_and_Churn_BB(Refresh_Dt date default null ) 
sql security invoker
begin
  
  set temporary option Query_Temp_Space_Limit = 0;
  commit work;
  if Refresh_Dt is null then
    set Refresh_dt = (select max(Event_Dt)-4*7 from Decisioning.Churn_BB)
  end if;
  
  select effective_from_dt,effective_to_dt,
    status_start_dt,status_end_dt,
    Account_Number,
    Account_Type,Account_Sub_Type,
    current_product_description,
    Status_Code,prev_status_code,
    first_activation_dt,
    cb_Key_Household,Created_By_ID,Current_Product_sk,Ent_Cat_Prod_sk,First_Order_ID,
    Order_ID,Order_Line_ID,PH_Subs_Hist_sk,Service_Instance_ID,Subscription_ID,
    Owning_Cust_Account_ID,
    currency_code,
    case when Currency_Code = 'EUR' then 'ROI' else 'UK' end as Country,
    cast(case when status_code in( 'AC','AB','PC','BCRQ','CF','PT' ) then 1 else 0 end as smallint) as Number_Of_Active_Subs,
    case when Current_Product_sk = 43373 then 'Sky Broadband Unlimited (Legacy)' else Current_Product_Description end as BB_Product_Description,
    case when BB_Product_Description = 'Broadband Connect' then 'Connect'
    when BB_Product_Description in( '?','Other','Missing at load' ) then 'Other'
    when BB_Product_Description like 'Sky Broadband Lite%' then Substr(BB_Product_Description,1,200)
    when BB_Product_Description like 'Sky Broadband %' then Substr(BB_Product_Description,15,200)
    when BB_Product_Description = 'Sky Fibre Unlimited Pro' then 'Fibre Unlimited Pro'
    when BB_Product_Description like 'Sky Fibre %' then Substr(BB_Product_Description,5,200)
    when BB_Product_Description like 'Sky Connect %' then Substr(BB_Product_Description,5,200)
    else BB_Product_Description
    end as Product_Holding
    into #BB_Subs
    from cust_subs_hist as csh_EoD
    where effective_from_dt >= Refresh_dt
    and effective_from_dt < effective_to_dt
    and subscription_sub_type = 'Broadband DSL Line'
    and account_number <> '?'
    and owning_cust_account_id > '1' union
  
  select effective_from_dt,
    effective_to_dt,
    status_start_dt,status_end_dt,
    Account_Number,
    Account_Type,Account_Sub_Type,
    current_product_description,
    Status_Code,prev_status_code,
    first_activation_dt,
    cb_Key_Household,Created_By_ID,Current_Product_sk,Ent_Cat_Prod_sk,First_Order_ID,
    Order_ID,Order_Line_ID,PH_Subs_Hist_sk,Service_Instance_ID,Subscription_ID,
    Owning_Cust_Account_ID,
    currency_code,
    case when Currency_Code = 'EUR' then 'ROI' else 'UK' end as Country,
    cast(case when status_code in( 'AC','AB','PC','BCRQ','CF','PT' ) then 1 else 0 end as smallint) as Number_Of_Active_Subs,
    case when Current_Product_sk = 43373 then 'Sky Broadband Unlimited (Legacy)' else Current_Product_Description end as BB_Product_Description,
    case when BB_Product_Description = 'Broadband Connect' then 'Connect'
    when BB_Product_Description in( '?','Other','Missing at load' ) then 'Other'
    when BB_Product_Description like 'Sky Broadband Lite%' then Substr(BB_Product_Description,1,200)
    when BB_Product_Description like 'Sky Broadband %' then Substr(BB_Product_Description,15,200)
    when BB_Product_Description = 'Sky Fibre Unlimited Pro' then 'Fibre Unlimited Pro'
    when BB_Product_Description like 'Sky Fibre %' then Substr(BB_Product_Description,5,200)
    when BB_Product_Description like 'Sky Connect %' then Substr(BB_Product_Description,5,200)
    else BB_Product_Description
    end as Product_Holding
    from cust_subs_hist as csh_EoD
    where effective_to_dt >= Refresh_dt
    and effective_from_dt < effective_to_dt
    and subscription_sub_type = 'Broadband DSL Line'
    and account_number <> '?'
    and owning_cust_account_id > '1';
  
  select subscription_id,min(effective_from_dt) as First_Activation_Dt
    into #First_Acc_Dt
    from cust_subs_hist as csh
    where subscription_sub_type = 'Broadband DSL Line'
    and account_number <> '?'
    and owning_cust_account_id > '1'
    and status_code = 'AC'
    group by subscription_id;
  
  commit work;
  create hg index idx_1 on #First_Acc_Dt(subscription_id);
  
  update #BB_Subs as BB
    set first_activation_dt = act.first_activation_dt from
    #First_Acc_Dt as act
    where act.subscription_id = BB.subscription_id;
  commit work;
  
  create hg index idx_1 on #BB_Subs(Account_number);
  create date index idx_2 on #BB_Subs(effective_from_dt);
  create cmp index idx_3 on #BB_Subs(effective_from_dt,effective_to_dt);
  create lf index idx_4 on #BB_Subs(Status_Code);
  create hg index idx_5 on #BB_Subs(subscription_id);
  
  select distinct account_number,subscription_id,effective_from_dt
    into #Movement_Dts
    from #BB_Subs
    where effective_from_dt >= Refresh_dt;
  
  select Dts.effective_from_dt as Event_Dt,
    Dts.account_number,
    Dts.Subscription_Id,
    Coalesce(SoD.Number_Of_Active_Subs,0) as SoD_Active_Sub,
    Coalesce(EoD.Number_Of_Active_Subs,0) as EoD_Active_Sub,
    case when SoD_Active_Sub = 0 and EoD_Active_Sub > 0 then 1 else 0 end as Subscription_Activation,
    case when SoD_Active_Sub > 0 and EoD_Active_Sub = 0 then 1 else 0 end as Subscription_Churn,
    SoD.Product_Holding as SoD_Product_Holding,
    EoD.Product_Holding as EoD_Product_Holding,
    Coalesce(EoD.Account_Type,SoD.Account_Type) as Account_Type,
    Coalesce(EoD.Account_Sub_Type,SoD.Account_Sub_Type) as Account_Sub_Type,
    Coalesce(EoD.cb_Key_Household,SoD.cb_Key_Household) as cb_Key_Household,
    Coalesce(EoD.Created_By_Id,SoD.Created_By_Id) as Created_By_Id,
    case when Subscription_Activation > 0 then EoD.Current_Product_sk when Subscription_Churn > 0 then SoD.Current_Product_sk end as Current_Product_sk,
    case when Subscription_Activation > 0 then EoD.Ent_Cat_Prod_sk when Subscription_Churn > 0 then SoD.Ent_Cat_Prod_sk end as Ent_Cat_Prod_sk,
    Coalesce(EoD.First_Order_ID,SoD.First_Order_ID) as First_Order_ID,
    Coalesce(EoD.Order_ID,SoD.Order_ID) as Order_ID,
    Coalesce(EoD.Owning_Cust_Account_ID,SoD.Owning_Cust_Account_ID) as Owning_Cust_Account_ID,
    Coalesce(EoD.Order_Line_ID,SoD.Order_Line_ID) as Order_Line_ID,
    Coalesce(EoD.PH_Subs_Hist_sk,SoD.PH_Subs_Hist_sk) as PH_Subs_Hist_sk,
    Coalesce(EoD.Service_Instance_ID,SoD.Service_Instance_ID) as Service_Instance_ID,
    Coalesce(EoD.Country,SoD.Country) as Country,
    EoD.Status_Code as EoD_Status_Code,
    Row_Number() over(partition by Dts.account_number,Dts.effective_from_dt,Dts.Subscription_ID order by
    SoD.Number_Of_Active_Subs desc,EoD.Number_Of_Active_Subs desc,SoD.effective_from_dt desc,EoD.effective_from_dt desc) as Subs_Rnk,
    Row_Number() over(partition by Dts.account_number,Dts.effective_from_dt order by
    SoD.Number_Of_Active_Subs desc,EoD.Number_Of_Active_Subs desc,SoD.effective_from_dt desc,EoD.effective_from_dt desc) as Acc_Rnk
    into #BB_Movements
    from #Movement_Dts as Dts
      left outer join #BB_Subs as SoD
      on Dts.account_number = SoD.account_number
      and Dts.subscription_id = SoD.subscription_id
      and Dts.effective_from_dt between SoD.effective_from_dt+1 and SoD.effective_to_dt
      left outer join #BB_Subs as EoD
      on Dts.account_number = EoD.account_number
      and Dts.subscription_id = EoD.subscription_id
      and Dts.effective_from_dt between EoD.effective_from_dt and EoD.effective_to_dt-1;
  
  delete from #BB_Movements where Subs_Rnk > 1;
  
  select *,
    Sum(SoD_Active_Sub) over(partition by Account_Number,Event_Dt) as SoD_Active_Subs,
    Sum(EoD_Active_Sub) over(partition by Account_Number,Event_Dt) as EoD_Active_Subs
    into #BB_Movements_2
    from #BB_Movements;
  
  delete from Decisioning.Churn_BB where Event_Dt >= Refresh_dt;
  insert into Decisioning.Churn_BB
    select null as Subs_Year,
      null as Subs_Quarter,
      null as Subs_Week,
      null as Subs_Week_And_Year,
      Event_Dt,
      Account_Number,
      Owning_Cust_Account_ID,
      Account_Type,
      Account_Sub_Type,
      cb_Key_Household,
      Created_By_ID,
      Current_Product_sk,
      Ent_Cat_Prod_sk,
      First_Order_ID,
      Order_ID,
      Order_Line_ID,
      PH_Subs_Hist_sk,
      Service_Instance_ID,
      Subscription_ID,
      Country,
      EoD_Product_Holding as Product_Holding,
      EoD_Status_Code as Status_Code,
      case when SoD_Active_Subs > 0 and EoD_Active_Subs = 0 and Acc_Rnk = 1 then 1 else 0 end as BB_Subscriber_Churn,
      Subscription_Churn-Subscription_Activation as BB_Subscription_Churn
      from #BB_Movements_2
      where SoD_Active_Subs > EoD_Active_Subs
      and Subscription_Activation+Subscription_Churn > 0;
  
  update Decisioning.Churn_BB as ta
    set Subs_Year = sc.Subs_Year,
    Subs_Quarter = sc.Subs_Quarter_Of_Year,
    Subs_Week = sc.Subs_Week_Of_Year,
    Subs_Week_And_Year = cast(sc.Subs_Week_And_Year as integer) from
    sky_calendar as sc
    where ta.Subs_Year is null and sc.calendar_date = ta.event_dt;
  
  delete from Decisioning.Activations_BB where Event_Dt >= Refresh_dt;
  insert into Decisioning.Activations_BB
    select null as Subs_Year,
      null as Subs_Quarter,
      null as Subs_Week,
      null as Subs_Week_And_Year,
      Event_Dt,
      Account_Number,
      Owning_Cust_Account_ID,
      Account_Type,
      Account_Sub_Type,
      cb_Key_Household,
      Created_By_ID,
      Current_Product_sk,
      Ent_Cat_Prod_sk,
      First_Order_ID,
      Order_ID,
      Order_Line_ID,
      PH_Subs_Hist_sk,
      Service_Instance_ID,
      Subscription_ID,
      Country,
      EoD_Product_Holding as Product_Holding,
      EoD_Status_Code as Status_Code,
      case when SoD_Active_Subs = 0 and EoD_Active_Subs > 0 and Acc_Rnk = 1 then 1 else 0 end as BB_Subscriber_Activation,
      Subscription_Activation-Subscription_Churn as BB_Subscription_Activation
      from #BB_Movements_2
      where SoD_Active_Subs < EoD_Active_Subs
      and Subscription_Activation+Subscription_Churn > 0;
  
  update Decisioning.Activations_BB as ta
    set Subs_Year = sc.Subs_Year,
    Subs_Quarter = sc.Subs_Quarter_Of_Year,
    Subs_Week = sc.Subs_Week_Of_Year,
    Subs_Week_And_Year = cast(sc.Subs_Week_And_Year as integer) from
    sky_calendar as sc
    where ta.Subs_Year is null and sc.calendar_date = ta.event_dt;
  
  delete from Decisioning.Regrades_BB where Event_Dt >= Refresh_dt;
  
  insert into Decisioning.Regrades_BB
    select null as Subs_Year,
      null as Subs_Quarter,
      null as Subs_Week,
      null as Subs_Week_And_Year,
      Event_Dt,
      Account_Number,
      Owning_Cust_Account_ID,
      Account_Type,
      Account_Sub_Type,
      cb_Key_Household,
      Created_By_ID,
      Current_Product_sk,
      Ent_Cat_Prod_sk,
      First_Order_ID,
      Order_ID,
      Order_Line_ID,
      PH_Subs_Hist_sk,
      Service_Instance_ID,
      Subscription_ID,
      Country,
      SoD_Product_Holding as Product_Holding_SoD,
      EoD_Product_Holding as Product_Holding_EoD
      from #BB_Movements_2
      where Subscription_Activation = 0
      and Subscription_Churn = 0
      and EoD_Active_Subs >= SoD_Active_Subs
      and SoD_Active_Subs > 0
      and Product_Holding_SoD <> Product_Holding_EoD;
  
  update Decisioning.Regrades_BB as ta
    set Subs_Year = sc.Subs_Year,
    Subs_Quarter = sc.Subs_Quarter_Of_Year,
    Subs_Week = sc.Subs_Week_Of_Year,
    Subs_Week_And_Year = cast(sc.Subs_Week_And_Year as integer) from
    sky_calendar as sc
    where ta.Subs_Year is null and sc.calendar_date = ta.event_dt
end
GO