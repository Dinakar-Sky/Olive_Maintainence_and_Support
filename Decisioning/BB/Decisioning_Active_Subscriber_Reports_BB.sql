/*------------------------------------------------------------------------------*/
/*                         BB Active Subscribers                               */
/*                                                                              */
/*          Reconciled to Daily BB & Talk Subscriber Report                     */
/*                                                                              */
/*------------------------------------------------------------------------------*/

-- Setuser Decisioning_Procs

Call Decisioning_Procs.Update_Active_Subscriber_Report_BB()

Drop Procedure If Exists Decisioning_Procs.Update_Active_Subscriber_Report_BB;
Create Procedure Decisioning_Procs.Update_Active_Subscriber_Report_BB(Refresh_Dt date default null)
SQL SECURITY INVOKER
BEGIN


SET TEMPORARY OPTION Query_Temp_Space_Limit = 0; commit;

-- Drop variable if exists Refresh_dt; Create variable Refresh_dt date;

-- Set Refresh_dt = '1917-12-01';
--select Refresh_dt;
If Refresh_Dt is null then
BEGIN
Set Refresh_dt = (Select max(effective_from_dt) - 4 * 7 from Decisioning.Active_Subscriber_Report_Src where subscription_sub_type = 'Broadband');
Set Refresh_dt = Case when Refresh_dt > today() - 4*7 then today() - 4 * 7 else Refresh_dt end;
END;
End If;
-----------------------------------------------------------------------------------------------------------------------
-- BB Subs
-----------------------------------------------------------------------------------------------------------------------

-- Select potential subs change records that will be basis of incremental update to subs table
Select
ph_subs_hist_sk,
Account_Number,
Account_Type,
Account_Sub_Type,
Owning_Cust_Account_ID,
Subscription_Type,
Current_Product_sk,
Cast(null as varchar(80)) as Subscription_Sub_Type,
Cast(null as date) as Effective_From_Dt,
Cast(null as date) as Effective_To_Dt,
Effective_From_Datetime,
Cast(null as integer) as Active_Subscriber,
Cast(null as integer) as Effective_From_Subs_Week,Cast(null as integer) as Effective_To_Subs_Week,Cast(null as smallint) as Number_Of_Active_Subs,
Cast(null as varchar(80)) as BB_Product_Description,
Cast(csh.current_product_description as varchar(80)) as Product_Holding,
Subscription_ID,Service_Instance_ID,Status_Code,SI_LATEST_SRC,
Cast(null as varchar(3)) as Country,
current_product_description,ENT_CAT_PROD_SK,
Cast(null as integer) as OfferCode,Cast(Null as varchar(240)) as BOXSET_FLAG,Cast(Null as varchar(3)) as HDPremiumFlag,
Cast(0 as tinyint) Overlapping_Records,
Status_Start_Dt,
Status_End_Dt,
Status_Reason,
Prev_Status_Code

into #Subs_Movements
FROM Cust_Subs_Hist csh
Where 1 = 0;

commit;
create hg   index   idx_1   on #Subs_Movements(Owning_Cust_Account_ID);
create date index   idx_2   on #Subs_Movements(Effective_From_Dt);
create date index   idx_3   on #Subs_Movements(Effective_To_Dt);
create lf   index   idx_4   on #Subs_Movements(Subscription_Sub_Type);
create lf   index   idx_5   on #Subs_Movements(Number_Of_Active_Subs);
create lf   index   idx_6   on #Subs_Movements(Product_Holding);
create hg   index   idx_9   on #Subs_Movements(current_product_description);
create hg   index   idx_10  on #Subs_Movements(ENT_CAT_PROD_SK);
create hg   index   idx_11  on #Subs_Movements(ph_subs_hist_sk);
create hg   index   idx_12  on #Subs_Movements(subscription_id);
create lf   index   idx_13  on #Subs_Movements(Overlapping_Records);
create dttm index   idx_14   on #Subs_Movements(Effective_From_Datetime);

-- Insert into #Subs_Movements Select * from Subs_Movements;

