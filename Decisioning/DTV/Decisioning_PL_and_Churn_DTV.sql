/*------------------------------------------------------------------------------*/
/*                     DTV Pipeline Reactivations & Churn                       */
/*                                                                              */
/*            Reconciled to Churn Figures with ROI _IncOver12mnth               */
/*                         a.k.a. Master Of Retention                           */
/*                                                                              */
/*------------------------------------------------------------------------------*/

/*
dba.sp_drop_table 'Decisioning','PL_Entries_DTV'
dba.sp_create_table 'Decisioning','PL_Entries_DTV',
   'Subs_Year integer default null, '
|| 'Subs_Quarter_Of_Year tinyint default null, '
|| 'Subs_Week_Of_Year integer default null, '
|| 'Subs_Week_And_Year integer default null, '
|| 'Event_Dt date default null, '

|| 'Account_Number varchar(20) default null, '
|| 'Owning_Cust_Account_ID varchar(50) default null, '
|| 'Account_Type varchar(255) default null, '
|| 'Account_Sub_Type  varchar(255) default null, '
|| 'cb_Key_Household bigint default null, '
|| 'Created_By_ID varchar(50) default null, '
|| 'Current_Product_sk integer default null, '
|| 'Ent_Cat_Prod_sk integer default null, '
|| 'First_Order_ID varchar(50) default null, '
|| 'Order_ID varchar(50) default null, '
|| 'Order_Line_ID varchar(50) default null, '
|| 'PH_Subs_Hist_sk decimal(22,0) default null, '
|| 'Service_Instance_ID varchar(50) default null, '
|| 'Subscription_ID varchar(50) default null, '
|| 'Country varchar(3) default null, '
|| 'Product_Holding varchar(80) default null, '

|| 'PC_To_AB smallint default 0,'
|| 'AB_Pending_Termination smallint default 0,'
|| 'Gross_PC_Pending_Cancellation smallint default 0,'
|| 'PC_Pipeline_Cancellation smallint default 0,'
|| 'Same_Day_Cancel smallint default 0,'
|| 'Same_Day_PC_Reactivation smallint default 0,'
|| 'Same_Day_AB_Reactivation smallint default 0,'
|| 'PC_Reactivation smallint default 0,'
|| 'AB_Reactivation smallint default 0,'

|| 'PC_Effective_To_Dt date default null, '
|| 'PC_Future_Sub_Effective_Dt date default null, '
|| 'PC_Next_Status_Code varchar(3) default null, '
|| 'AB_Effective_To_Dt date default null, '
|| 'AB_Future_Sub_Effective_Dt date default null, '
|| 'AB_Next_Status_Code varchar(3) default null, '
|| 'Last_Modified_Dt date default null '

Create lf index idx_1 on Decisioning.PL_Entries_DTV (Subs_Year);
Create lf index idx_2 on Decisioning.PL_Entries_DTV (Subs_Quarter_Of_Year);
Create lf index idx_3 on Decisioning.PL_Entries_DTV (Subs_Week_Of_Year);
Create hg index idx_4 on Decisioning.PL_Entries_DTV (Subs_Week_And_Year);
Create date index idx_5 on Decisioning.PL_Entries_DTV (Event_Dt);
Create hg index idx_6 on Decisioning.PL_Entries_DTV (Account_Number);
Create lf index idx_7 on Decisioning.PL_Entries_DTV (Country);
Create lf index idx_8 on Decisioning.PL_Entries_DTV (PC_To_AB);
Create lf index idx_9 on Decisioning.PL_Entries_DTV (AB_Pending_Termination);
Create lf index idx_10 on Decisioning.PL_Entries_DTV (Same_Day_Cancel);
Create lf index idx_11 on Decisioning.PL_Entries_DTV (Same_Day_PC_Reactivation);
Create lf index idx_12 on Decisioning.PL_Entries_DTV (Gross_PC_Pending_Cancellation);
Create lf index idx_13 on Decisioning.PL_Entries_DTV (PC_Pipeline_Cancellation);
Create CMP index idx_14 on Decisioning.PL_Entries_DTV (PC_Effective_To_Dt,PC_Future_Sub_Effective_Dt);
Create DATE index idx_15 on Decisioning.PL_Entries_DTV(PC_Future_Sub_Effective_Dt);


call DBA.sp_DDL ('create', 'view', 'Decisioning', 'PL_Entries_DTV_View',  ' Select * from Decisioning.PL_Entries_DTV')
setuser Decisioning
Grant select on Decisioning.PL_Entries_DTV_View to citeam
call DBA.sp_DDL ('drop', 'view', 'CITeam', 'PL_Entries_DTV')
call DBA.sp_DDL ('create', 'view', 'CITeam', 'PL_Entries_DTV',  ' Select * from Decisioning.PL_Entries_DTV_View')


Select top 1000 * from CITeam.PL_Entries_DTV

-- Alter table Decisioning.Churn_DTV rename Churn_DTV_Old
dba.sp_drop_table 'Decisioning','Churn_DTV'
dba.sp_create_table 'Decisioning','Churn_DTV',
   'Subs_Year integer default null, '
|| 'Subs_Quarter_Of_Year tinyint default null, '
|| 'Subs_Week_Of_Year integer default null, '
|| 'Subs_Week_And_Year integer default null, '
|| 'Event_Dt date default null, '

|| 'Account_Number varchar(20) default null, '
|| 'Owning_Cust_Account_ID varchar(50) default null, '
|| 'Account_Type varchar(255) default null, '
|| 'Account_Sub_Type  varchar(255) default null, '
|| 'cb_Key_Household bigint default null, '
|| 'Created_By_ID varchar(50) default null, '
|| 'Current_Product_sk integer default null, '
|| 'Ent_Cat_Prod_sk integer default null, '
|| 'First_Order_ID varchar(50) default null, '
|| 'Order_ID varchar(50) default null, '
|| 'Order_Line_ID varchar(50) default null, '
|| 'PH_Subs_Hist_sk decimal(22,0) default null, '
|| 'Service_Instance_ID varchar(50) default null, '
|| 'Subscription_ID varchar(50) default null, '
|| 'Country varchar(3) default null, '
|| 'Product_Holding varchar(80) default null, '

|| 'SC_Gross_Termination smallint default 0,'
|| 'PO_Cancellation smallint default 0, '
|| 'PO_Same_Day_Cancel smallint default 0,'
|| 'PO_Pipeline_Cancellation smallint default 0 '

Create lf index idx_1 on Decisioning.Churn_DTV (Subs_Year);
Create lf index idx_2 on Decisioning.Churn_DTV (Subs_Quarter_Of_Year);
Create lf index idx_3 on Decisioning.Churn_DTV (Subs_Week_Of_Year);
Create hg index idx_4 on Decisioning.Churn_DTV (Subs_Week_And_Year);
Create date index idx_5 on Decisioning.Churn_DTV (Event_Dt);
Create hg index idx_6 on Decisioning.Churn_DTV (Account_Number);
Create lf index idx_7 on Decisioning.Churn_DTV (Country);
Create lf index idx_8 on Decisioning.Churn_DTV (SC_Gross_Termination);
Create lf index idx_9 on Decisioning.Churn_DTV (PO_Cancellation);
Create lf index idx_10 on Decisioning.Churn_DTV (PO_Same_Day_Cancel);
Create lf index idx_11 on Decisioning.Churn_DTV (PO_Pipeline_Cancellation);

call DBA.sp_DDL ('create', 'view', 'Decisioning', 'Churn_DTV_View',  ' Select * from Decisioning.Churn_DTV')
setuser Decisioning
Grant select on Decisioning.Churn_DTV_View to citeam
call DBA.sp_DDL ('drop', 'view', 'CITeam', 'Churn_DTV')
call DBA.sp_DDL ('create', 'view', 'CITeam', 'Churn_DTV',  ' Select * from Decisioning.Churn_DTV_View')

Select top 100 * from Decisioning.Churn_DTV



*/

