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
Project:        Premium Orders & offers 
Created:        21/04/2018
Owner  :        Fractal 
---------------------------------------------------------------------------------------------------------------------------------------------------------------
Program to extract all Premium orders and offers 

***************************************************************************************************************************************************************
****                                                              Change History                                                                           ****
***************************************************************************************************************************************************************
** Change#   Date         Author    	       Description 
** --       ---------   ------------- 	 ------------------------------------
** 1        04/01/2018    Aadtiya       	   Initial release 
** 2        12/06/2018    Vikram 			   Dropping columns and adding account_active_length 
** 4        22/06/2018    Aaditya Padmawar	   Added Contract Status 
** 5 	    17/12/2018 	  Vikram Haibate	   Adding cinema and MOvies offers 
***************************************************************************************************************************************************************

-----------------------------------------------------------------------DDLS------------------------------------------------------------------------------------

dba.sp_drop_table 'Decisioning','ECONOMETRICS_PREMIUM_CHANGE_ORDERS_ACCOUNT_LEVEL'
dba.sp_create_table 'Decisioning','ECONOMETRICS_PREMIUM_CHANGE_ORDERS_ACCOUNT_LEVEL',
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
|| 'UPGRADE_DOWNGRADE varchar(20) default null,'
|| 'PREMIUM_CHANGE char(39) default null,'
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
|| 'MULTISCREEN_PLUS_ADDED smallint default 0,'
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
|| 'MULTISCREEN_PLUS_REMOVED smallint default 0,'
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
|| 'ACCOUNT_NUMBER  varchar(100)  default null,'
|| 'ORDER_ID  varchar(100)  default null,'
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
|| 'Sports_OFFER_END_STATUS_LEVEL_1 varchar(30) default null, '
|| 'Cinema_OFFER_END_STATUS_LEVEL_1 varchar(30) default null, '
|| 'Sports_OFFER_END_STATUS_LEVEL_2 varchar(30) default null, '
|| 'Cinema_OFFER_END_STATUS_LEVEL_2 varchar(30) default null, '
|| 'ANY_NEW_OFFER_FLAG integer default null,'
|| 'Asia_Pack_Active tinyint default 0,'
|| 'MuTV_Pack_Active tinyint default 0,'
|| 'LTV_Pack_Active tinyint default 0,'
|| 'CTV_Pack_Active tinyint default 0,'
|| 'KIDS_ADDED smallint default 0,'
|| 'KIDS_REMOVED smallint default 0,'
|| 'BOXSETS_ADDED smallint default 0,'
|| 'BOXSETS_REMOVED smallint default 0,'
|| 'SPOTIFY_ADDED smallint default 0,'
|| 'SPOTIFY_REMOVED smallint default 0,'
|| 'DTV_ADDED_PRODUCT varchar(30) default null, '
|| 'DTV_REMOVED_PRODUCT varchar(30) default null, '
|| 'ACCOUNT_ACTIVE_LENGTH smallint  default  0,'
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
|| 'Add_on_contract_subscription_item_post_order varchar(200) default null,'
|| 'longest_time_in_nf_app DECIMAL (5,2) DEFAULT NULL, '
|| 'total_nf_app_launches DECIMAL (5,2) DEFAULT NULL, '
|| 'total_time_in_nf_app DECIMAL (5,2) DEFAULT NULL,'
|| 'longest_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL, '
|| 'total_spotify_app_launches DECIMAL (5,2) DEFAULT NULL, '
|| 'total_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL, '
|| ' Basic_Contract_Status_Level_2 varchar(30) default null,'
|| ' Add_on_Products_Contract_Status_Level_2 varchar(30) default null,'
|| ' Talk_Contract_Status_Level_2 varchar(30) default null,'
|| ' BB_Contract_Status_Level_2 varchar(30) default null,'
|| ' Overall_Contract_Status_Level_2 varchar(30) default null,'
|| ' Basic_Contract_Status_Level_1 varchar(30) default null,'
|| ' Add_on_Products_Contract_Status_Level_1 varchar(30) default null,'
|| ' Talk_Contract_Status_Level_1 varchar(30) default null,'
|| ' BB_Contract_Status_Level_1 varchar(30) default null,'
|| ' Overall_Contract_Status_Level_1 varchar(30) default null'


dba.sp_drop_table 'Decisioning','ECONOMETRICS_PREMIUM_CHANGE_ORDERS'
dba.sp_create_table 'Decisioning','ECONOMETRICS_PREMIUM_CHANGE_ORDERS',
   'YEAR_WEEK varchar(31) default null,'
|| 'WEEK_START date default null,'
|| 'CURRENCY_CODE varchar(10) default null,'
|| 'RTM_LEVEL_1 varchar(50) default null,'
|| 'RTM_LEVEL_2 varchar(50) default null,'
|| 'RTM_LEVEL_3 varchar(50) default null,'
|| 'ORDER_COMMUNICATION_TYPE varchar(10) default null,'
|| 'ORDER_SALE_TYPE varchar(50) default null,'
|| 'CONTACT_TYPE varchar(20) default null,'
|| 'UPGRADE_DOWNGRADE varchar(20) default null,'
|| 'PREMIUM_CHANGE char(39) default null,'
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
|| 'Sports_OFFER_END_STATUS_LEVEL_1 varchar(30) default null, '
|| 'Cinema_OFFER_END_STATUS_LEVEL_1 varchar(30) default null, '
|| 'Sports_OFFER_END_STATUS_LEVEL_2 varchar(30) default null, '
|| 'Cinema_OFFER_END_STATUS_LEVEL_2 varchar(30) default null, '
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
|| 'ACCOUNT_ACTIVE_LENGTH smallint  default  0,'
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
|| 'Add_on_contract_subscription_item_post_order varchar(200) default null,'
|| 'longest_time_in_nf_app DECIMAL (5,2) DEFAULT NULL, '
|| 'total_nf_app_launches DECIMAL (5,2) DEFAULT NULL, '
|| 'total_time_in_nf_app DECIMAL (5,2) DEFAULT NULL,'
|| 'Unique_accounts_viewing_nf DECIMAL (5,2) DEFAULT NULL, '
|| 'avg_longest_time_in_nf_app DECIMAL (5,2) DEFAULT NULL,'
|| 'longest_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL, '
|| 'total_spotify_app_launches DECIMAL (5,2) DEFAULT NULL, '
|| 'total_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL ,'
|| 'Unique_accounts_viewing_spotify DECIMAL (5,2) DEFAULT NULL, '
|| 'avg_longest_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL,'
|| ' Basic_Contract_Status_Level_2 varchar(30) default null,'
|| ' Add_on_Products_Contract_Status_Level_2 varchar(30) default null,'
|| ' Talk_Contract_Status_Level_2 varchar(30) default null,'
|| ' BB_Contract_Status_Level_2 varchar(30) default null,'
|| ' Overall_Contract_Status_Level_2 varchar(30) default null,'
|| ' Basic_Contract_Status_Level_1 varchar(30) default null,'
|| ' Add_on_Products_Contract_Status_Level_1 varchar(30) default null,'
|| ' Talk_Contract_Status_Level_1 varchar(30) default null,'
|| ' BB_Contract_Status_Level_1 varchar(30) default null,'
|| ' Overall_Contract_Status_Level_1 varchar(30) default null'


dba.sp_drop_table 'Decisioning','ECONOMETRICS_PREMIUM_CHANGE_OFFERS'
dba.sp_create_table 'Decisioning','ECONOMETRICS_PREMIUM_CHANGE_OFFERS',
   'YEAR_WEEK varchar(31) default null,'
|| 'WEEK_START date default null,'
|| 'CURRENCY_CODE varchar(10) default null,'
|| 'RTM_LEVEL_1 varchar(50) default null,'
|| 'RTM_LEVEL_2 varchar(50) default null,'
|| 'RTM_LEVEL_3 varchar(50) default null,'
|| 'ORDER_COMMUNICATION_TYPE varchar(10) default null,'
|| 'ORDER_SALE_TYPE varchar(50) default null,'
|| 'CONTACT_TYPE varchar(20) default null,'
|| 'UPGRADE_DOWNGRADE varchar(20) default null,'
|| 'PREMIUM_CHANGE char(39) default null,'
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
|| 'Sports_OFFER_END_STATUS_LEVEL_1 varchar(30) default null, '
|| 'Cinema_OFFER_END_STATUS_LEVEL_1 varchar(30) default null, '
|| 'Sports_OFFER_END_STATUS_LEVEL_2 varchar(30) default null, '
|| 'Cinema_OFFER_END_STATUS_LEVEL_2 varchar(30) default null, '
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
|| 'ACCOUNT_ACTIVE_LENGTH smallint  default  0, '
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
|| 'Add_on_contract_subscription_item_post_order varchar(200) default null,'
|| 'longest_time_in_nf_app DECIMAL (5,2) DEFAULT NULL, '
|| 'total_nf_app_launches DECIMAL (5,2) DEFAULT NULL, '
|| 'total_time_in_nf_app DECIMAL (5,2) DEFAULT NULL,'
|| 'Unique_accounts_viewing_nf DECIMAL (5,2) DEFAULT NULL, '
|| 'avg_longest_time_in_nf_app DECIMAL (5,2) DEFAULT NULL,'
|| 'longest_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL, '
|| 'total_spotify_app_launches DECIMAL (5,2) DEFAULT NULL, '
|| 'total_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL ,'
|| 'Unique_accounts_viewing_spotify DECIMAL (5,2) DEFAULT NULL, '
|| 'avg_longest_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL,'
|| ' Basic_Contract_Status_Level_2 varchar(30) default null,'
|| ' Add_on_Products_Contract_Status_Level_2 varchar(30) default null,'
|| ' Talk_Contract_Status_Level_2 varchar(30) default null,'
|| ' BB_Contract_Status_Level_2 varchar(30) default null,'
|| ' Overall_Contract_Status_Level_2 varchar(30) default null,'
|| ' Basic_Contract_Status_Level_1 varchar(30) default null,'
|| ' Add_on_Products_Contract_Status_Level_1 varchar(30) default null,'
|| ' Talk_Contract_Status_Level_1 varchar(30) default null,'
|| ' BB_Contract_Status_Level_1 varchar(30) default null,'
|| ' Overall_Contract_Status_Level_1 varchar(30) default null,'

*/

