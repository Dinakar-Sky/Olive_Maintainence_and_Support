/*

dba.sp_drop_table 'Decisioning','PL_Entries_BB'
dba.sp_create_table 'Decisioning','PL_Entries_BB',
   'Subs_Year integer default null, '
|| 'Subs_Quarter_Of_Year tinyint default null, '
|| 'Subs_Week_Of_Year tinyint default null, '
|| 'Subs_Week_And_Year integer default null, '
|| 'Event_Dt date default null, '
|| 'Order_ID varchar(50) default null, '
|| 'Account_Number varchar(20) default null, '
|| 'Account_Type varchar(255) default null, '
|| 'Account_Sub_Type varchar(255) default null, '
|| 'Owning_Cust_Account_ID varchar(50) default null, '
|| 'PH_Subs_Hist_sk decimal(22,0) default null, '
|| 'Subscription_Type varchar(20) default null, '
|| 'Subscription_Sub_Type varchar(80) default null, '
|| 'Service_Instance_ID varchar(50) default null, '
|| 'Subscription_ID varchar(50) default null, '
|| 'Current_Product_sk integer default null, '
|| 'Product_Holding varchar(80) default null, '
|| 'Country varchar(3) default null, '
|| 'Created_By_ID varchar(50) default null,'
|| 'prev_status_code varchar(5) default null, '
|| 'Status_Code varchar(5) default null, '
|| 'Enter_SysCan tinyint default 0,'
|| 'Enter_CusCan tinyint default 0,'
|| 'Enter_HM tinyint default 0,'
|| 'Enter_3rd_Party tinyint default 0, '
|| 'PC_Effective_To_Dt date default null, '
|| 'PC_Future_Sub_Effective_Dt date default null, '
|| 'PC_Next_Status_Code varchar(4) default null, '
|| 'AB_Effective_To_Dt date default null, '
|| 'AB_Future_Sub_Effective_Dt date default null, '
|| 'AB_Next_Status_Code varchar(4) default null, '
|| 'BCRQ_Effective_To_Dt date default null, '
|| 'BCRQ_Future_Sub_Effective_Dt date default null, '
|| 'BCRQ_Next_Status_Code varchar(4) default null, '
|| 'BB_Cust_Type varchar(20) default null, '
|| 'ProdPlat_Churn_Type varchar(10) default null '

Create lf index idx_1 on Decisioning.PL_Entries_BB(Subs_Year);
Create lf index idx_2 on Decisioning.PL_Entries_BB(Subs_Quarter_Of_Year);
Create lf index idx_3 on Decisioning.PL_Entries_BB(Subs_Week_Of_Year);
Create hg index idx_4 on Decisioning.PL_Entries_BB(Subs_Week_And_Year);
Create date index idx_5 on Decisioning.PL_Entries_BB(Event_Dt);
Create hg index idx_6 on Decisioning.PL_Entries_BB(Account_Number);
Create lf index idx_7 on Decisioning.PL_Entries_BB(Country);
Create lf index idx_8 on Decisioning.PL_Entries_BB(Enter_SysCan);
Create lf index idx_9 on Decisioning.PL_Entries_BB(Enter_CusCan);
Create lf index idx_10 on Decisioning.PL_Entries_BB(Enter_HM);
Create lf index idx_11 on Decisioning.PL_Entries_BB(Enter_3rd_Party);
Create lf index idx_12 on Decisioning.PL_Entries_BB(BB_Cust_Type);
Create lf index idx_13 on Decisioning.PL_Entries_BB(ProdPlat_Churn_Type);


call DBA.sp_DDL ('create', 'view', 'Decisioning', 'PL_Entries_BB_View',  ' Select * from Decisioning.PL_Entries_BB')
setuser Decisioning
Grant select on Decisioning.PL_Entries_BB_View to citeam
call DBA.sp_DDL ('drop', 'view', 'CITeam', 'PL_Entries_BB')
call DBA.sp_DDL ('create', 'view', 'CITeam', 'PL_Entries_BB',  ' Select * from Decisioning.PL_Entries_BB_View')


Select top 1000 * from Decisioning.PL_Entries_BB

*/


