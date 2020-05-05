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
|| 'ProdPlat_Churn_Type varchar(10) default null, '
|| 'Last_Modified_Dt date default null '

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

-- Setuser decisioning_procs
Call Decisioning_Procs.Update_Decisioning_PL_Entries_BB()

Drop Procedure If Exists Decisioning_Procs.Update_Decisioning_PL_Entries_BB;
create Procedure Decisioning_Procs.Update_Decisioning_PL_Entries_BB(Refresh_Dt date default null)
SQL SECURITY INVOKER
BEGIN
SET TEMPORARY OPTION Query_Temp_Space_Limit = 0; commit;


If Refresh_Dt is null then
BEGIN
Set Refresh_Dt = (Select Max(Event_Dt) - 6*7 from Decisioning.PL_Entries_BB);
END;
End If;



-- insert into
--delete from
-- Decisioning.PL_Entries_BB
select
null as Subs_Year ,  --as Subs_Year
null as Subs_Quarter_of_year ,
null as subs_week_of_year , --as Subs_Week_Of_Year
null as Subs_week_and_year  , --as Subs_Week_And_Year
CASE WHEN  WH_ADDRESS_ROLE.AD_CREATED_DT IS NULL THEN 'No Homemove' ELSE 'Homemove' end HM_FLAG,
cast(WH_PH_SUBS_HIST.EFFECTIVE_FROM_DT as date) as Event_Dt, -- [Status Start Date] --
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
CASE WHEN WH_PH_SUBS_HIST.Current_Product_sk = 43373 THEN 'Sky Broadband Unlimited (Legacy)' ELSE WH_PH_SUBS_HIST.Current_Product_Description END as BB_Product_Description,
CASE WHEN BB_Product_Description='Broadband Connect' Then 'Connect'
     WHEN BB_Product_Description In ('?','Other','Missing at load') Then 'Other'
     WHEN BB_Product_Description like 'Sky Broadband Lite%' Then Substr(BB_Product_Description,1,200)
     WHEN BB_Product_Description like 'Sky Broadband %' Then Substr(BB_Product_Description,15,200)
     WHEN BB_Product_Description='Sky Fibre Unlimited Pro' Then 'Fibre Unlimited Pro'
     WHEN BB_Product_Description like 'Sky Fibre %' Then Substr(BB_Product_Description,5,200)
     WHEN BB_Product_Description like 'Sky Connect %' Then Substr(BB_Product_Description,5,200)
     Else BB_Product_Description
End as Product_Holding,
CASE WHEN WH_PH_SUBS_HIST.currency_code='GBP' THEN 'UK'
     WHEN WH_PH_SUBS_HIST.currency_code='EUR' THEN 'ROI'
     ELSE 'Other' END as Country,
WH_PH_SUBS_HIST.created_by_id,
WH_PH_SUBS_HIST.prev_status_code,
WH_PH_SUBS_HIST.status_code,
Case when (
        (       WH_PH_SUBS_HIST.STATUS_CODE  IN  (  'AB','PC' ) AND WH_PH_SUBS_HIST.PREV_STATUS_CODE IN  ( 'AC','AB','PC' ) )
        OR
        (       WH_PH_SUBS_HIST.STATUS_CODE  = 'AB' AND WH_PH_SUBS_HIST.PREV_STATUS_CODE = 'CF')
        OR
        (       WH_PH_SUBS_HIST.STATUS_CODE  = 'PC' AND WH_PH_SUBS_HIST.PREV_STATUS_CODE = 'PT')

--*********************************************************************************************************************************************************************************
--ADDED FOR TAY CHANGES - MICK PARSLEY 26-06-2013
--*********************************************************************************************************************************************************************************
        OR
        (       WH_PH_SUBS_HIST.STATUS_CODE  = 'BCRQ' AND WH_PH_SUBS_HIST.PREV_STATUS_CODE IN ('AB','PT') AND WH_PH_SUBS_HIST.STATUS_REASON_CODE IN ('900','84'))
        OR
        (       WH_PH_SUBS_HIST.STATUS_CODE  = 'BCRQ' AND WH_PH_SUBS_HIST.PREV_STATUS_CODE IN ('PC','CF') AND WH_PH_SUBS_HIST.STATUS_REASON_CODE IN ('79','80'))
        OR
--Return from BCRQ to a different funnel from start excluding those that switched at point of entry to BCRQ
        (
            PREVPH.PREV_STATUS_CODE = 'AB' AND
            WH_PH_SUBS_HIST.PREV_STATUS_CODE = 'BCRQ'
            AND PREVPH.STATUS_REASON_CODE NOT IN ('900','84')
            AND WH_PH_SUBS_HIST.STATUS_CODE = 'PC'
        )
        OR
        (
            PREVPH.PREV_STATUS_CODE = 'PC' AND
            WH_PH_SUBS_HIST.PREV_STATUS_CODE = 'BCRQ'
            AND PREVPH.STATUS_REASON_CODE NOT IN ('79','80')
            AND WH_PH_SUBS_HIST.STATUS_CODE = 'AB')
        )
        Then 'Yes'  else 'No' end IN_Report_Where,

