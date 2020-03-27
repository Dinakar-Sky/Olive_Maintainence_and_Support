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
Project:        QMS
Created:        21/04/2018
Owner  :        Fractal 
---------------------------------------------------------------------------------------------------------------------------------------------------------------
Program to extract all QMS orders and offers 

***************************************************************************************************************************************************************
****                                                              Change History                                                                           ****
***************************************************************************************************************************************************************
** Change#   Date         Author    	       Description 
** --       ---------   ------------- 	 ------------------------------------
** 1        30/07/2018    Aadtiya       	   Initial release 
** 2        21/09/2018    Vikram 			   script deployed on production
***************************************************************************************************************************************************************

-----------------------------------------------------------------------DDLS------------------------------------------------------------------------------------
dba.sp_drop_table 'Decisioning','ECONOMETRICS_QMS_ORDERS_Account_Level'
dba.sp_create_table 'Decisioning','ECONOMETRICS_QMS_ORDERS_Account_Level',
   'YEAR_WEEK varchar(31) default null,'
|| 'WEEK_START date default null,'
|| 'ORDER_DT date default null, '
|| 'CURRENCY_CODE varchar(10) default null,'
|| 'RTM_LEVEL_1 varchar(50) default null,'
|| 'RTM_LEVEL_2 varchar(50) default null,'
|| 'RTM_LEVEL_3 varchar(50) default null,'
|| 'ORDER_COMMUNICATION_TYPE varchar(10) default null,'
|| 'ORDER_SALE_TYPE varchar(50) default null,'
|| 'CONTACT_TYPE varchar(20) default null,'
|| 'CONTRACT_STATUS varchar(50) default null,'
|| 'SPORTS_ADDED smallint default 0,'
|| 'MOVIES_ADDED smallint default 0,'
|| 'FAMILY_ADDED smallint default 0,'
|| 'VARIETY_ADDED smallint default 0,'
|| 'ORIGINAL_ADDED smallint default 0,'
|| 'SKYQ_ADDED smallint default 0,'
|| 'HD_LEGACY_ADDED smallint default 0,'
|| 'HD_BASIC_ADDED smallint default 0,'
|| 'HD_PREMIUM_ADDED smallint default 0,'
|| 'MULTISCREEN_ADDED smallint default 0,'
|| 'QMS_ADDED smallint default 0,'
|| 'MS_ADDED_PRODUCT varchar(30) default null,'
|| 'SKY_PLUS_ADDED smallint default 0,'
|| 'SKY_GO_EXTRA_ADDED smallint default 0,'
|| 'NOW_TV_ADDED smallint default 0,'
|| 'BB_ADDED_PRODUCT varchar(240) default null,'
|| 'TALKU_ADDED smallint default 0,'
|| 'TALKW_ADDED smallint default 0,'
|| 'TALKF_ADDED smallint default 0,'
|| 'TALKA_ADDED smallint default 0,'
|| 'TALKP_ADDED smallint default 0,'
|| 'TALKO_ADDED smallint default 0,'
|| 'TALK_ADDED_PRODUCT varchar(30) default null,'
|| 'SPORTS_REMOVED smallint default 0,'
|| 'MOVIES_REMOVED smallint default 0,'
|| 'FAMILY_REMOVED smallint default 0,'
|| 'VARIETY_REMOVED smallint default 0,'
|| 'ORIGINAL_REMOVED smallint default 0,'
|| 'SKYQ_REMOVED smallint default 0,'
|| 'HD_LEGACY_REMOVED smallint default 0,'
|| 'HD_BASIC_REMOVED smallint default 0,'
|| 'HD_PREMIUM_REMOVED smallint default 0,'
|| 'MULTISCREEN_REMOVED smallint default 0,'
|| 'QMS_RMEOVED smallint default 0,'
|| 'MS_REMOVED_PRODUCT varchar(30) default null,'
|| 'SKY_PLUS_REMOVED smallint default 0,'
|| 'SKY_GO_EXTRA_REMOVED smallint default 0,'
|| 'NOW_TV_REMOVED smallint default 0,'
|| 'BB_REMOVED_PRODUCT varchar(240) default null,'
|| 'TALKU_REMOVED smallint default 0,'
|| 'TALKW_REMOVED smallint default 0,'
|| 'TALKF_REMOVED smallint default 0,'
|| 'TALKA_REMOVED smallint default 0,'
|| 'TALKP_REMOVED smallint default 0,'
|| 'TALKO_REMOVED smallint default 0,'
|| 'TALK_REMOVED_PRODUCT varchar(30) default null,'
|| 'PRE_ORDER_TOTAL_PREMIUMS integer default 0,'
|| 'PRE_ORDER_TOTAL_SPORTS integer default 0,'
|| 'PRE_ORDER_TOTAL_MOVIES integer default 0,'
|| 'POST_ORDER_TOTAL_PREMIUMS integer default 0,'
|| 'POST_ORDER_TOTAL_SPORTS integer default 0,'
|| 'POST_ORDER_TOTAL_MOVIES integer default 0,'
|| 'ACTUAL_OFFER_STATUS varchar(15) default null,'
|| 'INTENDED_OFFER_STATUS varchar(15) default null,'
|| 'ANY_OFFER_FLAG integer default null,'
|| 'OFFER_SUB_TYPE varchar(80) default null,'
|| 'OFFER_DESCRIPTION varchar(465) default null,'
|| 'MONTHLY_OFFER_VALUE decimal(126,38) default null,'
|| 'OFFER_DURATION_MTH integer default null,'
|| 'TOTAL_OFFER_VALUE integer default null,'
|| 'AUTO_TRANSFER_OFFER smallint default null,'
|| 'TENURE varchar(20) default null,'
|| 'TV_REGION varchar(100) default null,'
||'ACCOUNT_NUMBER  varchar(100)  default null,'
||'ORDER_ID  varchar(100)  default null,'
|| 'ACTIVE_BROADBAND_BEFORE_ORDER integer default null,'
|| 'LEGACY_SPORTS_SUB_ADDED smallint default 0,'
|| 'LEGACY_SPORTS_SUB_REMOVED smallint default 0,'
|| 'LEGACY_MOVIES_SUB_ADDED smallint default 0,'
|| 'LEGACY_MOVIES_SUB_REMOVED smallint default 0,'
|| 'SPORTS_PACK_SUB_ADDED smallint default 0,'
|| 'SPORTS_PACK_SUB_REMOVED smallint default 0,'
|| 'SPORTS_PACK_ADDED smallint default 0,'
|| 'SPORTS_PACK_REMOVED smallint default 0,'
|| 'SPORTS_COMPLETE_ADDED smallint default 0,'
|| 'SPORTS_COMPLETE_REMOVED smallint default 0,'
|| 'CINEMA_ADD_ON_ADDED smallint default 0,'
|| 'CINEMA_ADD_ON_REMOVED smallint default 0,'
|| 'SPORTS_ACTION_ADDED smallint default 0,'
|| 'SPORTS_ACTION_REMOVED smallint default 0,'
|| 'SPORTS_CRICKET_ADDED smallint default 0,'
|| 'SPORTS_CRICKET_REMOVED smallint default 0,'
|| 'SPORTS_F1_ADDED smallint default 0,'
|| 'SPORTS_F1_REMOVED smallint default 0,'
|| 'SPORTS_FOOTBALL_ADDED smallint default 0,'
|| 'SPORTS_FOOTBALL_REMOVED smallint default 0,'
|| 'SPORTS_GOLF_ADDED smallint default 0,'
|| 'SPORTS_GOLF_REMOVED smallint default 0,'
|| 'SPORTS_PREMIERLEAGUE_ADDED smallint default 0,'
|| 'SPORTS_PREMIERLEAGUE_REMOVED smallint default 0,'
|| 'Pre_Order_Prems_Active tinyint default 0,'
|| 'Post_Order_Prems_Active tinyint default 0,'
|| 'Pre_Order_Sports_Active tinyint default 0,'
|| 'Post_Order_Sports_Active tinyint default 0,'
|| 'Pre_Order_Movies_Active tinyint default 0,'
|| 'Post_Order_Movies_Active tinyint default 0, '
|| 'Offer_End_Status_Level_1 varchar(30) default null, '
|| 'Offer_End_Status_Level_2 varchar(30) default null, '
|| 'ANY_NEW_OFFER_FLAG integer default null,'
||'Asia_Pack_Active tinyint default 0,'
||'MuTV_Pack_Active tinyint default 0,'
||'LTV_Pack_Active tinyint default 0,'
||'CTV_Pack_Active tinyint default 0,'
|| 'KIDS_ADDED smallint default 0,'
|| 'KIDS_REMOVED smallint default 0,'
|| 'BOXSETS_ADDED smallint default 0,'
|| 'BOXSETS_REMOVED smallint default 0,'
|| 'SPOTIFY_ADDED smallint default 0,'
|| 'SPOTIFY_REMOVED smallint default 0,'
|| 'DTV_ADDED_PRODUCT varchar(30) default null, '
|| 'DTV_REMOVED_PRODUCT varchar(30) default null, '
|| 'ACTIVE_DTV_BEFORE_ORDER smallint  default  0,'
|| 'ACCOUNT_ACTIVE_LENGTH int  default  0, '
|| 'ORDER_BECAME_ACTIVE smallint  default  0, '
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
||'Add_on_contract_subscription_item_post_order varchar(200) default null,'
||'Classic_Multiscreen_Before_Order tinyint default 0,'
||'Classic_Multiscreen_After_Order tinyint default 0,'
||'QMS_Before_Order tinyint default 0,'
||'QMS_After_Order tinyint default 0,'
||'Upgrade_Downgrade varchar(30) default null'


dba.sp_drop_table 'Decisioning','ECONOMETRICS_QMS_ORDERS'
dba.sp_create_table 'Decisioning','ECONOMETRICS_QMS_ORDERS',
   'YEAR_WEEK varchar(31) default null,'
|| 'WEEK_START date default null,'
|| 'CURRENCY_CODE varchar(10) default null,'
|| 'RTM_LEVEL_1 varchar(50) default null,'
|| 'RTM_LEVEL_2 varchar(50) default null,'
|| 'RTM_LEVEL_3 varchar(50) default null,'
|| 'ORDER_COMMUNICATION_TYPE varchar(10) default null,'
|| 'ORDER_SALE_TYPE varchar(50) default null,'
|| 'CONTACT_TYPE varchar(20) default null,'
|| 'SPORTS_ADDED smallint default 0,'
|| 'MOVIES_ADDED smallint default 0,'
|| 'HD_LEGACY_ADDED smallint default 0,'
|| 'HD_BASIC_ADDED smallint default 0,'
|| 'HD_Sports_Added smallint default 0,'
|| 'MS_ADDED_PRODUCT varchar(30) default null,'
|| 'SKY_PLUS_ADDED smallint default 0,'
|| 'SKY_GO_EXTRA_ADDED smallint default 0,'
|| 'NOW_TV_ADDED smallint default 0,'
|| 'BB_ADDED_PRODUCT varchar(240) default null,'
|| 'TALK_ADDED_PRODUCT varchar(30) default null,'
|| 'SPORTS_REMOVED smallint default 0,'
|| 'MOVIES_REMOVED smallint default 0,'
|| 'HD_LEGACY_REMOVED smallint default 0,'
|| 'HD_BASIC_REMOVED smallint default 0,'
|| 'HD_Sports_removed smallint default 0,'
|| 'MS_REMOVED_PRODUCT varchar(30) default null,'
|| 'SKY_PLUS_REMOVED smallint default 0,'
|| 'SKY_GO_EXTRA_REMOVED smallint default 0,'
|| 'NOW_TV_REMOVED smallint default 0,'
|| 'BB_REMOVED_PRODUCT varchar(240) default null,'
|| 'TALK_REMOVED_PRODUCT varchar(30) default null,'
|| 'PRE_ORDER_TOTAL_PREMIUMS integer default 0,'
|| 'PRE_ORDER_TOTAL_SPORTS integer default 0,'
|| 'PRE_ORDER_TOTAL_MOVIES integer default 0,'
|| 'POST_ORDER_TOTAL_PREMIUMS integer default 0,'
|| 'POST_ORDER_TOTAL_SPORTS integer default 0,'
|| 'POST_ORDER_TOTAL_MOVIES integer default 0,'
|| 'ACTUAL_OFFER_STATUS varchar(15) default null,'
|| 'INTENDED_OFFER_STATUS varchar(15) default null,'
|| 'ANY_OFFER_GIVEN integer default null,'
|| 'OFFER_SUB_TYPE varchar(80) default null,'
|| 'OFFER_DESCRIPTION varchar(465) default null,'
|| 'MONTHLY_OFFER_VALUE decimal(126,38) default null,'
|| 'OFFER_DURATION_MTH integer default null,'
|| 'TOTAL_OFFER_VALUE integer default null,'
|| 'AUTO_TRANSFER_OFFER smallint default null,'
|| 'TENURE varchar(20) default null,'
|| 'TV_REGION varchar(100) default null,'
|| 'NUMBER_OF_ORDERS integer default null,'
|| 'ACTIVE_BROADBAND_BEFORE_ORDER integer default null,'
|| 'LEGACY_SPORTS_SUB_ADDED smallint default 0,'
|| 'LEGACY_SPORTS_SUB_REMOVED smallint default 0,'
|| 'LEGACY_MOVIES_SUB_ADDED smallint default 0,'
|| 'LEGACY_MOVIES_SUB_REMOVED smallint default 0,'
|| 'SPORTS_PACK_SUB_ADDED smallint default 0,'
|| 'SPORTS_PACK_SUB_REMOVED smallint default 0,'
|| 'SPORTS_PACK_ADDED smallint default 0,'
|| 'SPORTS_PACK_REMOVED smallint default 0,'
|| 'SPORTS_COMPLETE_ADDED smallint default 0,'
|| 'SPORTS_COMPLETE_REMOVED smallint default 0,'
|| 'CINEMA_ADDED smallint default 0,'
|| 'CINEMA_REMOVED smallint default 0,'
|| 'SPORTS_ACTION_ADDED smallint default 0,'
|| 'SPORTS_ACTION_REMOVED smallint default 0,'
|| 'SPORTS_CRICKET_ADDED smallint default 0,'
|| 'SPORTS_CRICKET_REMOVED smallint default 0,'
|| 'SPORTS_F1_ADDED smallint default 0,'
|| 'SPORTS_F1_REMOVED smallint default 0,'
|| 'SPORTS_FOOTBALL_ADDED smallint default 0,'
|| 'SPORTS_FOOTBALL_REMOVED smallint default 0,'
|| 'SPORTS_GOLF_ADDED smallint default 0,'
|| 'SPORTS_GOLF_REMOVED smallint default 0,'
|| 'SPORTS_PREMIERLEAGUE_ADDED smallint default 0,'
|| 'SPORTS_PREMIERLEAGUE_REMOVED smallint default 0,'
|| 'ACTIVE_PREMIUM_BEFORE_ORDER tinyint default 0,'
|| 'ACTIVE_PREMIUM_AFTER_ORDER tinyint default 0,'
|| 'ACTIVE_SPORTS_BEFORE_ORDER tinyint default 0,'
|| 'ACTIVE_SPORTS_AFTER_ORDER tinyint default 0,'
|| 'ACTIVE_MOVIES_BEFORE_ORDER tinyint default 0,'
|| 'ACTIVE_MOVIES_AFTER_ORDER tinyint default 0, '
|| 'Offer_End_Status_Level_1 varchar(30) default null, '
|| 'Offer_End_Status_Level_2 varchar(30) default null, '
|| 'Any_new_offer_given integer default null,'
|| 'Asia_Pack_Active tinyint default 0,'
|| 'MuTV_Pack_Active tinyint default 0,'
|| 'LTV_Pack_Active tinyint default 0,'
|| 'CTV_Pack_Active tinyint default 0,'
|| 'SKY_KIDS_ADDED smallint default 0,'
|| 'SKY_KIDS_REMOVED smallint default 0,'
|| 'SKY_BOXSETS_ADDED smallint default 0,'
|| 'SKY_BOXSETS_REMOVED smallint default 0,'
|| 'SPOTIFY_ADDED smallint default 0,'
|| 'SPOTIFY_REMOVED smallint default 0,'
|| 'DTV_ADDED_PRODUCT varchar(30) default null, '
|| 'DTV_REMOVED_PRODUCT varchar(30) default null, '
|| 'ACTIVE_DTV_BEFORE_ORDER smallint  default  0,'
|| 'ACCOUNT_ACTIVE_LENGTH int  default  0, '
|| 'ORDER_BECAME_ACTIVE smallint  default  0, '
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
||'Add_on_contract_subscription_item_post_order varchar(200) default null,'
||'Classic_Multiscreen_Before_Order tinyint default 0,'
||'Classic_Multiscreen_After_Order tinyint default 0,'
||'QMS_Before_Order tinyint default 0,'
||'QMS_After_Order tinyint default 0,'
||'Upgrade_Downgrade varchar(30) default null'