Insert into #Subs_Movements
Select --top 100
ph_subs_hist_sk,
Account_Number,
Account_Type,
Account_Sub_Type,
csh.Owning_Cust_Account_ID,
'BROADBAND' as Subscription_Type,
Current_Product_sk,
'Broadband' as Subscription_Sub_Type,
Effective_From_Dt,
Effective_To_Dt,
Effective_From_Datetime,
Cast(null as integer) as Effective_From_Subs_Week,
Cast(null as integer) as Effective_To_Subs_Week,
Cast(null as integer) as Active_Subscriber,
Cast(Case when status_code in ('AC','AB','PC','BCRQ','CF','PT') then 1 else 0 end as smallint) as Number_Of_Active_Subs,
CASE WHEN Current_Product_sk = 43373 THEN 'Sky Broadband Unlimited (Legacy)' ELSE Current_Product_Description END as BB_Product_Description,
CASE WHEN BB_Product_Description='Broadband Connect' Then 'Connect'
     WHEN BB_Product_Description In ('?','Other','Missing at load') Then 'Other'
     WHEN BB_Product_Description like 'Sky Broadband Lite%' Then Substr(BB_Product_Description,1,200)
     WHEN BB_Product_Description like 'Sky Broadband %' Then Substr(BB_Product_Description,15,200)
     WHEN BB_Product_Description='Sky Fibre Unlimited Pro' Then 'Fibre Unlimited Pro'
     WHEN BB_Product_Description like 'Sky Fibre %' Then Substr(BB_Product_Description,5,200)
     WHEN BB_Product_Description like 'Sky Connect %' Then Substr(BB_Product_Description,5,200)
     Else BB_Product_Description
End as Product_Holding,
Subscription_ID,
Service_Instance_ID,
Status_Code,
SI_LATEST_SRC,
Case when currency_code = 'EUR' then 'ROI' else 'UK' end Country,
current_product_description,
ENT_CAT_PROD_SK,
Cast(null as integer) as OfferCode,
Cast(Null as varchar(240)) as BOXSET_FLAG,
Cast(Null as varchar(3)) as HDPremiumFlag,
Cast(0 as tinyint) as Overlapping_Records,
Status_Start_Dt,
Status_End_Dt,
Status_Reason,
Prev_Status_Code
FROM Cust_Subs_Hist csh
     left join
     cust_entitlement_lookup cel
     on cel.short_description = csh.current_short_description
Where --owning_cust_account_id = '12074245144541973371471' and
csh.effective_to_dt >= Refresh_dt --Coalesce(ard.Acc_Refresh_dt,Refresh_dt)
        and csh.Subscription_Sub_Type = 'Broadband DSL Line'
        and csh.account_number != '99999999999999'
        and csh.OWNING_CUST_ACCOUNT_ID  >  '1'
        and csh.SI_LATEST_SRC  = 'CHORD'
        and csh.effective_to_dt > csh.effective_from_dt
;
--
--
-- Drop table if exists Subs_Movements;
-- Select * into Subs_Movements from #Subs_Movements;
--
-- Skip_Create_Subs_Movements:

Select owning_cust_account_id,subscription_id,Max(Number_Of_Active_Subs) Inc_Active_subscription
into #Inactive_Subs
from #Subs_Movements
group by owning_cust_account_id,subscription_id
having Inc_Active_subscription = 0;

commit;
create hg index idx_1 on #Inactive_Subs(owning_cust_account_id);
create hg index idx_2 on #Inactive_Subs(subscription_id);

Delete #Subs_Movements sm
from #Subs_Movements sm
     inner join
     #Inactive_Subs ins
     on ins.owning_cust_account_id = sm.owning_cust_account_id
        and ins.subscription_id = sm.subscription_id
        ;

-- Select count(*) from #Subs_Movements;
-- return;








-- Evaluate new effective_from/to dates for overlapping records
Select sm.ph_subs_hist_sk,Cast(null as datetime) as Min_Effective_From_Dt
into #Correct_Effect_To_Dates
from #Subs_Movements sm where 1=0;