-- CASE
-- WHEN WH_PH_SUBS_HIST.STATUS_REASON_CODE = '900' THEN '1 = 3rd Party'
-- WHEN WH_PH_SUBS_HIST.STATUS_CODE = 'AB' THEN '2 = SysCan'
-- WHEN WH_PH_SUBS_HIST.STATUS_CODE = 'PC'
--         THEN '3 = CusCan'
-- WHEN WH_PH_SUBS_HIST.STATUS_CODE = 'BCRQ' AND WH_PH_SUBS_HIST.PREV_STATUS_CODE IN ('AB','PT') THEN '3 = CusCan'
-- WHEN WH_PH_SUBS_HIST.STATUS_CODE = 'BCRQ' AND WH_PH_SUBS_HIST.PREV_STATUS_CODE IN ('PC','CF') THEN '2 = SysCan'
-- Else 'Check'
-- END TPSYCU -- Dummy Number 2
-- ,
CASE
WHEN WH_PH_SUBS_HIST.STATUS_REASON_CODE = '900' THEN '1 = 3rd Party'
WHEN WH_PH_SUBS_HIST.STATUS_CODE = 'AB' THEN '2 = SysCan'
WHEN WH_PH_SUBS_HIST.STATUS_CODE = 'PC' THEN '3 = CusCan'
WHEN WH_PH_SUBS_HIST.STATUS_CODE = 'BCRQ' AND WH_PH_SUBS_HIST.PREV_STATUS_CODE IN ('AB','PT')
        AND WH_PH_SUBS_HIST.STATUS_REASON_CODE IN ('900','84')
        THEN '3 = CusCan'
WHEN WH_PH_SUBS_HIST.STATUS_CODE = 'BCRQ' AND WH_PH_SUBS_HIST.PREV_STATUS_CODE IN ('PC','CF') THEN '2 = SysCan'
Else 'Check'
END TPSYCU -- Dummy Number 2
,
CASE WHEN IN_Report_Where = 'Yes' and  TPSYCU = '2 = SysCan' THEN 1 ELSE 0 END AS Enter_SysCan,
CASE WHEN IN_Report_Where = 'Yes' and  TPSYCU in ('1 = 3rd Party','3 = CusCan') and HM_FLAG = 'No Homemove' and TPSYCU != '1 = 3rd Party' then 1 else 0 end as Enter_CusCan,
CASE WHEN IN_Report_Where = 'Yes' and HM_FLAG = 'Homemove' THEN 1 ELSE 0 END AS Enter_HM,
CASE WHEN IN_Report_Where = 'Yes' and TPSYCU = '1 = 3rd Party' and HM_FLAG = 'No Homemove' THEN 1 ELSE 0 END AS Enter_3rd_Party--, --
into #BB_PL_Subs
FROM
--We get Funnel Entry from here
Cust_Subs_Hist WH_PH_SUBS_HIST
LEFT OUTER JOIN
CUST_ALL_ADDRESS WH_ADDRESS_ROLE
ON    WH_PH_SUBS_HIST.OWNING_CUST_ACCOUNT_ID = WH_ADDRESS_ROLE.CUST_ACCOUNT_ID
                AND
                cast(WH_PH_SUBS_HIST.EFFECTIVE_FROM_DT as date)= CAST(WH_ADDRESS_ROLE.AD_CREATED_DT as date)
                AND
                WH_ADDRESS_ROLE.CHANGE_REASON_CODE in ('MHWITHINST','MHNOINST' )
