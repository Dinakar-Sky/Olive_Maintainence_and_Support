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
Project:        DTV Orders & offers 
Created:        21/05/2018
Owner  :        Fractal 
---------------------------------------------------------------------------------------------------------------------------------------------------------------
Program to extract all DTV orders and offers 

***************************************************************************************************************************************************************
****                                                              Change History                                                                           ****
***************************************************************************************************************************************************************
** Change#   Date         Author    	       Description 
** --       ---------   ------------- 	 ------------------------------------
** 1       03/01/2018     Aadtiya       	   Initial release 
** 2	   15/06/2018     VIkram 			   Drop columns 
** 3       22/06/2018     Aaditya Padmawar	   Added Contract Status 
** 3       06/07/2018     Aaditya Padmawar	   Talk coulumn agreegations
** 4       02/08/2018     VIkram Haibate	   ROI issue for 2 weeks fixed 
** 5 	   17/12/2018 	  Vikram Haibate	   Adding cinema and MOvies offers 
***************************************************************************************************************************************************************

-----------------------------------------------------------------------DDLS------------------------------------------------------------------------------------

dba.sp_drop_table 'Decisioning','ECONOMETRICS_DTV_ACQUISITIONS_ORDERS_ACCOUNT_LEVEL'
dba.sp_create_table 'Decisioning','ECONOMETRICS_DTV_ACQUISITIONS_ORDERS_ACCOUNT_LEVEL',
  'ACCOUNT_NUMBER varchar ( 20 ) default null, '
||'CURRENCY_CODE varchar ( 10 ) default null, '
||'CUSTOMER_SK bigint default 0, '
||'ORDER_ID varchar ( 47 ) default null, '
||'SUBSCRIPTION_ID varchar ( 50 ) default null, '
||'ORDER_NUMBER varchar ( 12 ) default null, '
||'ORDER_DT date default null, '
||'RTM_LEVEL_1 varchar ( 50 ) default null, '
||'RTM_LEVEL_2 varchar ( 50 ) default null, '
||'RTM_LEVEL_3 varchar ( 50 ) default null, '
||'ORDER_COMMUNICATION_TYPE varchar ( 10 ) default null, '
||'ORDER_SALE_TYPE varchar ( 50 ) default null, '
||'CHANGE_TYPE char ( 11 ) default null, '
||'DTV_CHANGE char ( 20 ) default null, '
||'ORDER_CHANGE_COMPLETED smallint default 0, '
||'PREVIOUS_DTV smallint default 0, '
||'PREVIOUS_DTV_1_YEAR smallint default 0, '
||'PREVIOUS_BB smallint default 0, '
||'ORDER_BECAME_ACTIVE smallint default 0, '
||'ACCOUNT_ACTIVE_LENGTH smallint default 0, '
||'BB_BEFORE_ORDER smallint default 0, '
||'BB_AFTER_ORDER smallint default 0, '
||'SPORTS_ADDED smallint default 0, '
||'MOVIES_ADDED smallint default 0, '
||'LEGACY_SPORTS_SUB_ADDED smallint default 0, '
||'LEGACY_MOVIES_SUB_ADDED smallint default 0, '
||'LEGACY_SPORTS_ADDED smallint default 0, '
||'LEGACY_MOVIES_ADDED smallint default 0, '
||'SPORTS_PACK_SUB_ADDED smallint default 0, '
||'SPORTS_PACK_ADDED smallint default 0, '
||'FAMILY_ADDED smallint default 0, '
||'VARIETY_ADDED smallint default 0, '
||'ORIGINAL_ADDED smallint default 0, '
||'SKYQ_ADDED smallint default 0, '
||'HD_LEGACY_ADDED smallint default 0, '
||'HD_BASIC_ADDED smallint default 0, '
||'HD_SPORTS_ADDED smallint default 0, '
||'MULTISCREEN_ADDED smallint default 0, '
||'MULTISCREEN_PLUS_ADDED smallint default 0, '
||'MS_ADDED_PRODUCT varchar(30) default null,'
||'SKY_PLUS_ADDED smallint default 0, '
||'SKY_GO_EXTRA_ADDED smallint default 0, '
||'NOW_TV_ADDED smallint default 0, '
||'BB_ADDED smallint default 0, '
||'BB_ADDED_PRODUCT varchar ( 240 ) default null, '
||'TALKU_ADDED smallint default 0, '
||'TALKW_ADDED smallint default 0, '
||'TALKF_ADDED smallint default 0, '
||'TALKA_ADDED smallint default 0, '
||'TALKP_ADDED smallint default 0, '
||'TALKO_ADDED smallint default 0, '
|| 'TALK_ADDED_PRODUCT varchar(30) default null,'
||'SPORTS_REMOVED smallint default 0, '
||'MOVIES_REMOVED smallint default 0, '
||'LEGACY_SPORTS_SUB_REMOVED smallint default 0, '
||'LEGACY_MOVIES_SUB_REMOVED smallint default 0, '
||'LEGACY_SPORTS_REMOVED smallint default 0, '
||'LEGACY_MOVIES_REMOVED smallint default 0, '
||'SPORTS_PACK_SUB_REMOVED smallint default 0, '
||'SPORTS_PACK_REMOVED smallint default 0, '
||'FAMILY_REMOVED smallint default 0, '
||'VARIETY_REMOVED smallint default 0, '
||'ORIGINAL_REMOVED smallint default 0, '
||'SKYQ_REMOVED smallint default 0, '
||'HD_LEGACY_REMOVED smallint default 0, '
||'HD_BASIC_REMOVED smallint default 0, '
||'HD_SPORTS_REMOVED smallint default 0, '
||'MULTISCREEN_REMOVED smallint default 0, '
||'MULTISCREEN_PLUS_REMOVED smallint default 0, '
||'MS_REMOVED_PRODUCT varchar(30) default null,'
||'SKY_PLUS_REMOVED smallint default 0, '
||'SKY_GO_EXTRA_REMOVED smallint default 0, '
||'NOW_TV_REMOVED smallint default 0, '
||'BB_REMOVED_PRODUCT varchar ( 240 ) default null, '
||'TALKU_REMOVED smallint default 0, '
||'TALKW_REMOVED smallint default 0, '
||'TALKF_REMOVED smallint default 0, '
||'TALKA_REMOVED smallint default 0, '
||'TALKP_REMOVED smallint default 0, '
||'TALKO_REMOVED smallint default 0, '
|| 'TALK_REMOVED_PRODUCT varchar(30) default null,'
||'CONTACT_TYPE varchar ( 20 ) default null, '
||'CONTRACT_STATUS varchar ( 30 ) default null, '
||'ACTUAL_OFFER_STATUS varchar ( 15 ) default null, '
||'INTENDED_OFFER_STATUS varchar ( 15 ) default null, '
||'ANY_OFFER_FLAG smallint default 0, '
||'DTV_PRIMARY_VIEWING_OFFER smallint default 0, '
||'DTV_OFFER_SUB_TYPE varchar ( 80 ) default null, '
||'DTV_OFFER_ID decimal ( 5,2 ) default null, '
||'DTV_OFFER_DESCRIPTION varchar ( 465 ) default null, '
||'DTV_MONTHLY_OFFER_VALUE decimal ( 5,2 ) default null, '
||'DTV_OFFER_DURATION_MTH int default 0, '
||'DTV_TOTAL_OFFER_VALUE numeric default 0, '
||'DTV_AUTO_TRANSFER_OFFER smallint default 0, '
||'BB_OFFER smallint default 0, '
||'BB_OFFER_SUB_TYPE varchar ( 80 ) default null, '
||'BB_OFFER_ID decimal ( 5,2 ) default null, '
||'BB_OFFER_DESCRIPTION varchar ( 465 ) default null, '
||'BB_MONTHLY_OFFER_VALUE decimal ( 5,2 ) default null, '
||'BB_OFFER_DURATION_MTH int default 0, '
||'BB_TOTAL_OFFER_VALUE numeric default 0, '
||'BB_AUTO_TRANSFER_OFFER smallint default 0, '
||'TENURE int default null, '
||'SIMPLE_SEGMENT varchar ( 45 ) default null, '
||'TV_REGION varchar ( 45 ) default null, '
||'mosaic_uk_group varchar ( 45 ) default null, '
||'year_week varchar ( 31 ) default null, '
||'WEEK_START date default null, '
||'TV_OFFER_FLAG smallint default 0, '
||'COMMS_OFFER_FLAG smallint default 0, '
||'SPORTS_COMPLETE_ADDED smallint default 0, '
||'SPORTS_COMPLETE_REMOVED smallint default 0, '
||'SPORTS_ACTION_ADDED smallint default 0, '
||'SPORTS_ACTION_REMOVED smallint default 0, '
||'SPORTS_CRICKET_ADDED smallint default 0, '
||'SPORTS_CRICKET_REMOVED smallint default 0, '
||'SPORTS_F1_ADDED smallint default 0, '
||'SPORTS_F1_REMOVED smallint default 0, '
||'SPORTS_FOOTBALL_ADDED smallint default 0, '
||'SPORTS_FOOTBALL_REMOVED smallint default 0, '
||'SPORTS_GOLF_ADDED smallint default 0, '
||'SPORTS_GOLF_REMOVED smallint default 0, '
||'SPORTS_PREMIERLEAGUE_ADDED smallint default 0, '
||'SPORTS_PREMIERLEAGUE_REMOVED smallint default 0, '
||'CINEMA_ADD_ON_ADDED smallint default 0, '
||'CINEMA_ADD_ON_REMOVED smallint default 0, '
||'Offer_End_Status_Level_1 varchar ( 30 ) default null, '
||'Offer_End_Status_Level_2 varchar ( 30 ) default null, '
||'ANY_NEW_OFFER_FLAG int default 0, '
||'NEW_DTV_PRIMARY_VIEWING_OFFER int default 0, '
||'Asia_Pack_Active tinyint default 0, '
||'MuTV_Pack_Active tinyint default 0, '
||'LTV_Pack_Active tinyint default 0, '
||'CTV_Pack_Active tinyint default 0, '
||'KIDS_ADDED smallint default 0, '
||'KIDS_REMOVED smallint default 0, '
||'BOXSETS_ADDED smallint default 0, '
||'BOXSETS_REMOVED smallint default 0, '
||'SPOTIFY_ADDED smallint default 0, '
||'SPOTIFY_REMOVED smallint default 0, '
||'UOD_ADDED smallint default 0,'
||'UOD_REMOVED smallint default 0,'
||'Netflix_Added_Product varchar(30) default null, '
||'Netflix_Removed_Product varchar(30) default null, '
||'DTV_ADDED_PRODUCT varchar ( 240 ) default null, '
||'DTV_REMOVED_PRODUCT varchar ( 240 ) default null, '
||'DTV_Status varchar ( 50 ) default null, '
||'ACTIVE_DTV_BEFORE_ORDER smallint default 0, '
||'Basic_contract_status_pre_order int default 0, '
||'Basic_contract_subscription_item_pre_order varchar ( 200 ) default null, '
||'Add_on_contract_status_pre_order int default 0, '
||'Add_on_contract_subscription_item_pre_order varchar ( 200 ) default null, '
||'Talk_contract_status_pre_order int default 0, '
||'Talk_contract_subscription_item_pre_order varchar ( 200 ) default null, '
||'BB_contract_status_pre_order int default 0, '
||'BB_contract_subscription_item_pre_order varchar ( 200 ) default null, '
||'Basic_contract_status_post_order int default 0, '
||'Basic_contract_subscription_item_post_order varchar ( 200 ) default null, '
||'BB_contract_status_post_order int default 0, '
||'BB_contract_subscription_item_post_order varchar ( 200 ) default null, '
||'Talk_contract_status_post_order int default 0, '
||'Talk_contract_subscription_item_post_order varchar ( 200 ) default null, '
||'Add_on_contract_status_post_order int default 0, '
||'Add_on_contract_subscription_item_post_order varchar ( 200 ) default null'




dba.sp_drop_table 'Decisioning','ECONOMETRICS_DTV_ACQUISITIONS_ORDERS'
dba.sp_create_table 'Decisioning','ECONOMETRICS_DTV_ACQUISITIONS_ORDERS',
  'YEAR_WEEK varchar ( 31 ) default null,'
||'WEEK_START date  default null,'
||'CURRENCY_CODE varchar ( 10 ) default null,'
||'RTM_LEVEL_1 varchar ( 50 ) default null,'
||'RTM_LEVEL_2 varchar ( 50 ) default null,'
||'RTM_LEVEL_3 varchar ( 50 ) default null,'
||'ORDER_COMMUNICATION_TYPE varchar ( 10 ) default null,'
||'ORDER_SALE_TYPE varchar ( 50 ) default null,'
||'CONTACT_TYPE varchar ( 20 ) default null,'
||'CHANGE_TYPE char ( 11 ) default null,'
||'DTV_CHANGE char ( 20 ) default null,'
||'ORDER_CHANGE_COMPLETED smallint  default 0,'
||'PREVIOUS_DTV smallint  default 0,'
||'PREVIOUS_DTV_1_YEAR smallint  default 0,'
||'PREVIOUS_BB smallint  default 0,'
||'ORDER_BECAME_ACTIVE smallint  default 0,'
||'ACCOUNT_ACTIVE_LENGTH smallint  default 0,'
||'BB_BEFORE_ORDER smallint  default 0,'
||'BB_AFTER_ORDER smallint  default 0,'
||'SPORTS_ADDED smallint  default 0,'
||'MOVIES_ADDED smallint  default 0,'
||'LEGACY_SPORTS_SUB_ADDED smallint  default 0,'
||'LEGACY_MOVIES_SUB_ADDED smallint  default 0,'
||'SPORTS_PACK_SUB_ADDED smallint  default 0,'
||'SPORTS_PACK_ADDED smallint  default 0,'
||'HD_LEGACY_ADDED smallint  default 0,'
||'HD_BASIC_ADDED smallint  default 0,'
||'HD_Sports_Added smallint  default 0,'
|| 'MS_ADDED_PRODUCT varchar(30) default null,'
||'SKY_PLUS_ADDED smallint  default 0,'
||'SKY_GO_EXTRA_ADDED smallint  default 0,'
||'NOW_TV_ADDED smallint  default 0,'
||'BB_ADDED smallint  default 0,'
||'BB_ADDED_PRODUCT varchar ( 240 ) default null,'
||'TALK_ADDED_PRODUCT varchar(30) default null,'
||'SPORTS_REMOVED smallint  default 0,'
||'MOVIES_REMOVED smallint  default 0,'
||'LEGACY_SPORTS_SUB_REMOVED smallint  default 0,'
||'LEGACY_MOVIES_SUB_REMOVED smallint  default 0,'
||'SPORTS_PACK_SUB_REMOVED smallint  default 0,'
||'SPORTS_PACK_REMOVED smallint  default 0,'
||'HD_LEGACY_REMOVED smallint  default 0,'
||'HD_BASIC_REMOVED smallint  default 0,'
||'HD_SPORTS_REMOVED smallint  default 0,'
||'MS_REMOVED_PRODUCT varchar(30) default null,'
||'SKY_PLUS_REMOVED smallint  default 0,'
||'SKY_GO_EXTRA_REMOVED smallint  default 0,'
||'NOW_TV_REMOVED smallint  default 0,'
||'BB_REMOVED_PRODUCT varchar ( 240 ) default null,'
|| 'TALK_REMOVED_PRODUCT varchar(30) default null,'
||'ANY_OFFER_GIVEN smallint  default 0,'
||'TENURE int default null,'
||'TV_REGION varchar ( 45 ) default null,'
||'NUMBER_OF_ORDERS int  default null,'
||'TV_OFFER_GIVEN smallint  default 0,'
||'COMMS_OFFER_GIVEN smallint  default 0,'
||'SPORTS_COMPLETE_ADDED smallint  default 0,'
||'SPORTS_COMPLETE_REMOVED smallint  default 0,'
||'SPORTS_ACTION_ADDED smallint  default 0,'
||'SPORTS_ACTION_REMOVED smallint  default 0,'
||'SPORTS_CRICKET_ADDED smallint  default 0,'
||'SPORTS_CRICKET_REMOVED smallint  default 0,'
||'SPORTS_F1_ADDED smallint  default 0,'
||'SPORTS_F1_REMOVED smallint  default 0,'
||'SPORTS_FOOTBALL_ADDED smallint  default 0,'
||'SPORTS_FOOTBALL_REMOVED smallint  default 0,'
||'SPORTS_GOLF_ADDED smallint  default 0,'
||'SPORTS_GOLF_REMOVED smallint  default 0,'
||'SPORTS_PREMIERLEAGUE_ADDED smallint  default 0,'
||'SPORTS_PREMIERLEAGUE_REMOVED smallint  default 0,'
||'CINEMA_ADDED smallint  default 0,'
||'CINEMA_REMOVED smallint  default 0,'
||'ANY_NEW_OFFER_FLAG int  default null,'
||'Asia_Pack_Active tinyint  default 0,'
||'MuTV_Pack_Active tinyint  default 0,'
||'LTV_Pack_Active tinyint  default 0,'
||'CTV_Pack_Active tinyint  default 0,'
||'SKY_KIDS_ADDED smallint  default 0,'
||'SKY_KIDS_REMOVED smallint  default 0,'
||'SKY_BOXSETS_ADDED smallint  default 0,'
||'SKY_BOXSETS_REMOVED smallint  default 0,'
||'SPOTIFY_ADDED smallint default 0, '
||'SPOTIFY_REMOVED smallint default 0, '
||'UOD_ADDED smallint default 0,'
||'UOD_REMOVED smallint default 0,'
||'Netflix_Added_Product varchar(30) default null, '
||'Netflix_Removed_Product varchar(30) default null, '
||'DTV_ADDED_PRODUCT varchar ( 240 ) default null,'
||'DTV_REMOVED_PRODUCT varchar ( 240 ) default null,'
||'DTV_Status varchar ( 50 ) default null,'
||'ACTIVE_DTV_BEFORE_ORDER smallint  default 0, '
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