Call Decisioning_Procs.Update_Decisioning_PL_Entries_And_Churn_DTV()

-- setuser decisioning_procs

Create variable Refresh_Dt date default '2019-06-01';


---------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create temp table of relevant DTV status movements
---------------------------------------------------------------------------------------------------------------------------------------------------------

Drop Procedure If Exists Decisioning_Procs.Update_Decisioning_PL_Entries_And_Churn_DTV;
Create Procedure Decisioning_Procs.Update_Decisioning_PL_Entries_And_Churn_DTV(Refresh_Dt date default null)
SQL SECURITY INVOKER
BEGIN
SET TEMPORARY OPTION Query_Temp_Space_Limit = 0; commit;

If Refresh_Dt is null then 
BEGIN 
Set Refresh_Dt = (Select max(event_dt) - 6*7 from Decisioning.PL_Entries_DTV);
END
End If;

SELECT Account_Number,
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
  Case when currency_code = 'EUR' then 'ROI' else 'UK' end Country,
  PH_SUBS_SK, -- Number of Subscriptions
  SUBSCRIPTION_SUB_TYPE, --Subscription Sub Type
  CURRENCY_CODE, -- Currency Code
  STATUS_CODE, -- Status Code
  PREV_STATUS_CODE, -- Prev Status Code
  STATUS_CODE Movement_Type, -- Movement Type
  STATUS_START_DT Calendar_Date, -- Calendar Date
