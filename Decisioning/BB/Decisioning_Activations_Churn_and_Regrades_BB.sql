Call Decisioning_Procs.Update_Decisioning_Activations_and_Churn_BB()

Setuser Decisioning_Procs

//Drop procedure Decisioning_Procs.Update_Decisioning_Activations_and_Churn_BB
create Procedure Decisioning_Procs.Update_Decisioning_Activations_and_Churn_BB(Refresh_Dt date default null)
SQL SECURITY INVOKER
BEGIN


SET TEMPORARY OPTION Query_Temp_Space_Limit = 0; commit;

-- Drop variable if exists Refresh_dt; Create variable Refresh_dt date;

-- Set Refresh_dt = '2018-02-20';
--select Refresh_dt;
If Refresh_Dt is null then
BEGIN
Set Refresh_dt = (Select max(Event_Dt) - 4 * 7 from Decisioning.Churn_BB);
END;
End If;



select
  effective_from_dt, effective_to_dt
 ,status_start_dt,status_end_dt
, Account_Number
,Account_Type,Account_Sub_Type
,current_product_description
,Status_Code,prev_status_code
,first_activation_dt
,cb_Key_Household,Created_By_ID,Current_Product_sk,Ent_Cat_Prod_sk,First_Order_ID
,Order_ID,Order_Line_ID,PH_Subs_Hist_sk,Service_Instance_ID,Subscription_ID
,Owning_Cust_Account_ID
,currency_code
, Case when Currency_Code = 'EUR' then 'ROI' else 'UK' end Country
,Cast(Case when status_code in ('AC','AB','PC','BCRQ','CF','PT') then 1 else 0 end as smallint) as Number_Of_Active_Subs
,CASE WHEN Current_Product_sk = 43373 THEN 'Sky Broadband Unlimited (Legacy)' ELSE Current_Product_Description END as BB_Product_Description
,CASE WHEN BB_Product_Description='Broadband Connect' Then 'Connect'
     WHEN BB_Product_Description In ('?','Other','Missing at load') Then 'Other'
     WHEN BB_Product_Description like 'Sky Broadband Lite%' Then Substr(BB_Product_Description,1,200)
     WHEN BB_Product_Description like 'Sky Broadband %' Then Substr(BB_Product_Description,15,200)
     WHEN BB_Product_Description='Sky Fibre Unlimited Pro' Then 'Fibre Unlimited Pro'
     WHEN BB_Product_Description like 'Sky Fibre %' Then Substr(BB_Product_Description,5,200)
     WHEN BB_Product_Description like 'Sky Connect %' Then Substr(BB_Product_Description,5,200)
     Else BB_Product_Description
End as Product_Holding
into #BB_Subs
from cust_subs_hist csh_EoD
where --right(account_number,3) = '927' and
        effective_from_dt >= Refresh_dt
        and effective_from_dt < effective_to_dt
--         and csh_EoD.status_code in ('AC','PC','AB','BCRQ')
        AND subscription_sub_type = 'Broadband DSL Line'
        and account_number != '?'
        and owning_cust_account_id > '1'
union
select
  effective_from_dt
, effective_to_dt
,status_start_dt,status_end_dt
, Account_Number
,Account_Type,Account_Sub_Type
,current_product_description
,Status_Code,prev_status_code
,first_activation_dt
,cb_Key_Household,Created_By_ID,Current_Product_sk,Ent_Cat_Prod_sk,First_Order_ID
,Order_ID,Order_Line_ID,PH_Subs_Hist_sk,Service_Instance_ID,Subscription_ID
, Owning_Cust_Account_ID
,currency_code
, Case when Currency_Code = 'EUR' then 'ROI' else 'UK' end Country
,Cast(Case when status_code in ('AC','AB','PC','BCRQ','CF','PT') then 1 else 0 end as smallint) as Number_Of_Active_Subs
,CASE WHEN Current_Product_sk = 43373 THEN 'Sky Broadband Unlimited (Legacy)' ELSE Current_Product_Description END as BB_Product_Description
,CASE WHEN BB_Product_Description='Broadband Connect' Then 'Connect'
     WHEN BB_Product_Description In ('?','Other','Missing at load') Then 'Other'
     WHEN BB_Product_Description like 'Sky Broadband Lite%' Then Substr(BB_Product_Description,1,200)
     WHEN BB_Product_Description like 'Sky Broadband %' Then Substr(BB_Product_Description,15,200)
     WHEN BB_Product_Description='Sky Fibre Unlimited Pro' Then 'Fibre Unlimited Pro'
     WHEN BB_Product_Description like 'Sky Fibre %' Then Substr(BB_Product_Description,5,200)
     WHEN BB_Product_Description like 'Sky Connect %' Then Substr(BB_Product_Description,5,200)
     Else BB_Product_Description
End as Product_Holding
from cust_subs_hist csh_EoD
where --right(account_number,3) = '927' and
        effective_to_dt >= Refresh_dt
        and effective_from_dt < effective_to_dt
