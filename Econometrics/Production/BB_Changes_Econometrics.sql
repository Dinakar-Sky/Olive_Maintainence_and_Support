/*
***************************************************************************************************************************************************************
																	 $$$
																	 I$$$
																	 I$$$
														   $$$$$$$$  I$$$    $$$ $$$      $$$
														 ,$$$$       I$$$   $$$  $$$$    $$$ 
														 ?$$$,       I$$$ $$$$.   $$$$  $$$= 
														  $$$$$$$$=  I$$$$$$$      $$$$.$$$  
															  :$$$$  I$$$ $$$$      $$$$$$   
														   ,.  $$$$  I$$$  $$$$      $$$$=   
														  $$$$$$$$   I$$$   $$$$     .$$$    
																				    $$$     
																				   $$$      
																				  $$$?

***************************************************************************************************************************************************************
------------------------------------------------------------------------------------------------------------------------------------------------------------
Project:        BB orders & offers 
Created:        21/05/2018
Owner  :        Fractal 
---------------------------------------------------------------------------------------------------------------------------------------------------------------
Program to extract all BB orders and offers on weekly basis  

***************************************************************************************************************************************************************
****                                                              Change History                                                                           ****
***************************************************************************************************************************************************************
** Change#   Date         Author    	         Description 
** --       ---------   ------------- 	      ------------------------------------
** 1       03/01/2018     Vikram Haibate         Initial release 
** 3       30/04/2018     Surya Tiwari		 	 Added new Standalone bb logic 
** 2       31/05/2018     VIkram Haibate		 change in table names
** 3       19/06/2018     Vikram Haibate		 Dropping columns and changing logic for account_Active_length 
** 4       22/06/2018     Aaditya Padmawar		 Added Contract Status Logic
** 4       09/07/2018     Aaditya Padmawar		 Added Fix for change type
***************************************************************************************************************************************************************

-----------------------------------------------------------------------DDLS------------------------------------------------------------------------------------
dba.sp_drop_table 'Decisioning','ECONOMETRICS_BROADBAND_ORDERS'
dba.sp_create_table 'Decisioning','ECONOMETRICS_BROADBAND_ORDERS', 
   'YEAR_WEEK varchar (35) DEFAULT NULL,'
|| 'WEEK_START date DEFAULT NULL,'
|| 'CURRENCY_CODE varchar (10) DEFAULT NULL,'
|| 'RTM_LEVEL_1 varchar (50) DEFAULT NULL,'
|| 'RTM_LEVEL_2 varchar (50) DEFAULT NULL,'
|| 'RTM_LEVEL_3 varchar (50) DEFAULT NULL,'
|| 'ORDER_COMMUNICATION_TYPE varchar (10) DEFAULT NULL,'
|| 'DTV_ORDER_SALE_TYPE varchar (50) DEFAULT NULL,'
|| 'CONTACT_TYPE varchar (20) DEFAULT NULL,'
|| 'OLYMPUS_CUSTOMER smallint DEFAULT 0,'
|| 'CHANGE_TYPE varchar (20) DEFAULT NULL,'
|| 'BB_REMOVED_PRODUCT varchar (240) DEFAULT NULL,'
|| 'BB_ADDED_PRODUCT varchar (240) DEFAULT NULL,'
|| 'DSL_FIBRE varchar (5) DEFAULT NULL,'
|| 'ACTIVE_BROADBAND_LAST_12_MONTHS smallint DEFAULT 0,'
|| 'ACTIVE_BROADBAND_BEFORE_ORDER smallint DEFAULT 0,'
|| 'HOME_MOVE smallint DEFAULT 0,'
|| 'ORDER_BECAME_ACTIVE smallint DEFAULT 0,'
|| 'ACCOUNT_ACTIVE_LENGTH smallint DEFAULT 0,'
|| 'DTV_STATUS_BEFORE_ORDER varchar (20) DEFAULT NULL,'
|| 'DTV_BEFORE_ORDER smallint DEFAULT 0,'
|| 'previous_dtv smallint DEFAULT 0,'
|| 'ORDER_CANCELLED_SAME_DAY smallint DEFAULT 0,'
|| 'DTV_AFTER_ORDER smallint DEFAULT 0,'
|| 'ANY_OFFER_GIVEN smallint DEFAULT 0,'
|| 'TENURE int DEFAULT NULL, '
|| 'TV_REGION varchar (45) DEFAULT NULL,'
|| 'NUMBER_OF_ORDERS int DEFAULT 0,'
|| 'TV_OFFER_GIVEN smallint DEFAULT 0,'
|| 'COMMS_OFFER_GIVEN smallint DEFAULT 0,'
|| 'Any_new_offer_given int DEFAULT 0,'
|| 'BB_ORDER_SALE_TYPE varchar (50) DEFAULT NULL, '
||'SPORTS_ADDED smallint default 0, '
||'MOVIES_ADDED smallint default 0, '
||'SPORTS_REMOVED smallint default 0, '
||'MOVIES_REMOVED smallint default 0, '
|| 'SPOTIFY_ADDED smallint default 0,'
|| 'SPOTIFY_REMOVED smallint default 0,'
|| 'UOD_ADDED smallint default 0,'
|| 'UOD_REMOVED smallint default 0,'
||'Netflix_Added_Product varchar(30) default null, '
||'Netflix_Removed_Product varchar(30) default null, '
||'Basic_contract_status_pre_order smallint default 0, '
||'Basic_contract_subscription_item_pre_order varchar(200) default null, '
||'Add_on_contract_status_pre_order smallint default 0, '
||'Add_on_contract_subscription_item_pre_order varchar(200) default null, '
||'Talk_contract_status_pre_order smallint default 0, '
||'Talk_contract_subscription_item_pre_order varchar(200) default null, '
||'BB_contract_status_pre_order smallint default 0, '
||'BB_contract_subscription_item_pre_order varchar(200) default null, '
||'Basic_contract_status_post_order smallint default 0, '
||'Basic_contract_subscription_item_post_order varchar(200) default null, '
||'BB_contract_status_post_order smallint default 0, '
||'BB_contract_subscription_item_post_order varchar(200) default null, '
||'Talk_contract_status_post_order smallint default 0, '
||'Talk_contract_subscription_item_post_order varchar(200) default null, '
||'Add_on_contract_status_post_order smallint default 0, '
||'Add_on_contract_subscription_item_post_order varchar(200) default null'


dba.sp_drop_table 'Decisioning','ECONOMETRICS_BROADBAND_OFFERS'
dba.sp_create_table 'Decisioning','ECONOMETRICS_BROADBAND_OFFERS', 
  'YEAR_WEEK varchar (31) default null,'
||'WEEK_START date  default null,'
||'CURRENCY_CODE varchar (10) default null,'
||'RTM_LEVEL_1 varchar (50) default null,'
||'RTM_LEVEL_2 varchar (50) default null,'
||'RTM_LEVEL_3 varchar (50) default null,'
||'ORDER_COMMUNICATION_TYPE varchar (10) default null,'
||'DTV_ORDER_SALE_TYPE varchar (50) default null,'
||'CONTACT_TYPE varchar (20) default null,'
||'OLYMPUS_CUSTOMER smallint  default 0,'
||'CHANGE_TYPE varchar (20) default null,'
||'BB_REMOVED_PRODUCT varchar (240) default null,'
||'BB_ADDED_PRODUCT varchar (240) default null,'
||'DSL_FIBRE char (5) default null,'
||'ACTIVE_BROADBAND_LAST_12_MONTHS smallint  default 0,'
||'ACTIVE_BROADBAND_BEFORE_ORDER smallint  default 0,'
||'HOME_MOVE smallint  default 0,'
||'ORDER_BECAME_ACTIVE smallint  default 0,'
||'ACCOUNT_ACTIVE_LENGTH smallint  default 0,'
||'DTV_STATUS_BEFORE_ORDER varchar (20) default null,'
||'DTV_BEFORE_ORDER smallint  default 0,'
||'previous_dtv smallint  default 0,'
||'ORDER_CANCELLED_SAME_DAY smallint  default 0,'
||'DTV_AFTER_ORDER smallint  default 0,'
||'ANY_OFFER_GIVEN smallint  default 0,'
||'OFFER_SUB_TYPE varchar (80) default null,'
||'OFFER_DESCRIPTION varchar (465) default null,'
||'MONTHLY_OFFER_VALUE decimal (5,2) default null,'
||'OFFER_DURATION_MTH int  default null,'
||'TOTAL_OFFER_VALUE decimal (5,2) default null,'
||'AUTO_TRANSFER_OFFER smallint  default 0,'
||'TENURE int DEFAULT NULL, '
||'TV_REGION varchar (45) default null,'
||'NUMBER_OF_ORDERS int  default null,'
||'TV_OFFER_GIVEN smallint  default 0,'
||'COMMS_OFFER_GIVEN smallint  default 0,'
||'Any_new_offer_given int  default null,'
||'BB_ORDER_SALE_TYPE varchar (50) default null, '
||'SPORTS_ADDED smallint default 0, '
||'MOVIES_ADDED smallint default 0, '
||'SPORTS_REMOVED smallint default 0, '
||'MOVIES_REMOVED smallint default 0, '
|| 'SPOTIFY_ADDED smallint default 0,'
|| 'SPOTIFY_REMOVED smallint default 0,'
|| 'UOD_ADDED smallint default 0,'
|| 'UOD_REMOVED smallint default 0,'
||'Netflix_Added_Product varchar(30) default null, '
||'Netflix_Removed_Product varchar(30) default null, '
||'Basic_contract_status_pre_order smallint default 0, '
||'Basic_contract_subscription_item_pre_order varchar(200) default null, '
||'Add_on_contract_status_pre_order smallint default 0, '
||'Add_on_contract_subscription_item_pre_order varchar(200) default null, '
||'Talk_contract_status_pre_order smallint default 0, '
||'Talk_contract_subscription_item_pre_order varchar(200) default null, '
||'BB_contract_status_pre_order smallint default 0, '
||'BB_contract_subscription_item_pre_order varchar(200) default null, '
||'Basic_contract_status_post_order smallint default 0, '
||'Basic_contract_subscription_item_post_order varchar(200) default null, '
||'BB_contract_status_post_order smallint default 0, '
||'BB_contract_subscription_item_post_order varchar(200) default null, '
||'Talk_contract_status_post_order smallint default 0, '
||'Talk_contract_subscription_item_post_order varchar(200) default null, '
||'Add_on_contract_status_post_order smallint default 0, '
||'Add_on_contract_subscription_item_post_order varchar(200) default null'

-- Account level table just for Developers to de-bug for any issue 

dba.sp_drop_table 'Decisioning','ECONOMETRICS_BROADBAND_ORDERS_ACCOUNT_LEVEL'
dba.sp_create_table 'Decisioning','ECONOMETRICS_BROADBAND_ORDERS_ACCOUNT_LEVEL', 
   'ACCOUNT_NUMBER varchar (100) DEFAULT NULL,'
|| 'ORDER_ID varchar (100) DEFAULT NULL,'
|| 'ORDER_dt date DEFAULT NULL,'
|| 'YEAR_WEEK varchar (35) DEFAULT NULL,'
|| 'WEEK_START date DEFAULT NULL,'
|| 'CURRENCY_CODE varchar (10) DEFAULT NULL,'
|| 'RTM_LEVEL_1 varchar (50) DEFAULT NULL,'
|| 'RTM_LEVEL_2 varchar (50) DEFAULT NULL,'
|| 'RTM_LEVEL_3 varchar (50) DEFAULT NULL,'
|| 'ORDER_COMMUNICATION_TYPE varchar (10) DEFAULT NULL,'
|| 'ORDER_SALE_TYPE varchar (50) DEFAULT NULL,'
|| 'CONTACT_TYPE varchar (20) DEFAULT NULL,'
|| 'OLYMPUS_CUSTOMER smallint DEFAULT 0,'
|| 'CHANGE_TYPE varchar (20) DEFAULT NULL,'
|| 'BROADBAND_CHANGE varchar (500) DEFAULT NULL,'
|| 'BB_REMOVED_PRODUCT varchar (240) DEFAULT NULL,'
|| 'BB_ADDED_PRODUCT varchar (240) DEFAULT NULL,'
|| 'DSL_FIBRE varchar (5) DEFAULT NULL,'
|| 'ACTIVE_BROADBAND_LAST_12_MONTHS smallint DEFAULT 0,'
|| 'ACTIVE_BROADBAND_BEFORE_ORDER smallint DEFAULT 0,'
|| 'HOME_MOVE smallint DEFAULT 0,'
|| 'ORDER_BECAME_ACTIVE smallint DEFAULT 0,'
|| 'ACCOUNT_ACTIVE_LENGTH smallint DEFAULT 0,'
|| 'DTV_STATUS_BEFORE_ORDER varchar (20) DEFAULT NULL,'
|| 'DTV_BEFORE_ORDER smallint DEFAULT 0,'
|| 'previous_dtv smallint DEFAULT 0,'
|| 'same_day_cancel smallint DEFAULT 0,'
|| 'DTV_AFTER_ORDER smallint DEFAULT 0,'
|| 'ACTUAL_OFFER_STATUS varchar (15) DEFAULT NULL,'
|| 'INTENDED_OFFER_STATUS varchar (15) DEFAULT NULL,'
|| 'ANY_OFFER_FLAG smallint DEFAULT 0,'
|| 'TENURE  int DEFAULT NULL, '
|| 'TV_REGION varchar (45) DEFAULT NULL,'
|| 'TV_OFFER_FLAG smallint DEFAULT 0,'
|| 'COMMS_OFFER_FLAG smallint DEFAULT 0,'
|| 'ANY_NEW_OFFER_FLAG int DEFAULT 0,'
|| 'BB_Status varchar (50) DEFAULT NULL, '
|| 'SPORTS_ADDED smallint default 0, '
|| 'MOVIES_ADDED smallint default 0, '
|| 'SPORTS_REMOVED smallint default 0, '
|| 'MOVIES_REMOVED smallint default 0, '
|| 'SPOTIFY_ADDED smallint default 0,'
|| 'SPOTIFY_REMOVED smallint default 0,'
|| 'UOD_ADDED smallint default 0,'
|| 'UOD_REMOVED smallint default 0,'
|| 'Netflix_Added_Product varchar(30) default null, '
|| 'Netflix_Removed_Product varchar(30) default null, '
|| 'Basic_contract_status_pre_order smallint default 0, '
|| 'Basic_contract_subscription_item_pre_order varchar(200) default null, '
|| 'Add_on_contract_status_pre_order smallint default 0, '
|| 'Add_on_contract_subscription_item_pre_order varchar(200) default null, '
|| 'Talk_contract_status_pre_order smallint default 0, '
|| 'Talk_contract_subscription_item_pre_order varchar(200) default null, '
|| 'BB_contract_status_pre_order smallint default 0, '
|| 'BB_contract_subscription_item_pre_order varchar(200) default null, '
|| 'Basic_contract_status_post_order smallint default 0, '
|| 'Basic_contract_subscription_item_post_order varchar(200) default null, '
|| 'BB_contract_status_post_order smallint default 0, '
|| 'BB_contract_subscription_item_post_order varchar(200) default null, '
|| 'Talk_contract_status_post_order smallint default 0, '
|| 'Talk_contract_subscription_item_post_order varchar(200) default null, '
|| 'Add_on_contract_status_post_order smallint default 0, '
|| 'Add_on_contract_subscription_item_post_order varchar(200) default null'
*/