--   Max(Case when Status_Code = 'PC' then Future_Sub_Effective_Dt end) Future_Sub_Effective_Dt,
--   Max(Case when Status_Code = 'PC' then Effective_To_Dt end) Effective_To_Dt,
  Case when cast(STATUS_START_DT as date)-cast(STATUS_END_DT as date) = 0 then 'Y' else 'N' end Same_Day_Movement, -- Same Day Movement
  Case when cast(PREV_STATUS_START_DT as date) - cast(STATUS_START_DT as date)= 0 then 'Y' else 'N' end Same_Day_Prev_Status_Move, -- Same Day Prev Status Move
 CAST(STATUS_START_DT as date) STATUS_START_DT, -- Dummy Date 1
 CAST(PREV_STATUS_START_DT as date) PREV_STATUS_START_DT, -- Dummy Date 2

 Case when current_fo_src_system_catalogue_id In ('14015','14016','14017','14018','14019','14020','14021','14022','14023','14024','14025','14026','14027','14028','14029','14030') then 'Sky Q'
     when current_fo_src_system_catalogue_id In ('13876','13877','13878','13879','13880','13881','13882','13883','13884','13885','13886','13887','13888','13889','13890','13891') then 'Box Sets'
     when current_fo_src_system_catalogue_id In ('13697','13698','13699','13700','13701','13702','13703','13704','13705','13706','13707','13708','13709','13710','13711','13712') then 'Variety'
         when current_fo_src_system_catalogue_id In ('13713','13714','13715','13716','13717','13718','13719','13720','13721','13722','13723','13724','13725','13726','13727','13728','14042','14043','14044','14045','14046','14047','14048','14049','14050','14051','14052','14053','14054','14055','14056','14057') then 'Original (Legacy)'
     when current_fo_src_system_catalogue_id In ('14230','14231','14232','14233','14234','14235','14236','14237','14238','14239','14240','14241','14242','14243','14244','14245') then 'Original (Legacy 2017)'
     when current_fo_src_system_catalogue_id In ('14380','14381','14382','14383','14384','14385','14386','14387','14388','14389','14390','14391','14392','14393','14394','14395') then 'Original'
     when current_product_description LIKE 'Sky Entertainment%' then 'Sky Entertainment'
     when cel.Basic_Desc In ('1 Mix-YNNNNN','1 Mix-NNNYNN','2 Mix-YNNYNN','1 Mix-NNNNNN','0 Mix-NNNNNN','') then 'Original (Legacy)'