dba.sp_drop_table 'Decisioning','ECONOMETRICS_QMS_OFFERS'
dba.sp_create_table 'Decisioning','ECONOMETRICS_QMS_OFFERS',
   'YEAR_WEEK varchar(31) default null,'
|| 'WEEK_START date default null,'
|| 'CURRENCY_CODE varchar(10) default null,'
|| 'RTM_LEVEL_1 varchar(50) default null,'
|| 'RTM_LEVEL_2 varchar(50) default null,'
|| 'RTM_LEVEL_3 varchar(50) default null,'
|| 'ORDER_COMMUNICATION_TYPE varchar(10) default null,'
|| 'ORDER_SALE_TYPE varchar(50) default null,'
|| 'CONTACT_TYPE varchar(20) default null,'
|| 'SPORTS_ADDED smallint default 0,'
|| 'MOVIES_ADDED smallint default 0,'
|| 'HD_LEGACY_ADDED smallint default 0,'
|| 'HD_BASIC_ADDED smallint default 0,'
|| 'HD_Sports_Added smallint default 0,'
|| 'MS_ADDED_PRODUCT varchar(30) default null,'
|| 'SKY_PLUS_ADDED smallint default 0,'
|| 'SKY_GO_EXTRA_ADDED smallint default 0,'
|| 'NOW_TV_ADDED smallint default 0,'
|| 'BB_ADDED_PRODUCT varchar(240) default null,'
|| 'TALK_ADDED_PRODUCT varchar(30) default null,'
|| 'SPORTS_REMOVED smallint default 0,'
|| 'MOVIES_REMOVED smallint default 0,'
|| 'HD_LEGACY_REMOVED smallint default 0,'
|| 'HD_BASIC_REMOVED smallint default 0,'
|| 'HD_Sports_removed smallint default 0,'
|| 'MS_REMOVED_PRODUCT varchar(30) default null,'
|| 'SKY_PLUS_REMOVED smallint default 0,'
|| 'SKY_GO_EXTRA_REMOVED smallint default 0,'
|| 'NOW_TV_REMOVED smallint default 0,'
|| 'BB_REMOVED_PRODUCT varchar(240) default null,'
|| 'TALK_REMOVED_PRODUCT varchar(30) default null,'
|| 'PRE_ORDER_TOTAL_PREMIUMS integer default 0,'
|| 'PRE_ORDER_TOTAL_SPORTS integer default 0,'
|| 'PRE_ORDER_TOTAL_MOVIES integer default 0,'
|| 'POST_ORDER_TOTAL_PREMIUMS integer default 0,'
|| 'POST_ORDER_TOTAL_SPORTS integer default 0,'
|| 'POST_ORDER_TOTAL_MOVIES integer default 0,'
|| 'ACTUAL_OFFER_STATUS varchar(15) default null,'
|| 'INTENDED_OFFER_STATUS varchar(15) default null,'
|| 'ANY_OFFER_GIVEN integer default null,'
|| 'OFFER_SUB_TYPE varchar(80) default null,'
|| 'OFFER_DESCRIPTION varchar(465) default null,'
|| 'MONTHLY_OFFER_VALUE decimal(126,38) default null,'
|| 'OFFER_DURATION_MTH integer default null,'
|| 'TOTAL_OFFER_VALUE integer default null,'
|| 'AUTO_TRANSFER_OFFER smallint default null,'
|| 'TENURE varchar(20) default null,'
|| 'TV_REGION varchar(100) default null,'
|| 'NUMBER_OF_OFFERS integer default null,'
|| 'ACTIVE_BROADBAND_BEFORE_ORDER integer default null,'
|| 'LEGACY_SPORTS_SUB_ADDED smallint default 0,'
|| 'LEGACY_SPORTS_SUB_REMOVED smallint default 0,'
|| 'LEGACY_MOVIES_SUB_ADDED smallint default 0,'
|| 'LEGACY_MOVIES_SUB_REMOVED smallint default 0,'
|| 'SPORTS_PACK_SUB_ADDED smallint default 0,'
|| 'SPORTS_PACK_SUB_REMOVED smallint default 0,'
|| 'SPORTS_PACK_ADDED smallint default 0,'
|| 'SPORTS_PACK_REMOVED smallint default 0,'
|| 'SPORTS_COMPLETE_ADDED smallint default 0,'
|| 'SPORTS_COMPLETE_REMOVED smallint default 0,'
|| 'CINEMA_ADDED smallint default 0,'
|| 'CINEMA_REMOVED smallint default 0,'
|| 'SPORTS_ACTION_ADDED smallint default 0,'
|| 'SPORTS_ACTION_REMOVED smallint default 0,'
|| 'SPORTS_CRICKET_ADDED smallint default 0,'
|| 'SPORTS_CRICKET_REMOVED smallint default 0,'
|| 'SPORTS_F1_ADDED smallint default 0,'
|| 'SPORTS_F1_REMOVED smallint default 0,'
|| 'SPORTS_FOOTBALL_ADDED smallint default 0,'
|| 'SPORTS_FOOTBALL_REMOVED smallint default 0,'
|| 'SPORTS_GOLF_ADDED smallint default 0,'
|| 'SPORTS_GOLF_REMOVED smallint default 0,'
|| 'SPORTS_PREMIERLEAGUE_ADDED smallint default 0,'
|| 'SPORTS_PREMIERLEAGUE_REMOVED smallint default 0,'
|| 'ACTIVE_PREMIUM_BEFORE_ORDER tinyint default 0,'
|| 'ACTIVE_PREMIUM_AFTER_ORDER tinyint default 0,'
|| 'ACTIVE_SPORTS_BEFORE_ORDER tinyint default 0,'
|| 'ACTIVE_SPORTS_AFTER_ORDER tinyint default 0,'
|| 'ACTIVE_MOVIES_BEFORE_ORDER tinyint default 0,'
|| 'ACTIVE_MOVIES_AFTER_ORDER tinyint default 0, '
|| 'Offer_End_Status_Level_1 varchar(30) default null, '
|| 'Offer_End_Status_Level_2 varchar(30) default null, '
|| 'Any_new_offer_given integer default null,'
|| 'Asia_Pack_Active tinyint default 0,'
|| 'MuTV_Pack_Active tinyint default 0,'
|| 'LTV_Pack_Active tinyint default 0,'
|| 'CTV_Pack_Active tinyint default 0,'
|| 'SKY_KIDS_ADDED smallint default 0,'
|| 'SKY_KIDS_REMOVED smallint default 0,'
|| 'SKY_BOXSETS_ADDED smallint default 0,'
|| 'SKY_BOXSETS_REMOVED smallint default 0,'
|| 'SPOTIFY_ADDED smallint default 0,'
|| 'SPOTIFY_REMOVED smallint default 0,'
|| 'DTV_ADDED_PRODUCT varchar(30) default null, '
|| 'DTV_REMOVED_PRODUCT varchar(30) default null, '
|| 'ACTIVE_DTV_BEFORE_ORDER smallint  default  0, '
|| 'ACCOUNT_ACTIVE_LENGTH int  default  0, '
|| 'ORDER_BECAME_ACTIVE smallint  default  0, '
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
||'Add_on_contract_subscription_item_post_order varchar(200) default null,'
||'Classic_Multiscreen_Before_Order tinyint default 0,'
||'Classic_Multiscreen_After_Order tinyint default 0,'
||'QMS_Before_Order tinyint default 0,'
||'QMS_After_Order tinyint default 0,'
||'Upgrade_Downgrade varchar(30) default null'

*/