--         and csh_EoD.status_code in ('AC','PC','AB','BCRQ')
        AND subscription_sub_type = 'Broadband DSL Line'
        and account_number != '?'
        and owning_cust_account_id > '1'
;

Select subscription_id,min(effective_from_dt) First_Activation_Dt
into #First_Acc_Dt
from cust_subs_hist csh
where subscription_sub_type = 'Broadband DSL Line'
        and account_number != '?'
        and owning_cust_account_id > '1'
        and status_code = 'AC'
group by subscription_id;

commit;
create hg index idx_1 on #First_Acc_Dt(subscription_id);

Update #BB_Subs BB
Set first_activation_dt = act.first_activation_dt
from #First_Acc_Dt act
where act.subscription_id = BB.subscription_id;


commit;
create hg index idx_1 on #BB_Subs(Account_number);
create date index idx_2 on #BB_Subs(effective_from_dt);
create cmp index idx_3 on #BB_Subs(effective_from_dt,effective_to_dt);
create lf index idx_4 on #BB_Subs(Status_Code);
create hg index idx_5 on #BB_Subs(subscription_id);


Select distinct account_number,subscription_id, effective_from_dt
into #Movement_Dts
from #BB_Subs
where effective_from_dt >= Refresh_dt;

Select
 Dts.effective_from_dt as Event_Dt
,Dts.account_number
,Dts.Subscription_Id
,Coalesce(SoD.Number_Of_Active_Subs,0) as SoD_Active_Sub
,Coalesce(EoD.Number_Of_Active_Subs,0) as EoD_Active_Sub
,Case when SoD_Active_Sub = 0 and EoD_Active_Sub > 0 then 1 else 0 end Subscription_Activation
,Case when SoD_Active_Sub > 0 and EoD_Active_Sub = 0 then 1 else 0 end Subscription_Churn
,SoD.Product_Holding as SoD_Product_Holding
,EoD.Product_Holding as EoD_Product_Holding

,Coalesce(EoD.Account_Type,SoD.Account_Type) as Account_Type
,Coalesce(EoD.Account_Sub_Type,SoD.Account_Sub_Type) as Account_Sub_Type
,Coalesce(EoD.cb_Key_Household,SoD.cb_Key_Household) as cb_Key_Household
,Coalesce(EoD.Created_By_Id,SoD.Created_By_Id) as Created_By_Id
,Case when Subscription_Activation > 0 then EoD.Current_Product_sk when Subscription_Churn > 0 then SoD.Current_Product_sk end as Current_Product_sk
,Case when Subscription_Activation > 0 then EoD.Ent_Cat_Prod_sk when Subscription_Churn > 0 then SoD.Ent_Cat_Prod_sk end as Ent_Cat_Prod_sk
,Coalesce(EoD.First_Order_ID,SoD.First_Order_ID) as First_Order_ID
,Coalesce(EoD.Order_ID,SoD.Order_ID) as Order_ID
,Coalesce(EoD.Owning_Cust_Account_ID,SoD.Owning_Cust_Account_ID) as Owning_Cust_Account_ID
,Coalesce(EoD.Order_Line_ID,SoD.Order_Line_ID) as Order_Line_ID
,Coalesce(EoD.PH_Subs_Hist_sk,SoD.PH_Subs_Hist_sk) as PH_Subs_Hist_sk
,Coalesce(EoD.Service_Instance_ID,SoD.Service_Instance_ID) as Service_Instance_ID
,Coalesce(EoD.Country,SoD.Country) as Country

,EoD.Status_Code as EoD_Status_Code

,Row_Number() over(partition by Dts.account_number,Dts.effective_from_dt,Dts.Subscription_ID
                   order by SoD.Number_Of_Active_Subs desc,EoD.Number_Of_Active_Subs desc, SoD.effective_from_dt desc,EoD.effective_from_dt desc) Subs_Rnk

,Row_Number() over(partition by Dts.account_number,Dts.effective_from_dt
                   order by SoD.Number_Of_Active_Subs desc,EoD.Number_Of_Active_Subs desc, SoD.effective_from_dt desc,EoD.effective_from_dt desc) Acc_Rnk
into #BB_Movements
from #Movement_Dts Dts
     left join
     #BB_Subs SoD
     on Dts.account_number = SoD.account_number
        and Dts.subscription_id = SoD.subscription_id
        and Dts.effective_from_dt between SoD.effective_from_dt + 1 and SoD.effective_to_dt
     left join
     #BB_Subs EoD
     on Dts.account_number = EoD.account_number
        and Dts.subscription_id = EoD.subscription_id
        and Dts.effective_from_dt between EoD.effective_from_dt and EoD.effective_to_dt - 1
        ;

Delete from #BB_Movements where Subs_Rnk > 1;



Select *
,Sum(SoD_Active_Sub) over(partition by Account_Number,Event_Dt) as SoD_Active_Subs
,Sum(EoD_Active_Sub) over(partition by Account_Number,Event_Dt) as EoD_Active_Subs
into #BB_Movements_2
from #BB_Movements;