--       when (current_fo_src_system_catalogue_id In('14380','14381','14382','14383','14384','14385','14386','14387','14388','14389','14390','14391','14392','14393','14394','14395','14230','14231','14232','14233','14234','14235','14236','14237','14238','14239','14240','14241','14242','14243','14244','14245','13713','13714','13715','13716','13717','13718','13719','13720','13721','13722','13723','13724','13725','13726','13727','13728','14042','14043','14044','14045','14046','14047','14048','14049','14050','14051','14052','14053','14054','14055','14056','14057') OR cel.Basic_Desc In ('1 Mix-YNNNNN','1 Mix-NNNYNN','2 Mix-YNNYNN','1 Mix-NNNNNN','0 Mix-NNNNNN',''))  then 'Original'

         when cel.Basic_Desc In ('6 Mix-NNNNNN') then 'Variety'

     when current_product_description like 'Sky Q%' then 'Sky Q'
     when current_product_description like '6 Mix%' then 'Variety'
     when current_product_description like 'Kids%' then 'Variety'
     when current_product_description like 'Variety%' then 'Variety'
     when current_product_description like 'Knowledge%' then 'Variety'
     when current_product_description like 'News%' then 'Variety'
     when current_product_description like 'Music%' then 'Variety'
     when current_product_description like 'Sky%' then 'Variety'
     when current_product_description like 'Style%' then 'Variety'
     when current_product_description like 'Extra%' then 'Variety'


        -- else 'Original (Legacy)'
         else 'Original'
end as Product_Description_1,

Case when current_fo_src_system_catalogue_id In ('13710','13726','13889','14055','14243','14393') then ' with Cinema 1'
     when current_fo_src_system_catalogue_id In ('13711','13727','13890','14056','14244','14394') then ' with Cinema 2'
     when current_fo_src_system_catalogue_id In ('13708','13724','13887','14053','14241','14391') then ' with Sports 1'
     when current_fo_src_system_catalogue_id In ('13709','13725','13888','14054','14242','14392') then ' with Sports 2'
     when current_fo_src_system_catalogue_id In ('13704','13720','13883','14049','14237','14387') then ' with Sports 1 & Cinema 1'
     when current_fo_src_system_catalogue_id In ('13705','13721','13884','14050','14238','14388') then ' with Sports 1 & Cinema 2'
     when current_fo_src_system_catalogue_id In ('13706','13722','13885','14051','14239','14389') then ' with Sports 2 & Cinema 1'
     when current_fo_src_system_catalogue_id In ('13707','13723','13886','14052','14240','14390') then ' with Sports 2 & Cinema 2'
     when current_fo_src_system_catalogue_id In ('13699','13715','13878','14044','14017','14232','14382') then ' with Cinema'
     when current_fo_src_system_catalogue_id In ('13698','13714','13877','14043','14016','14231','14381') then ' with Sports'
     when current_fo_src_system_catalogue_id In ('13697','13713','13876','14042','14015','14230','14380') then ' with Sports & Cinema'
     when current_fo_src_system_catalogue_id In ('13702','13718','13881','14047','14235','14385') then ' with Sports 1 & Cinema'
     when current_fo_src_system_catalogue_id In ('13703','13719','13882','14048','14236','14386') then ' with Sports 2 & Cinema'
     when current_fo_src_system_catalogue_id In ('13700','13716','13879','14045','14233','14383') then ' with Sports & Cinema 1'
     when current_fo_src_system_catalogue_id In ('13701','13717','13880','14046','14234','14384') then ' with Sports & Cinema 2'
     when current_product_description like 'Sky World%' then ' with Sports & Cinema'
     when current_product_description like '%with Family Pack - 1B' then ' with Cinema'
     when current_product_description like '%with Family Pack - 1C' then ' with Sports'
     when current_product_description like '%with Family Pack - 1J' then ' with Sports 1 & Cinema 2'
     when current_product_description like '%with Movies Mix' then ' with Cinema'
     when current_product_description like '%with Sports Mix' then ' with Sports'
     when current_product_description like '%with Movies 1' then ' with Cinema 1'
     when current_product_description like '%with Movies 2' then ' with Cinema 2'
     when current_product_description like '%with Sports 1' then ' with Sports 1'
     when current_product_description like '%with Sports 2' then ' with Sports 2'
     when current_product_description like '%with Sports 1 & Movies 1' then ' with Sports 1 & Cinema 1'
     when current_product_description like '%with Sports 1 & Movies 2' then ' with Sports 1 & Cinema 2'
     when current_product_description like '%with Sports 2 & Movies 1' then ' with Sports 2 & Cinema 1'
     when current_product_description like '%with Sports 2 & Movies 2' then ' with Sports 2 & Cinema 2'
     when current_product_description like '%with Sports 1 & Movies Mix' then ' with Sports 1 & Cinema'
     when current_product_description like '%with Sports 2 & Movies Mix' then ' with Sports 2 & Cinema'
     when current_product_description like '%with Sports Mix & Movies 1' then ' with Sports & Cinema 1'
     when current_product_description like '%with Sports Mix & Movies 2' then ' with Sports & Cinema 2'
     when current_product_description like '%with Sports Mix & Movies Mix' then ' with Sports & Cinema'
