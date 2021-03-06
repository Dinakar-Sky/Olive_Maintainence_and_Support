setuser Decisioning_Procs;
GO
DROP PROCEDURE if exists Decisioning_Procs.Update_Active_Subscriber_Report_BBBOOST;
GO
create procedure Decisioning_Procs.Update_Active_Subscriber_Report_BBBOOST( Refresh_Dt date default null ) 
sql security invoker
begin
  /*
   create variable refresh_dt date ;
   set refresh_dt = '2012-01-01'
  */
  set temporary option Query_Temp_Space_Limit = 0;

  commit work;
  if Refresh_Dt is null then
    set Refresh_dt = (select max(effective_from_dt)-4*7 from Decisioning.Active_Subscriber_Report_Src where subscription_sub_type = 'BBBOOST');
    set Refresh_dt = case when Refresh_dt > today()-4*7 then today()-4*7 else Refresh_dt end
  end if;

  select ph_subs_hist_sk,
    Account_Number,
    Account_Type,
    Account_Sub_Type,
    Owning_Cust_Account_ID,
    Subscription_Type,
    Current_Product_sk,
    cast(null as varchar(80)) as Subscription_Sub_Type,
    cast(null as date) as Effective_From_Dt,
    cast(null as date) as Effective_To_Dt,
    Effective_From_Datetime,
    cast(null as integer) as Active_Subscriber,
    cast(null as integer) as Effective_From_Subs_Week,
	cast(null as integer) as Effective_To_Subs_Week,
	cast(null as smallint) as Number_Of_Active_Subs,
    cast(null as varchar(80)) as Product_Description,
    cast(csh.current_product_description as varchar(80)) as Product_Holding,
    Subscription_ID,Service_Instance_ID,Status_Code,SI_LATEST_SRC,
    cast(null as varchar(3)) as Country,
    current_product_description,
	ENT_CAT_PROD_SK,
    cast(null as integer) as OfferCode,
	cast(null as varchar(240)) as BOXSET_FLAG,
	cast(null as varchar(3)) as HDPremiumFlag,
    cast(0 as tinyint) as Overlapping_Records,
    Status_Start_Dt,
    Status_End_Dt,
    Status_Reason,
    Prev_Status_Code
    into #Subs_Movements
    from Cust_Subs_Hist as csh
    where 1 = 0;
	
  commit work;
  create hg index idx_1 on #Subs_Movements(Owning_Cust_Account_ID);
  create date index idx_2 on #Subs_Movements(Effective_From_Dt);
  create date index idx_3 on #Subs_Movements(Effective_To_Dt);
  create lf index idx_4 on #Subs_Movements(Subscription_Sub_Type);
  create lf index idx_5 on #Subs_Movements(Number_Of_Active_Subs);
  create lf index idx_6 on #Subs_Movements(Product_Holding);
  create hg index idx_9 on #Subs_Movements(current_product_description);
  create hg index idx_10 on #Subs_Movements(ENT_CAT_PROD_SK);
  create hg index idx_11 on #Subs_Movements(ph_subs_hist_sk);
  create hg index idx_12 on #Subs_Movements(subscription_id);
  create lf index idx_13 on #Subs_Movements(Overlapping_Records);
  create dttm index idx_14 on #Subs_Movements(Effective_From_Datetime);
  
  insert into #Subs_Movements
    select ph_subs_hist_sk,
      Account_Number,
      Account_Type,
      Account_Sub_Type,
      csh.Owning_Cust_Account_ID,
      'BB RELATED SUBS' as Subscription_Type,
      Current_Product_sk,
      'BBBOOST' as Subscription_Sub_Type,
      Effective_From_Dt,
      Effective_To_Dt,
      Effective_From_Datetime,
      cast(null as integer) as Effective_From_Subs_Week,
      cast(null as integer) as Effective_To_Subs_Week,
      cast(null as integer) as Active_Subscriber,
      cast(case when status_code in( 'AC','AB','PC') then 1 else 0 end as smallint) as Number_Of_Active_Subs,
      Current_Product_Description,
	  Current_Product_Description,
      Subscription_ID,
      Service_Instance_ID,
      Status_Code,
      SI_LATEST_SRC,
      case when currency_code = 'EUR' then 'ROI' else 'UK' end as Country,
      current_product_description,
      ENT_CAT_PROD_SK,
      cast(null as integer) as OfferCode,
      cast(null as varchar(240)) as BOXSET_FLAG,
      cast(null as varchar(3)) as HDPremiumFlag,
      cast(0 as tinyint) as Overlapping_Records,
      Status_Start_Dt,
      Status_End_Dt,
      Status_Reason,
      Prev_Status_Code
      from Cust_Subs_Hist as csh
        left outer join cust_entitlement_lookup as cel
        on cel.short_description = csh.current_short_description
      where csh.effective_to_dt >= Refresh_dt
      and csh.Subscription_Sub_Type = 'BBBOOST'
      and csh.account_number <> '99999999999999'
      and csh.OWNING_CUST_ACCOUNT_ID > '1'
      and csh.SI_LATEST_SRC = 'CHORD'
      and csh.effective_to_dt > csh.effective_from_dt;
	  