Insert into #Correct_Effect_To_Dates
-- Evaluate new effective_from/to dates for overlapping records
Select sm.ph_subs_hist_sk,min(sm_2.effective_from_dt) as Min_Effective_From_Dt
from #Subs_Movements sm
     inner join
     #Subs_Movements sm_2
     on sm_2.owning_cust_account_id = sm.owning_cust_account_id
        and sm_2.subscription_id = sm.subscription_id
        and sm.effective_to_dt > sm_2.effective_from_dt --+ 1 --and sm_2.effective_to_dt
        and sm_2.effective_from_dt > sm.effective_from_dt
        and sm_2.ph_subs_hist_sk != sm.ph_subs_hist_sk
--         and sm_2.Overlapping_Records > 0
where (sm.Number_Of_Active_Subs > 0 and sm_2.Number_Of_Active_Subs > 0) -- If active then set effective_to_dt to first overlapping record
group by sm.ph_subs_hist_sk
;

-- Update effective_to_dt of overlapping records
Update #Subs_Movements sm
Set Effective_To_Dt = Cast(cetd.Min_Effective_From_Dt as date)
from #Correct_Effect_To_Dates/*_2*/  cetd
where cetd.ph_subs_hist_sk = sm.ph_subs_hist_sk;


Drop table if exists #Correct_Effect_To_Dates;

Delete #Subs_Movements sm
from #Subs_Movements sm
     inner join
     #Subs_Movements os
     on os.owning_cust_account_id = sm.owning_cust_account_id
        and os.subscription_id = sm.subscription_id
        and os.subscription_sub_type = sm.subscription_sub_type
        and os.effective_from_dt between sm.effective_from_dt + 1 and sm.effective_to_dt - 1
        and sm.effective_to_dt = '9999-09-09';



-- Delete records that are no longer effective beyond Refresh Dt after record corrections
Delete from #Subs_Movements where effective_to_dt < Refresh_Dt;