end as Product_Description_2,
-- LIMA - START

Product_Description_1 AS Product_Holding,


 Case when STATUS_CODE = 'AB' And PREV_STATUS_CODE = 'PC' then 1 else 0 end as PC_To_AB, --v_PC_To_AB, -- Includes intraday movements where customer in AB <24Hrs
 Case when (STATUS_CODE='AB' And PREV_STATUS_CODE = 'AC')
           or PC_To_AB > 0
      then 1 else 0
 End as AB_Pending_Termination, --V_pending_terminations Includes intraday movements where customer in AB <24Hrs

 Case when STATUS_CODE = 'PC' or Same_Day_Cancel = 1 then 1 else 0 end as Gross_PC_Pending_Cancellation, --V_pending_cancellations,

 Case when Same_Day_Prev_Status_Move ='Y' And Movement_Type = 'PO' And PREV_STATUS_CODE = 'PC' And STATUS_CODE='PO'
                then 1 Else 0
 End as Same_Day_Cancel, --Includes intraday movements activating same day as cancel but excludes customers going direct from AC --> PO

 Case when Same_Day_Prev_Status_Move = 'Y' And PREV_STATUS_CODE='PC' And STATUS_CODE='AC'
                then 1 else 0
 end as Same_Day_PC_Reactivation,

 Case when Same_Day_Prev_Status_Move = 'Y' And PREV_STATUS_CODE='AB' And STATUS_CODE='AC'
                then 1 else 0
 end as Same_Day_AB_Reactivation,
 Case when Movement_Type='SC' then 1 else 0 end as V_gross_termination, -- Includes intrday SCs
 Case when Same_Day_Cancel > 0 then 0
      when Movement_Type='PO' then 1
      else 0
 end as V_pipeline_cancellation -- Includes intraday POs

Into #MoR_Subs_Events
FROM Cust_Subs_Hist as WH_PH_SUBS_HIST
     left join
     cust_entitlement_lookup cel
     on cel.short_description = WH_PH_SUBS_HIST.current_short_description
WHERE WH_PH_SUBS_HIST.EFFECTIVE_FROM_DT >= Refresh_dt
      and OWNING_CUST_ACCOUNT_ID  >  '1'
      and STATUS_CODE_CHANGED  =  'Y'
      and WH_PH_SUBS_HIST.SUBSCRIPTION_SUB_TYPE = 'DTV Primary Viewing'
;


commit;
create hg index idx_1 on #MoR_Subs_Events(Account_number);
create hg index idx_2 on #MoR_Subs_Events(Calendar_Date);
-- create lf index idx_3 on #MoR_Subs_Events(Rnk);

-- Delete from #MoR_Subs_Events where Rnk > 1;


-----------------------------------------------------------------------------------------------------------------------------------------------------
-- Update DTV_PL_Entries Table
-----------------------------------------------------------------------------------------------------------------------------------------------------
Delete from Decisioning.PL_Entries_DTV MoR
where Event_Dt >= Refresh_dt
;

Insert into Decisioning.PL_Entries_DTV
Select
       null as Subs_Year,
       null as Subs_Quarter_Of_Year,
       null as Subs_Week_Of_Year,
       null as Subs_Week,
       Calendar_Date as Event_Dt,
       Account_number,
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
       Product_Holding,
       PC_To_AB,
       MoR.AB_Pending_Termination as AB_Pending_Termination,
       Gross_PC_Pending_Cancellation,
       Case when MoR.Same_Day_PC_Reactivation > 0 then 0 -- -1
            when MoR.Same_Day_Cancel > 0 then 0 -- -1
            else MoR.Gross_PC_Pending_Cancellation
        end as PC_Pipeline_Cancellation,
       Same_Day_Cancel,
       Same_Day_PC_Reactivation,
       Same_Day_AB_Reactivation,