Drop Procedure If Exists vha02.Update_Decisioning_PL_Entries_BB;
GO
create procedure vha02.Update_Decisioning_PL_Entries_BB( Refresh_Dt date default null ) 
sql security invoker
begin
  
  set temporary option Query_Temp_Space_Limit = 0;
  commit work;
  
  if Refresh_Dt is null then
    set Refresh_Dt = (select Max(Event_Dt)-6*7 from CITeam.PL_Entries_BB_beta)
  end if;
  
  select null as Subs_Year,
    null as Subs_Quarter_of_year,
    null as subs_week_of_year,
    null as Subs_week_and_year,
    -- case when WH_ADDRESS_ROLE.AD_CREATED_DT is null then 'No Homemove' else 'Homemove' end as HM_FLAG,
	case when WH_PH_SUBS_HIST.STATUS_REASON = 'Moving Home' then 'Homemove' else 'No Homemove' end as HM_FLAG,
	 
    cast(WH_PH_SUBS_HIST.EFFECTIVE_FROM_DT as date) as Event_Dt,
    WH_PH_SUBS_HIST.Order_ID,
    WH_PH_SUBS_HIST.account_number,
    WH_PH_SUBS_HIST.Account_Type,
    WH_PH_SUBS_HIST.Account_Sub_Type,
    WH_PH_SUBS_HIST.Owning_Cust_Account_ID,
    WH_PH_SUBS_HIST.PH_Subs_Hist_sk,
    WH_PH_SUBS_HIST.Subscription_Type,
    WH_PH_SUBS_HIST.Subscription_Sub_Type,
    WH_PH_SUBS_HIST.Service_Instance_ID,
    WH_PH_SUBS_HIST.Subscription_ID,
    WH_PH_SUBS_HIST.Current_Product_sk,
    case when WH_PH_SUBS_HIST.Current_Product_sk = 43373 then 'Sky Broadband Unlimited (Legacy)' else WH_PH_SUBS_HIST.Current_Product_Description end as BB_Product_Description,
    case when BB_Product_Description = 'Broadband Connect' then 'Connect'
    when BB_Product_Description in( '?','Other','Missing at load' ) then 'Other'
    when BB_Product_Description like 'Sky Broadband Lite%' then Substr(BB_Product_Description,1,200)
    when BB_Product_Description like 'Sky Broadband %' then Substr(BB_Product_Description,15,200)
    when BB_Product_Description = 'Sky Fibre Unlimited Pro' then 'Fibre Unlimited Pro'
    when BB_Product_Description like 'Sky Fibre %' then Substr(BB_Product_Description,5,200)
    when BB_Product_Description like 'Sky Connect %' then Substr(BB_Product_Description,5,200)
    else BB_Product_Description
    end as Product_Holding,
    case when WH_PH_SUBS_HIST.currency_code = 'GBP' then 'UK'
    when WH_PH_SUBS_HIST.currency_code = 'EUR' then 'ROI'
    else 'Other'
    end as Country,WH_PH_SUBS_HIST.created_by_id,
    WH_PH_SUBS_HIST.prev_status_code,
    WH_PH_SUBS_HIST.status_code,
    case when((WH_PH_SUBS_HIST.STATUS_CODE in( 'AB','PC' ) and WH_PH_SUBS_HIST.PREV_STATUS_CODE in( 'AC','AB','PC' ) )
    or(WH_PH_SUBS_HIST.STATUS_CODE = 'AB' and WH_PH_SUBS_HIST.PREV_STATUS_CODE = 'CF')
    or(WH_PH_SUBS_HIST.STATUS_CODE = 'PC' and WH_PH_SUBS_HIST.PREV_STATUS_CODE = 'PT')
    or(WH_PH_SUBS_HIST.STATUS_CODE = 'BCRQ' and WH_PH_SUBS_HIST.PREV_STATUS_CODE in( 'AB','PT' ) and WH_PH_SUBS_HIST.STATUS_REASON_CODE in( '900','84' ) )
    or(WH_PH_SUBS_HIST.STATUS_CODE = 'BCRQ' and WH_PH_SUBS_HIST.PREV_STATUS_CODE in( 'PC','CF' ) and WH_PH_SUBS_HIST.STATUS_REASON_CODE in( '79','80' ) )
    or(PREVPH.PREV_STATUS_CODE = 'AB'
    and WH_PH_SUBS_HIST.PREV_STATUS_CODE = 'BCRQ'
    and PREVPH.STATUS_REASON_CODE not in( '900','84' ) 
    and WH_PH_SUBS_HIST.STATUS_CODE = 'PC')
    or(PREVPH.PREV_STATUS_CODE = 'PC'
    and WH_PH_SUBS_HIST.PREV_STATUS_CODE = 'BCRQ'
    and PREVPH.STATUS_REASON_CODE not in( '79','80' ) 
    and WH_PH_SUBS_HIST.STATUS_CODE = 'AB')) then
      'Yes' else 'No' end as IN_Report_Where,
    case when WH_PH_SUBS_HIST.STATUS_REASON_CODE = '900' then '1 = 3rd Party'
    when WH_PH_SUBS_HIST.STATUS_CODE = 'AB' then '2 = SysCan'
    when WH_PH_SUBS_HIST.STATUS_CODE = 'PC' then '3 = CusCan'
    when WH_PH_SUBS_HIST.STATUS_CODE = 'BCRQ' and WH_PH_SUBS_HIST.PREV_STATUS_CODE in( 'AB','PT' ) 
    and WH_PH_SUBS_HIST.STATUS_REASON_CODE in( '900','84' ) then
      '3 = CusCan'
    when WH_PH_SUBS_HIST.STATUS_CODE = 'BCRQ' and WH_PH_SUBS_HIST.PREV_STATUS_CODE in( 'PC','CF' ) then '2 = SysCan'
    else 'Check'
    end as TPSYCU,
    -- case when IN_Report_Where = 'Yes' and TPSYCU = '2 = SysCan' then 1 else 0 end as Enter_SysCan,
	case when WH_PH_SUBS_HIST.STATUS_CODE = 'AB' or WH_PH_SUBS_HIST.STATUS_REASON_CODE in ('79','80') then 1 else 0 end as Enter_SysCan,
	
	--case when IN_Report_Where = 'Yes' and HM_FLAG = 'Homemove' then 1 else 0 end as Enter_HM,
	case when Enter_SysCan = 0 and HM_FLAG = 'Homemove' then 1 else 0 end as Enter_HM, -- recheck 
	
    -- case when IN_Report_Where = 'Yes' and TPSYCU = '1 = 3rd Party' and HM_FLAG = 'No Homemove' then 1 else 0 end as Enter_3rd_Party
	case when WH_PH_SUBS_HIST.STATUS_REASON_CODE = '900' and HM_FLAG = 'No Homemove' and Enter_SysCan = 0 then 1 else 0 end as Enter_3rd_Party,
	
    --case when IN_Report_Where = 'Yes' and TPSYCU in( '1 = 3rd Party','3 = CusCan' ) and HM_FLAG = 'No Homemove' and TPSYCU <> '1 = 3rd Party' then 1 else 0 end as Enter_CusCan,
	case when Enter_SysCan =0 and Enter_HM = 0 and Enter_3rd_Party = 0   then 1 else 0 end as Enter_CusCan
    
	
    into #BB_PL_Subs
    from Cust_Subs_Hist as WH_PH_SUBS_HIST
     /* left outer join CUST_ALL_ADDRESS as WH_ADDRESS_ROLE
      on WH_PH_SUBS_HIST.OWNING_CUST_ACCOUNT_ID = WH_ADDRESS_ROLE.CUST_ACCOUNT_ID
      and cast(WH_PH_SUBS_HIST.EFFECTIVE_FROM_DT as date) = cast(WH_ADDRESS_ROLE.AD_CREATED_DT as date)
      and WH_ADDRESS_ROLE.CHANGE_REASON_CODE in( 'MHWITHINST','MHNOINST' ) */
      left outer join Cust_Subs_Hist as PREVPH
      on(WH_PH_SUBS_HIST.SUBSCRIPTION_ID = PREVPH.SUBSCRIPTION_ID
      and WH_PH_SUBS_HIST.STATUS_START_DT = PREVPH.STATUS_END_DT
      and WH_PH_SUBS_HIST.STATUS_START_DT > PREVPH.STATUS_START_DT
      and PREVPH.STATUS_CODE_CHANGED = 'Y'
      and WH_PH_SUBS_HIST.PREV_STATUS_CODE = PREVPH.STATUS_CODE
      and PREVPH.SUBSCRIPTION_SUB_TYPE = 'Broadband DSL Line'
      and WH_PH_SUBS_HIST.SUBSCRIPTION_SUB_TYPE = 'Broadband DSL Line'
      and cast(WH_PH_SUBS_HIST.FIRST_ACTIVATION_DT as date) < '9999-01-01')
    where WH_PH_SUBS_HIST.EFFECTIVE_FROM_DT >= Refresh_Dt
    and WH_PH_SUBS_HIST.SUBSCRIPTION_SUB_TYPE = 'Broadband DSL Line'
    and cast(WH_PH_SUBS_HIST.FIRST_ACTIVATION_DT as date) < '9999-01-01'
    and WH_PH_SUBS_HIST.Status_Code in( 'AB','PC','BCRQ' ) 
    and WH_PH_SUBS_HIST.STATUS_CODE_CHANGED = 'Y'
    and WH_PH_SUBS_HIST.EFFECTIVE_TO_DT >= '2012-06-01 00:00:00';
  commit work;
  
  delete from CITeam.PL_Entries_BB_beta where event_dt >= Refresh_Dt;
  
  insert into CITeam.PL_Entries_BB_beta
    select null as Subs_Year,
      null as Subs_Quarter_Of_Year,
      null as Subs_Week_Of_Year,
      null as Subs_Week_And_Year,
      Event_Dt,
      Order_ID,
      Account_Number,
      Account_Type,
      Account_Sub_Type,
      Owning_Cust_Account_ID,
      PH_Subs_Hist_sk,
      Subscription_Type,
      Subscription_Sub_Type,
      Service_Instance_ID,
      Subscription_ID,
      Current_Product_sk,
      Product_Holding,
      Country,
      Created_By_ID,
      Prev_Status_Code,
      Status_Code,
      Enter_SysCan,
      Enter_CusCan,
      Enter_HM,
      Enter_3rd_Party,
      null as PC_Effective_To_Dt,
      null as PC_Future_Sub_Effective_Dt,
      null as PC_Next_Status_Code,
      null as AB_Effective_To_Dt,
      null as AB_Future_Sub_Effective_Dt,
      null as AB_Next_Status_Code,
      null as BCRQ_Effective_To_Dt,
      null as BCRQ_Future_Sub_Effective_Dt,
      null as BCRQ_Next_Status_Code,
      null as BB_Cust_Type,
      null as ProdPlat_Churn_Type
      from #BB_PL_Subs;
  
  update CITeam.PL_Entries_BB_beta as BCP
    set subs_year = sc.subs_year,
    subs_quarter_of_year = sc.subs_quarter_of_year,
    subs_week_of_year = sc.subs_week_of_year,
    subs_week_and_year = cast(sc.subs_week_and_year as integer) from
    sky_calendar as sc
    where bcp.subs_year is null
    and sc.calendar_date = bcp.event_dt;
  
  update CITeam.PL_Entries_BB_beta as BCP
    set BB_Cust_Type = case when SODDTV.STATUS_CODE in( 'AC','AB','PC' ) then 'Triple Play'
    else 'SABB'
    end from
    CITeam.PL_Entries_BB_beta as BCP
    left outer join cust_subs_hist as SODDTV
    on BCP.account_number = SODDTV.account_number
    and BCP.Event_Dt between SODDTV.EFFECTIVE_FROM_DT+1 and SODDTV.EFFECTIVE_TO_DT
    -- and SODDTV.SUBSCRIPTION_SUB_TYPE = 'DTV Primary Viewing'
	and SODDTV.SUBSCRIPTION_SUB_TYPE in('DTV Primary Viewing','DTV Sky+')
    and SODDTV.STATUS_CODE in( 'AC','PC','AB' ) 
    where BCP.BB_Cust_Type is null;
  
  /*
  update CITeam.PL_Entries_BB_beta as BCP
    set ProdPlat_Churn_Type = case when SODDTV.STATUS_CODE in( 'AC','PC' ) 
    and EODDTV.STATUS_CODE in( 'PC','PO' ) then 'Platform'
    else 'Product'
    end from
    CITeam.PL_Entries_BB_beta as BCP
    left outer join cust_subs_hist as SODDTV
    on BCP.account_number = SODDTV.account_number
    and BCP.Event_Dt between SODDTV.EFFECTIVE_FROM_DT+1 and SODDTV.EFFECTIVE_TO_DT
    and SODDTV.SUBSCRIPTION_SUB_TYPE = 'DTV Primary Viewing'
    and SODDTV.STATUS_CODE in( 'AC','PC','AB' ) 
    left outer join cust_subs_hist as EODDTV
    on BCP.account_number = EODDTV.account_number
    and BCP.Event_Dt between EODDTV.EFFECTIVE_FROM_DT and EODDTV.EFFECTIVE_TO_DT-1
    and EODDTV.SUBSCRIPTION_SUB_TYPE = 'DTV Primary Viewing'
    and EODDTV.STATUS_CODE in( 'AC','PC','AB','PO','SC' ) 
    where BCP.ProdPlat_Churn_Type is null
    and(Enter_CusCan > 0 or Enter_3rd_Party > 0);
  */
  
  update CITeam.PL_Entries_BB_beta as BCP
    set ProdPlat_Churn_Type = case when csh.account_number is not null then 'Platform'
    else 'Product'
    end from
    CITeam.PL_Entries_BB_beta as BCP
    left outer join cust_subs_hist as csh
    on BCP.account_number = csh.account_number
    and BCP.Event_Dt between csh.EFFECTIVE_FROM_DT+1 and csh.EFFECTIVE_TO_DT
    and csh.SUBSCRIPTION_SUB_TYPE = 'DTV Primary Viewing'
	and csh.STATUS_CODE_CHANGED = 'Y'
    and csh.STATUS_CODE in('PC')
	and csh.PREV_STATUS_CODE in ('AB','AC','PC');
  
  drop table if exists #PC_Future_Effective_Dt;
  select MoR.account_number,MoR.event_dt,
    csh.status_end_dt as status_end_dt,
    csh.future_sub_effective_dt,
    csh.effective_from_datetime,
    csh.effective_to_datetime,
    row_number() over(partition by MoR.account_number,MoR.event_dt order by csh.effective_from_datetime desc) as PC_Rnk
    into #PC_Future_Effective_Dt
    from CITeam.PL_Entries_BB_beta as MoR
      join cust_subs_hist as csh
      on csh.account_number = MoR.account_number
      and csh.status_start_dt = MoR.Event_dt
      and csh.status_end_dt >= Refresh_dt
      and csh.subscription_sub_type = 'Broadband DSL Line'
      and csh.OWNING_CUST_ACCOUNT_ID > '1'
      and csh.STATUS_CODE_CHANGED = 'Y'
      and csh.status_code = 'PC'
    where(MoR.PC_Effective_To_Dt is null or MoR.PC_Future_Sub_Effective_Dt is null);
  
  commit work;
  create hg index idx_1 on #PC_Future_Effective_Dt(account_number);
  create date index idx_2 on #PC_Future_Effective_Dt(event_dt);
  create lf index idx_3 on #PC_Future_Effective_Dt(PC_Rnk);
  delete from #PC_Future_Effective_Dt where PC_Rnk > 1;
  commit work;
  
  update CITeam.PL_Entries_BB_beta as MoR
    set MoR.PC_Future_Sub_Effective_Dt = PC.future_sub_effective_dt from
    CITeam.PL_Entries_BB_beta as MoR
    join #PC_Future_Effective_Dt as PC
    on PC.account_number = MoR.account_number
    and pc.event_dt = MoR.event_dt
    where MoR.Status_Code = 'PC';
  
  drop table if exists #BCRQ_Future_Effective_Dt;
  select MoR.account_number,MoR.event_dt,
    csh.status_end_dt as status_end_dt,
    csh.future_sub_effective_dt,
    csh.effective_from_datetime,
    csh.effective_to_datetime,
    row_number() over(partition by MoR.account_number,MoR.event_dt order by csh.effective_from_datetime desc) as PC_Rnk
    into #BCRQ_Future_Effective_Dt
    from CITeam.PL_Entries_BB_beta as MoR
      join cust_subs_hist as csh
      on csh.account_number = MoR.account_number
      and csh.status_start_dt = MoR.Event_dt
      and csh.status_end_dt >= Refresh_dt
      and csh.subscription_sub_type = 'Broadband DSL Line'
      and csh.OWNING_CUST_ACCOUNT_ID > '1'
      and csh.STATUS_CODE_CHANGED = 'Y'
      and csh.status_code = 'BCRQ'
    where(MoR.BCRQ_Effective_To_Dt is null or MoR.BCRQ_Future_Sub_Effective_Dt is null);
  
  commit work;
  create hg index idx_1 on #BCRQ_Future_Effective_Dt(account_number);
  create date index idx_2 on #BCRQ_Future_Effective_Dt(event_dt);
  create lf index idx_3 on #BCRQ_Future_Effective_Dt(PC_Rnk);
  delete from #BCRQ_Future_Effective_Dt where PC_Rnk > 1;
  commit work;
  
  update CITeam.PL_Entries_BB_beta as MoR
    set MoR.BCRQ_Future_Sub_Effective_Dt = BCRQ.future_sub_effective_dt from
    CITeam.PL_Entries_BB_beta as MoR
    join #BCRQ_Future_Effective_Dt as BCRQ
    on BCRQ.account_number = MoR.account_number
    and BCRQ.event_dt = MoR.event_dt
    where MoR.Status_Code = 'BCRQ';
  
  update CITeam.PL_Entries_BB_beta as MoR
    set MoR.AB_Future_Sub_Effective_Dt = cast(event_dt+50 as date)
    where STATUS_CODE = 'AB'
    and(AB_Future_Sub_Effective_Dt is null);
  
  select MoR.account_number,
    MoR.event_dt,
    CSH.status_start_dt as PC_Effective_To_dt,
    csh.status_code as Next_Status_Code,
    Row_number() over(partition by MoR.account_number,MoR.event_dt order by status_start_dt desc) as Status_change_rnk
    into #PC_Status_Change
    from CITeam.PL_Entries_BB_beta as MoR
      join cust_subs_hist as CSH
      on CSH.account_number = MoR.account_number
      and CSH.prev_status_start_dt = MoR.event_dt
      and csh.subscription_sub_type = 'Broadband DSL Line'
    where csh.status_start_dt >= MoR.event_dt
    and csh.status_end_dt >= Refresh_dt
    and CSH.prev_status_code = 'PC' and CSH.status_code <> 'PC' and status_code_changed = 'Y'
    and MoR.status_code = 'PC';
  
  update CITeam.PL_Entries_BB_beta as MoR
    set PC_Effective_To_Dt = CSH.PC_Effective_To_dt,
    PC_Next_Status_Code = CSH.Next_Status_Code from
    CITeam.PL_Entries_BB_beta as MoR
    join #PC_Status_Change as CSH
    on CSH.account_number = MoR.account_number
    and CSH.event_dt = MoR.event_dt
    where Status_change_rnk = 1
    and MoR.status_code = 'PC';
  
  commit work;
  
  select MoR.account_number,
    MoR.event_dt,
    CSH.status_start_dt as AB_Effective_To_dt,
    csh.status_code as Next_Status_Code,
    Row_number() over(partition by MoR.account_number,MoR.event_dt order by status_start_dt desc) as Status_change_rnk
    into #AB_Status_Change
    from CITeam.PL_Entries_BB_beta as MoR
      join cust_subs_hist as CSH
      on CSH.account_number = MoR.account_number
      and CSH.prev_status_start_dt = MoR.event_dt
      and csh.subscription_sub_type = 'Broadband DSL Line'
    where csh.status_start_dt >= MoR.event_dt
    and csh.status_end_dt >= Refresh_dt
    and CSH.prev_status_code = 'AB' and CSH.status_code <> 'AB' and status_code_changed = 'Y'
    and MoR.status_code = 'AB';
  
  update CITeam.PL_Entries_BB_beta as MoR
    set AB_Effective_To_Dt = CSH.AB_Effective_To_dt,
    AB_Next_Status_Code = CSH.Next_Status_Code from
    CITeam.PL_Entries_BB_beta as MoR
    join #AB_Status_Change as CSH
    on CSH.account_number = MoR.account_number
    and CSH.event_dt = MoR.event_dt
    where Status_change_rnk = 1
    and MoR.status_code = 'AB';
  
  commit work;
  
  select MoR.account_number,
    MoR.event_dt,
    CSH.status_start_dt as AB_Effective_To_dt,
    csh.status_code as Next_Status_Code,
    Row_number() over(partition by MoR.account_number,MoR.event_dt order by status_start_dt desc) as Status_change_rnk
    into #BCRQ_Status_Change
    from CITeam.PL_Entries_BB_beta as MoR
      join cust_subs_hist as CSH
      on CSH.account_number = MoR.account_number
      and CSH.prev_status_start_dt = MoR.event_dt
      and csh.subscription_sub_type = 'Broadband DSL Line'
    where csh.status_start_dt >= MoR.event_dt
    and csh.status_end_dt >= Refresh_dt
    and CSH.prev_status_code = 'BCRQ' and CSH.status_code <> 'BCRQ' and status_code_changed = 'Y'
    and MoR.status_code = 'BCRQ';
  
  update CITeam.PL_Entries_BB_beta as MoR
    set BCRQ_Effective_To_Dt = CSH.AB_Effective_To_dt,
    BCRQ_Next_Status_Code = CSH.Next_Status_Code from
    CITeam.PL_Entries_BB_beta as MoR
    join #BCRQ_Status_Change as CSH
    on CSH.account_number = MoR.account_number
    and CSH.event_dt = MoR.event_dt
    where Status_change_rnk = 1
    and MoR.status_code = 'BCRQ';
  
  commit work

end
GO
Grant execute on vha02.Update_Decisioning_PL_Entries_BB to public;


/*
drop table if exists #test;
select account_number,effective_from_dt,effective_to_dt,status_code,current_product_description,count(*) as number_of
into #test
from cust_subs_hist
where 
SUBSCRIPTION_SUB_TYPE = 'Broadband DSL Line'
and Status_Code in( 'AB','PC','BCRQ' ) 
and STATUS_CODE_CHANGED = 'Y'
and effective_from_dt between '2019-04-15' and '2019-04-16'
group by account_number,effective_from_dt,effective_to_dt,status_code,current_product_description




*/