delete from #Subs_Movements where Product_Holding not like  '%Sky Broadband Boost%';
	  
  select owning_cust_account_id,subscription_id,Max(Number_Of_Active_Subs) as Inc_Active_subscription
    into #Inactive_Subs
    from #Subs_Movements
    group by owning_cust_account_id,subscription_id
    having Inc_Active_subscription = 0;
	
  commit work;
  create hg index idx_1 on #Inactive_Subs(owning_cust_account_id);
  create hg index idx_2 on #Inactive_Subs(subscription_id);
  
  delete from #Subs_Movements as sm from
    #Subs_Movements as sm
    join #Inactive_Subs as ins
    on ins.owning_cust_account_id = sm.owning_cust_account_id
    and ins.subscription_id = sm.subscription_id;
  
  select sm.ph_subs_hist_sk,cast(null as datetime) as Min_Effective_From_Dt
    into #Correct_Effect_To_Dates
    from #Subs_Movements as sm where 1 = 0;
  
  insert into #Correct_Effect_To_Dates
    select sm.ph_subs_hist_sk,min(sm_2.effective_from_dt) as Min_Effective_From_Dt
      from #Subs_Movements as sm
        join #Subs_Movements as sm_2
        on sm_2.owning_cust_account_id = sm.owning_cust_account_id
        and sm_2.subscription_id = sm.subscription_id
        and sm.effective_to_dt > sm_2.effective_from_dt
        and sm_2.effective_from_dt > sm.effective_from_dt
        and sm_2.ph_subs_hist_sk <> sm.ph_subs_hist_sk
      where(sm.Number_Of_Active_Subs > 0 and sm_2.Number_Of_Active_Subs > 0)
      group by sm.ph_subs_hist_sk;
  
  update #Subs_Movements as sm
    set Effective_To_Dt = cast(cetd.Min_Effective_From_Dt as date) from
    #Correct_Effect_To_Dates as cetd
    where cetd.ph_subs_hist_sk = sm.ph_subs_hist_sk;
  
  drop table if exists #Correct_Effect_To_Dates;
  
  delete from #Subs_Movements as sm from
    #Subs_Movements as sm
    join #Subs_Movements as os
    on os.owning_cust_account_id = sm.owning_cust_account_id
    and os.subscription_id = sm.subscription_id
    and os.subscription_sub_type = sm.subscription_sub_type
    and os.effective_from_dt between sm.effective_from_dt+1 and sm.effective_to_dt-1
    and sm.effective_to_dt = '9999-09-09';
  
  delete from #Subs_Movements where effective_to_dt < Refresh_Dt;
  
  delete from Decisioning.Active_Subscriber_Report_Src
    where Effective_To_Dt >= Refresh_Dt
    and subscription_sub_type = any(select distinct subscription_sub_type from #Subs_Movements);
  
  select sm.ph_subs_hist_sk,sm.effective_to_dt,max(asr.effective_to_dt) as effective_from_dt
    into #Effective_To
    from #Subs_Movements as sm
      join Decisioning.Active_Subscriber_Report_Src as asr
      on asr.ph_subs_hist_sk = sm.ph_subs_hist_sk
      and sm.subscription_sub_type = asr.subscription_sub_type
      and asr.effective_to_dt < Refresh_Dt
      and Refresh_dt between sm.effective_from_dt+1 and sm.effective_to_dt
    group by sm.ph_subs_hist_sk,sm.effective_to_dt;
  
  commit work;
  
  create hg index idx_1 on #Effective_To(ph_subs_hist_sk);
  create date index idx_2 on #Effective_To(effective_to_dt);
  
  update #Subs_Movements as sm
    set Effective_From_Dt = asr.effective_from_dt from
    #Effective_To as asr
    where asr.ph_subs_hist_sk = sm.ph_subs_hist_sk
    and asr.effective_to_dt = sm.effective_to_dt;
  
  drop table if exists #Effective_To;
  
  commit work;
  
  insert into Decisioning.Active_Subscriber_Report_Src( Effective_From_Dt,Effective_To_Dt,Account_Number,Account_Type,Account_Sub_Type,Owning_Cust_Account_ID,Subscription_Type,Subscription_Sub_Type,
    Service_Instance_ID,Subscription_ID,ph_subs_hist_sk,Status_Code,Current_Product_sk,Product_Holding,Country,Active_Subscriber,Active_Subscription,
    PH_Subs_Status_Start_Dt,PH_Subs_Status_End_Dt_Dt,PH_Subs_Prev_Status_Code,
    PH_Subs_Status_Reason ) 
    select osm.Effective_From_Dt,
      osm.Effective_To_Dt,
      osm.Account_Number,
      osm.Account_Type,
      osm.Account_Sub_Type,
      osm.Owning_Cust_Account_ID,
      osm.Subscription_Type,
      osm.Subscription_Sub_Type,
      osm.Service_Instance_ID,
      osm.Subscription_ID,
      osm.ph_subs_hist_sk,
      osm.Status_Code,
      osm.Current_Product_sk,
      osm.Product_Holding,
      osm.Country,
      osm.Number_Of_Active_Subs as Active_Subscriber,
      osm.Number_Of_Active_Subs as Active_Subscription,
      osm.Status_Start_Dt,
      osm.Status_End_Dt,
      osm.Prev_Status_Code,
      osm.Status_Reason
      from #Subs_Movements as osm
      where osm.Number_Of_Active_Subs > 0;
  commit work;
  
  select asr.owning_cust_account_id,asr.subscription_sub_type,asr.effective_from_dt as Change_Dt
    into #Active_Subs_Change_Dts
    from Decisioning.Active_Subscriber_Report_Src as asr
      join Decisioning.Active_Subscriber_Report_Src as asr_2
      on asr_2.owning_cust_account_id = asr.owning_cust_account_id
      and asr_2.subscription_sub_type = asr.subscription_sub_type
      and asr_2.ph_subs_hist_sk <> asr.ph_subs_hist_sk
      and asr_2.subscription_id <> asr.subscription_id
      and asr.effective_from_dt between asr_2.effective_from_dt and asr_2.effective_to_dt
      and asr_2.Subscription_Sub_Type = 'BBBOOST'
      and asr_2.Active_Subscriber = 1
	where asr.Effective_To_Dt >= Refresh_Dt
    and asr.Subscription_Sub_Type = 'BBBOOST'
    and asr.Active_Subscriber = 1
    group by asr.owning_cust_account_id,asr.subscription_sub_type,asr.effective_from_dt union
  
  select asr.owning_cust_account_id,asr.subscription_sub_type,asr.effective_to_dt as Change_Dt
    from Decisioning.Active_Subscriber_Report_Src as asr
      join Decisioning.Active_Subscriber_Report_Src as asr_2
      on asr_2.owning_cust_account_id = asr.owning_cust_account_id
      and asr_2.subscription_sub_type = asr.subscription_sub_type
      and asr_2.ph_subs_hist_sk <> asr.ph_subs_hist_sk
      and asr_2.subscription_id <> asr.subscription_id
      and asr.effective_to_dt between asr_2.effective_from_dt and asr_2.effective_to_dt
      and asr_2.Subscription_Sub_Type = 'BBBOOST'
      and asr_2.Active_Subscriber = 1
    where asr.Effective_To_Dt >= Refresh_Dt
    and asr.Subscription_Sub_Type = 'BBBOOST'
    and asr.Active_Subscriber = 1
    group by asr.owning_cust_account_id,asr.subscription_sub_type,asr.effective_to_dt;
	
  while(select count() from #Active_Subs_Change_Dts) > 0 loop
    drop table if exists #Loop_Change_Dts;
    select owning_cust_account_id,subscription_sub_type,min(Change_Dt) as Change_Dt
      into #Loop_Change_Dts
      from #Active_Subs_Change_Dts
      group by owning_cust_account_id,subscription_sub_type;
    drop table if exists #temp_Split_Records;
    select sm.*
      into #temp_Split_Records
      from Decisioning.Active_Subscriber_Report_Src as sm
        join #Loop_Change_Dts as lcd
        on sm.owning_cust_account_id = lcd.owning_cust_account_id
        and sm.subscription_sub_type = lcd.subscription_sub_type
        and lcd.change_dt between sm.effective_from_dt+1 and sm.effective_to_dt-1;
    update #temp_Split_Records as sm
      set effective_to_dt = lcd.change_dt from
      #Loop_Change_Dts as lcd
      where sm.owning_cust_account_id = lcd.owning_cust_account_id
      and sm.subscription_sub_type = lcd.subscription_sub_type
      and lcd.change_dt between sm.effective_from_dt+1 and sm.effective_to_dt-1;
    update Decisioning.Active_Subscriber_Report_Src as sm
      set effective_from_dt = lcd.change_dt from
      #Loop_Change_Dts as lcd
      where sm.owning_cust_account_id = lcd.owning_cust_account_id
      and sm.subscription_sub_type = lcd.subscription_sub_type
      and lcd.change_dt between sm.effective_from_dt+1 and sm.effective_to_dt-1;
    insert into Decisioning.Active_Subscriber_Report_Src
      select * from #temp_Split_Records;
    delete from #Active_Subs_Change_Dts as ascd from
      #Loop_Change_Dts as lcd
      where ascd.owning_cust_account_id = lcd.owning_cust_account_id
      and ascd.subscription_sub_type = lcd.subscription_sub_type
      and ascd.Change_Dt = lcd.Change_Dt
  end loop;
  
  drop table if exists #Active_Subs_Change_Dts;
  drop table if exists #Loop_Change_Dts;
  drop table if exists #temp_Split_Records;
  update Decisioning.Active_Subscriber_Report_Src as asr
    set Effective_From_Subs_Week = cast(sc.subs_week_and_year as integer) from
    Decisioning.Active_Subscriber_Report_Src as asr
    join sky_calendar as sc
    on sc.calendar_date = asr.effective_from_dt
    where asr.Effective_From_Subs_Week is null;
  update Decisioning.Active_Subscriber_Report_Src as asr
    set Effective_To_Subs_Week = cast(Coalesce(sc.subs_week_and_year,'999999') as integer) from
    Decisioning.Active_Subscriber_Report_Src as asr
    left outer join sky_calendar as sc
    on sc.calendar_date = asr.effective_to_dt
    where(asr.Effective_To_Subs_Week is null
    or asr.Effective_To_Subs_Week = 999999);
  select distinct Substr(current_product_description,15,200) as Sky_BB_Type
    into #Sky_BB_Types
    from cust_subs_hist
    where subscription_sub_type = 'BBBOOST';
  select Owning_Cust_Account_ID,ph_subs_hist_sk,Effective_From_Dt,Subscription_Sub_Type,
    1 as Prod_Holding_Num,
    cast(case status_code
    when 'AC' then 1
    when 'PC' then 2
    when 'AB' then 3
    else 999
    end as integer) as Status_Num,
    Row_Number() over(partition by Owning_Cust_Account_Id,subscription_sub_type,Effective_From_Dt order by Prod_Holding_Num desc,Status_Num asc) as Acc_Rnk
    into #Order_Subs_Movements
    from Decisioning.Active_Subscriber_Report_Src as asr
      left outer join #Sky_BB_Types
      on #Sky_BB_Types.Sky_BB_Type = asr.Product_Holding
    where effective_to_dt >= Refresh_Dt
    and subscription_sub_type in('BBBOOST');
  commit work;
  create hg index idx_1 on #Order_Subs_Movements(Owning_Cust_Account_ID);
  create hg index idx_2 on #Order_Subs_Movements(ph_subs_hist_sk);
  create date index idx_3 on #Order_Subs_Movements(Effective_From_Dt);
  create lf index idx_4 on #Order_Subs_Movements(Subscription_Sub_Type);
  create lf index idx_5 on #Order_Subs_Movements(Acc_Rnk);
  update Decisioning.Active_Subscriber_Report_Src as asr
    set Active_Subscriber = case when osm.Acc_Rnk = 1 then 1 else 0 end from
    #Order_Subs_Movements as osm
    where osm.ph_subs_hist_sk = asr.ph_subs_hist_sk
    and osm.Owning_Cust_Account_ID = asr.Owning_Cust_Account_ID
    and osm.Subscription_Sub_Type = asr.Subscription_Sub_Type
    and osm.Effective_From_Dt = asr.Effective_From_Dt
end

GO
GRANT EXECUTE ON Decisioning_Procs.Update_Active_Subscriber_Report_BBBOOST TO public;

/*
call Decisioning_Procs.Update_Active_Subscriber_Report_BBBOOST('2012-01-01');

*/