-- Insert into churn table
Delete from Decisioning.Churn_BB where Event_Dt >= Refresh_dt;

Insert into Decisioning.Churn_BB
Select
 null as Subs_Year
,null as Subs_Quarter
,null as Subs_Week
,null as Subs_Week_And_Year
,Event_Dt
,Account_Number
,Owning_Cust_Account_ID
,Account_Type
,Account_Sub_Type
,cb_Key_Household
,Created_By_ID
,Current_Product_sk
,Ent_Cat_Prod_sk
,First_Order_ID
,Order_ID
,Order_Line_ID
,PH_Subs_Hist_sk
,Service_Instance_ID
,Subscription_ID
,Country
,EoD_Product_Holding as Product_Holding
,EoD_Status_Code as Status_Code
,Case when SoD_Active_Subs > 0 and EoD_Active_Subs = 0 and Acc_Rnk = 1 then 1 else 0 end as BB_Subscriber_Churn
,Subscription_Churn - Subscription_Activation as BB_Subscription_Churn
from #BB_Movements_2
where SoD_Active_Subs > EoD_Active_Subs
        and Subscription_Activation + Subscription_Churn > 0;

Update Decisioning.Churn_BB ta
Set  Subs_Year = sc.Subs_Year
    ,Subs_Quarter = sc.Subs_Quarter_Of_Year
    ,Subs_Week = sc.Subs_Week_Of_Year
    ,Subs_Week_And_Year = Cast(sc.Subs_Week_And_Year as integer)
from sky_calendar sc
where ta.Subs_Year is null and sc.calendar_date = ta.event_dt;




-- Insert into activations table
Delete from Decisioning.Activations_BB       where Event_Dt >= Refresh_dt;

Insert into Decisioning.Activations_BB
Select
 null as Subs_Year
,null as Subs_Quarter
,null as Subs_Week
,null as Subs_Week_And_Year
,Event_Dt
,Account_Number
,Owning_Cust_Account_ID
,Account_Type
,Account_Sub_Type
,cb_Key_Household
,Created_By_ID
,Current_Product_sk
,Ent_Cat_Prod_sk
,First_Order_ID
,Order_ID
,Order_Line_ID
,PH_Subs_Hist_sk
,Service_Instance_ID
,Subscription_ID
,Country
,EoD_Product_Holding as Product_Holding
,EoD_Status_Code as Status_Code
,Case when SoD_Active_Subs = 0 and EoD_Active_Subs > 0 and Acc_Rnk = 1 then 1 else 0 end as BB_Subscriber_Activation
,Subscription_Activation - Subscription_Churn as BB_Subscription_Activation
from #BB_Movements_2
where SoD_Active_Subs < EoD_Active_Subs
        and Subscription_Activation + Subscription_Churn > 0;


Update Decisioning.Activations_BB ta
Set  Subs_Year = sc.Subs_Year
    ,Subs_Quarter = sc.Subs_Quarter_Of_Year
    ,Subs_Week = sc.Subs_Week_Of_Year
    ,Subs_Week_And_Year = Cast(sc.Subs_Week_And_Year as integer)
from sky_calendar sc
where ta.Subs_Year is null and sc.calendar_date = ta.event_dt;



-- Insert into regrades table
Delete from Decisioning.Regrades_BB       where Event_Dt >= Refresh_dt;

Insert into Decisioning.Regrades_BB
Select
 null as Subs_Year
,null as Subs_Quarter
,null as Subs_Week
,null as Subs_Week_And_Year
,Event_Dt
,Account_Number
,Owning_Cust_Account_ID
,Account_Type
,Account_Sub_Type
,cb_Key_Household
,Created_By_ID
,Current_Product_sk
,Ent_Cat_Prod_sk
,First_Order_ID
,Order_ID
,Order_Line_ID
,PH_Subs_Hist_sk
,Service_Instance_ID
,Subscription_ID
,Country
,SoD_Product_Holding as Product_Holding_SoD
,EoD_Product_Holding as Product_Holding_EoD
,today() as Last_Modified_Dt
from #BB_Movements_2
where Subscription_Activation = 0
      and Subscription_Churn = 0
      and EoD_Active_Subs >= SoD_Active_Subs
      and SoD_Active_Subs > 0
      and Product_Holding_SoD != Product_Holding_EoD;


Update Decisioning.Regrades_BB ta
Set  Subs_Year = sc.Subs_Year
    ,Subs_Quarter = sc.Subs_Quarter_Of_Year
    ,Subs_Week = sc.Subs_Week_Of_Year
    ,Subs_Week_And_Year = Cast(sc.Subs_Week_And_Year as integer)
from sky_calendar sc
where ta.Subs_Year is null and sc.calendar_date = ta.event_dt;

End;

Grant execute on Decisioning_Procs.Update_Decisioning_Activations_and_Churn_BB to Decisioning;