dba.sp_drop_table 'Decisioning','ECONOMETRICS_DTV_ACQUISITIONS_OFFERS'
dba.sp_create_table 'Decisioning','ECONOMETRICS_DTV_ACQUISITIONS_OFFERS',  
  'YEAR_WEEK varchar  (  31  )  default null,'
||'WEEK_START date  default  null,'
||'CURRENCY_CODE varchar  (  10  )  default null,'
||'RTM_LEVEL_1 varchar  (  50  )  default null,'
||'RTM_LEVEL_2 varchar  (  50  )  default null,'
||'RTM_LEVEL_3 varchar  (  50  )  default null,'
||'ORDER_COMMUNICATION_TYPE varchar   (  10  )  default null,'
||'ORDER_SALE_TYPE varchar  (  50  )  default null,'
||'CONTACT_TYPE varchar (  20  )  default null,'
||'CHANGE_TYPE char (  11  )  default null,'
||'DTV_CHANGE char  (  20  )  default null,'
||'ORDER_CHANGE_COMPLETED smallint  default  0,'
||'PREVIOUS_DTV smallint  default   0,'
||'PREVIOUS_DTV_1_YEAR smallint  default   0,'
||'PREVIOUS_BB smallint  default 0,'
||'ORDER_BECAME_ACTIVE smallint  default  0,'
||'ACCOUNT_ACTIVE_LENGTH smallint  default  0,'
||'BB_BEFORE_ORDER smallint  default 0,'
||'BB_AFTER_ORDER smallint  default  0,'
||'SPORTS_ADDED smallint  default    0,'
||'MOVIES_ADDED smallint  default   0,'
||'LEGACY_SPORTS_SUB_ADDED smallint  default  0,'
||'LEGACY_MOVIES_SUB_ADDED smallint  default 0,'
||'SPORTS_PACK_SUB_ADDED smallint  default  0,'
||'SPORTS_PACK_ADDED smallint  default  0,'
||'HD_LEGACY_ADDED smallint  default  0,'
||'HD_BASIC_ADDED smallint  default 0,'
||'HD_Sports_Added smallint  default 0,'
||'MS_ADDED_PRODUCT varchar(30) default null,'
||'SKY_PLUS_ADDED smallint  default  0,'
||'SKY_GO_EXTRA_ADDED smallint  default    0,'
||'NOW_TV_ADDED smallint  default   0,'
||'BB_ADDED smallint  default 0,'
||'BB_ADDED_PRODUCT varchar (  240   )  default null,'
||'TALK_ADDED_PRODUCT varchar(30) default null,'
||'SPORTS_REMOVED smallint  default  0,'
||'MOVIES_REMOVED smallint  default 0,'
||'LEGACY_SPORTS_SUB_REMOVED smallint  default  0,'
||'LEGACY_MOVIES_SUB_REMOVED smallint  default 0,'
||'SPORTS_PACK_SUB_REMOVED smallint  default   0,'
||'SPORTS_PACK_REMOVED smallint  default  0,'
||'HD_LEGACY_REMOVED smallint  default   0,'
||'HD_BASIC_REMOVED smallint  default 0,'
||'HD_SPORTS_REMOVED smallint  default  0,'
|| 'MS_REMOVED_PRODUCT varchar(30) default null,'
||'SKY_PLUS_REMOVED smallint  default 0,'
||'SKY_GO_EXTRA_REMOVED smallint  default 0,'
||'NOW_TV_REMOVED smallint  default  0,'
||'BB_REMOVED_PRODUCT varchar   (  240   )  default null,'
||'TALK_REMOVED_PRODUCT varchar(30) default null,'
||'ANY_OFFER_GIVEN smallint  default 0,'
||'OFFER_SUB_TYPE varchar  (  80  )  default null,'
||'OFFER_DESCRIPTION varchar (  465   )  default null,'
||'MONTHLY_OFFER_VALUE decimal   (  5,2 )  default null,'
||'OFFER_DURATION_MTH int  default null,'
||'TOTAL_OFFER_VALUE decimal (  5,2 )  default null,'
||'AUTO_TRANSFER_OFFER smallint  default  0,'
||'TENURE int  default null,'
||'TV_REGION varchar  (  45  )  default null,'
||'NUMBER_OF_ORDERS int  default   null,'
||'TV_OFFER_GIVEN smallint  default   0,'
||'COMMS_OFFER_GIVEN smallint  default  0,'
||'SPORTS_COMPLETE_ADDED smallint  default  0,'
||'SPORTS_COMPLETE_REMOVED smallint  default   0,'
||'SPORTS_ACTION_ADDED smallint  default  0,'
||'SPORTS_ACTION_REMOVED smallint  default 0,'
||'SPORTS_CRICKET_ADDED smallint  default   0,'
||'SPORTS_CRICKET_REMOVED smallint  default  0,'
||'SPORTS_F1_ADDED smallint  default 0,'
||'SPORTS_F1_REMOVED smallint  default 0,'
||'SPORTS_FOOTBALL_ADDED smallint  default 0,'
||'SPORTS_FOOTBALL_REMOVED smallint  default 0,'
||'SPORTS_GOLF_ADDED smallint  default  0,'
||'SPORTS_GOLF_REMOVED smallint  default  0,'
||'SPORTS_PREMIERLEAGUE_ADDED smallint  default 0,'
||'SPORTS_PREMIERLEAGUE_REMOVED smallint  default 0,'
||'CINEMA_ADDED smallint  default  0,'
||'CINEMA_REMOVED smallint  default  0,'
||'ANY_NEW_OFFER_FLAG int  default null,'
||'Asia_Pack_Active tinyint  default    0,'
||'MuTV_Pack_Active tinyint  default  0,'
||'LTV_Pack_Active tinyint  default   0,'
||'CTV_Pack_Active tinyint  default    0,'
||'SKY_KIDS_ADDED smallint  default 0,'
||'SKY_KIDS_REMOVED smallint  default    0,'
||'SKY_BOXSETS_ADDED smallint  default  0,'
||'SKY_BOXSETS_REMOVED smallint  default 0,'
||'SPOTIFY_ADDED smallint default 0, '
||'SPOTIFY_REMOVED smallint default 0, '
||'UOD_ADDED smallint default 0,'
||'UOD_REMOVED smallint default 0,'
||'Netflix_Added_Product varchar(30) default null, '
||'Netflix_Removed_Product varchar(30) default null, '
||'DTV_ADDED_PRODUCT varchar (  240   )  default null,'
||'DTV_REMOVED_PRODUCT varchar  (  240   )  default null,'
||'DTV_Status varchar (  50  )  default null,'
||'ACTIVE_DTV_BEFORE_ORDER smallint  default 0, '
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

*/