null as PC_Reactivation,
null as AB_Reactivation,
null as PC_Effective_To_Dt,
null as PC_Future_Sub_Effective_Dt,
null as PC_Next_Status_Code,
null as AB_Effective_To_Dt,
null as AB_Future_Sub_Effective_Dt,
null as AB_Next_Status_Code,
today() as Last_Modified_Dt

from #MoR_Subs_Events MoR
where PC_To_AB != 0
        or AB_Pending_Termination != 0
        or Same_Day_Cancel != 0
        or Same_Day_PC_Reactivation != 0
        or Same_Day_AB_Reactivation != 0
        or PC_Pipeline_Cancellation != 0
        ;



Update Decisioning.PL_Entries_DTV MoR
Set Subs_Year = sc.subs_year,
    Subs_Quarter_Of_Year = sc.Subs_Quarter_Of_Year,
    Subs_Week_Of_Year = sc.Subs_Week_Of_Year,
    Subs_Week_And_Year = sc.Subs_Week_And_Year
from Decisioning.PL_Entries_DTV MoR
     inner join
     sky_calendar sc
     on sc.calendar_date = MoR.Event_dt
where MoR.Subs_Week_And_Year is null;

commit;

--------------------------------------------------------------------------------------
------------------------- Add Future Subs Effective Dt -------------------------------
--------------------------------------------------------------------------------------
Drop table if exists #PC_Future_Effective_Dt;
Select MoR.account_number,MoR.event_dt,
        csh.status_end_dt status_end_dt,
        csh.future_sub_effective_dt,
        csh.effective_from_datetime,
        csh.effective_to_datetime,
        Case when csh.effective_to_dt = csh.effective_from_dt then 1 else 0 end as ZeroDuration,  
        row_number() over(partition by MoR.account_number,MoR.event_dt order by csh.effective_from_datetime desc,ZeroDuration,csh.effective_to_datetime asc) PC_Rnk
into #PC_Future_Effective_Dt
from Decisioning.PL_Entries_DTV MoR
     inner join
     cust_subs_hist csh
     on csh.account_number = MoR.account_number
        and csh.status_start_dt = MoR.Event_dt
        and csh.subscription_sub_type = 'DTV Primary Viewing'
        and csh.OWNING_CUST_ACCOUNT_ID  >  '1'
        and csh.STATUS_CODE_CHANGED  =  'Y'
        and csh.status_code  = 'PC'
where event_dt >= '2011-07-01' -- Future subs effective date not properly populated before this date
      and (Same_Day_Cancel > 0 or PC_Pipeline_Cancellation > 0 or Same_Day_PC_Reactivation > 0)
       and (MoR.PC_Effective_To_Dt is null or MoR.PC_Future_Sub_Effective_Dt is null)
;

commit;
create hg index idx_1 on #PC_Future_Effective_Dt(account_number);
create date index idx_2 on #PC_Future_Effective_Dt(event_dt);
create lf index idx_3 on #PC_Future_Effective_Dt(PC_Rnk);

Delete from #PC_Future_Effective_Dt where PC_Rnk > 1;

commit;

Update Decisioning.PL_Entries_DTV MoR
Set MoR.PC_Future_Sub_Effective_Dt = PC.future_sub_effective_dt
from Decisioning.PL_Entries_DTV MoR
     inner join
     #PC_Future_Effective_Dt PC
     on PC.account_number = MoR.account_number
        and pc.event_dt = MoR.event_dt
where (Same_Day_Cancel > 0 or PC_Pipeline_Cancellation > 0 or Same_Day_PC_Reactivation > 0)
       and 
        (MoR.PC_Effective_To_Dt is null or MoR.PC_Future_Sub_Effective_Dt is null)
        ; 

Update Decisioning.PL_Entries_DTV MoR
Set MoR.AB_Future_Sub_Effective_Dt = Cast(event_dt + 50 as date)
where (AB_Pending_Termination > 0 or Same_Day_AB_Reactivation > 0)
        and (AB_Effective_To_Dt is null or AB_Future_Sub_Effective_Dt is null);