--/*
LEFT OUTER JOIN
Cust_Subs_Hist PREVPH
 ON (WH_PH_SUBS_HIST.SUBSCRIPTION_ID = PREVPH.SUBSCRIPTION_ID AND
         WH_PH_SUBS_HIST.STATUS_START_DT = PREVPH.STATUS_END_DT AND
         WH_PH_SUBS_HIST.STATUS_START_DT > PREVPH.STATUS_START_DT AND
         PREVPH.STATUS_CODE_CHANGED  =  'Y' AND
         WH_PH_SUBS_HIST.PREV_STATUS_CODE = PREVPH.STATUS_CODE AND
         PREVPH.SUBSCRIPTION_SUB_TYPE = 'Broadband DSL Line' AND
         WH_PH_SUBS_HIST.SUBSCRIPTION_SUB_TYPE = 'Broadband DSL Line'AND
         cast(WH_PH_SUBS_HIST.FIRST_ACTIVATION_DT as date) < '9999-01-01' )
--*/
-- INNER JOIN Sky_Calendar Cal
-- on WH_PH_SUBS_HIST.EFFECTIVE_FROM_DT =Cal.Calendar_date

where
WH_PH_SUBS_HIST.EFFECTIVE_FROM_DT >= Refresh_Dt --is not null and
and WH_PH_SUBS_HIST.SUBSCRIPTION_SUB_TYPE = 'Broadband DSL Line'
and
cast(WH_PH_SUBS_HIST.FIRST_ACTIVATION_DT as date) < '9999-01-01'
AND WH_PH_SUBS_HIST.Status_Code in ('AB','PC','BCRQ')
-- AND
-- (
--         (       WH_PH_SUBS_HIST.STATUS_CODE  IN  (  'AB','PC' ) AND WH_PH_SUBS_HIST.PREV_STATUS_CODE IN  ( 'AC','AB','PC' ) )
--         OR
--         (       WH_PH_SUBS_HIST.STATUS_CODE  = 'AB' AND WH_PH_SUBS_HIST.PREV_STATUS_CODE = 'CF')
--         OR
--         (       WH_PH_SUBS_HIST.STATUS_CODE  = 'PC' AND WH_PH_SUBS_HIST.PREV_STATUS_CODE = 'PT')
--
-- --*********************************************************************************************************************************************************************************
-- --ADDED FOR TAY CHANGES - MICK PARSLEY 26-06-2013
-- --*********************************************************************************************************************************************************************************
--         OR
--         (       WH_PH_SUBS_HIST.STATUS_CODE  = 'BCRQ' AND WH_PH_SUBS_HIST.PREV_STATUS_CODE IN ('AB','PT') AND WH_PH_SUBS_HIST.STATUS_REASON_CODE IN ('900','84'))
--         OR
--         (       WH_PH_SUBS_HIST.STATUS_CODE  = 'BCRQ' AND WH_PH_SUBS_HIST.PREV_STATUS_CODE IN ('PC','CF') AND WH_PH_SUBS_HIST.STATUS_REASON_CODE IN ('79','80'))
--         OR
-- --Return from BCRQ to a different funnel from start excluding those that switched at point of entry to BCRQ
--         (
--             PREVPH.PREV_STATUS_CODE = 'AB' AND
--             WH_PH_SUBS_HIST.PREV_STATUS_CODE = 'BCRQ'
--             AND PREVPH.STATUS_REASON_CODE NOT IN ('900','84')
--             AND WH_PH_SUBS_HIST.STATUS_CODE = 'PC'
--         )
--         OR
--         (
--             PREVPH.PREV_STATUS_CODE = 'PC' AND
--             WH_PH_SUBS_HIST.PREV_STATUS_CODE = 'BCRQ'
--             AND PREVPH.STATUS_REASON_CODE NOT IN ('79','80')
--             AND WH_PH_SUBS_HIST.STATUS_CODE = 'AB')
--         )
--*********************************************************************************************************************************************************************************
--*********************************************************************************************************************************************************************************
AND
WH_PH_SUBS_HIST.STATUS_CODE_CHANGED  =  'Y'
AND
--The hard coded date here is to restrict the amount of data being held in memory when using derived dates and must be set to a date before the earliest date to be reported
--if needed, restriction can be removed
WH_PH_SUBS_HIST.EFFECTIVE_TO_DT >= '2012-06-01 00:00:00';