setuser Decisioning_Procs
GO
DROP PROCEDURE IF EXISTS Decisioning_Procs.Update_Econometrics_DTV_Acquisition;
GO
create procedure Decisioning_Procs.Update_Econometrics_DTV_Acquisition(Refresh_Dt date default null ) 
sql security invoker
begin
  set option Query_Temp_Space_Limit = 0;
  /*
CREATE OR REPLACE VARIABLE PERIOD_START date;
CREATE OR REPLACE VARIABLE PERIOD_END date;
set PERIOD_START = '2017-11-01';  -- Set this to be first day to get data for (ie first day where movements are counted)
set PERIOD_END = '2017-11-01';    -- Set this to be last day to get data for (ie last day where movements are counted)

*/
  if Refresh_Dt is null then
    set Refresh_Dt
       = (select cast(DATEADD(day,-28,coalesce(max(week_start),'2012-01-29')) as date)
        from Decisioning.ECONOMETRICS_DTV_ACQUISITIONS_ORDERS)
  end if;
  if Refresh_Dt is not null then
    set Refresh_Dt
       = case when DATEPART(weekday,Refresh_Dt) = 1 then cast(DATEADD(day,-2,Refresh_Dt) as date) --sunday
      when DATEPART(weekday,Refresh_Dt) = 2 then cast(DATEADD(day,-3,Refresh_Dt) as date) --monday
      when DATEPART(weekday,Refresh_Dt) = 3 then cast(DATEADD(day,-4,Refresh_Dt) as date) --tue
      when DATEPART(weekday,Refresh_Dt) = 4 then cast(DATEADD(day,-5,Refresh_Dt) as date) --wed
      when DATEPART(weekday,Refresh_Dt) = 5 then cast(DATEADD(day,-6,Refresh_Dt) as date) --thu
      when DATEPART(weekday,Refresh_Dt) = 6 then Refresh_Dt --fri
      when DATEPART(weekday,Refresh_Dt) = 7 then cast(DATEADD(day,-1,Refresh_Dt) as date) end --sat
  end if;
  drop table if exists #DTV;
  select ACCOUNT_NUMBER,
    Account_Currency_Code as CURRENCY_CODE,
    CUSTOMER_SK,
    ORDER_ID,
    ORDER_NUMBER,
    ORDER_DT,
    cast(ORDER_DT-1 as date) as ORDER_DT_SoD,
    RTM_LEVEL_1,
    RTM_LEVEL_2,
    RTM_LEVEL_3,
    ORDER_COMMUNICATION_TYPE,
    ORDER_SALE_TYPE,
    case when((FAMILY_ADDED+VARIETY_ADDED+ORIGINAL_ADDED+SKYQ_ADDED) >= 1) or(DTV_ADDED_PRODUCT = 'Sky Entertainment') then 'ACQUISITION' when((FAMILY_REMOVED+VARIETY_REMOVED+ORIGINAL_REMOVED+SKYQ_REMOVED) >= 1) or(DTV_REMOVED_PRODUCT = 'Sky Entertainment') then 'CHURN' end as CHANGE_TYPE,
    case when FAMILY_ADDED = 1 then 'FAMILY ACQUISITION'
    when VARIETY_ADDED = 1 then 'VARIETY ACQUISITION'
    when ORIGINAL_ADDED = 1 then 'ORIGINAL ACQUISITION'
    when SKYQ_ADDED = 1 then 'SKYQ ACQUISITION'
    when FAMILY_REMOVED = 1 then 'FAMILY CHURN'
    when VARIETY_REMOVED = 1 then 'VARIETY CHURN'
    when ORIGINAL_REMOVED = 1 then 'ORIGINAL CHURN'
    when SKYQ_REMOVED = 1 then 'SKYQ CHURN'
    else 'UNKNOWN'
    end as DTV_CHANGE,
    0 as ORDER_CHANGE_COMPLETED,
    0 as PREVIOUS_DTV,
    0 as PREVIOUS_DTV_1_YEAR,
    0 as PREVIOUS_BB,
    0 as ORDER_BECAME_ACTIVE,
    0 as ACCOUNT_ACTIVE_LENGTH,
    0 as BB_BEFORE_ORDER,
    0 as BB_AFTER_ORDER,
    SPORTS_ADDED,
    MOVIES_ADDED,
    LEGACY_SPORTS_SUB_ADDED,
    LEGACY_MOVIES_SUB_ADDED,
    LEGACY_SPORTS_ADDED,
    LEGACY_MOVIES_ADDED,
    SPORTS_PACK_SUB_ADDED,
    SPORTS_PACK_ADDED,
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
    BB_ADDED,
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
    BB_REMOVED_PRODUCT,
    TALKU_REMOVED,
    TALKW_REMOVED,
    TALKF_REMOVED,
    TALKA_REMOVED,
    TALKP_REMOVED,
    TALKO_REMOVED,
    cast(null as varchar(20)) as CONTACT_TYPE,
    cast(null as varchar(15)) as ACTUAL_OFFER_STATUS,
    cast(null as varchar(15)) as INTENDED_OFFER_STATUS,
    0 as ANY_OFFER_FLAG,
    0 as TV_OFFER_FLAG,
    0 as BB_OFFER,
    0 as COMMS_OFFER_FLAG,
    SPORTS_COMPLETE_ADDED,
    SPORTS_COMPLETE_REMOVED,
    --SPORTS_CONTRACT_ADDED ,
    --SPORTS_CONTRACT_REMOVED ,
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
    CINEMA_ADD_ON_ADDED,
    --CINEMA_CONTRACT_ADDED ,
    --CINEMA_CONTRACT_REMOVED ,
    CINEMA_ADD_ON_REMOVED, -- ROSE CHANGES
    SPOTIFY_ADDED,
    SPOTIFY_REMOVED,
    UOD_ADDED,
    UOD_REMOVED,
    Netflix_Standard_Added,
    Netflix_Standard_Removed,
    Netflix_Premium_Added,
    Netflix_Premium_Removed,
    KIDS_ADDED,
    KIDS_REMOVED,
    BOXSETS_ADDED,
    BOXSETS_REMOVED,
    DTV_ADDED_PRODUCT,
    DTV_REMOVED_PRODUCT, -- MMC New Offer Fields
    cast(null as date) as Prev_Offer_Start_Dt_Any,
    cast(null as date) as Prev_Offer_Intended_end_Dt_Any,
    cast(null as date) as Prev_Offer_Actual_End_Dt_Any,
    cast(null as date) as Curr_Offer_Start_Dt_Any,
    cast(null as date) as Curr_Offer_Intended_end_Dt_Any,
    cast(null as date) as Curr_Offer_Actual_End_Dt_Any,
    cast(null as varchar(30)) as Offer_End_Status_Level_1,
    cast(null as varchar(30)) as Offer_End_Status_Level_2,
    cast(0 as tinyint) as Offers_Applied_Lst_1D_Any,
    cast(0 as tinyint) as Offers_Applied_Lst_1D_DTV,
    cast(0 as tinyint) as Offers_Applied_Lst_1D_BB,
    cast(0 as tinyint) as Offers_Applied_Lst_1D_LR,
    cast(0 as tinyint) as Offers_Applied_Lst_1D_Talk,
    cast(0 as tinyint) as Offers_Applied_Lst_1D_Comms,
    cast(0 as tinyint) as Offers_Applied_Lst_1D_MS,
    cast(0 as tinyint) as Offers_Applied_Lst_1D_SGE,
    cast(0 as tinyint) as Offers_Applied_Lst_1D_HD,
    cast(0 as tinyint) as Offers_Applied_Lst_1D_TOPTIER,
    cast(0 as tinyint) as Offers_Applied_Lst_1D_Sports,
    cast(0 as tinyint) as Offers_Applied_Lst_1D_Movies, -- ROSE CHANGES
    cast(0 as tinyint) as Offers_Applied_Lst_1D_Kids,
    cast(0 as tinyint) as Offers_Applied_Lst_1D_Boxsets,
    cast(0 as integer) as ANY_NEW_OFFER_FLAG,
    cast(0 as integer) as NEW_DTV_PRIMARY_VIEWING_OFFER,
    cast(0 as tinyint) as DTV_Active, --,CAST() AS CONTRACT_STATUS
    cast(null as varchar(50)) as SUBSCRIPTION_ID, --Added by AP
    cast(null as varchar(50)) as DTV_Status,
    1 as Orders,
    0 as existing_dtv,
    0 as Existing_AP_AC,
    0 as Existing_PC_AC,
    0 as Existing_PA_AP,
    0 as Existing_AB_AC,
    0 as Existing_BB_Active,
    0 as Existing_BB_Order,
    0 as New_bb_Order,
    0 as BB_Churn,
    0 as SATV,
    0 as DTV_Order_Filter,
    0 as ACTIVE_DTV_BEFORE_ORDER
    into #DTV
    from Decisioning.Orders_Daily
    where order_dt >= Refresh_Dt
    --order_dt>=period_start
    --AND order_dt<=period_end
    and(((FAMILY_ADDED+VARIETY_ADDED+ORIGINAL_ADDED+SKYQ_ADDED) >= 1
    and(FAMILY_REMOVED+VARIETY_REMOVED+ORIGINAL_REMOVED+SKYQ_REMOVED) = 0)
    or((FAMILY_ADDED+VARIETY_ADDED+ORIGINAL_ADDED+SKYQ_ADDED) = 0
    and(FAMILY_REMOVED+VARIETY_REMOVED+ORIGINAL_REMOVED+SKYQ_REMOVED) >= 1)
    or(DTV_ADDED_PRODUCT = 'Sky Entertainment')
    or(DTV_REMOVED_PRODUCT = 'Sky Entertainment'));
  commit work;
  -- MMC new proc calls to populate offers details ---------------------------------------------
  call Decisioning_Procs.Add_Offers_Software('#DTV','ORDER_DT_SoD','Any','Ordered','All',Null,'Update Only','Prev_Offer_Start_Dt_Any','Prev_Offer_Intended_end_Dt_Any','Prev_Offer_Actual_End_Dt_Any','Curr_Offer_Start_Dt_Any','Curr_Offer_Intended_end_Dt_Any','Curr_Offer_Actual_End_Dt_Any'); -- Offers for
  call Decisioning_Procs.Add_Offers_Software('#DTV','ORDER_DT','Any','Ordered','New',Null,'Update Only','Offers_Applied_Lst_1D_Any');
  -- Offers for DTV
  call Decisioning_Procs.Add_Offers_Software('#DTV','ORDER_DT','DTV','Ordered','New',Null,'Update Only','Offers_Applied_Lst_1D_DTV');
  -- -- Product holding for BB
  -- Call Decisioning_Procs.Add_Active_Subscriber_Product_Holding('#DTV','ORDER_DT','BB','Update Only','BB_ADDED','BB_PRODUCT_HOLDING');
  update #DTV
    set ANY_NEW_OFFER_FLAG
     = case when Offers_Applied_Lst_1D_Any > 0 then 1
    else 0
    end,
    NEW_DTV_PRIMARY_VIEWING_OFFER
     = case when Offers_Applied_Lst_1D_DTV > 0 then 1
    else 0
    end;
  update #DTV
    set Offers_Applied_Lst_1D_Any = 0,
    Offers_Applied_Lst_1D_DTV = 0;
  commit work;
  -- Offers for All
  call Decisioning_Procs.Add_Offers_Software('#DTV','ORDER_DT','Any','Ordered','All',Null,'Update Only','Offers_Applied_Lst_1D_Any');
  -- Offers for DTV
  call Decisioning_Procs.Add_Offers_Software('#DTV','ORDER_DT','DTV','Ordered','All',Null,'Update Only','Offers_Applied_Lst_1D_DTV');
  -- Offers for BB
  call Decisioning_Procs.Add_Offers_Software('#DTV','ORDER_DT','BB','Ordered','All',Null,'Update Only','Offers_Applied_Lst_1D_BB');
  -- Offers for LR
  call Decisioning_Procs.Add_Offers_Software('#DTV','ORDER_DT','Line Rental','Ordered','All',Null,'Update Only','Offers_Applied_Lst_1D_LR');
  -- Offers for Talk
  call Decisioning_Procs.Add_Offers_Software('#DTV','ORDER_DT','Talk','Ordered','All',Null,'Update Only','Offers_Applied_Lst_1D_Talk');
  -- Offers for MS
  call Decisioning_Procs.Add_Offers_Software('#DTV','ORDER_DT','MS','Ordered','All',Null,'Update Only','Offers_Applied_Lst_1D_MS');
  -- Offers for SGE
  call Decisioning_Procs.Add_Offers_Software('#DTV','ORDER_DT','SGE','Ordered','All',Null,'Update Only','Offers_Applied_Lst_1D_SGE');
  -- Offers for HD
  call Decisioning_Procs.Add_Offers_Software('#DTV','ORDER_DT','HD','Ordered','All',Null,'Update Only','Offers_Applied_Lst_1D_HD');
  -- Offers for TopTier
  call Decisioning_Procs.Add_Offers_Software('#DTV','ORDER_DT','TopTier','Ordered','All',Null,'Update Only','Offers_Applied_Lst_1D_TopTier');
  -- Offers for Prems
  call Decisioning_Procs.Add_Offers_Software('#DTV','ORDER_DT','Sports','Ordered','All',Null,'Update Only','Offers_Applied_Lst_1D_Sports');
  call Decisioning_Procs.Add_Offers_Software('#DTV','ORDER_DT','Movies','Ordered','All',Null,'Update Only','Offers_Applied_Lst_1D_Movies');
  -- Offers for Kids
  call Decisioning_Procs.Add_Offers_Software('#DTV','ORDER_DT','Sports','Ordered','All',Null,'Update Only','Offers_Applied_Lst_1D_Sports');
  -- Offers for Boxsets
  call Decisioning_Procs.Add_Offers_Software('#DTV','ORDER_DT','Movies','Ordered','All',Null,'Update Only','Offers_Applied_Lst_1D_Movies');
  update #DTV
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
  update #DTV
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
  update #DTV as A
    set A.ACTIVE_DTV_BEFORE_ORDER = B.dtv_Active_subscription from
    #DTV as A
    join CITEAM.ACTIVE_SUBSCRIBER_REPORT as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    where A.order_dt-1 between B.effective_from_dt and B.effective_to_dt-1
    and B.DTV_Active = 1;
  -- *********************************************************************************************
  -- Set DTV & BB status
  -- *********************************************************************************************
  update #DTV as a
    set existing_dtv = 1 from
    #DTV as a
    join(select a.account_number,
      a.order_dt
      from #DTV as a
        join cust_subs_hist as b on a.account_number = b.account_number
        and b.effective_from_dt < a.order_dt
        and b.effective_to_dt > a.order_dt
      where b.subscription_sub_type = 'DTV Primary Viewing'
      and b.status_code in( 'AC' ) 
      group by a.account_number,
      a.order_dt) as b on a.account_number = b.account_number
    and a.order_dt = b.order_dt;
  update #DTV as a
    set existing_pa_ap = 1 from
    #DTV as a
    join(select a.account_number,
      a.order_dt
      from #DTV as a
        join cust_subs_hist as b on a.account_number = b.account_number
        and b.effective_from_dt = a.order_dt
      where b.subscription_sub_type = 'DTV Primary Viewing'
      and b.status_code = 'AP'
      and b.prev_status_code = 'PA'
      and status_code_changed = 'Y'
      group by a.account_number,
      a.order_dt) as b on a.account_number = b.account_number
    and a.order_dt = b.order_dt;
  update #DTV as a
    set existing_ap_ac = 1 from
    #DTV as a
    join(select a.account_number,
      a.order_dt
      from #DTV as a
        join cust_subs_hist as b on a.account_number = b.account_number
        and b.effective_from_dt = a.order_dt
      where b.subscription_sub_type = 'DTV Primary Viewing'
      and b.status_code = 'AC'
      and b.prev_status_code in( 'AP' ) 
      group by a.account_number,
      a.order_dt) as b on a.account_number = b.account_number
    and a.order_dt = b.order_dt;
  update #DTV as a
    set existing_pc_ac = 1 from
    #DTV as a
    join(select a.account_number,
      a.order_dt
      from #DTV as a
        join cust_subs_hist as b on a.account_number = b.account_number
        and b.effective_from_dt = a.order_dt
      where b.subscription_sub_type = 'DTV Primary Viewing'
      and b.status_code = 'AC'
      and b.prev_status_code in( 'PC' ) 
      group by a.account_number,
      a.order_dt) as b on a.account_number = b.account_number
    and a.order_dt = b.order_dt;
  update #DTV as a
    set existing_ab_ac = 1 from
    #DTV as a
    join(select a.account_number,
      a.order_dt
      from #DTV as a
        join cust_subs_hist as b on a.account_number = b.account_number
        and b.effective_from_dt = a.order_dt
      where b.subscription_sub_type = 'DTV Primary Viewing'
      and b.status_code = 'AC'
      and b.prev_status_code = 'AB'
      group by a.account_number,
      a.order_dt) as b on a.account_number = b.account_number
    and a.order_dt = b.order_dt;
  update #DTV as a
    set existing_bb_active = 1 from
    #DTV as a
    join(select a.account_number,
      a.order_dt
      from #DTV as a
        join cust_subs_hist as b on a.account_number = b.account_number
        and b.effective_from_dt <= a.order_dt
        and b.effective_to_dt > a.order_dt
      where b.subscription_sub_type = 'Broadband DSL Line'
      and b.status_code in( 'AC',
      'AB',
      'PC' ) 
      group by a.account_number,
      a.order_dt) as b on a.account_number = b.account_number
    and a.order_dt = b.order_dt;
  update #DTV as a
    set existing_bb_order = 1 from
    #DTV as a
    join(select a.account_number,
      a.order_dt
      from #DTV as a
        join cust_subs_hist as b on a.account_number = b.account_number
        and b.effective_from_dt between(a.order_dt-56) and(a.order_dt-1)
      where b.subscription_sub_type = 'Broadband DSL Line'
      and b.status_code in( 'IT',
      'EN',
      'SU' ) 
      group by a.account_number,
      a.order_dt) as b on a.account_number = b.account_number
    and a.order_dt = b.order_dt;
  update #DTV as a
    set new_bb_order = 1 from
    #DTV as a
    join(select a.account_number,
      a.order_dt
      from #DTV as a
        join cust_subs_hist as b on a.account_number = b.account_number
        and b.effective_from_dt = a.order_dt
      where b.subscription_sub_type = 'Broadband DSL Line'
      and b.status_code in( 'AE',
      'AP',
      'RQ',
      'AC' ) 
      group by a.account_number,
      a.order_dt) as b on a.account_number = b.account_number
    and a.order_dt = b.order_dt;
  update #DTV as a
    set BB_Churn = 1 from
    #DTV as a
    join(select a.account_number,
      a.order_dt
      from #DTV as a
        join cust_subs_hist as b on a.account_number = b.account_number
        and b.effective_from_dt <= a.order_dt
      where b.subscription_sub_type = 'Broadband DSL Line'
      and b.status_code in( 'PO',
      'SC' ) 
      and b.prev_status_code in( 'AC',
      'AB',
      'PC' ) 
      and b.status_code_changed = 'Y'
      group by a.account_number,
      a.order_dt) as b on a.account_number = b.account_number
    and a.order_dt = b.order_dt;
  update #DTV
    set DTV_Status
     = case when existing_dtv = 1 then 'A.Existing DTV'
    when existing_ap_ac = 1 then 'B1. AP-->AC'
    when existing_pa_ap = 1 then 'B2. PA-->AP'
    when existing_pc_ac = 1 then 'B3. PC-->AC'
    when existing_ab_ac = 1 then 'C. AB-->AC'
    when existing_BB_active = 1 then 'D1. Existing Upgrades'
    when existing_BB_order = 1 then 'D2.BB Order Pending Upgrades'
    when new_bb_order = 1 then 'E. New Sale'
    when BB_Churn = 1 then 'F.TV Only'
    else 'NO TV'
    end;
  -- Patch 1
  update #DTV as A
    set A.ORDER_CHANGE_COMPLETED
     = case when A.CHANGE_TYPE in( 'ACQUISITION' ) 
    and B.ACCOUNT_NUMBER is not null
    and B.EVENT_DT is not null then 1
    when A.CHANGE_TYPE in( 'ACQUISITION' ) 
    and B.ACCOUNT_NUMBER is null then 2
    else A.ORDER_CHANGE_COMPLETED
    end from
    #DTV as A
    left outer join Decisioning.Activations_DTV as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_ID = B.ORDER_ID;
  -- Patch 2
  update #DTV as A
    set A.ORDER_CHANGE_COMPLETED
     = case when A.CHANGE_TYPE in( 'ACQUISITION' ) 
    and B.ACCOUNT_NUMBER is not null
    and B.EVENT_DT is not null then 1
    when A.CHANGE_TYPE in( 'ACQUISITION' ) 
    and B.ACCOUNT_NUMBER is null then 2
    else A.ORDER_CHANGE_COMPLETED
    end from
    #DTV as A
    left outer join CITeam.Orders_Detail as C on A.Account_Number = C.Account_Number
    and A.Order_Dt = C.Order_Dt
    and C.DTV_Added_Product is not null
    join Decisioning.Activations_DTV as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and B.ORDER_ID = C.ORDER_ID
    where ORDER_CHANGE_COMPLETED in( 0,
    2 ) ;
  update #DTV as A
    set A.ORDER_CHANGE_COMPLETED
     = case when B.STATUS_CODE in( 'SC','PO','IT','EN','PA','EE','?','SU','EQ','PC','AB' ) then 0
    else 2
    end from
    #DTV as A
    left outer join CUST_SUBS_HIST as B
    on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_ID = B.ORDER_ID
    and a.order_dt = b.effective_from_dt
    and ORDER_CHANGE_COMPLETED <> 1
    where B.subscription_sub_type = 'DTV Primary Viewing' and effective_from_dt < effective_to_dt and STATUS_CODE_CHANGED = 'Y'
    and OWNING_CUST_ACCOUNT_ID > '1';
  delete from
    #DTV
    where ORDER_CHANGE_COMPLETED = 2;
  update #DTV as A
    set A.ORDER_CHANGE_COMPLETED
     = case when A.CHANGE_TYPE = 'CHURN'
    and B.ACCOUNT_NUMBER is not null then 1
    when A.CHANGE_TYPE = 'CHURN'
    and B.ACCOUNT_NUMBER is null then 0
    else A.ORDER_CHANGE_COMPLETED
    end from
    #DTV as A
    left outer join Decisioning.Churn_DTV as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_ID = B.ORDER_ID;
  ----------------Update SUBSCRIPTION_ID----------
  update #DTV as A
    set A.SUBSCRIPTION_ID = B.SUBSCRIPTION_ID from
    #DTV as A
    left outer join CUST_SUBS_HIST as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_ID = B.ORDER_ID
    and b.effective_from_dt between a.order_dt and a.order_dt --AND\x09ORDER_CHANGE_COMPLETED<>1
    where B.subscription_sub_type = 'DTV Primary Viewing'
    and effective_from_dt < effective_to_dt
    and B.owning_cust_account_id > '1'
    and B.SI_Latest_Src = 'CHORD'
    and B.STATUS_CODE in( 'AC','AB','PC' ) 
    and OWNING_CUST_ACCOUNT_ID > '1';
  --FLAG IF CUSTOMER HAS HAD DTV ACTIVE PREVIOUSLY AND IF THEY HAVE HAD ACTIVE DTV IN THE LAST YEAR
  drop table if exists #DTV_ACTIVE;
  select A.ORDER_ID,
    A.ORDER_DT,
    A.ACCOUNT_NUMBER,
    MAX(B.effective_to_dt) as LAST_ACTIVE_DATE into #DTV_ACTIVE
    from #DTV as A
      join CITeam.Active_Subscriber_Report as B
      on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and A.ORDER_DT > B.effective_from_dt
      and B.DTV_ACTIVE_SUBSCRIPTION = 1
    group by A.ORDER_ID,
    A.ORDER_DT,
    A.ACCOUNT_NUMBER;
  update #DTV as A
    set A.PREVIOUS_DTV = 1,
    A.PREVIOUS_DTV_1_YEAR
     = case when B.LAST_ACTIVE_DATE >= A.ORDER_DT-365 then 1
    else 0
    end from
    #DTV_ACTIVE as B
    where A.ORDER_ID = B.ORDER_ID;
  --FLAG IF CUSTOMER HAS HAD BB ACTIVE PREVIOUSLY
  drop table if exists #BB_ACTIVE;
  select A.ORDER_ID,
    A.ORDER_DT,
    A.ACCOUNT_NUMBER,
    MAX(B.effective_to_dt) as LAST_ACTIVE_DATE into #BB_ACTIVE
    from #DTV as A
      join CITeam.Active_Subscriber_Report as B --changed by AP
      on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and A.ORDER_DT > B.effective_from_dt
      and B.BB_ACTIVE_SUBSCRIPTION = 1
    group by A.ORDER_ID,
    A.ORDER_DT,
    A.ACCOUNT_NUMBER;
  update #DTV as A
    set A.PREVIOUS_BB = 1 from
    #BB_ACTIVE as B
    where A.ORDER_ID = B.ORDER_ID;
  --FLAG if Order was activated by Order date
  drop table if exists #DTV_ORDER;
  select A.ACCOUNT_NUMBER,
    A.ORDER_ID,
    A.ORDER_DT,
    coalesce(MIN(B.ORDER_DT),'9999-09-09') as NEXT_ORDER_DT into #DTV_ORDER
    from #DTV as A
      left outer join #DTV as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and A.ORDER_DT < B.ORDER_DT
    group by A.ACCOUNT_NUMBER,
    A.ORDER_ID,
    A.ORDER_DT;
  drop table if exists #ASR;
  select row_number() over(order by account_number asc,effective_from_dt asc) as HOLDINGS_ID,ACCOUNT_NUMBER,DTV_ACTIVE_SUBSCRIPTION,effective_from_dt
    into #ASR
    from CITeam.Active_Subscriber_Report --where effective_to_dt>='2012-01-01'
    order by ACCOUNT_NUMBER asc,effective_from_dt asc;
  drop table if exists #DTV_HOLDINGS_EVENTS;
  select A.ACCOUNT_NUMBER,
    A.effective_from_dt into #DTV_HOLDINGS_EVENTS
    from #ASR as A
      left outer join #ASR as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and A.HOLDINGS_ID-1 = B.HOLDINGS_ID
    where A.DTV_ACTIVE_SUBSCRIPTION = 1;
  --  AND B.DTV_ACTIVE_SUBSCRIPTION=0
  drop table if exists #DTV_UPDATE;
  select A.* into #DTV_UPDATE
    from #DTV_ORDER as A
      join #DTV_HOLDINGS_EVENTS as B
      on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and B.effective_from_dt between A.ORDER_DT and A.NEXT_ORDER_DT;
  update #DTV as A
    set A.ORDER_BECAME_ACTIVE = 1 from
    #DTV_UPDATE as B
    where A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT = B.ORDER_DT;
  --FLAG how long the account was active after the Order
  drop table if exists #ACCOUNT_ACTIVE;
  select A.ACCOUNT_NUMBER,
    A.ORDER_DT,
    coalesce(MIN(B.EFFECTIVE_FROM_DT),TODAY()) as ACTIVE_DT
    into #ACCOUNT_ACTIVE
    from #DTV as A
      left outer join CITEAM.Active_subscriber_report as B
      on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and A.ORDER_DT < B.EFFECTIVE_TO_DT
      and B.DTV_Active_subscription = 1
    group by A.ACCOUNT_NUMBER,
    A.ORDER_DT;
  drop table if exists #dtv1;
  select account_number,effective_from_dt,effective_to_dt
    into #dtv1
    from CITEAM.Active_subscriber_report as B
    where DTV_active_subscription = 1
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
  update #DTV as A
    set A.ACCOUNT_ACTIVE_LENGTH = B.ACCOUNT_ACTIVE_LENGTH from
    #ACCOUNT_ACTIVE3 as B
    where A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT = B.ORDER_DT;
  --Flag If Customer had BB before Order and If they Had BB After Order
  update #DTV as A
    set A.BB_BEFORE_ORDER
     = case when B.BB_ACTIVE_SUBSCRIPTION = 1 then 1
    else 0
    end from
    #DTV as A
    left outer join(select *
      from CITeam.Active_Subscriber_Report
      where BB_ACTIVE_SUBSCRIPTION = 1) as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT-1 >= effective_from_dt
    and A.ORDER_DT-1 < effective_to_dt;
  update #DTV as aa
    set bb_after_order = case when bb_added_product = bb_removed_product then 0
    when bb_added_product is not null then 1
    else 0
    end;
  update #DTV as aa
    set bb_after_order = 1 from
    #DTV as aa
    join CITEam.active_subscriber_report as bb
    on aa.account_number = bb.account_number
    where aa.order_dt between bb.effective_from_dt and bb.effective_to_dt-1
    and bb_active_subscription = 1;
  /*
UPDATE #DTV AS A
SET A.BB_AFTER_ORDER = CASE
WHEN B.BB_ACTIVE_SUBSCRIPTION =0
AND A.BB_ADDED_PRODUCT IS NOT NULL
AND (CASE
WHEN A.BB_ADDED_PRODUCT IS NOT NULL THEN 1
ELSE 0
END) <> (CASE
WHEN A.BB_REMOVED_PRODUCT IS NOT NULL THEN 1
ELSE 0
END) THEN 1
WHEN B.BB_ACTIVE_SUBSCRIPTION=0
AND (CASE
WHEN A.BB_ADDED_PRODUCT IS NOT NULL THEN 1
ELSE 0
END) = (CASE
WHEN A.BB_REMOVED_PRODUCT IS NOT NULL THEN 1
ELSE 0
END) THEN 0
WHEN B.BB_ACTIVE_SUBSCRIPTION=1
AND (CASE
WHEN A.BB_ADDED_PRODUCT IS NOT NULL THEN 1
ELSE 0
END) <> (CASE
WHEN A.BB_REMOVED_PRODUCT IS NOT NULL THEN 1
ELSE 0
END) THEN 1
WHEN B.BB_ACTIVE_SUBSCRIPTION=1
AND (CASE
WHEN A.BB_ADDED_PRODUCT IS NOT NULL THEN 1
ELSE 0
END) < (CASE
WHEN A.BB_REMOVED_PRODUCT IS NOT NULL THEN 1
ELSE 0
END) THEN 0
WHEN B.BB_ACTIVE_SUBSCRIPTION=1 THEN 1
ELSE 0
END
FROM #DTV AS A
LEFT JOIN CITeam.Active_Subscriber_Report B ON A.ACCOUNT_NUMBER=B.ACCOUNT_NUMBER
AND A.ORDER_DT>=effective_from_dt
AND A.ORDER_DT<=effective_to_dt;

*/
  -- ADD ON WHAT TYPE OF CALL THE ORDER CAME IN ON
  drop table if exists #DTV_CONTACT_TYPE;
  select distinct A.ACCOUNT_NUMBER,
    A.ORDER_DT,
    A.ORDER_COMMUNICATION_TYPE,
    MIN(
    case when C.ACCOUNT_NUMBER is not null then '1.TA'
    when D.ACCOUNT_NUMBER is not null then '2.PAT'
    when SUBSTRING(B.contact_channel,1,1) = 'I' then '3.INBOUND '+A.ORDER_COMMUNICATION_TYPE
    when SUBSTRING(B.contact_channel,1,1) = 'O' then '4.OUTBOUND '+A.ORDER_COMMUNICATION_TYPE
    else '5. '+A.ORDER_COMMUNICATION_TYPE
    end) as CONTACT_TYPE into #DTV_CONTACT_TYPE
    from #DTV as A
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
  --UPDATE BROADBAND TABLE
  update #DTV as A
    set A.CONTACT_TYPE = B.CONTACT_TYPE from
    #DTV_CONTACT_TYPE as B
    where A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT = B.ORDER_DT;
  ---------------------------------------------------------------------------------------------------------------------
  --ADD ON OFFER STATUS FOR ACCOUNTS
  ---------------------------------------------------------------------------------------------------------------------
  drop table if exists #DTV_OFFER_STATUS;
  select distinct D.ACCOUNT_NUMBER,
    D.ORDER_DT,
    case when D.ACTUAL_OFFER_STATUS = 2 then 'Offer End'
    when D.ACTUAL_OFFER_STATUS = 1 then 'On Offer'
    else 'No Offer'
    end as ACTUAL_OFFER_STATUS,
    case when D.INTENDED_OFFER_STATUS = 2 then 'Offer End'
    when D.INTENDED_OFFER_STATUS = 1 then 'On Offer'
    else 'No Offer'
    end as INTENDED_OFFER_STATUS into #DTV_OFFER_STATUS
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
        from #DTV as A
          left outer join Decisioning.offers_software as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
          and A.ORDER_DT > B.WHOLE_OFFER_START_DT_ACTUAL
          and A.ORDER_DT-55 <= B.WHOLE_OFFER_END_DT_ACTUAL
          and lower(B.OFFER_DIM_DESCRIPTION) not like '%price protect%'
          left outer join Decisioning.offers_software as C on A.ACCOUNT_NUMBER = C.ACCOUNT_NUMBER
          and A.ORDER_DT > C.Whole_Offer_Intended_Start_Dt
          and A.ORDER_DT-55 <= C.Whole_Offer_Intended_Start_Dt
          and lower(B.OFFER_DIM_DESCRIPTION) not like '%price protect%'
        group by A.ACCOUNT_NUMBER,
        A.ORDER_DT) as D;
  -- UPDATE TABLE
  update #DTV as A
    set A.ACTUAL_OFFER_STATUS = B.ACTUAL_OFFER_STATUS,
    A.INTENDED_OFFER_STATUS = B.INTENDED_OFFER_STATUS from
    #DTV_OFFER_STATUS as B
    where A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT = B.ORDER_DT;
  -- ADD FLAG IF ORDER CAME WITH ANY OFFER
  -- MMC Correct logic for Offer flags using data provided by proc
  update #DTV as A
    set A.ANY_OFFER_FLAG
     = case when Offers_Applied_Lst_1D_Any > 0 then 1
    else 0
    end;
  update #DTV as A
    set A.TV_OFFER_FLAG
     = case when Offers_Applied_Lst_1D_DTV > 0
    or Offers_Applied_Lst_1D_MS > 0
    or Offers_Applied_Lst_1D_SGE > 0
    or Offers_Applied_Lst_1D_HD > 0
    or Offers_Applied_Lst_1D_TopTier > 0
    or Offers_Applied_Lst_1D_Sports > 0
    or Offers_Applied_Lst_1D_Movies > 0 then 1
    else 0
    end;
  update #DTV as A
    set A.BB_OFFER
     = case when Offers_Applied_Lst_1D_BB > 0 then 1
    else 0
    end;
  update #DTV as A
    set A.COMMS_OFFER_FLAG
     = case when Offers_Applied_Lst_1D_BB > 0
    or Offers_Applied_Lst_1D_LR > 0
    or Offers_Applied_Lst_1D_Talk > 0 then 1
    else 0
    end;
  -- ADD OFFER DATA TO BUNDLE DATA
  drop table if exists #DTV2;
  select distinct A.*,
    case when Offers_Applied_Lst_1D_DTV > 0 then 1
    else 0
    end as DTV_PRIMARY_VIEWING_OFFER,
    B.SUBS_TYPE as DTV_OFFER_SUB_TYPE,
    B.OFFER_ID as DTV_OFFER_ID,
    B.OFFER_DIM_DESCRIPTION as DTV_OFFER_DESCRIPTION,
    B.OFFER_VALUE as DTV_MONTHLY_OFFER_VALUE,
    DATEDIFF(month,B.INTENDED_OFFER_START_DT,B.INTENDED_OFFER_END_DT) as DTV_OFFER_DURATION_MTH,
    DATEDIFF(month,B.INTENDED_OFFER_START_DT,B.INTENDED_OFFER_END_DT)*B.OFFER_VALUE as DTV_TOTAL_OFFER_VALUE,
    case when B.ORIG_PORTFOLIO_OFFER_ID <> '?' then 1
    else 0
    end as DTV_AUTO_TRANSFER_OFFER, --,CASE WHEN B.SUBS_TYPE IS NOT NULL THEN 1 ELSE 0 END AS BB_OFFER
    B.SUBS_TYPE as BB_OFFER_SUB_TYPE,
    B.OFFER_ID as BB_OFFER_ID,
    B.OFFER_DIM_DESCRIPTION as BB_OFFER_DESCRIPTION,
    B.OFFER_VALUE as BB_MONTHLY_OFFER_VALUE,
    DATEDIFF(month,B.INTENDED_OFFER_START_DT,B.INTENDED_OFFER_END_DT) as BB_OFFER_DURATION_MTH,
    DATEDIFF(month,B.INTENDED_OFFER_START_DT,B.INTENDED_OFFER_END_DT)*B.OFFER_VALUE as BB_TOTAL_OFFER_VALUE,
    case when B.ORIG_PORTFOLIO_OFFER_ID <> '?' then 1
    else 0
    end as BB_AUTO_TRANSFER_OFFER into #DTV2
    from #DTV as A
      left outer join(select C.*
        from CITeam.ECON_OFFERS as C
          join(select ACCOUNT_NUMBER,
            CREATED_DT,
            MAX(INTENDED_OFFER_END_DT-INTENDED_OFFER_START_DT) as OFFER_DURATION
            from CITeam.ECON_OFFERS
            group by ACCOUNT_NUMBER,
            CREATED_DT) as D on C.ACCOUNT_NUMBER = D.ACCOUNT_NUMBER
          and C.CREATED_DT = D.CREATED_DT
          and(C.INTENDED_OFFER_END_DT-C.INTENDED_OFFER_START_DT) = D.OFFER_DURATION) as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and A.ORDER_DT = B.CREATED_DT
      and B.SUBS_TYPE = 'DTV Primary Viewing'
      and B.OFFER_SEGMENT_GROUPED_1 <> 'Price Protection'
      and B.OFFER_VALUE < 0
      left outer join(select C.*
        from CITeam.ECON_OFFERS as C
          join(select ACCOUNT_NUMBER,
            CREATED_DT,
            MAX(INTENDED_OFFER_END_DT-INTENDED_OFFER_START_DT) as OFFER_DURATION
            from CITeam.ECON_OFFERS
            group by ACCOUNT_NUMBER,
            CREATED_DT) as D on C.ACCOUNT_NUMBER = D.ACCOUNT_NUMBER
          and C.CREATED_DT = D.CREATED_DT
          and(C.INTENDED_OFFER_END_DT-C.INTENDED_OFFER_START_DT) = D.OFFER_DURATION) as CC on A.ACCOUNT_NUMBER = CC.ACCOUNT_NUMBER
      and A.ORDER_DT = CC.CREATED_DT
      and CC.SUBS_TYPE = 'Broadband DSL Line'
      and CC.OFFER_SEGMENT_GROUPED_1 <> 'Price Protection'
      and CC.OFFER_VALUE < 0;
  -- ADD ON CUSTOMER DATA AND WEEK DATA AND OUTPUT
  drop table if exists #ECONOMETRICS_DTV;
  --INSERT INTO #ECONOMETRICS_DTV
  select distinct A.ACCOUNT_NUMBER,
    A.CURRENCY_CODE,
    A.CUSTOMER_SK,
    A.ORDER_ID,
    A.SUBSCRIPTION_ID,
    A.ORDER_NUMBER,
    A.ORDER_DT,
    A.RTM_LEVEL_1,
    A.RTM_LEVEL_2,
    A.RTM_LEVEL_3,
    A.ORDER_COMMUNICATION_TYPE,
    A.ORDER_SALE_TYPE,
    A.CHANGE_TYPE,
    A.DTV_CHANGE,
    A.ORDER_CHANGE_COMPLETED,
    A.PREVIOUS_DTV,
    A.PREVIOUS_DTV_1_YEAR,
    A.PREVIOUS_BB,
    A.ORDER_BECAME_ACTIVE,
    A.ACCOUNT_ACTIVE_LENGTH,
    A.BB_BEFORE_ORDER,
    A.BB_AFTER_ORDER,
    A.SPORTS_ADDED,
    A.MOVIES_ADDED,
    A.LEGACY_SPORTS_SUB_ADDED,
    A.LEGACY_MOVIES_SUB_ADDED,
    A.LEGACY_SPORTS_ADDED,
    A.LEGACY_MOVIES_ADDED,
    A.SPORTS_PACK_SUB_ADDED,
    A.SPORTS_PACK_ADDED,
    A.FAMILY_ADDED,
    A.VARIETY_ADDED,
    A.ORIGINAL_ADDED,
    A.SKYQ_ADDED,
    case when A.HD_LEGACY_ADDED > 1 then 1 else A.HD_LEGACY_ADDED end as HD_LEGACY_ADDED,
    case when A.HD_BASIC_ADDED > 1 then 1 else A.HD_BASIC_ADDED end as HD_BASIC_ADDED,
    case when A.HD_PREMIUM_ADDED > 1 then 1 else A.HD_PREMIUM_ADDED end as HD_PREMIUM_ADDED,
    case when A.MULTISCREEN_ADDED > 1 then 1 else A.MULTISCREEN_ADDED end as MULTISCREEN_ADDED,
    case when A.MULTISCREEN_PLUS_ADDED > 1 then 1 else A.MULTISCREEN_PLUS_ADDED end as MULTISCREEN_PLUS_ADDED,
    case when A.MULTISCREEN_ADDED > 0 then 'CLASSIC_MULTISCREEN' when A.MULTISCREEN_PLUS_ADDED > 0 then 'QMS' end as MS_ADDED_PRODUCT,
    case when A.SKY_PLUS_ADDED > 1 then 1 else A.SKY_PLUS_ADDED end as SKY_PLUS_ADDED,
    case when A.SKY_GO_EXTRA_ADDED > 1 then 1 else A.SKY_GO_EXTRA_ADDED end as SKY_GO_EXTRA_ADDED,
    case when A.NOW_TV_ADDED > 1 then 1 else A.NOW_TV_ADDED end as NOW_TV_ADDED,
    case when A.BB_ADDED > 1 then 1 else A.BB_ADDED end as BB_ADDED,
    A.BB_ADDED_PRODUCT,
    A.TALKU_ADDED,
    A.TALKW_ADDED,
    A.TALKF_ADDED,
    A.TALKA_ADDED,
    A.TALKP_ADDED,
    A.TALKO_ADDED,
    --CASE WHEN (A.TALKU_ADDED + A.TALKW_ADDED + A.TALKF_ADDED + A.TALKA_ADDED + A.TALKP_ADDED +A.TALKO_ADDED)>1 THEN 1 ELSE 0 END as TALK_ADDED,
    case when TALKU_ADDED > 0 then 'TALK UNLIMITED' when TALKW_ADDED > 0 then 'TALK WEEKEND' when TALKF_ADDED > 0 then 'TALKF FREETIME' when TALKA_ADDED > 0 then 'TALKA ANYTIME'
    when TALKP_ADDED > 0 then 'TALK PAY AS YOU GO' when TALKO_ADDED > 0 then 'TALK OFF PEAK' else null end as TALK_ADDED,
    A.SPORTS_REMOVED,
    A.MOVIES_REMOVED,
    A.LEGACY_SPORTS_SUB_REMOVED,
    A.LEGACY_MOVIES_SUB_REMOVED,
    A.LEGACY_SPORTS_REMOVED,
    A.LEGACY_MOVIES_REMOVED,
    A.SPORTS_PACK_SUB_REMOVED,
    A.SPORTS_PACK_REMOVED,
    A.FAMILY_REMOVED,
    A.VARIETY_REMOVED,
    A.ORIGINAL_REMOVED,
    A.SKYQ_REMOVED,
    case when A.HD_LEGACY_REMOVED > 1 then 1 else A.HD_LEGACY_REMOVED end as HD_LEGACY_REMOVED,
    case when A.HD_BASIC_REMOVED > 1 then 1 else A.HD_BASIC_REMOVED end as HD_BASIC_REMOVED,
    case when A.HD_PREMIUM_REMOVED > 1 then 1 else A.HD_PREMIUM_REMOVED end as HD_PREMIUM_REMOVED,
    case when A.MULTISCREEN_REMOVED > 1 then 1 else A.MULTISCREEN_REMOVED end as MULTISCREEN_REMOVED,
    case when A.MULTISCREEN_PLUS_REMOVED > 1 then 1 else A.MULTISCREEN_PLUS_REMOVED end as MULTISCREEN_PLUS_REMOVED,
    case when A.MULTISCREEN_REMOVED > 0 then 'CLASSIC_MULTISCREEN' when A.MULTISCREEN_PLUS_REMOVED > 0 then 'QMS' end as MS_REMOVED_PRODUCT,
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
    --CASE WHEN (A.TALKU_REMOVED + A.TALKW_REMOVED + A.TALKF_REMOVED + A.TALKA_REMOVED + A.TALKP_REMOVED +A.TALKO_REMOVED)>1 THEN 1 ELSE 0 END as TALK_REMOVED,
    case when TALKU_REMOVED > 0 then 'TALK UNLIMITED' when TALKW_REMOVED > 0 then 'TALK WEEKEND' when TALKF_REMOVED > 0 then 'TALKF FREETIME' when TALKA_REMOVED > 0 then 'TALKA ANYTIME'
    when TALKP_REMOVED > 0 then 'TALK PAY AS YOU GO' when TALKO_REMOVED > 0 then 'TALK OFF PEAK' else null end as TALK_REMOVED,
    A.CONTACT_TYPE,
    cast('Out of Contract' as varchar(30)) as CONTRACT_STATUS,
    A.ACTUAL_OFFER_STATUS,
    A.INTENDED_OFFER_STATUS,
    A.ANY_OFFER_FLAG,
    A.DTV_PRIMARY_VIEWING_OFFER,
    A.DTV_OFFER_SUB_TYPE,
    A.DTV_OFFER_ID,
    A.DTV_OFFER_DESCRIPTION,
    A.DTV_MONTHLY_OFFER_VALUE,
    A.DTV_OFFER_DURATION_MTH,
    A.DTV_TOTAL_OFFER_VALUE,
    A.DTV_AUTO_TRANSFER_OFFER,
    A.BB_OFFER,
    A.BB_OFFER_SUB_TYPE,
    A.BB_OFFER_ID,
    A.BB_OFFER_DESCRIPTION,
    A.BB_MONTHLY_OFFER_VALUE,
    A.BB_OFFER_DURATION_MTH,
    A.BB_TOTAL_OFFER_VALUE,
    A.BB_AUTO_TRANSFER_OFFER,
    cast(null as integer) as TENURE,
    cast(null as varchar(45)) as SIMPLE_SEGMENT,
    cast(null as varchar(45)) as TV_REGION,
    cast(null as varchar(45)) as mosaic_uk_group,
    right(cast(C.subs_year as varchar),2) || '/' || right(cast(C.subs_year+1 as varchar),2) || '-'
     || case when C.subs_week_of_year < 10 then '0' || cast(C.subs_week_of_year as varchar)
    else cast(C.subs_week_of_year as varchar)
    end as year_week,
    A.ORDER_DT as WEEK_START,
    A.TV_OFFER_FLAG,
    A.COMMS_OFFER_FLAG,
    case when A.SPORTS_COMPLETE_ADDED > 1 then 1 else A.SPORTS_COMPLETE_ADDED end as SPORTS_COMPLETE_ADDED,
    case when A.SPORTS_COMPLETE_REMOVED > 1 then 1 else A.SPORTS_COMPLETE_REMOVED end as SPORTS_COMPLETE_REMOVED,
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
    CINEMA_ADD_ON_ADDED,
    -- CINEMA_CONTRACT_ADDED ,
    --CINEMA_CONTRACT_REMOVED ,
    CINEMA_ADD_ON_REMOVED,
    A.Offer_End_Status_Level_1,
    A.Offer_End_Status_Level_2,
    A.ANY_NEW_OFFER_FLAG,
    A.NEW_DTV_PRIMARY_VIEWING_OFFER,
    cast(0 as tinyint) as Asia_Pack_Active,
    cast(0 as tinyint) as MuTV_Pack_Active,
    cast(0 as tinyint) as LTV_Pack_Active,
    cast(0 as tinyint) as CTV_Pack_Active,
    case when A.KIDS_ADDED > 1 then 1 else A.KIDS_ADDED end as KIDS_ADDED,
    case when A.KIDS_REMOVED > 1 then 1 else A.KIDS_REMOVED end as KIDS_REMOVED,
    case when A.BOXSETS_ADDED > 1 then 1 else A.BOXSETS_ADDED end as BOXSETS_ADDED,
    case when A.BOXSETS_REMOVED > 1 then 1 else A.BOXSETS_REMOVED end as BOXSETS_REMOVED,
    SPOTIFY_ADDED,
    SPOTIFY_REMOVED,
    UOD_ADDED,
    UOD_REMOVED,
    case when A.Netflix_Standard_Added > 0 then 'Netflix_Standard' when A.Netflix_Premium_Added > 0 then 'Netflix_Premium' else '' end as Netflix_Added_Product,
    case when A.Netflix_Standard_Removed > 0 then 'Netflix_Standard' when A.Netflix_Premium_Removed > 0 then 'Netflix_Premium' else '' end as Netflix_Removed_Product,
    DTV_ADDED_PRODUCT,
    DTV_REMOVED_PRODUCT,
    DTV_Status,
    ACTIVE_DTV_BEFORE_ORDER,
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
    into #ECONOMETRICS_DTV
    from #DTV2 as A
      left outer join sky_calendar as C on A.ORDER_DT = C.CALENDAR_DATE;
  select right(cast(subs_year as varchar),2) || '/' || right(cast(subs_year+1 as varchar),2) || '-'
     || case when subs_week_of_year < 10 then '0' || cast(subs_week_of_year as varchar)
    else cast(subs_week_of_year as varchar)
    end as year_week,
    min(calendar_date) as week_start into #weeks
    from sky_calendar as cal
    group by year_week;
  update #ECONOMETRICS_DTV as a
    set a.week_start = b.week_start from
    #weeks as b
    where a.year_week = b.year_week;
  -------------------Update Tenure and TV Region
  update #ECONOMETRICS_DTV as A
    set A.TV_Region = B.tv_region,
    A.TENURE = case when DATEDIFF(month,B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT,A.WEEK_START) < 0 then 0 else DATEDIFF(month,B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT,A.WEEK_START) end from
    /* CASE
WHEN DATEDIFF(DAY, B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT, A.WEEK_START) <= 122 THEN 'A) 0-4 MONTHS'
WHEN DATEDIFF(DAY, B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT, A.WEEK_START) <= 274 THEN 'B) 5-9 MONTHS'
WHEN DATEDIFF(DAY, B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT, A.WEEK_START) <= 395 THEN 'C) 10-13 MONTHS'
WHEN DATEDIFF(DAY, B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT, A.WEEK_START) <= 730 THEN 'D) 14-24 MONTHS'
WHEN DATEDIFF(DAY, B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT, A.WEEK_START) <= 1095 THEN 'E) 2-3 YEARS'
WHEN DATEDIFF(DAY, B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT, A.WEEK_START) <= 1825 THEN 'F) 3-5 YEARS'
WHEN DATEDIFF(DAY, B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT, A.WEEK_START) <= 3650 THEN 'G) 5-10 YEARS'
WHEN DATEDIFF(DAY, B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT, A.WEEK_START) > 3650 THEN 'H) 10 YEARS+'
ELSE 'UNKNOWN'
END*/
    #ECONOMETRICS_DTV as A
    join CITeam.Account_TV_Region as B on A.account_number = B.account_number;
  -----------------------------Update contract status-
  update #ECONOMETRICS_DTV as A
    set A.CONTRACT_STATUS
     = case when D.CONTRACT_STATUS is not null then D.CONTRACT_STATUS
    when D.CONTRACT_STATUS = 'Out Of Contract' then 'Out Of Contract'
    else 'Out Of Contract'
    end from
    #ECONOMETRICS_DTV as A
    left outer join CITEAM.DM_CONTRACTS as D on A.ACCOUNT_NUMBER = D.ACCOUNT_NUMBER
    and order_dt = D.start_date;
  ------------------Update LTV, MuTV, CTV,Asia Pack Flags--------------Added by AP
  update #ECONOMETRICS_DTV as A
    set A.Asia_Pack_Active
     = case when B.SkyAsia_Active_Subscription = 1 then 1
    else 0
    end from
    #ECONOMETRICS_DTV as A
    left outer join CITeam.Active_Subscriber_Report as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT-1 >= B.effective_from_dt
    and A.ORDER_DT-1 < B.effective_to_dt
    and A.SUBSCRIPTION_ID = B.SUBSCRIPTION_ID;
  update #ECONOMETRICS_DTV as A
    set A.MuTV_Pack_Active
     = case when B.MUTV_Active_Subscription = 1 then 1
    else 0
    end from
    #ECONOMETRICS_DTV as A
    left outer join CITeam.Active_Subscriber_Report as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT-1 >= B.effective_from_dt
    and A.ORDER_DT-1 < B.effective_to_dt
    and A.SUBSCRIPTION_ID = B.SUBSCRIPTION_ID;
  update #ECONOMETRICS_DTV as A
    set A.LTV_Pack_Active
     = case when B.Liverpool_Active_Subscription = 1 then 1
    else 0
    end from
    #ECONOMETRICS_DTV as A
    left outer join CITeam.Active_Subscriber_Report as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT-1 >= B.effective_from_dt
    and A.ORDER_DT-1 < B.effective_to_dt
    and A.SUBSCRIPTION_ID = B.SUBSCRIPTION_ID;
  update #ECONOMETRICS_DTV as A
    set A.CTV_Pack_Active
     = case when B.Chelsea_TV_Active_Subscription = 1 then 1
    else 0
    end from
    #ECONOMETRICS_DTV as A
    left outer join CITeam.Active_Subscriber_Report as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT-1 >= B.effective_from_dt
    and A.ORDER_DT-1 < B.effective_to_dt
    and A.SUBSCRIPTION_ID = B.SUBSCRIPTION_ID;
  --------------------------------------------------------------------------------------------------
  ---------Contract Flags Update-------
  --------------------------------------------------------------------------------------------------
  update #ECONOMETRICS_DTV as dtv
    set dtv.Basic_contract_status_pre_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    dtv.Basic_contract_subscription_item_pre_order = ctr.Agreement_Item_Type from
    #ECONOMETRICS_DTV as dtv
    left outer join CITEAM.DM_Contracts as ctr
    on dtv.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and dtv.order_dt-1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Primary DTV' ) ;
  update #ECONOMETRICS_DTV as dtv
    set dtv.Add_on_contract_status_pre_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    dtv.Add_on_contract_subscription_item_pre_order = ctr.Agreement_Item_Type from
    #ECONOMETRICS_DTV as dtv
    left outer join CITEAM.DM_Contracts as ctr
    on dtv.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and dtv.order_dt-1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Secondary DTV','Sky Enhanced Cap Subs' ) ;
  update #ECONOMETRICS_DTV as dtv
    set dtv.Talk_contract_status_pre_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    dtv.Talk_contract_subscription_item_pre_order = ctr.Agreement_Item_Type from
    #ECONOMETRICS_DTV as dtv
    left outer join CITEAM.DM_Contracts as ctr
    on dtv.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and dtv.order_dt-1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Sky Talk' ) ;
  update #ECONOMETRICS_DTV as dtv
    set dtv.BB_contract_status_pre_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    dtv.BB_contract_subscription_item_pre_order = ctr.Agreement_Item_Type from
    #ECONOMETRICS_DTV as dtv
    left outer join CITEAM.DM_Contracts as ctr
    on dtv.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and dtv.order_dt-1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Broadband' ) ;
  ---
  update #ECONOMETRICS_DTV as A
    set A.Basic_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.Basic_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #ECONOMETRICS_DTV as A
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
  update #ECONOMETRICS_DTV as A
    set A.Basic_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.Basic_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #ECONOMETRICS_DTV as A
    left outer join CITeam.Orders_Detail as C on A.Account_Number = C.Account_Number and A.Order_Dt = C.Order_Dt
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
  update #ECONOMETRICS_DTV as dtv
    set dtv.Basic_contract_status_post_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    dtv.Basic_contract_subscription_item_post_order = ctr.Agreement_Item_Type from
    #ECONOMETRICS_DTV as dtv
    left outer join CITEAM.DM_Contracts as ctr
    on dtv.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and dtv.order_dt+1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and ctr.subscription_type in( 'Primary DTV' ) and dtv.Basic_contract_status_post_order <> 1;
  ---
  update #ECONOMETRICS_DTV as A
    set A.BB_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.BB_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #ECONOMETRICS_DTV as A
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
  update #ECONOMETRICS_DTV as A
    set A.BB_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.BB_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #ECONOMETRICS_DTV as A
    left outer join CITeam.Orders_Detail as C on A.Account_Number = C.Account_Number and A.Order_Dt = C.Order_Dt
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
  update #ECONOMETRICS_DTV as dtv
    set dtv.BB_contract_status_post_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    dtv.BB_contract_subscription_item_post_order = ctr.Agreement_Item_Type from
    #ECONOMETRICS_DTV as dtv
    left outer join CITEAM.DM_Contracts as ctr
    on dtv.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and dtv.order_dt+1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and ctr.subscription_type in( 'Broadband' ) and dtv.BB_contract_status_post_order <> 1;
  --
  update #ECONOMETRICS_DTV as A
    set A.Talk_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.Talk_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #ECONOMETRICS_DTV as A
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
  update #ECONOMETRICS_DTV as A
    set A.Talk_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.Talk_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #ECONOMETRICS_DTV as A
    left outer join CITeam.Orders_Detail as C on A.Account_Number = C.Account_Number and A.Order_Dt = C.Order_Dt
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
  update #ECONOMETRICS_DTV as dtv
    set dtv.Talk_contract_status_post_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    dtv.Talk_contract_subscription_item_post_order = ctr.Agreement_Item_Type from
    #ECONOMETRICS_DTV as dtv
    left outer join CITEAM.DM_Contracts as ctr
    on dtv.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and dtv.order_dt+1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Sky Talk' ) and dtv.Talk_contract_status_post_order <> 1;
  ---
  update #ECONOMETRICS_DTV as A
    set A.Add_on_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.Add_on_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #ECONOMETRICS_DTV as A
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
    where(A.SPORTS_ADDED+A.MOVIES_ADDED+A.KIDS_ADDED+A.BOXSETS_ADDED+A.SKYQ_ADDED+A.HD_LEGACY_ADDED+A.HD_BASIC_ADDED+A.HD_PREMIUM_ADDED+A.MULTISCREEN_ADDED+A.MULTISCREEN_PLUS_ADDED+A.SKY_PLUS_ADDED+A.SKY_GO_EXTRA_ADDED+A.SPOTIFY_ADDED) >= 1 and D.CONTRACT_STATUS in( 'In Contract' ) ;
  update #ECONOMETRICS_DTV as A
    set A.Add_on_contract_status_post_order
     = case when D.CONTRACT_STATUS in( 'In Contract' ) then 1
    else 0
    end,
    A.Add_on_contract_subscription_item_post_order = case when D.CONTRACT_STATUS in( 'In Contract' ) then D.Agreement_Item_Type else null end from
    #ECONOMETRICS_DTV as A
    left outer join CITeam.Orders_Detail as C on A.Account_Number = C.Account_Number and A.Order_Dt = C.Order_Dt
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
    where(A.SPORTS_ADDED+A.MOVIES_ADDED+A.KIDS_ADDED+A.BOXSETS_ADDED+A.SKYQ_ADDED+A.HD_LEGACY_ADDED+A.HD_BASIC_ADDED+A.HD_PREMIUM_ADDED+A.MULTISCREEN_ADDED+A.MULTISCREEN_PLUS_ADDED+A.SKY_PLUS_ADDED+A.SKY_GO_EXTRA_ADDED+A.SPOTIFY_ADDED) >= 1 and D.CONTRACT_STATUS in( 'In Contract' ) and A.Add_on_contract_status_post_order <> 1;
  update #ECONOMETRICS_DTV as dtv
    set dtv.Add_on_contract_status_post_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    dtv.Add_on_contract_subscription_item_post_order = ctr.Agreement_Item_Type from
    #ECONOMETRICS_DTV as dtv
    left outer join CITEAM.DM_Contracts as ctr
    on dtv.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and dtv.order_dt+1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Secondary DTV','Sky Enhanced Cap Subs' ) and dtv.Add_on_contract_status_post_order <> 1;
  ------------------------------------------------------------------------------
  ------------------------------------------------
  --Account level table
  ---------------------------------------------
  delete from Decisioning.ECONOMETRICS_DTV_ACQUISITIONS_ORDERS_ACCOUNT_LEVEL
    where WEEK_START >= Refresh_Dt;
  insert into Decisioning.ECONOMETRICS_DTV_ACQUISITIONS_ORDERS_ACCOUNT_LEVEL
    select ACCOUNT_NUMBER,
      CURRENCY_CODE,
      CUSTOMER_SK,
      ORDER_ID,
      SUBSCRIPTION_ID,
      ORDER_NUMBER,
      ORDER_DT,
      RTM_LEVEL_1,
      RTM_LEVEL_2,
      RTM_LEVEL_3,
      ORDER_COMMUNICATION_TYPE,
      ORDER_SALE_TYPE,
      CHANGE_TYPE,
      DTV_CHANGE,
      ORDER_CHANGE_COMPLETED,
      PREVIOUS_DTV,
      PREVIOUS_DTV_1_YEAR,
      PREVIOUS_BB,
      ORDER_BECAME_ACTIVE,
      ACCOUNT_ACTIVE_LENGTH,
      BB_BEFORE_ORDER,
      BB_AFTER_ORDER,
      SPORTS_ADDED,
      MOVIES_ADDED,
      LEGACY_SPORTS_SUB_ADDED,
      LEGACY_MOVIES_SUB_ADDED,
      LEGACY_SPORTS_ADDED,
      LEGACY_MOVIES_ADDED,
      SPORTS_PACK_SUB_ADDED,
      SPORTS_PACK_ADDED,
      FAMILY_ADDED,
      VARIETY_ADDED,
      ORIGINAL_ADDED,
      SKYQ_ADDED,
      HD_LEGACY_ADDED,
      HD_BASIC_ADDED,
      HD_PREMIUM_ADDED,
      MULTISCREEN_ADDED,
      MULTISCREEN_PLUS_ADDED,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      BB_ADDED,
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
      LEGACY_SPORTS_SUB_REMOVED,
      LEGACY_MOVIES_SUB_REMOVED,
      LEGACY_SPORTS_REMOVED,
      LEGACY_MOVIES_REMOVED,
      SPORTS_PACK_SUB_REMOVED,
      SPORTS_PACK_REMOVED,
      FAMILY_REMOVED,
      VARIETY_REMOVED,
      ORIGINAL_REMOVED,
      SKYQ_REMOVED,
      HD_LEGACY_REMOVED,
      HD_BASIC_REMOVED,
      HD_PREMIUM_REMOVED,
      MULTISCREEN_REMOVED,
      MULTISCREEN_PLUS_REMOVED,
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
      CONTACT_TYPE,
      CONTRACT_STATUS,
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      ANY_OFFER_FLAG,
      DTV_PRIMARY_VIEWING_OFFER,
      DTV_OFFER_SUB_TYPE,
      DTV_OFFER_ID,
      DTV_OFFER_DESCRIPTION,
      DTV_MONTHLY_OFFER_VALUE,
      DTV_OFFER_DURATION_MTH,
      DTV_TOTAL_OFFER_VALUE,
      DTV_AUTO_TRANSFER_OFFER,
      BB_OFFER,
      BB_OFFER_SUB_TYPE,
      BB_OFFER_ID,
      BB_OFFER_DESCRIPTION,
      BB_MONTHLY_OFFER_VALUE,
      BB_OFFER_DURATION_MTH,
      BB_TOTAL_OFFER_VALUE,
      BB_AUTO_TRANSFER_OFFER,
      TENURE,
      SIMPLE_SEGMENT,
      TV_REGION,
      mosaic_uk_group,
      year_week,
      WEEK_START,
      TV_OFFER_FLAG,
      COMMS_OFFER_FLAG,
      SPORTS_COMPLETE_ADDED,
      SPORTS_COMPLETE_REMOVED,
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
      CINEMA_ADD_ON_ADDED,
      CINEMA_ADD_ON_REMOVED,
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      ANY_NEW_OFFER_FLAG,
      NEW_DTV_PRIMARY_VIEWING_OFFER,
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
      UOD_ADDED,
      UOD_REMOVED,
      Netflix_Added_Product,
      Netflix_Removed_Product,
      DTV_ADDED_PRODUCT,
      DTV_REMOVED_PRODUCT,
      DTV_Status,
      ACTIVE_DTV_BEFORE_ORDER,
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
      from #ECONOMETRICS_DTV;
  ------------------------------------------------
  --SUMMARIZE DATA
  ---------------------------------------------
  delete from Decisioning.ECONOMETRICS_DTV_ACQUISITIONS_ORDERS
    where WEEK_START >= Refresh_Dt;
  commit work;
  insert into Decisioning.ECONOMETRICS_DTV_ACQUISITIONS_ORDERS
    select YEAR_WEEK,
      WEEK_START,
      CURRENCY_CODE,
      RTM_LEVEL_1,
      RTM_LEVEL_2,
      RTM_LEVEL_3,
      ORDER_COMMUNICATION_TYPE,
      ORDER_SALE_TYPE,
      CONTACT_TYPE,
      -- CONTRACT_STATUS ,
      CHANGE_TYPE,
      DTV_CHANGE,
      ORDER_CHANGE_COMPLETED,
      PREVIOUS_DTV,
      PREVIOUS_DTV_1_YEAR,
      PREVIOUS_BB,
      ORDER_BECAME_ACTIVE,
      ACCOUNT_ACTIVE_LENGTH,
      BB_BEFORE_ORDER,
      BB_AFTER_ORDER,
      SPORTS_ADDED,
      MOVIES_ADDED,
      LEGACY_SPORTS_SUB_ADDED,
      LEGACY_MOVIES_SUB_ADDED,
      -- LEGACY_SPORTS_ADDED ,
      --LEGACY_MOVIES_ADDED ,
      SPORTS_PACK_SUB_ADDED,
      SPORTS_PACK_ADDED,
      -- FAMILY_ADDED ,
      -- VARIETY_ADDED ,
      -- ORIGINAL_ADDED ,
      -- SKYQ_ADDED ,
      HD_LEGACY_ADDED,
      HD_BASIC_ADDED,
      HD_PREMIUM_ADDED,
      --MULTISCREEN_ADDED ,
      --MULTISCREEN_PLUS_ADDED ,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      BB_ADDED,
      BB_ADDED_PRODUCT,
      /*       TALKU_ADDED ,
TALKW_ADDED ,
TALKF_ADDED ,
TALKA_ADDED ,
TALKP_ADDED ,
TALKO_ADDED ,
*/
      TALK_ADDED,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      LEGACY_SPORTS_SUB_REMOVED,
      LEGACY_MOVIES_SUB_REMOVED,
      --LEGACY_SPORTS_REMOVED ,
      --LEGACY_MOVIES_REMOVED ,
      SPORTS_PACK_SUB_REMOVED,
      SPORTS_PACK_REMOVED,
      --FAMILY_REMOVED ,
      --VARIETY_REMOVED ,
      --ORIGINAL_REMOVED ,
      --SKYQ_REMOVED ,
      HD_LEGACY_REMOVED,
      HD_BASIC_REMOVED,
      HD_PREMIUM_REMOVED,
      -- MULTISCREEN_REMOVED ,
      --MULTISCREEN_PLUS_REMOVED ,
      MS_REMOVED_PRODUCT,
      SKY_PLUS_REMOVED,
      SKY_GO_EXTRA_REMOVED,
      NOW_TV_REMOVED,
      BB_REMOVED_PRODUCT,
      -- TALKU_REMOVED ,
      -- TALKW_REMOVED ,
      -- TALKF_REMOVED ,
      -- TALKA_REMOVED ,
      -- TALKP_REMOVED ,
      -- TALKO_REMOVED ,
      TALK_REMOVED,
      --        ACTUAL_OFFER_STATUS ,
      --        INTENDED_OFFER_STATUS ,
      ANY_OFFER_FLAG,
      -- DTV_PRIMARY_VIEWING_OFFER ,
      --DTV_OFFER_SUB_TYPE ,
      --DTV_OFFER_ID ,
      --DTV_OFFER_DESCRIPTION ,
      --DTV_MONTHLY_OFFER_VALUE ,
      --DTV_OFFER_DURATION_MTH ,
      --DTV_TOTAL_OFFER_VALUE ,
      --DTV_AUTO_TRANSFER_OFFER ,
      --BB_OFFER ,
      --BB_OFFER_SUB_TYPE ,
      --BB_OFFER_ID ,
      --BB_OFFER_DESCRIPTION ,
      --BB_MONTHLY_OFFER_VALUE ,
      --BB_OFFER_DURATION_MTH ,
      --BB_TOTAL_OFFER_VALUE ,
      --BB_AUTO_TRANSFER_OFFER ,
      TENURE,
      --SIMPLE_SEGMENT ,
      TV_REGION,
      --MOSAIC_UK_GROUP ,
      count() as NUMBER_OF_ORDERS,
      TV_OFFER_FLAG,
      COMMS_OFFER_FLAG,
      SPORTS_COMPLETE_ADDED,
      SPORTS_COMPLETE_REMOVED,
      --SPORTS_CONTRACT_ADDED ,
      --SPORTS_CONTRACT_REMOVED ,
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
      CINEMA_ADD_ON_ADDED,
      --CINEMA_CONTRACT_ADDED ,
      --CINEMA_CONTRACT_REMOVED ,
      CINEMA_ADD_ON_REMOVED,
      --Offer_End_Status_Level_1 ,
      --Offer_End_Status_Level_2 ,
      ANY_NEW_OFFER_FLAG,
      --NEW_DTV_PRIMARY_VIEWING_OFFER  ,
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
      UOD_ADDED,
      UOD_REMOVED,
      Netflix_Added_Product,
      Netflix_Removed_Product,
      DTV_ADDED_PRODUCT,
      DTV_REMOVED_PRODUCT,
      DTV_Status,
      ACTIVE_DTV_BEFORE_ORDER,
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
      from #ECONOMETRICS_DTV
      group by YEAR_WEEK,
      WEEK_START,
      CURRENCY_CODE,
      RTM_LEVEL_1,
      RTM_LEVEL_2,
      RTM_LEVEL_3,
      ORDER_COMMUNICATION_TYPE,
      ORDER_SALE_TYPE,
      CONTACT_TYPE,
      -- CONTRACT_STATUS ,
      CHANGE_TYPE,
      DTV_CHANGE,
      ORDER_CHANGE_COMPLETED,
      PREVIOUS_DTV,
      PREVIOUS_DTV_1_YEAR,
      PREVIOUS_BB,
      ORDER_BECAME_ACTIVE,
      ACCOUNT_ACTIVE_LENGTH,
      BB_BEFORE_ORDER,
      BB_AFTER_ORDER,
      SPORTS_ADDED,
      MOVIES_ADDED,
      LEGACY_SPORTS_SUB_ADDED,
      LEGACY_MOVIES_SUB_ADDED,
      --LEGACY_SPORTS_ADDED ,
      --LEGACY_MOVIES_ADDED ,
      SPORTS_PACK_SUB_ADDED,
      SPORTS_PACK_ADDED,
      --FAMILY_ADDED ,
      --VARIETY_ADDED ,
      --ORIGINAL_ADDED ,
      --SKYQ_ADDED ,
      HD_LEGACY_ADDED,
      HD_BASIC_ADDED,
      HD_PREMIUM_ADDED,
      --MULTISCREEN_ADDED ,
      --MULTISCREEN_PLUS_ADDED ,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      BB_ADDED,
      BB_ADDED_PRODUCT,
      /* TALKU_ADDED ,
TALKW_ADDED ,
TALKF_ADDED ,
TALKA_ADDED ,
TALKP_ADDED ,
TALKO_ADDED ,*/
      TALK_ADDED,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      LEGACY_SPORTS_SUB_REMOVED,
      LEGACY_MOVIES_SUB_REMOVED,
      --LEGACY_SPORTS_REMOVED ,
      --LEGACY_MOVIES_REMOVED ,
      SPORTS_PACK_SUB_REMOVED,
      SPORTS_PACK_REMOVED,
      --FAMILY_REMOVED ,
      --VARIETY_REMOVED ,
      --ORIGINAL_REMOVED ,
      --SKYQ_REMOVED ,
      HD_LEGACY_REMOVED,
      HD_BASIC_REMOVED,
      HD_PREMIUM_REMOVED,
      -- MULTISCREEN_REMOVED ,
      -- MULTISCREEN_PLUS_REMOVED ,
      MS_REMOVED_PRODUCT,
      SKY_PLUS_REMOVED,
      SKY_GO_EXTRA_REMOVED,
      NOW_TV_REMOVED,
      BB_REMOVED_PRODUCT,
      /*   TALKU_REMOVED ,
TALKW_REMOVED ,
TALKF_REMOVED ,
TALKA_REMOVED ,
TALKP_REMOVED ,
TALKO_REMOVED ,*/
      TALK_REMOVED,
      -- ACTUAL_OFFER_STATUS ,
      -- INTENDED_OFFER_STATUS ,
      ANY_OFFER_FLAG,
      --DTV_PRIMARY_VIEWING_OFFER ,
      --DTV_OFFER_SUB_TYPE ,
      --DTV_OFFER_ID ,
      --DTV_OFFER_DESCRIPTION ,
      --DTV_MONTHLY_OFFER_VALUE ,
      --DTV_OFFER_DURATION_MTH ,
      --DTV_TOTAL_OFFER_VALUE ,
      --DTV_AUTO_TRANSFER_OFFER ,
      --BB_OFFER ,
      --BB_OFFER_SUB_TYPE ,
      --BB_OFFER_ID ,
      --BB_OFFER_DESCRIPTION ,
      --BB_MONTHLY_OFFER_VALUE ,
      --BB_OFFER_DURATION_MTH ,
      --BB_TOTAL_OFFER_VALUE ,
      --BB_AUTO_TRANSFER_OFFER ,
      TENURE,
      --SIMPLE_SEGMENT ,
      TV_REGION,
      --MOSAIC_UK_GROUP ,
      TV_OFFER_FLAG,
      COMMS_OFFER_FLAG,
      SPORTS_COMPLETE_ADDED,
      SPORTS_COMPLETE_REMOVED,
      --SPORTS_CONTRACT_ADDED ,
      --SPORTS_CONTRACT_REMOVED ,
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
      CINEMA_ADD_ON_ADDED,
      --CINEMA_CONTRACT_ADDED ,
      --CINEMA_CONTRACT_REMOVED ,
      CINEMA_ADD_ON_REMOVED,
      --Offer_End_Status_Level_1 ,
      --Offer_End_Status_Level_2 ,
      ANY_NEW_OFFER_FLAG,
      --NEW_DTV_PRIMARY_VIEWING_OFFER ,
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
      UOD_ADDED,
      UOD_REMOVED,
      Netflix_Added_Product,
      Netflix_Removed_Product,
      DTV_ADDED_PRODUCT,
      DTV_REMOVED_PRODUCT,
      DTV_Status,
      ACTIVE_DTV_BEFORE_ORDER,
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
  drop table if exists #ECONOMETRICS_DTV_OFFERS_1;
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
    DTV_CHANGE,
    ORDER_CHANGE_COMPLETED,
    PREVIOUS_DTV,
    PREVIOUS_DTV_1_YEAR,
    PREVIOUS_BB,
    ORDER_BECAME_ACTIVE,
    ACCOUNT_ACTIVE_LENGTH,
    BB_BEFORE_ORDER,
    BB_AFTER_ORDER,
    SPORTS_ADDED,
    MOVIES_ADDED,
    LEGACY_SPORTS_SUB_ADDED,
    LEGACY_MOVIES_SUB_ADDED,
    LEGACY_SPORTS_ADDED,
    LEGACY_MOVIES_ADDED,
    SPORTS_PACK_SUB_ADDED,
    SPORTS_PACK_ADDED,
    FAMILY_ADDED,
    VARIETY_ADDED,
    ORIGINAL_ADDED,
    SKYQ_ADDED,
    HD_LEGACY_ADDED,
    HD_BASIC_ADDED,
    HD_PREMIUM_ADDED,
    --MULTISCREEN_ADDED ,
    --MULTISCREEN_PLUS_ADDED ,
    MS_ADDED_PRODUCT,
    SKY_PLUS_ADDED,
    SKY_GO_EXTRA_ADDED,
    NOW_TV_ADDED,
    BB_ADDED,
    BB_ADDED_PRODUCT,
    /*TALKU_ADDED ,
TALKW_ADDED ,
TALKF_ADDED ,
TALKA_ADDED ,
TALKP_ADDED ,
TALKO_ADDED ,*/
    TALK_ADDED,
    SPORTS_REMOVED,
    MOVIES_REMOVED,
    LEGACY_SPORTS_SUB_REMOVED,
    LEGACY_MOVIES_SUB_REMOVED,
    LEGACY_SPORTS_REMOVED,
    LEGACY_MOVIES_REMOVED,
    SPORTS_PACK_SUB_REMOVED,
    SPORTS_PACK_REMOVED,
    FAMILY_REMOVED,
    VARIETY_REMOVED,
    ORIGINAL_REMOVED,
    SKYQ_REMOVED,
    HD_LEGACY_REMOVED,
    HD_BASIC_REMOVED,
    HD_PREMIUM_REMOVED,
    --MULTISCREEN_REMOVED ,
    --MULTISCREEN_PLUS_REMOVED ,
    MS_REMOVED_PRODUCT,
    SKY_PLUS_REMOVED,
    SKY_GO_EXTRA_REMOVED,
    NOW_TV_REMOVED,
    BB_REMOVED_PRODUCT,
    /* TALKU_REMOVED ,
TALKW_REMOVED ,
TALKF_REMOVED ,
TALKA_REMOVED ,
TALKP_REMOVED ,
TALKO_REMOVED ,*/
    TALK_REMOVED,
    CONTACT_TYPE,
    CONTRACT_STATUS,
    ACTUAL_OFFER_STATUS,
    INTENDED_OFFER_STATUS,
    ANY_OFFER_FLAG,
    DTV_PRIMARY_VIEWING_OFFER,
    BB_OFFER,
    TENURE,
    SIMPLE_SEGMENT,
    TV_REGION,
    mosaic_uk_group,
    year_week,
    WEEK_START,
    TV_OFFER_FLAG,
    COMMS_OFFER_FLAG,
    SPORTS_COMPLETE_ADDED,
    SPORTS_COMPLETE_REMOVED,
    --SPORTS_CONTRACT_ADDED ,
    --SPORTS_CONTRACT_REMOVED ,
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
    CINEMA_ADD_ON_ADDED,
    --CINEMA_CONTRACT_ADDED ,
    --CINEMA_CONTRACT_REMOVED ,
    CINEMA_ADD_ON_REMOVED,
    Offer_End_Status_Level_1,
    Offer_End_Status_Level_2,
    ANY_NEW_OFFER_FLAG,
    NEW_DTV_PRIMARY_VIEWING_OFFER,
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
    UOD_ADDED,
    UOD_REMOVED,
    Netflix_Added_Product,
    Netflix_Removed_Product,
    DTV_ADDED_PRODUCT,
    DTV_REMOVED_PRODUCT,
    DTV_Status,
    ACTIVE_DTV_BEFORE_ORDER,
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
    into #ECONOMETRICS_DTV_OFFERS_1
    from #ECONOMETRICS_DTV;
  drop table if exists #ECONOMETRICS_DTV_OFFERS;
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
    A.DTV_CHANGE,
    A.ORDER_CHANGE_COMPLETED,
    A.PREVIOUS_DTV,
    A.PREVIOUS_DTV_1_YEAR,
    A.PREVIOUS_BB,
    A.ORDER_BECAME_ACTIVE,
    A.ACCOUNT_ACTIVE_LENGTH,
    A.BB_BEFORE_ORDER,
    A.BB_AFTER_ORDER,
    A.SPORTS_ADDED,
    A.MOVIES_ADDED,
    A.LEGACY_SPORTS_SUB_ADDED,
    A.LEGACY_MOVIES_SUB_ADDED,
    A.LEGACY_SPORTS_ADDED,
    A.LEGACY_MOVIES_ADDED,
    A.SPORTS_PACK_SUB_ADDED,
    A.SPORTS_PACK_ADDED,
    A.FAMILY_ADDED,
    A.VARIETY_ADDED,
    A.ORIGINAL_ADDED,
    A.SKYQ_ADDED,
    A.HD_LEGACY_ADDED,
    A.HD_BASIC_ADDED,
    A.HD_PREMIUM_ADDED,
    --A.MULTISCREEN_ADDED ,
    --A.MULTISCREEN_PLUS_ADDED ,
    A.MS_ADDED_PRODUCT,
    A.SKY_PLUS_ADDED,
    A.SKY_GO_EXTRA_ADDED,
    A.NOW_TV_ADDED,
    A.BB_ADDED,
    A.BB_ADDED_PRODUCT,
    /* A.TALKU_ADDED ,
A.TALKW_ADDED ,
A.TALKF_ADDED ,
A.TALKA_ADDED ,
A.TALKP_ADDED ,
A.TALKO_ADDED ,*/
    A.TALK_ADDED,
    A.SPORTS_REMOVED,
    A.MOVIES_REMOVED,
    LEGACY_SPORTS_SUB_REMOVED,
    LEGACY_MOVIES_SUB_REMOVED,
    LEGACY_SPORTS_REMOVED,
    LEGACY_MOVIES_REMOVED,
    SPORTS_PACK_SUB_REMOVED,
    SPORTS_PACK_REMOVED,
    A.FAMILY_REMOVED,
    A.VARIETY_REMOVED,
    A.ORIGINAL_REMOVED,
    A.SKYQ_REMOVED,
    A.HD_LEGACY_REMOVED,
    A.HD_BASIC_REMOVED,
    A.HD_PREMIUM_REMOVED,
    --A.MULTISCREEN_REMOVED ,
    --A.MULTISCREEN_PLUS_REMOVED ,
    A.MS_REMOVED_PRODUCT,
    A.SKY_PLUS_REMOVED,
    A.SKY_GO_EXTRA_REMOVED,
    A.NOW_TV_REMOVED,
    A.BB_REMOVED_PRODUCT,
    /*  A.TALKU_REMOVED ,
A.TALKW_REMOVED ,
A.TALKF_REMOVED ,
A.TALKA_REMOVED ,
A.TALKP_REMOVED ,
A.TALKO_REMOVED ,*/
    TALK_REMOVED,
    A.CONTACT_TYPE,
    A.CONTRACT_STATUS,
    A.ACTUAL_OFFER_STATUS,
    A.INTENDED_OFFER_STATUS,
    A.ANY_OFFER_FLAG,
    A.DTV_PRIMARY_VIEWING_OFFER,
    A.BB_OFFER,
    A.TENURE,
    A.SIMPLE_SEGMENT,
    A.TV_REGION,
    A.mosaic_uk_group,
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
    A.TV_OFFER_FLAG,
    A.COMMS_OFFER_FLAG,
    SPORTS_COMPLETE_ADDED,
    SPORTS_COMPLETE_REMOVED,
    --SPORTS_CONTRACT_ADDED ,
    --SPORTS_CONTRACT_REMOVED ,
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
    CINEMA_ADD_ON_ADDED,
    --CINEMA_CONTRACT_ADDED ,
    --CINEMA_CONTRACT_REMOVED ,
    CINEMA_ADD_ON_REMOVED,
    Offer_End_Status_Level_1,
    Offer_End_Status_Level_2,
    ANY_NEW_OFFER_FLAG,
    NEW_DTV_PRIMARY_VIEWING_OFFER,
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
    UOD_ADDED,
    UOD_REMOVED,
    Netflix_Added_Product,
    Netflix_Removed_Product,
    DTV_ADDED_PRODUCT,
    DTV_REMOVED_PRODUCT,
    DTV_Status,
    ACTIVE_DTV_BEFORE_ORDER,
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
    into #ECONOMETRICS_DTV_OFFERS
    from #ECONOMETRICS_DTV_OFFERS_1 as A
      left outer join Decisioning.Offers_Software as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and(A.ORDER_DT = B.Offer_Leg_CREATED_DT
      and B.Offer_Leg = 1)
      and lower(B.Offer_Dim_Description) not like '%price protect%';
  insert into #ECONOMETRICS_DTV_OFFERS
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
      A.DTV_CHANGE,
      A.ORDER_CHANGE_COMPLETED,
      A.PREVIOUS_DTV,
      A.PREVIOUS_DTV_1_YEAR,
      A.PREVIOUS_BB,
      A.ORDER_BECAME_ACTIVE,
      A.ACCOUNT_ACTIVE_LENGTH,
      A.BB_BEFORE_ORDER,
      A.BB_AFTER_ORDER,
      A.SPORTS_ADDED,
      A.MOVIES_ADDED,
      A.LEGACY_SPORTS_SUB_ADDED,
      A.LEGACY_MOVIES_SUB_ADDED,
      A.LEGACY_SPORTS_ADDED,
      A.LEGACY_MOVIES_ADDED,
      A.SPORTS_PACK_SUB_ADDED,
      A.SPORTS_PACK_ADDED,
      A.FAMILY_ADDED,
      A.VARIETY_ADDED,
      A.ORIGINAL_ADDED,
      A.SKYQ_ADDED,
      A.HD_LEGACY_ADDED,
      A.HD_BASIC_ADDED,
      A.HD_PREMIUM_ADDED,
      --A.MULTISCREEN_ADDED ,
      --A.MULTISCREEN_PLUS_ADDED ,
      A.MS_ADDED_PRODUCT,
      A.SKY_PLUS_ADDED,
      A.SKY_GO_EXTRA_ADDED,
      A.NOW_TV_ADDED,
      A.BB_ADDED,
      A.BB_ADDED_PRODUCT,
      /*A.TALKU_ADDED ,
A.TALKW_ADDED ,
A.TALKF_ADDED ,
A.TALKA_ADDED ,
A.TALKP_ADDED ,
A.TALKO_ADDED ,*/
      A.TALK_ADDED,
      A.SPORTS_REMOVED,
      A.MOVIES_REMOVED,
      A.LEGACY_SPORTS_SUB_REMOVED,
      A.LEGACY_MOVIES_SUB_REMOVED,
      A.LEGACY_SPORTS_REMOVED,
      A.LEGACY_MOVIES_REMOVED,
      A.SPORTS_PACK_SUB_REMOVED,
      A.SPORTS_PACK_REMOVED,
      A.FAMILY_REMOVED,
      A.VARIETY_REMOVED,
      A.ORIGINAL_REMOVED,
      A.SKYQ_REMOVED,
      A.HD_LEGACY_REMOVED,
      A.HD_BASIC_REMOVED,
      A.HD_PREMIUM_REMOVED,
      --A.MULTISCREEN_REMOVED ,
      --A.MULTISCREEN_PLUS_REMOVED ,
      A.MS_REMOVED_PRODUCT,
      A.SKY_PLUS_REMOVED,
      A.SKY_GO_EXTRA_REMOVED,
      A.NOW_TV_REMOVED,
      A.BB_REMOVED_PRODUCT,
      /* A.TALKU_REMOVED ,
A.TALKW_REMOVED ,
A.TALKF_REMOVED ,
A.TALKA_REMOVED ,
A.TALKP_REMOVED ,
A.TALKO_REMOVED ,*/
      A.TALK_REMOVED,
      A.CONTACT_TYPE,
      A.CONTRACT_STATUS,
      A.ACTUAL_OFFER_STATUS,
      A.INTENDED_OFFER_STATUS,
      A.ANY_OFFER_FLAG,
      A.DTV_PRIMARY_VIEWING_OFFER,
      A.BB_OFFER,
      A.TENURE,
      A.SIMPLE_SEGMENT,
      A.TV_REGION,
      A.mosaic_uk_group,
      A.year_week,
      A.WEEK_START,
      case when B.DISCOUNT_TYPE = 'OFFER' then 'HARDWARE OFFER'
      else B.DISCOUNT_TYPE
      end as OFFER_SUB_TYPE,
      B.OFFER_ID,
      B.OFFER_DESCRIPTION as OFFER_DESCRIPTION,
      B.DISCOUNT_AMOUNT as MONTHLY_OFFER_VALUE,
      cast(null as integer) as OFFER_DURATION_MTH,
      B.DISCOUNT_AMOUNT as TOTAL_OFFER_VALUE,
      0 as AUTO_TRANSFER_OFFER,
      A.TV_OFFER_FLAG,
      A.COMMS_OFFER_FLAG,
      A.SPORTS_COMPLETE_ADDED,
      A.SPORTS_COMPLETE_REMOVED,
      --A.SPORTS_CONTRACT_ADDED ,
      --A.SPORTS_CONTRACT_REMOVED ,
      A.SPORTS_ACTION_ADDED,
      A.SPORTS_ACTION_REMOVED,
      A.SPORTS_CRICKET_ADDED,
      A.SPORTS_CRICKET_REMOVED,
      A.SPORTS_F1_ADDED,
      A.SPORTS_F1_REMOVED,
      A.SPORTS_FOOTBALL_ADDED,
      A.SPORTS_FOOTBALL_REMOVED,
      A.SPORTS_GOLF_ADDED,
      A.SPORTS_GOLF_REMOVED,
      A.SPORTS_PREMIERLEAGUE_ADDED,
      A.SPORTS_PREMIERLEAGUE_REMOVED,
      A.CINEMA_ADD_ON_ADDED,
      --A.CINEMA_CONTRACT_ADDED ,
      --A.CINEMA_CONTRACT_REMOVED ,
      A.CINEMA_ADD_ON_REMOVED,
      A.Offer_End_Status_Level_1,
      A.Offer_End_Status_Level_2,
      A.ANY_NEW_OFFER_FLAG,
      A.NEW_DTV_PRIMARY_VIEWING_OFFER,
      A.Asia_Pack_Active,
      A.MuTV_Pack_Active,
      A.LTV_Pack_Active,
      A.CTV_Pack_Active,
      A.KIDS_ADDED,
      A.KIDS_REMOVED,
      A.BOXSETS_ADDED,
      A.BOXSETS_REMOVED,
      A.SPOTIFY_ADDED,
      A.SPOTIFY_REMOVED,
      A.UOD_ADDED,
      A.UOD_REMOVED,
      A.Netflix_Added_Product,
      A.Netflix_Removed_Product,
      A.DTV_ADDED_PRODUCT,
      A.DTV_REMOVED_PRODUCT,
      A.DTV_Status,
      A.ACTIVE_DTV_BEFORE_ORDER,
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
      from #ECONOMETRICS_DTV_OFFERS_1 as A
        join OFFERS_DETAILS as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
        and A.ORDER_DT = cast(B.CREATED_DATE as date);
  update #ECONOMETRICS_DTV_OFFERS as a
    set offer_id = b.offer_id,
    offer_description = b.OFFER_DIM_DESCRIPTION,
    OFFER_SUB_TYPE = B.subscription_sub_type,
    MONTHLY_OFFER_VALUE = B.Monthly_Offer_Amount from
    #ECONOMETRICS_DTV_OFFERS as a
    join Decisioning.offers_software as b on a.account_number = b.account_number
    and a.order_dt = b.WHOLE_OFFER_CREATED_DT
    where b.offer_leg = 1
    and a.offer_id is null
    and b.subscription_sub_type = 'DTV Primary Viewing';
  delete from Decisioning.ECONOMETRICS_DTV_ACQUISITIONS_OFFERS
    where WEEK_START >= Refresh_Dt;
  commit work;
  insert into Decisioning.ECONOMETRICS_DTV_ACQUISITIONS_OFFERS
    select YEAR_WEEK,
      WEEK_START,
      CURRENCY_CODE,
      RTM_LEVEL_1,
      RTM_LEVEL_2,
      RTM_LEVEL_3,
      ORDER_COMMUNICATION_TYPE,
      ORDER_SALE_TYPE,
      CONTACT_TYPE,
      -- CONTRACT_STATUS ,
      CHANGE_TYPE,
      DTV_CHANGE,
      ORDER_CHANGE_COMPLETED,
      PREVIOUS_DTV,
      PREVIOUS_DTV_1_YEAR,
      PREVIOUS_BB,
      ORDER_BECAME_ACTIVE,
      ACCOUNT_ACTIVE_LENGTH,
      BB_BEFORE_ORDER,
      BB_AFTER_ORDER,
      SPORTS_ADDED,
      MOVIES_ADDED,
      LEGACY_SPORTS_SUB_ADDED,
      LEGACY_MOVIES_SUB_ADDED,
      --LEGACY_SPORTS_ADDED ,
      --LEGACY_MOVIES_ADDED ,
      SPORTS_PACK_SUB_ADDED,
      SPORTS_PACK_ADDED,
      --FAMILY_ADDED ,
      --VARIETY_ADDED ,
      --ORIGINAL_ADDED ,
      --SKYQ_ADDED ,
      HD_LEGACY_ADDED,
      HD_BASIC_ADDED,
      HD_PREMIUM_ADDED,
      --MULTISCREEN_ADDED ,
      --MULTISCREEN_PLUS_ADDED ,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      BB_ADDED,
      BB_ADDED_PRODUCT,
      /*  TALKU_ADDED ,
TALKW_ADDED ,
TALKF_ADDED ,
TALKA_ADDED ,
TALKP_ADDED ,
TALKO_ADDED ,*/
      TALK_ADDED,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      LEGACY_SPORTS_SUB_REMOVED,
      LEGACY_MOVIES_SUB_REMOVED,
      --LEGACY_SPORTS_REMOVED ,
      --LEGACY_MOVIES_REMOVED ,
      SPORTS_PACK_SUB_REMOVED,
      SPORTS_PACK_REMOVED,
      --FAMILY_REMOVED ,
      --VARIETY_REMOVED ,
      --ORIGINAL_REMOVED ,
      --SKYQ_REMOVED ,
      HD_LEGACY_REMOVED,
      HD_BASIC_REMOVED,
      HD_PREMIUM_REMOVED,
      -- MULTISCREEN_REMOVED ,
      -- MULTISCREEN_PLUS_REMOVED ,
      MS_REMOVED_PRODUCT,
      SKY_PLUS_REMOVED,
      SKY_GO_EXTRA_REMOVED,
      NOW_TV_REMOVED,
      BB_REMOVED_PRODUCT,
      /*    TALKU_REMOVED ,
TALKW_REMOVED ,
TALKF_REMOVED ,
TALKA_REMOVED ,
TALKP_REMOVED ,
TALKO_REMOVED ,*/
      TALK_REMOVED,
      -- ACTUAL_OFFER_STATUS ,
      -- INTENDED_OFFER_STATUS ,
      ANY_OFFER_FLAG,
      --DTV_PRIMARY_VIEWING_OFFER ,
      --BB_OFFER ,
      OFFER_SUB_TYPE,
      OFFER_DESCRIPTION,
      MONTHLY_OFFER_VALUE,
      OFFER_DURATION_MTH,
      TOTAL_OFFER_VALUE,
      AUTO_TRANSFER_OFFER,
      TENURE,
      --SIMPLE_SEGMENT ,
      TV_REGION,
      --MOSAIC_UK_GROUP ,
      count() as NUMBER_OF_ORDERS,
      TV_OFFER_FLAG,
      COMMS_OFFER_FLAG,
      SPORTS_COMPLETE_ADDED,
      SPORTS_COMPLETE_REMOVED,
      --SPORTS_CONTRACT_ADDED ,
      --SPORTS_CONTRACT_REMOVED ,
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
      CINEMA_ADD_ON_ADDED,
      --CINEMA_CONTRACT_ADDED ,
      --CINEMA_CONTRACT_REMOVED ,
      CINEMA_ADD_ON_REMOVED,
      --Offer_End_Status_Level_1 ,
      --Offer_End_Status_Level_2 ,
      ANY_NEW_OFFER_FLAG,
      --NEW_DTV_PRIMARY_VIEWING_OFFER ,
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
      UOD_ADDED,
      UOD_REMOVED,
      Netflix_Added_Product,
      Netflix_Removed_Product,
      DTV_ADDED_PRODUCT,
      DTV_REMOVED_PRODUCT,
      DTV_Status,
      ACTIVE_DTV_BEFORE_ORDER,
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
      from #ECONOMETRICS_DTV_OFFERS
      group by YEAR_WEEK,
      WEEK_START,
      CURRENCY_CODE,
      RTM_LEVEL_1,
      RTM_LEVEL_2,
      RTM_LEVEL_3,
      ORDER_COMMUNICATION_TYPE,
      ORDER_SALE_TYPE,
      CONTACT_TYPE,
      -- CONTRACT_STATUS ,
      CHANGE_TYPE,
      DTV_CHANGE,
      ORDER_CHANGE_COMPLETED,
      PREVIOUS_DTV,
      PREVIOUS_DTV_1_YEAR,
      PREVIOUS_BB,
      ORDER_BECAME_ACTIVE,
      ACCOUNT_ACTIVE_LENGTH,
      BB_BEFORE_ORDER,
      BB_AFTER_ORDER,
      SPORTS_ADDED,
      MOVIES_ADDED,
      LEGACY_SPORTS_SUB_ADDED,
      LEGACY_MOVIES_SUB_ADDED,
      SPORTS_PACK_SUB_ADDED,
      SPORTS_PACK_ADDED,
      HD_LEGACY_ADDED,
      HD_BASIC_ADDED,
      HD_PREMIUM_ADDED,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      BB_ADDED,
      BB_ADDED_PRODUCT,
      TALK_ADDED,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      LEGACY_SPORTS_SUB_REMOVED,
      LEGACY_MOVIES_SUB_REMOVED,
      SPORTS_PACK_SUB_REMOVED,
      SPORTS_PACK_REMOVED,
      HD_LEGACY_REMOVED,
      HD_BASIC_REMOVED,
      HD_PREMIUM_REMOVED,
      MS_REMOVED_PRODUCT,
      SKY_PLUS_REMOVED,
      SKY_GO_EXTRA_REMOVED,
      NOW_TV_REMOVED,
      BB_REMOVED_PRODUCT,
      TALK_REMOVED,
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
      SPORTS_COMPLETE_ADDED,
      SPORTS_COMPLETE_REMOVED,
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
      CINEMA_ADD_ON_ADDED,
      CINEMA_ADD_ON_REMOVED,
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
      UOD_ADDED,
      UOD_REMOVED,
      Netflix_Added_Product,
      Netflix_Removed_Product,
      DTV_ADDED_PRODUCT,
      DTV_REMOVED_PRODUCT,
      DTV_Status,
      ACTIVE_DTV_BEFORE_ORDER,
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
GRANT EXECUTE ON Decisioning_Procs.Update_Econometrics_DTV_Acquisition TO public;


/*
call Decisioning_Procs.Update_Econometrics_DTV_Acquisition();

#create view in CITeam 

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'ECONOMETRICS_DTV_ACQUISITIONS_ORDERS_ACCOUNT_LEVEL');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'ECONOMETRICS_DTV_ACQUISITIONS_ORDERS_ACCOUNT_LEVEL',  'select * from Decisioning.ECONOMETRICS_DTV_ACQUISITIONS_ORDERS_ACCOUNT_LEVEL');

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'ECONOMETRICS_DTV_ACQUISITIONS_ORDERS');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'ECONOMETRICS_DTV_ACQUISITIONS_ORDERS',  'select * from Decisioning.ECONOMETRICS_DTV_ACQUISITIONS_ORDERS');

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'ECONOMETRICS_DTV_ACQUISITIONS_OFFERS');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'ECONOMETRICS_DTV_ACQUISITIONS_OFFERS',  'select * from Decisioning.ECONOMETRICS_DTV_ACQUISITIONS_OFFERS');

*/