--------------------------------------------------------------------------------------
--------------------------- Add PC Effective To Dt -----------------------------------
--------------------------------------------------------------------------------------
Drop table if exists #PC_Status_Change;
Select 
       MoR.account_number,
       MoR.event_dt,
       CSH.status_end_dt PC_Effective_To_dt,
       Cast(null as varchar(10)) as  Next_Status_Code,
       Case when csh.effective_to_dt = csh.effective_from_dt then 1 else 0 end as ZeroDuration,
       Row_number() over(partition by MoR.account_number,MoR.event_dt order by ZeroDuration,status_end_dt desc) Status_change_rnk
into #PC_Status_Change
from Decisioning.PL_Entries_DTV MoR
     inner join
     cust_subs_hist CSH
     on CSH.account_number = MoR.account_number
        and CSH.status_start_dt = MoR.event_dt
        and csh.subscription_sub_type = 'DTV Primary Viewing'
        and csh.status_code = 'PC'
        and csh.status_code_changed = 'Y'
where (Same_Day_Cancel > 0 or PC_Pipeline_Cancellation > 0 or Same_Day_PC_Reactivation > 0)
        and MoR.PC_Next_Status_Code is null
;

commit;
create hg index idx_1 on #PC_Status_Change(account_number);
create date index idx_2 on #PC_Status_Change(Event_Dt);
create date index idx_3 on #PC_Status_Change(PC_Effective_To_dt);
create lf index idx_4 on #PC_Status_Change(Status_change_rnk);

Update #PC_Status_Change MoR
Set Next_Status_Code = csh.status_code
from #PC_Status_Change MoR
     inner join
     cust_subs_hist CSH
     on CSH.account_number = MoR.account_number
        and csh.status_start_dt = MoR.PC_Effective_To_dt
        and csh.subscription_sub_type = 'DTV Primary Viewing'
        and csh.prev_status_code = 'PC'
        and csh.status_code != 'PC'
        and csh.status_code_changed = 'Y'
;


Update Decisioning.PL_Entries_DTV
Set PC_Effective_To_Dt = CSH.PC_Effective_To_dt,
    PC_Next_Status_Code = CSH.Next_Status_Code
from Decisioning.PL_Entries_DTV MoR
     inner join
     #PC_Status_Change CSH
     on CSH.account_number = MoR.account_number
        and CSH.event_dt = MoR.event_dt
where Status_change_rnk = 1;


commit;




--------------------------------------------------------------------------------------
--------------------------- Add AB Effective To Dt -----------------------------------
--------------------------------------------------------------------------------------
Drop table if exists #AB_Status_Change;
Select 
       MoR.account_number,
       MoR.event_dt,
       CSH.status_end_dt AB_Effective_To_dt,
       Cast(null as varchar(10)) as  Next_Status_Code,
       Case when csh.effective_to_dt = csh.effective_from_dt then 1 else 0 end as ZeroDuration,
       Row_number() over(partition by MoR.account_number,MoR.event_dt order by ZeroDuration,status_end_dt desc) Status_change_rnk
into #AB_Status_Change
from Decisioning.PL_Entries_DTV MoR
     inner join
     cust_subs_hist CSH
     on CSH.account_number = MoR.account_number
        and CSH.status_start_dt = MoR.event_dt
--         and csh.status_end_dt >= MoR.event_dt
        and csh.subscription_sub_type = 'DTV Primary Viewing'
        and csh.status_code = 'AB'
        and csh.status_code_changed = 'Y'
where (AB_Pending_Termination > 0 or Same_Day_AB_Reactivation > 0)
      and MoR.AB_Next_Status_Code is null
    ;

commit;
create hg index idx_1 on #AB_Status_Change(account_number);
create date index idx_2 on #AB_Status_Change(Event_Dt);
create date index idx_3 on #AB_Status_Change(AB_Effective_To_dt);
create lf index idx_4 on #AB_Status_Change(Status_change_rnk);

Update #AB_Status_Change MoR
Set Next_Status_Code = csh.status_code
from #AB_Status_Change MoR
     inner join
     cust_subs_hist CSH
     on CSH.account_number = MoR.account_number
        and CSH.status_start_dt = MoR.AB_Effective_To_dt
        and csh.subscription_sub_type = 'DTV Primary Viewing'
        and csh.prev_status_code = 'AB'
        and csh.status_code != 'AB'
        and csh.status_code_changed = 'Y'