setuser Decisioning_Procs
GO
DROP PROCEDURE IF EXISTS Decisioning_Procs.Update_Econometrics_Broadband;
GO
create procedure Decisioning_Procs.Update_Econometrics_Broadband( PERIOD_START date default null,PERIOD_END date default null ) 
sql security invoker
begin
  set temporary option Query_Temp_Space_Limit = 0;
  commit work;
  /*
create or replace variable PERIOD_START date;
create or replace variable PERIOD_END date;
set PERIOD_START = '2017-01-01';  
set PERIOD_END =  '2017-04-20';  
*/
  set option Query_Temp_Space_Limit = 0;
  if PERIOD_START is null then
    set PERIOD_START = (select max(week_start)-4*7 from Decisioning.ECONOMETRICS_BROADBAND_ORDERS)
  end if;
  if PERIOD_END is null then
    set PERIOD_END = today()
  end if;
  drop table if exists #BROADBAND;
  select ACCOUNT_NUMBER,
    Account_Currency_Code as CURRENCY_CODE,
    CUSTOMER_SK,
    ORDER_ID,
    ORDER_NUMBER,
    ORDER_DT,
    cast(ORDER_DT-1 as date) as ORDER_DT_SoD, -- MMC add date to get product holdings at start of day
    RTM_LEVEL_1,
    RTM_LEVEL_2,
    RTM_LEVEL_3,
    ORDER_COMMUNICATION_TYPE,
    ORDER_SALE_TYPE,
    --,ORDER_TYPE
    -- Adding new logic for change_type and broadband change 
    /* ,CASE
WHEN
bb_added_product is not null and bb_Removed_product is null
THEN 'NEW'
WHEN
bb_added_product is  null and bb_Removed_product is not null
THEN 'CANCEL'
WHEN
BB_ADDED_SALETYPE NOT IN ('UNBLOCK','')
AND BB_UNLIMITED_ADDED>0
AND BB_LITE_REMOVED>0
THEN 'UPGRADE'
WHEN
BB_ADDED_SALETYPE NOT IN ('UNBLOCK','')
AND BB_UNLIMITED_ADDED>0
AND BB_FIBRE_CAP_REMOVED>0
THEN 'DOWNGRADE'
WHEN
BB_ADDED_SALETYPE NOT IN ('UNBLOCK','')
AND BB_UNLIMITED_ADDED>0
AND BB_FIBRE_UNLIMITED_REMOVED>0
THEN 'DOWNGRADE'
WHEN
BB_ADDED_SALETYPE NOT IN ('UNBLOCK','')
AND BB_UNLIMITED_ADDED>0
AND BB_FIBRE_UNLIMITED_PRO_REMOVED>0
THEN 'DOWNGRADE'
WHEN
BB_ADDED_SALETYPE NOT IN ('UNBLOCK','')
AND BB_LITE_ADDED>0
AND BB_UNLIMITED_REMOVED>0
THEN 'DOWNGRADE'
WHEN
BB_ADDED_SALETYPE NOT IN ('UNBLOCK','')
AND BB_LITE_ADDED>0
AND BB_FIBRE_CAP_REMOVED>0
THEN 'DOWNGRADE'
WHEN
BB_ADDED_SALETYPE NOT IN ('UNBLOCK','')
AND BB_LITE_ADDED>0
AND BB_FIBRE_UNLIMITED_REMOVED>0
THEN 'DOWNGRADE'
WHEN
BB_ADDED_SALETYPE NOT IN ('UNBLOCK','')
AND BB_LITE_ADDED>0
AND BB_FIBRE_UNLIMITED_PRO_REMOVED>0
THEN 'DOWNGRADE'
WHEN
BB_ADDED_SALETYPE NOT IN ('UNBLOCK','')
AND BB_FIBRE_CAP_ADDED>0
AND BB_UNLIMITED_REMOVED>0
THEN 'UPGRADE'
WHEN
BB_ADDED_SALETYPE NOT IN ('UNBLOCK','')
AND BB_FIBRE_CAP_ADDED>0
AND BB_LITE_REMOVED>0
THEN 'UPGRADE'
WHEN
BB_ADDED_SALETYPE NOT IN ('UNBLOCK','')
AND BB_FIBRE_CAP_ADDED>0
AND BB_FIBRE_UNLIMITED_REMOVED>0
THEN 'DOWNGRADE'
WHEN
BB_ADDED_SALETYPE NOT IN ('UNBLOCK','')
AND BB_FIBRE_CAP_ADDED>0
AND BB_FIBRE_UNLIMITED_PRO_REMOVED>0
THEN 'DOWNGRADE'
WHEN
BB_ADDED_SALETYPE NOT IN ('UNBLOCK','')
AND BB_FIBRE_UNLIMITED_ADDED>0
AND BB_UNLIMITED_REMOVED>0
THEN 'UPGRADE'
WHEN
BB_ADDED_SALETYPE NOT IN ('UNBLOCK','')
AND BB_FIBRE_UNLIMITED_ADDED>0
AND BB_LITE_REMOVED>0
THEN 'UPGRADE'
WHEN
BB_ADDED_SALETYPE NOT IN ('UNBLOCK','')
AND BB_FIBRE_UNLIMITED_ADDED>0
AND BB_FIBRE_CAP_REMOVED>0
THEN 'UPGRADE'
WHEN
BB_ADDED_SALETYPE NOT IN ('UNBLOCK','')
AND BB_FIBRE_UNLIMITED_ADDED>0
AND BB_FIBRE_UNLIMITED_PRO_REMOVED>0
THEN 'DOWNGRADE'
WHEN
BB_ADDED_SALETYPE NOT IN ('UNBLOCK','')
AND BB_FIBRE_UNLIMITED_PRO_ADDED>0
AND BB_UNLIMITED_REMOVED>0
THEN 'UPGRADE'
WHEN
BB_ADDED_SALETYPE NOT IN ('UNBLOCK','')
AND BB_FIBRE_UNLIMITED_PRO_ADDED>0
AND BB_LITE_REMOVED>0
THEN 'UPGRADE'
WHEN
BB_ADDED_SALETYPE NOT IN ('UNBLOCK','')
AND BB_FIBRE_UNLIMITED_PRO_ADDED>0
AND BB_FIBRE_CAP_REMOVED>0
THEN 'UPGRADE'
WHEN
BB_ADDED_SALETYPE NOT IN ('UNBLOCK','')
AND BB_FIBRE_UNLIMITED_PRO_ADDED>0
AND BB_FIBRE_UNLIMITED_REMOVED>0
THEN 'UPGRADE'

ELSE BB_ADDED_SALETYPE
END AS */
    cast(null as varchar(20)) as CHANGE_TYPE,
    case when BB_ADDED_SALETYPE not in( 'UNBLOCK','' ) 
    and COALESCE(BB_ADDED_PRODUCT,'') <> ''
    and COALESCE(BB_REMOVED_PRODUCT,'') <> '' then BB_REMOVED_PRODUCT || ' TO ' || BB_ADDED_PRODUCT
    when bb_removed_product is null then bb_added_product || ' Added'
    when bb_added_product is null then bb_removed_product || ' Removed'
    else 'BROADBAND CHANGED'
    end as BROADBAND_CHANGE,
    case when BB_ADDED_PRODUCT = 'Sky Broadband Everyday' then 1
    when BB_ADDED_PRODUCT = 'Sky Broadband Lite' then 2
    when BB_ADDED_PRODUCT = 'Sky Broadband 12GB' then 3
    when BB_ADDED_PRODUCT = 'Broadband Connect' then 4
    when BB_ADDED_PRODUCT = 'Sky Broadband Unlimited' then 5
    when BB_ADDED_PRODUCT = 'Sky Broadband Unlimited (ROI)' then 5
    when BB_ADDED_PRODUCT = 'Sky Broadband Unlimited (ROI - Legacy)' then 5
    when BB_ADDED_PRODUCT = 'Sky Broadband Unlimited Pro' then 6
    when BB_ADDED_PRODUCT = 'Sky Fibre Lite' then 7
    when BB_ADDED_PRODUCT = 'Sky Fibre' then 8
    when BB_ADDED_PRODUCT = 'Sky Broadband Unlimited Fibre' then 9
    when BB_ADDED_PRODUCT = 'Sky Fibre Unlimited Plus' then 10
    when BB_ADDED_PRODUCT = 'Sky Fibre Unlimited Pro' then 11
    when BB_ADDED_PRODUCT = 'Sky Fibre Max' then 12 end as Added,
    case when BB_REMOVED_PRODUCT = 'Sky Broadband Everyday' then 1
    when BB_REMOVED_PRODUCT = 'Sky Broadband Lite' then 2
    when BB_REMOVED_PRODUCT = 'Sky Broadband 12GB' then 3
    when BB_REMOVED_PRODUCT = 'Broadband Connect' then 4
    when BB_REMOVED_PRODUCT = 'Sky Broadband Unlimited' then 5
    when BB_REMOVED_PRODUCT = 'Sky Broadband Unlimited (ROI)' then 5
    when BB_REMOVED_PRODUCT = 'Sky Broadband Unlimited (ROI - Legacy)' then 5
    when BB_REMOVED_PRODUCT = 'Sky Broadband Unlimited Pro' then 6
    when BB_REMOVED_PRODUCT = 'Sky Fibre Lite' then 7
    when BB_REMOVED_PRODUCT = 'Sky Fibre' then 8
    when BB_REMOVED_PRODUCT = 'Sky Broadband Unlimited Fibre' then 9
    when BB_REMOVED_PRODUCT = 'Sky Fibre Unlimited Plus' then 10
    when BB_REMOVED_PRODUCT = 'Sky Fibre Unlimited Pro' then 11
    when BB_REMOVED_PRODUCT = 'Sky Fibre Max' then 12 end as Removed,
    BB_ADDED_SALETYPE,
    BB_REMOVED_PRODUCT,
    BB_ADDED_PRODUCT,
    0 as PREVIOUS_ACTIVE_BROADBAND,
    0 as ACTIVE_BROADBAND_LAST_30_DAYS,
    0 as ACTIVE_BROADBAND_LAST_12_MONTHS,
    0 as ACTIVE_BROADBAND_BEFORE_ORDER,
    0 as HOME_MOVE,
    0 as ORDER_BECAME_ACTIVE,
    0 as ACCOUNT_ACTIVE_LENGTH,
    cast(null as varchar(20)) as DTV_STATUS_BEFORE_ORDER,
    0 as DTV_BEFORE_ORDER,
    0 as previous_dtv,
    0 as same_day_cancel,
    0 as DTV_AFTER_ORDER,
    0 as PRE_ORDER_BB_STATUS_PA,
    SPORTS_ADDED,
    MOVIES_ADDED,
    FAMILY_ADDED,
    VARIETY_ADDED,
    ORIGINAL_ADDED,
    SKYQ_ADDED,
    HD_LEGACY_ADDED,
    HD_BASIC_ADDED,
    HD_PREMIUM_ADDED,
    MULTISCREEN_ADDED,
    MULTISCREEN_PLUS_ADDED,
    SKY_PLUS_ADDED,
    SKY_GO_EXTRA_ADDED,
    NOW_TV_ADDED,
    BB_UNLIMITED_ADDED,
    BB_LITE_ADDED,
    BB_FIBRE_CAP_ADDED,
    BB_FIBRE_UNLIMITED_ADDED,
    BB_FIBRE_UNLIMITED_PRO_ADDED,
    TALKU_ADDED,
    TALKW_ADDED,
    TALKF_ADDED,
    TALKA_ADDED,
    TALKP_ADDED,
    TALKO_ADDED,
    SPORTS_REMOVED,
    MOVIES_REMOVED,
    FAMILY_REMOVED,
    VARIETY_REMOVED,
    ORIGINAL_REMOVED,
    SKYQ_REMOVED,
    HD_LEGACY_REMOVED,
    HD_BASIC_REMOVED,
    HD_PREMIUM_REMOVED,
    MULTISCREEN_REMOVED,
    MULTISCREEN_PLUS_REMOVED,
    SKY_PLUS_REMOVED,
    SKY_GO_EXTRA_REMOVED,
    NOW_TV_REMOVED,
    BB_UNLIMITED_REMOVED,
    BB_LITE_REMOVED,
    BB_FIBRE_CAP_REMOVED,
    BB_FIBRE_UNLIMITED_REMOVED,
    BB_FIBRE_UNLIMITED_PRO_REMOVED,
    TALKU_REMOVED,
    TALKW_REMOVED,
    TALKF_REMOVED,
    TALKA_REMOVED,
    TALKP_REMOVED,
    TALKO_REMOVED,
    0 as OLYMPUS_CUSTOMER,
    cast(null as varchar(20)) as CONTACT_TYPE,
    cast(null as varchar(15)) as ACTUAL_OFFER_STATUS,
    cast(null as varchar(15)) as INTENDED_OFFER_STATUS,
    0 as ANY_OFFER_FLAG,
    0 as TV_OFFER_FLAG,
    0 as COMMS_OFFER_FLAG,
    -- MMC New Offer Fields            
    cast(null as date) as Prev_Offer_Start_Dt_Any,
    cast(null as date) as Prev_Offer_Intended_end_Dt_Any,
    cast(null as date) as Prev_Offer_Actual_End_Dt_Any,
    cast(null as date) as Curr_Offer_Start_Dt_Any,
    cast(null as date) as Curr_Offer_Intended_end_Dt_Any,
    cast(null as date) as Curr_Offer_Actual_End_Dt_Any,
    cast(null as varchar(30)) as Offer_End_Status_Level_1,
    cast(null as varchar(30)) as Offer_End_Status_Level_2,
    cast(null as tinyint) as Offers_Applied_Lst_1D_Any,
    cast(null as tinyint) as Offers_Applied_Lst_1D_DTV,
    cast(null as tinyint) as Offers_Applied_Lst_1D_BB,
    cast(null as tinyint) as Offers_Applied_Lst_1D_LR,
    cast(null as tinyint) as Offers_Applied_Lst_1D_Talk,
    cast(0 as integer) as ANY_NEW_OFFER_FLAG,
    cast(0 as integer) as NEW_DTV_PRIMARY_VIEWING_OFFER,
    cast(0 as integer) as BB_Acquisition,
    cast(null as date) as DTV_Created_Date,
    cast(null as varchar(50)) as BB_Status,
    1 as Orders,
    0 as Existing_BB,
    0 as Existing_AP_AC,
    0 as Existing_PC_AC,
    0 as Existing_PA_AP,
    0 as Existing_AB_AC,
    0 as Existing_TV_Active,
    0 as Existing_TV_Order,
    --- Up To 56 Days Before BB Order
    0 as New_TV_Order,
    0 as TV_Churn,
    0 as SABB,
    case when((BB_added_product is not null and BB_removed_product is null)
    or(BB_added_product is not null and BB_removed_product is not null and BB_added_product = BB_removed_product)
    or(BB_added_product <> BB_removed_product and BB_ADDED_SALETYPE = 'NEW')) then 1 else 0 end as BB_Upgrade_Orders,
    DTV_ADDED_PRODUCT,
    KIDS_ADDED,
    BOXSETS_ADDED,
    SPOTIFY_ADDED,
    SPOTIFY_REMOVED,
    UOD_ADDED,
    UOD_REMOVED,
    Netflix_Standard_Added,
    Netflix_Standard_Removed,
    Netflix_Premium_Added,
    Netflix_Premium_Removed
    into #BROADBAND
    from CITeam.Orders_Daily
    where order_dt >= period_start
    and order_dt <= period_end
    -- and (bb_added_product is not null or bb_Removed_product is not null)
    and((BB_added_product is not null and BB_removed_product is null)
    or(BB_added_product is not null and BB_removed_product is not null and BB_added_product = BB_removed_product)
    or(BB_added_product <> BB_removed_product and BB_ADDED_SALETYPE = 'NEW'));
  update #BROADBAND
    set CHANGE_TYPE = case when bb_added_product is not null and bb_Removed_product is null then 'NEW'
    when bb_added_product is null and bb_Removed_product is not null then 'CANCEL'
    when BB_ADDED_SALETYPE not in( 'UNBLOCK','' ) and added > Removed then 'UPGRADE'
    when BB_ADDED_SALETYPE not in( 'UNBLOCK','' ) and added < Removed then 'DOWNGRADE'
    when BB_ADDED_SALETYPE not in( 'UNBLOCK','' ) and added = Removed then 'UNCHANGED'
    else 'UNKNOWN'
    end from #BROADBAND;
  update #BROADBAND
    set same_day_cancel = case when coalesce(bb_added_product,'') = coalesce(bb_removed_product,'') then 1 else 0 end from
    #BROADBAND;
  -- Set BB Acquisition
  update #BROADBAND as bb
    set bb.BB_Acquisition = case when csh.order_id is not null then 1 else 0 end from
    #BROADBAND as bb
    -- AND B.Status_Code_Changed = 'Y'
    --AND B.STATUS_CODE in ('AC','PC','AB','BCRQ')
    left outer join(select order_id,ACCOUNT_NUMBER,effective_from_dt from cust_subs_hist as B
      where B.subscription_sub_type in( 'Broadband DSL Line' ) 
      and B.effective_from_dt < B.effective_to_dt
      and B.owning_cust_account_id > '1'
      and B.SI_Latest_Src = 'CHORD'
      and effective_from_dt > '2012-01-01'
      group by order_id,ACCOUNT_NUMBER,effective_from_dt) as csh
    on bb.ACCOUNT_NUMBER = csh.ACCOUNT_NUMBER
    and bb.ORDER_ID = csh.ORDER_ID;
  call Decisioning_Procs.Add_Offers_Software('#BROADBAND','ORDER_DT_SoD','Any','Ordered','All',null,'Update Only',
  'Prev_Offer_Start_Dt_Any','Prev_Offer_Intended_end_Dt_Any','Prev_Offer_Actual_End_Dt_Any',
  'Curr_Offer_Start_Dt_Any','Curr_Offer_Intended_end_Dt_Any','Curr_Offer_Actual_End_Dt_Any');
  call Decisioning_Procs.Add_Offers_Software('#BROADBAND','ORDER_DT','Any','Ordered','New',null,'Update Only','Offers_Applied_Lst_1D_Any');
  -- Offers for DTV
  call Decisioning_Procs.Add_Offers_Software('#BROADBAND','ORDER_DT','DTV','Ordered','New',null,'Update Only','Offers_Applied_Lst_1D_DTV');
  update #BROADBAND
    set ANY_NEW_OFFER_FLAG = case when Offers_Applied_Lst_1D_Any > 0 then 1 else 0 end,
    NEW_DTV_PRIMARY_VIEWING_OFFER = case when Offers_Applied_Lst_1D_DTV > 0 then 1 else 0 end;
  update #BROADBAND
    set Offers_Applied_Lst_1D_Any = 0,
    Offers_Applied_Lst_1D_DTV = 0;
  commit work;
  -- Offers for All
  call Decisioning_Procs.Add_Offers_Software('#BROADBAND','ORDER_DT','Any','Ordered','All',null,'Update Only','Offers_Applied_Lst_1D_Any');
  -- Offers for DTV
  call Decisioning_Procs.Add_Offers_Software('#BROADBAND','ORDER_DT','DTV','Ordered','All',null,'Update Only','Offers_Applied_Lst_1D_DTV');
  -- Offers for BB
  call Decisioning_Procs.Add_Offers_Software('#BROADBAND','ORDER_DT','Broadband','Ordered','All',null,'Update Only','Offers_Applied_Lst_1D_BB');
  -- Offers for LR
  call Decisioning_Procs.Add_Offers_Software('#BROADBAND','ORDER_DT','Line Rental','Ordered','All',null,'Update Only','Offers_Applied_Lst_1D_LR');
  -- Offers for Talk
  call Decisioning_Procs.Add_Offers_Software('#BROADBAND','ORDER_DT','Talk','Ordered','All',null,'Update Only','Offers_Applied_Lst_1D_Talk');
  update #BROADBAND
    set Offer_End_Status_Level_2
     = case when Curr_Offer_Intended_end_Dt_Any between(ORDER_DT_SoD+1) and(ORDER_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
    when Curr_Offer_Intended_end_Dt_Any between(ORDER_DT_SoD+8) and(ORDER_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
    when Curr_Offer_Intended_end_Dt_Any between(ORDER_DT_SoD+15) and(ORDER_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
    when Curr_Offer_Intended_end_Dt_Any between(ORDER_DT_SoD+22) and(ORDER_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_Any between(ORDER_DT_SoD+29) and(ORDER_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_Any between(ORDER_DT_SoD+36) and(ORDER_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_Any > (ORDER_DT_SoD+42) then 'Offer Ending in 7+ Wks'
    when Prev_Offer_Actual_End_Dt_Any between(ORDER_DT_SoD-7) and ORDER_DT_SoD then 'Offer Ended in last 1 Wks'
    when Prev_Offer_Actual_End_Dt_Any between(ORDER_DT_SoD-14) and(ORDER_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
    when Prev_Offer_Actual_End_Dt_Any between(ORDER_DT_SoD-21) and(ORDER_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
    when Prev_Offer_Actual_End_Dt_Any between(ORDER_DT_SoD-28) and(ORDER_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_Any between(ORDER_DT_SoD-35) and(ORDER_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_Any between(ORDER_DT_SoD-42) and(ORDER_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_Any < (ORDER_DT_SoD-42) then 'Offer Ended 7+ Wks'
    else 'No Offer'
    end;
  update #BROADBAND
    set Offer_End_Status_Level_1
     = case when Offer_End_Status_Level_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when Offer_End_Status_Level_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  commit work;
  -----------------------------------------------------------------------------------------------
  --Flag If Customer has had Active Broadband before Order previously and If they Had Active Broadband in last 30 days and 12 months before order
  update #BROADBAND as A
    set A.PREVIOUS_ACTIVE_BROADBAND = B.bb_Active_subscription,
    A.ACTIVE_BROADBAND_BEFORE_ORDER = B.bb_Active_subscription,
    A.ACTIVE_BROADBAND_LAST_30_DAYS = case when B.EFFECTIVE_TO_DT >= (A.ORDER_DT-30) then 1 else 0 end,
    A.ACTIVE_BROADBAND_LAST_12_MONTHS = case when B.EFFECTIVE_TO_DT >= (A.ORDER_DT-365) then 1 else 0 end from
    #BROADBAND as A
    join CITEAM.ACTIVE_SUBSCRIBER_REPORT as B
    on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    where A.order_dt-1 between B.effective_from_dt and B.effective_to_dt-1
    and B.BB_Active_subscription = 1;
  -- DTV Before Order
  update #BROADBAND as A
    set A.DTV_STATUS_BEFORE_ORDER = B.STATUS_CODE,
    A.DTV_BEFORE_ORDER = 1 from
    #BROADBAND as A
    join CITEam.active_subscriber_report as B
    on A.account_number = B.Account_number
    where A.ORDER_DT-1 between B.effective_from_dt and B.effective_to_dt-1
    and B.Status_Code in( 'AB','AC','PC' ) ;
  -- *********************************************************************************************
  -- Set BB Standalone status
  -- *********************************************************************************************
  update #BROADBAND as a
    set existing_bb = 1 from
    #BROADBAND as a
    join(select a.account_number,
      a.order_dt
      from #BROADBAND as a
        join cust_subs_hist as b
        on a.account_number = b.account_number
        and b.effective_from_dt < a.order_dt
        and b.effective_to_dt > a.order_dt
      where a.BB_Upgrade_Orders = 1
      and b.subscription_sub_type = 'Broadband DSL Line'
      and b.status_code in( 'AC' ) 
      group by a.account_number,
      a.order_dt) as b
    on a.account_number = b.account_number
    and a.order_dt = b.order_dt
    where a.BB_Upgrade_Orders = 1;
  update #BROADBAND as a
    set existing_pa_ap = 1 from
    #BROADBAND as a
    join(select a.account_number,
      a.order_dt
      from #BROADBAND as a
        join cust_subs_hist as b
        on a.account_number = b.account_number
        and b.effective_from_dt = a.order_dt
      where a.BB_Upgrade_Orders = 1
      and b.subscription_sub_type = 'Broadband DSL Line'
      and b.status_code = 'AP'
      and b.prev_status_code = 'PA'
      and status_code_changed = 'Y'
      group by a.account_number,
      a.order_dt) as b
    on a.account_number = b.account_number
    and a.order_dt = b.order_dt
    where a.BB_Upgrade_Orders = 1;
  update #BROADBAND as a
    set existing_ap_ac = 1 from
    #BROADBAND as a
    join(select a.account_number,
      a.order_dt
      from #BROADBAND as a
        join cust_subs_hist as b
        on a.account_number = b.account_number
        and b.effective_from_dt = a.order_dt
      where a.BB_Upgrade_Orders = 1
      and b.subscription_sub_type = 'Broadband DSL Line'
      and b.status_code = 'AC'
      and b.prev_status_code in( 'AP' ) 
      group by a.account_number,
      a.order_dt) as b
    on a.account_number = b.account_number
    and a.order_dt = b.order_dt
    where a.BB_Upgrade_Orders = 1;
  update #BROADBAND as a
    set existing_pc_ac = 1 from
    #BROADBAND as a
    join(select a.account_number,
      a.order_dt
      from #BROADBAND as a
        join cust_subs_hist as b
        on a.account_number = b.account_number
        and b.effective_from_dt = a.order_dt
      where a.BB_Upgrade_Orders = 1
      and b.subscription_sub_type = 'Broadband DSL Line'
      and b.status_code = 'AC'
      and b.prev_status_code in( 'PC' ) 
      group by a.account_number,
      a.order_dt) as b
    on a.account_number = b.account_number
    and a.order_dt = b.order_dt
    where a.BB_Upgrade_Orders = 1;
  update #BROADBAND as a
    set existing_ab_ac = 1 from
    #BROADBAND as a
    join(select a.account_number,
      a.order_dt
      from #BROADBAND as a
        join cust_subs_hist as b
        on a.account_number = b.account_number
        and b.effective_from_dt = a.order_dt
      where a.BB_Upgrade_Orders = 1
      and b.subscription_sub_type = 'Broadband DSL Line'
      and b.status_code = 'AC'
      and b.prev_status_code = 'AB'
      group by a.account_number,
      a.order_dt) as b
    on a.account_number = b.account_number
    and a.order_dt = b.order_dt
    where a.BB_Upgrade_Orders = 1;
  update #BROADBAND as a
    set existing_tv_active = 1 from
    #BROADBAND as a
    join(select a.account_number,
      a.order_dt
      from #BROADBAND as a
        join cust_subs_hist as b
        on a.account_number = b.account_number
        and b.effective_from_dt <= a.order_dt
        and b.effective_to_dt > a.order_dt
      where a.BB_Upgrade_Orders = 1
      and b.subscription_sub_type = 'DTV Primary Viewing'
      and b.status_code in( 'AC','AB','PC' ) 
      group by a.account_number,
      a.order_dt) as b
    on a.account_number = b.account_number
    and a.order_dt = b.order_dt
    where a.BB_Upgrade_Orders = 1;
  update #BROADBAND as a
    set existing_tv_order = 1 from
    #BROADBAND as a
    join(select a.account_number,
      a.order_dt
      from #BROADBAND as a
        join cust_subs_hist as b
        on a.account_number = b.account_number
        and b.effective_from_dt between(a.order_dt-56) and(a.order_dt-1)
      where a.BB_Upgrade_Orders = 1
      and b.subscription_sub_type = 'DTV Primary Viewing'
      and b.status_code in( 'IT','EN','SU' ) 
      group by a.account_number,
      a.order_dt) as b
    on a.account_number = b.account_number
    and a.order_dt = b.order_dt
    where a.BB_Upgrade_Orders = 1;
  update #BROADBAND as a
    set new_tv_order = 1 from
    #BROADBAND as a
    join(select a.account_number,
      a.order_dt
      from #BROADBAND as a
        join cust_subs_hist as b
        on a.account_number = b.account_number
        and b.effective_from_dt = a.order_dt
      where a.BB_Upgrade_Orders = 1
      and b.subscription_sub_type = 'DTV Primary Viewing'
      and b.status_code in( 'IT','EN','SU' ) 
      group by a.account_number,
      a.order_dt) as b
    on a.account_number = b.account_number
    and a.order_dt = b.order_dt
    where a.BB_Upgrade_Orders = 1;
  update #BROADBAND as a
    set tv_churn = 1 from
    #BROADBAND as a
    join(select a.account_number,
      a.order_dt
      from #BROADBAND as a
        join cust_subs_hist as b
        on a.account_number = b.account_number
        and b.effective_from_dt <= a.order_dt
      where a.BB_Upgrade_Orders = 1
      and b.subscription_sub_type = 'DTV Primary Viewing'
      and b.status_code in( 'PO','SC' ) 
      and b.prev_status_code in( 'AC','AB','PC' ) 
      and b.status_code_changed = 'Y'
      group by a.account_number,
      a.order_dt) as b
    on a.account_number = b.account_number
    and a.order_dt = b.order_dt
    where a.BB_Upgrade_Orders = 1;
  update #BROADBAND
    set BB_Status
     = case when existing_bb = 1 then 'A.Existing BB'
    when existing_ap_ac = 1 then 'B1. AP-->AC'
    when existing_pa_ap = 1 then 'B2. PA-->AP'
    when existing_pc_ac = 1 then 'B3. PC-->AC'
    when existing_ab_ac = 1 then 'C. AB-->AC'
    when existing_tv_active = 1 then 'D1. Existing Upgrades'
    when existing_tv_order = 1 then 'D2.TV Order Pending Upgrades'
    when new_tv_order = 1 then 'E. New Sale'
    when tv_churn = 1 then 'F.SABB'
    else 'F.SABB'
    end
    where BB_Upgrade_Orders = 1;
  -- *********************************************************************************************
  -- To check previous DTV subs ever
  update #BROADBAND as A
    set A.Previous_DTV = 1 from
    #BROADBAND as A
    join CITeam.Active_Subscriber_Report as B
    on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    where A.ORDER_DT-1 >= B.effective_from_dt
    and B.DTV_Active = 1;
  --Flag If Customer had DTV After Order and Active BB at time of order
  --get all orders on the day
  drop table if exists #BROADBAND_DTV2;
  select A.ACCOUNT_NUMBER,
    A.ORDER_DT,
    SUM(B.FAMILY_ADDED+B.VARIETY_ADDED+B.ORIGINAL_ADDED+B.SKYQ_ADDED+case when B.dtv_added_product like '%Sky Entertainment%' then 1 else 0 end) as DTV_ADDED,
    SUM(B.FAMILY_REMOVED+B.VARIETY_REMOVED+B.ORIGINAL_REMOVED+B.SKYQ_REMOVED+case when B.dtv_removed_product like '%Sky Entertainment%' then 1 else 0 end) as DTV_REMOVED
    into #BROADBAND_DTV2
    from #BROADBAND as A
      left outer join CITEAM.Orders_Daily as B
      on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and A.ORDER_DT = B.ORDER_DT
    where(B.dtv_Added_product is not null or B.Dtv_removed_product is not null)
    group by A.ACCOUNT_NUMBER,A.ORDER_DT;
  ---------New logic for after order
  update #BROADBAND as A
    set A.DTV_AFTER_ORDER = case when B.status_code is null
    and coalesce(C.DTV_ADDED,0) >= 1
    and coalesce(C.DTV_ADDED,0) <> coalesce(C.DTV_REMOVED,0) then
      1
    when B.status_code is null
    and coalesce(C.DTV_ADDED,0) = coalesce(C.DTV_REMOVED,0) then
      0
    when B.status_code is not null
    and coalesce(C.DTV_ADDED,0) = coalesce(C.DTV_REMOVED,0) then
      1
    when B.status_code is not null
    and coalesce(C.DTV_ADDED,0) < coalesce(C.DTV_REMOVED,0) then
      0
    when B.status_code is not null then 1
    else 0
    end from
    #BROADBAND as A
    left outer join #BROADBAND_DTV2 as C
    on A.ACCOUNT_NUMBER = C.ACCOUNT_NUMBER
    and A.ORDER_DT = C.ORDER_DT
    -- sti18.ASR_NEW B
    join CITeam.Active_Subscriber_Report as B
    on A.Account_number = B.ACCOUNT_NUMBER
    and A.ORDER_DT between effective_from_dt and effective_to_dt
    -- and A.order_dt-1 between B.effective_from_dt and B.effective_to_dt-2 
    and B.DTV_Active = 1
    where B.Status_Code in( 'AB','AC','PC' ) ;
  --FLAG if Order was activated by Order date
  drop table if exists #BB_ORDER;
  select A.ACCOUNT_NUMBER,
    A.ORDER_ID,
    A.ORDER_DT,
    coalesce(MIN(B.ORDER_DT),'9999-09-09') as NEXT_ORDER_DT
    into #BB_ORDER
    from #BROADBAND as A
      left outer join #BROADBAND as B
      on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and A.ORDER_DT < B.ORDER_DT
    group by A.ACCOUNT_NUMBER,
    A.ORDER_ID,
    A.ORDER_DT;
  drop table if exists #BROADBAND_UPDATE;
  select A.*
    into #BROADBAND_UPDATE
    from #BB_ORDER as A
      join CITEam.active_subscriber_report as B
      on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    where B.EFFECTIVE_FROM_DT between A.ORDER_DT and A.NEXT_ORDER_DT
    and B.bb_Active_subscription = 1;
  update #BROADBAND as A
    set A.ORDER_BECAME_ACTIVE = 1 from
    #BROADBAND_UPDATE as B
    where A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT = B.ORDER_DT;
  --FLAG how long the account was active after the Order
  drop table if exists #ACCOUNT_ACTIVE;
  select A.ACCOUNT_NUMBER,
    A.ORDER_DT,
    coalesce(MIN(B.EFFECTIVE_FROM_DT),TODAY()) as ACTIVE_DT
    into #ACCOUNT_ACTIVE
    from #BROADBAND as A
      left outer join CITEAM.Active_subscriber_report as B
      on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and A.ORDER_DT < B.EFFECTIVE_TO_DT
      and B.bb_Active_subscription = 1
    group by A.ACCOUNT_NUMBER,
    A.ORDER_DT;
  drop table if exists #bb1;
  select account_number,effective_from_dt,effective_to_dt
    into #bb1
    from CITEAM.Active_subscriber_report as B
    where bb_active_subscription = 1
    order by account_number asc,effective_from_dt asc,effective_to_dt asc;
  drop table if exists #bb2;
  select account_number,effective_from_dt,effective_to_dt,LEAD(effective_from_dt,1) over(partition by ACCOUNT_NUMBER order by effective_from_dt asc) as SORT_Lead,
    case when(SORT_Lead <> effective_to_dt or SORT_Lead is null) then 1 else 0 end as error,
    case when error = 1 then effective_to_dt else null end as max_effective_to_dt
    into #bb2
    from #bb1
    order by effective_from_dt asc;
  drop table if exists #bb3;
  select *,row_number() over(partition by account_number order by max_effective_to_dt desc) as row_num
    into #bb3
    from #bb2
    where error = 1;
  drop table if exists #bb_final;
  select aa.account_number,aa.effective_from_dt,aa.effective_to_dt,aa.sort_lead,aa.error,aa.max_effective_to_dt,count() as row_num
    into #bb_final
    from #bb2 as aa
      join #bb3 as bb
      on aa.account_number = bb.account_number
      and aa.effective_to_dt <= bb.max_effective_to_dt
    where aa.error = 0
    group by aa.account_number,aa.effective_from_dt,aa.effective_to_dt,aa.sort_lead,aa.error,aa.max_effective_to_dt;
  update #bb_final as aa
    set aa.max_effective_to_dt = bb.max_effective_to_dt from
    #bb_final as aa
    join #bb3 as bb
    on aa.account_number = bb.account_number
    and aa.row_num = bb.row_num;
  insert into #bb_final
    select account_number,effective_from_dt,effective_to_dt,sort_lead,error,max_effective_to_dt,0 as row
      from #bb2
      where error = 1;
  drop table if exists #ACCOUNT_ACTIVE2;
  select A.ACCOUNT_NUMBER,
    A.ORDER_DT,
    A.ACTIVE_DT,
    case when(ACTIVE_DT = today() or B.max_effective_to_dt = '9999-09-09') then today() else B.max_effective_to_dt end as NOT_ACTIVE_DT
    into #ACCOUNT_ACTIVE2
    from #ACCOUNT_ACTIVE as A
      left outer join #bb_final as B
      on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and A.ACTIVE_DT = B.EFFECTIVE_FROM_DT;
  drop table if exists #ACCOUNT_ACTIVE3;
  select *,
    (NOT_ACTIVE_DT-ACTIVE_DT)/30 as ACCOUNT_ACTIVE_LENGTH
    into #ACCOUNT_ACTIVE3
    from #ACCOUNT_ACTIVE2;
  update #BROADBAND as A
    set A.ACCOUNT_ACTIVE_LENGTH = B.ACCOUNT_ACTIVE_LENGTH from
    #ACCOUNT_ACTIVE3 as B
    where A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT = B.ORDER_DT;
  commit work;
  --FLAG HOME MOVES
  -- BROADBAND PACK LOGIC
  drop table if exists #HOME_MOVE;
  select distinct account_number,
    address_role,
    change_reason,
    ad_created_dt,
    ad_effective_from_dt,
    ad_effective_to_dt
    into #HOME_MOVE
    from CUST_ALL_ADDRESS
    where address_role = 'INSTALL'
    and change_reason in( 'Move Home With Install','Move Home Without Install' ) ;
  commit work;
  update #BROADBAND as A
    set A.HOME_MOVE = case when B.ACCOUNT_NUMBER is not null
    or C.ACCOUNT_NUMBER is not null then
      1 else 0 end from
    #BROADBAND as A
    left outer join #HOME_MOVE as B
    on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT = B.ad_created_dt
    left outer join #HOME_MOVE as C
    on A.ACCOUNT_NUMBER = C.ACCOUNT_NUMBER
    and A.ORDER_DT = C.ad_effective_from_dt;
  commit work;
  --FLAG OLYMPUS CUSTOMERS
  update #BROADBAND as base
    set base.OLYMPUS_CUSTOMER = 1 from
    CUST_ACCOUNT_SEGMENT as cas
    where base.account_number = cas.account_number
    and cas.segment_code in( '146','150' )  --added by sharon 06/14 olympus customer codes from onboarding
    and cas.deleted = '0'; -- this table has dupes, shows all records deleted and not deleted
  commit work;
  -- ADD ON WHAT TYPE OF CALL THE ORDER CAME IN ON
  drop table if exists #BROADBAND_CONTACT_TYPE;
  select distinct
    A.ACCOUNT_NUMBER,
    A.ORDER_DT,
    A.ORDER_COMMUNICATION_TYPE,
    MIN(case when C.ACCOUNT_NUMBER is not null then '1.TA'
    when D.ACCOUNT_NUMBER is not null then '2.PAT'
    when SUBSTRING(B.contact_channel,1,1) = 'I' then '3.INBOUND '+A.ORDER_COMMUNICATION_TYPE
    when SUBSTRING(B.contact_channel,1,1) = 'O' then '4.OUTBOUND '+A.ORDER_COMMUNICATION_TYPE
    else '5. '+A.ORDER_COMMUNICATION_TYPE
    end) as CONTACT_TYPE
    into #BROADBAND_CONTACT_TYPE
    from #BROADBAND as A
      left outer join cust_contact as B
      on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and A.ORDER_DT = B.CREATED_DATE
      left outer join cust_change_attempt as C
      on A.ACCOUNT_NUMBER = C.ACCOUNT_NUMBER
      and A.ORDER_DT = C.CREATED_DT
      and C.change_attempt_type = 'CANCELLATION ATTEMPT'
      and C.created_by_id not in( 'dpsbtprd','batchuser' ) 
      and C.subscription_sub_type in( 'DTV Primary Viewing' ) 
      and C.Wh_Attempt_Outcome_Description_1 in( 'Turnaround Saved',
      'Legacy Save',
      'Turnaround Not Saved',
      'Legacy Fail',
      'Home Move Saved',
      'Home Move Not Saved',
      'Home Move Accept Saved' ) 
      left outer join cust_change_attempt as D
      on A.ACCOUNT_NUMBER = D.ACCOUNT_NUMBER
      and A.ORDER_DT = D.CREATED_DT
      and D.change_attempt_type = 'DOWNGRADE ATTEMPT'
      and D.subscription_sub_type = 'DTV Primary Viewing'
      and D.created_by_id not in( 'dpsbtprd','batchuser' ) 
      and D.Wh_Attempt_Outcome_Description_1 in( 'PAT No Save','PAT Partial Save','PAT Save' ) 
      and D.Wh_Attempt_Reason_Description_1 <> 'Turnaround'
    group by A.ACCOUNT_NUMBER,A.ORDER_DT,A.ORDER_COMMUNICATION_TYPE;
  commit work;
  --UPDATE BROADBAND TABLE
  update #BROADBAND as A
    set A.CONTACT_TYPE = B.CONTACT_TYPE from
    #BROADBAND_CONTACT_TYPE as B
    where A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT = B.ORDER_DT;
  commit work;
  --ADD ON WHETHER THE ACCOUNT HAS PERFORMED THE SAME BUNDLE CHANGE BEFORE
  -- Create temp table for 
  drop table if exists #BROADBAND_TEMP;
  select aa.ACCOUNT_NUMBER,aa.ORDER_DT,
    case when aa.BB_ADDED_SALETYPE not in( 'UNBLOCK','' ) 
    and COALESCE(aa.BB_ADDED_PRODUCT,'') <> ''
    and COALESCE(aa.BB_REMOVED_PRODUCT,'') <> '' then aa.BB_REMOVED_PRODUCT || ' TO ' || aa.BB_ADDED_PRODUCT
    when aa.bb_removed_product is null then aa.bb_added_product || ' Added'
    when aa.bb_added_product is null then aa.bb_removed_product || ' Removed'
    else 'BROADBAND CHANGED'
    end as BROADBAND_CHANGE,
    aa.BB_REMOVED_PRODUCT,
    aa.BB_ADDED_PRODUCT
    into #BROADBAND_TEMP
    from CITEam.Orders_Daily as aa
      join #BROADBAND as bb
      on aa.account_number = bb.account_number
    where(aa.bb_added_product is not null or aa.bb_Removed_product is not null);
  drop table if exists #BROADBAND2;
  select distinct AA.*,BB.SAME_ORDER_PREVIOUSLY
    into #BROADBAND2
    from #BROADBAND as AA
      left outer join(select distinct A.ACCOUNT_NUMBER,A.ORDER_DT,case when COUNT(distinct B.ACCOUNT_NUMBER) > 0 then 1 else 0 end as SAME_ORDER_PREVIOUSLY
        from #BROADBAND_TEMP as A
          left outer join #BROADBAND_TEMP as B
          on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
          and A.ORDER_DT > B.ORDER_DT
          and a.BROADBAND_CHANGE = b.BROADBAND_CHANGE
        group by A.ACCOUNT_NUMBER,A.ORDER_DT) as BB
      on AA.ACCOUNT_NUMBER = BB.ACCOUNT_NUMBER
      and AA.ORDER_DT = BB.ORDER_DT;
  commit work;
  ---------------------------------------------------------------------------------------------------------------------
  --ADD ON OFFER STATUS FOR ACCOUNTS
  ---------------------------------------------------------------------------------------------------------------------
  select D.ACCOUNT_NUMBER,
    D.ORDER_DT,
    case when D.ACTUAL_OFFER_STATUS = 2 then 'Offer End'
    when D.ACTUAL_OFFER_STATUS = 1 then 'On Offer'
    else 'No Offer'
    end as ACTUAL_OFFER_STATUS,
    case when D.INTENDED_OFFER_STATUS = 2 then 'Offer End'
    when D.INTENDED_OFFER_STATUS = 1 then 'On Offer'
    else 'No Offer'
    end as INTENDED_OFFER_STATUS
    into #BROADBAND_OFFER_STATUS
    from(select distinct A.ACCOUNT_NUMBER,
        A.ORDER_DT,
        MAX(
        case when B.WHOLE_OFFER_END_DT_ACTUAL <> A.ORDER_DT and A.ORDER_DT-55 <= B.WHOLE_OFFER_END_DT_ACTUAL and A.ORDER_DT+35 >= B.WHOLE_OFFER_END_DT_ACTUAL then 2
        when B.WHOLE_OFFER_END_DT_ACTUAL = A.ORDER_DT and A.ORDER_DT-55 <= B.Intended_Offer_End_Dt and A.ORDER_DT+35 >= B.Intended_Offer_End_Dt then 2
        when B.WHOLE_OFFER_END_DT_ACTUAL is not null then 1
        else 0
        end) as ACTUAL_OFFER_STATUS,
        MAX(
        case when A.ORDER_DT-55 <= C.Intended_Offer_End_Dt and A.ORDER_DT+35 >= C.Intended_Offer_End_Dt then 2
        when C.Intended_Offer_End_Dt is not null then 1
        else 0
        end) as INTENDED_OFFER_STATUS
        from #BROADBAND2 as A
          left outer join Decisioning.offers_software as B
          on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
          and A.ORDER_DT > B.WHOLE_OFFER_START_DT_ACTUAL
          and A.ORDER_DT-55 <= B.WHOLE_OFFER_END_DT_ACTUAL
          and lower(B.OFFER_DIM_DESCRIPTION) not like '%price protect%'
          left outer join Decisioning.offers_software as C
          on A.ACCOUNT_NUMBER = C.ACCOUNT_NUMBER
          and A.ORDER_DT > C.Offer_Leg_Start_Dt_Actual
          and A.ORDER_DT-55 <= C.Intended_Offer_End_Dt
          and lower(B.OFFER_DIM_DESCRIPTION) not like '%price protect%'
        group by A.ACCOUNT_NUMBER,
        A.ORDER_DT) as D
    group by D.ACCOUNT_NUMBER,
    D.ORDER_DT,
    ACTUAL_OFFER_STATUS,
    INTENDED_OFFER_STATUS;
  commit work;
  -- UPDATE TABLE
  update #BROADBAND2 as A
    set A.ACTUAL_OFFER_STATUS = B.ACTUAL_OFFER_STATUS,
    A.INTENDED_OFFER_STATUS = B.INTENDED_OFFER_STATUS from
    #BROADBAND_OFFER_STATUS as B
    where A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT = B.ORDER_DT;
  commit work;
  -- ADD FLAG IF ORDER CAME WITH ANY OFFER
  -- MMC Correct logic for Offer flags using data provided by proc
  update #BROADBAND2 as A
    set A.ANY_OFFER_FLAG = case when Offers_Applied_Lst_1D_Any > 0 then 1 else 0 end;
  commit work;
  -- ADD FLAG IF ORDER CAME WITH ANY COMMS OFFER OR TV OFFER
  update #BROADBAND2 as A
    set A.TV_OFFER_FLAG = case when Offers_Applied_Lst_1D_DTV > 0 then 1 else 0 end;
  commit work;
  update #BROADBAND2 as A
    set A.COMMS_OFFER_FLAG = case when Offers_Applied_Lst_1D_BB > 0 or Offers_Applied_Lst_1D_LR > 0 or Offers_Applied_Lst_1D_Talk > 0 then 1 else 0 end;
  commit work;
  -- ADD OFFER DATA TO BUNDLE DATA
  drop table if exists #BROADBAND3;
  select distinct A.*,
    case when B.SUBS_TYPE is not null then 1 else 0 end as DTV_PRIMARY_VIEWING_OFFER,
    B.SUBS_TYPE as OFFER_SUB_TYPE,
    B.OFFER_ID,
    B.OFFER_DIM_DESCRIPTION as OFFER_DESCRIPTION,
    B.OFFER_VALUE as MONTHLY_OFFER_VALUE,
    DATEDIFF(month,B.INTENDED_OFFER_START_DT,B.INTENDED_OFFER_END_DT) as OFFER_DURATION_MTH,
    DATEDIFF(month,B.INTENDED_OFFER_START_DT,B.INTENDED_OFFER_END_DT)*B.OFFER_VALUE as TOTAL_OFFER_VALUE,
    B.AUTO_TRANSFER_OFFER
    into #BROADBAND3
    from #BROADBAND2 as A
      left outer join(select C.*,D.AUTO_TRANSFER_OFFER
        from CITEAM.ECON_OFFERS as C
          join(select ACCOUNT_NUMBER,CREATED_DT,MAX(INTENDED_OFFER_END_DT-INTENDED_OFFER_START_DT) as OFFER_DURATION,
            case when SUM(case when ORIG_PORTFOLIO_OFFER_ID <> '?' then 1 else 0 end) > 1 then 1 else 0 end as AUTO_TRANSFER_OFFER
            from CITEAM.ECON_OFFERS
            group by ACCOUNT_NUMBER,CREATED_DT) as D
          on C.ACCOUNT_NUMBER = D.ACCOUNT_NUMBER
          and C.CREATED_DT = D.CREATED_DT
          and(C.INTENDED_OFFER_END_DT-C.INTENDED_OFFER_START_DT) = D.OFFER_DURATION) as B
      on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and A.ORDER_DT = B.CREATED_DT
      -- AND A.ORDER_ID=B.ORDER_ID
      and B.SUBS_TYPE = 'DTV Primary Viewing'
      --AND B.ORIG_PORTFOLIO_OFFER_ID='?'
      and B.OFFER_SEGMENT_GROUPED_1 <> 'Price Protection'
      --AND DATEDIFF(MONTH,B.INTENDED_OFFER_START_DT,B.INTENDED_OFFER_END_DT)<=72
      and B.OFFER_VALUE < 0;
  commit work;
  -- ADD ON CUSTOMER DATA AND WEEK DATA AND OUTPUT
  drop table if exists #ECONOMETRICS_BROADBAND;
  select distinct A.ACCOUNT_NUMBER,
    A.CURRENCY_CODE,
    A.CUSTOMER_SK,
    A.ORDER_ID,
    A.ORDER_NUMBER,
    A.ORDER_DT,
    A.RTM_LEVEL_1,
    A.RTM_LEVEL_2,
    A.RTM_LEVEL_3,
    A.ORDER_COMMUNICATION_TYPE,
    --                 ,A.ORDER_TYPE
    A.ORDER_SALE_TYPE,
    A.CHANGE_TYPE,
    A.BROADBAND_CHANGE,
    A.BB_REMOVED_PRODUCT,
    A.BB_ADDED_PRODUCT,
    case when lower(trim(BB_ADDED_PRODUCT)) like '%fibre%' then 'Fibre' else 'DSL' end as DSL_FIBRE,
    A.PREVIOUS_ACTIVE_BROADBAND,
    A.ACTIVE_BROADBAND_LAST_30_DAYS,
    A.ACTIVE_BROADBAND_LAST_12_MONTHS,
    A.ACTIVE_BROADBAND_BEFORE_ORDER,
    A.HOME_MOVE,
    A.ORDER_BECAME_ACTIVE,
    A.ACCOUNT_ACTIVE_LENGTH,
    A.DTV_STATUS_BEFORE_ORDER,
    A.DTV_BEFORE_ORDER,
    A.previous_dtv,
    A.same_day_cancel,
    A.DTV_AFTER_ORDER,
    A.PRE_ORDER_BB_STATUS_PA,
    A.SPORTS_ADDED,
    A.MOVIES_ADDED,
    A.FAMILY_ADDED,
    A.VARIETY_ADDED,
    A.ORIGINAL_ADDED,
    A.SKYQ_ADDED,
    A.HD_LEGACY_ADDED,
    A.HD_BASIC_ADDED,
    A.HD_PREMIUM_ADDED,
    A.MULTISCREEN_ADDED,
    A.MULTISCREEN_PLUS_ADDED,
    A.SKY_PLUS_ADDED,
    A.SKY_GO_EXTRA_ADDED,
    A.NOW_TV_ADDED,
    A.BB_UNLIMITED_ADDED,
    A.BB_LITE_ADDED,
    A.BB_FIBRE_CAP_ADDED,
    A.BB_FIBRE_UNLIMITED_ADDED,
    A.BB_FIBRE_UNLIMITED_PRO_ADDED,
    A.TALKU_ADDED,
    A.TALKW_ADDED,
    A.TALKF_ADDED,
    A.TALKA_ADDED,
    A.TALKP_ADDED,
    A.TALKO_ADDED,
    A.KIDS_ADDED,
    A.BOXSETS_ADDED,
    A.SPORTS_REMOVED,
    A.MOVIES_REMOVED,
    A.FAMILY_REMOVED,
    A.VARIETY_REMOVED,
    A.ORIGINAL_REMOVED,
    A.SKYQ_REMOVED,
    A.HD_LEGACY_REMOVED,
    A.HD_BASIC_REMOVED,
    A.HD_PREMIUM_REMOVED,
    A.MULTISCREEN_REMOVED,
    A.MULTISCREEN_PLUS_REMOVED,
    A.SKY_PLUS_REMOVED,
    A.SKY_GO_EXTRA_REMOVED,
    A.NOW_TV_REMOVED,
    A.BB_UNLIMITED_REMOVED,
    A.BB_LITE_REMOVED,
    A.BB_FIBRE_CAP_REMOVED,
    A.BB_FIBRE_UNLIMITED_REMOVED,
    A.BB_FIBRE_UNLIMITED_PRO_REMOVED,
    A.TALKU_REMOVED,
    A.TALKW_REMOVED,
    A.TALKF_REMOVED,
    A.TALKA_REMOVED,
    A.TALKP_REMOVED,
    A.TALKO_REMOVED,
    A.OLYMPUS_CUSTOMER,
    A.CONTACT_TYPE,
    A.SAME_ORDER_PREVIOUSLY,
    A.ACTUAL_OFFER_STATUS,
    A.INTENDED_OFFER_STATUS,
    A.ANY_OFFER_FLAG,
    A.DTV_PRIMARY_VIEWING_OFFER,
    A.OFFER_SUB_TYPE,
    A.OFFER_ID,
    A.OFFER_DESCRIPTION,
    A.MONTHLY_OFFER_VALUE,
    A.OFFER_DURATION_MTH,
    A.TOTAL_OFFER_VALUE,
    A.AUTO_TRANSFER_OFFER,
    cast(null as integer) as TENURE,
    cast(null as varchar(45)) as SIMPLE_SEGMENT,
    cast(null as varchar(45)) as TV_REGION,
    cast(null as varchar(45)) as mosaic_uk_group,
    right(cast(C.subs_year as varchar),2) || '/' || right(cast(C.subs_year+1 as varchar),2)
     || '-' || case when C.subs_week_of_year < 10 then '0' || cast(C.subs_week_of_year as varchar) else cast(C.subs_week_of_year as varchar) end as year_week,
    A.ORDER_DT as WEEK_START,
    A.TV_OFFER_FLAG,
    A.COMMS_OFFER_FLAG,
    Offer_End_Status_Level_1,
    Offer_End_Status_Level_2,
    A.ANY_NEW_OFFER_FLAG,
    A.NEW_DTV_PRIMARY_VIEWING_OFFER,
    A.BB_ACQUISITION,
    A.BB_Status,
    A.Orders,
    A.Existing_BB,
    A.Existing_AP_AC,
    A.Existing_PC_AC,
    A.Existing_PA_AP,
    A.Existing_AB_AC,
    A.Existing_TV_Active,
    A.Existing_TV_Order,
    A.New_TV_Order,
    A.TV_Churn,
    A.SABB,
    A.BB_Upgrade_Orders,
    A.DTV_ADDED_PRODUCT,
    A.SPOTIFY_ADDED,
    A.SPOTIFY_REMOVED,
    A.UOD_ADDED,
    A.UOD_REMOVED,
    case when A.Netflix_Standard_Added > 0 then 'Netflix_Standard' when A.Netflix_Premium_Added > 0 then 'Netflix_Premium' else '' end as Netflix_Added_Product,
    case when A.Netflix_Standard_Removed > 0 then 'Netflix_Standard' when A.Netflix_Premium_Removed > 0 then 'Netflix_Premium' else '' end as Netflix_Removed_Product,
    cast(0 as integer) as Basic_contract_status_pre_order,
    cast(null as varchar(200)) as Basic_contract_subscription_item_pre_order,
    cast(0 as integer) as Add_on_contract_status_pre_order,
    cast(null as varchar(200)) as Add_on_contract_subscription_item_pre_order,
    cast(0 as integer) as Talk_contract_status_pre_order,
    cast(null as varchar(200)) as Talk_contract_subscription_item_pre_order,
    cast(0 as integer) as BB_contract_status_pre_order,
    cast(null as varchar(200)) as BB_contract_subscription_item_pre_order,
    cast(0 as integer) as Basic_contract_status_post_order,
    cast(null as varchar(200)) as Basic_contract_subscription_item_post_order,
    cast(0 as integer) as BB_contract_status_post_order,
    cast(null as varchar(200)) as BB_contract_subscription_item_post_order,
    cast(0 as integer) as Talk_contract_status_post_order,
    cast(null as varchar(200)) as Talk_contract_subscription_item_post_order,
    cast(0 as integer) as Add_on_contract_status_post_order,
    cast(null as varchar(200)) as Add_on_contract_subscription_item_post_order
    into #ECONOMETRICS_BROADBAND
    from #BROADBAND3 as A
      left outer join sky_calendar as C
      on A.ORDER_DT = C.CALENDAR_DATE;
  commit work;
  -------------------Update Tenure and TV Region
  update #ECONOMETRICS_BROADBAND as A
    set A.TV_Region = B.tv_region,
    A.TENURE = DATEDIFF(month,B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT,A.order_dt) from
    /*CASE 
WHEN DATEDIFF(DAY,B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT,A.WEEK_START) <= 122 THEN 'A) 0-4 MONTHS'
WHEN DATEDIFF(DAY,B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT,A.WEEK_START) <= 274 THEN 'B) 5-9 MONTHS'
WHEN DATEDIFF(DAY,B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT,A.WEEK_START) <= 395 THEN 'C) 10-13 MONTHS'
WHEN DATEDIFF(DAY,B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT,A.WEEK_START) <= 730 THEN 'D) 14-24 MONTHS'
WHEN DATEDIFF(DAY,B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT,A.WEEK_START) <= 1095 THEN 'E) 2-3 YEARS'
WHEN DATEDIFF(DAY,B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT,A.WEEK_START) <= 1825 THEN 'F) 3-5 YEARS'
WHEN DATEDIFF(DAY,B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT,A.WEEK_START) <= 3650 THEN 'G) 5-10 YEARS'
WHEN DATEDIFF(DAY,B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT,A.WEEK_START) > 3650 THEN 'H) 10 YEARS+'
ELSE 'UNKNOWN' END */
    #ECONOMETRICS_BROADBAND as A
    join CITeam.Account_TV_Region as B
    on A.account_number = B.account_number;
  -- UPDATE WEEK START
  select right(cast(subs_year as varchar),2) || '/' || right(cast(subs_year+1 as varchar),2)
     || '-' || case when subs_week_of_year < 10 then '0' || cast(subs_week_of_year as varchar) else cast(subs_week_of_year as varchar) end as year_week,
    min(calendar_date) as week_start
    into #weeks
    from sky_calendar as cal
    group by year_week;
  update #ECONOMETRICS_BROADBAND as a
    set a.week_start = b.week_start from
    #weeks as b
    where a.year_week = b.year_week;
  --END
  --------------------------------------------------------------------------------------------------
  ---------Contract Flags Update-------
  --------------------------------------------------------------------------------------------------
  update #ECONOMETRICS_BROADBAND as bb
    set bb.Basic_contract_status_pre_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    bb.Basic_contract_subscription_item_pre_order = ctr.Agreement_Item_Type from
    #ECONOMETRICS_BROADBAND as bb
    left outer join CITEAM.DM_Contracts as ctr
    on bb.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and bb.order_dt-1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Primary DTV' ) ;
  update #ECONOMETRICS_BROADBAND as bb
    set bb.Add_on_contract_status_pre_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    bb.Add_on_contract_subscription_item_pre_order = ctr.Agreement_Item_Type from
    #ECONOMETRICS_BROADBAND as bb
    left outer join CITEAM.DM_Contracts as ctr
    on bb.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and bb.order_dt-1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Secondary DTV','Sky Enhanced Cap Subs' ) ;
  update #ECONOMETRICS_BROADBAND as bb
    set bb.Talk_contract_status_pre_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    bb.Talk_contract_subscription_item_pre_order = ctr.Agreement_Item_Type from
    #ECONOMETRICS_BROADBAND as bb
    left outer join CITEAM.DM_Contracts as ctr
    on bb.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and bb.order_dt-1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Sky Talk' ) ;
  update #ECONOMETRICS_BROADBAND as bb
    set bb.BB_contract_status_pre_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    bb.BB_contract_subscription_item_pre_order = ctr.Agreement_Item_Type from
    #ECONOMETRICS_BROADBAND as bb
    left outer join CITEAM.DM_Contracts as ctr
    on bb.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and bb.order_dt-1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Broadband' ) ;
  ---
  update #ECONOMETRICS_BROADBAND as A
    set A.Basic_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.Basic_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #ECONOMETRICS_BROADBAND as A
    --AND B.STATUS_CODE_CHANGED = 'Y'
    left outer join(select ACCOUNT_NUMBER,ORDER_ID,subscription_id,EFFECTIVE_FROM_DT
      from cust_subs_hist as B
      where B.subscription_sub_type in( 'DTV Primary Viewing' ) 
      and B.effective_from_dt < B.effective_to_dt
      and B.owning_cust_account_id > '1'
      and B.SI_Latest_Src = 'CHORD'
      and B.STATUS_CODE in( 'AC','AB','PC' ) 
      and effective_to_dt >= '2012-01-01') as B
    on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_ID = B.ORDER_ID
    and B.EFFECTIVE_FROM_DT between A.ORDER_DT and A.ORDER_DT+30
    left outer join CITEAM.dm_contracts as D
    on A.ACCOUNT_NUMBER = D.ACCOUNT_NUMBER
    and B.subscription_id = D.subscription_id
    and D.CONTRACT_START_DATE between A.order_dt and B.effective_from_dt
    where A.DTV_ADDED_PRODUCT is not null and D.CONTRACT_STATUS in( 'In Contract' ) ;
  update #ECONOMETRICS_BROADBAND as A
    set A.Basic_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.Basic_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #ECONOMETRICS_BROADBAND as A
    left outer join CITeam.orders_detail as C on A.Account_Number = C.Account_Number and A.Order_Dt = C.Order_Dt
    --AND B.STATUS_CODE_CHANGED = 'Y'
    left outer join(select ACCOUNT_NUMBER,ORDER_ID,subscription_id,EFFECTIVE_FROM_DT
      from cust_subs_hist as B
      where B.subscription_sub_type in( 'DTV Primary Viewing' ) 
      and B.effective_from_dt < B.effective_to_dt
      and B.owning_cust_account_id > '1'
      and B.SI_Latest_Src = 'CHORD'
      and B.STATUS_CODE in( 'AC','AB','PC' ) 
      and effective_to_dt >= '2012-01-01') as B
    on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and C.ORDER_ID = B.ORDER_ID
    and B.EFFECTIVE_FROM_DT between A.ORDER_DT and A.ORDER_DT+30
    left outer join CITEAM.dm_contracts as D
    on A.ACCOUNT_NUMBER = D.ACCOUNT_NUMBER
    and B.subscription_id = D.subscription_id
    and D.CONTRACT_START_DATE between A.order_dt and B.effective_from_dt
    where A.DTV_ADDED_PRODUCT is not null and D.CONTRACT_STATUS in( 'In Contract' ) and A.Basic_contract_status_post_order <> 1;
  update #ECONOMETRICS_BROADBAND as bb
    set bb.Basic_contract_status_post_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    bb.Basic_contract_subscription_item_post_order = ctr.Agreement_Item_Type from
    #ECONOMETRICS_BROADBAND as bb
    left outer join CITEAM.DM_Contracts as ctr
    on bb.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and bb.order_dt+1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and ctr.subscription_type in( 'Primary DTV' ) and bb.Basic_contract_status_post_order <> 1;
  ---
  update #ECONOMETRICS_BROADBAND as A
    set A.BB_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.BB_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #ECONOMETRICS_BROADBAND as A
    --AND B.STATUS_CODE_CHANGED = 'Y'
    left outer join(select ACCOUNT_NUMBER,ORDER_ID,subscription_id,EFFECTIVE_FROM_DT
      from cust_subs_hist as B
      where B.subscription_sub_type in( 'Broadband DSL Line' ) 
      and B.effective_from_dt < B.effective_to_dt
      and B.owning_cust_account_id > '1'
      and B.SI_Latest_Src = 'CHORD'
      and B.STATUS_CODE in( 'AC','AB','PC' ) 
      and effective_to_dt >= '2012-01-01') as B
    on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_ID = B.ORDER_ID
    and B.EFFECTIVE_FROM_DT between A.ORDER_DT and A.ORDER_DT+30
    left outer join CITEAM.dm_contracts as D
    on A.ACCOUNT_NUMBER = D.ACCOUNT_NUMBER
    and B.subscription_id = D.subscription_id
    and D.CONTRACT_START_DATE between A.order_dt and B.effective_from_dt
    where A.BB_ADDED_PRODUCT is not null and D.CONTRACT_STATUS in( 'In Contract' ) ;
  update #ECONOMETRICS_BROADBAND as A
    set A.BB_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.BB_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #ECONOMETRICS_BROADBAND as A
    left outer join CITeam.orders_detail as C on A.Account_Number = C.Account_Number and A.Order_Dt = C.Order_Dt
    --AND B.STATUS_CODE_CHANGED = 'Y'
    left outer join(select ACCOUNT_NUMBER,ORDER_ID,subscription_id,EFFECTIVE_FROM_DT
      from cust_subs_hist as B
      where B.subscription_sub_type in( 'Broadband DSL Line' ) 
      and B.effective_from_dt < B.effective_to_dt
      and B.owning_cust_account_id > '1'
      and B.SI_Latest_Src = 'CHORD'
      and B.STATUS_CODE in( 'AC','AB','PC' ) 
      and effective_to_dt >= '2012-01-01') as B
    on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and C.ORDER_ID = B.ORDER_ID
    and B.EFFECTIVE_FROM_DT between A.ORDER_DT and A.ORDER_DT+30
    left outer join CITEAM.dm_contracts as D
    on A.ACCOUNT_NUMBER = D.ACCOUNT_NUMBER
    and B.subscription_id = D.subscription_id
    and D.CONTRACT_START_DATE between A.order_dt and B.effective_from_dt
    where A.BB_ADDED_PRODUCT is not null and D.CONTRACT_STATUS in( 'In Contract' ) and A.BB_contract_status_post_order <> 1;
  update #ECONOMETRICS_BROADBAND as bb
    set bb.BB_contract_status_post_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    bb.BB_contract_subscription_item_post_order = ctr.Agreement_Item_Type from
    #ECONOMETRICS_BROADBAND as bb
    left outer join CITEAM.DM_Contracts as ctr
    on bb.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and bb.order_dt+1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and ctr.subscription_type in( 'Broadband' ) and bb.BB_contract_status_post_order <> 1;
  --
  update #ECONOMETRICS_BROADBAND as A
    set A.Talk_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.Talk_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #ECONOMETRICS_BROADBAND as A
    --AND B.STATUS_CODE_CHANGED = 'Y'
    left outer join(select ACCOUNT_NUMBER,ORDER_ID,subscription_id,EFFECTIVE_FROM_DT
      from cust_subs_hist as B
      where B.subscription_type in( 'SKY TALK' ) 
      and B.effective_from_dt < B.effective_to_dt
      and B.owning_cust_account_id > '1'
      and B.SI_Latest_Src = 'CHORD'
      and B.STATUS_CODE in( 'AC','AB','PC' ) 
      and effective_to_dt >= '2012-01-01') as B
    on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_ID = B.ORDER_ID
    and B.EFFECTIVE_FROM_DT between A.ORDER_DT and A.ORDER_DT+30
    left outer join CITEAM.dm_contracts as D
    on A.ACCOUNT_NUMBER = D.ACCOUNT_NUMBER
    and B.subscription_id = D.subscription_id
    and D.CONTRACT_START_DATE between A.order_dt and B.effective_from_dt
    where(A.TALKU_ADDED+A.TALKW_ADDED+A.TALKF_ADDED+A.TALKA_ADDED+A.TALKP_ADDED+A.TALKO_ADDED) >= 1 and D.CONTRACT_STATUS in( 'In Contract' ) ;
  update #ECONOMETRICS_BROADBAND as A
    set A.Talk_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.Talk_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #ECONOMETRICS_BROADBAND as A
    left outer join CITeam.orders_detail as C on A.Account_Number = C.Account_Number and A.Order_Dt = C.Order_Dt
    --AND B.STATUS_CODE_CHANGED = 'Y'
    left outer join(select ACCOUNT_NUMBER,ORDER_ID,subscription_id,EFFECTIVE_FROM_DT
      from cust_subs_hist as B
      where B.subscription_type in( 'SKY TALK' ) 
      and B.effective_from_dt < B.effective_to_dt
      and B.owning_cust_account_id > '1'
      and B.SI_Latest_Src = 'CHORD'
      and B.STATUS_CODE in( 'AC','AB','PC' ) 
      and effective_to_dt >= '2012-01-01') as B
    on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and C.ORDER_ID = B.ORDER_ID
    and B.EFFECTIVE_FROM_DT between A.ORDER_DT and A.ORDER_DT+30
    left outer join CITEAM.dm_contracts as D
    on A.ACCOUNT_NUMBER = D.ACCOUNT_NUMBER
    and B.subscription_id = D.subscription_id
    and D.CONTRACT_START_DATE between A.order_dt and B.effective_from_dt
    where(A.TALKU_ADDED+A.TALKW_ADDED+A.TALKF_ADDED+A.TALKA_ADDED+A.TALKP_ADDED+A.TALKO_ADDED) >= 1 and D.CONTRACT_STATUS in( 'In Contract' ) and A.Talk_contract_status_post_order <> 1;
  update #ECONOMETRICS_BROADBAND as bb
    set bb.Talk_contract_status_post_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    bb.Talk_contract_subscription_item_post_order = ctr.Agreement_Item_Type from
    #ECONOMETRICS_BROADBAND as bb
    left outer join CITEAM.DM_Contracts as ctr
    on bb.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and bb.order_dt+1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Sky Talk' ) and bb.Talk_contract_status_post_order <> 1;
  ---
  update #ECONOMETRICS_BROADBAND as A
    set A.Add_on_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.Add_on_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #ECONOMETRICS_BROADBAND as A
    --AND B.STATUS_CODE_CHANGED = 'Y'
    left outer join(select ACCOUNT_NUMBER,ORDER_ID,subscription_id,EFFECTIVE_FROM_DT
      from cust_subs_hist as B
      where B.subscription_sub_type in( 'DTV HD','DTV Extra Subscription','Sky Go Extra','HD Pack','MS+','SKY_KIDS','SKY_BOX_SETS','KIDS_PACK','FREESAT','DTV_HD_EXTN' ) 
      and B.effective_from_dt < B.effective_to_dt
      and B.owning_cust_account_id > '1'
      and B.SI_Latest_Src = 'CHORD'
      and B.STATUS_CODE in( 'AC','AB','PC' ) 
      and effective_to_dt >= '2012-01-01') as B
    on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_ID = B.ORDER_ID
    and B.EFFECTIVE_FROM_DT between A.ORDER_DT and A.ORDER_DT+30
    left outer join CITEAM.dm_contracts as D
    on A.ACCOUNT_NUMBER = D.ACCOUNT_NUMBER
    and B.subscription_id = D.subscription_id
    and D.CONTRACT_START_DATE between A.order_dt and B.effective_from_dt
    where(A.SPORTS_ADDED+A.MOVIES_ADDED+A.KIDS_ADDED+A.BOXSETS_ADDED+A.SKYQ_ADDED+A.HD_LEGACY_ADDED+A.HD_BASIC_ADDED+A.HD_PREMIUM_ADDED+A.MULTISCREEN_ADDED+A.MULTISCREEN_PLUS_ADDED+A.SKY_PLUS_ADDED+A.SKY_GO_EXTRA_ADDED) >= 1 and D.CONTRACT_STATUS in( 'In Contract' ) ;
  update #ECONOMETRICS_BROADBAND as A
    set A.Add_on_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.Add_on_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #ECONOMETRICS_BROADBAND as A
    left outer join CITeam.orders_detail as C on A.Account_Number = C.Account_Number and A.Order_Dt = C.Order_Dt
    --AND B.STATUS_CODE_CHANGED = 'Y'
    left outer join(select ACCOUNT_NUMBER,ORDER_ID,subscription_id,EFFECTIVE_FROM_DT
      from cust_subs_hist as B
      where B.subscription_sub_type in( 'DTV HD','DTV Extra Subscription','Sky Go Extra','HD Pack','MS+','SKY_KIDS','SKY_BOX_SETS','KIDS_PACK','FREESAT','DTV_HD_EXTN' ) 
      and B.effective_from_dt < B.effective_to_dt
      and B.owning_cust_account_id > '1'
      and B.SI_Latest_Src = 'CHORD'
      and B.STATUS_CODE in( 'AC','AB','PC' ) 
      and effective_to_dt >= '2012-01-01') as B
    on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and C.ORDER_ID = B.ORDER_ID
    and B.EFFECTIVE_FROM_DT between A.ORDER_DT and A.ORDER_DT+30
    left outer join CITEAM.dm_contracts as D
    on A.ACCOUNT_NUMBER = D.ACCOUNT_NUMBER
    and B.subscription_id = D.subscription_id
    and D.CONTRACT_START_DATE between A.order_dt and B.effective_from_dt
    where(A.SPORTS_ADDED+A.MOVIES_ADDED+A.KIDS_ADDED+A.BOXSETS_ADDED+A.SKYQ_ADDED+A.HD_LEGACY_ADDED+A.HD_BASIC_ADDED+A.HD_PREMIUM_ADDED+A.MULTISCREEN_ADDED+A.MULTISCREEN_PLUS_ADDED+A.SKY_PLUS_ADDED+A.SKY_GO_EXTRA_ADDED) >= 1 and D.CONTRACT_STATUS in( 'In Contract' ) and A.Add_on_contract_status_post_order <> 1;
  update #ECONOMETRICS_BROADBAND as bb
    set bb.Add_on_contract_status_post_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    bb.Add_on_contract_subscription_item_post_order = ctr.Agreement_Item_Type from
    #ECONOMETRICS_BROADBAND as bb
    left outer join CITEAM.DM_Contracts as ctr
    on bb.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and bb.order_dt+1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Secondary DTV','Sky Enhanced Cap Subs' ) and bb.Add_on_contract_status_post_order <> 1;
  ------------------------------------------------------------------------------
  commit work;
  delete from Decisioning.ECONOMETRICS_BROADBAND_ORDERS_ACCOUNT_LEVEL
    where WEEK_START between period_start and period_end;
  insert into Decisioning.ECONOMETRICS_BROADBAND_ORDERS_ACCOUNT_LEVEL
    select ACCOUNT_NUMBER,
      ORDER_ID,
      order_dt,
      YEAR_WEEK,
      WEEK_START,
      CURRENCY_CODE,
      RTM_LEVEL_1,
      RTM_LEVEL_2,
      RTM_LEVEL_3,
      ORDER_COMMUNICATION_TYPE,
      ORDER_SALE_TYPE,
      CONTACT_TYPE,
      OLYMPUS_CUSTOMER,
      CHANGE_TYPE,
      BROADBAND_CHANGE,
      BB_REMOVED_PRODUCT,
      BB_ADDED_PRODUCT,
      DSL_FIBRE,
      --,PREVIOUS_ACTIVE_BROADBAND
      --,ACTIVE_BROADBAND_LAST_30_DAYS
      ACTIVE_BROADBAND_LAST_12_MONTHS,
      ACTIVE_BROADBAND_BEFORE_ORDER,
      HOME_MOVE,
      ORDER_BECAME_ACTIVE,
      ACCOUNT_ACTIVE_LENGTH,
      DTV_STATUS_BEFORE_ORDER,
      DTV_BEFORE_ORDER,
      previous_dtv,
      same_day_cancel,
      DTV_AFTER_ORDER,
      --,PRE_ORDER_BB_STATUS_PA
      --,BB_UNLIMITED_ADDED
      --,BB_LITE_ADDED
      --,BB_FIBRE_CAP_ADDED
      --,BB_FIBRE_UNLIMITED_ADDED
      --,BB_FIBRE_UNLIMITED_PRO_ADDED
      --,BB_UNLIMITED_REMOVED
      --,BB_LITE_REMOVED
      --,BB_FIBRE_CAP_REMOVED
      --,BB_FIBRE_UNLIMITED_REMOVED
      --,BB_FIBRE_UNLIMITED_PRO_REMOVED
      --,SAME_ORDER_PREVIOUSLY
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      ANY_OFFER_FLAG,
      TENURE,
      --,SIMPLE_SEGMENT
      TV_REGION,
      --,MOSAIC_UK_GROUP
      TV_OFFER_FLAG,
      COMMS_OFFER_FLAG,
      --,Offer_End_Status_Level_1
      --,Offer_End_Status_Level_2
      ANY_NEW_OFFER_FLAG,
      --,NEW_DTV_PRIMARY_VIEWING_OFFER
      --,BB_ACQUISITION
      BB_Status,
      --,Orders
      --,Existing_BB
      --,Existing_AP_AC
      --,Existing_PC_AC
      --,Existing_PA_AP
      --,Existing_AB_AC
      --,Existing_TV_Active
      --,Existing_TV_Order
      --,New_TV_Order
      --,TV_Churn
      --,SABB
      --,BB_Upgrade_Orders
      SPORTS_ADDED,
      MOVIES_ADDED,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      SPOTIFY_ADDED,
      SPOTIFY_REMOVED,
      UOD_ADDED,
      UOD_REMOVED,
      Netflix_Added_Product,
      Netflix_Removed_Product,
      Basic_contract_status_pre_order,
      Basic_contract_subscription_item_pre_order,
      Add_on_contract_status_pre_order,
      Add_on_contract_subscription_item_pre_order,
      Talk_contract_status_pre_order,
      Talk_contract_subscription_item_pre_order,
      BB_contract_status_pre_order,
      BB_contract_subscription_item_pre_order,
      Basic_contract_status_post_order,
      Basic_contract_subscription_item_post_order,
      BB_contract_status_post_order,
      BB_contract_subscription_item_post_order,
      Talk_contract_status_post_order,
      Talk_contract_subscription_item_post_order,
      Add_on_contract_status_post_order,
      Add_on_contract_subscription_item_post_order
      from #ECONOMETRICS_BROADBAND;
  delete from Decisioning.ECONOMETRICS_BROADBAND_ORDERS
    where WEEK_START between period_start and period_end;
  insert into Decisioning.ECONOMETRICS_BROADBAND_ORDERS
    select YEAR_WEEK,
      WEEK_START,
      CURRENCY_CODE,
      RTM_LEVEL_1,
      RTM_LEVEL_2,
      RTM_LEVEL_3,
      ORDER_COMMUNICATION_TYPE,
      ORDER_SALE_TYPE,
      CONTACT_TYPE,
      OLYMPUS_CUSTOMER,
      CHANGE_TYPE,
      --,BROADBAND_CHANGE
      BB_REMOVED_PRODUCT,
      BB_ADDED_PRODUCT,
      DSL_FIBRE,
      --,PREVIOUS_ACTIVE_BROADBAND
      --,ACTIVE_BROADBAND_LAST_30_DAYS
      ACTIVE_BROADBAND_LAST_12_MONTHS,
      ACTIVE_BROADBAND_BEFORE_ORDER,
      HOME_MOVE,
      ORDER_BECAME_ACTIVE,
      ACCOUNT_ACTIVE_LENGTH,
      DTV_STATUS_BEFORE_ORDER,
      DTV_BEFORE_ORDER,
      previous_dtv,
      same_day_cancel,
      DTV_AFTER_ORDER,
      --,PRE_ORDER_BB_STATUS_PA
      --,BB_UNLIMITED_ADDED
      --,BB_LITE_ADDED
      --,BB_FIBRE_CAP_ADDED
      --,BB_FIBRE_UNLIMITED_ADDED
      --,BB_FIBRE_UNLIMITED_PRO_ADDED
      --,BB_UNLIMITED_REMOVED
      --,BB_LITE_REMOVED
      --,BB_FIBRE_CAP_REMOVED
      --,BB_FIBRE_UNLIMITED_REMOVED
      --,BB_FIBRE_UNLIMITED_PRO_REMOVED
      --,SAME_ORDER_PREVIOUSLY
      --,ACTUAL_OFFER_STATUS
      --,INTENDED_OFFER_STATUS
      ANY_OFFER_FLAG,
      TENURE,
      --,SIMPLE_SEGMENT
      TV_REGION,
      --,MOSAIC_UK_GROUP
      COUNT() as NUMBER_OF_ORDERS,
      TV_OFFER_FLAG,
      COMMS_OFFER_FLAG,
      --,Offer_End_Status_Level_1
      --,Offer_End_Status_Level_2
      ANY_NEW_OFFER_FLAG,
      --,NEW_DTV_PRIMARY_VIEWING_OFFER
      --,BB_ACQUISITION
      BB_Status,
      --,Orders
      --,Existing_BB
      --,Existing_AP_AC
      --,Existing_PC_AC
      --,Existing_PA_AP
      --,Existing_AB_AC
      --,Existing_TV_Active
      --,Existing_TV_Order
      --,New_TV_Order
      --,TV_Churn
      --,SABB
      --,BB_Upgrade_Orders
      SPORTS_ADDED,
      MOVIES_ADDED,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      SPOTIFY_ADDED,
      SPOTIFY_REMOVED,
      UOD_ADDED,
      UOD_REMOVED,
      Netflix_Added_Product,
      Netflix_Removed_Product,
      Basic_contract_status_pre_order,
      Basic_contract_subscription_item_pre_order,
      Add_on_contract_status_pre_order,
      Add_on_contract_subscription_item_pre_order,
      Talk_contract_status_pre_order,
      Talk_contract_subscription_item_pre_order,
      BB_contract_status_pre_order,
      BB_contract_subscription_item_pre_order,
      Basic_contract_status_post_order,
      Basic_contract_subscription_item_post_order,
      BB_contract_status_post_order,
      BB_contract_subscription_item_post_order,
      Talk_contract_status_post_order,
      Talk_contract_subscription_item_post_order,
      Add_on_contract_status_post_order,
      Add_on_contract_subscription_item_post_order
      from #ECONOMETRICS_BROADBAND
      group by YEAR_WEEK,
      WEEK_START,
      CURRENCY_CODE,
      RTM_LEVEL_1,
      RTM_LEVEL_2,
      RTM_LEVEL_3,
      ORDER_COMMUNICATION_TYPE,
      ORDER_SALE_TYPE,
      CONTACT_TYPE,
      OLYMPUS_CUSTOMER,
      CHANGE_TYPE,
      --,BROADBAND_CHANGE
      BB_REMOVED_PRODUCT,
      BB_ADDED_PRODUCT,
      DSL_FIBRE,
      --,PREVIOUS_ACTIVE_BROADBAND
      --,ACTIVE_BROADBAND_LAST_30_DAYS
      ACTIVE_BROADBAND_LAST_12_MONTHS,
      ACTIVE_BROADBAND_BEFORE_ORDER,
      HOME_MOVE,
      ORDER_BECAME_ACTIVE,
      ACCOUNT_ACTIVE_LENGTH,
      DTV_STATUS_BEFORE_ORDER,
      DTV_BEFORE_ORDER,
      previous_dtv,
      same_day_cancel,
      DTV_AFTER_ORDER,
      --,PRE_ORDER_BB_STATUS_PA
      --,BB_UNLIMITED_ADDED
      --,BB_LITE_ADDED
      --,BB_FIBRE_CAP_ADDED
      --,BB_FIBRE_UNLIMITED_ADDED
      --,BB_FIBRE_UNLIMITED_PRO_ADDED
      --,BB_UNLIMITED_REMOVED
      --,BB_LITE_REMOVED
      --,BB_FIBRE_CAP_REMOVED
      --,BB_FIBRE_UNLIMITED_REMOVED
      --,BB_FIBRE_UNLIMITED_PRO_REMOVED
      --,SAME_ORDER_PREVIOUSLY
      --,ACTUAL_OFFER_STATUS
      --,INTENDED_OFFER_STATUS
      ANY_OFFER_FLAG,
      TENURE,
      --,SIMPLE_SEGMENT
      TV_REGION,
      --,MOSAIC_UK_GROUP
      TV_OFFER_FLAG,
      COMMS_OFFER_FLAG,
      --,Offer_End_Status_Level_1
      --,Offer_End_Status_Level_2
      ANY_NEW_OFFER_FLAG,
      --,NEW_DTV_PRIMARY_VIEWING_OFFER
      --,BB_ACQUISITION
      BB_Status,
      --,Orders
      --,Existing_BB
      --,Existing_AP_AC
      --,Existing_PC_AC
      --,Existing_PA_AP
      --,Existing_AB_AC
      --,Existing_TV_Active
      --,Existing_TV_Order
      --,New_TV_Order
      --,TV_Churn
      --,SABB
      --,BB_Upgrade_Orders
      SPORTS_ADDED,
      MOVIES_ADDED,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      SPOTIFY_ADDED,
      SPOTIFY_REMOVED,
      UOD_ADDED,
      UOD_REMOVED,
      Netflix_Added_Product,
      Netflix_Removed_Product,
      Basic_contract_status_pre_order,
      Basic_contract_subscription_item_pre_order,
      Add_on_contract_status_pre_order,
      Add_on_contract_subscription_item_pre_order,
      Talk_contract_status_pre_order,
      Talk_contract_subscription_item_pre_order,
      BB_contract_status_pre_order,
      BB_contract_subscription_item_pre_order,
      Basic_contract_status_post_order,
      Basic_contract_subscription_item_post_order,
      BB_contract_status_post_order,
      BB_contract_subscription_item_post_order,
      Talk_contract_status_post_order,
      Talk_contract_subscription_item_post_order,
      Add_on_contract_status_post_order,
      Add_on_contract_subscription_item_post_order;
  commit work;
  -- CREATE SUMMARY OF ALL OFFERS
  select ACCOUNT_NUMBER,
    CURRENCY_CODE,
    CUSTOMER_SK,
    ORDER_ID,
    ORDER_NUMBER,
    ORDER_DT,
    RTM_LEVEL_1,
    RTM_LEVEL_2,
    RTM_LEVEL_3,
    ORDER_COMMUNICATION_TYPE,
    ORDER_SALE_TYPE,
    CHANGE_TYPE,
    BROADBAND_CHANGE,
    BB_REMOVED_PRODUCT,
    BB_ADDED_PRODUCT,
    DSL_FIBRE,
    PREVIOUS_ACTIVE_BROADBAND,
    ACTIVE_BROADBAND_LAST_30_DAYS,
    ACTIVE_BROADBAND_LAST_12_MONTHS,
    ACTIVE_BROADBAND_BEFORE_ORDER,
    HOME_MOVE,
    ORDER_BECAME_ACTIVE,
    ACCOUNT_ACTIVE_LENGTH,
    DTV_STATUS_BEFORE_ORDER,
    DTV_BEFORE_ORDER,
    previous_dtv,
    same_day_cancel,
    DTV_AFTER_ORDER,
    PRE_ORDER_BB_STATUS_PA,
    SPORTS_ADDED,
    MOVIES_ADDED,
    FAMILY_ADDED,
    VARIETY_ADDED,
    ORIGINAL_ADDED,
    SKYQ_ADDED,
    HD_LEGACY_ADDED,
    HD_BASIC_ADDED,
    HD_PREMIUM_ADDED,
    MULTISCREEN_ADDED,
    MULTISCREEN_PLUS_ADDED,
    SKY_PLUS_ADDED,
    SKY_GO_EXTRA_ADDED,
    NOW_TV_ADDED,
    BB_UNLIMITED_ADDED,
    BB_LITE_ADDED,
    BB_FIBRE_CAP_ADDED,
    BB_FIBRE_UNLIMITED_ADDED,
    BB_FIBRE_UNLIMITED_PRO_ADDED,
    TALKU_ADDED,
    TALKW_ADDED,
    TALKF_ADDED,
    TALKA_ADDED,
    TALKP_ADDED,
    TALKO_ADDED,
    SPORTS_REMOVED,
    MOVIES_REMOVED,
    FAMILY_REMOVED,
    VARIETY_REMOVED,
    ORIGINAL_REMOVED,
    SKYQ_REMOVED,
    HD_LEGACY_REMOVED,
    HD_BASIC_REMOVED,
    HD_PREMIUM_REMOVED,
    MULTISCREEN_REMOVED,
    MULTISCREEN_PLUS_REMOVED,
    SKY_PLUS_REMOVED,
    SKY_GO_EXTRA_REMOVED,
    NOW_TV_REMOVED,
    BB_UNLIMITED_REMOVED,
    BB_LITE_REMOVED,
    BB_FIBRE_CAP_REMOVED,
    BB_FIBRE_UNLIMITED_REMOVED,
    BB_FIBRE_UNLIMITED_PRO_REMOVED,
    TALKU_REMOVED,
    TALKW_REMOVED,
    TALKF_REMOVED,
    TALKA_REMOVED,
    TALKP_REMOVED,
    TALKO_REMOVED,
    OLYMPUS_CUSTOMER,
    CONTACT_TYPE,
    SAME_ORDER_PREVIOUSLY,
    ACTUAL_OFFER_STATUS,
    INTENDED_OFFER_STATUS,
    ANY_OFFER_FLAG,
    DTV_PRIMARY_VIEWING_OFFER,
    TENURE,
    SIMPLE_SEGMENT,
    TV_REGION,
    mosaic_uk_group,
    year_week,
    WEEK_START,
    TV_OFFER_FLAG,
    COMMS_OFFER_FLAG,
    Offer_End_Status_Level_1,
    Offer_End_Status_Level_2,
    ANY_NEW_OFFER_FLAG,
    NEW_DTV_PRIMARY_VIEWING_OFFER,
    BB_ACQUISITION,
    BB_Status,
    Orders,
    Existing_BB,
    Existing_AP_AC,
    Existing_PC_AC,
    Existing_PA_AP,
    Existing_AB_AC,
    Existing_TV_Active,
    Existing_TV_Order,
    New_TV_Order,
    TV_Churn,
    SABB,
    BB_Upgrade_Orders,
    SPOTIFY_ADDED,
    SPOTIFY_REMOVED,
    UOD_ADDED,
    UOD_REMOVED,
    Netflix_Added_Product,
    Netflix_Removed_Product,
    Basic_contract_status_pre_order,
    Basic_contract_subscription_item_pre_order,
    Add_on_contract_status_pre_order,
    Add_on_contract_subscription_item_pre_order,
    Talk_contract_status_pre_order,
    Talk_contract_subscription_item_pre_order,
    BB_contract_status_pre_order,
    BB_contract_subscription_item_pre_order,
    Basic_contract_status_post_order,
    Basic_contract_subscription_item_post_order,
    BB_contract_status_post_order,
    BB_contract_subscription_item_post_order,
    Talk_contract_status_post_order,
    Talk_contract_subscription_item_post_order,
    Add_on_contract_status_post_order,
    Add_on_contract_subscription_item_post_order
    into #ECONOMETRICS_BROADBAND_OFFERS_1
    from #ECONOMETRICS_BROADBAND;
  commit work;
  select A.ACCOUNT_NUMBER,
    A.CURRENCY_CODE,
    A.CUSTOMER_SK,
    A.ORDER_ID,
    A.ORDER_NUMBER,
    A.ORDER_DT,
    A.RTM_LEVEL_1,
    A.RTM_LEVEL_2,
    A.RTM_LEVEL_3,
    A.ORDER_COMMUNICATION_TYPE,
    A.ORDER_SALE_TYPE,
    A.CHANGE_TYPE,
    A.BROADBAND_CHANGE,
    A.BB_REMOVED_PRODUCT,
    A.BB_ADDED_PRODUCT,
    A.DSL_FIBRE,
    A.PREVIOUS_ACTIVE_BROADBAND,
    A.ACTIVE_BROADBAND_LAST_30_DAYS,
    A.ACTIVE_BROADBAND_LAST_12_MONTHS,
    A.ACTIVE_BROADBAND_BEFORE_ORDER,
    A.HOME_MOVE,
    A.ORDER_BECAME_ACTIVE,
    A.ACCOUNT_ACTIVE_LENGTH,
    A.DTV_STATUS_BEFORE_ORDER,
    A.DTV_BEFORE_ORDER,
    A.previous_dtv,
    A.same_day_cancel,
    A.DTV_AFTER_ORDER,
    A.PRE_ORDER_BB_STATUS_PA,
    A.SPORTS_ADDED,
    A.MOVIES_ADDED,
    A.FAMILY_ADDED,
    A.VARIETY_ADDED,
    A.ORIGINAL_ADDED,
    A.SKYQ_ADDED,
    A.HD_LEGACY_ADDED,
    A.HD_BASIC_ADDED,
    A.HD_PREMIUM_ADDED,
    A.MULTISCREEN_ADDED,
    A.MULTISCREEN_PLUS_ADDED,
    A.SKY_PLUS_ADDED,
    A.SKY_GO_EXTRA_ADDED,
    A.NOW_TV_ADDED,
    A.BB_UNLIMITED_ADDED,
    A.BB_LITE_ADDED,
    A.BB_FIBRE_CAP_ADDED,
    A.BB_FIBRE_UNLIMITED_ADDED,
    A.BB_FIBRE_UNLIMITED_PRO_ADDED,
    A.TALKU_ADDED,
    A.TALKW_ADDED,
    A.TALKF_ADDED,
    A.TALKA_ADDED,
    A.TALKP_ADDED,
    A.TALKO_ADDED,
    A.SPORTS_REMOVED,
    A.MOVIES_REMOVED,
    A.FAMILY_REMOVED,
    A.VARIETY_REMOVED,
    A.ORIGINAL_REMOVED,
    A.SKYQ_REMOVED,
    A.HD_LEGACY_REMOVED,
    A.HD_BASIC_REMOVED,
    A.HD_PREMIUM_REMOVED,
    A.MULTISCREEN_REMOVED,
    A.MULTISCREEN_PLUS_REMOVED,
    A.SKY_PLUS_REMOVED,
    A.SKY_GO_EXTRA_REMOVED,
    A.NOW_TV_REMOVED,
    A.BB_UNLIMITED_REMOVED,
    A.BB_LITE_REMOVED,
    A.BB_FIBRE_CAP_REMOVED,
    A.BB_FIBRE_UNLIMITED_REMOVED,
    A.BB_FIBRE_UNLIMITED_PRO_REMOVED,
    A.TALKU_REMOVED,
    A.TALKW_REMOVED,
    A.TALKF_REMOVED,
    A.TALKA_REMOVED,
    A.TALKP_REMOVED,
    A.TALKO_REMOVED,
    A.OLYMPUS_CUSTOMER,
    A.CONTACT_TYPE,
    A.SAME_ORDER_PREVIOUSLY,
    A.ACTUAL_OFFER_STATUS,
    A.INTENDED_OFFER_STATUS,
    A.ANY_OFFER_FLAG,
    A.DTV_PRIMARY_VIEWING_OFFER,
    A.TENURE,
    A.SIMPLE_SEGMENT,
    A.TV_REGION,
    A.mosaic_uk_group,
    A.year_week,
    A.WEEK_START,
    B.subscription_sub_type as OFFER_SUB_TYPE,
    B.OFFER_ID,
    B.OFFER_DIM_DESCRIPTION as OFFER_DESCRIPTION,
    -- ,B.OFFER_VALUE AS MONTHLY_OFFER_VALUE
    B.Monthly_Offer_Amount as MONTHLY_OFFER_VALUE,
    -- MMC correct logic for offer values/lengths        
    DATEDIFF(month,B.Whole_Offer_Intended_Start_Dt,B.INTENDED_OFFER_END_DT) as OFFER_DURATION_MTH,
    DATEDIFF(month,B.Whole_Offer_Intended_Start_Dt,B.INTENDED_OFFER_END_DT)*B.Monthly_Offer_Amount as TOTAL_OFFER_VALUE,
    case when B.ORIG_PORTFOLIO_OFFER_ID <> '?' then 1 else 0 end as AUTO_TRANSFER_OFFER,
    A.TV_OFFER_FLAG,
    A.COMMS_OFFER_FLAG,
    Offer_End_Status_Level_1,
    Offer_End_Status_Level_2,
    A.ANY_NEW_OFFER_FLAG,
    A.NEW_DTV_PRIMARY_VIEWING_OFFER,
    A.BB_ACQUISITION,
    A.BB_Status,
    A.Orders,
    A.Existing_BB,
    A.Existing_AP_AC,
    A.Existing_PC_AC,
    A.Existing_PA_AP,
    A.Existing_AB_AC,
    A.Existing_TV_Active,
    A.Existing_TV_Order,
    A.New_TV_Order,
    A.TV_Churn,
    A.SABB,
    A.BB_Upgrade_Orders,
    A.SPOTIFY_ADDED,
    A.SPOTIFY_REMOVED,
    A.UOD_ADDED,
    A.UOD_REMOVED,
    A.Netflix_Added_Product,
    A.Netflix_Removed_Product,
    A.Basic_contract_status_pre_order,
    A.Basic_contract_subscription_item_pre_order,
    A.Add_on_contract_status_pre_order,
    A.Add_on_contract_subscription_item_pre_order,
    A.Talk_contract_status_pre_order,
    A.Talk_contract_subscription_item_pre_order,
    A.BB_contract_status_pre_order,
    A.BB_contract_subscription_item_pre_order,
    A.Basic_contract_status_post_order,
    A.Basic_contract_subscription_item_post_order,
    A.BB_contract_status_post_order,
    A.BB_contract_subscription_item_post_order,
    A.Talk_contract_status_post_order,
    A.Talk_contract_subscription_item_post_order,
    A.Add_on_contract_status_post_order,
    A.Add_on_contract_subscription_item_post_order
    into #ECONOMETRICS_BROADBAND_OFFERS
    from #ECONOMETRICS_BROADBAND_OFFERS_1 as A
      -- mmc 
      left outer join Decisioning.Offers_Software as B
      on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and A.ORDER_DT = B.Offer_Leg_CREATED_DT
      and B.Offer_Leg = 1
      and lower(B.Offer_Dim_Description) not like '%price protect%';
  commit work;
  --ADD IN HARDWARE OFFERS
  insert into #ECONOMETRICS_BROADBAND_OFFERS
    select A.ACCOUNT_NUMBER,
      A.CURRENCY_CODE,
      A.CUSTOMER_SK,
      A.ORDER_ID,
      A.ORDER_NUMBER,
      A.ORDER_DT,
      A.RTM_LEVEL_1,
      A.RTM_LEVEL_2,
      A.RTM_LEVEL_3,
      A.ORDER_COMMUNICATION_TYPE,
      A.ORDER_SALE_TYPE,
      A.CHANGE_TYPE,
      A.BROADBAND_CHANGE,
      A.BB_REMOVED_PRODUCT,
      A.BB_ADDED_PRODUCT,
      A.DSL_FIBRE,
      A.PREVIOUS_ACTIVE_BROADBAND,
      A.ACTIVE_BROADBAND_LAST_30_DAYS,
      A.ACTIVE_BROADBAND_LAST_12_MONTHS,
      A.ACTIVE_BROADBAND_BEFORE_ORDER,
      A.HOME_MOVE,
      A.ORDER_BECAME_ACTIVE,
      A.ACCOUNT_ACTIVE_LENGTH,
      A.DTV_STATUS_BEFORE_ORDER,
      A.DTV_BEFORE_ORDER,
      A.previous_dtv,
      A.same_day_cancel,
      A.DTV_AFTER_ORDER,
      A.PRE_ORDER_BB_STATUS_PA,
      A.SPORTS_ADDED,
      A.MOVIES_ADDED,
      A.FAMILY_ADDED,
      A.VARIETY_ADDED,
      A.ORIGINAL_ADDED,
      A.SKYQ_ADDED,
      A.HD_LEGACY_ADDED,
      A.HD_BASIC_ADDED,
      A.HD_PREMIUM_ADDED,
      A.MULTISCREEN_ADDED,
      A.MULTISCREEN_PLUS_ADDED,
      A.SKY_PLUS_ADDED,
      A.SKY_GO_EXTRA_ADDED,
      A.NOW_TV_ADDED,
      A.BB_UNLIMITED_ADDED,
      A.BB_LITE_ADDED,
      A.BB_FIBRE_CAP_ADDED,
      A.BB_FIBRE_UNLIMITED_ADDED,
      A.BB_FIBRE_UNLIMITED_PRO_ADDED,
      A.TALKU_ADDED,
      A.TALKW_ADDED,
      A.TALKF_ADDED,
      A.TALKA_ADDED,
      A.TALKP_ADDED,
      A.TALKO_ADDED,
      A.SPORTS_REMOVED,
      A.MOVIES_REMOVED,
      A.FAMILY_REMOVED,
      A.VARIETY_REMOVED,
      A.ORIGINAL_REMOVED,
      A.SKYQ_REMOVED,
      A.HD_LEGACY_REMOVED,
      A.HD_BASIC_REMOVED,
      A.HD_PREMIUM_REMOVED,
      A.MULTISCREEN_REMOVED,
      A.MULTISCREEN_PLUS_REMOVED,
      A.SKY_PLUS_REMOVED,
      A.SKY_GO_EXTRA_REMOVED,
      A.NOW_TV_REMOVED,
      A.BB_UNLIMITED_REMOVED,
      A.BB_LITE_REMOVED,
      A.BB_FIBRE_CAP_REMOVED,
      A.BB_FIBRE_UNLIMITED_REMOVED,
      A.BB_FIBRE_UNLIMITED_PRO_REMOVED,
      A.TALKU_REMOVED,
      A.TALKW_REMOVED,
      A.TALKF_REMOVED,
      A.TALKA_REMOVED,
      A.TALKP_REMOVED,
      A.TALKO_REMOVED,
      A.OLYMPUS_CUSTOMER,
      A.CONTACT_TYPE,
      A.SAME_ORDER_PREVIOUSLY,
      A.ACTUAL_OFFER_STATUS,
      A.INTENDED_OFFER_STATUS,
      A.ANY_OFFER_FLAG,
      A.DTV_PRIMARY_VIEWING_OFFER,
      A.TENURE,
      A.SIMPLE_SEGMENT,
      A.TV_REGION,
      A.mosaic_uk_group,
      A.year_week,
      A.WEEK_START,
      case when B.DISCOUNT_TYPE = 'OFFER' then 'HARDWARE OFFER' else B.DISCOUNT_TYPE end as OFFER_SUB_TYPE,
      B.OFFER_ID,
      B.OFFER_DESCRIPTION as OFFER_DESCRIPTION,
      B.DISCOUNT_AMOUNT as MONTHLY_OFFER_VALUE,
      cast(null as integer) as OFFER_DURATION_MTH,
      B.DISCOUNT_AMOUNT as TOTAL_OFFER_VALUE,
      0 as AUTO_TRANSFER_OFFER,
      A.TV_OFFER_FLAG,
      A.COMMS_OFFER_FLAG,
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      A.ANY_NEW_OFFER_FLAG,
      A.NEW_DTV_PRIMARY_VIEWING_OFFER,
      A.BB_ACQUISITION,
      A.BB_Status,
      A.Orders,
      A.Existing_BB,
      A.Existing_AP_AC,
      A.Existing_PC_AC,
      A.Existing_PA_AP,
      A.Existing_AB_AC,
      A.Existing_TV_Active,
      A.Existing_TV_Order,
      A.New_TV_Order,
      A.TV_Churn,
      A.SABB,
      A.BB_Upgrade_Orders,
      A.SPOTIFY_ADDED,
      A.SPOTIFY_REMOVED,
      A.UOD_ADDED,
      A.UOD_REMOVED,
      A.Netflix_Added_Product,
      A.Netflix_Removed_Product,
      Basic_contract_status_pre_order,
      Basic_contract_subscription_item_pre_order,
      Add_on_contract_status_pre_order,
      Add_on_contract_subscription_item_pre_order,
      Talk_contract_status_pre_order,
      Talk_contract_subscription_item_pre_order,
      BB_contract_status_pre_order,
      BB_contract_subscription_item_pre_order,
      Basic_contract_status_post_order,
      Basic_contract_subscription_item_post_order,
      BB_contract_status_post_order,
      BB_contract_subscription_item_post_order,
      Talk_contract_status_post_order,
      Talk_contract_subscription_item_post_order,
      Add_on_contract_status_post_order,
      Add_on_contract_subscription_item_post_order
      from #ECONOMETRICS_BROADBAND_OFFERS_1 as A
        join OFFERS_DETAILS as B
        on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
        and A.ORDER_DT = cast(B.CREATED_DATE as date);
  commit work;
  -- SUMMARIZE DATA
  delete from Decisioning.ECONOMETRICS_BROADBAND_OFFERS
    where WEEK_START between period_start and period_end;
  insert into Decisioning.ECONOMETRICS_BROADBAND_OFFERS
    select YEAR_WEEK,
      WEEK_START,
      CURRENCY_CODE,
      RTM_LEVEL_1,
      RTM_LEVEL_2,
      RTM_LEVEL_3,
      ORDER_COMMUNICATION_TYPE,
      ORDER_SALE_TYPE,
      CONTACT_TYPE,
      OLYMPUS_CUSTOMER,
      CHANGE_TYPE,
      BB_REMOVED_PRODUCT,
      BB_ADDED_PRODUCT,
      DSL_FIBRE,
      ACTIVE_BROADBAND_LAST_12_MONTHS,
      ACTIVE_BROADBAND_BEFORE_ORDER,
      HOME_MOVE,
      ORDER_BECAME_ACTIVE,
      ACCOUNT_ACTIVE_LENGTH,
      DTV_STATUS_BEFORE_ORDER,
      DTV_BEFORE_ORDER,
      previous_dtv,
      same_day_cancel,
      DTV_AFTER_ORDER,
      ANY_OFFER_FLAG,
      OFFER_SUB_TYPE,
      OFFER_DESCRIPTION,
      MONTHLY_OFFER_VALUE,
      OFFER_DURATION_MTH,
      TOTAL_OFFER_VALUE,
      AUTO_TRANSFER_OFFER,
      TENURE,
      TV_REGION,
      COUNT() as NUMBER_OF_ORDERS,
      TV_OFFER_FLAG,
      COMMS_OFFER_FLAG,
      ANY_NEW_OFFER_FLAG,
      BB_Status,
      SPORTS_ADDED,
      MOVIES_ADDED,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      SPOTIFY_ADDED,
      SPOTIFY_REMOVED,
      UOD_ADDED,
      UOD_REMOVED,
      Netflix_Added_Product,
      Netflix_Removed_Product,
      Basic_contract_status_pre_order,
      Basic_contract_subscription_item_pre_order,
      Add_on_contract_status_pre_order,
      Add_on_contract_subscription_item_pre_order,
      Talk_contract_status_pre_order,
      Talk_contract_subscription_item_pre_order,
      BB_contract_status_pre_order,
      BB_contract_subscription_item_pre_order,
      Basic_contract_status_post_order,
      Basic_contract_subscription_item_post_order,
      BB_contract_status_post_order,
      BB_contract_subscription_item_post_order,
      Talk_contract_status_post_order,
      Talk_contract_subscription_item_post_order,
      Add_on_contract_status_post_order,
      Add_on_contract_subscription_item_post_order
      from #ECONOMETRICS_BROADBAND_OFFERS
      where ANY_OFFER_FLAG >= 1
      group by YEAR_WEEK,
      WEEK_START,
      CURRENCY_CODE,
      RTM_LEVEL_1,
      RTM_LEVEL_2,
      RTM_LEVEL_3,
      ORDER_COMMUNICATION_TYPE,
      ORDER_SALE_TYPE,
      CONTACT_TYPE,
      OLYMPUS_CUSTOMER,
      CHANGE_TYPE,
      BB_REMOVED_PRODUCT,
      BB_ADDED_PRODUCT,
      DSL_FIBRE,
      ACTIVE_BROADBAND_LAST_12_MONTHS,
      ACTIVE_BROADBAND_BEFORE_ORDER,
      HOME_MOVE,
      ORDER_BECAME_ACTIVE,
      ACCOUNT_ACTIVE_LENGTH,
      DTV_STATUS_BEFORE_ORDER,
      DTV_BEFORE_ORDER,
      previous_dtv,
      same_day_cancel,
      DTV_AFTER_ORDER,
      ANY_OFFER_FLAG,
      OFFER_SUB_TYPE,
      OFFER_DESCRIPTION,
      MONTHLY_OFFER_VALUE,
      OFFER_DURATION_MTH,
      TOTAL_OFFER_VALUE,
      AUTO_TRANSFER_OFFER,
      TENURE,
      TV_REGION,
      TV_OFFER_FLAG,
      COMMS_OFFER_FLAG,
      ANY_NEW_OFFER_FLAG,
      BB_Status,
      SPORTS_ADDED,
      MOVIES_ADDED,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      SPOTIFY_ADDED,
      SPOTIFY_REMOVED,
      UOD_ADDED,
      UOD_REMOVED,
      Netflix_Added_Product,
      Netflix_Removed_Product,
      Basic_contract_status_pre_order,
      Basic_contract_subscription_item_pre_order,
      Add_on_contract_status_pre_order,
      Add_on_contract_subscription_item_pre_order,
      Talk_contract_status_pre_order,
      Talk_contract_subscription_item_pre_order,
      BB_contract_status_pre_order,
      BB_contract_subscription_item_pre_order,
      Basic_contract_status_post_order,
      Basic_contract_subscription_item_post_order,
      BB_contract_status_post_order,
      BB_contract_subscription_item_post_order,
      Talk_contract_status_post_order,
      Talk_contract_subscription_item_post_order,
      Add_on_contract_status_post_order,
      Add_on_contract_subscription_item_post_order;
  commit work
end

GO
GRANT EXECUTE ON Decisioning_Procs.Update_Econometrics_Broadband TO public;


/*
call Decisioning_Procs.Update_Econometrics_Broadband();

#create view in CITeam 

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'ECONOMETRICS_BROADBAND_ORDERS');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'ECONOMETRICS_BROADBAND_ORDERS',  'select * from Decisioning.ECONOMETRICS_BROADBAND_ORDERS');

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'ECONOMETRICS_BROADBAND_OFFERS');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'ECONOMETRICS_BROADBAND_OFFERS',  'select * from Decisioning.ECONOMETRICS_BROADBAND_OFFERS');

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'ECONOMETRICS_BROADBAND_ORDERS_ACCOUNT_LEVEL');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'ECONOMETRICS_BASE',  'select * from Decisioning.ECONOMETRICS_BROADBAND_ORDERS_ACCOUNT_LEVEL');

*/