commit;

delete from Decisioning.PL_Entries_BB where event_dt >= Refresh_Dt;

Insert into Decisioning.PL_Entries_BB
Select
null as Subs_Year,
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
null as ProdPlat_Churn_Type,
today() as Last_Modified_Dt
from #BB_PL_Subs;



Update Decisioning.PL_Entries_BB BCP
Set subs_year = sc.subs_year,
    subs_quarter_of_year = sc.subs_quarter_of_year,
    subs_week_of_year = sc.subs_week_of_year,
    subs_week_and_year = Cast(sc.subs_week_and_year as integer)
from sky_calendar sc
where bcp.subs_year is null
        and sc.calendar_date = bcp.event_dt;












--------------------------------------------------------------------------------------
------------------- Add SABB/TP and Prod/Plat PL Entry Flags -------------------------
--------------------------------------------------------------------------------------
Update Decisioning.PL_Entries_BB BCP
Set BB_Cust_Type = Case when SODDTV.STATUS_CODE in ('AC','AB','PC') then 'Triple Play'
                        else 'SABB'
                   end
from Decisioning.PL_Entries_BB BCP
     LEFT OUTER JOIN
     cust_subs_hist SODDTV
     ON BCP.account_number = SODDTV.account_number
        AND BCP.Event_Dt between SODDTV.EFFECTIVE_FROM_DT + 1 and SODDTV.EFFECTIVE_TO_DT
        and SODDTV.SUBSCRIPTION_SUB_TYPE = 'DTV Primary Viewing'
                and SODDTV.STATUS_CODE IN ('AC','PC','AB')
where BCP.BB_Cust_Type is null;



Update Decisioning.PL_Entries_BB BCP
Set ProdPlat_Churn_Type = Case when SODDTV.STATUS_CODE in ('AC','PC')
                                    and EODDTV.STATUS_CODE in ('PC','PO')then 'Platform'
                                    else 'Product'
                          end
from Decisioning.PL_Entries_BB BCP
     LEFT OUTER JOIN 
     cust_subs_hist SODDTV
     ON BCP.account_number = SODDTV.account_number
        AND BCP.Event_Dt between SODDTV.EFFECTIVE_FROM_DT + 1 and SODDTV.EFFECTIVE_TO_DT
        and SODDTV.SUBSCRIPTION_SUB_TYPE = 'DTV Primary Viewing'
                and SODDTV.STATUS_CODE IN ('AC','PC','AB')
         LEFT OUTER JOIN
     cust_subs_hist EODDTV
     ON BCP.account_number = EODDTV.account_number
        AND BCP.Event_Dt between EODDTV.EFFECTIVE_FROM_DT and EODDTV.EFFECTIVE_TO_DT - 1
        and EODDTV.SUBSCRIPTION_SUB_TYPE = 'DTV Primary Viewing'
                and EODDTV.STATUS_CODE IN ('AC','PC','AB','PO','SC')
where BCP.ProdPlat_Churn_Type is null
      and (Enter_CusCan > 0 or Enter_3rd_Party > 0);











--------------------------------------------------------------------------------------
------------------------- Add Future Subs Effective Dt -------------------------------
--------------------------------------------------------------------------------------

--add PC_Future_Effective_Dt
Drop table if exists #PC_Future_Effective_Dt;

Select MoR.account_number,MoR.event_dt,
        csh.status_end_dt status_end_dt,
        csh.future_sub_effective_dt,
        csh.effective_from_datetime,
        csh.effective_to_datetime,
        row_number() over(partition by MoR.account_number,MoR.event_dt order by csh.effective_from_datetime desc) PC_Rnk
into #PC_Future_Effective_Dt
from Decisioning.PL_Entries_BB MoR
     inner join
     cust_subs_hist csh
     on csh.account_number = MoR.account_number
        and csh.status_start_dt = MoR.Event_dt
        and csh.status_end_dt >= Refresh_dt
        and csh.subscription_sub_type = 'Broadband DSL Line'
--OC: is the constraint OWNING_CUST_ACCOUNT_ID  >  '1' in following line required in the next statements?
        and csh.OWNING_CUST_ACCOUNT_ID  >  '1'
        and csh.STATUS_CODE_CHANGED  =  'Y'
        and csh.status_code  = 'PC'