setuser Decisioning_Procs
GO
DROP PROCEDURE IF EXISTS Decisioning_Procs.Update_Econometrics_QMS;
GO
create procedure Decisioning_Procs.Update_Econometrics_QMS( PERIOD_START date default null,PERIOD_END date default null ) 
sql security invoker
begin
  ---------------------------------------------------------------------------------------------------------------------
  --CREATE VARIABLES
  ---------------------------------------------------------------------------------------------------------------------
  set option Query_Temp_Space_Limit = 0;
  /*
create or replace variable PERIOD_START date;
create or replace variable PERIOD_END date;
set PERIOD_START = '2016-01-01';
set PERIOD_END = '2018-04-05';
*/
  if PERIOD_START is null then
    set PERIOD_START = (select max(week_start)-4*7 from Decisioning.ECONOMETRICS_QMS_ORDERS)
  end if;
  if PERIOD_END is null then
    set PERIOD_END = today()
  end if;
  drop table if exists #QMS;
  select ACCOUNT_NUMBER,
    Account_Currency_Code as CURRENCY_CODE, -- MMC correct currency code field
    CUSTOMER_SK,
    ORDER_ID,
    ORDER_NUMBER,
    ORDER_DT,
    cast(ORDER_DT-1 as date) as ORDER_DT_SoD, -- MMC add date to get product holdings at start of day
    RTM_LEVEL_1,
    RTM_LEVEL_2,
    RTM_LEVEL_3,
    ORDER_COMMUNICATION_TYPE,
    ORDER_SALE_TYPE, -- MMC ----------------------------------------------------------------------------------------
    SPORTS_ADDED,
    MOVIES_ADDED,
    LEGACY_SPORTS_SUB_ADDED,
    LEGACY_MOVIES_SUB_ADDED,
    LEGACY_SPORTS_ADDED,
    LEGACY_MOVIES_ADDED,
    SPORTS_PACK_SUB_ADDED,
    SPORTS_PACK_ADDED,
    SPORTS_COMPLETE_ADDED,
    CINEMA_ADD_ON_ADDED,
    FAMILY_ADDED,
    VARIETY_ADDED,
    ORIGINAL_ADDED,
    SKYQ_ADDED,
    HD_LEGACY_ADDED,
    HD_BASIC_ADDED,
    HD_PREMIUM_ADDED,
    MULTISCREEN_ADDED,
    QMS_ADDED,
    SKY_PLUS_ADDED,
    SKY_GO_EXTRA_ADDED,
    NOW_TV_ADDED,
    BB_ADDED_PRODUCT,
    TALKU_ADDED,
    TALKW_ADDED,
    TALKF_ADDED,
    TALKA_ADDED,
    TALKP_ADDED,
    TALKO_ADDED,
    SPORTS_REMOVED,
    MOVIES_REMOVED,
    LEGACY_SPORTS_SUB_REMOVED,
    LEGACY_MOVIES_SUB_REMOVED,
    LEGACY_SPORTS_REMOVED,
    LEGACY_MOVIES_REMOVED,
    SPORTS_PACK_SUB_REMOVED,
    SPORTS_PACK_REMOVED,
    SPORTS_COMPLETE_REMOVED,
    CINEMA_ADD_ON_REMOVED,
    FAMILY_REMOVED,
    VARIETY_REMOVED,
    ORIGINAL_REMOVED,
    SKYQ_REMOVED,
    HD_LEGACY_REMOVED,
    HD_BASIC_REMOVED,
    HD_PREMIUM_REMOVED,
    MULTISCREEN_REMOVED,
    QMS_REMOVED,
    SKY_PLUS_REMOVED,
    SKY_GO_EXTRA_REMOVED,
    NOW_TV_REMOVED,
    BB_REMOVED_PRODUCT,
    TALKU_REMOVED,
    TALKW_REMOVED,
    TALKF_REMOVED,
    TALKA_REMOVED,
    TALKP_REMOVED,
    TALKO_REMOVED,
    -- MMC Set pre and post order product count to 0 ------------------------------------------------
    cast(0 as integer) as PRE_ORDER_TOTAL_PREMIUMS,
    cast(0 as integer) as PRE_ORDER_TOTAL_SPORTS,
    cast(0 as integer) as PRE_ORDER_TOTAL_MOVIES, --          
    cast(0 as integer) as POST_ORDER_TOTAL_PREMIUMS,
    cast(0 as integer) as POST_ORDER_TOTAL_SPORTS,
    cast(0 as integer) as POST_ORDER_TOTAL_MOVIES,
    cast(null as varchar(20)) as CONTACT_TYPE,
    cast(null as varchar(15)) as ACTUAL_OFFER_STATUS,
    cast(null as varchar(15)) as INTENDED_OFFER_STATUS,
    0 as ANY_OFFER_FLAG,
    0 as ACTIVE_BROADBAND_BEFORE_ORDER,
    SPORTS_ACTION_ADDED,
    SPORTS_ACTION_REMOVED,
    SPORTS_CRICKET_ADDED,
    SPORTS_CRICKET_REMOVED,
    SPORTS_F1_ADDED,
    SPORTS_F1_REMOVED,
    SPORTS_FOOTBALL_ADDED,
    SPORTS_FOOTBALL_REMOVED,
    SPORTS_GOLF_ADDED,
    SPORTS_GOLF_REMOVED,
    SPORTS_PREMIERLEAGUE_ADDED,
    SPORTS_PREMIERLEAGUE_REMOVED,
    cast(0 as tinyint) as Prems_Product_Count,
    cast(0 as tinyint) as Sports_Product_Count,
    cast(0 as tinyint) as Movies_Product_Count,
    cast(0 as tinyint) as Pre_Order_Prems_Activ,
    cast(0 as tinyint) as Prems_Active,
    cast(0 as tinyint) as Pre_Order_Sports_Active,
    cast(0 as tinyint) as Sports_Active,
    cast(0 as tinyint) as Pre_Order_Movies_Active,
    cast(0 as tinyint) as Movies_Active,
    cast(null as date) as Prev_Offer_Start_Dt_Any,
    cast(null as date) as Prev_Offer_Intended_end_Dt_Any,
    cast(null as date) as Prev_Offer_Actual_End_Dt_Any,
    cast(null as date) as Curr_Offer_Start_Dt_Any,
    cast(null as date) as Curr_Offer_Intended_end_Dt_Any,
    cast(null as date) as Curr_Offer_Actual_End_Dt_Any,
    cast(null as varchar(30)) as Offer_End_Status_Level_1,
    cast(null as varchar(30)) as Offer_End_Status_Level_2,
    cast(0 as integer) as Offers_Applied_Lst_1D_Any,
    cast(0 as integer) as Offers_Applied_Lst_1D_DTV,
    cast(0 as integer) as ANY_NEW_OFFER_FLAG,
    cast(0 as tinyint) as DTV_Active,
    KIDS_ADDED,
    KIDS_REMOVED,
    BOXSETS_ADDED,
    BOXSETS_REMOVED,
    SPOTIFY_ADDED,
    SPOTIFY_REMOVED,
    DTV_ADDED_PRODUCT,
    DTV_REMOVED_PRODUCT,
    UOD_ADDED,
    UOD_REMOVED,
    Netflix_Standard_Added,
    Netflix_Standard_Removed,
    Netflix_Premium_Added,
    Netflix_Premium_Removed,
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
    cast(null as varchar(200)) as Add_on_contract_subscription_item_post_order,
    cast(0 as integer) as PRE_ORDER_Prems_Active
    into #QMS
    from Citeam.Orders_Daily as A
    where order_dt >= period_start
    and order_dt <= period_end
    and(QMS_added+QMS_removed) > 0;
  -- MMC Removed so REGRADES are included
  -- MMC Populate prems fields with Model T data -----------------------------------------------
  call Decisioning_Procs.Add_Active_Subscriber_Product_Holding('#QMS','ORDER_DT_SoD','DTV','Update Only','Sports_Active','DTV_Active'); /*,'Sports_Product_Holding'*/
  call Decisioning_Procs.Add_Active_Subscriber_Product_Holding_Econ('#QMS','ORDER_DT_SoD','Sports','Update Only','Sports_Active','Sports_Product_Count'); /*,'Sports_Product_Holding'*/
  call Decisioning_Procs.Add_Active_Subscriber_Product_Holding_Econ('#QMS','ORDER_DT_SoD','Movies','Update Only','Movies_Active','Movies_Product_Count'); /*,'Movies_Product_Holding'*/
  call Decisioning_Procs.Add_Active_Subscriber_Product_Holding_Econ('#QMS','ORDER_DT_SoD','Prems','Update Only','Prems_Active','Prems_Product_Count'); /*,'Prems_Product_Holding'*/
  -- MMC new proc calls to populate offers details ---------------------------------------------
  call Decisioning_Procs.Add_Offers_Software('#QMS','ORDER_DT_SoD','Any','Ordered',null,'Update Only','Prev_Offer_Start_Dt_Any','Prev_Offer_Intended_end_Dt_Any','Prev_Offer_Actual_End_Dt_Any','Curr_Offer_Start_Dt_Any','Curr_Offer_Intended_end_Dt_Any','Curr_Offer_Actual_End_Dt_Any');
  call Decisioning_Procs.Add_Offers_Software('#QMS','ORDER_DT','Any','Ordered','New',null,'Update Only','Offers_Applied_Lst_1D_Any');
  call Decisioning_Procs.Add_Offers_Software('#QMS','ORDER_DT','DTV','Ordered','New',null,'Update Only','Offers_Applied_Lst_1D_DTV');
  update #QMS
    set ANY_NEW_OFFER_FLAG
     = case when Offers_Applied_Lst_1D_Any > 0 then 1
    else 0
    end;
  update #QMS
    set Offers_Applied_Lst_1D_Any = 0,
    Offers_Applied_Lst_1D_DTV = 0;
  commit work;
  call Decisioning_Procs.Add_Offers_Software('#QMS','ORDER_DT','Any','Ordered','All',null,'Update Only','Offers_Applied_Lst_1D_Any');
  call Decisioning_Procs.Add_Offers_Software('#QMS','ORDER_DT','DTV','Ordered','All',null,'Update Only','Offers_Applied_Lst_1D_DTV');
  update #QMS
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
  update #QMS
    set Offer_End_Status_Level_1
     = case when Offer_End_Status_Level_2 in( 'Offer Ending in Next 1 Wks',
    'Offer Ending in Next 2-3 Wks',
    'Offer Ending in Next 4-6 Wks',
    'Offer Ended in last 1 Wks',
    'Offer Ended in last 2-3 Wks',
    'Offer Ended in last 4-6 Wks' ) then 'Offer Ending'
    when Offer_End_Status_Level_2 = 'Offer Ending in 7+ Wks' then 'On Offer'
    else 'No Offer'
    end;
  commit work;
  update #QMS
    set PRE_ORDER_TOTAL_SPORTS
     = case when SPORTS_REMOVED > 0 then LEGACY_SPORTS_REMOVED+SPORTS_PACK_REMOVED
    when SPORTS_ADDED > 0 then 0
    else Sports_Product_Count
    end,
    PRE_ORDER_TOTAL_MOVIES
     = case when MOVIES_REMOVED > 0 then LEGACY_MOVIES_REMOVED+CINEMA_ADD_ON_REMOVED
    when MOVIES_ADDED > 0 then 0
    else Movies_Product_Count
    end;
  -- Surya - Added fix for updating values which are not part of Sports pack
  update #QMS
    set PRE_ORDER_TOTAL_SPORTS
     = case when PRE_ORDER_TOTAL_SPORTS > 6 then 6
    else PRE_ORDER_TOTAL_SPORTS
    end;
  commit work;
  update #QMS
    set PRE_ORDER_TOTAL_PREMIUMS = PRE_ORDER_TOTAL_SPORTS+PRE_ORDER_TOTAL_MOVIES;
  commit work;
  update #QMS
    set PRE_ORDER_Prems_Active
     = case when PRE_ORDER_TOTAL_PREMIUMS > 0 then 1
    else 0
    end,
    PRE_ORDER_Sports_Active
     = case when PRE_ORDER_TOTAL_SPORTS > 0 then 1
    else 0
    end,
    PRE_ORDER_Movies_Active
     = case when PRE_ORDER_TOTAL_MOVIES > 0 then 1
    else 0
    end;
  commit work;
  update #QMS
    set Sports_Active = 0,
    Sports_Product_Count = 0,
    Movies_Active = 0,
    Movies_Product_Count = 0,
    Prems_Active = 0,
    Prems_Product_Count = 0;
  commit work;
  update #QMS
    set POST_ORDER_TOTAL_SPORTS
     = case when SPORTS_PACK_SUB_ADDED > 0 then SPORTS_PACK_ADDED
    when SPORTS_PACK_ADDED > 0 then Pre_Order_Total_Sports+SPORTS_PACK_ADDED
    when LEGACY_SPORTS_ADDED > 0 then LEGACY_SPORTS_ADDED
    when SPORTS_PACK_SUB_REMOVED > 0 then 0
    when SPORTS_PACK_REMOVED > 0 then Pre_Order_Total_Sports-SPORTS_PACK_REMOVED
    when LEGACY_SPORTS_REMOVED > 0 then 0
    else Pre_Order_Total_Sports
    end,
    POST_ORDER_TOTAL_MOVIES
     = case when CINEMA_ADD_ON_ADDED > 0 then CINEMA_ADD_ON_ADDED
    when LEGACY_MOVIES_ADDED > 0 then LEGACY_MOVIES_ADDED
    when CINEMA_ADD_ON_REMOVED > 0 then 0
    when LEGACY_MOVIES_REMOVED > 0 then 0
    else Pre_Order_Total_Movies
    end;
  -- Surya - Added fix for updating values which are not part of Sports pack
  update #QMS
    set POST_ORDER_TOTAL_SPORTS
     = case when POST_ORDER_TOTAL_SPORTS > 6 then 6
    else POST_ORDER_TOTAL_SPORTS
    end;
  commit work;
  update #QMS
    set POST_ORDER_TOTAL_PREMIUMS = POST_ORDER_TOTAL_SPORTS+POST_ORDER_TOTAL_MOVIES;
  commit work;
  update #QMS
    set POST_ORDER_TOTAL_PREMIUMS
     = case when POST_ORDER_TOTAL_PREMIUMS < 0 then 0
    else POST_ORDER_TOTAL_PREMIUMS
    end,
    POST_ORDER_TOTAL_SPORTS
     = case when POST_ORDER_TOTAL_SPORTS < 0 then 0
    else POST_ORDER_TOTAL_SPORTS
    end,
    POST_ORDER_TOTAL_MOVIES
     = case when POST_ORDER_TOTAL_MOVIES < 0 then 0
    else POST_ORDER_TOTAL_MOVIES
    end;
  commit work;
  update #QMS
    set Prems_Active
     = case when POST_ORDER_TOTAL_PREMIUMS > 0 then 1
    else 0
    end,
    Sports_Active
     = case when POST_ORDER_TOTAL_SPORTS > 0 then 1
    else 0
    end,
    Movies_Active
     = case when POST_ORDER_TOTAL_MOVIES > 0 then 1
    else 0
    end;
  commit work;
  ------------------------------------------------------------------------------------------------
  --ADD IN FLAG IF ACOUNT HAD BB BEFORE ORDER
  update #QMS as A
    set A.ACTIVE_BROADBAND_BEFORE_ORDER
     = case when B.BB_ACTIVE_SUBSCRIPTION = 1 then 1
    else 0
    end from
    #QMS as A
    join CITEAM.Active_Subscriber_Report as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT-1 >= B.EFFECTIVE_FROM_DT
    and A.ORDER_DT-1 < B.EFFECTIVE_TO_DT
    where B.BB_ACTIVE_SUBSCRIPTION = 1;
  /*
UPDATE #QMS a
SET a.DTV_ADDED_PRODUCT = CASE WHEN A.FAMILY_ADDED>0 THEN 'FAMILY ADDED'
WHEN A.VARIETY_ADDED>0 THEN 'VARIETY ADDED'
WHEN A.ORIGINAL_ADDED>0 THEN 'ORIGINAL ADDED'
WHEN A.SKYQ_ADDED>0 THEN 'SKYQ_ADDED'
ELSE '' END


FROM #QMS A ;


UPDATE #QMS A
SET a.DTV_REMOVED_PRODUCT = CASE WHEN A.FAMILY_REMOVED>0 THEN 'FAMILY REMOVED'
WHEN A.VARIETY_REMOVED>0 THEN 'VARIETY REMOVED'
WHEN A.ORIGINAL_REMOVED>0 THEN 'ORIGINAL REMOVED'
WHEN A.SKYQ_REMOVED>0 THEN 'SKYQ REMOVED'
ELSE '' END
FROM #QMS A ;
*/
  --------------------------------------------------------------------------------------------------
  ---------Contract Flags Update-------
  --------------------------------------------------------------------------------------------------
  update #QMS as qms
    set qms.Basic_contract_status_pre_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    qms.Basic_contract_subscription_item_pre_order = ctr.Agreement_Item_Type from
    #QMS as qms
    left outer join CITEAM.DM_Contracts as ctr
    on qms.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and qms.order_dt-1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Primary DTV' ) ;
  update #QMS as qms
    set qms.Add_on_contract_status_pre_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    qms.Add_on_contract_subscription_item_pre_order = ctr.Agreement_Item_Type from
    #QMS as qms
    left outer join CITEAM.DM_Contracts as ctr
    on qms.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and qms.order_dt-1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Secondary DTV','Sky Enhanced Cap Subs' ) ;
  update #QMS as qms
    set qms.Talk_contract_status_pre_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    qms.Talk_contract_subscription_item_pre_order = ctr.Agreement_Item_Type from
    #QMS as qms
    left outer join CITEAM.DM_Contracts as ctr
    on qms.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and qms.order_dt-1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Sky Talk' ) ;
  update #QMS as qms
    set qms.BB_contract_status_pre_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    qms.BB_contract_subscription_item_pre_order = case when ctr.CONTRACT_STATUS in( 'In Contract' ) then ctr.Agreement_Item_Type else null end from
    #QMS as qms
    left outer join CITEAM.DM_Contracts as ctr
    on qms.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and qms.order_dt-1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Broadband' ) ;
  ---
  update #QMS as A
    set A.Basic_contract_status_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1 else 0 end,
    A.Basic_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #QMS as A
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
  update #QMS as A
    set A.Basic_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.Basic_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #QMS as A
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
  update #QMS as prem
    set prem.Basic_contract_status_post_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    prem.Basic_contract_subscription_item_post_order = case when ctr.CONTRACT_STATUS in( 'In Contract' ) then ctr.Agreement_Item_Type else null end from
    #QMS as prem
    left outer join CITEAM.DM_Contracts as ctr
    on prem.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and prem.order_dt+1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and ctr.subscription_type in( 'Primary DTV' ) and prem.Basic_contract_status_post_order <> 1;
  ---
  update #QMS as A
    set A.BB_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.BB_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #QMS as A
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
  update #QMS as A
    set A.BB_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.BB_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #QMS as A
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
  update #QMS as prem
    set prem.BB_contract_status_post_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    prem.BB_contract_subscription_item_post_order = case when ctr.CONTRACT_STATUS in( 'In Contract' ) then ctr.Agreement_Item_Type else null end from
    #QMS as prem
    left outer join CITEAM.DM_Contracts as ctr
    on prem.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and prem.order_dt+1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and ctr.subscription_type in( 'Broadband' ) and prem.BB_contract_status_post_order <> 1;
  --
  update #QMS as A
    set A.Talk_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.Talk_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #QMS as A
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
  update #QMS as A
    set A.Talk_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.Talk_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #QMS as A
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
  update #QMS as prem
    set prem.Talk_contract_status_post_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    prem.Talk_contract_subscription_item_post_order = case when ctr.CONTRACT_STATUS in( 'In Contract' ) then ctr.Agreement_Item_Type else null end from
    #QMS as prem
    left outer join CITEAM.DM_Contracts as ctr
    on prem.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and prem.order_dt+1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Sky Talk' ) and prem.Talk_contract_status_post_order <> 1;
  ---
  update #QMS as A
    set A.Add_on_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.Add_on_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #QMS as A
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
    where(A.SPORTS_ADDED+A.MOVIES_ADDED+A.KIDS_ADDED+A.BOXSETS_ADDED+A.SKYQ_ADDED+A.HD_LEGACY_ADDED+A.HD_BASIC_ADDED+A.HD_PREMIUM_ADDED+A.MULTISCREEN_ADDED+A.QMS_ADDED+A.SKY_PLUS_ADDED+A.SKY_GO_EXTRA_ADDED) >= 1 and D.CONTRACT_STATUS in( 'In Contract' ) ;
  update #QMS as A
    set A.Add_on_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.Add_on_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #QMS as A
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
    where(A.SPORTS_ADDED+A.MOVIES_ADDED+A.KIDS_ADDED+A.BOXSETS_ADDED+A.SKYQ_ADDED+A.HD_LEGACY_ADDED+A.HD_BASIC_ADDED+A.HD_PREMIUM_ADDED+A.MULTISCREEN_ADDED+A.QMS_ADDED+A.SKY_PLUS_ADDED+A.SKY_GO_EXTRA_ADDED) >= 1 and D.CONTRACT_STATUS in( 'In Contract' ) and A.Add_on_contract_status_post_order <> 1;
  update #QMS as prem
    set prem.Add_on_contract_status_post_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    prem.Add_on_contract_subscription_item_post_order = case when ctr.CONTRACT_STATUS in( 'In Contract' ) then ctr.Agreement_Item_Type else null end from
    #QMS as prem
    left outer join CITEAM.DM_Contracts as ctr
    on prem.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and prem.order_dt+1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Secondary DTV','Sky Enhanced Cap Subs' ) and prem.Add_on_contract_status_post_order <> 1;
  ------------------------------------------------------------------------------
  select distinct A.ACCOUNT_NUMBER,
    A.ORDER_DT,
    A.ORDER_COMMUNICATION_TYPE,
    MIN(
    case when C.ACCOUNT_NUMBER is not null then '1.TA'
    when D.ACCOUNT_NUMBER is not null then '2.PAT'
    when SUBSTRING(B.contact_channel,1,1) = 'I' then '3.INBOUND '+A.ORDER_COMMUNICATION_TYPE
    when SUBSTRING(B.contact_channel,1,1) = 'O' then '4.OUTBOUND '+A.ORDER_COMMUNICATION_TYPE
    else '5. '+A.ORDER_COMMUNICATION_TYPE
    end) as CONTACT_TYPE
    into #QMS_CONTACT_TYPE
    from #QMS as A
      left outer join cust_contact as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and A.ORDER_DT = B.CREATED_DATE
      left outer join cust_change_attempt as C on A.ACCOUNT_NUMBER = C.ACCOUNT_NUMBER
      and A.ORDER_DT = C.CREATED_DT
      and C.change_attempt_type = 'CANCELLATION ATTEMPT'
      and C.created_by_id not in( 'dpsbtprd',
      'batchuser' ) 
      and C.subscription_sub_type in( 'DTV Primary Viewing' ) 
      and C.Wh_Attempt_Outcome_Description_1 in( 'Turnaround Saved',
      'Legacy Save',
      'Turnaround Not Saved',
      'Legacy Fail',
      'Home Move Saved',
      'Home Move Not Saved',
      'Home Move Accept Saved' ) 
      left outer join cust_change_attempt as D on A.ACCOUNT_NUMBER = D.ACCOUNT_NUMBER
      and A.ORDER_DT = D.CREATED_DT
      and D.change_attempt_type = 'DOWNGRADE ATTEMPT'
      and D.subscription_sub_type = 'DTV Primary Viewing'
      and D.created_by_id not in( 'dpsbtprd',
      'batchuser' ) 
      and D.Wh_Attempt_Outcome_Description_1 in( 'PAT No Save',
      'PAT Partial Save',
      'PAT Save' ) 
      and D.Wh_Attempt_Reason_Description_1 <> 'Turnaround'
    group by A.ACCOUNT_NUMBER,
    A.ORDER_DT,
    A.ORDER_COMMUNICATION_TYPE;
  --UPDATE PREMIUMS TABLE
  update #QMS as A
    set A.CONTACT_TYPE = B.CONTACT_TYPE from
    #QMS_CONTACT_TYPE as B
    where A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT = B.ORDER_DT;
  --ADD ON WHETHER THE ACCOUNT HAS PERFORMED THE SAME PREMIUM CHANGE BEFORE
  select *
    into #QMS2
    from #QMS as AA;
  ---------------------------------------------------------------------------------------------------------------------
  --ADD ON OFFER STATUS FOR ACCOUNTS
  ---------------------------------------------------------------------------------------------------------------------
  select distinct D.ACCOUNT_NUMBER,
    D.ORDER_DT,
    case when D.ACTUAL_OFFER_STATUS = 2 then 'Offer End'
    when D.ACTUAL_OFFER_STATUS = 1 then 'On Offer'
    else 'No Offer'
    end as ACTUAL_OFFER_STATUS,
    case when D.INTENDED_OFFER_STATUS = 2 then 'Offer End'
    when D.INTENDED_OFFER_STATUS = 1 then 'On Offer'
    else 'No Offer'
    end as INTENDED_OFFER_STATUS into #QMS_OFFER_STATUS
    from(select distinct A.ACCOUNT_NUMBER,
        A.ORDER_DT,
        MAX(
        case when B.WHOLE_OFFER_END_DT_ACTUAL <> A.ORDER_DT
        and A.ORDER_DT-55 <= B.WHOLE_OFFER_END_DT_ACTUAL
        and A.ORDER_DT+35 >= B.WHOLE_OFFER_END_DT_ACTUAL then 2
        when B.WHOLE_OFFER_END_DT_ACTUAL = A.ORDER_DT
        and A.ORDER_DT-55 <= B.Intended_Offer_End_Dt
        and A.ORDER_DT+35 >= B.Intended_Offer_End_Dt then 2
        when B.WHOLE_OFFER_END_DT_ACTUAL is not null then 1
        else 0
        end) as ACTUAL_OFFER_STATUS,
        MAX(
        case when A.ORDER_DT-55 <= C.Intended_Offer_End_Dt
        and A.ORDER_DT+35 >= C.Intended_Offer_End_Dt then 2
        when C.Intended_Offer_End_Dt is not null then 1
        else 0
        end) as INTENDED_OFFER_STATUS
        from #QMS2 as A
          left outer join Decisioning.Offers_Software as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
          and A.ORDER_DT > B.WHOLE_OFFER_START_DT_ACTUAL
          and A.ORDER_DT-55 <= B.WHOLE_OFFER_END_DT_ACTUAL
          and lower(B.OFFER_DIM_DESCRIPTION) not like '%price protect%'
          and B.WHOLE_OFFER_AMOUNT_ACTUAL < 0
          left outer join Decisioning.Offers_Software as C on A.ACCOUNT_NUMBER = C.ACCOUNT_NUMBER
          and A.ORDER_DT >= C.Offer_Leg_Start_Dt_Actual
          and A.ORDER_DT-55 <= C.Whole_Offer_Intended_Start_Dt
          and lower(C.offer_dim_description) not like 'price protect%'
          and C.WHOLE_OFFER_AMOUNT_ACTUAL < 0
        group by A.ACCOUNT_NUMBER,
        A.ORDER_DT) as D;
  -- UPDATE TABLE
  update #QMS2 as A
    set A.ACTUAL_OFFER_STATUS = B.ACTUAL_OFFER_STATUS,
    A.INTENDED_OFFER_STATUS = B.INTENDED_OFFER_STATUS from
    #QMS_OFFER_STATUS as B
    where A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT = B.ORDER_DT;
  -- ADD FLAG IF ORDER CAME WITH ANY OFFER
  -- MMC Correct logic for Any_Offer flag using data provided by proc
  update #QMS2 as A
    set A.ANY_OFFER_FLAG
     = case when Offers_Applied_Lst_1D_Any > 0 then 1
    else 0
    end;
  -- ADD OFFER DATA TO BUNDLE DATA
  select A.*,
    cast(null as varchar(100)) as OFFER_SUB_TYPE,
    cast(null as integer) as OFFER_ID,
    cast(null as varchar(100)) as OFFER_DESCRIPTION,
    cast(null as real) as MONTHLY_OFFER_VALUE,
    cast(null as integer) as OFFER_DURATION_MTH,
    cast(null as real) as TOTAL_OFFER_VALUE,
    cast(null as integer) as AUTO_TRANSFER_OFFER into #QMS3
    from #QMS2 as A;
  -- ADD ON CUSTOMER DATA AND WEEK DATA AND OUTPUT
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
    A.ORDER_SALE_TYPE,
    -- A.UPGRADE_DOWNGRADE ,
    -- A.PREMIUM_CHANGE ,
    A.SPORTS_ADDED,
    A.MOVIES_ADDED,
    A.FAMILY_ADDED,
    A.VARIETY_ADDED,
    A.ORIGINAL_ADDED,
    A.SKYQ_ADDED,
    case when A.HD_LEGACY_ADDED > 1 then 1 else A.HD_LEGACY_ADDED end as HD_LEGACY_ADDED,
    case when A.HD_BASIC_ADDED > 1 then 1 else A.HD_BASIC_ADDED end as HD_BASIC_ADDED,
    case when A.HD_PREMIUM_ADDED > 1 then 1 else A.HD_PREMIUM_ADDED end as HD_PREMIUM_ADDED,
    case when A.MULTISCREEN_ADDED > 1 then 1 else A.MULTISCREEN_ADDED end as MULTISCREEN_ADDED,
    case when A.QMS_ADDED > 1 then 1 else A.QMS_ADDED end as QMS_ADDED,
    case when A.MULTISCREEN_ADDED > 0 then 'CLASSIC_MULTISCREEN' when A.QMS_ADDED > 0 then 'QMS' end as MS_ADDED_PRODUCT,
    case when A.SKY_PLUS_ADDED > 1 then 1 else A.SKY_PLUS_ADDED end as SKY_PLUS_ADDED,
    case when A.SKY_GO_EXTRA_ADDED > 1 then 1 else A.SKY_GO_EXTRA_ADDED end as SKY_GO_EXTRA_ADDED,
    case when A.NOW_TV_ADDED > 1 then 1 else A.NOW_TV_ADDED end as NOW_TV_ADDED,
    A.BB_ADDED_PRODUCT,
    A.TALKU_ADDED,
    A.TALKW_ADDED,
    A.TALKF_ADDED,
    A.TALKA_ADDED,
    A.TALKP_ADDED,
    A.TALKO_ADDED,
    --,CASE WHEN (A.TALKU_ADDED + A.TALKW_ADDED + A.TALKF_ADDED + A.TALKA_ADDED + A.TALKP_ADDED +A.TALKO_ADDED)>1 THEN 1 ELSE 0 END as TALK_ADDED,
    --CASE WHEN A.TALKU_ADDED THEN 'TALKU_ADDED' CASE WHEN A.TALKW_ADDED THEN 'TALKW_ADDED' WHEN A.TALKF_ADDED THEN 'TALKF_ADDED' CASE WHEN A.TALKA_ADDED THEN 'TALKA_ADDED'
    case when TALKU_ADDED > 0 then 'TALK UNLIMITED' when TALKW_ADDED > 0 then 'TALK WEEKEND' when TALKF_ADDED > 0 then 'TALKF FREETIME' when TALKA_ADDED > 0 then 'TALKA ANYTIME'
    when TALKP_ADDED > 0 then 'TALK PAY AS YOU GO' when TALKO_ADDED > 0 then 'TALK OFF PEAK' else null end as TALK_ADDED,
    A.SPORTS_REMOVED,
    A.MOVIES_REMOVED,
    A.FAMILY_REMOVED,
    A.VARIETY_REMOVED,
    A.ORIGINAL_REMOVED,
    A.SKYQ_REMOVED,
    case when A.HD_LEGACY_REMOVED > 1 then 1 else A.HD_LEGACY_REMOVED end as HD_LEGACY_REMOVED,
    case when A.HD_BASIC_REMOVED > 1 then 1 else A.HD_BASIC_REMOVED end as HD_BASIC_REMOVED,
    case when A.HD_PREMIUM_REMOVED > 1 then 1 else A.HD_PREMIUM_REMOVED end as HD_PREMIUM_REMOVED,
    case when A.MULTISCREEN_REMOVED > 1 then 1 else A.MULTISCREEN_REMOVED end as MULTISCREEN_REMOVED,
    case when A.QMS_REMOVED > 1 then 1 else A.QMS_REMOVED end as QMS_REMOVED,
    case when A.MULTISCREEN_REMOVED > 0 then 'CLASSIC_MULTISCREEN' when A.QMS_REMOVED > 0 then 'QMS' end as MS_REMOVED_PRODUCT,
    case when A.SKY_PLUS_REMOVED > 1 then 1 else A.SKY_PLUS_REMOVED end as SKY_PLUS_REMOVED,
    case when A.SKY_GO_EXTRA_REMOVED > 1 then 1 else A.SKY_GO_EXTRA_REMOVED end as SKY_GO_EXTRA_REMOVED,
    case when A.NOW_TV_REMOVED > 1 then 1 else A.NOW_TV_REMOVED end as NOW_TV_REMOVED,
    A.BB_REMOVED_PRODUCT,
    A.TALKU_REMOVED,
    A.TALKW_REMOVED,
    A.TALKF_REMOVED,
    A.TALKA_REMOVED,
    A.TALKP_REMOVED,
    A.TALKO_REMOVED,
    case when TALKU_REMOVED > 0 then 'TALK UNLIMITED' when TALKW_REMOVED > 0 then 'TALK WEEKEND' when TALKF_REMOVED > 0 then 'TALKF FREETIME' when TALKA_REMOVED > 0 then 'TALKA ANYTIME'
    when TALKP_REMOVED > 0 then 'TALK PAY AS YOU GO' when TALKO_REMOVED > 0 then 'TALK OFF PEAK' else null end as TALK_REMOVED,
    A.PRE_ORDER_TOTAL_PREMIUMS,
    A.PRE_ORDER_TOTAL_SPORTS,
    A.PRE_ORDER_TOTAL_MOVIES,
    A.POST_ORDER_TOTAL_PREMIUMS,
    A.POST_ORDER_TOTAL_SPORTS,
    A.POST_ORDER_TOTAL_MOVIES,
    A.CONTACT_TYPE,
    cast(null as varchar(50)) as CONTRACT_STATUS,
    A.ACTUAL_OFFER_STATUS,
    A.INTENDED_OFFER_STATUS,
    A.ANY_OFFER_FLAG,
    A.OFFER_SUB_TYPE,
    A.OFFER_ID,
    A.OFFER_DESCRIPTION,
    A.MONTHLY_OFFER_VALUE,
    A.OFFER_DURATION_MTH,
    A.TOTAL_OFFER_VALUE,
    A.AUTO_TRANSFER_OFFER,
    cast(null as varchar(45)) as TENURE,
    cast(null as varchar(45)) as TV_REGION,
    0 as ACCOUNT_ACTIVE_LENGTH,
    right(cast(C.subs_year as varchar),2) || '/' || right(cast(C.subs_year+1 as varchar),2) || '-'
     || case when C.subs_week_of_year < 10 then '0' || cast(C.subs_week_of_year as varchar)
    else cast(C.subs_week_of_year as varchar)
    end as year_week,
    A.ORDER_DT as WEEK_START,
    A.ACTIVE_BROADBAND_BEFORE_ORDER,
    -- MMC new prems fields ------------------------------------------------------------------------
    A.LEGACY_SPORTS_SUB_ADDED,
    A.LEGACY_SPORTS_SUB_REMOVED,
    A.LEGACY_MOVIES_SUB_ADDED,
    A.LEGACY_MOVIES_SUB_REMOVED,
    A.LEGACY_SPORTS_ADDED,
    A.LEGACY_SPORTS_REMOVED,
    A.LEGACY_MOVIES_ADDED,
    A.LEGACY_MOVIES_REMOVED,
    A.SPORTS_PACK_SUB_ADDED,
    A.SPORTS_PACK_SUB_REMOVED,
    A.SPORTS_PACK_ADDED,
    A.SPORTS_PACK_REMOVED,
    case when A.SPORTS_COMPLETE_ADDED > 1 then 1 else A.SPORTS_COMPLETE_ADDED end as SPORTS_COMPLETE_ADDED,
    case when A.SPORTS_COMPLETE_REMOVED > 1 then 1 else A.SPORTS_COMPLETE_REMOVED end as SPORTS_COMPLETE_REMOVED,
    A.CINEMA_ADD_ON_ADDED,
    A.CINEMA_ADD_ON_REMOVED,
    -- A.SPORTS_CONTRACT_ADDED ,
    --A.SPORTS_CONTRACT_REMOVED ,
    case when A.SPORTS_ACTION_ADDED > 1 then 1 else A.SPORTS_ACTION_ADDED end as SPORTS_ACTION_ADDED,
    case when A.SPORTS_ACTION_REMOVED > 1 then 1 else A.SPORTS_ACTION_REMOVED end as SPORTS_ACTION_REMOVED,
    case when A.SPORTS_CRICKET_ADDED > 1 then 1 else A.SPORTS_CRICKET_ADDED end as SPORTS_CRICKET_ADDED,
    case when A.SPORTS_CRICKET_REMOVED > 1 then 1 else A.SPORTS_CRICKET_REMOVED end as SPORTS_CRICKET_REMOVED,
    case when A.SPORTS_F1_ADDED > 1 then 1 else A.SPORTS_F1_ADDED end as SPORTS_F1_ADDED,
    case when A.SPORTS_F1_REMOVED > 1 then 1 else A.SPORTS_F1_REMOVED end as SPORTS_F1_REMOVED,
    case when A.SPORTS_FOOTBALL_ADDED > 1 then 1 else A.SPORTS_FOOTBALL_ADDED end as SPORTS_FOOTBALL_ADDED,
    case when A.SPORTS_FOOTBALL_REMOVED > 1 then 1 else A.SPORTS_FOOTBALL_REMOVED end as SPORTS_FOOTBALL_REMOVED,
    case when A.SPORTS_GOLF_ADDED > 1 then 1 else A.SPORTS_GOLF_ADDED end as SPORTS_GOLF_ADDED,
    case when A.SPORTS_GOLF_REMOVED > 1 then 1 else A.SPORTS_GOLF_REMOVED end as SPORTS_GOLF_REMOVED,
    case when A.SPORTS_PREMIERLEAGUE_ADDED > 1 then 1 else A.SPORTS_PREMIERLEAGUE_ADDED end as SPORTS_PREMIERLEAGUE_ADDED,
    case when A.SPORTS_PREMIERLEAGUE_REMOVED > 1 then 1 else A.SPORTS_PREMIERLEAGUE_REMOVED end as SPORTS_PREMIERLEAGUE_REMOVED,
    A.Pre_Order_Prems_Active,
    A.Prems_Active as Post_Order_Prems_Active,
    A.Pre_Order_Sports_Active,
    A.Sports_Active as Post_Order_Sports_Active,
    A.Pre_Order_Movies_Active,
    A.Movies_Active as Post_Order_Movies_Active,
    A.Offer_End_Status_Level_1,
    A.Offer_End_Status_Level_2,
    A.ANY_NEW_OFFER_FLAG,
    cast(0 as tinyint) as Asia_Pack_Active,
    cast(0 as tinyint) as MuTV_Pack_Active,
    cast(0 as tinyint) as LTV_Pack_Active,
    cast(0 as tinyint) as CTV_Pack_Active,
    case when A.KIDS_ADDED > 1 then 1 else A.KIDS_ADDED end as KIDS_ADDED,
    case when A.KIDS_REMOVED > 1 then 1 else A.KIDS_REMOVED end as KIDS_REMOVED,
    case when A.BOXSETS_ADDED > 1 then 1 else A.BOXSETS_ADDED end as BOXSETS_ADDED,
    case when A.BOXSETS_REMOVED > 1 then 1 else A.BOXSETS_REMOVED end as BOXSETS_REMOVED,
    A.SPOTIFY_ADDED,
    A.SPOTIFY_REMOVED,
    A.DTV_ADDED_PRODUCT,
    A.DTV_REMOVED_PRODUCT,
    A.DTV_Active,
    cast(0 as tinyint) as ACTIVE_DTV_BEFORE_ORDER,
    cast(0 as tinyint) as ORDER_BECAME_ACTIVE,
    UOD_ADDED,
    UOD_REMOVED,
    case when A.Netflix_Standard_Added > 0 then 'Netflix_Standard' when A.Netflix_Premium_Added > 0 then 'Netflix_Premium' else '' end as Netflix_Added_Product,
    case when A.Netflix_Standard_Removed > 0 then 'Netflix_Standard' when A.Netflix_Premium_Removed > 0 then 'Netflix_Premium' else '' end as Netflix_Removed_Product,
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
    Add_on_contract_subscription_item_post_order,
    cast(0 as tinyint) as Classic_Multiscreen_Before_Order,
    cast(0 as tinyint) as Classic_Multiscreen_After_Order,
    cast(0 as tinyint) as QMS_Before_Order,
    cast(0 as tinyint) as QMS_After_Order,
    cast(null as varchar(30)) as Upgrade_Downgrade
    into #ECONOMETRICS_QMS --MMC Create as temp table rather than perm table in CITeam
    from #QMS3 as A
      left outer join sky_calendar as C on A.ORDER_DT = C.CALENDAR_DATE;
  update #ECONOMETRICS_QMS as aa
    set Classic_Multiscreen_Before_Order = 1 from
    #ECONOMETRICS_QMS as aa
    join CITeam.active_subscriber_report as bb
    on aa.account_number = bb.account_number
    where aa.order_dt-1 between bb.effective_from_dt and bb.effective_to_dt-1
    and product_holding in( 'MS' ) ;
  update #ECONOMETRICS_QMS as aa
    set QMS_Before_Order = 1 from
    #ECONOMETRICS_QMS as aa
    join CITeam.active_subscriber_report as bb
    on aa.account_number = bb.account_number
    where aa.order_dt-1 between bb.effective_from_dt and bb.effective_to_dt-1
    and product_holding in( 'Sky Q MS+' ) ;
  update #ECONOMETRICS_QMS as aa
    set Classic_Multiscreen_After_Order = 1 from
    #ECONOMETRICS_QMS as aa
    join CITeam.active_subscriber_report as bb
    on aa.account_number = bb.account_number
    where aa.order_dt between bb.effective_from_dt and bb.effective_to_dt-1
    and product_holding in( 'MS' ) ;
  update #ECONOMETRICS_QMS as aa
    set QMS_After_Order = 1 from
    #ECONOMETRICS_QMS as aa
    join CITeam.active_subscriber_report as bb
    on aa.account_number = bb.account_number
    where aa.order_dt between bb.effective_from_dt and bb.effective_to_dt-1
    and product_holding in( 'Sky Q MS+' ) ;
  -- UPDATE WEEK START
  select right(cast(subs_year as varchar),2) || '/' || right(cast(subs_year+1 as varchar),2) || '-'
     || case when subs_week_of_year < 10 then '0' || cast(subs_week_of_year as varchar)
    else cast(subs_week_of_year as varchar)
    end as year_week,
    min(calendar_date) as week_start into #weeks
    from sky_calendar as cal
    group by year_week;
  update #ECONOMETRICS_QMS as a
    set a.week_start = b.week_start from
    #weeks as b
    where a.year_week = b.year_week;
  ------------------------------------------------------------------------------------------------------------------
  --FLAG if Order was activated by Order date
  ------------------------------------------------------------------------------------------------------------------
  drop table if exists #QMS_ORDER;
  select A.ACCOUNT_NUMBER,
    A.ORDER_ID,
    A.ORDER_DT,
    coalesce(MIN(B.ORDER_DT),'9999-09-09') as NEXT_ORDER_DT into #QMS_ORDER
    from #ECONOMETRICS_QMS as A
      left outer join #ECONOMETRICS_QMS as B
      on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and A.ORDER_DT < B.ORDER_DT
    group by A.ACCOUNT_NUMBER,
    A.ORDER_ID,
    A.ORDER_DT;
  drop table if exists #ASR;
  select row_number() over(order by account_number asc,effective_from_dt asc) as HOLDINGS_ID,ACCOUNT_NUMBER,MS_ACTIVE_SUBSCRIPTION,effective_from_dt,Product_holding
    into #ASR
    from CITeam.Active_Subscriber_Report --where effective_to_dt>='2012-01-01'
    order by ACCOUNT_NUMBER asc,effective_from_dt asc;
  drop table if exists #QMS_HOLDINGS_EVENTS;
  select A.ACCOUNT_NUMBER,
    A.effective_from_dt into #QMS_HOLDINGS_EVENTS
    from #ASR as A
      left outer join #ASR as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and A.HOLDINGS_ID-1 = B.HOLDINGS_ID
      and A.Product_holding = 'Sky Q MS+'
    where A.MS_ACTIVE_SUBSCRIPTION = 1;
  drop table if exists #QMS_UPDATE;
  select A.* into #QMS_UPDATE
    from #QMS_ORDER as A
      join #QMS_HOLDINGS_EVENTS as B
      on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and B.effective_from_dt between A.ORDER_DT and A.NEXT_ORDER_DT;
  update #ECONOMETRICS_QMS as A
    set A.ORDER_BECAME_ACTIVE = 1 from
    #QMS_UPDATE as B
    where A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT = B.ORDER_DT;
  ------------------------------------------------------------------------------------------------------------------
  ------------------------------------------------------------------------------------------------------------------
  --FLAG how long the account was active after the Order
  drop table if exists #ACCOUNT_ACTIVE;
  select A.ACCOUNT_NUMBER,
    A.ORDER_DT,
    coalesce(MIN(B.EFFECTIVE_FROM_DT),TODAY()) as ACTIVE_DT
    into #ACCOUNT_ACTIVE
    from #ECONOMETRICS_QMS as A
      left outer join CITEAM.Active_subscriber_report as B
      on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and A.ORDER_DT < B.EFFECTIVE_TO_DT
      and B.MS_Active_subscription = 1
      and B.Product_holding = 'Sky Q MS+'
    group by A.ACCOUNT_NUMBER,
    A.ORDER_DT;
  drop table if exists #dtv1;
  select account_number,effective_from_dt,effective_to_dt
    into #dtv1
    from CITEAM.Active_subscriber_report as B
    where B.MS_active_subscription = 1 and B.Product_holding = 'Sky Q MS+'
    order by account_number asc,effective_from_dt asc,effective_to_dt asc;
  drop table if exists #dtv2;
  select account_number,effective_from_dt,effective_to_dt,LEAD(effective_from_dt,1) over(partition by ACCOUNT_NUMBER order by effective_from_dt asc) as SORT_Lead,
    case when(SORT_Lead <> effective_to_dt or SORT_Lead is null) then 1 else 0 end as error,
    case when error = 1 then effective_to_dt else null end as max_effective_to_dt
    into #dtv2
    from #dtv1
    order by effective_from_dt asc;
  drop table if exists #dtv3;
  select *,row_number() over(partition by account_number order by max_effective_to_dt desc) as row_num
    into #dtv3
    from #dtv2
    where error = 1;
  drop table if exists #dtv_final;
  select aa.account_number,aa.effective_from_dt,aa.effective_to_dt,aa.sort_lead,aa.error,aa.max_effective_to_dt,count() as row_num
    into #dtv_final
    from #dtv2 as aa
      join #dtv3 as bb
      on aa.account_number = bb.account_number
      and aa.effective_to_dt <= bb.max_effective_to_dt
    where aa.error = 0
    group by aa.account_number,aa.effective_from_dt,aa.effective_to_dt,aa.sort_lead,aa.error,aa.max_effective_to_dt;
  update #dtv_final as aa
    set aa.max_effective_to_dt = bb.max_effective_to_dt from
    #dtv_final as aa
    join #dtv3 as bb
    on aa.account_number = bb.account_number
    and aa.row_num = bb.row_num;
  insert into #dtv_final
    select account_number,effective_from_dt,effective_to_dt,sort_lead,error,max_effective_to_dt,0 as row
      from #dtv2
      where error = 1;
  drop table if exists #ACCOUNT_ACTIVE2;
  select A.ACCOUNT_NUMBER,
    A.ORDER_DT,
    A.ACTIVE_DT,
    case when(ACTIVE_DT = today() or B.max_effective_to_dt = '9999-09-09') then today() else B.max_effective_to_dt end as NOT_ACTIVE_DT
    into #ACCOUNT_ACTIVE2
    from #ACCOUNT_ACTIVE as A
      left outer join #dtv_final as B
      on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and A.ACTIVE_DT = B.EFFECTIVE_FROM_DT;
  drop table if exists #ACCOUNT_ACTIVE3;
  select *,
    (NOT_ACTIVE_DT-ACTIVE_DT)/30 as ACCOUNT_ACTIVE_LENGTH
    into #ACCOUNT_ACTIVE3
    from #ACCOUNT_ACTIVE2;
  update #ECONOMETRICS_QMS as A
    set A.ACCOUNT_ACTIVE_LENGTH = B.ACCOUNT_ACTIVE_LENGTH from
    #ACCOUNT_ACTIVE3 as B
    where A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT = B.ORDER_DT;
  ------------------------------------------------------------------------------------------------
  /*
UPDATE #ECONOMETRICS_QMS A
SET A.ACTIVE_DTV_BEFORE_ORDER = B.dtv_Active_subscription
FROM #ECONOMETRICS_QMS A
INNER JOIN CITEAM.ACTIVE_SUBSCRIBER_REPORT B ON A.ACCOUNT_NUMBER=B.ACCOUNT_NUMBER
WHERE A.order_dt - 1 BETWEEN B.effective_from_dt AND B.effective_to_dt -1
AND B.DTV_Active = 1;

*/
  update #ECONOMETRICS_QMS as a
    set ACTIVE_DTV_BEFORE_ORDER = 1 from
    #ECONOMETRICS_QMS as a
    join(select a.account_number,
      a.order_dt
      from #ECONOMETRICS_QMS as a
        join cust_subs_hist as b
        on a.account_number = b.account_number
        and b.effective_from_dt <= a.order_dt
        and b.effective_to_dt > a.order_dt
      where b.subscription_sub_type = 'DTV Primary Viewing'
      and b.status_code in( 'AC','AB','PC' ) 
      group by a.account_number,
      a.order_dt) as b
    on a.account_number = b.account_number
    and a.order_dt = b.order_dt;
  update #ECONOMETRICS_QMS as a
    set ACTIVE_DTV_BEFORE_ORDER = 1 from
    #ECONOMETRICS_QMS as a
    join(select a.account_number,
      a.order_dt
      from #ECONOMETRICS_QMS as a
        join cust_subs_hist as b
        on a.account_number = b.account_number
        and b.effective_from_dt between(a.order_dt-56) and(a.order_dt-1)
      where b.subscription_sub_type = 'DTV Primary Viewing'
      and b.status_code in( 'IT','EN','SU' ) 
      group by a.account_number,
      a.order_dt) as b
    on a.account_number = b.account_number
    and a.order_dt = b.order_dt
    where a.ACTIVE_DTV_BEFORE_ORDER <> 1;
  -- upgrade downgrade 
  update #ECONOMETRICS_QMS
    set Upgrade_Downgrade = case when ACTIVE_DTV_BEFORE_ORDER = 1 and QMS_ADDED = 1 then 'UPGRADE'
    when ACTIVE_DTV_BEFORE_ORDER = 1 and QMS_removed = 1 then 'DOWNGRADE' end;
  -----------------------------------------------------------------------------------------------
  -- UPDATE THE TV_REGION
  update #ECONOMETRICS_QMS as qms
    set qms.TV_Region = B.tv_region,
    qms.TENURE = cast(DATEDIFF(month,B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT,qms.WEEK_START) as varchar) from
    #ECONOMETRICS_QMS as qms
    join CITeam.Account_TV_Region as B on qms.account_number = B.account_number;
  ------------------Update LTV, MuTV, CTV,Asia Pack Flags--------------
  update #ECONOMETRICS_QMS as A
    set A.Asia_Pack_Active
     = case when B.SkyAsia_Active_Subscription = 1 then 1
    else 0
    end from
    #ECONOMETRICS_QMS as A
    left outer join CITeam.Active_Subscriber_Report as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT-1 >= B.effective_from_dt
    and A.ORDER_DT-1 < B.effective_to_dt
    where B.SkyAsia_Active_Subscription = 1;
  update #ECONOMETRICS_QMS as A
    set A.MuTV_Pack_Active
     = case when B.MUTV_Active_Subscription = 1 then 1
    else 0
    end from
    #ECONOMETRICS_QMS as A
    left outer join CITeam.Active_Subscriber_Report as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT-1 >= B.effective_from_dt
    and A.ORDER_DT-1 < B.effective_to_dt
    where B.MUTV_Active_Subscription = 1;
  update #ECONOMETRICS_QMS as A
    set A.LTV_Pack_Active
     = case when B.Liverpool_Active_Subscription = 1 then 1
    else 0
    end from
    #ECONOMETRICS_QMS as A
    left outer join CITeam.Active_Subscriber_Report as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT-1 >= B.effective_from_dt
    and A.ORDER_DT-1 < B.effective_to_dt
    where B.Liverpool_Active_Subscription = 1;
  update #ECONOMETRICS_QMS as A
    set A.CTV_Pack_Active
     = case when B.Chelsea_TV_Active_Subscription = 1 then 1
    else 0
    end from
    #ECONOMETRICS_QMS as A
    left outer join CITeam.Active_Subscriber_Report as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT-1 >= B.effective_from_dt
    and A.ORDER_DT-1 < B.effective_to_dt
    where B.Chelsea_TV_Active_Subscription = 1;
  delete from Decisioning.ECONOMETRICS_QMS_ORDERS_Account_Level
    where WEEK_START between PERIOD_START and PERIOD_END;
  insert into Decisioning.ECONOMETRICS_QMS_ORDERS_Account_Level
    select YEAR_WEEK,
      WEEK_START,
      ORDER_DT,
      CURRENCY_CODE,
      RTM_LEVEL_1,
      RTM_LEVEL_2,
      RTM_LEVEL_3,
      ORDER_COMMUNICATION_TYPE,
      ORDER_SALE_TYPE,
      CONTACT_TYPE,
      CONTRACT_STATUS,
      --,UPGRADE_DOWNGRADE
      --,PREMIUM_CHANGE
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
      QMS_ADDED,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      BB_ADDED_PRODUCT,
      TALKU_ADDED,
      TALKW_ADDED,
      TALKF_ADDED,
      TALKA_ADDED,
      TALKP_ADDED,
      TALKO_ADDED,
      TALK_ADDED,
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
      QMS_REMOVED,
      MS_REMOVED_PRODUCT,
      SKY_PLUS_REMOVED,
      SKY_GO_EXTRA_REMOVED,
      NOW_TV_REMOVED,
      BB_REMOVED_PRODUCT,
      TALKU_REMOVED,
      TALKW_REMOVED,
      TALKF_REMOVED,
      TALKA_REMOVED,
      TALKP_REMOVED,
      TALKO_REMOVED,
      TALK_REMOVED,
      PRE_ORDER_TOTAL_PREMIUMS,
      PRE_ORDER_TOTAL_SPORTS,
      PRE_ORDER_TOTAL_MOVIES,
      POST_ORDER_TOTAL_PREMIUMS,
      POST_ORDER_TOTAL_SPORTS,
      POST_ORDER_TOTAL_MOVIES,
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      ANY_OFFER_FLAG,
      OFFER_SUB_TYPE,
      OFFER_DESCRIPTION,
      MONTHLY_OFFER_VALUE,
      OFFER_DURATION_MTH,
      TOTAL_OFFER_VALUE,
      AUTO_TRANSFER_OFFER,
      TENURE,
      TV_REGION,
      ACCOUNT_NUMBER,
      ORDER_ID,
      ACTIVE_BROADBAND_BEFORE_ORDER,
      LEGACY_SPORTS_SUB_ADDED,
      LEGACY_SPORTS_SUB_REMOVED,
      LEGACY_MOVIES_SUB_ADDED,
      LEGACY_MOVIES_SUB_REMOVED,
      SPORTS_PACK_SUB_ADDED,
      SPORTS_PACK_SUB_REMOVED,
      SPORTS_PACK_ADDED,
      SPORTS_PACK_REMOVED,
      SPORTS_COMPLETE_ADDED,
      SPORTS_COMPLETE_REMOVED,
      CINEMA_ADD_ON_ADDED,
      CINEMA_ADD_ON_REMOVED,
      SPORTS_ACTION_ADDED,
      SPORTS_ACTION_REMOVED,
      SPORTS_CRICKET_ADDED,
      SPORTS_CRICKET_REMOVED,
      SPORTS_F1_ADDED,
      SPORTS_F1_REMOVED,
      SPORTS_FOOTBALL_ADDED,
      SPORTS_FOOTBALL_REMOVED,
      SPORTS_GOLF_ADDED,
      SPORTS_GOLF_REMOVED,
      SPORTS_PREMIERLEAGUE_ADDED,
      SPORTS_PREMIERLEAGUE_REMOVED,
      Pre_Order_Prems_Active,
      Post_Order_Prems_Active,
      Pre_Order_Sports_Active,
      Post_Order_Sports_Active,
      Pre_Order_Movies_Active,
      Post_Order_Movies_Active,
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      ANY_NEW_OFFER_FLAG,
      Asia_Pack_Active,
      MuTV_Pack_Active,
      LTV_Pack_Active,
      CTV_Pack_Active,
      KIDS_ADDED,
      KIDS_REMOVED,
      BOXSETS_ADDED,
      BOXSETS_REMOVED,
      SPOTIFY_ADDED,
      SPOTIFY_REMOVED,
      DTV_ADDED_PRODUCT,
      DTV_REMOVED_PRODUCT,
      ACTIVE_DTV_BEFORE_ORDER,
      ACCOUNT_ACTIVE_LENGTH,
      ORDER_BECAME_ACTIVE,
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
      Add_on_contract_subscription_item_post_order,
      Classic_Multiscreen_Before_Order,
      Classic_Multiscreen_After_Order,
      QMS_Before_Order,
      QMS_After_Order,
      Upgrade_Downgrade
      from #ECONOMETRICS_QMS;
  commit work;
  --SUMMARIZE DATA
  delete from Decisioning.ECONOMETRICS_QMS_ORDERS
    where WEEK_START between PERIOD_START and PERIOD_END;
  insert into Decisioning.ECONOMETRICS_QMS_ORDERS
    select YEAR_WEEK,
      WEEK_START,
      CURRENCY_CODE,
      RTM_LEVEL_1,
      RTM_LEVEL_2,
      RTM_LEVEL_3,
      ORDER_COMMUNICATION_TYPE,
      ORDER_SALE_TYPE,
      CONTACT_TYPE,
      -- CONTRACT_STATUS, 
      -- UPGRADE_DOWNGRADE,
      -- PREMIUM_CHANGE,
      SPORTS_ADDED,
      MOVIES_ADDED,
      HD_LEGACY_ADDED,
      HD_BASIC_ADDED,
      HD_PREMIUM_ADDED,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      BB_ADDED_PRODUCT,
      TALK_ADDED,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      HD_LEGACY_REMOVED,
      HD_BASIC_REMOVED,
      HD_PREMIUM_REMOVED,
      MS_REMOVED_PRODUCT,
      SKY_PLUS_REMOVED,
      SKY_GO_EXTRA_REMOVED,
      NOW_TV_REMOVED,
      BB_REMOVED_PRODUCT,
      TALK_REMOVED,
      PRE_ORDER_TOTAL_PREMIUMS,
      PRE_ORDER_TOTAL_SPORTS,
      PRE_ORDER_TOTAL_MOVIES,
      POST_ORDER_TOTAL_PREMIUMS,
      POST_ORDER_TOTAL_SPORTS,
      POST_ORDER_TOTAL_MOVIES,
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      ANY_OFFER_FLAG,
      OFFER_SUB_TYPE,
      OFFER_DESCRIPTION,
      MONTHLY_OFFER_VALUE,
      OFFER_DURATION_MTH,
      TOTAL_OFFER_VALUE,
      AUTO_TRANSFER_OFFER,
      TENURE,
      TV_REGION,
      Count() as NUMBER_OF_ORDERS,
      ACTIVE_BROADBAND_BEFORE_ORDER,
      LEGACY_SPORTS_SUB_ADDED,
      LEGACY_SPORTS_SUB_REMOVED,
      LEGACY_MOVIES_SUB_ADDED,
      LEGACY_MOVIES_SUB_REMOVED,
      SPORTS_PACK_SUB_ADDED,
      SPORTS_PACK_SUB_REMOVED,
      SPORTS_PACK_ADDED,
      SPORTS_PACK_REMOVED,
      SPORTS_COMPLETE_ADDED,
      SPORTS_COMPLETE_REMOVED,
      CINEMA_ADD_ON_ADDED,
      CINEMA_ADD_ON_REMOVED,
      --SPORTS_CONTRACT_ADDED,
      --SPORTS_CONTRACT_REMOVED,
      SPORTS_ACTION_ADDED,
      SPORTS_ACTION_REMOVED,
      SPORTS_CRICKET_ADDED,
      SPORTS_CRICKET_REMOVED,
      SPORTS_F1_ADDED,
      SPORTS_F1_REMOVED,
      SPORTS_FOOTBALL_ADDED,
      SPORTS_FOOTBALL_REMOVED,
      SPORTS_GOLF_ADDED,
      SPORTS_GOLF_REMOVED,
      SPORTS_PREMIERLEAGUE_ADDED,
      SPORTS_PREMIERLEAGUE_REMOVED,
      Pre_Order_Prems_Active,
      Post_Order_Prems_Active,
      Pre_Order_Sports_Active,
      Post_Order_Sports_Active,
      Pre_Order_Movies_Active,
      Post_Order_Movies_Active,
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      ANY_NEW_OFFER_FLAG,
      Asia_Pack_Active,
      MuTV_Pack_Active,
      LTV_Pack_Active,
      CTV_Pack_Active,
      KIDS_ADDED,
      KIDS_REMOVED,
      BOXSETS_ADDED,
      BOXSETS_REMOVED,
      SPOTIFY_ADDED,
      SPOTIFY_REMOVED,
      DTV_ADDED_PRODUCT,
      DTV_REMOVED_PRODUCT,
      ACTIVE_DTV_BEFORE_ORDER,
      ACCOUNT_ACTIVE_LENGTH,
      ORDER_BECAME_ACTIVE,
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
      Add_on_contract_subscription_item_post_order,
      Classic_Multiscreen_Before_Order,
      Classic_Multiscreen_After_Order,
      QMS_Before_Order,
      QMS_After_Order,
      Upgrade_Downgrade
      from #ECONOMETRICS_QMS as A
      group by YEAR_WEEK,
      WEEK_START,
      CURRENCY_CODE,
      RTM_LEVEL_1,
      RTM_LEVEL_2,
      RTM_LEVEL_3,
      ORDER_COMMUNICATION_TYPE,
      ORDER_SALE_TYPE,
      CONTACT_TYPE,
      -- CONTRACT_STATUS, 
      --UPGRADE_DOWNGRADE,
      --PREMIUM_CHANGE,
      SPORTS_ADDED,
      MOVIES_ADDED,
      HD_LEGACY_ADDED,
      HD_BASIC_ADDED,
      HD_PREMIUM_ADDED,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      BB_ADDED_PRODUCT,
      TALK_ADDED,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      HD_LEGACY_REMOVED,
      HD_BASIC_REMOVED,
      HD_PREMIUM_REMOVED,
      MS_REMOVED_PRODUCT,
      SKY_PLUS_REMOVED,
      SKY_GO_EXTRA_REMOVED,
      NOW_TV_REMOVED,
      BB_REMOVED_PRODUCT,
      TALK_REMOVED,
      PRE_ORDER_TOTAL_PREMIUMS,
      PRE_ORDER_TOTAL_SPORTS,
      PRE_ORDER_TOTAL_MOVIES,
      POST_ORDER_TOTAL_PREMIUMS,
      POST_ORDER_TOTAL_SPORTS,
      POST_ORDER_TOTAL_MOVIES,
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      ANY_OFFER_FLAG,
      OFFER_SUB_TYPE,
      OFFER_DESCRIPTION,
      MONTHLY_OFFER_VALUE,
      OFFER_DURATION_MTH,
      TOTAL_OFFER_VALUE,
      AUTO_TRANSFER_OFFER,
      TENURE,
      TV_REGION,
      ACTIVE_BROADBAND_BEFORE_ORDER,
      LEGACY_SPORTS_SUB_ADDED,
      LEGACY_SPORTS_SUB_REMOVED,
      LEGACY_MOVIES_SUB_ADDED,
      LEGACY_MOVIES_SUB_REMOVED,
      SPORTS_PACK_SUB_ADDED,
      SPORTS_PACK_SUB_REMOVED,
      SPORTS_PACK_ADDED,
      SPORTS_PACK_REMOVED,
      SPORTS_COMPLETE_ADDED,
      SPORTS_COMPLETE_REMOVED,
      CINEMA_ADD_ON_ADDED,
      CINEMA_ADD_ON_REMOVED,
      --SPORTS_CONTRACT_ADDED,
      --SPORTS_CONTRACT_REMOVED,
      SPORTS_ACTION_ADDED,
      SPORTS_ACTION_REMOVED,
      SPORTS_CRICKET_ADDED,
      SPORTS_CRICKET_REMOVED,
      SPORTS_F1_ADDED,
      SPORTS_F1_REMOVED,
      SPORTS_FOOTBALL_ADDED,
      SPORTS_FOOTBALL_REMOVED,
      SPORTS_GOLF_ADDED,
      SPORTS_GOLF_REMOVED,
      SPORTS_PREMIERLEAGUE_ADDED,
      SPORTS_PREMIERLEAGUE_REMOVED,
      Pre_Order_Prems_Active,
      Post_Order_Prems_Active,
      Pre_Order_Sports_Active,
      Post_Order_Sports_Active,
      Pre_Order_Movies_Active,
      Post_Order_Movies_Active,
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      ANY_NEW_OFFER_FLAG,
      Asia_Pack_Active,
      MuTV_Pack_Active,
      LTV_Pack_Active,
      CTV_Pack_Active,
      KIDS_ADDED,
      KIDS_REMOVED,
      BOXSETS_ADDED,
      BOXSETS_REMOVED,
      SPOTIFY_ADDED,
      SPOTIFY_REMOVED,
      DTV_ADDED_PRODUCT,
      DTV_REMOVED_PRODUCT,
      ACTIVE_DTV_BEFORE_ORDER,
      ACCOUNT_ACTIVE_LENGTH,
      ORDER_BECAME_ACTIVE,
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
      Add_on_contract_subscription_item_post_order,
      Classic_Multiscreen_Before_Order,
      Classic_Multiscreen_After_Order,
      QMS_Before_Order,
      QMS_After_Order,
      Upgrade_Downgrade;
  commit work;
  drop table if exists #ECONOMETRICS_QMS_OFFERS;
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
    --UPGRADE_DOWNGRADE,
    --PREMIUM_CHANGE,
    SPORTS_ADDED,
    MOVIES_ADDED,
    /* FAMILY_ADDED,
VARIETY_ADDED,
ORIGINAL_ADDED,
SKYQ_ADDED,*/
    HD_LEGACY_ADDED,
    HD_BASIC_ADDED,
    HD_PREMIUM_ADDED,
    -- MULTISCREEN_ADDED,
    --MULTISCREEN_PLUS_ADDED,
    MS_ADDED_PRODUCT,
    SKY_PLUS_ADDED,
    SKY_GO_EXTRA_ADDED,
    NOW_TV_ADDED,
    BB_ADDED_PRODUCT,
    TALK_ADDED,
    SPORTS_REMOVED,
    MOVIES_REMOVED,
    HD_LEGACY_REMOVED,
    HD_BASIC_REMOVED,
    HD_PREMIUM_REMOVED,
    MS_REMOVED_PRODUCT,
    SKY_PLUS_REMOVED,
    SKY_GO_EXTRA_REMOVED,
    NOW_TV_REMOVED,
    BB_REMOVED_PRODUCT,
    TALK_REMOVED,
    PRE_ORDER_TOTAL_PREMIUMS,
    PRE_ORDER_TOTAL_SPORTS,
    PRE_ORDER_TOTAL_MOVIES,
    POST_ORDER_TOTAL_PREMIUMS,
    POST_ORDER_TOTAL_SPORTS,
    POST_ORDER_TOTAL_MOVIES,
    CONTACT_TYPE,
    CONTRACT_STATUS,
    ACTUAL_OFFER_STATUS,
    INTENDED_OFFER_STATUS,
    ANY_OFFER_FLAG,
    TENURE,
    TV_REGION,
    year_week,
    WEEK_START,
    OFFER_SUB_TYPE,
    OFFER_ID,
    OFFER_DESCRIPTION,
    MONTHLY_OFFER_VALUE,
    OFFER_DURATION_MTH,
    TOTAL_OFFER_VALUE,
    AUTO_TRANSFER_OFFER,
    ACTIVE_BROADBAND_BEFORE_ORDER,
    LEGACY_SPORTS_SUB_ADDED,
    LEGACY_SPORTS_SUB_REMOVED,
    LEGACY_MOVIES_SUB_ADDED,
    LEGACY_MOVIES_SUB_REMOVED,
    LEGACY_SPORTS_ADDED,
    LEGACY_SPORTS_REMOVED,
    LEGACY_MOVIES_ADDED,
    LEGACY_MOVIES_REMOVED,
    SPORTS_PACK_SUB_ADDED,
    SPORTS_PACK_SUB_REMOVED,
    SPORTS_PACK_ADDED,
    SPORTS_PACK_REMOVED,
    SPORTS_COMPLETE_ADDED,
    SPORTS_COMPLETE_REMOVED,
    CINEMA_ADD_ON_ADDED,
    CINEMA_ADD_ON_REMOVED,
    -- SPORTS_CONTRACT_ADDED,
    SPORTS_ACTION_ADDED,
    SPORTS_CRICKET_ADDED,
    SPORTS_F1_ADDED,
    SPORTS_FOOTBALL_ADDED,
    SPORTS_GOLF_ADDED,
    SPORTS_PREMIERLEAGUE_ADDED,
    --SPORTS_CONTRACT_REMOVED,
    SPORTS_ACTION_REMOVED,
    SPORTS_CRICKET_REMOVED,
    SPORTS_F1_REMOVED,
    SPORTS_FOOTBALL_REMOVED,
    SPORTS_GOLF_REMOVED,
    SPORTS_PREMIERLEAGUE_REMOVED,
    Pre_Order_Prems_Active,
    Post_Order_Prems_Active,
    Pre_Order_Sports_Active,
    Post_Order_Sports_Active,
    Pre_Order_Movies_Active,
    Post_Order_Movies_Active,
    Offer_End_Status_Level_1,
    Offer_End_Status_Level_2,
    ANY_NEW_OFFER_FLAG,
    Offer_Leg_1,
    Offer_Leg_Any,
    Asia_Pack_Active,
    MuTV_Pack_Active,
    LTV_Pack_Active,
    CTV_Pack_Active,
    KIDS_ADDED,
    KIDS_REMOVED,
    BOXSETS_ADDED,
    BOXSETS_REMOVED,
    SPOTIFY_ADDED,
    SPOTIFY_REMOVED,
    DTV_ADDED_PRODUCT,
    DTV_REMOVED_PRODUCT,
    ACTIVE_DTV_BEFORE_ORDER,
    ACCOUNT_ACTIVE_LENGTH,
    ORDER_BECAME_ACTIVE,
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
    Add_on_contract_subscription_item_post_order,
    Classic_Multiscreen_Before_Order,
    Classic_Multiscreen_After_Order,
    QMS_Before_Order,
    QMS_After_Order,
    Upgrade_Downgrade
    into #ECONOMETRICS_QMS_OFFERS
    -- A.UPGRADE_DOWNGRADE ,
    --A.PREMIUM_CHANGE ,
    -- A.MULTISCREEN_ADDED ,
    --A.MULTISCREEN_PLUS_ADDED ,
    --A.SPORTS_CONTRACT_ADDED ,
    --A.SPORTS_CONTRACT_REMOVED ,
    --       WHERE A.ACCOUNT_NUMBER = '210023104644'
    --and B.Offer_Leg = 1
    from(select A.ACCOUNT_NUMBER,
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
        A.SPORTS_ADDED,
        A.MOVIES_ADDED,
        A.HD_LEGACY_ADDED,
        A.HD_BASIC_ADDED,
        A.HD_PREMIUM_ADDED,
        A.MS_ADDED_PRODUCT,
        A.SKY_PLUS_ADDED,
        A.SKY_GO_EXTRA_ADDED,
        A.NOW_TV_ADDED,
        A.BB_ADDED_PRODUCT,
        A.TALK_ADDED,
        A.SPORTS_REMOVED,
        A.MOVIES_REMOVED,
        A.HD_LEGACY_REMOVED,
        A.HD_BASIC_REMOVED,
        A.HD_PREMIUM_REMOVED,
        A.MS_REMOVED_PRODUCT,
        A.SKY_PLUS_REMOVED,
        A.SKY_GO_EXTRA_REMOVED,
        A.NOW_TV_REMOVED,
        A.BB_REMOVED_PRODUCT,
        A.TALK_REMOVED,
        A.PRE_ORDER_TOTAL_PREMIUMS,
        A.PRE_ORDER_TOTAL_SPORTS,
        A.PRE_ORDER_TOTAL_MOVIES,
        POST_ORDER_TOTAL_PREMIUMS,
        POST_ORDER_TOTAL_SPORTS,
        POST_ORDER_TOTAL_MOVIES,
        A.CONTACT_TYPE,
        A.CONTRACT_STATUS,
        A.ACTUAL_OFFER_STATUS,
        A.INTENDED_OFFER_STATUS,
        A.ANY_OFFER_FLAG,
        A.TENURE,
        A.TV_REGION,
        A.year_week,
        A.WEEK_START,
        B.subscription_sub_type as OFFER_SUB_TYPE,
        B.OFFER_ID,
        B.OFFER_DIM_DESCRIPTION as OFFER_DESCRIPTION,
        B.Monthly_Offer_Amount as MONTHLY_OFFER_VALUE,
        DATEDIFF(month,B.Whole_Offer_Intended_Start_Dt,B.INTENDED_OFFER_END_DT) as OFFER_DURATION_MTH,
        DATEDIFF(month,B.Whole_Offer_Intended_Start_Dt,B.INTENDED_OFFER_END_DT)*B.Monthly_Offer_Amount as TOTAL_OFFER_VALUE,
        case when B.ORIG_PORTFOLIO_OFFER_ID <> '?' then 1
        else 0
        end as AUTO_TRANSFER_OFFER,
        A.ACTIVE_BROADBAND_BEFORE_ORDER,
        LEGACY_SPORTS_SUB_ADDED,
        LEGACY_SPORTS_SUB_REMOVED,
        LEGACY_MOVIES_SUB_ADDED,
        LEGACY_MOVIES_SUB_REMOVED,
        LEGACY_SPORTS_ADDED,
        LEGACY_SPORTS_REMOVED,
        LEGACY_MOVIES_ADDED,
        LEGACY_MOVIES_REMOVED,
        SPORTS_PACK_SUB_ADDED,
        SPORTS_PACK_SUB_REMOVED,
        SPORTS_PACK_ADDED,
        SPORTS_PACK_REMOVED,
        SPORTS_COMPLETE_ADDED,
        SPORTS_COMPLETE_REMOVED,
        CINEMA_ADD_ON_ADDED,
        CINEMA_ADD_ON_REMOVED,
        A.SPORTS_ACTION_ADDED,
        A.SPORTS_CRICKET_ADDED,
        A.SPORTS_F1_ADDED,
        A.SPORTS_FOOTBALL_ADDED,
        A.SPORTS_GOLF_ADDED,
        A.SPORTS_PREMIERLEAGUE_ADDED,
        A.SPORTS_ACTION_REMOVED,
        A.SPORTS_CRICKET_REMOVED,
        A.SPORTS_F1_REMOVED,
        A.SPORTS_FOOTBALL_REMOVED,
        A.SPORTS_GOLF_REMOVED,
        A.SPORTS_PREMIERLEAGUE_REMOVED,
        A.Pre_Order_Prems_Active,
        A.Post_Order_Prems_Active,
        A.Pre_Order_Sports_Active,
        A.Post_Order_Sports_Active,
        A.Pre_Order_Movies_Active,
        A.Post_Order_Movies_Active,
        A.Offer_End_Status_Level_1,
        A.Offer_End_Status_Level_2,
        A.ANY_NEW_OFFER_FLAG,
        null as Offer_Leg_1,
        null as Offer_Leg_Any,
        Asia_Pack_Active,
        MuTV_Pack_Active,
        LTV_Pack_Active,
        CTV_Pack_Active,
        KIDS_ADDED,
        KIDS_REMOVED,
        BOXSETS_ADDED,
        BOXSETS_REMOVED,
        SPOTIFY_ADDED,
        SPOTIFY_REMOVED,
        DTV_ADDED_PRODUCT,
        DTV_REMOVED_PRODUCT,
        ACTIVE_DTV_BEFORE_ORDER,
        ACCOUNT_ACTIVE_LENGTH,
        ORDER_BECAME_ACTIVE,
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
        Add_on_contract_subscription_item_post_order,
        Classic_Multiscreen_Before_Order,
        Classic_Multiscreen_After_Order,
        QMS_Before_Order,
        QMS_After_Order,
        Upgrade_Downgrade,
        ROW_NUMBER() over(partition by A.ACCOUNT_NUMBER,
        A.CURRENCY_CODE,
        A.CUSTOMER_SK,
        A.ORDER_ID,
        A.ORDER_NUMBER,
        A.ORDER_DT,
        B.Offer_ID order by
        A.ORDER_DT desc,MONTHLY_OFFER_VALUE desc) as RowNum
        from #ECONOMETRICS_QMS as A
          left outer join Decisioning.Offers_Software as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
          and lower(B.Offer_Dim_Description) not like '%price protect%'
          and A.ORDER_DT = B.Offer_Leg_CREATED_DT) as A
    where RowNum = 1;
  commit work;
  --SUMMARIZE DATA
  delete from Decisioning.ECONOMETRICS_QMS_OFFERS
    where WEEK_START between PERIOD_START and PERIOD_END;
  insert into Decisioning.ECONOMETRICS_QMS_OFFERS
    select YEAR_WEEK,
      WEEK_START,
      CURRENCY_CODE,
      RTM_LEVEL_1,
      RTM_LEVEL_2,
      RTM_LEVEL_3,
      ORDER_COMMUNICATION_TYPE,
      ORDER_SALE_TYPE,
      CONTACT_TYPE,
      -- CONTRACT_STATUS,
      -- UPGRADE_DOWNGRADE,
      --PREMIUM_CHANGE,
      SPORTS_ADDED,
      MOVIES_ADDED,
      HD_LEGACY_ADDED,
      HD_BASIC_ADDED,
      HD_PREMIUM_ADDED,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      BB_ADDED_PRODUCT,
      TALK_ADDED,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      HD_LEGACY_REMOVED,
      HD_BASIC_REMOVED,
      HD_PREMIUM_REMOVED,
      MS_REMOVED_PRODUCT,
      SKY_PLUS_REMOVED,
      SKY_GO_EXTRA_REMOVED,
      NOW_TV_REMOVED,
      BB_REMOVED_PRODUCT,
      TALK_REMOVED,
      PRE_ORDER_TOTAL_PREMIUMS,
      PRE_ORDER_TOTAL_SPORTS,
      PRE_ORDER_TOTAL_MOVIES,
      POST_ORDER_TOTAL_PREMIUMS,
      POST_ORDER_TOTAL_SPORTS,
      POST_ORDER_TOTAL_MOVIES,
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      ANY_OFFER_FLAG,
      OFFER_SUB_TYPE,
      OFFER_DESCRIPTION,
      MONTHLY_OFFER_VALUE,
      OFFER_DURATION_MTH,
      TOTAL_OFFER_VALUE,
      AUTO_TRANSFER_OFFER,
      TENURE,
      TV_REGION,
      Count() as NUMBER_OF_OFFERS,
      ACTIVE_BROADBAND_BEFORE_ORDER,
      LEGACY_SPORTS_SUB_ADDED,
      LEGACY_SPORTS_SUB_REMOVED,
      LEGACY_MOVIES_SUB_ADDED,
      LEGACY_MOVIES_SUB_REMOVED,
      SPORTS_PACK_SUB_ADDED,
      SPORTS_PACK_SUB_REMOVED,
      SPORTS_PACK_ADDED,
      SPORTS_PACK_REMOVED,
      SPORTS_COMPLETE_ADDED,
      SPORTS_COMPLETE_REMOVED,
      CINEMA_ADD_ON_ADDED,
      CINEMA_ADD_ON_REMOVED,
      SPORTS_ACTION_ADDED,
      SPORTS_ACTION_REMOVED,
      SPORTS_CRICKET_ADDED,
      SPORTS_CRICKET_REMOVED,
      SPORTS_F1_ADDED,
      SPORTS_F1_REMOVED,
      SPORTS_FOOTBALL_ADDED,
      SPORTS_FOOTBALL_REMOVED,
      SPORTS_GOLF_ADDED,
      SPORTS_GOLF_REMOVED,
      SPORTS_PREMIERLEAGUE_ADDED,
      SPORTS_PREMIERLEAGUE_REMOVED,
      Pre_Order_Prems_Active,
      Post_Order_Prems_Active,
      Pre_Order_Sports_Active,
      Post_Order_Sports_Active,
      Pre_Order_Movies_Active,
      Post_Order_Movies_Active,
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      ANY_NEW_OFFER_FLAG,
      --Offer_leg_1,
      --Offer_leg_Any, 
      Asia_Pack_Active,
      MuTV_Pack_Active,
      LTV_Pack_Active,
      CTV_Pack_Active,
      KIDS_ADDED,
      KIDS_REMOVED,
      BOXSETS_ADDED,
      BOXSETS_REMOVED,
      SPOTIFY_ADDED,
      SPOTIFY_REMOVED,
      DTV_ADDED_PRODUCT,
      DTV_REMOVED_PRODUCT,
      ACTIVE_DTV_BEFORE_ORDER,
      ACCOUNT_ACTIVE_LENGTH,
      ORDER_BECAME_ACTIVE,
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
      Add_on_contract_subscription_item_post_order,
      Classic_Multiscreen_Before_Order,
      Classic_Multiscreen_After_Order,
      QMS_Before_Order,
      QMS_After_Order,
      Upgrade_Downgrade
      from #ECONOMETRICS_QMS_OFFERS as A
      group by YEAR_WEEK,
      WEEK_START,
      CURRENCY_CODE,
      RTM_LEVEL_1,
      RTM_LEVEL_2,
      RTM_LEVEL_3,
      ORDER_COMMUNICATION_TYPE,
      ORDER_SALE_TYPE,
      CONTACT_TYPE,
      SPORTS_ADDED,
      MOVIES_ADDED,
      HD_LEGACY_ADDED,
      HD_BASIC_ADDED,
      HD_PREMIUM_ADDED,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      BB_ADDED_PRODUCT,
      TALK_ADDED,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      HD_LEGACY_REMOVED,
      HD_BASIC_REMOVED,
      HD_PREMIUM_REMOVED,
      MS_REMOVED_PRODUCT,
      SKY_PLUS_REMOVED,
      SKY_GO_EXTRA_REMOVED,
      NOW_TV_REMOVED,
      BB_REMOVED_PRODUCT,
      TALK_REMOVED,
      PRE_ORDER_TOTAL_PREMIUMS,
      PRE_ORDER_TOTAL_SPORTS,
      PRE_ORDER_TOTAL_MOVIES,
      POST_ORDER_TOTAL_PREMIUMS,
      POST_ORDER_TOTAL_SPORTS,
      POST_ORDER_TOTAL_MOVIES,
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      ANY_OFFER_FLAG,
      OFFER_SUB_TYPE,
      OFFER_DESCRIPTION,
      MONTHLY_OFFER_VALUE,
      OFFER_DURATION_MTH,
      TOTAL_OFFER_VALUE,
      AUTO_TRANSFER_OFFER,
      TENURE,
      TV_REGION,
      ACTIVE_BROADBAND_BEFORE_ORDER,
      LEGACY_SPORTS_SUB_ADDED,
      LEGACY_SPORTS_SUB_REMOVED,
      LEGACY_MOVIES_SUB_ADDED,
      LEGACY_MOVIES_SUB_REMOVED,
      SPORTS_PACK_SUB_ADDED,
      SPORTS_PACK_SUB_REMOVED,
      SPORTS_PACK_ADDED,
      SPORTS_PACK_REMOVED,
      SPORTS_COMPLETE_ADDED,
      SPORTS_COMPLETE_REMOVED,
      CINEMA_ADD_ON_ADDED,
      CINEMA_ADD_ON_REMOVED,
      --SPORTS_CONTRACT_ADDED,
      --SPORTS_CONTRACT_REMOVED,
      SPORTS_ACTION_ADDED,
      SPORTS_ACTION_REMOVED,
      SPORTS_CRICKET_ADDED,
      SPORTS_CRICKET_REMOVED,
      SPORTS_F1_ADDED,
      SPORTS_F1_REMOVED,
      SPORTS_FOOTBALL_ADDED,
      SPORTS_FOOTBALL_REMOVED,
      SPORTS_GOLF_ADDED,
      SPORTS_GOLF_REMOVED,
      SPORTS_PREMIERLEAGUE_ADDED,
      SPORTS_PREMIERLEAGUE_REMOVED,
      Pre_Order_Prems_Active,
      Post_Order_Prems_Active,
      Pre_Order_Sports_Active,
      Post_Order_Sports_Active,
      Pre_Order_Movies_Active,
      Post_Order_Movies_Active,
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      ANY_NEW_OFFER_FLAG,
      Asia_Pack_Active,
      MuTV_Pack_Active,
      LTV_Pack_Active,
      CTV_Pack_Active,
      KIDS_ADDED,
      KIDS_REMOVED,
      BOXSETS_ADDED,
      BOXSETS_REMOVED,
      SPOTIFY_ADDED,
      SPOTIFY_REMOVED,
      DTV_ADDED_PRODUCT,
      DTV_REMOVED_PRODUCT,
      ACTIVE_DTV_BEFORE_ORDER,
      ACCOUNT_ACTIVE_LENGTH,
      ORDER_BECAME_ACTIVE,
      UOD_ADDED,
      UOD_REMOVED,
      Netflix_Added_Product,
      Netflix_Removed_Product,
      Basic_contract_status_pre_order,
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
      Add_on_contract_subscription_item_post_order,
      Classic_Multiscreen_Before_Order,
      Classic_Multiscreen_After_Order,
      QMS_Before_Order,
      QMS_After_Order,
      Upgrade_Downgrade;
  commit work;
end

GO
GRANT EXECUTE ON Decisioning_Procs.Update_Econometrics_QMS TO public;

/*
CALL Decisioning_Procs.Update_Econometrics_QMS('2016-07-01', today());

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'ECONOMETRICS_QMS_ORDERS_Account_Level');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'ECONOMETRICS_QMS_ORDERS_Account_Level',  'select * from Decisioning.ECONOMETRICS_QMS_ORDERS_Account_Level');

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'ECONOMETRICS_QMS_ORDERS');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'ECONOMETRICS_QMS_ORDERS',  'select * from Decisioning.ECONOMETRICS_QMS_ORDERS');

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'ECONOMETRICS_QMS_OFFERS');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'ECONOMETRICS_QMS_OFFERS',  'select * from Decisioning.ECONOMETRICS_QMS_OFFERS');

*/