setuser Decisioning_Procs
GO
DROP PROCEDURE IF EXISTS Decisioning_Procs.Update_Econometrics_PremiumChanges;
GO
create procedure Decisioning_Procs.Update_Econometrics_PremiumChanges( Refresh_Dt date default null ) 
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
*/ --Get All Premium Changes
  if Refresh_Dt is null then
    set Refresh_Dt
       = (select cast(DATEADD(day,-28,coalesce(max(week_start),'2012-01-29')) as date)
        from Decisioning.ECONOMETRICS_PREMIUM_CHANGE_ORDERS)
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
  drop table if exists #PREMIUMS;
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
    case when(A.SPORTS_ADDED+A.MOVIES_ADDED) > (A.SPORTS_REMOVED+A.MOVIES_REMOVED)
    and(A.SPORTS_ADDED+A.MOVIES_ADDED) > 0 then -- MMC sales_type logic included in Offers_Software                        
      'UPGRADE'
    when(A.SPORTS_ADDED+A.MOVIES_ADDED) < (A.SPORTS_REMOVED+A.MOVIES_REMOVED)
    and(A.SPORTS_REMOVED+A.MOVIES_REMOVED) > 0 then --                         AND A.SALE_TYPE <> 'UNBLOCK'
      'DOWNGRADE'
    when(A.SPORTS_ADDED+A.MOVIES_ADDED) = (A.SPORTS_REMOVED+A.MOVIES_REMOVED)
    and(A.SPORTS_ADDED+A.MOVIES_ADDED) > 0 then --                         AND A.SALE_TYPE <> 'UNBLOCK'
      'CROSSGRADE'
    else null
    end as UPGRADE_DOWNGRADE,
    case when A.SPORTS_ADDED > 0
    and A.MOVIES_ADDED = A.MOVIES_REMOVED
    and A.SPORTS_REMOVED = 0 then 'SPORTS ADDED'
    when A.SPORTS_ADDED = A.SPORTS_REMOVED
    and A.MOVIES_ADDED > 0
    and A.MOVIES_REMOVED = 0 then 'MOVIES ADDED'
    when A.SPORTS_ADDED > 0
    and A.MOVIES_ADDED > 0
    and A.SPORTS_REMOVED = 0
    and A.MOVIES_REMOVED = 0 then 'SPORTS AND MOVIES ADDED'
    when A.SPORTS_ADDED = 0
    and A.MOVIES_ADDED = A.MOVIES_REMOVED
    and A.SPORTS_REMOVED > 0 then 'SPORTS REMOVED'
    when A.SPORTS_ADDED = A.SPORTS_REMOVED
    and A.MOVIES_ADDED = 0
    and A.MOVIES_REMOVED > 0 then 'MOVIES REMOVED'
    when A.SPORTS_ADDED = 0
    and A.MOVIES_ADDED = 0
    and A.SPORTS_REMOVED > 0
    and A.MOVIES_REMOVED > 0 then 'SPORTS AND MOVIES REMOVED'
    when A.SPORTS_ADDED > 0
    and A.MOVIES_ADDED = 0
    and A.SPORTS_REMOVED = 0
    and A.MOVIES_REMOVED > 0 then 'SPORTS ADDED AND MOVIES REMOVED'
    when A.SPORTS_ADDED = 0
    and A.MOVIES_ADDED > 0
    and A.SPORTS_REMOVED > 0
    and A.MOVIES_REMOVED = 0 then 'MOVIES ADDED AND SPORTS REMOVED'
    when A.SPORTS_ADDED > 1
    and A.MOVIES_ADDED = A.MOVIES_REMOVED
    and A.SPORTS_REMOVED = 1 then 'SPORTS UPGRADED'
    when A.SPORTS_ADDED = A.SPORTS_REMOVED
    and A.MOVIES_ADDED > 1
    and A.MOVIES_REMOVED = 1 then 'MOVIES UPGRADED'
    when A.SPORTS_ADDED = 1
    and A.MOVIES_ADDED = A.MOVIES_REMOVED
    and A.SPORTS_REMOVED > 1 then 'SPORTS DOWNGRADED'
    when A.SPORTS_ADDED = A.SPORTS_REMOVED
    and A.MOVIES_ADDED = 1
    and A.MOVIES_REMOVED > 1 then 'MOVIES DOWNGRADED'
    when A.SPORTS_ADDED > 1
    and A.MOVIES_ADDED > 0
    and A.SPORTS_REMOVED = 1
    and A.MOVIES_REMOVED = 0 then 'SPORTS UPGRADED AND MOVIES ADDED'
    when A.SPORTS_ADDED > 1
    and A.MOVIES_ADDED = 0
    and A.SPORTS_REMOVED = 1
    and A.MOVIES_REMOVED > 0 then 'SPORTS UPGRADED AND MOVIES REMOVED'
    when A.SPORTS_ADDED = 1
    and A.MOVIES_ADDED > 0
    and A.SPORTS_REMOVED > 1
    and A.MOVIES_REMOVED = 0 then 'SPORTS DOWNGRADED AND MOVIES ADDED'
    when A.SPORTS_ADDED = 1
    and A.MOVIES_ADDED = 0
    and A.SPORTS_REMOVED > 1
    and A.MOVIES_REMOVED > 0 then 'SPORTS DOWNGRADED AND MOVIES REMOVED'
    when A.SPORTS_ADDED > 0
    and A.MOVIES_ADDED > 1
    and A.SPORTS_REMOVED = 0
    and A.MOVIES_REMOVED = 1 then 'MOVIES UPGRADED AND SPORTS ADDED'
    when A.SPORTS_ADDED = 0
    and A.MOVIES_ADDED > 1
    and A.SPORTS_REMOVED > 0
    and A.MOVIES_REMOVED = 1 then 'MOVIES UPGRADED AND SPORTS REMOVED'
    when A.SPORTS_ADDED > 0
    and A.MOVIES_ADDED = 1
    and A.SPORTS_REMOVED = 0
    and A.MOVIES_REMOVED > 1 then 'MOVIES DOWNGRADED AND SPORTS ADDED'
    when A.SPORTS_ADDED = 0
    and A.MOVIES_ADDED = 1
    and A.SPORTS_REMOVED > 0
    and A.MOVIES_REMOVED > 1 then 'MOVIES DOWNGRADED AND SPORTS REMOVED'
    when A.SPORTS_ADDED > 1
    and A.MOVIES_ADDED > 1
    and A.SPORTS_REMOVED = 1
    and A.MOVIES_REMOVED = 1 then 'MOVIES UPGRADED AND SPORTS UPGRADED'
    when A.SPORTS_ADDED = 1
    and A.MOVIES_ADDED = 1
    and A.SPORTS_REMOVED > 1
    and A.MOVIES_REMOVED > 1 then 'MOVIES DOWNGRADED AND SPORTS DOWNGRADED'
    when A.SPORTS_ADDED = 1
    and A.MOVIES_ADDED > 1
    and A.SPORTS_REMOVED > 1
    and A.MOVIES_REMOVED = 1 then 'MOVIES UPGRADED AND SPORTS DOWNGRADED'
    when A.SPORTS_ADDED > 1
    and A.MOVIES_ADDED = 1
    and A.SPORTS_REMOVED = 1
    and A.MOVIES_REMOVED > 1 then 'MOVIES DOWNGRADED AND SPORTS UPGRADED'
    else 'UNKNOWN'
    end as PREMIUM_CHANGE,
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
    MULTISCREEN_PLUS_ADDED,
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
    TALKO_REMOVED, -- MMC Set pre and post order product count to 0 ------------------------------------------------
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
    cast(null as varchar(30)) as BASIC_OFFER_END_STATUS_LEVEL_1,
    cast(null as varchar(30)) as BB_OFFER_END_STATUS_LEVEL_1,
    cast(null as varchar(30)) as LR_OFFER_END_STATUS_LEVEL_1,
    cast(null as varchar(30)) as PREMIUM_OFFER_END_STATUS_LEVEL_1,
    cast(null as varchar(30)) as Sports_OFFER_END_STATUS_LEVEL_1,
    cast(null as varchar(30)) as Cinema_OFFER_END_STATUS_LEVEL_1,
    cast(null as varchar(30)) as HD_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    cast(null as varchar(30)) as MS_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    cast(null as varchar(30)) as SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    cast(null as varchar(30)) as HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    cast(null as varchar(30)) as BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    cast(null as varchar(30)) as SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    cast(null as varchar(30)) as TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    cast(null as varchar(30)) as SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    cast(null as varchar(30)) as ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    cast(null as varchar(30)) as Offer_End_Status_Level_2,
    cast(null as varchar(30)) as BASIC_OFFER_END_STATUS_LEVEL_2,
    cast(null as varchar(30)) as BB_OFFER_END_STATUS_LEVEL_2,
    cast(null as varchar(30)) as LR_OFFER_END_STATUS_LEVEL_2,
    cast(null as varchar(30)) as PREMIUM_OFFER_END_STATUS_LEVEL_2,
    cast(null as varchar(30)) as Sports_OFFER_END_STATUS_LEVEL_2,
    cast(null as varchar(30)) as Cinema_OFFER_END_STATUS_LEVEL_2,
    cast(null as varchar(30)) as HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    cast(null as varchar(30)) as MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    cast(null as varchar(30)) as SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    cast(null as varchar(30)) as HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    cast(null as varchar(30)) as BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    cast(null as varchar(30)) as SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    cast(null as varchar(30)) as TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    cast(null as varchar(30)) as SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    cast(null as varchar(30)) as ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    cast(null as date) as Prev_Offer_Actual_End_Dt_DTV,
    cast(null as date) as Curr_Offer_Intended_end_Dt_DTV,
    cast(null as date) as Prev_Offer_Actual_End_Dt_BB,
    cast(null as date) as Curr_Offer_Intended_end_Dt_BB,
    cast(null as date) as Prev_Offer_Actual_End_Dt_LR,
    cast(null as date) as Curr_Offer_Intended_end_Dt_LR,
    cast(null as date) as Curr_Offer_Intended_end_Dt_Movies,
    cast(null as date) as Prev_Offer_Actual_End_Dt_Movies,
    cast(null as date) as Curr_Offer_Intended_end_Dt_Sports,
    cast(null as date) as Prev_Offer_Actual_End_Dt_Sports,
    cast(null as date) as Prev_Offer_Actual_End_Dt_HD,
    cast(null as date) as Curr_Offer_Intended_end_Dt_HD,
    cast(null as date) as Prev_Offer_Actual_End_Dt_MS,
    cast(null as date) as Curr_Offer_Intended_end_Dt_MS,
    cast(null as date) as Prev_Offer_Actual_End_Dt_SGE,
    cast(null as date) as Curr_Offer_Intended_end_Dt_SGE,
    cast(null as date) as Prev_Offer_Actual_End_Dt_HD_PACK,
    cast(null as date) as Curr_Offer_Intended_end_Dt_HD_PACK,
    cast(null as date) as Prev_Offer_Actual_End_Dt_BOX_SETS,
    cast(null as date) as Curr_Offer_Intended_end_Dt_BOX_SETS,
    cast(null as date) as Prev_Offer_Actual_End_Dt_SKY_KIDS,
    cast(null as date) as Curr_Offer_Intended_end_Dt_SKY_KIDS,
    cast(null as date) as Prev_Offer_Actual_End_Dt_TALK,
    cast(null as date) as Curr_Offer_Intended_end_Dt_TALK,
    cast(null as date) as Prev_Offer_Actual_End_Dt_SPOTIFY,
    cast(null as date) as Curr_Offer_Intended_end_Dt_SPOTIFY,
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
    --   ,Cast(0 AS integer) AS Overall_contract_status_pre_order
    --   ,Cast(NULL AS varchar(200)) AS overall_contract_subscription_item_pre_order
    cast(0 as integer) as Basic_contract_status_post_order,
    cast(null as varchar(200)) as Basic_contract_subscription_item_post_order,
    cast(0 as integer) as BB_contract_status_post_order,
    cast(null as varchar(200)) as BB_contract_subscription_item_post_order,
    cast(0 as integer) as Talk_contract_status_post_order,
    cast(null as varchar(200)) as Talk_contract_subscription_item_post_order,
    cast(0 as integer) as Add_on_contract_status_post_order,
    cast(null as varchar(200)) as Add_on_contract_subscription_item_post_order,
    --  \x09   ,Cast(0 AS integer) AS Overall_contract_status_post_order
    --\x09   ,Cast(NULL AS varchar(200)) AS overall_contract_subscription_item_post_order
    cast('No Contract' as varchar(100)) as Basic_Contract_Status_Level_2,
    cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_2,
    cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_2_DTV_Extra_Subscription,
    cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_2_DTV_Sky_plus,
    cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_2_DTV_HD,
    cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_2_MS_plus,
    cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_2_SKY_BOX_SETS,
    cast('No Contract' as varchar(100)) as Overall_Contract_Status_Level_2,
    cast('No Contract' as varchar(100)) as Talk_Contract_Status_Level_2,
    cast('No Contract' as varchar(100)) as BB_Contract_Status_Level_2,
    cast('No Contract' as varchar(100)) as Basic_Contract_Status_Level_1,
    cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_1,
    cast('No Contract' as varchar(100)) as Talk_Contract_Status_Level_1,
    cast('No Contract' as varchar(100)) as BB_Contract_Status_Level_1,
    cast('No Contract' as varchar(100)) as Overall_Contract_Status_Level_1,
    cast(0 as integer) as PRE_ORDER_Prems_Active
    into #PREMIUMS
    from Citeam.Orders_Daily as A
    where order_dt >= Refresh_dt --order_dt>=period_start
    --  AND order_dt<=period_end 
    and((A.SPORTS_ADDED+A.MOVIES_ADDED+A.SPORTS_REMOVED+A.MOVIES_REMOVED) > 0
    and DTV_ADDED = DTV_REMOVED);
  -- MMC Removed so REGRADES are included
  -- MMC Populate prems fields with Model T data -----------------------------------------------
  call Decisioning_Procs.Add_Active_Subscriber_Product_Holding_Econ('#PREMIUMS','ORDER_DT_SoD','DTV','Update Only','Sports_Active','DTV_Active'); /*,'Sports_Product_Holding'*/
  delete from
    #PREMIUMS
    where DTV_Active = 0;
  call Decisioning_Procs.Add_Active_Subscriber_Product_Holding_Econ('#PREMIUMS','ORDER_DT_SoD','Sports','Update Only','Sports_Active','Sports_Product_Count'); /*,'Sports_Product_Holding'*/
  call Decisioning_Procs.Add_Active_Subscriber_Product_Holding_Econ('#PREMIUMS','ORDER_DT_SoD','Movies','Update Only','Movies_Active','Movies_Product_Count'); /*,'Movies_Product_Holding'*/
  call Decisioning_Procs.Add_Active_Subscriber_Product_Holding_Econ('#PREMIUMS','ORDER_DT_SoD','Prems','Update Only','Prems_Active','Prems_Product_Count'); /*,'Prems_Product_Holding'*/
  -- MMC new proc calls to populate offers details ---------------------------------------------
  call Decisioning_Procs.Add_Offers_Software('#Premiums','ORDER_DT','Any','Ordered','New',null,'Update Only','Offers_Applied_Lst_1D_Any');
  call Decisioning_Procs.Add_Offers_Software('#Premiums','ORDER_DT','DTV','Ordered','New',null,'Update Only','Offers_Applied_Lst_1D_DTV');
  update #Premiums
    set ANY_NEW_OFFER_FLAG
     = case when Offers_Applied_Lst_1D_Any > 0 then 1
    else 0
    end;
  update #Premiums
    set Offers_Applied_Lst_1D_Any = 0,
    Offers_Applied_Lst_1D_DTV = 0;
  commit work;
  call Decisioning_Procs.Add_Offers_Software('#Premiums','ORDER_DT','Any','Ordered','All',null,'Update Only','Offers_Applied_Lst_1D_Any');
  call Decisioning_Procs.Add_Offers_Software('#Premiums','ORDER_DT','DTV','Ordered','All',null,'Update Only','Offers_Applied_Lst_1D_DTV');
  update #PREMIUMS
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
  update #PREMIUMS
    set PRE_ORDER_TOTAL_SPORTS
     = case when PRE_ORDER_TOTAL_SPORTS > 6 then 6
    else PRE_ORDER_TOTAL_SPORTS
    end;
  commit work;
  update #PREMIUMS
    set PRE_ORDER_TOTAL_PREMIUMS = PRE_ORDER_TOTAL_SPORTS+PRE_ORDER_TOTAL_MOVIES;
  commit work;
  update #PREMIUMS
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
  update #PREMIUMS
    set Sports_Active = 0,
    Sports_Product_Count = 0,
    Movies_Active = 0,
    Movies_Product_Count = 0,
    Prems_Active = 0,
    Prems_Product_Count = 0;
  commit work;
  
  update #PREMIUMS
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
  update #PREMIUMS
    set POST_ORDER_TOTAL_SPORTS
     = case when POST_ORDER_TOTAL_SPORTS > 6 then 6
    else POST_ORDER_TOTAL_SPORTS
    end;
  
  commit work;
  
  update #PREMIUMS
    set POST_ORDER_TOTAL_PREMIUMS = POST_ORDER_TOTAL_SPORTS+POST_ORDER_TOTAL_MOVIES;
  commit work;
  
  update #PREMIUMS
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
  
  update #PREMIUMS
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
  update #PREMIUMS as A
    set A.ACTIVE_BROADBAND_BEFORE_ORDER
     = case when B.BB_ACTIVE_SUBSCRIPTION = 1 then 1
    else 0
    end from
    #PREMIUMS as A
    join CITEAM.Active_Subscriber_Report as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT-1 >= B.EFFECTIVE_FROM_DT
    and A.ORDER_DT-1 < B.EFFECTIVE_TO_DT
    where B.BB_ACTIVE_SUBSCRIPTION = 1;
  /*
CALL Decisioning_Procs.Add_Offers_Software('#Premiums', 'ORDER_DT_SoD', 'Any', 'Ordered', 'Update Only' , 'Prev_Offer_Start_Dt_Any', 'Prev_Offer_Intended_end_Dt_Any', 'Prev_Offer_Actual_End_Dt_Any' , 'Curr_Offer_Start_Dt_Any', 'Curr_Offer_Intended_end_Dt_Any', 'Curr_Offer_Actual_End_Dt_Any' );


UPDATE #Premiums
SET Offer_End_Status_Level_2 = CASE
WHEN Curr_Offer_Intended_end_Dt_Any BETWEEN (ORDER_DT_SoD + 1) AND (ORDER_DT_SoD + 7) THEN 'Offer Ending in Next 1 Wks'
WHEN Curr_Offer_Intended_end_Dt_Any BETWEEN (ORDER_DT_SoD + 8) AND (ORDER_DT_SoD + 14) THEN 'Offer Ending in Next 2-3 Wks'
WHEN Curr_Offer_Intended_end_Dt_Any BETWEEN (ORDER_DT_SoD + 15) AND (ORDER_DT_SoD + 21) THEN 'Offer Ending in Next 2-3 Wks'
WHEN Curr_Offer_Intended_end_Dt_Any BETWEEN (ORDER_DT_SoD + 22) AND (ORDER_DT_SoD + 28) THEN 'Offer Ending in Next 4-6 Wks'
WHEN Curr_Offer_Intended_end_Dt_Any BETWEEN (ORDER_DT_SoD + 29) AND (ORDER_DT_SoD + 35) THEN 'Offer Ending in Next 4-6 Wks'
WHEN Curr_Offer_Intended_end_Dt_Any BETWEEN (ORDER_DT_SoD + 36) AND (ORDER_DT_SoD + 42) THEN 'Offer Ending in Next 4-6 Wks'
WHEN Curr_Offer_Intended_end_Dt_Any > (ORDER_DT_SoD + 42) THEN 'Offer Ending in 7+ Wks'
WHEN Prev_Offer_Actual_End_Dt_Any BETWEEN (ORDER_DT_SoD - 7) AND ORDER_DT_SoD THEN 'Offer Ended in last 1 Wks'
WHEN Prev_Offer_Actual_End_Dt_Any BETWEEN (ORDER_DT_SoD - 14) AND (ORDER_DT_SoD - 8) THEN 'Offer Ended in last 2-3 Wks'
WHEN Prev_Offer_Actual_End_Dt_Any BETWEEN (ORDER_DT_SoD - 21) AND (ORDER_DT_SoD - 15) THEN 'Offer Ended in last 2-3 Wks'
WHEN Prev_Offer_Actual_End_Dt_Any BETWEEN (ORDER_DT_SoD - 28) AND (ORDER_DT_SoD - 22) THEN 'Offer Ended in last 4-6 Wks'
WHEN Prev_Offer_Actual_End_Dt_Any BETWEEN (ORDER_DT_SoD - 35) AND (ORDER_DT_SoD - 29) THEN 'Offer Ended in last 4-6 Wks'
WHEN Prev_Offer_Actual_End_Dt_Any BETWEEN (ORDER_DT_SoD - 42) AND (ORDER_DT_SoD - 36) THEN 'Offer Ended in last 4-6 Wks'
WHEN Prev_Offer_Actual_End_Dt_Any < (ORDER_DT_SoD - 42) THEN 'Offer Ended 7+ Wks'
ELSE 'No Offer'
END;


UPDATE #Premiums
SET Offer_End_Status_Level_1 = CASE
WHEN Offer_End_Status_Level_2 IN ('Offer Ending in Next 1 Wks',
'Offer Ending in Next 2-3 Wks',
'Offer Ending in Next 4-6 Wks',
'Offer Ended in last 1 Wks',
'Offer Ended in last 2-3 Wks',
'Offer Ended in last 4-6 Wks') THEN 'Offer Ending'
WHEN Offer_End_Status_Level_2 = 'Offer Ending in 7+ Wks' THEN 'On Offer'
ELSE 'No Offer'
END;


COMMIT;

*/
  -- Offers status  start \x09
  call Decisioning_Procs.Add_Offers_Software('#PREMIUMS','ORDER_DT_SoD','DTV','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_DTV','Curr_Offer_Intended_end_Dt_DTV');
  update #PREMIUMS
    set Basic_Offer_End_Status_Level_2
     = case when Curr_Offer_Intended_end_Dt_DTV between(ORDER_DT_SoD+1) and(ORDER_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
    when Curr_Offer_Intended_end_Dt_DTV between(ORDER_DT_SoD+8) and(ORDER_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
    when Curr_Offer_Intended_end_Dt_DTV between(ORDER_DT_SoD+15) and(ORDER_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
    when Curr_Offer_Intended_end_Dt_DTV between(ORDER_DT_SoD+22) and(ORDER_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_DTV between(ORDER_DT_SoD+29) and(ORDER_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_DTV between(ORDER_DT_SoD+36) and(ORDER_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_DTV > (ORDER_DT_SoD+42) then 'Offer Ending in 7+ Wks'
    when Prev_Offer_Actual_End_Dt_DTV between(ORDER_DT_SoD-7) and ORDER_DT_SoD then 'Offer Ended in last 1 Wks'
    when Prev_Offer_Actual_End_Dt_DTV between(ORDER_DT_SoD-14) and(ORDER_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
    when Prev_Offer_Actual_End_Dt_DTV between(ORDER_DT_SoD-21) and(ORDER_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
    when Prev_Offer_Actual_End_Dt_DTV between(ORDER_DT_SoD-28) and(ORDER_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_DTV between(ORDER_DT_SoD-35) and(ORDER_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_DTV between(ORDER_DT_SoD-42) and(ORDER_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_DTV < (ORDER_DT_SoD-42) then 'Offer Ended 7+ Wks'
    else
      'No Offer'
    end;
  update #PREMIUMS
    set Basic_Offer_End_Status_Level_1
     = case when Basic_Offer_End_Status_Level_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when Basic_Offer_End_Status_Level_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  call Decisioning_Procs.Add_Offers_Software('#PREMIUMS','ORDER_DT_SoD','BROADBAND','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_BB','Curr_Offer_Intended_end_Dt_BB');
  update #PREMIUMS
    set BB_Offer_End_Status_Level_2
     = case when ACTIVE_BROADBAND_BEFORE_ORDER = 1 then
      (case when Curr_Offer_Intended_end_Dt_BB between(ORDER_DT_SoD+1) and(ORDER_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_BB between(ORDER_DT_SoD+8) and(ORDER_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_BB between(ORDER_DT_SoD+15) and(ORDER_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_BB between(ORDER_DT_SoD+22) and(ORDER_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_BB between(ORDER_DT_SoD+29) and(ORDER_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_BB between(ORDER_DT_SoD+36) and(ORDER_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_BB > (ORDER_DT_SoD+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_BB between(ORDER_DT_SoD-7) and ORDER_DT_SoD then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_BB between(ORDER_DT_SoD-14) and(ORDER_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_BB between(ORDER_DT_SoD-21) and(ORDER_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_BB between(ORDER_DT_SoD-28) and(ORDER_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_BB between(ORDER_DT_SoD-35) and(ORDER_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_BB between(ORDER_DT_SoD-42) and(ORDER_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_BB < (ORDER_DT_SoD-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #PREMIUMS
    set BB_Offer_End_Status_Level_1
     = case when BB_Offer_End_Status_Level_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when BB_Offer_End_Status_Level_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  call Decisioning_Procs.Add_Offers_Software('#PREMIUMS','ORDER_DT_SoD','LR','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_LR','Curr_Offer_Intended_end_Dt_LR');
  update #PREMIUMS
    set LR_Offer_End_Status_Level_2
     = case when Curr_Offer_Intended_end_Dt_LR between(ORDER_DT_SoD+1) and(ORDER_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
    when Curr_Offer_Intended_end_Dt_LR between(ORDER_DT_SoD+8) and(ORDER_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
    when Curr_Offer_Intended_end_Dt_LR between(ORDER_DT_SoD+15) and(ORDER_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
    when Curr_Offer_Intended_end_Dt_LR between(ORDER_DT_SoD+22) and(ORDER_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_LR between(ORDER_DT_SoD+29) and(ORDER_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_LR between(ORDER_DT_SoD+36) and(ORDER_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_LR > (ORDER_DT_SoD+42) then 'Offer Ending in 7+ Wks'
    when Prev_Offer_Actual_End_Dt_LR between(ORDER_DT_SoD-7) and ORDER_DT_SoD then 'Offer Ended in last 1 Wks'
    when Prev_Offer_Actual_End_Dt_LR between(ORDER_DT_SoD-14) and(ORDER_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
    when Prev_Offer_Actual_End_Dt_LR between(ORDER_DT_SoD-21) and(ORDER_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
    when Prev_Offer_Actual_End_Dt_LR between(ORDER_DT_SoD-28) and(ORDER_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_LR between(ORDER_DT_SoD-35) and(ORDER_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_LR between(ORDER_DT_SoD-42) and(ORDER_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_LR < (ORDER_DT_SoD-42) then 'Offer Ended 7+ Wks'
    else 'No Offer'
    end;
  update #PREMIUMS
    set LR_Offer_End_Status_Level_1
     = case when LR_Offer_End_Status_Level_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when LR_Offer_End_Status_Level_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- sports 
  call Decisioning_Procs.Add_Offers_Software('#PREMIUMS','ORDER_DT_SoD','Sports','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_Sports','Curr_Offer_Intended_end_Dt_Sports');
  update #PREMIUMS
    set Sports_OFFER_END_STATUS_LEVEL_2
     = case when PRE_ORDER_TOTAL_SPORTS > 0 then
      (case when Curr_Offer_Intended_end_Dt_Sports between(ORDER_DT_SoD+1) and(ORDER_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_Sports between(ORDER_DT_SoD+8) and(ORDER_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_Sports between(ORDER_DT_SoD+15) and(ORDER_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_Sports between(ORDER_DT_SoD+22) and(ORDER_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_Sports between(ORDER_DT_SoD+29) and(ORDER_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_Sports between(ORDER_DT_SoD+36) and(ORDER_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_Sports > (ORDER_DT_SoD+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_Sports between(ORDER_DT_SoD-7) and ORDER_DT_SoD then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_Sports between(ORDER_DT_SoD-14) and(ORDER_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_Sports between(ORDER_DT_SoD-21) and(ORDER_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_Sports between(ORDER_DT_SoD-28) and(ORDER_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_Sports between(ORDER_DT_SoD-35) and(ORDER_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_Sports between(ORDER_DT_SoD-42) and(ORDER_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_Sports < (ORDER_DT_SoD-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #PREMIUMS
    set Sports_OFFER_END_STATUS_LEVEL_1
     = case when Sports_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when Sports_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then 'On Offer'
    else 'No Offer'
    end;
  -- movies 
  call Decisioning_Procs.Add_Offers_Software('#PREMIUMS','ORDER_DT_SoD','Movies','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_Movies','Curr_Offer_Intended_end_Dt_Movies');
  update #PREMIUMS
    set Cinema_OFFER_END_STATUS_LEVEL_2
     = case when PRE_ORDER_TOTAL_MOVIES > 0 then
      (case when Curr_Offer_Intended_end_Dt_Movies between(ORDER_DT_SoD+1) and(ORDER_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_Movies between(ORDER_DT_SoD+8) and(ORDER_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_Movies between(ORDER_DT_SoD+15) and(ORDER_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_Movies between(ORDER_DT_SoD+22) and(ORDER_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_Movies between(ORDER_DT_SoD+29) and(ORDER_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_Movies between(ORDER_DT_SoD+36) and(ORDER_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_Movies > (ORDER_DT_SoD+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_Movies between(ORDER_DT_SoD-7) and ORDER_DT_SoD then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_Movies between(ORDER_DT_SoD-14) and(ORDER_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_Movies between(ORDER_DT_SoD-21) and(ORDER_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_Movies between(ORDER_DT_SoD-28) and(ORDER_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_Movies between(ORDER_DT_SoD-35) and(ORDER_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_Movies between(ORDER_DT_SoD-42) and(ORDER_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_Movies < (ORDER_DT_SoD-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #PREMIUMS
    set Cinema_OFFER_END_STATUS_LEVEL_1
     = case when Cinema_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when Cinema_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then 'On Offer'
    else 'No Offer'
    end;
  -- PREMS
  update #PREMIUMS
    set PREMIUM_Offer_End_Status_Level_1
     = case when PRE_ORDER_TOTAL_PREMIUMS > 0 then
      (case when(Sports_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or Cinema_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending') then 'Offer Ending'
      when(Sports_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or Cinema_OFFER_END_STATUS_LEVEL_1 = 'On Offer') then 'On Offer'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #PREMIUMS
    set PREMIUM_Offer_End_Status_Level_2
     = case when PRE_ORDER_TOTAL_PREMIUMS > 0 then
      (case when PREMIUM_Offer_End_Status_Level_1 = 'No Offer' then 'No Offer'
      when PREMIUM_Offer_End_Status_Level_1 = 'On Offer' then 'Offer Ending in 7+ Wks'
      when PREMIUM_Offer_End_Status_Level_1 = 'Offer Ending' then
        (case when(Sports_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks' ) or Cinema_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks' ) ) then 'Offer Ending in Next 1 Wks'
        when(Sports_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 2-3 Wks' ) or Cinema_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 2-3 Wks' ) ) then 'Offer Ending in Next 2-3 Wks'
        when(Sports_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 4-6 Wks' ) or Cinema_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 4-6 Wks' ) ) then 'Offer Ending in Next 4-6 Wks'
        when(Sports_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ended in last 1 Wks' ) or Cinema_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ended in last 1 Wks' ) ) then 'Offer Ended in last 1 Wks'
        when(Sports_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ended in last 2-3 Wks' ) or Cinema_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ended in last 2-3 Wks' ) ) then 'Offer Ended in last 2-3 Wks'
        when(Sports_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ended in last 4-6 Wks' ) or Cinema_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ended in last 4-6 Wks' ) ) then 'Offer Ended in last 4-6 Wks' end)
      end)
    else
      'No Offer'
    end;
  -- ADD On Packages start \x09\x09
  -- HD  
  call Decisioning_Procs.Add_Offers_Software('#PREMIUMS','ORDER_DT_SoD','HD','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_HD','Curr_Offer_Intended_end_Dt_HD');
  update #PREMIUMS
    set HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when Curr_Offer_Intended_end_Dt_HD between(ORDER_DT_SoD+1) and(ORDER_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
    when Curr_Offer_Intended_end_Dt_HD between(ORDER_DT_SoD+8) and(ORDER_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
    when Curr_Offer_Intended_end_Dt_HD between(ORDER_DT_SoD+15) and(ORDER_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
    when Curr_Offer_Intended_end_Dt_HD between(ORDER_DT_SoD+22) and(ORDER_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_HD between(ORDER_DT_SoD+29) and(ORDER_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_HD between(ORDER_DT_SoD+36) and(ORDER_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_HD > (ORDER_DT_SoD+42) then 'Offer Ending in 7+ Wks'
    when Prev_Offer_Actual_End_Dt_HD between(ORDER_DT_SoD-7) and ORDER_DT_SoD then 'Offer Ended in last 1 Wks'
    when Prev_Offer_Actual_End_Dt_HD between(ORDER_DT_SoD-14) and(ORDER_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
    when Prev_Offer_Actual_End_Dt_HD between(ORDER_DT_SoD-21) and(ORDER_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
    when Prev_Offer_Actual_End_Dt_HD between(ORDER_DT_SoD-28) and(ORDER_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_HD between(ORDER_DT_SoD-35) and(ORDER_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_HD between(ORDER_DT_SoD-42) and(ORDER_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_HD < (ORDER_DT_SoD-42) then 'Offer Ended 7+ Wks'
    else 'No Offer'
    end;
  update #PREMIUMS
    set HD_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- ms 
  call Decisioning_Procs.Add_Offers_Software('#PREMIUMS','ORDER_DT_SoD','MS','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_MS','Curr_Offer_Intended_end_Dt_MS');
  update #PREMIUMS
    set MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when Curr_Offer_Intended_end_Dt_MS between(ORDER_DT_SoD+1) and(ORDER_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
    when Curr_Offer_Intended_end_Dt_MS between(ORDER_DT_SoD+8) and(ORDER_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
    when Curr_Offer_Intended_end_Dt_MS between(ORDER_DT_SoD+15) and(ORDER_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
    when Curr_Offer_Intended_end_Dt_MS between(ORDER_DT_SoD+22) and(ORDER_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_MS between(ORDER_DT_SoD+29) and(ORDER_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_MS between(ORDER_DT_SoD+36) and(ORDER_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_MS > (ORDER_DT_SoD+42) then 'Offer Ending in 7+ Wks'
    when Prev_Offer_Actual_End_Dt_MS between(ORDER_DT_SoD-7) and ORDER_DT_SoD then 'Offer Ended in last 1 Wks'
    when Prev_Offer_Actual_End_Dt_MS between(ORDER_DT_SoD-14) and(ORDER_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
    when Prev_Offer_Actual_End_Dt_MS between(ORDER_DT_SoD-21) and(ORDER_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
    when Prev_Offer_Actual_End_Dt_MS between(ORDER_DT_SoD-28) and(ORDER_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_MS between(ORDER_DT_SoD-35) and(ORDER_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_MS between(ORDER_DT_SoD-42) and(ORDER_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_MS < (ORDER_DT_SoD-42) then 'Offer Ended 7+ Wks'
    else 'No Offer'
    end;
  update #PREMIUMS
    set MS_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- SGE 
  call Decisioning_Procs.Add_Offers_Software('#PREMIUMS','ORDER_DT_SoD','SGE','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_SGE','Curr_Offer_Intended_end_Dt_SGE');
  update #PREMIUMS
    set SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when Curr_Offer_Intended_end_Dt_SGE between(ORDER_DT_SoD+1) and(ORDER_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
    when Curr_Offer_Intended_end_Dt_SGE between(ORDER_DT_SoD+8) and(ORDER_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
    when Curr_Offer_Intended_end_Dt_SGE between(ORDER_DT_SoD+15) and(ORDER_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
    when Curr_Offer_Intended_end_Dt_SGE between(ORDER_DT_SoD+22) and(ORDER_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_SGE between(ORDER_DT_SoD+29) and(ORDER_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_SGE between(ORDER_DT_SoD+36) and(ORDER_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_SGE > (ORDER_DT_SoD+42) then 'Offer Ending in 7+ Wks'
    when Prev_Offer_Actual_End_Dt_SGE between(ORDER_DT_SoD-7) and ORDER_DT_SoD then 'Offer Ended in last 1 Wks'
    when Prev_Offer_Actual_End_Dt_SGE between(ORDER_DT_SoD-14) and(ORDER_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
    when Prev_Offer_Actual_End_Dt_SGE between(ORDER_DT_SoD-21) and(ORDER_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
    when Prev_Offer_Actual_End_Dt_SGE between(ORDER_DT_SoD-28) and(ORDER_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_SGE between(ORDER_DT_SoD-35) and(ORDER_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_SGE between(ORDER_DT_SoD-42) and(ORDER_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_SGE < (ORDER_DT_SoD-42) then 'Offer Ended 7+ Wks'
    else 'No Offer'
    end;
  update #PREMIUMS
    set SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- HD Pack  
  call Decisioning_Procs.Add_Offers_Software('#PREMIUMS','ORDER_DT_SoD','HD PACK','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_HD_PACK','Curr_Offer_Intended_end_Dt_HD_PACK');
  update #PREMIUMS
    set HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when Curr_Offer_Intended_end_Dt_HD_PACK between(ORDER_DT_SoD+1) and(ORDER_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
    when Curr_Offer_Intended_end_Dt_HD_PACK between(ORDER_DT_SoD+8) and(ORDER_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
    when Curr_Offer_Intended_end_Dt_HD_PACK between(ORDER_DT_SoD+15) and(ORDER_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
    when Curr_Offer_Intended_end_Dt_HD_PACK between(ORDER_DT_SoD+22) and(ORDER_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_HD_PACK between(ORDER_DT_SoD+29) and(ORDER_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_HD_PACK between(ORDER_DT_SoD+36) and(ORDER_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_HD_PACK > (ORDER_DT_SoD+42) then 'Offer Ending in 7+ Wks'
    when Prev_Offer_Actual_End_Dt_HD_PACK between(ORDER_DT_SoD-7) and ORDER_DT_SoD then 'Offer Ended in last 1 Wks'
    when Prev_Offer_Actual_End_Dt_HD_PACK between(ORDER_DT_SoD-14) and(ORDER_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
    when Prev_Offer_Actual_End_Dt_HD_PACK between(ORDER_DT_SoD-21) and(ORDER_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
    when Prev_Offer_Actual_End_Dt_HD_PACK between(ORDER_DT_SoD-28) and(ORDER_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_HD_PACK between(ORDER_DT_SoD-35) and(ORDER_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_HD_PACK between(ORDER_DT_SoD-42) and(ORDER_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_HD_PACK < (ORDER_DT_SoD-42) then 'Offer Ended 7+ Wks'
    else 'No Offer'
    end;
  update #PREMIUMS
    set HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- Box sets 
  call Decisioning_Procs.Add_Offers_Software('#PREMIUMS','ORDER_DT_SoD','BOX SETS','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_BOX_SETS','Curr_Offer_Intended_end_Dt_BOX_SETS');
  update #PREMIUMS
    set BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when Curr_Offer_Intended_end_Dt_BOX_SETS between(ORDER_DT_SoD+1) and(ORDER_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
    when Curr_Offer_Intended_end_Dt_BOX_SETS between(ORDER_DT_SoD+8) and(ORDER_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
    when Curr_Offer_Intended_end_Dt_BOX_SETS between(ORDER_DT_SoD+15) and(ORDER_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
    when Curr_Offer_Intended_end_Dt_BOX_SETS between(ORDER_DT_SoD+22) and(ORDER_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_BOX_SETS between(ORDER_DT_SoD+29) and(ORDER_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_BOX_SETS between(ORDER_DT_SoD+36) and(ORDER_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_BOX_SETS > (ORDER_DT_SoD+42) then 'Offer Ending in 7+ Wks'
    when Prev_Offer_Actual_End_Dt_BOX_SETS between(ORDER_DT_SoD-7) and ORDER_DT_SoD then 'Offer Ended in last 1 Wks'
    when Prev_Offer_Actual_End_Dt_BOX_SETS between(ORDER_DT_SoD-14) and(ORDER_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
    when Prev_Offer_Actual_End_Dt_BOX_SETS between(ORDER_DT_SoD-21) and(ORDER_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
    when Prev_Offer_Actual_End_Dt_BOX_SETS between(ORDER_DT_SoD-28) and(ORDER_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_BOX_SETS between(ORDER_DT_SoD-35) and(ORDER_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_BOX_SETS between(ORDER_DT_SoD-42) and(ORDER_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_BOX_SETS < (ORDER_DT_SoD-42) then 'Offer Ended 7+ Wks'
    else 'No Offer'
    end;
  update #PREMIUMS
    set BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- SKY Kids 
  call Decisioning_Procs.Add_Offers_Software('#PREMIUMS','ORDER_DT_SoD','SKY_KIDS','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_SKY_KIDS','Curr_Offer_Intended_end_Dt_SKY_KIDS');
  update #PREMIUMS
    set SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when Curr_Offer_Intended_end_Dt_SKY_KIDS between(ORDER_DT_SoD+1) and(ORDER_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
    when Curr_Offer_Intended_end_Dt_SKY_KIDS between(ORDER_DT_SoD+8) and(ORDER_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
    when Curr_Offer_Intended_end_Dt_SKY_KIDS between(ORDER_DT_SoD+15) and(ORDER_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
    when Curr_Offer_Intended_end_Dt_SKY_KIDS between(ORDER_DT_SoD+22) and(ORDER_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_SKY_KIDS between(ORDER_DT_SoD+29) and(ORDER_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_SKY_KIDS between(ORDER_DT_SoD+36) and(ORDER_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_SKY_KIDS > (ORDER_DT_SoD+42) then 'Offer Ending in 7+ Wks'
    when Prev_Offer_Actual_End_Dt_SKY_KIDS between(ORDER_DT_SoD-7) and ORDER_DT_SoD then 'Offer Ended in last 1 Wks'
    when Prev_Offer_Actual_End_Dt_SKY_KIDS between(ORDER_DT_SoD-14) and(ORDER_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
    when Prev_Offer_Actual_End_Dt_SKY_KIDS between(ORDER_DT_SoD-21) and(ORDER_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
    when Prev_Offer_Actual_End_Dt_SKY_KIDS between(ORDER_DT_SoD-28) and(ORDER_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_SKY_KIDS between(ORDER_DT_SoD-35) and(ORDER_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_SKY_KIDS between(ORDER_DT_SoD-42) and(ORDER_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_SKY_KIDS < (ORDER_DT_SoD-42) then 'Offer Ended 7+ Wks'
    else 'No Offer'
    end;
  update #PREMIUMS
    set SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- Sky Talk 
  call Decisioning_Procs.Add_Offers_Software('#PREMIUMS','ORDER_DT_SoD','TALK','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_TALK','Curr_Offer_Intended_end_Dt_TALK');
  update #PREMIUMS
    set TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when Curr_Offer_Intended_end_Dt_TALK between(ORDER_DT_SoD+1) and(ORDER_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
    when Curr_Offer_Intended_end_Dt_TALK between(ORDER_DT_SoD+8) and(ORDER_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
    when Curr_Offer_Intended_end_Dt_TALK between(ORDER_DT_SoD+15) and(ORDER_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
    when Curr_Offer_Intended_end_Dt_TALK between(ORDER_DT_SoD+22) and(ORDER_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_TALK between(ORDER_DT_SoD+29) and(ORDER_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_TALK between(ORDER_DT_SoD+36) and(ORDER_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_TALK > (ORDER_DT_SoD+42) then 'Offer Ending in 7+ Wks'
    when Prev_Offer_Actual_End_Dt_TALK between(ORDER_DT_SoD-7) and ORDER_DT_SoD then 'Offer Ended in last 1 Wks'
    when Prev_Offer_Actual_End_Dt_TALK between(ORDER_DT_SoD-14) and(ORDER_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
    when Prev_Offer_Actual_End_Dt_TALK between(ORDER_DT_SoD-21) and(ORDER_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
    when Prev_Offer_Actual_End_Dt_TALK between(ORDER_DT_SoD-28) and(ORDER_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_TALK between(ORDER_DT_SoD-35) and(ORDER_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_TALK between(ORDER_DT_SoD-42) and(ORDER_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_TALK < (ORDER_DT_SoD-42) then 'Offer Ended 7+ Wks'
    else 'No Offer'
    end;
  update #PREMIUMS
    set TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- SPOTIFY 
  call Decisioning_Procs.Add_Offers_Software('#PREMIUMS','ORDER_DT_SoD','SPOTIFY','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_SPOTIFY','Curr_Offer_Intended_end_Dt_SPOTIFY');
  update #PREMIUMS
    set SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when Curr_Offer_Intended_end_Dt_SPOTIFY between(ORDER_DT_SoD+1) and(ORDER_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
    when Curr_Offer_Intended_end_Dt_SPOTIFY between(ORDER_DT_SoD+8) and(ORDER_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
    when Curr_Offer_Intended_end_Dt_SPOTIFY between(ORDER_DT_SoD+15) and(ORDER_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
    when Curr_Offer_Intended_end_Dt_SPOTIFY between(ORDER_DT_SoD+22) and(ORDER_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_SPOTIFY between(ORDER_DT_SoD+29) and(ORDER_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_SPOTIFY between(ORDER_DT_SoD+36) and(ORDER_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
    when Curr_Offer_Intended_end_Dt_SPOTIFY > (ORDER_DT_SoD+42) then 'Offer Ending in 7+ Wks'
    when Prev_Offer_Actual_End_Dt_SPOTIFY between(ORDER_DT_SoD-7) and ORDER_DT_SoD then 'Offer Ended in last 1 Wks'
    when Prev_Offer_Actual_End_Dt_SPOTIFY between(ORDER_DT_SoD-14) and(ORDER_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
    when Prev_Offer_Actual_End_Dt_SPOTIFY between(ORDER_DT_SoD-21) and(ORDER_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
    when Prev_Offer_Actual_End_Dt_SPOTIFY between(ORDER_DT_SoD-28) and(ORDER_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_SPOTIFY between(ORDER_DT_SoD-35) and(ORDER_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_SPOTIFY between(ORDER_DT_SoD-42) and(ORDER_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
    when Prev_Offer_Actual_End_Dt_SPOTIFY < (ORDER_DT_SoD-42) then 'Offer Ended 7+ Wks'
    else 'No Offer'
    end;
  update #PREMIUMS
    set SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  update #PREMIUMS
    set ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when(SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or MS_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or HD_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending') then 'Offer Ending'
    when(SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or MS_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or HD_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer') then 'On Offer'
    else 'No Offer'
    end;
  update #PREMIUMS
    set ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'No Offer' then 'No Offer'
    when ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' then 'Offer Ending in 7+ Wks'
    when ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' then
      (case when(SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks') then 'Offer Ending in Next 1 Wks'
      when(SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks') then 'Offer Ending in Next 2-3 Wks'
      when(SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks') then 'Offer Ending in Next 4-6 Wks'
      when(SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks') then 'Offer Ended in last 1 Wks'
      when(SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks') then 'Offer Ended in last 2-3 Wks'
      when(SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks') then 'Offer Ended in last 4-6 Wks' end)
    end;
  update #PREMIUMS
    set Offer_End_Status_Level_1
     = case when(BASIC_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or BB_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or LR_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or PREMIUM_Offer_End_Status_Level_1 = 'Offer Ending' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending') then 'Offer Ending'
    when(BASIC_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or BB_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or LR_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or PREMIUM_Offer_End_Status_Level_1 = 'On Offer' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer') then 'On Offer'
    else
      'No Offer'
    end;
  update #PREMIUMS
    set Offer_End_Status_Level_2
     = case when Offer_End_Status_Level_1 = 'No Offer' then 'No Offer'
    when Offer_End_Status_Level_1 = 'On Offer' then 'Offer Ending in 7+ Wks'
    when Offer_End_Status_Level_1 = 'Offer Ending' then
      (case when(BASIC_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or BB_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or LR_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or PREMIUM_Offer_End_Status_Level_2 = 'Offer Ending in Next 1 Wks' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks') then 'Offer Ending in Next 1 Wks'
      when(BASIC_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or BB_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or LR_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or PREMIUM_Offer_End_Status_Level_2 = 'Offer Ending in Next 2-3 Wks' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks') then 'Offer Ending in Next 2-3 Wks'
      when(BASIC_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or BB_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or LR_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or PREMIUM_Offer_End_Status_Level_2 = 'Offer Ending in Next 4-6 Wks' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks') then 'Offer Ending in Next 4-6 Wks'
      when(BASIC_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or BB_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or LR_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or PREMIUM_Offer_End_Status_Level_2 = 'Offer Ended in last 1 Wks' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks') then 'Offer Ended in last 1 Wks'
      when(BASIC_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or BB_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or LR_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or PREMIUM_Offer_End_Status_Level_2 = 'Offer Ended in last 2-3 Wks' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks') then 'Offer Ended in last 2-3 Wks'
      when(BASIC_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or BB_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or LR_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or PREMIUM_Offer_End_Status_Level_2 = 'Offer Ended in last 4-6 Wks' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks') then 'Offer Ended in last 4-6 Wks' end)
    end;
  -- end 
  /*
UPDATE #PREMIUMS a
SET a.DTV_ADDED_PRODUCT = CASE WHEN A.FAMILY_ADDED>0 THEN 'FAMILY ADDED'
WHEN A.VARIETY_ADDED>0 THEN 'VARIETY ADDED'
WHEN A.ORIGINAL_ADDED>0 THEN 'ORIGINAL ADDED'
WHEN A.SKYQ_ADDED>0 THEN 'SKYQ_ADDED'
ELSE '' END


FROM #PREMIUMS A ;


UPDATE #PREMIUMS A
SET a.DTV_REMOVED_PRODUCT = CASE WHEN A.FAMILY_REMOVED>0 THEN 'FAMILY REMOVED'
WHEN A.VARIETY_REMOVED>0 THEN 'VARIETY REMOVED'
WHEN A.ORIGINAL_REMOVED>0 THEN 'ORIGINAL REMOVED'
WHEN A.SKYQ_REMOVED>0 THEN 'SKYQ REMOVED'
ELSE '' END
FROM #PREMIUMS A ;
*/
  --------------------------------------------------------------------------------------------------
  ---------Contract Flags Update-------
  --------------------------------------------------------------------------------------------------
  update #PREMIUMS as prem
    set prem.Basic_contract_status_pre_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    prem.Basic_contract_subscription_item_pre_order = ctr.Agreement_Item_Type from
    #PREMIUMS as prem
    left outer join CITEAM.DM_Contracts as ctr
    on prem.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and prem.order_dt-1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Primary DTV' ) ;
  update #PREMIUMS as prem
    set prem.Add_on_contract_status_pre_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    prem.Add_on_contract_subscription_item_pre_order = ctr.Agreement_Item_Type from
    #PREMIUMS as prem
    left outer join CITEAM.DM_Contracts as ctr
    on prem.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and prem.order_dt-1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Secondary DTV','Sky Enhanced Cap Subs' ) ;
  update #PREMIUMS as prem
    set prem.Talk_contract_status_pre_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    prem.Talk_contract_subscription_item_pre_order = ctr.Agreement_Item_Type from
    #PREMIUMS as prem
    left outer join CITEAM.DM_Contracts as ctr
    on prem.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and prem.order_dt-1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Sky Talk' ) ;
  update #PREMIUMS as prem
    set prem.BB_contract_status_pre_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    prem.BB_contract_subscription_item_pre_order = case when ctr.CONTRACT_STATUS in( 'In Contract' ) then ctr.Agreement_Item_Type else null end from
    #PREMIUMS as prem
    left outer join CITEAM.DM_Contracts as ctr
    on prem.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and prem.order_dt-1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Broadband' ) ;
  /*
update #PREMIUMS as prem
set prem.Overall_contract_status_pre_call = CASE 
WHEN Basic_contract_status_pre_call=1 then Basic_contract_status_pre_call
WHEN Talk_contract_status_pre_call=1 then Talk_contract_status_pre_call
WHEN BB_contract_status_pre_call=1 then BB_contract_status_pre_call
WHEN Add_on_contract_status_pre_call=1 then Add_on_contract_status_pre_call
ELSE 0 END,
set prem.Overall_contract_subscription_item_pre_order= CASE 
WHEN Basic_contract_status_pre_call=1 then Basic_contract_subscription_item_pre_call
WHEN Talk_contract_status_pre_call=1 then Talk_contract_subscription_item_pre_call
WHEN BB_contract_status_pre_call=1 then BB_contract_subscription_item_pre_call
WHEN Add_on_contract_status_pre_call=1 then Add_on_contract_subscription_item_pre_call ELSE null END
from #PREMIUMS as prem;
*/
  ----------------new contracts-------------
  update #PREMIUMS as prem
    set prem.Basic_contract_status_post_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    prem.Basic_contract_subscription_item_post_order = ctr.Agreement_Item_Type from
    #PREMIUMS as prem
    left outer join CITEAM.DM_Contracts as ctr
    on prem.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and ctr.Contract_start_date between prem.order_dt and prem.order_dt+30
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Primary DTV' ) ;
  update #PREMIUMS as prem
    set prem.Add_on_contract_status_post_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    prem.Add_on_contract_subscription_item_post_order = ctr.Agreement_Item_Type from
    #PREMIUMS as prem
    left outer join CITEAM.DM_Contracts as ctr
    on prem.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and ctr.Contract_start_date between prem.order_dt and prem.order_dt+30
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Secondary DTV' ) ;
  update #PREMIUMS as prem
    set prem.Add_on_contract_status_post_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    prem.Add_on_contract_subscription_item_post_order = ctr.Agreement_Item_Type from
    #PREMIUMS as prem
    left outer join CITEAM.DM_Contracts as ctr
    on prem.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and ctr.Contract_start_date between prem.order_dt and prem.order_dt+30
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Sky Enhanced Cap Subs' ) and Add_on_contract_status_post_order = 0;
  update #PREMIUMS as prem
    set prem.Talk_contract_status_post_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    prem.Talk_contract_subscription_item_post_order = ctr.Agreement_Item_Type from
    #PREMIUMS as prem
    left outer join CITEAM.DM_Contracts as ctr
    on prem.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and ctr.Contract_start_date between prem.order_dt and prem.order_dt+30
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Sky Talk' ) ;
  update #PREMIUMS as prem
    set prem.BB_contract_status_post_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    prem.BB_contract_subscription_item_post_order = case when ctr.CONTRACT_STATUS in( 'In Contract' ) then ctr.Agreement_Item_Type else null end from
    #PREMIUMS as prem
    left outer join CITEAM.DM_Contracts as ctr
    on prem.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and ctr.Contract_start_date between prem.order_dt and prem.order_dt+30
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Broadband' ) ;
  ---------existing contracts--------------
  update #PREMIUMS as prem
    set prem.Basic_contract_status_post_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    prem.Basic_contract_subscription_item_post_order = ctr.Agreement_Item_Type from
    #PREMIUMS as prem
    left outer join CITEAM.DM_Contracts as ctr
    on prem.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and prem.order_dt between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Primary DTV' ) and Basic_contract_status_post_order = 0;
  update #PREMIUMS as prem
    set prem.Add_on_contract_status_post_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    prem.Add_on_contract_subscription_item_post_order = ctr.Agreement_Item_Type from
    #PREMIUMS as prem
    left outer join CITEAM.DM_Contracts as ctr
    on prem.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and prem.order_dt between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Secondary DTV' ) and Basic_contract_status_post_order = 0;
  update #PREMIUMS as prem
    set prem.Add_on_contract_status_post_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    prem.Add_on_contract_subscription_item_post_order = ctr.Agreement_Item_Type from
    #PREMIUMS as prem
    left outer join CITEAM.DM_Contracts as ctr
    on prem.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and prem.order_dt between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Sky Enhanced Cap Subs' ) and Basic_contract_status_post_order = 0;
  update #PREMIUMS as prem
    set prem.Talk_contract_status_post_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    prem.Talk_contract_subscription_item_post_order = ctr.Agreement_Item_Type from
    #PREMIUMS as prem
    left outer join CITEAM.DM_Contracts as ctr
    on prem.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and prem.order_dt between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Sky Talk' ) and Basic_contract_status_post_order = 0;
  update #PREMIUMS as prem
    set prem.BB_contract_status_post_order = case when ctr.contract_status in( 'In Contract' ) then 1 else 0 end,
    prem.BB_contract_subscription_item_post_order = case when ctr.CONTRACT_STATUS in( 'In Contract' ) then ctr.Agreement_Item_Type else null end from
    #PREMIUMS as prem
    left outer join CITEAM.DM_Contracts as ctr
    on prem.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and prem.order_dt between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Broadband' ) and Basic_contract_status_post_order = 0;
  /*
update #PREMIUMS as prem
set prem.Overall_contract_status_post_call = CASE 
WHEN Basic_contract_status_post_call=1 then Basic_contract_status_post_call
WHEN Talk_contract_status_post_call=1 then Talk_contract_status_post_call
WHEN BB_contract_status_post_call=1 then BB_contract_status_post_call
WHEN Add_on_contract_status_post_call=1 then Add_on_contract_status_post_call
ELSE 0 END,
set prem.Overall_contract_subscription_item_pre_order= CASE 
WHEN Basic_contract_status_post_call=1 then Basic_contract_subscription_item_post_call
WHEN Talk_contract_status_post_call=1 then Talk_contract_subscription_item_post_call
WHEN BB_contract_status_post_call=1 then BB_contract_subscription_item_post_call
WHEN Add_on_contract_status_post_call=1 then Add_on_contract_subscription_item_post_call ELSE null END
from #PREMIUMS as prem;
*/
  ----------------
  -------------------------
  select account_number,subscription_id,subscription_type,cast(start_date_new as date) as status_start_date,cast(end_date_new as date) as status_end_date,Contract_status
    into #Contracts
    from(select account_number,subscription_id,subscription_type,actual_contract_end_date+1 as start_date_new,coalesce((lead(start_date) over(order by account_number asc,subscription_id asc,start_date asc)-1),'9999-09-09') as end_date_new,'Out Of Contract' as contract_status from decisioning.contracts union all
      select account_number,subscription_id,subscription_type,(max(actual_contract_end_date)+1) as start_date_new,'9999-09-09' as end_date_new,'Out Of Contract' as contract_status from decisioning.contracts group by account_number,subscription_id,subscription_type union all
      select account_number,subscription_id,subscription_type,start_date as start_date_new,actual_contract_end_date as end_Date_new,'In Contract' as contract_status from decisioning.contracts) as a
    where start_date_new <= end_date_new;
  update #PREMIUMS as base
    set base.Basic_Contract_Status_Level_2 = case when ctr.contract_status = 'In Contract' then
      case when ctr.status_end_date between ORDER_DT and(ORDER_DT+7) then 'Contract Ending in Next 1 Wks'
      when ctr.status_end_date between(ORDER_DT+8) and(ORDER_DT+14) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(ORDER_DT+15) and(ORDER_DT+21) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(ORDER_DT+22) and(ORDER_DT+28) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+29) and(ORDER_DT+35) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+36) and(ORDER_DT+42) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+43) and(ORDER_DT+49) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date between(ORDER_DT+50) and(ORDER_DT+56) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date > (ORDER_DT+56) then 'Contract Ending in 8+ Wks'
      else 'No Contract'
      end when ctr.contract_status = 'Out Of Contract' then
      case when ctr.status_start_date-1 between(ORDER_DT-7) and(ORDER_DT-1) then 'Contract Ended in last 1 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-14) and(ORDER_DT-8) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-21) and(ORDER_DT-15) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-28) and(ORDER_DT-22) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-35) and(ORDER_DT-29) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-42) and(ORDER_DT-36) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT+43) and(ORDER_DT+49) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 between(ORDER_DT+50) and(ORDER_DT+56) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 < (ORDER_DT-56) then
        'No Contract' else 'No Contract' end
    else 'No Contract'
    end from
    #PREMIUMS as base
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    and base.ORDER_DT-1 between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and subscription_type in( 'Primary DTV' ) ;
  update #PREMIUMS as base
    set base.Add_on_Products_Contract_Status_Level_2_DTV_Extra_Subscription = case when ctr.contract_status = 'In Contract' then
      case when ctr.status_end_date between(ORDER_DT) and(ORDER_DT+7) then 'Contract Ending in Next 1 Wks'
      when ctr.status_end_date between(ORDER_DT+8) and(ORDER_DT+14) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(ORDER_DT+15) and(ORDER_DT+21) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(ORDER_DT+22) and(ORDER_DT+28) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+29) and(ORDER_DT+35) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+36) and(ORDER_DT+42) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+43) and(ORDER_DT+49) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date between(ORDER_DT+50) and(ORDER_DT+56) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date > (ORDER_DT+56) then 'Contract Ending in 8+ Wks'
      else 'No Contract'
      end when ctr.contract_status = 'Out Of Contract' then
      case when ctr.status_start_date-1 between(ORDER_DT-7) and(ORDER_DT-1) then 'Contract Ended in last 1 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-14) and(ORDER_DT-8) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-21) and(ORDER_DT-15) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-28) and(ORDER_DT-22) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-35) and(ORDER_DT-29) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-42) and(ORDER_DT-36) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT+43) and(ORDER_DT+49) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 between(ORDER_DT+50) and(ORDER_DT+56) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 < (ORDER_DT-56) then --then 'Contract Ended 8+ Wks'
        'No Contract' else 'No Contract' end
    else 'No Contract'
    end from
    #PREMIUMS as base
    left outer join cust_subs_hist as csh on base.account_number = csh.account_number and base.ORDER_DT between csh.effective_from_dt and csh.effective_to_dt and csh.status_code in( 'AC','AB','PC' ) 
    and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD' and csh.subscription_type in( 'DTV PACKAGE' ) and csh.subscription_sub_type = 'DTV Extra Subscription'
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.ORDER_DT between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and ctr.subscription_type in( 'Secondary DTV' ) and csh.subscription_type in( 'DTV PACKAGE' ) 
    and csh.subscription_sub_type = 'DTV Extra Subscription' and csh.status_code in( 'AC','AB','PC' ) and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD' and csh.subscription_id = ctr.subscription_id;
  update #PREMIUMS as base
    set base.Add_on_Products_Contract_Status_Level_2_DTV_Sky_plus
     = case when ctr.contract_status = 'In Contract' then
      case when ctr.status_end_date between(ORDER_DT) and(ORDER_DT+7) then 'Contract Ending in Next 1 Wks'
      when ctr.status_end_date between(ORDER_DT+8) and(ORDER_DT+14) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(ORDER_DT+15) and(ORDER_DT+21) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(ORDER_DT+22) and(ORDER_DT+28) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+29) and(ORDER_DT+35) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+36) and(ORDER_DT+42) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+43) and(ORDER_DT+49) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date between(ORDER_DT+50) and(ORDER_DT+56) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date > (ORDER_DT+56) then 'Contract Ending in 8+ Wks'
      else 'No Contract'
      end when ctr.contract_status = 'Out Of Contract' then
      case when ctr.status_start_date-1 between(ORDER_DT-7) and(ORDER_DT-1) then 'Contract Ended in last 1 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-14) and(ORDER_DT-8) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-21) and(ORDER_DT-15) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-28) and(ORDER_DT-22) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-35) and(ORDER_DT-29) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-42) and(ORDER_DT-36) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT+43) and(ORDER_DT+49) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 between(ORDER_DT+50) and(ORDER_DT+56) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 < (ORDER_DT-56) then --then 'Contract Ended 8+ Wks'
        'No Contract' else 'No Contract' end
    else 'No Contract'
    end from
    #PREMIUMS as base
    left outer join cust_subs_hist as csh on base.account_number = csh.account_number and base.ORDER_DT between csh.effective_from_dt and csh.effective_to_dt and csh.status_code in( 'AC','AB','PC' ) 
    and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD' and csh.subscription_type in( 'ENHANCED' ) and csh.subscription_sub_type = 'DTV Sky+'
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.ORDER_DT between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and ctr.subscription_type in( 'Sky Enhanced Cap Subs' ) and csh.subscription_type in( 'ENHANCED' ) 
    and csh.subscription_sub_type = 'DTV Sky+' and csh.status_code in( 'AC','AB','PC' ) and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD'
    and(base.Add_on_Products_Contract_Status_Level_2 = 'No Contract' or base.Add_on_Products_Contract_Status_Level_2 is null) and csh.subscription_id = ctr.subscription_id;
  update #PREMIUMS as base
    set base.Add_on_Products_Contract_Status_Level_2_DTV_HD = case when ctr.contract_status = 'In Contract' then
      case when ctr.status_end_date between(ORDER_DT) and(ORDER_DT+7) then 'Contract Ending in Next 1 Wks'
      when ctr.status_end_date between(ORDER_DT+8) and(ORDER_DT+14) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(ORDER_DT+15) and(ORDER_DT+21) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(ORDER_DT+22) and(ORDER_DT+28) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+29) and(ORDER_DT+35) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+36) and(ORDER_DT+42) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+43) and(ORDER_DT+49) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date between(ORDER_DT+50) and(ORDER_DT+56) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date > (ORDER_DT+56) then 'Contract Ending in 8+ Wks'
      else 'No Contract'
      end when ctr.contract_status = 'Out Of Contract' then
      case when ctr.status_start_date-1 between(ORDER_DT-7) and(ORDER_DT-1) then 'Contract Ended in last 1 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-14) and(ORDER_DT-8) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-21) and(ORDER_DT-15) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-28) and(ORDER_DT-22) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-35) and(ORDER_DT-29) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-42) and(ORDER_DT-36) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT+43) and(ORDER_DT+49) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 between(ORDER_DT+50) and(ORDER_DT+56) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 < (ORDER_DT-56) then --then 'Contract Ended 8+ Wks'
        'No Contract' else 'No Contract' end
    else 'No Contract'
    end from
    #PREMIUMS as base
    left outer join cust_subs_hist as csh on base.account_number = csh.account_number and base.ORDER_DT between csh.effective_from_dt and csh.effective_to_dt and csh.status_code in( 'AC','AB','PC' ) 
    and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD' and csh.subscription_type in( 'ENHANCED' ) and csh.subscription_sub_type = 'DTV HD'
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.ORDER_DT between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and ctr.subscription_type in( 'Sky Enhanced Cap Subs' ) and csh.subscription_type in( 'ENHANCED' ) 
    and csh.subscription_sub_type = 'DTV HD' and csh.status_code in( 'AC','AB','PC' ) and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD'
    and(base.Add_on_Products_Contract_Status_Level_2 = 'No Contract' or base.Add_on_Products_Contract_Status_Level_2 is null) and csh.subscription_id = ctr.subscription_id;
  update #PREMIUMS as base
    set base.Add_on_Products_Contract_Status_Level_2_MS_plus = case when ctr.contract_status = 'In Contract' then
      case when ctr.status_end_date between(ORDER_DT) and(ORDER_DT+7) then 'Contract Ending in Next 1 Wks'
      when ctr.status_end_date between(ORDER_DT+8) and(ORDER_DT+14) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(ORDER_DT+15) and(ORDER_DT+21) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(ORDER_DT+22) and(ORDER_DT+28) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+29) and(ORDER_DT+35) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+36) and(ORDER_DT+42) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+43) and(ORDER_DT+49) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date between(ORDER_DT+50) and(ORDER_DT+56) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date > (ORDER_DT+56) then 'Contract Ending in 8+ Wks'
      else 'No Contract'
      end when ctr.contract_status = 'Out Of Contract' then
      case when ctr.status_start_date-1 between(ORDER_DT-7) and(ORDER_DT-1) then 'Contract Ended in last 1 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-14) and(ORDER_DT-8) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-21) and(ORDER_DT-15) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-28) and(ORDER_DT-22) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-35) and(ORDER_DT-29) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-42) and(ORDER_DT-36) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT+43) and(ORDER_DT+49) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 between(ORDER_DT+50) and(ORDER_DT+56) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 < (ORDER_DT-56) then --then 'Contract Ended 8+ Wks'
        'No Contract' else 'No Contract' end
    else 'No Contract'
    end from
    #PREMIUMS as base
    left outer join cust_subs_hist as csh on base.account_number = csh.account_number and base.ORDER_DT between csh.effective_from_dt and csh.effective_to_dt and csh.status_code in( 'AC','AB','PC' ) 
    and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD' and csh.subscription_type in( 'ENHANCED' ) and csh.subscription_sub_type = 'MS+'
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.ORDER_DT between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and ctr.subscription_type in( 'Sky Enhanced Cap Subs' ) and csh.subscription_type in( 'ENHANCED' ) 
    and csh.subscription_sub_type = 'MS+' and csh.status_code in( 'AC','AB','PC' ) and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD'
    and(base.Add_on_Products_Contract_Status_Level_2 = 'No Contract' or base.Add_on_Products_Contract_Status_Level_2 is null) and csh.subscription_id = ctr.subscription_id;
  update #PREMIUMS as base
    set base.Add_on_Products_Contract_Status_Level_2_SKY_BOX_SETS = case when ctr.contract_status = 'In Contract' then
      case when ctr.status_end_date between(ORDER_DT) and(ORDER_DT+7) then 'Contract Ending in Next 1 Wks'
      when ctr.status_end_date between(ORDER_DT+8) and(ORDER_DT+14) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(ORDER_DT+15) and(ORDER_DT+21) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(ORDER_DT+22) and(ORDER_DT+28) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+29) and(ORDER_DT+35) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+36) and(ORDER_DT+42) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+43) and(ORDER_DT+49) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date between(ORDER_DT+50) and(ORDER_DT+56) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date > (ORDER_DT+56) then 'Contract Ending in 8+ Wks'
      else 'No Contract'
      end when ctr.contract_status = 'Out Of Contract' then
      case when ctr.status_start_date-1 between(ORDER_DT-7) and(ORDER_DT-1) then 'Contract Ended in last 1 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-14) and(ORDER_DT-8) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-21) and(ORDER_DT-15) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-28) and(ORDER_DT-22) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-35) and(ORDER_DT-29) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-42) and(ORDER_DT-36) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT+43) and(ORDER_DT+49) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 between(ORDER_DT+50) and(ORDER_DT+56) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 < (ORDER_DT-56) then --then 'Contract Ended 8+ Wks'
        'No Contract' else 'No Contract' end
    else 'No Contract'
    end from
    #PREMIUMS as base
    left outer join cust_subs_hist as csh on base.account_number = csh.account_number and base.ORDER_DT between csh.effective_from_dt and csh.effective_to_dt and csh.status_code in( 'AC','AB','PC' ) 
    and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD' and csh.subscription_type in( 'ENHANCED' ) and csh.subscription_sub_type = 'SKY_BOX_SETS'
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.ORDER_DT between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and ctr.subscription_type in( 'Sky Enhanced Cap Subs' ) and csh.subscription_type in( 'ENHANCED' ) 
    and csh.subscription_sub_type = 'SKY_BOX_SETS' and csh.status_code in( 'AC','AB','PC' ) and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD'
    and(base.Add_on_Products_Contract_Status_Level_2 = 'No Contract' or base.Add_on_Products_Contract_Status_Level_2 is null) and csh.subscription_id = ctr.subscription_id;
  update #PREMIUMS as base
    set base.Add_on_Products_Contract_Status_Level_2
     = case when Add_on_Products_Contract_Status_Level_2_DTV_Extra_Subscription in( 'Contract Ending in 8+ Wks' ) then Add_on_Products_Contract_Status_Level_2_DTV_Extra_Subscription
    when Add_on_Products_Contract_Status_Level_2_DTV_Sky_plus in( 'Contract Ending in 8+ Wks' ) then Add_on_Products_Contract_Status_Level_2_DTV_Sky_plus
    when Add_on_Products_Contract_Status_Level_2_DTV_HD in( 'Contract Ending in 8+ Wks' ) then Add_on_Products_Contract_Status_Level_2_DTV_HD
    when Add_on_Products_Contract_Status_Level_2_MS_plus in( 'Contract Ending in 8+ Wks' ) then Add_on_Products_Contract_Status_Level_2_MS_plus
    when Add_on_Products_Contract_Status_Level_2_SKY_BOX_SETS in( 'Contract Ending in 8+ Wks' ) then Add_on_Products_Contract_Status_Level_2_SKY_BOX_SETS
    when Add_on_Products_Contract_Status_Level_2_DTV_Extra_Subscription in( 'Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
    'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks' ) then Add_on_Products_Contract_Status_Level_2_DTV_Extra_Subscription
    when Add_on_Products_Contract_Status_Level_2_DTV_Sky_plus in( 'Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
    'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks' ) then Add_on_Products_Contract_Status_Level_2_DTV_Sky_plus
    when Add_on_Products_Contract_Status_Level_2_DTV_HD in( 'Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
    'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks' ) then Add_on_Products_Contract_Status_Level_2_DTV_HD
    when Add_on_Products_Contract_Status_Level_2_MS_plus in( 'Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
    'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks' ) then Add_on_Products_Contract_Status_Level_2_MS_plus
    when Add_on_Products_Contract_Status_Level_2_SKY_BOX_SETS in( 'Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
    'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks' ) then Add_on_Products_Contract_Status_Level_2_SKY_BOX_SETS
    else 'No Contract'
    end from #PREMIUMS as base;
  update #PREMIUMS as base
    set base.Talk_Contract_Status_Level_2 = case when ctr.contract_status = 'In Contract' then
      case when ctr.status_end_date between ORDER_DT and(ORDER_DT+7) then 'Contract Ending in Next 1 Wks'
      when ctr.status_end_date between(ORDER_DT+8) and(ORDER_DT+14) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(ORDER_DT+15) and(ORDER_DT+21) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(ORDER_DT+22) and(ORDER_DT+28) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+29) and(ORDER_DT+35) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+36) and(ORDER_DT+42) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+43) and(ORDER_DT+49) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date between(ORDER_DT+50) and(ORDER_DT+56) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date > (ORDER_DT+56) then 'Contract Ending in 8+ Wks'
      else 'No Contract'
      end when ctr.contract_status = 'Out Of Contract' then
      case when ctr.status_start_date-1 between(ORDER_DT-7) and(ORDER_DT-1) then 'Contract Ended in last 1 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-14) and(ORDER_DT-8) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-21) and(ORDER_DT-15) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-28) and(ORDER_DT-22) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-35) and(ORDER_DT-29) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-42) and(ORDER_DT-36) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT+43) and(ORDER_DT+49) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 between(ORDER_DT+50) and(ORDER_DT+56) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 < (ORDER_DT-56) then
        'No Contract' else 'No Contract' end
    else 'No Contract'
    end from
    #PREMIUMS as base
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    and base.ORDER_DT-1 between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and subscription_type in( 'Sky Talk' ) ;
  update #PREMIUMS as base
    set base.BB_Contract_Status_Level_2 = case when ctr.contract_status = 'In Contract' then
      case when ctr.status_end_date between ORDER_DT and(ORDER_DT+7) then 'Contract Ending in Next 1 Wks'
      when ctr.status_end_date between(ORDER_DT+8) and(ORDER_DT+14) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(ORDER_DT+15) and(ORDER_DT+21) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(ORDER_DT+22) and(ORDER_DT+28) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+29) and(ORDER_DT+35) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+36) and(ORDER_DT+42) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(ORDER_DT+43) and(ORDER_DT+49) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date between(ORDER_DT+50) and(ORDER_DT+56) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date > (ORDER_DT+56) then 'Contract Ending in 8+ Wks'
      else 'No Contract'
      end when ctr.contract_status = 'Out Of Contract' then
      case when ctr.status_start_date-1 between(ORDER_DT-7) and(ORDER_DT-1) then 'Contract Ended in last 1 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-14) and(ORDER_DT-8) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-21) and(ORDER_DT-15) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-28) and(ORDER_DT-22) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-35) and(ORDER_DT-29) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT-42) and(ORDER_DT-36) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(ORDER_DT+43) and(ORDER_DT+49) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 between(ORDER_DT+50) and(ORDER_DT+56) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 < (ORDER_DT-56) then
        'No Contract' else 'No Contract' end
    else 'No Contract'
    end from
    #PREMIUMS as base
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    and base.order_dt-1 between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and subscription_type in( 'Broadband' ) ;
  update #PREMIUMS as base
    set base.Overall_Contract_Status_Level_2
     = case when base.Basic_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then base.Basic_Contract_Status_Level_2
    when base.BB_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then base.BB_Contract_Status_Level_2
    when base.Add_on_Products_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then base.Add_on_Products_Contract_Status_Level_2
    when base.Talk_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then base.Talk_Contract_Status_Level_2
    when(base.Basic_Contract_Status_Level_2 <> 'No Contract' or base.Basic_Contract_Status_Level_2 is not null) then base.Basic_Contract_Status_Level_2
    when(base.BB_Contract_Status_Level_2 <> 'No Contract' or base.BB_Contract_Status_Level_2 is not null) then base.BB_Contract_Status_Level_2
    when(base.Add_on_Products_Contract_Status_Level_2 <> 'No Contract' or base.Add_on_Products_Contract_Status_Level_2 is not null) then base.Add_on_Products_Contract_Status_Level_2
    when(base.Talk_Contract_Status_Level_2 <> 'No Contract' or base.Talk_Contract_Status_Level_2 is not null) then base.Talk_Contract_Status_Level_2
    else 'No Contract'
    end;
  update #PREMIUMS
    set BB_Contract_Status_Level_1
     = case when BB_Contract_Status_Level_2 in( 'Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
    'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks' ) then
      'Contract End'
    when BB_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then
      'In-Contract'
    else 'No Contract'
    end;
  update #PREMIUMS
    set Talk_Contract_Status_Level_1
     = case when Talk_Contract_Status_Level_2 in( 'Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
    'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks' ) then
      'Contract End'
    when Talk_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then
      'In-Contract'
    else 'No Contract'
    end;
  update #PREMIUMS
    set Add_on_Products_Contract_Status_Level_1
     = case when Add_on_Products_Contract_Status_Level_2 in( 'Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
    'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks' ) then
      'Contract End'
    when Add_on_Products_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then
      'In-Contract'
    else 'No Contract'
    end;
  update #PREMIUMS
    set Basic_Contract_Status_Level_1
     = case when Basic_Contract_Status_Level_2 in( 'Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
    'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks' ) then
      'Contract End'
    when Basic_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then
      'In-Contract'
    else 'No Contract'
    end;
  update #PREMIUMS
    set Overall_Contract_Status_Level_1
     = case when Overall_Contract_Status_Level_2 in( 'Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
    'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks' ) then
      'Contract End'
    when Overall_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then
      'In-Contract'
    else 'No Contract'
    end;
  --------------------------
  /*---
UPDATE #PREMIUMS AS A
SET A.Basic_contract_status_post_order= CASE WHEN D.CONTRACT_STATUS IN ('In Contract') THEN 1 ELSE 0 END,
A.Basic_contract_subscription_item_post_order= CASE WHEN D.CONTRACT_STATUS IN ('In Contract') THEN D.Agreement_Item_Type ELSE NULL END
FROM #PREMIUMS A
LEFT JOIN
(SELECT ACCOUNT_NUMBER,ORDER_ID,subscription_id,EFFECTIVE_FROM_DT
FROM cust_subs_hist B

WHERE B.subscription_sub_type IN ('DTV Primary Viewing')
AND B.effective_from_dt < B.effective_to_dt
AND B.owning_cust_account_id > '1'
AND B.SI_Latest_Src = 'CHORD'
AND B.STATUS_CODE IN ('AC','AB','PC') 
--AND B.STATUS_CODE_CHANGED = 'Y'
AND effective_to_dt>='2012-01-01') B 
ON A.ACCOUNT_NUMBER=B.ACCOUNT_NUMBER
AND A.ORDER_ID = B.ORDER_ID 
AND B.EFFECTIVE_FROM_DT BETWEEN A.ORDER_DT AND A.ORDER_DT+30
LEFT JOIN CITEAM.dm_contracts D 
ON A.ACCOUNT_NUMBER=D.ACCOUNT_NUMBER 
AND B.subscription_id = D.subscription_id
AND D.CONTRACT_START_DATE between A.order_dt and B.effective_from_dt
WHERE A.DTV_ADDED_PRODUCT IS NOT NULL AND D.CONTRACT_STATUS IN ('In Contract');

UPDATE #PREMIUMS AS A
SET A.Basic_contract_status_post_order= CASE
WHEN D.CONTRACT_STATUS IN ('In Contract') THEN 1
ELSE 0
END,
A.Basic_contract_subscription_item_post_order=CASE WHEN D.CONTRACT_STATUS IN ('In Contract') THEN D.Agreement_Item_Type ELSE NULL END
FROM #PREMIUMS AS A
LEFT JOIN CITeam.Orders_Detail C ON A.Account_Number = C.Account_Number AND A.Order_Dt = C.Order_Dt
LEFT JOIN
(SELECT ACCOUNT_NUMBER,ORDER_ID,subscription_id,EFFECTIVE_FROM_DT
FROM cust_subs_hist B

WHERE B.subscription_sub_type IN ('DTV Primary Viewing')
AND B.effective_from_dt < B.effective_to_dt
AND B.owning_cust_account_id > '1'
AND B.SI_Latest_Src = 'CHORD'
AND B.STATUS_CODE IN ('AC','AB','PC') 
--AND B.STATUS_CODE_CHANGED = 'Y'
AND effective_to_dt>='2012-01-01') B 
ON A.ACCOUNT_NUMBER=B.ACCOUNT_NUMBER
AND C.ORDER_ID = B.ORDER_ID 
AND B.EFFECTIVE_FROM_DT BETWEEN A.ORDER_DT AND A.ORDER_DT+30
LEFT JOIN CITEAM.dm_contracts D 
ON A.ACCOUNT_NUMBER=D.ACCOUNT_NUMBER 
AND B.subscription_id = D.subscription_id
AND D.CONTRACT_START_DATE between A.order_dt and B.effective_from_dt
WHERE A.DTV_ADDED_PRODUCT IS NOT NULL AND D.CONTRACT_STATUS IN ('In Contract') and A.Basic_contract_status_post_order <>1;

update #PREMIUMS prem
set prem.Basic_contract_status_post_order = CASE WHEN ctr.contract_status in ('In Contract') THEN 1 ELSE 0 END,
prem.Basic_contract_subscription_item_post_order=CASE WHEN ctr.CONTRACT_STATUS IN ('In Contract') THEN ctr.Agreement_Item_Type ELSE NULL END 
from #PREMIUMS prem
left join CITEAM.DM_Contracts ctr
on prem.account_number =ctr.account_number 
--and base.subscription_id = ctr.subscription_id
and prem.order_dt+1 between ctr.Contract_start_date and ctr.actual_contract_end_date  
where ctr.contract_status in ('In Contract')and ctr.subscription_type in('Primary DTV') and prem.Basic_contract_status_post_order <>1;

---
UPDATE #PREMIUMS AS A
SET A.BB_contract_status_post_order= CASE
WHEN D.CONTRACT_STATUS IN ('In Contract') THEN 1
ELSE 0
END,
A.BB_contract_subscription_item_post_order= CASE WHEN D.CONTRACT_STATUS IN ('In Contract') THEN D.Agreement_Item_Type ELSE NULL END
FROM #PREMIUMS A
LEFT JOIN
(SELECT ACCOUNT_NUMBER,ORDER_ID,subscription_id,EFFECTIVE_FROM_DT
FROM cust_subs_hist B

WHERE B.subscription_sub_type IN ('Broadband DSL Line')
AND B.effective_from_dt < B.effective_to_dt
AND B.owning_cust_account_id > '1'
AND B.SI_Latest_Src = 'CHORD'
AND B.STATUS_CODE IN ('AC','AB','PC') 
--AND B.STATUS_CODE_CHANGED = 'Y'
AND effective_to_dt>='2012-01-01') B 
ON A.ACCOUNT_NUMBER=B.ACCOUNT_NUMBER
AND A.ORDER_ID = B.ORDER_ID 
AND B.EFFECTIVE_FROM_DT BETWEEN A.ORDER_DT AND A.ORDER_DT+30
LEFT JOIN CITEAM.dm_contracts D 
ON A.ACCOUNT_NUMBER=D.ACCOUNT_NUMBER 
AND B.subscription_id = D.subscription_id
AND D.CONTRACT_START_DATE between A.order_dt and B.effective_from_dt
WHERE A.BB_ADDED_PRODUCT IS NOT NULL AND D.CONTRACT_STATUS IN ('In Contract');

UPDATE #PREMIUMS A
SET A.BB_contract_status_post_order= CASE
WHEN D.CONTRACT_STATUS IN ('In Contract') THEN 1
ELSE 0
END,
A.BB_contract_subscription_item_post_order=CASE WHEN D.CONTRACT_STATUS IN ('In Contract') THEN D.Agreement_Item_Type ELSE NULL END
FROM #PREMIUMS A
LEFT JOIN CITeam.Orders_Detail C ON A.Account_Number = C.Account_Number AND A.Order_Dt = C.Order_Dt
LEFT JOIN
(SELECT ACCOUNT_NUMBER,ORDER_ID,subscription_id,EFFECTIVE_FROM_DT
FROM cust_subs_hist B

WHERE B.subscription_sub_type IN ('Broadband DSL Line')
AND B.effective_from_dt < B.effective_to_dt
AND B.owning_cust_account_id > '1'
AND B.SI_Latest_Src = 'CHORD'
AND B.STATUS_CODE IN ('AC','AB','PC') 
--AND B.STATUS_CODE_CHANGED = 'Y'
AND effective_to_dt>='2012-01-01') B 
ON A.ACCOUNT_NUMBER=B.ACCOUNT_NUMBER
AND C.ORDER_ID = B.ORDER_ID 
AND B.EFFECTIVE_FROM_DT BETWEEN A.ORDER_DT AND A.ORDER_DT+30
LEFT JOIN CITEAM.dm_contracts D 
ON A.ACCOUNT_NUMBER=D.ACCOUNT_NUMBER 
AND B.subscription_id = D.subscription_id
AND D.CONTRACT_START_DATE between A.order_dt and B.effective_from_dt
WHERE A.BB_ADDED_PRODUCT IS NOT NULL AND D.CONTRACT_STATUS IN ('In Contract') and A.BB_contract_status_post_order <>1;

update #PREMIUMS prem
set prem.BB_contract_status_post_order = CASE WHEN ctr.contract_status in ('In Contract') THEN 1 ELSE 0 END,
prem.BB_contract_subscription_item_post_order=CASE WHEN ctr.CONTRACT_STATUS IN ('In Contract') THEN ctr.Agreement_Item_Type ELSE NULL END 
from #PREMIUMS prem
left join CITEAM.DM_Contracts ctr
on prem.account_number =ctr.account_number 
--and base.subscription_id = ctr.subscription_id
and prem.order_dt+1 between ctr.Contract_start_date and ctr.actual_contract_end_date  
where ctr.contract_status in ('In Contract')and ctr.subscription_type in('Broadband') and prem.BB_contract_status_post_order <>1;


--
UPDATE #PREMIUMS AS A
SET A.Talk_contract_status_post_order= CASE
WHEN D.CONTRACT_STATUS IN ('In Contract') THEN 1
ELSE 0
END,
A.Talk_contract_subscription_item_post_order=CASE WHEN D.CONTRACT_STATUS IN ('In Contract') THEN D.Agreement_Item_Type ELSE NULL END
FROM #PREMIUMS A
LEFT JOIN
(SELECT ACCOUNT_NUMBER,ORDER_ID,subscription_id,EFFECTIVE_FROM_DT
FROM cust_subs_hist B

WHERE B.subscription_type IN ('SKY TALK')
AND B.effective_from_dt < B.effective_to_dt
AND B.owning_cust_account_id > '1'
AND B.SI_Latest_Src = 'CHORD'
AND B.STATUS_CODE IN ('AC','AB','PC') 
--AND B.STATUS_CODE_CHANGED = 'Y'
AND effective_to_dt>='2012-01-01') B 
ON A.ACCOUNT_NUMBER=B.ACCOUNT_NUMBER
AND A.ORDER_ID = B.ORDER_ID 
AND B.EFFECTIVE_FROM_DT BETWEEN A.ORDER_DT AND A.ORDER_DT+30
LEFT JOIN CITEAM.dm_contracts D 
ON A.ACCOUNT_NUMBER=D.ACCOUNT_NUMBER 
AND B.subscription_id = D.subscription_id
AND D.CONTRACT_START_DATE between A.order_dt and B.effective_from_dt
WHERE (A.TALKU_ADDED + A.TALKW_ADDED + A.TALKF_ADDED + A.TALKA_ADDED +A.TALKP_ADDED + A.TALKO_ADDED)>=1 AND D.CONTRACT_STATUS IN ('In Contract');

UPDATE #PREMIUMS A
SET A.Talk_contract_status_post_order= CASE
WHEN D.CONTRACT_STATUS IN ('In Contract') THEN 1
ELSE 0
END,
A.Talk_contract_subscription_item_post_order=CASE WHEN D.CONTRACT_STATUS IN ('In Contract') THEN D.Agreement_Item_Type ELSE NULL END
FROM #PREMIUMS A
LEFT JOIN CITeam.Orders_Detail C ON A.Account_Number = C.Account_Number AND A.Order_Dt = C.Order_Dt
LEFT JOIN
(SELECT ACCOUNT_NUMBER,ORDER_ID,subscription_id,EFFECTIVE_FROM_DT
FROM cust_subs_hist B

WHERE B.subscription_type IN ('SKY TALK')
AND B.effective_from_dt < B.effective_to_dt
AND B.owning_cust_account_id > '1'
AND B.SI_Latest_Src = 'CHORD'
AND B.STATUS_CODE IN ('AC','AB','PC') 
--AND B.STATUS_CODE_CHANGED = 'Y'
AND effective_to_dt>='2012-01-01') B 
ON A.ACCOUNT_NUMBER=B.ACCOUNT_NUMBER
AND C.ORDER_ID = B.ORDER_ID 
AND B.EFFECTIVE_FROM_DT BETWEEN A.ORDER_DT AND A.ORDER_DT+30
LEFT JOIN CITEAM.dm_contracts D 
ON A.ACCOUNT_NUMBER=D.ACCOUNT_NUMBER 
AND B.subscription_id = D.subscription_id
AND D.CONTRACT_START_DATE between A.order_dt and B.effective_from_dt
WHERE (A.TALKU_ADDED + A.TALKW_ADDED + A.TALKF_ADDED + A.TALKA_ADDED +A.TALKP_ADDED + A.TALKO_ADDED)>=1 AND D.CONTRACT_STATUS IN ('In Contract') and A.Talk_contract_status_post_order<>1;

update #PREMIUMS prem
set prem.Talk_contract_status_post_order = CASE WHEN ctr.contract_status in ('In Contract') THEN 1 ELSE 0 END,
prem.Talk_contract_subscription_item_post_order=CASE WHEN ctr.CONTRACT_STATUS IN ('In Contract') THEN ctr.Agreement_Item_Type ELSE NULL END 
from #PREMIUMS prem
left join CITEAM.DM_Contracts ctr
on prem.account_number =ctr.account_number 
--and base.subscription_id = ctr.subscription_id
and prem.order_dt+1 between ctr.Contract_start_date and ctr.actual_contract_end_date  
where ctr.contract_status in ('In Contract')and subscription_type in('Sky Talk') and prem.Talk_contract_status_post_order<>1 ;

---
UPDATE #PREMIUMS AS A
SET A.Add_on_contract_status_post_order= CASE
WHEN D.CONTRACT_STATUS IN ('In Contract') THEN 1
ELSE 0
END,
A.Add_on_contract_subscription_item_post_order=CASE WHEN D.CONTRACT_STATUS IN ('In Contract') THEN D.Agreement_Item_Type ELSE NULL END
FROM #PREMIUMS A
LEFT JOIN
(SELECT ACCOUNT_NUMBER,ORDER_ID,subscription_id,EFFECTIVE_FROM_DT
FROM cust_subs_hist B

WHERE B.subscription_sub_type IN ('DTV HD','DTV Extra Subscription','Sky Go Extra','HD Pack','MS+','SKY_KIDS','SKY_BOX_SETS','KIDS_PACK','FREESAT','DTV_HD_EXTN')
AND B.effective_from_dt < B.effective_to_dt
AND B.owning_cust_account_id > '1'
AND B.SI_Latest_Src = 'CHORD'
AND B.STATUS_CODE IN ('AC','AB','PC') 
--AND B.STATUS_CODE_CHANGED = 'Y'
AND effective_to_dt>='2012-01-01') B 
ON A.ACCOUNT_NUMBER=B.ACCOUNT_NUMBER
AND A.ORDER_ID = B.ORDER_ID 
AND B.EFFECTIVE_FROM_DT BETWEEN A.ORDER_DT AND A.ORDER_DT+30
LEFT JOIN CITEAM.dm_contracts D 
ON A.ACCOUNT_NUMBER=D.ACCOUNT_NUMBER 
AND B.subscription_id = D.subscription_id
AND D.CONTRACT_START_DATE between A.order_dt and B.effective_from_dt
WHERE (A.SPORTS_ADDED + A.MOVIES_ADDED + A.KIDS_ADDED + A.BOXSETS_ADDED +A.SKYQ_ADDED+A.HD_LEGACY_ADDED+A.HD_BASIC_ADDED+A.HD_PREMIUM_ADDED+A.MULTISCREEN_ADDED+A.MULTISCREEN_PLUS_ADDED+A.SKY_PLUS_ADDED+A.SKY_GO_EXTRA_ADDED)>=1 AND D.CONTRACT_STATUS IN ('In Contract');

UPDATE #PREMIUMS A
SET A.Add_on_contract_status_post_order= CASE
WHEN D.CONTRACT_STATUS IN ('In Contract') THEN 1
ELSE 0
END,
A.Add_on_contract_subscription_item_post_order=CASE WHEN D.CONTRACT_STATUS IN ('In Contract') THEN D.Agreement_Item_Type ELSE NULL END
FROM #PREMIUMS A
LEFT JOIN CITeam.Orders_Detail C ON A.Account_Number = C.Account_Number AND A.Order_Dt = C.Order_Dt
LEFT JOIN
(SELECT ACCOUNT_NUMBER,ORDER_ID,subscription_id,EFFECTIVE_FROM_DT
FROM cust_subs_hist B

WHERE B.subscription_sub_type IN ('DTV HD','DTV Extra Subscription','Sky Go Extra','HD Pack','MS+','SKY_KIDS','SKY_BOX_SETS','KIDS_PACK','FREESAT','DTV_HD_EXTN')
AND B.effective_from_dt < B.effective_to_dt
AND B.owning_cust_account_id > '1'
AND B.SI_Latest_Src = 'CHORD'
AND B.STATUS_CODE IN ('AC','AB','PC') 
--AND B.STATUS_CODE_CHANGED = 'Y'
AND effective_to_dt>='2012-01-01') B 
ON A.ACCOUNT_NUMBER=B.ACCOUNT_NUMBER
AND C.ORDER_ID = B.ORDER_ID 
AND B.EFFECTIVE_FROM_DT BETWEEN A.ORDER_DT AND A.ORDER_DT+30
LEFT JOIN CITEAM.dm_contracts D 
ON A.ACCOUNT_NUMBER=D.ACCOUNT_NUMBER 
AND B.subscription_id = D.subscription_id
AND D.CONTRACT_START_DATE between A.order_dt and B.effective_from_dt
WHERE (A.SPORTS_ADDED + A.MOVIES_ADDED + A.KIDS_ADDED + A.BOXSETS_ADDED +A.SKYQ_ADDED+A.HD_LEGACY_ADDED+A.HD_BASIC_ADDED+A.HD_PREMIUM_ADDED+A.MULTISCREEN_ADDED+A.MULTISCREEN_PLUS_ADDED+A.SKY_PLUS_ADDED+A.SKY_GO_EXTRA_ADDED)>=1 AND D.CONTRACT_STATUS IN ('In Contract')  and A.Add_on_contract_status_post_order<>1 ;


update #PREMIUMS prem
set prem.Add_on_contract_status_post_order = CASE WHEN ctr.contract_status in ('In Contract') THEN 1 ELSE 0 END,
prem.Add_on_contract_subscription_item_post_order= CASE WHEN ctr.CONTRACT_STATUS IN ('In Contract') THEN ctr.Agreement_Item_Type ELSE NULL END 
from #PREMIUMS prem
left join CITEAM.DM_Contracts ctr
on prem.account_number =ctr.account_number 
--and base.subscription_id = ctr.subscription_id
and prem.order_dt+1 between ctr.Contract_start_date and ctr.actual_contract_end_date  
where ctr.contract_status in ('In Contract')and subscription_type in('Secondary DTV','Sky Enhanced Cap Subs') and prem.Add_on_contract_status_post_order<>1 ; */
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
    into #PREMIUMS_CONTACT_TYPE
    from #PREMIUMS as A
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
  update #PREMIUMS as A
    set A.CONTACT_TYPE = B.CONTACT_TYPE from
    #PREMIUMS_CONTACT_TYPE as B
    where A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT = B.ORDER_DT;
  --ADD ON WHETHER THE ACCOUNT HAS PERFORMED THE SAME PREMIUM CHANGE BEFORE
  select *
    into #PREMIUMS2
    from #PREMIUMS as AA;
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
    end as INTENDED_OFFER_STATUS into #PREMIUMS_OFFER_STATUS
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
        from #PREMIUMS2 as A
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
  update #PREMIUMS2 as A
    set A.ACTUAL_OFFER_STATUS = B.ACTUAL_OFFER_STATUS,
    A.INTENDED_OFFER_STATUS = B.INTENDED_OFFER_STATUS from
    #PREMIUMS_OFFER_STATUS as B
    where A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT = B.ORDER_DT;
  -- ADD FLAG IF ORDER CAME WITH ANY OFFER
  -- MMC Correct logic for Any_Offer flag using data provided by proc
  update #PREMIUMS2 as A
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
    cast(null as integer) as AUTO_TRANSFER_OFFER into #PREMIUMS3
    from #PREMIUMS2 as A;
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
    A.UPGRADE_DOWNGRADE,
    A.PREMIUM_CHANGE,
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
    case when A.MULTISCREEN_PLUS_ADDED > 1 then 1 else A.MULTISCREEN_PLUS_ADDED end as MULTISCREEN_PLUS_ADDED,
    case when A.MULTISCREEN_ADDED > 0 then 'CLASSIC_MULTISCREEN' when A.MULTISCREEN_PLUS_ADDED > 0 then 'QMS' end as MS_ADDED_PRODUCT,
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
    A.ACTIVE_BROADBAND_BEFORE_ORDER, -- MMC new prems fields ------------------------------------------------------------------------
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
    Sports_OFFER_END_STATUS_LEVEL_1,
    Cinema_OFFER_END_STATUS_LEVEL_1,
    Sports_OFFER_END_STATUS_LEVEL_2,
    Cinema_OFFER_END_STATUS_LEVEL_2,
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
    A.UOD_ADDED,
    A.UOD_REMOVED,
    case when A.Netflix_Standard_Added > 0 then 'Netflix_Standard' when A.Netflix_Premium_Added > 0 then 'Netflix_Premium' else '' end as Netflix_Added_Product,
    case when A.Netflix_Standard_Removed > 0 then 'Netflix_Standard' when A.Netflix_Premium_Removed > 0 then 'Netflix_Premium' else '' end as Netflix_Removed_Product,
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
    A.Add_on_contract_subscription_item_post_order,
    Add_on_Products_Contract_Status_Level_2,
    Basic_Contract_Status_Level_2,
    Overall_Contract_Status_Level_2,
    Talk_Contract_Status_Level_2,
    BB_Contract_Status_Level_2,
    Basic_Contract_Status_Level_1,
    Add_on_Products_Contract_Status_Level_1,
    Talk_Contract_Status_Level_1,
    BB_Contract_Status_Level_1,
    Overall_Contract_Status_Level_1,
    cast(null as decimal(5,2)) as longest_time_in_nf_app,
    cast(null as decimal(5,2)) as shortest_time_in_nf_app,
    cast(null as decimal(5,2)) as total_nf_app_launches,
    cast(null as decimal(5,2)) as total_time_in_nf_app,
    cast(null as decimal(5,2)) as longest_time_in_spotify_app,
    cast(null as decimal(5,2)) as shortest_time_in_spotify_app,
    cast(null as decimal(5,2)) as total_spotify_app_launches,
    cast(null as decimal(5,2)) as total_time_in_spotify_app
    into #ECONOMETRICS_PREMIUM_CHANGES --MMC Create as temp table rather than perm table in CITeam
    from #PREMIUMS3 as A
      left outer join sky_calendar as C on A.ORDER_DT = C.CALENDAR_DATE;
  -- UPDATE WEEK START
  select right(cast(subs_year as varchar),2) || '/' || right(cast(subs_year+1 as varchar),2) || '-'
     || case when subs_week_of_year < 10 then '0' || cast(subs_week_of_year as varchar)
    else cast(subs_week_of_year as varchar)
    end as year_week,
    min(calendar_date) as week_start into #weeks
    from sky_calendar as cal
    group by year_week;
  update #ECONOMETRICS_PREMIUM_CHANGES as a
    set a.week_start = b.week_start from
    #weeks as b
    where a.year_week = b.year_week;
  -----------------------App Usage------------------------------------
  select a.account_number,a.order_dt,a.order_id,
    (max(coalesce(longest_time_in_app,0.0)))/60000.0 as longest_time_in_nf_app,
    (min(coalesce(shortest_time_in_app,0.0)))/60000.0 as shortest_time_in_nf_app,
    sum(coalesce(total_app_launches,0.0)) as total_nf_app_launches,
    sum(coalesce(total_time_in_app,0.0))/60000.0 as total_time_in_nf_app
    into #weekly_netflix_app_usage
    from #ECONOMETRICS_PREMIUM_CHANGES as a
      left outer join q_stb_app_usage as b
      on a.account_number = b.account_number
      and cast(b.event_datetime as date) between a.order_dt-30 and a.order_dt
      and lower(trim(app_name)) = 'netflix'
    group by a.account_number,a.order_dt,a.order_id;
  select a.account_number,a.order_dt,a.order_id,
    (max(coalesce(longest_time_in_app,0.0)))/60000.0 as longest_time_in_spotify_app,
    (min(coalesce(shortest_time_in_app,0.0)))/60000.0 as shortest_time_in_spotify_app,
    sum(coalesce(total_app_launches,0.0)) as total_spotify_app_launches,
    sum(coalesce(total_time_in_app,0.0))/60000.0 as total_time_in_spotify_app
    into #weekly_spotify_app_usage
    from #ECONOMETRICS_PREMIUM_CHANGES as a
      left outer join q_stb_app_usage as b
      on a.account_number = b.account_number
      and cast(b.event_datetime as date) between a.order_dt-30 and a.order_dt
      and lower(trim(app_name)) like '%spotify%'
    group by a.account_number,a.order_dt,a.order_id;
  update #ECONOMETRICS_PREMIUM_CHANGES as base
    set base.longest_time_in_nf_app = 0.0,
    base.shortest_time_in_nf_app = 0.0,
    base.total_nf_app_launches = 0.0,
    base.total_time_in_nf_app = 0.0,
    base.longest_time_in_spotify_app = 0.0,
    base.shortest_time_in_spotify_app = 0.0,
    base.total_spotify_app_launches = 0.0,
    base.total_time_in_spotify_app = 0.0
    where order_dt >= Refresh_Dt;
  update #ECONOMETRICS_PREMIUM_CHANGES as base
    set base.longest_time_in_nf_app = coalesce(B.longest_time_in_nf_app,0.0),
    base.shortest_time_in_nf_app = coalesce(B.shortest_time_in_nf_app,0.0),
    base.total_nf_app_launches = coalesce(B.total_nf_app_launches,0.0),
    base.total_time_in_nf_app = coalesce(B.total_time_in_nf_app,0.0) from
    #ECONOMETRICS_PREMIUM_CHANGES as base
    join #weekly_netflix_app_usage as b
    on base.account_number = B.account_number and base.order_dt = B.order_dt and base.order_id = b.order_id;
  update #ECONOMETRICS_PREMIUM_CHANGES as base
    set base.longest_time_in_spotify_app = coalesce(B.longest_time_in_spotify_app,0.0),
    base.shortest_time_in_spotify_app = coalesce(B.shortest_time_in_spotify_app,0.0),
    base.total_spotify_app_launches = coalesce(B.total_spotify_app_launches,0.0),
    base.total_time_in_spotify_app = coalesce(B.total_time_in_spotify_app,0.0) from
    #ECONOMETRICS_PREMIUM_CHANGES as base
    join #weekly_spotify_app_usage as b
    on base.account_number = B.account_number and base.order_dt = B.order_dt and base.order_id = b.order_id;
  -----------------------------------------------------------------------------------------------
  -- UPDATE THE TV_REGION
  update #ECONOMETRICS_PREMIUM_CHANGES as prems
    set prems.TV_Region = B.tv_region,
    /* prems.TENURE = CASE
WHEN DATEDIFF(DAY, B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT, prems.WEEK_START) <= 122 THEN 'A) 0-4 MONTHS'
WHEN DATEDIFF(DAY, B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT, prems.WEEK_START) <= 274 THEN 'B) 5-9 MONTHS'
WHEN DATEDIFF(DAY, B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT, prems.WEEK_START) <= 395 THEN 'C) 10-13 MONTHS'
WHEN DATEDIFF(DAY, B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT, prems.WEEK_START) <= 730 THEN 'D) 14-24 MONTHS'
WHEN DATEDIFF(DAY, B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT, prems.WEEK_START) <= 1095 THEN 'E) 2-3 YEARS'
WHEN DATEDIFF(DAY, B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT, prems.WEEK_START) <= 1825 THEN 'F) 3-5 YEARS'
WHEN DATEDIFF(DAY, B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT, prems.WEEK_START) <= 3650 THEN 'G) 5-10 YEARS'
WHEN DATEDIFF(DAY, B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT, prems.WEEK_START) > 3650 THEN 'H) 10 YEARS+'
ELSE 'UNKNOWN'
END*/
    prems.TENURE = cast(DATEDIFF(month,B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT,prems.WEEK_START) as varchar) from
    #ECONOMETRICS_PREMIUM_CHANGES as prems
    join CITeam.Account_TV_Region as B on prems.account_number = B.account_number;
  ------------------Update LTV, MuTV, CTV,Asia Pack Flags--------------
  
  update #ECONOMETRICS_PREMIUM_CHANGES as A
    set A.Asia_Pack_Active
     = case when B.SkyAsia_Active_Subscription = 1 then 1
    else 0
    end from
    #ECONOMETRICS_PREMIUM_CHANGES as A
    left outer join CITeam.Active_Subscriber_Report as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT-1 >= B.effective_from_dt
    and A.ORDER_DT-1 < B.effective_to_dt
    where B.SkyAsia_Active_Subscription = 1;
  update #ECONOMETRICS_PREMIUM_CHANGES as A
    set A.MuTV_Pack_Active
     = case when B.MUTV_Active_Subscription = 1 then 1
    else 0
    end from
    #ECONOMETRICS_PREMIUM_CHANGES as A
    left outer join CITeam.Active_Subscriber_Report as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT-1 >= B.effective_from_dt
    and A.ORDER_DT-1 < B.effective_to_dt
    where B.MUTV_Active_Subscription = 1;
  update #ECONOMETRICS_PREMIUM_CHANGES as A
    set A.LTV_Pack_Active
     = case when B.Liverpool_Active_Subscription = 1 then 1
    else 0
    end from
    #ECONOMETRICS_PREMIUM_CHANGES as A
    left outer join CITeam.Active_Subscriber_Report as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT-1 >= B.effective_from_dt
    and A.ORDER_DT-1 < B.effective_to_dt
    where B.Liverpool_Active_Subscription = 1;
  update #ECONOMETRICS_PREMIUM_CHANGES as A
    set A.CTV_Pack_Active
     = case when B.Chelsea_TV_Active_Subscription = 1 then 1
    else 0
    end from
    #ECONOMETRICS_PREMIUM_CHANGES as A
    left outer join CITeam.Active_Subscriber_Report as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.ORDER_DT-1 >= B.effective_from_dt
    and A.ORDER_DT-1 < B.effective_to_dt
    where B.Chelsea_TV_Active_Subscription = 1;
	
  ------------------------------------------------------------Account_Active_length-------------------------------------------------------------------------- 
  drop table if exists #sports_activations;
  select account_number,event_dt as active_dt
    into #sports_activations
    from citeam.prem_activations
    where sports_upgrade = 1;
  
  drop table if exists #sports_churn;
  select a.account_number,a.active_Dt,
    MIN(b.event_dt) as not_active_dt
    into #sports_churn
    from #sports_activations as a
      left outer join citeam.prem_churns as b
      on a.account_number = b.account_number
      and b.event_dt > a.active_dt
      and sports_downgrade = 1
    group by a.account_number,a.active_Dt;
  
  drop table if exists #movies_activations;
  select account_number,event_dt as active_dt
    into #movies_activations
    from citeam.prem_activations
    where movies_upgrade = 1;
  
  drop table if exists #movies_churn;
  select a.account_number,a.active_Dt,
    MIN(b.event_dt) as not_active_dt
    into #movies_churn
    from #movies_activations as a
      left outer join citeam.prem_churns as b
      on a.account_number = b.account_number
      and b.event_dt > a.active_dt
      and movies_downgrade = 1
    group by a.account_number,a.active_Dt;
  
  update #movies_churn
    set not_active_dt = today()+2
    where not_active_dt is null;
  
  update #sports_churn
    set not_active_dt = today()+2
    where not_active_dt is null;
  
  drop table if exists #movies_churn_final;
  select aa.account_number,aa.order_dt,aa.active_dt,bb.not_active_dt
    into #movies_churn_final
    from(select aa.account_number,aa.order_dt,min(bb.active_dt) as active_dt
        from #ECONOMETRICS_PREMIUM_CHANGES as aa
          join #movies_churn as bb
          on aa.account_number = bb.account_number
        where aa.order_dt < bb.not_active_dt and movies_added = 1
        group by aa.account_number,aa.order_dt) as aa
      join #movies_churn as bb
      on aa.account_number = bb.account_number
      and aa.active_dt = bb.active_Dt
    group by aa.account_number,aa.order_dt,aa.active_dt,bb.not_active_dt;
  
  drop table if exists #sports_churn_final;
  select aa.account_number,aa.order_dt,aa.active_dt,bb.not_active_dt
    into #sports_churn_final
    from(select aa.account_number,aa.order_dt,min(bb.active_dt) as active_dt
        from #ECONOMETRICS_PREMIUM_CHANGES as aa
          join #sports_churn as bb
          on aa.account_number = bb.account_number
        where aa.order_dt < bb.not_active_dt and aa.sports_added = 1
        group by aa.account_number,aa.order_dt) as aa
      join #sports_churn as bb
      on aa.account_number = bb.account_number
      and aa.active_dt = bb.active_Dt
    group by aa.account_number,aa.order_dt,aa.active_dt,bb.not_active_dt;
  
  update #ECONOMETRICS_PREMIUM_CHANGES as aa
    set account_active_length = ((bb.not_active_dt-bb.active_dt)/30) from
    #ECONOMETRICS_PREMIUM_CHANGES as aa
    join #sports_churn_final as bb
    on aa.account_number = bb.account_number
    and aa.order_dt = bb.order_dt
    where aa.sports_added = 1;
  
  update #ECONOMETRICS_PREMIUM_CHANGES as aa
    set account_active_length = ((bb.not_active_dt-bb.active_dt)/30) from
    #ECONOMETRICS_PREMIUM_CHANGES as aa
    join #movies_churn_final as bb
    on aa.account_number = bb.account_number
    and aa.order_dt = bb.order_dt
    where aa.movies_added = 1;
  -- End 
  -----------------------------------------------------------------------------------------------
  delete from Decisioning.ECONOMETRICS_PREMIUM_CHANGE_ORDERS_ACCOUNT_LEVEL
    where WEEK_START >= Refresh_Dt;
  insert into Decisioning.ECONOMETRICS_PREMIUM_CHANGE_ORDERS_ACCOUNT_LEVEL
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
      UPGRADE_DOWNGRADE,
      PREMIUM_CHANGE,
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
      Sports_OFFER_END_STATUS_LEVEL_1,
      Cinema_OFFER_END_STATUS_LEVEL_1,
      Sports_OFFER_END_STATUS_LEVEL_2,
      Cinema_OFFER_END_STATUS_LEVEL_2,
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
      ACCOUNT_ACTIVE_LENGTH,
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
      longest_time_in_nf_app,
      total_nf_app_launches,
      total_time_in_nf_app,
      longest_time_in_spotify_app,
      total_spotify_app_launches,
      total_time_in_spotify_app,
      Add_on_Products_Contract_Status_Level_2,
      Basic_Contract_Status_Level_2,
      Overall_Contract_Status_Level_2,
      Talk_Contract_Status_Level_2,
      BB_Contract_Status_Level_2,
      Basic_Contract_Status_Level_1,
      Add_on_Products_Contract_Status_Level_1,
      Talk_Contract_Status_Level_1,
      BB_Contract_Status_Level_1,
      Overall_Contract_Status_Level_1
      from #ECONOMETRICS_PREMIUM_CHANGES;
  commit work;
  --SUMMARIZE DATA
  delete from Decisioning.ECONOMETRICS_PREMIUM_CHANGE_ORDERS
    where WEEK_START >= Refresh_Dt;
  insert into Decisioning.ECONOMETRICS_PREMIUM_CHANGE_ORDERS
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
      UPGRADE_DOWNGRADE,
      PREMIUM_CHANGE,
      SPORTS_ADDED,
      MOVIES_ADDED,
      --FAMILY_ADDED,
      --VARIETY_ADDED,
      --ORIGINAL_ADDED,
      --SKYQ_ADDED,
      HD_LEGACY_ADDED,
      HD_BASIC_ADDED,
      HD_PREMIUM_ADDED,
      -- MULTISCREEN_ADDED,
      -- MULTISCREEN_PLUS_ADDED,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      BB_ADDED_PRODUCT,
      --TALKU_ADDED,
      --TALKW_ADDED,
      --TALKF_ADDED,
      --TALKA_ADDED,
      --TALKP_ADDED,
      --TALKO_ADDED,
      TALK_ADDED,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      --FAMILY_REMOVED,
      --VARIETY_REMOVED,
      --ORIGINAL_REMOVED,
      --SKYQ_REMOVED,
      HD_LEGACY_REMOVED,
      HD_BASIC_REMOVED,
      HD_PREMIUM_REMOVED,
      --MULTISCREEN_REMOVED,
      --MULTISCREEN_PLUS_REMOVED,
      MS_REMOVED_PRODUCT,
      SKY_PLUS_REMOVED,
      SKY_GO_EXTRA_REMOVED,
      NOW_TV_REMOVED,
      BB_REMOVED_PRODUCT,
      --TALKU_REMOVED,
      --TALKW_REMOVED,
      --TALKF_REMOVED,
      --TALKA_REMOVED,
      --TALKP_REMOVED,
      --TALKO_REMOVED,
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
      Sports_OFFER_END_STATUS_LEVEL_1,
      Cinema_OFFER_END_STATUS_LEVEL_1,
      Sports_OFFER_END_STATUS_LEVEL_2,
      Cinema_OFFER_END_STATUS_LEVEL_2,
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
      ACCOUNT_ACTIVE_LENGTH,
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
      sum(longest_time_in_nf_app) as longest_time_in_nf_app_a,
      sum(total_nf_app_launches) as total_nf_app_launches_a,
      sum(total_time_in_nf_app) as total_time_in_nf_app,
      sum(case when total_nf_app_launches > 0 then 1 else 0 end) as Unique_accounts_viewing_nf,
      case when(sum(case when total_nf_app_launches > 0 then 1 else 0 end)) = 0 then 0.0
      else((sum(longest_time_in_nf_app))/(sum(case when total_nf_app_launches > 0 then 1 else 0 end)))
      end as avg_longest_time_in_nf_app,
      sum(longest_time_in_spotify_app) as longest_time_in_spotify_app_a,
      sum(total_spotify_app_launches) as total_spotify_app_launches_a,
      sum(total_time_in_spotify_app) as total_time_in_spotify_app,
      sum(case when total_spotify_app_launches > 0 then 1 else 0 end) as Unique_accounts_viewing_spotify,
      case when(sum(case when total_spotify_app_launches > 0 then 1 else 0 end)) = 0 then 0.0
      else((sum(longest_time_in_spotify_app))/(sum(case when total_spotify_app_launches > 0 then 1 else 0 end)))
      end as avg_longest_time_in_spotify_app,
      Add_on_Products_Contract_Status_Level_2,
      Basic_Contract_Status_Level_2,
      Overall_Contract_Status_Level_2,
      Talk_Contract_Status_Level_2,
      BB_Contract_Status_Level_2,
      Basic_Contract_Status_Level_1,
      Add_on_Products_Contract_Status_Level_1,
      Talk_Contract_Status_Level_1,
      BB_Contract_Status_Level_1,
      Overall_Contract_Status_Level_1
      from #ECONOMETRICS_PREMIUM_CHANGES as A
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
      UPGRADE_DOWNGRADE,
      PREMIUM_CHANGE,
      SPORTS_ADDED,
      MOVIES_ADDED,
      /*FAMILY_ADDED,
VARIETY_ADDED,
ORIGINAL_ADDED,
SKYQ_ADDED,*/
      HD_LEGACY_ADDED,
      HD_BASIC_ADDED,
      HD_PREMIUM_ADDED,
      -- MULTISCREEN_ADDED,
      -- MULTISCREEN_PLUS_ADDED,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      BB_ADDED_PRODUCT,
      /*  TALKU_ADDED,
TALKW_ADDED,
TALKF_ADDED,
TALKA_ADDED,
TALKP_ADDED,
TALKO_ADDED,*/
      TALK_ADDED,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      /* FAMILY_REMOVED,
VARIETY_REMOVED,
ORIGINAL_REMOVED,
SKYQ_REMOVED,*/
      HD_LEGACY_REMOVED,
      HD_BASIC_REMOVED,
      HD_PREMIUM_REMOVED,
      --MULTISCREEN_REMOVED,
      --MULTISCREEN_PLUS_REMOVED,
      MS_REMOVED_PRODUCT,
      SKY_PLUS_REMOVED,
      SKY_GO_EXTRA_REMOVED,
      NOW_TV_REMOVED,
      BB_REMOVED_PRODUCT,
      /* TALKU_REMOVED,
TALKW_REMOVED,
TALKF_REMOVED,
TALKA_REMOVED,
TALKP_REMOVED,
TALKO_REMOVED,*/
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
      Sports_OFFER_END_STATUS_LEVEL_1,
      Cinema_OFFER_END_STATUS_LEVEL_1,
      Sports_OFFER_END_STATUS_LEVEL_2,
      Cinema_OFFER_END_STATUS_LEVEL_2,
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
      ACCOUNT_ACTIVE_LENGTH,
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
      Add_on_Products_Contract_Status_Level_2,
      Basic_Contract_Status_Level_2,
      Overall_Contract_Status_Level_2,
      Talk_Contract_Status_Level_2,
      BB_Contract_Status_Level_2,
      Basic_Contract_Status_Level_1,
      Add_on_Products_Contract_Status_Level_1,
      Talk_Contract_Status_Level_1,
      BB_Contract_Status_Level_1,
      Overall_Contract_Status_Level_1;
  commit work;
  drop table if exists #ECONOMETRICS_PREMIUM_CHANGES_OFFERS;
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
    UPGRADE_DOWNGRADE,
    PREMIUM_CHANGE,
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
    /*  TALKU_ADDED,
TALKW_ADDED,
TALKF_ADDED,
TALKA_ADDED,
TALKP_ADDED,
TALKO_ADDED,
*/
    TALK_ADDED,
    SPORTS_REMOVED,
    MOVIES_REMOVED,
    -- FAMILY_REMOVED,
    -- VARIETY_REMOVED,
    -- ORIGINAL_REMOVED,
    -- SKYQ_REMOVED,
    HD_LEGACY_REMOVED,
    HD_BASIC_REMOVED,
    HD_PREMIUM_REMOVED,
    --MULTISCREEN_REMOVED,
    --MULTISCREEN_PLUS_REMOVED,
    MS_REMOVED_PRODUCT,
    SKY_PLUS_REMOVED,
    SKY_GO_EXTRA_REMOVED,
    NOW_TV_REMOVED,
    BB_REMOVED_PRODUCT,
    -- TALKU_REMOVED,
    -- TALKW_REMOVED,
    -- TALKF_REMOVED,
    -- TALKA_REMOVED,
    -- TALKP_REMOVED,
    -- TALKO_REMOVED,
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
    Sports_OFFER_END_STATUS_LEVEL_1,
    Cinema_OFFER_END_STATUS_LEVEL_1,
    Sports_OFFER_END_STATUS_LEVEL_2,
    Cinema_OFFER_END_STATUS_LEVEL_2,
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
    ACCOUNT_ACTIVE_LENGTH,
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
    longest_time_in_nf_app,
    total_nf_app_launches,
    total_time_in_nf_app,
    longest_time_in_spotify_app,
    total_spotify_app_launches,
    total_time_in_spotify_app,
    Add_on_Products_Contract_Status_Level_2,
    Basic_Contract_Status_Level_2,
    Overall_Contract_Status_Level_2,
    Talk_Contract_Status_Level_2,
    BB_Contract_Status_Level_2,
    Basic_Contract_Status_Level_1,
    Add_on_Products_Contract_Status_Level_1,
    Talk_Contract_Status_Level_1,
    BB_Contract_Status_Level_1,
    Overall_Contract_Status_Level_1
    into #ECONOMETRICS_PREMIUM_CHANGES_OFFERS
    /* A.FAMILY_ADDED ,
A.VARIETY_ADDED ,
A.ORIGINAL_ADDED ,
A.SKYQ_ADDED ,*/
    -- A.MULTISCREEN_ADDED ,
    --A.MULTISCREEN_PLUS_ADDED ,
    /* A.TALKU_ADDED ,
A.TALKW_ADDED ,
A.TALKF_ADDED ,
A.TALKA_ADDED ,
A.TALKP_ADDED ,
A.TALKO_ADDED ,*/
    -- A.FAMILY_REMOVED ,
    -- A.VARIETY_REMOVED ,
    -- A.ORIGINAL_REMOVED ,
    -- A.SKYQ_REMOVED ,
    -- A.MULTISCREEN_REMOVED ,
    --A.MULTISCREEN_PLUS_REMOVED ,
    -- A.TALKU_REMOVED ,
    -- A.TALKW_REMOVED ,
    -- A.TALKF_REMOVED ,
    -- A.TALKA_REMOVED ,
    -- A.TALKP_REMOVED ,
    -- A.TALKO_REMOVED ,
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
        A.UPGRADE_DOWNGRADE,
        A.PREMIUM_CHANGE,
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
        Sports_OFFER_END_STATUS_LEVEL_1,
        Cinema_OFFER_END_STATUS_LEVEL_1,
        Sports_OFFER_END_STATUS_LEVEL_2,
        Cinema_OFFER_END_STATUS_LEVEL_2,
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
        A.SPOTIFY_ADDED,
        A.SPOTIFY_REMOVED,
        DTV_ADDED_PRODUCT,
        DTV_REMOVED_PRODUCT,
        ACCOUNT_ACTIVE_LENGTH,
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
        longest_time_in_nf_app,
        total_nf_app_launches,
        total_time_in_nf_app,
        longest_time_in_spotify_app,
        total_spotify_app_launches,
        total_time_in_spotify_app,
        Add_on_Products_Contract_Status_Level_2,
        Basic_Contract_Status_Level_2,
        Overall_Contract_Status_Level_2,
        Talk_Contract_Status_Level_2,
        BB_Contract_Status_Level_2,
        Basic_Contract_Status_Level_1,
        Add_on_Products_Contract_Status_Level_1,
        Talk_Contract_Status_Level_1,
        BB_Contract_Status_Level_1,
        Overall_Contract_Status_Level_1,
        ROW_NUMBER() over(partition by A.ACCOUNT_NUMBER,
        A.CURRENCY_CODE,
        A.CUSTOMER_SK,
        A.ORDER_ID,
        A.ORDER_NUMBER,
        A.ORDER_DT,
        B.Offer_ID order by
        A.ORDER_DT desc,MONTHLY_OFFER_VALUE desc) as RowNum
        from #ECONOMETRICS_PREMIUM_CHANGES as A
          left outer join Decisioning.Offers_Software as B on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
          and lower(B.Offer_Dim_Description) not like '%price protect%'
          and A.ORDER_DT = B.Offer_Leg_CREATED_DT) as A
    where RowNum = 1;
  commit work;
  --SUMMARIZE DATA
  delete from Decisioning.ECONOMETRICS_PREMIUM_CHANGE_OFFERS
    where WEEK_START >= Refresh_Dt;
  insert into Decisioning.ECONOMETRICS_PREMIUM_CHANGE_OFFERS
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
      UPGRADE_DOWNGRADE,
      PREMIUM_CHANGE,
      SPORTS_ADDED,
      MOVIES_ADDED,
      /* FAMILY_ADDED,
VARIETY_ADDED,
ORIGINAL_ADDED,
SKYQ_ADDED,*/
      HD_LEGACY_ADDED,
      HD_BASIC_ADDED,
      HD_PREMIUM_ADDED,
      --MULTISCREEN_ADDED,
      --MULTISCREEN_PLUS_ADDED,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      BB_ADDED_PRODUCT,
      /*  TALKU_ADDED,
TALKW_ADDED,
TALKF_ADDED,
TALKA_ADDED,
TALKP_ADDED,
TALKO_ADDED,*/
      TALK_ADDED,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      -- FAMILY_REMOVED,
      -- VARIETY_REMOVED,
      -- ORIGINAL_REMOVED,
      -- SKYQ_REMOVED,
      HD_LEGACY_REMOVED,
      HD_BASIC_REMOVED,
      HD_PREMIUM_REMOVED,
      --MULTISCREEN_REMOVED,
      --MULTISCREEN_PLUS_REMOVED,
      MS_REMOVED_PRODUCT,
      SKY_PLUS_REMOVED,
      SKY_GO_EXTRA_REMOVED,
      NOW_TV_REMOVED,
      BB_REMOVED_PRODUCT,
      -- TALKU_REMOVED,
      -- TALKW_REMOVED,
      -- TALKF_REMOVED,
      -- TALKA_REMOVED,
      -- TALKP_REMOVED,
      -- TALKO_REMOVED,
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
      Sports_OFFER_END_STATUS_LEVEL_1,
      Cinema_OFFER_END_STATUS_LEVEL_1,
      Sports_OFFER_END_STATUS_LEVEL_2,
      Cinema_OFFER_END_STATUS_LEVEL_2,
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
      ACCOUNT_ACTIVE_LENGTH,
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
      sum(longest_time_in_nf_app) as longest_time_in_nf_app_a,
      sum(total_nf_app_launches) as total_nf_app_launches_a,
      sum(total_time_in_nf_app) as total_time_in_nf_app,
      sum(case when total_nf_app_launches > 0 then 1 else 0 end) as Unique_accounts_viewing_nf,
      case when(sum(case when total_nf_app_launches > 0 then 1 else 0 end)) = 0 then 0.0
      else((sum(longest_time_in_nf_app))/(sum(case when total_nf_app_launches > 0 then 1 else 0 end)))
      end as avg_longest_time_in_nf_app,
      sum(longest_time_in_spotify_app) as longest_time_in_spotify_app_a,
      sum(total_spotify_app_launches) as total_spotify_app_launches_a,
      sum(total_time_in_spotify_app) as total_time_in_spotify_app,
      sum(case when total_spotify_app_launches > 0 then 1 else 0 end) as Unique_accounts_viewing_spotify,
      case when(sum(case when total_spotify_app_launches > 0 then 1 else 0 end)) = 0 then 0.0
      else((sum(longest_time_in_spotify_app))/(sum(case when total_spotify_app_launches > 0 then 1 else 0 end)))
      end as avg_longest_time_in_spotify_app,
      Add_on_Products_Contract_Status_Level_2,
      Basic_Contract_Status_Level_2,
      Overall_Contract_Status_Level_2,
      Talk_Contract_Status_Level_2,
      BB_Contract_Status_Level_2,
      Basic_Contract_Status_Level_1,
      Add_on_Products_Contract_Status_Level_1,
      Talk_Contract_Status_Level_1,
      BB_Contract_Status_Level_1,
      Overall_Contract_Status_Level_1
      from #ECONOMETRICS_PREMIUM_CHANGES_OFFERS as A
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
      UPGRADE_DOWNGRADE,
      PREMIUM_CHANGE,
      SPORTS_ADDED,
      MOVIES_ADDED,
      -- FAMILY_ADDED,
      -- VARIETY_ADDED,
      -- ORIGINAL_ADDED,
      -- SKYQ_ADDED,
      HD_LEGACY_ADDED,
      HD_BASIC_ADDED,
      HD_PREMIUM_ADDED,
      --MULTISCREEN_ADDED,
      --MULTISCREEN_PLUS_ADDED,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      BB_ADDED_PRODUCT,
      -- TALKU_ADDED,
      -- TALKW_ADDED,
      -- TALKF_ADDED,
      -- TALKA_ADDED,
      -- TALKP_ADDED,
      -- TALKO_ADDED,
      TALK_ADDED,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      /* FAMILY_REMOVED,
VARIETY_REMOVED,
ORIGINAL_REMOVED,
SKYQ_REMOVED,*/
      HD_LEGACY_REMOVED,
      HD_BASIC_REMOVED,
      HD_PREMIUM_REMOVED,
      --MULTISCREEN_REMOVED,
      --MULTISCREEN_PLUS_REMOVED,
      MS_REMOVED_PRODUCT,
      SKY_PLUS_REMOVED,
      SKY_GO_EXTRA_REMOVED,
      NOW_TV_REMOVED,
      BB_REMOVED_PRODUCT,
      /*TALKU_REMOVED,
TALKW_REMOVED,
TALKF_REMOVED,
TALKA_REMOVED,
TALKP_REMOVED,
TALKO_REMOVED,*/
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
      Sports_OFFER_END_STATUS_LEVEL_1,
      Cinema_OFFER_END_STATUS_LEVEL_1,
      Sports_OFFER_END_STATUS_LEVEL_2,
      Cinema_OFFER_END_STATUS_LEVEL_2,
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
      ACCOUNT_ACTIVE_LENGTH,
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
      Add_on_Products_Contract_Status_Level_2,
      Basic_Contract_Status_Level_2,
      Overall_Contract_Status_Level_2,
      Talk_Contract_Status_Level_2,
      BB_Contract_Status_Level_2,
      Basic_Contract_Status_Level_1,
      Add_on_Products_Contract_Status_Level_1,
      Talk_Contract_Status_Level_1,
      BB_Contract_Status_Level_1,
      Overall_Contract_Status_Level_1;
  commit work;
  commit work
end

GO
GRANT EXECUTE ON Decisioning_Procs.Update_Econometrics_PremiumChanges TO public;


------------------------------------------------------------------------------------------------------------------
/*
CALL Decisioning_Procs.Update_Econometrics_PremiumChanges();
*/ 


/* create view in CITeam 
call DBA.sp_DDL ('drop', 'view', 'CITeam', 'ECONOMETRICS_PREMIUM_CHANGE_ORDERS');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'ECONOMETRICS_PREMIUM_CHANGE_ORDERS',  'select * from Decisioning.ECONOMETRICS_PREMIUM_CHANGE_ORDERS');

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'ECONOMETRICS_PREMIUM_CHANGE_OFFERS');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'ECONOMETRICS_PREMIUM_CHANGE_OFFERS',  'select * from Decisioning.ECONOMETRICS_PREMIUM_CHANGE_OFFERS');

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'ECONOMETRICS_PREMIUM_CHANGE_ORDERS_ACCOUNT_LEVEL');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'ECONOMETRICS_PREMIUM_CHANGE_ORDERS_ACCOUNT_LEVEL',  'select * from Decisioning.ECONOMETRICS_PREMIUM_CHANGE_ORDERS_ACCOUNT_LEVEL');

*/