where
--Same_Day_Cancels > 0 or PC_Pending_Cancellations > 0 or Same_Day_PC_Reactivations > 0
    (MoR.PC_Effective_To_Dt is null or MoR.PC_Future_Sub_Effective_Dt is null)
;

commit;
create hg index idx_1 on #PC_Future_Effective_Dt(account_number);
create date index idx_2 on #PC_Future_Effective_Dt(event_dt);
create lf index idx_3 on #PC_Future_Effective_Dt(PC_Rnk);

Delete from #PC_Future_Effective_Dt where PC_Rnk > 1;

commit;

Update Decisioning.PL_Entries_BB MoR
Set MoR.PC_Future_Sub_Effective_Dt = PC.future_sub_effective_dt
from Decisioning.PL_Entries_BB MoR
     inner join
     #PC_Future_Effective_Dt PC
     on PC.account_number = MoR.account_number
        and pc.event_dt = MoR.event_dt
where MoR.Status_Code = 'PC';







--add BCRQ_Future_Effective_Dt
Drop table if exists #BCRQ_Future_Effective_Dt;

Select MoR.account_number,MoR.event_dt,
        csh.status_end_dt status_end_dt,
        csh.future_sub_effective_dt,
        csh.effective_from_datetime,
        csh.effective_to_datetime,
        row_number() over(partition by MoR.account_number,MoR.event_dt order by csh.effective_from_datetime desc) PC_Rnk
into #BCRQ_Future_Effective_Dt
from Decisioning.PL_Entries_BB MoR
     inner join
     cust_subs_hist csh
     on csh.account_number = MoR.account_number
        and csh.status_start_dt = MoR.Event_dt
        and csh.status_end_dt >= Refresh_dt
        and csh.subscription_sub_type = 'Broadband DSL Line'
--OC: is the constraint OWNING_CUST_ACCOUNT_ID  >  '1' in following line required in the next statements?
        and csh.OWNING_CUST_ACCOUNT_ID  >  '1'
        and csh.STATUS_CODE_CHANGED  =  'Y'
        and csh.status_code  = 'BCRQ'
where
--Same_Day_Cancels > 0 or PC_Pending_Cancellations > 0 or Same_Day_PC_Reactivations > 0
    (MoR.BCRQ_Effective_To_Dt is null or MoR.BCRQ_Future_Sub_Effective_Dt is null)
;

commit;
create hg index idx_1 on #BCRQ_Future_Effective_Dt(account_number);
create date index idx_2 on #BCRQ_Future_Effective_Dt(event_dt);
create lf index idx_3 on #BCRQ_Future_Effective_Dt(PC_Rnk);

Delete from #BCRQ_Future_Effective_Dt where PC_Rnk > 1;

commit;

Update Decisioning.PL_Entries_BB MoR
Set MoR.BCRQ_Future_Sub_Effective_Dt = BCRQ.future_sub_effective_dt
from Decisioning.PL_Entries_BB MoR
     inner join
     #BCRQ_Future_Effective_Dt BCRQ
     on BCRQ.account_number = MoR.account_number
        and BCRQ.event_dt = MoR.event_dt
where MoR.Status_Code = 'BCRQ';

--add AB_Future_Sub_Effective_Dt
Update Decisioning.PL_Entries_BB MoR
--OC: can we confirm +50 is correct also in the case of BB?
Set MoR.AB_Future_Sub_Effective_Dt = Cast(event_dt + 50 as date)
where STATUS_CODE = 'AB' and
(AB_Future_Sub_Effective_Dt is null);



--------------------------------------------------------------------------------------
--------------------------- Add PC Effective To Dt -----------------------------------
--------------------------------------------------------------------------------------
Select MoR.account_number,
       MoR.event_dt,
       CSH.status_start_dt PC_Effective_To_dt,
       csh.status_code Next_Status_Code,
       Row_number() over(partition by MoR.account_number,MoR.event_dt order by status_start_dt desc) Status_change_rnk
into #PC_Status_Change
from Decisioning.PL_Entries_BB MoR
    inner join
    cust_subs_hist CSH
    on CSH.account_number = MoR.account_number
       and CSH.prev_status_start_dt = MoR.event_dt
       and csh.subscription_sub_type = 'Broadband DSL Line'