Delete from Decisioning.Active_Subscriber_Report_Src
where Effective_To_Dt >= Refresh_Dt and
-- subscription_sub_type = 'BB'
subscription_sub_type in (Select distinct subscription_sub_type from #Subs_Movements)
;


-- Update effective_to_dt of overlapping records
Select sm.ph_subs_hist_sk,sm.effective_to_dt,max(asr.effective_to_dt) as effective_from_dt
into #Effective_To
from #Subs_Movements sm
     inner join
     Decisioning.Active_Subscriber_Report_Src  asr
     on asr.ph_subs_hist_sk = sm.ph_subs_hist_sk
        and sm.subscription_sub_type = asr.subscription_sub_type
        and asr.effective_to_dt < Refresh_Dt
        and Refresh_dt between sm.effective_from_dt + 1 and sm.effective_to_dt
group by sm.ph_subs_hist_sk,sm.effective_to_dt;

-- Create hg index idx_1 on Active_Subscriber_Report_Src(ph_subs_hist_sk);
-- Create lf index idx_2 on Active_Subscriber_Report_Src(subscription_sub_type);

commit;
create hg   index idx_1 on #Effective_To(ph_subs_hist_sk);
create date index idx_2 on #Effective_To(effective_to_dt);


Update #Subs_Movements sm
Set Effective_From_Dt = asr.effective_from_dt
from #Effective_To  asr
where asr.ph_subs_hist_sk = sm.ph_subs_hist_sk
      and asr.effective_to_dt = sm.effective_to_dt;

Drop table if exists #Effective_To;


----------------------------------------------------------------------------------------------------------
-- Insert new records into Decisioning.Active_Subscriber_Report_Src
----------------------------------------------------------------------------------------------------------


commit;


-- Insert new records into Decisioning.Active_Subscriber_Report_Src table
Insert into Decisioning.Active_Subscriber_Report_Src(Effective_From_Dt,Effective_To_Dt,Account_Number,Account_Type,Account_Sub_Type,Owning_Cust_Account_ID,Subscription_Type,Subscription_Sub_Type,
Service_Instance_ID,Subscription_ID,ph_subs_hist_sk,Status_Code,Current_Product_sk,Product_Holding,Country,Active_Subscriber,Active_Subscription,
PH_Subs_Status_Start_Dt,PH_Subs_Status_End_Dt_Dt,PH_Subs_Prev_Status_Code,PH_Subs_Status_Reason
)
Select   osm.Effective_From_Dt,
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
from #Subs_Movements osm
where osm.Number_Of_Active_Subs > 0;


commit;


-- return;


----------------------------------------------------------------------------------------------------------
-- Dedupe doubles counts where customers have multiple active subscriptions
----------------------------------------------------------------------------------------------------------
-- Select * into #Subs_Movements from Subs_Movements sm;

Select asr.owning_cust_account_id,asr.subscription_sub_type,asr.effective_from_dt as Change_Dt
into #Active_Subs_Change_Dts
from Decisioning.Active_Subscriber_Report_Src asr
     inner join
     Decisioning.Active_Subscriber_Report_Src asr_2
     on asr_2.owning_cust_account_id = asr.owning_cust_account_id
        and asr_2.subscription_sub_type = asr.subscription_sub_type
        and asr_2.ph_subs_hist_sk != asr.ph_subs_hist_sk
        and asr_2.subscription_id != asr.subscription_id
        and asr.effective_from_dt between asr_2.effective_from_dt and asr_2.effective_to_dt
        and asr_2.Subscription_Sub_Type = 'Broadband'
        and asr_2.Active_Subscriber = 1
where asr.Effective_To_Dt >= Refresh_Dt
        and asr.Subscription_Sub_Type = 'Broadband'
        and asr.Active_Subscriber = 1
group by asr.owning_cust_account_id,asr.subscription_sub_type,asr.effective_from_dt
union
Select asr.owning_cust_account_id,asr.subscription_sub_type,asr.effective_to_dt as Change_Dt
from Decisioning.Active_Subscriber_Report_Src asr
     inner join
     Decisioning.Active_Subscriber_Report_Src asr_2
     on asr_2.owning_cust_account_id = asr.owning_cust_account_id
        and asr_2.subscription_sub_type = asr.subscription_sub_type
        and asr_2.ph_subs_hist_sk != asr.ph_subs_hist_sk
        and asr_2.subscription_id != asr.subscription_id
        and asr.effective_to_dt between asr_2.effective_from_dt and asr_2.effective_to_dt
        and asr_2.Subscription_Sub_Type = 'Broadband'
        and asr_2.Active_Subscriber = 1
where asr.Effective_To_Dt >= Refresh_Dt
        and asr.Subscription_Sub_Type = 'Broadband'
        and asr.Active_Subscriber = 1
group by asr.owning_cust_account_id,asr.subscription_sub_type,asr.effective_to_dt;



While (Select count(*) from #Active_Subs_Change_Dts) > 0 loop

Drop table if exists #Loop_Change_Dts;
Select owning_cust_account_id,subscription_sub_type, min(Change_Dt) as Change_Dt
into #Loop_Change_Dts
from #Active_Subs_Change_Dts
group by owning_cust_account_id,subscription_sub_type;

Drop table if exists #temp_Split_Records;
Select sm.*
into #temp_Split_Records
from Decisioning.Active_Subscriber_Report_Src sm
     inner join
     #Loop_Change_Dts lcd
     on sm.owning_cust_account_id = lcd.owning_cust_account_id
        and sm.subscription_sub_type = lcd.subscription_sub_type
        and lcd.change_dt between sm.effective_from_dt + 1 and sm.effective_to_dt - 1;

Update #temp_Split_Records sm
Set effective_to_dt = lcd.change_dt
from #Loop_Change_Dts lcd
where sm.owning_cust_account_id = lcd.owning_cust_account_id
        and sm.subscription_sub_type = lcd.subscription_sub_type
        and lcd.change_dt between sm.effective_from_dt + 1 and sm.effective_to_dt - 1
        ;

Update Decisioning.Active_Subscriber_Report_Src sm
Set effective_from_dt = lcd.change_dt
from #Loop_Change_Dts lcd
where sm.owning_cust_account_id = lcd.owning_cust_account_id
        and sm.subscription_sub_type = lcd.subscription_sub_type
        and lcd.change_dt between sm.effective_from_dt + 1 and sm.effective_to_dt - 1
        ;


Insert into Decisioning.Active_Subscriber_Report_Src
Select * from #temp_Split_Records;

Delete #Active_Subs_Change_Dts ascd
from #Loop_Change_Dts lcd
where ascd.owning_cust_account_id = lcd.owning_cust_account_id
        and ascd.subscription_sub_type = lcd.subscription_sub_type
        and ascd.Change_Dt = lcd.Change_Dt
        ;

End Loop;


Drop table if exists #Active_Subs_Change_Dts;
Drop table if exists #Loop_Change_Dts;
Drop table if exists #temp_Split_Records;



-- Update Effective From and To Subs Week fields
Update Decisioning.Active_Subscriber_Report_Src asr
Set Effective_From_Subs_Week = Cast(sc.subs_week_and_year as integer)
from Decisioning.Active_Subscriber_Report_Src asr
     inner join
     sky_calendar sc
     on sc.calendar_date = asr.effective_from_dt
where asr.Effective_From_Subs_Week is null
;

Update Decisioning.Active_Subscriber_Report_Src asr
Set Effective_To_Subs_Week = Cast(Coalesce(sc.subs_week_and_year,'999999') as integer)
from Decisioning.Active_Subscriber_Report_Src asr
     left join
     sky_calendar sc
     on sc.calendar_date = asr.effective_to_dt
where asr.Effective_To_Subs_Week is null
        or asr.Effective_To_Subs_Week = 999999;
;














---------------------------------------------------------------------------------------------------
Select distinct Substr(current_product_description,15,200) as Sky_BB_Type
into #Sky_BB_Types
from cust_subs_hist
where subscription_sub_type = 'Broadband DSL Line'
        ;


-- Drop table if exists #Order_Subs_Movements;
Select Owning_Cust_Account_ID,ph_subs_hist_sk,Effective_From_Dt,Subscription_Sub_Type,
--        CASE
--                 WHEN Product_Holding = 'Connect' then 1
--                 WHEN Product_Holding = 'Other' then 2
--                 WHEN Product_Holding like 'Sky BB Lite%' then 3
--                 WHEN #Sky_BB_Types.Sky_BB_Type is not null then 4
--                 WHEN Product_Holding = 'Fibre Unlimited Pro' then 5
--                 WHEN Product_Holding like 'Fibre %' then 6
--                 WHEN Product_Holding like 'Connect %' then 7
--                 else 9
--        END
       1 as Prod_Holding_Num,
       Cast(Case status_code
                when 'AC' then 1
                when 'PC' then 2
                when 'AB' then 3
                else 999
            end as integer) as Status_Num,
       -- Rank of the dates the changes were applied to each subscription so effective to dates can be readjusted
--        Dense_Rank() over(partition by Owning_Cust_Account_Id,subscription_sub_type,subscription_id order by Subs_Change_Dt asc) Subs_Change_Rnk,
       -- Rank the product holding of all active subs on the date and change was applied
--        Dense_Rank() over(partition by Owning_Cust_Account_Id,subscription_sub_type,subscription_id,Subs_Change_Dt order by Number_Of_Active_Subs desc, effective_from_dt /*Prod_Holding_Num*/ desc,Status_Num asc) Prod_Holding_Rnk,
       -- Assign unique identifier to each record
--        Row_Number() over(partition by Owning_Cust_Account_Id,subscription_sub_type,Subs_Change_Dt,Number_Of_Active_Subs,effective_from_dt,Status_Num order by Effective_To_Dt desc) Record_Rnk,
       Row_Number() over(partition by Owning_Cust_Account_Id,subscription_sub_type,Effective_From_Dt order by Prod_Holding_Num desc,Status_Num asc) Acc_Rnk
into #Order_Subs_Movements
from Decisioning.Active_Subscriber_Report_Src asr
     left join
     #Sky_BB_Types
     on #Sky_BB_Types.Sky_BB_Type = asr.Product_Holding
where effective_to_dt >= Refresh_Dt
        and subscription_sub_type in ('Broadband' /*Select distinct subscription_sub_type from #Subs_Movements*/)
;


commit;
create hg   index idx_1  on #Order_Subs_Movements(Owning_Cust_Account_ID);
create hg   index idx_2  on #Order_Subs_Movements(ph_subs_hist_sk);
create date index idx_3  on #Order_Subs_Movements(Effective_From_Dt);
create lf   index idx_4  on #Order_Subs_Movements(Subscription_Sub_Type);
create lf   index idx_5 on #Order_Subs_Movements(Acc_Rnk);


Update Decisioning.Active_Subscriber_Report_Src asr
Set Active_Subscriber = Case when osm.Acc_Rnk = 1 then 1 else 0 end
from #Order_Subs_Movements osm
where  osm.ph_subs_hist_sk = asr.ph_subs_hist_sk
        and osm.Owning_Cust_Account_ID = asr.Owning_Cust_Account_ID
        and osm.Subscription_Sub_Type = asr.Subscription_Sub_Type
        and osm.Effective_From_Dt = asr.Effective_From_Dt
        ;

END;

Grant execute on Decisioning_Procs.Update_Active_Subscriber_Report_BB to Decisioning;

return;































-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------
Select count(distinct OWNING_CUST_ACCOUNT_ID),count(distinct subscription_id)
from cust_subs_hist csh
where '2017-03-30' between csh.effective_from_dt and csh.effective_to_dt - 1
    and csh.subscription_sub_type = 'BB DSL Line'
    and csh.status_code in ('AC','AB','PC','BCRQ')
    and OWNING_CUST_ACCOUNT_ID  >  '1'
    and SI_LATEST_SRC  =  'CHORD';

Select Cast(sc.calendar_date as date) calendar_date,sum(Active_Subscriber) as Subscribers,sum(Active_Subscription) Number_Of_Active_Subs
,Product_Holding
from sky_calendar sc
     inner join
     Decisioning.Active_Subscriber_Report_Src asr --Decisioning.Active_Subscriber_Report_Src asr
     on sc.calendar_date between effective_from_dt and effective_to_dt - 1
        and asr.subscription_sub_type = 'Broadband'
where sc.calendar_date between '2016-09-30' and '2016-10-06'
group by calendar_date
,Product_Holding
order by calendar_date;
;


Select count(*) from Decisioning.Active_Subscriber_Report_Src_init;
Select count(*) from Decisioning.Active_Subscriber_Report_Src;

Select count(*) over(partition by ph_subs_hist_sk,effective_from_dt) Dupes
,*
into #Dupes
from Decisioning.Active_Subscriber_Report_Src asr
where '2016-05-30' between asr.effective_from_dt and asr.effective_to_dt - 1
        and asr.BB_Active_Subscription > 0
        and asr.subscription_sub_type = 'BB';

Select top 100 * from #Dupes where Dupes > 1
order by owning_cust_account_id,effective_from_dt,ph_subs_hist_sk;

Select top 10 asr.*
from Decisioning.Active_Subscriber_Report_Src asr
     left join
     Decisioning.Active_Subscriber_Report_Src_init asr_2
     on asr.owning_cust_account_id = asr_2.owning_cust_account_id
        and asr.subscription_sub_type = asr_2.subscription_sub_type
        and '2016-05-30' between asr_2.effective_from_dt and asr_2.effective_to_dt - 1
        and asr_2.BB_Active > 0
where '2016-05-30' between asr.effective_from_dt and asr.effective_to_dt - 1
        and asr.BB_Active > 0
        and asr_2.owning_cust_account_id is null
        and asr.subscription_sub_type = 'BB';

Select top 100 * from Decisioning.Active_Subscriber_Report_Src_init asr
where owning_cust_account_id = '12074245144541973371471'
        and subscription_sub_type = 'BB'
order by subscription_id,effective_from_dt;

Select top 100 * from Decisioning.Active_Subscriber_Report_Src asr
where owning_cust_account_id = '12074245144541973371471'
        and subscription_sub_type = 'BB'
order by subscription_id,effective_from_dt;