;


Update Decisioning.PL_Entries_DTV
Set AB_Effective_To_Dt = CSH.AB_Effective_To_dt,
    AB_Next_Status_Code = CSH.Next_Status_Code
from Decisioning.PL_Entries_DTV MoR
     inner join
     #AB_Status_Change CSH
     on CSH.account_number = MoR.account_number
        and CSH.event_dt = MoR.event_dt
where Status_change_rnk = 1;


commit;


Update Decisioning.PL_Entries_DTV
Set PC_Reactivation = Case when PC_Effective_To_Dt is not null and PC_Next_Status_Code = 'AC'  then 1
                            when PC_Effective_To_Dt is not null and PC_Next_Status_Code != 'AC' then 0
                       end,
    AB_Reactivation = Case when AB_Effective_To_Dt is not null and AB_Next_Status_Code = 'AC'  then 1
                            when AB_Effective_To_Dt is not null and AB_Next_Status_Code != 'AC' then 0
                       end
where PC_Reactivation is null and AB_Reactivation is null;




















































-----------------------------------------------------------------------------------------------------------------------------------------------------
-- Update DTV_Churn Table
-----------------------------------------------------------------------------------------------------------------------------------------------------


Delete from Decisioning.Churn_DTV MoR
where Event_Dt >= Refresh_dt
;


Insert into Decisioning.Churn_DTV
Select
       null as Subs_Year,
       null as Subs_Quarter_Of_Year,
       null as Subs_Week_Of_Year,
       null as Subs_Week,
       Calendar_Date as Event_Dt,
       Account_number,
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
       Product_Holding,
       mor.V_gross_termination as SC_Gross_Termination, --V_gross_terminations, -- Includes intrday SCs
       mor.Same_Day_Cancel+mor.V_pipeline_cancellation as PO_Cancellation,
       mor.Same_Day_Cancel as PO_Same_Day_Cancel, --Includes intraday movements activating same day as cancel but excludes customers going direct from AC --> PO
       V_pipeline_cancellation as PO_Pipeline_Cancellation -- V_pipeline_cancellations -- Includes intraday POs
from #MoR_Subs_Events mor
where PO_Same_Day_Cancel != 0 or SC_Gross_Termination != 0 or PO_Pipeline_Cancellation > 0;

Update Decisioning.Churn_DTV MoR
Set Subs_Year = sc.subs_year,
    Subs_Quarter_Of_Year = sc.Subs_Quarter_Of_Year,
    Subs_Week_Of_Year = sc.Subs_Week_Of_Year,
    Subs_Week_And_Year = sc.Subs_Week_And_Year
from Decisioning.Churn_DTV MoR
     inner join
     sky_calendar sc
     on sc.calendar_date = MoR.Event_dt
where MoR.Subs_Week_And_Year is null;

commit;

END;
--
Grant Execute on Decisioning_Procs.Update_Decisioning_PL_Entries_And_Churn_DTV to Decisioning;



--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

-- Select top 1000 * from decisioning.Churn_DTV;
-- Select top 1000 * from decisioning.PL_Entries_DTV where event_dt = '2017-03-10' and pc_to_ab != 0;
-- Select pc_to_ab,count(*),sum(pc_to_ab) from decisioning.PL_Entries_DTV where event_dt = '2017-03-10' group by pc_to_ab;

/*

Select event_dt
,sum(PC_To_AB) -- Validated
,sum(AB_Pending_Termination) --
,sum(PC_Pipeline_Cancellation)
,sum(Same_Day_Cancel)
,sum(Same_Day_PC_Reactivation)
,sum(Same_Day_AB_Reactivation)
,sum(PC_Reactivation)
,sum(AB_Reactivation)
from Decisioning.PL_Entries_DTV
where event_dt >= '2017-03-10'
group by event_dt


Select event_dt
,sum(SC_Gross_Termination)
,sum(PO_Cancellation)
,sum(PO_Same_Day_Cancel)
,sum(PO_Pipeline_Cancellation)
from Decisioning.Churn_DTV
where event_dt >= '2017-03-10'
group by event_dt

*/