where csh.status_start_dt >= MoR.event_dt
       and csh.status_end_dt >= Refresh_dt
       and CSH.prev_status_code = 'PC' and CSH.status_code != 'PC' and status_code_changed = 'Y'
       and MoR.status_code = 'PC'
--       and (Same_Day_Cancels > 0 or PC_Pending_Cancellations > 0 or Same_Day_PC_Reactivations > 0)
;


Update Decisioning.PL_Entries_BB
Set PC_Effective_To_Dt = CSH.PC_Effective_To_dt,
    PC_Next_Status_Code = CSH.Next_Status_Code
from Decisioning.PL_Entries_BB MoR
     inner join
     #PC_Status_Change CSH
     on CSH.account_number = MoR.account_number
        and CSH.event_dt = MoR.event_dt
where Status_change_rnk = 1
       and MoR.status_code = 'PC';


commit;


--------------------------------------------------------------------------------------
--------------------------- Add AB Effective To Dt -----------------------------------
--------------------------------------------------------------------------------------
Select MoR.account_number,
       MoR.event_dt,
       CSH.status_start_dt AB_Effective_To_dt,
       csh.status_code Next_Status_Code,
       Row_number() over(partition by MoR.account_number,MoR.event_dt order by status_start_dt desc) Status_change_rnk
into #AB_Status_Change
from Decisioning.PL_Entries_BB MoR
     inner join
     cust_subs_hist CSH
     on CSH.account_number = MoR.account_number
       and CSH.prev_status_start_dt = MoR.event_dt
       and csh.subscription_sub_type = 'Broadband DSL Line'
where csh.status_start_dt >= MoR.event_dt
       and csh.status_end_dt >= Refresh_dt
       and CSH.prev_status_code = 'AB' and CSH.status_code != 'AB' and status_code_changed = 'Y'
       and MoR.status_code = 'AB'
       ;


Update Decisioning.PL_Entries_BB
Set AB_Effective_To_Dt = CSH.AB_Effective_To_dt,
    AB_Next_Status_Code = CSH.Next_Status_Code
from Decisioning.PL_Entries_BB MoR
     inner join
     #AB_Status_Change CSH
     on CSH.account_number = MoR.account_number
        and CSH.event_dt = MoR.event_dt
where Status_change_rnk = 1
       and MoR.status_code = 'AB'
;


commit;


--------------------------------------------------------------------------------------
--------------------------- Add BCRQ Effective To Dt -----------------------------------
--------------------------------------------------------------------------------------
Select MoR.account_number,
       MoR.event_dt,
       CSH.status_start_dt AB_Effective_To_dt,
       csh.status_code Next_Status_Code,
       Row_number() over(partition by MoR.account_number,MoR.event_dt order by status_start_dt desc) Status_change_rnk
into #BCRQ_Status_Change
from Decisioning.PL_Entries_BB MoR
     inner join
     cust_subs_hist CSH
     on CSH.account_number = MoR.account_number
       and CSH.prev_status_start_dt = MoR.event_dt
       and csh.subscription_sub_type = 'Broadband DSL Line'
where csh.status_start_dt >= MoR.event_dt
       and csh.status_end_dt >= Refresh_dt
       and CSH.prev_status_code = 'BCRQ' and CSH.status_code != 'BCRQ' and status_code_changed = 'Y'
       and MoR.status_code = 'BCRQ'
       ;


Update Decisioning.PL_Entries_BB
Set BCRQ_Effective_To_Dt = CSH.AB_Effective_To_dt,
    BCRQ_Next_Status_Code = CSH.Next_Status_Code
from Decisioning.PL_Entries_BB MoR
     inner join
     #BCRQ_Status_Change CSH
     on CSH.account_number = MoR.account_number
        and CSH.event_dt = MoR.event_dt
where Status_change_rnk = 1
       and MoR.status_code = 'BCRQ'
;

commit;




End;

Grant execute on Decisioning_Procs.Update_Decisioning_PL_Entries_BB to Decisioning;


/*

Select top 1000 * from Decisioning.PL_Entries_BB where status_code = 'BCRQ';

Select subs_week_and_year
,sum(Enter_SysCan)
,sum(Enter_CusCan)
,sum(Enter_HM)
,sum(Enter_3rd_Party)
from Decisioning.PL_Entries_BB
group by subs_week_and_year

*/
