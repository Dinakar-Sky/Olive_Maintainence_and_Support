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

---------------------------------------------------------------------------------------------------------------------------------------------------------------
Project:        TA EVENTS
Created:        18/03/2018
Owner  :        Fractal
--------------------------------------------------------------------------------------------------------------------------------------------------------------
Program to extract TA Call Events, add on any changes to the customers holdings on the day of the call,add on offers added on the day of the call and add customer information, then summarize

***************************************************************************************************************************************************************
****                                                              Change History                                                                           ****
*****************************************************************************************************************************************************************
Change#      Date         Author    	       Description 
** --       ---------   ------------- 	 ------------------------------------
** 1       03/01/2017   Vikram Haibate       Changing old sources with new one like VIEW_CUST_CALLS_HIST 
											 DM_Holdings_history with Turnaround_calls and active_subscriber_Report 
** 2       01/04/2018   Vikram Haibate       Added pre and post events for kids and boxsets 
** 3       16/04/2018   Vikram Haibate       Add contract Status of a subscription 
** 4   	   22/06/2018   Vikram Haibate       Drop and rename columns 
** 5	   22/06/2018   Vikram Haibate		 Added post event sky plus status 	and any offer given 
** 6       06/08/2018   Vikram Haibate		 Split Ala-Carte product holding 
** 7 	   17/12/2018 	Vikram Haibate		 Adding cinema and MOvies offers 
** 8 	   31/12/2018 	Vikram Haibate		 Add columns for sport_complete,Alacarte,sky go extra and last ta flags 
***************************************************************************************************************************************************************

-----------------------------------------------------------------------DDLS------------------------------------------------------------------------------------
dba.sp_drop_table 'Decisioning','ECONOMETRICS_TA_CALLS'
dba.sp_create_table 'Decisioning','ECONOMETRICS_TA_CALLS', 
   ' YEAR_WEEK VARCHAR (31) DEFAULT NULL, '
|| ' WEEK_START DATE  DEFAULT NULL, '
|| ' COUNTRY VARCHAR (16) DEFAULT NULL, '
|| ' SAVED_FLAG SMALLINT  DEFAULT 0, '
|| ' ACTUAL_OFFER_STATUS VARCHAR (15) DEFAULT NULL, '
|| ' INTENDED_OFFER_STATUS VARCHAR (15) DEFAULT NULL, '
|| ' SPORTS_ADDED SMALLINT  DEFAULT 0, '
|| ' MOVIES_ADDED SMALLINT  DEFAULT 0, '
|| ' LEGACY_SPORTS_SUB_ADDED smallint  default 0,'
|| ' LEGACY_MOVIES_SUB_ADDED smallint  default 0,'
|| ' SPORTS_PACK_SUB_ADDED smallint  default 0,'
|| ' SPORTS_PACK_ADDED smallint  default 0,'
|| ' LEGACY_SPORTS_SUB_REMOVED smallint  default 0,'
|| ' LEGACY_MOVIES_SUB_REMOVED smallint  default 0,'
|| ' SPORTS_PACK_SUB_REMOVED smallint  default 0,'
|| ' SPORTS_PACK_REMOVED smallint  default 0,'
|| ' BASIC_DTV_ADDED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' BASIC_DTV_REMOVED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' HD_LEGACY_ADDED SMALLINT  DEFAULT 0, '
|| ' HD_BASIC_ADDED SMALLINT  DEFAULT 0, '
|| ' HD_PREMIUM_ADDED SMALLINT  DEFAULT 0, '
|| ' MS_ADDED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' SKY_PLUS_ADDED SMALLINT  DEFAULT 0, '
|| ' SKY_GO_EXTRA_ADDED SMALLINT  DEFAULT 0, '
|| ' NOW_TV_ADDED SMALLINT  DEFAULT 0,' 
|| ' PRE_CALL_BB_ACTIVE TINYINT  DEFAULT NULL, '
|| ' PRE_CALL_BB_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_BB_ACTIVE TINYINT  DEFAULT NULL, '
|| ' POST_CALL_BB_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_DTV TINYINT  DEFAULT NULL, '
|| ' TALK_ADDED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' SPORTS_REMOVED SMALLINT  DEFAULT 0, '
|| ' MOVIES_REMOVED SMALLINT  DEFAULT 0, '
|| ' HD_LEGACY_REMOVED SMALLINT  DEFAULT 0, '
|| ' HD_BASIC_REMOVED SMALLINT  DEFAULT 0, '
|| ' HD_PREMIUM_REMOVED SMALLINT  DEFAULT 0, '
|| ' MS_REMOVED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' SKY_PLUS_REMOVED SMALLINT  DEFAULT 0, '
|| ' SKY_GO_EXTRA_REMOVED SMALLINT  DEFAULT 0, '
|| ' NOW_TV_REMOVED SMALLINT  DEFAULT 0, '
|| ' TALK_REMOVED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' PRE_CALL_DTV INT  DEFAULT NULL, '
|| ' PRE_CALL_BASIC_DTV_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_BASIC_DTV_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' PRE_CALL_TOP_TIER INT  DEFAULT NULL, '
|| ' PRE_CALL_TOTAL_PREMIUMS INT  DEFAULT NULL, '
|| ' PRE_CALL_TOTAL_SPORTS INT  DEFAULT NULL, '
|| ' PRE_CALL_TOTAL_MOVIES INT  DEFAULT NULL, '
|| ' POST_CALL_TOP_TIER SMALLINT  DEFAULT 0, '
|| ' POST_CALL_TOTAL_PREMIUMS INT  DEFAULT NULL, '
|| ' POST_CALL_TOTAL_SPORTS INT  DEFAULT NULL, '
|| ' POST_CALL_TOTAL_MOVIES INT  DEFAULT NULL, '
|| ' ANY_OFFER_Active SMALLINT  DEFAULT 0, '
|| ' ANY_OFFER_GIVEN SMALLINT  DEFAULT 0, '
|| ' DTV_OFFER_Active SMALLINT  DEFAULT 0, '
|| ' DTV_OFFER_Given SMALLINT  DEFAULT 0, '
|| ' BB_OFFER_Active SMALLINT  DEFAULT 0, '
|| ' LR_OFFER_Active SMALLINT  DEFAULT 0, '
|| ' MS_OFFER_Active SMALLINT  DEFAULT 0, '
|| ' HD_OFFER_Active SMALLINT  DEFAULT 0, '
|| ' POST_CALL_SKY_PLUS SMALLINT  DEFAULT 0, '
|| ' TENURE int DEFAULT NULL, '
|| ' TV_REGION VARCHAR (100) DEFAULT NULL, '
|| ' NUMBER_OF_TA_EVENTS INT  DEFAULT NULL, '
|| ' SPORTS_COMPLETE_ADDED SMALLINT  DEFAULT 0, '
|| ' SPORTS_COMPLETE_REMOVED SMALLINT  DEFAULT 0, '
|| ' SPORTS_ACTION_ADDED SMALLINT  DEFAULT 0, '
|| ' SPORTS_ACTION_REMOVED SMALLINT  DEFAULT 0, '
|| ' SPORTS_CRICKET_ADDED SMALLINT  DEFAULT 0, '
|| ' SPORTS_CRICKET_REMOVED SMALLINT  DEFAULT 0, '
|| ' SPORTS_F1_ADDED SMALLINT  DEFAULT 0, '
|| ' SPORTS_F1_REMOVED SMALLINT  DEFAULT 0, '
|| ' SPORTS_FOOTBALL_ADDED SMALLINT  DEFAULT 0, '
|| ' SPORTS_FOOTBALL_REMOVED SMALLINT  DEFAULT 0, '
|| ' SPORTS_GOLF_ADDED SMALLINT  DEFAULT 0, '
|| ' SPORTS_GOLF_REMOVED SMALLINT  DEFAULT 0, '
|| ' SPORTS_PREMIERLEAGUE_ADDED SMALLINT  DEFAULT 0, '
|| ' SPORTS_PREMIERLEAGUE_REMOVED SMALLINT  DEFAULT 0, '
|| ' CINEMA_ADDED SMALLINT  DEFAULT 0, '
|| ' CINEMA_REMOVED SMALLINT  DEFAULT 0, '
|| ' PRE_CALL_SPORTS_ACTIVE TINYINT  DEFAULT 0, '
|| ' POST_CALL_SPORTS_ACTIVE TINYINT  DEFAULT 0, '
|| ' PRE_CALL_MOVIES_ACTIVE TINYINT  DEFAULT 0, '
|| ' POST_CALL_MOVIES_ACTIVE TINYINT  DEFAULT 0, '
|| ' OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' BASIC_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' PREMIUM_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' Sports_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' Cinema_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' BB_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' LR_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' BASIC_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' PREMIUM_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' Sports_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' Cinema_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' BB_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' LR_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' PRE_CALL_SPORTS_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_SPORTS_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' PRE_CALL_MOVIES_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_MOVIES_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' ANY_NEW_OFFER_Active_Leg_1 integer default null,'
|| ' NEW_DTV_OFFER_Active_leg_1 smallint default null, '
|| ' SKY_KIDS_ADDED smallint  default	0,'
|| ' SKY_KIDS_REMOVED smallint  default	0,'
|| ' SKY_BOXSETS_ADDED smallint  default	0,'
|| ' SKY_BOXSETS_REMOVED smallint  default	0,'
|| ' SPOTIFY_ADDED smallint  default	0,'
|| ' SPOTIFY_REMOVED smallint  default	0,'
|| ' UOD_ADDED smallint default 0,'
|| ' UOD_REMOVED smallint default 0,'
|| ' Netflix_Added_Product VARCHAR(30) DEFAULT NULL, '
|| ' Netflic_Removed_Product VARCHAR(30) DEFAULT NULL, '
|| ' PRE_CALL_SKY_KIDS smallint  default	0,'
|| ' PRE_CALL_SKY_BOXSETS smallint  default	0,'
|| ' POST_CALL_SKY_KIDS smallint 	default	0,'
|| ' POST_CALL_SKY_BOXSETS smallint 	default	0,'
|| ' PRE_CALL_HD_BASIC smallint 	default	0,'
|| ' PRE_CALL_HD_PREMIUM smallint 	default	0,'
|| ' POST_CALL_HD_BASIC smallint 	default	0,'
|| ' POST_CALL_HD_PREMIUM smallint 	default	0,'
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
|| ' TA_attempt_type varchar	(	255	) default	null,'
|| ' last_ta_date date  default	null,'
|| ' Time_Since_Last_TA_Event varchar	(	15	) default	null,'
|| ' ta_call_event smallint  default	0,'
|| ' turnaround_description char	(	20	) default	null,'
|| ' livechat_turnaround_event smallint  default	0,'
|| ' livechat_turnaround_description char	(	29	) default	null,'
|| ' pre_call_LR tinyint  default	0,'
|| ' post_call_LR tinyint  default	0,'
|| ' LR_added tinyint  default	0,'
|| ' LR_removed tinyint  default	0,'
|| ' pre_call_ms_product_holding varchar	(	80	) default	null,'
|| ' pre_call_ms_count int  default	null,'
|| ' post_call_ms_product_holding varchar	(	80	) default	null,'
|| ' post_call_ms_count int  default	null,'
|| ' ms_count_added tinyint  default	0,'
|| ' ms_count_removed tinyint  default	0,'
|| ' MS_Product_Holding_Added varchar	(	80	) default	null,'
|| ' MS_Product_Holding_Removed varchar	(	80	) default	null,'
|| ' pre_call_talk_product_holding varchar	(	80	) default	null,'
|| ' post_call_talk_product_holding varchar	(	80	) default	null,'
|| ' Talk_Product_Holding_Added varchar	(	80	) default	null,'
|| ' Talk_Product_Holding_Removed varchar	(	80	) default	null,'
|| ' pre_call_chelsea_tv tinyint default 0,'
|| ' post_call_chelsea_tv tinyint default 0,'
|| ' pre_call_mutv tinyint default 0,'
|| ' post_call_mutv tinyint default 0,'
|| ' pre_call_liverpool tinyint default 0,'
|| ' post_call_liverpool tinyint default 0,'
|| ' pre_call_skyasia tinyint default 0,'
|| ' post_call_skyasia tinyint default 0,'
|| ' chelsea_tv_Added tinyint default 0,'
|| ' chelsea_tv_Removed tinyint default 0,'
|| ' mutv_Added tinyint default 0,'
|| ' mutv_Removed tinyint default 0,'
|| ' liverpool_Added tinyint default 0,'
|| ' liverpool_Removed tinyint default 0,'
|| ' skyasia_Added tinyint default 0,'
|| ' skyasia_Removed tinyint default 0,'
|| ' longest_time_in_nf_app DECIMAL (5,2) DEFAULT NULL, '
|| ' total_nf_app_launches DECIMAL (5,2) DEFAULT NULL, '
|| ' total_time_in_nf_app DECIMAL (5,2) DEFAULT NULL,'
|| ' Unique_accounts_viewing_nf DECIMAL (5,2) DEFAULT NULL, '
|| ' avg_longest_time_in_nf_app DECIMAL (5,2) DEFAULT NULL,'
|| ' longest_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL, '
|| ' total_spotify_app_launches DECIMAL (5,2) DEFAULT NULL, '
|| ' total_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL ,'
|| ' Unique_accounts_viewing_spotify DECIMAL (5,2) DEFAULT NULL, '
|| ' avg_longest_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL,'
|| ' Basic_contract_status_pre_call tinyint default 0,'
|| ' Talk_contract_status_pre_call tinyint default 0,'
|| ' BB_contract_status_pre_call tinyint default 0,'
|| ' Add_on_contract_status_pre_call tinyint default 0,'
|| ' Overall_contract_status_pre_call tinyint default 0,'
|| ' Basic_contract_status_post_call tinyint default 0,'
|| ' Talk_contract_status_post_call tinyint default 0,'
|| ' BB_contract_status_post_call tinyint default 0,'
|| ' Add_on_contract_status_post_call tinyint default 0,'
|| ' Overall_contract_status_post_call tinyint default 0,'
|| ' pre_call_sports_complete tinyint default 0,'
|| ' post_call_sports_complete tinyint default 0,'
|| ' pre_call_ala_carte_product_holding varchar(30) default 0,'
|| ' post_call_ala_carte_product_holding varchar(30) default 0,'
|| ' pre_call_sky_go_extra tinyint default 0,'
|| ' post_call_sky_go_extra tinyint default 0,'
|| ' ta_in_last_seven_days tinyint default 0,'
|| ' ta_in_last_one_month tinyint default 0,'
|| ' ta_in_last_six_months tinyint default 0,'
|| ' ta_in_last_one_year tinyint default 0'



dba.sp_drop_table 'Decisioning','ECONOMETRICS_TA_CALLS_OFFERS'
dba.sp_create_table 'Decisioning','ECONOMETRICS_TA_CALLS_OFFERS', 
   ' YEAR_WEEK VARCHAR (31) DEFAULT NULL, '
|| ' WEEK_START DATE  DEFAULT NULL, '
|| ' COUNTRY VARCHAR (16) DEFAULT NULL, '
|| ' SAVED_FLAG SMALLINT  DEFAULT 0, '
|| ' ACTUAL_OFFER_STATUS VARCHAR (15) DEFAULT NULL, '
|| ' INTENDED_OFFER_STATUS VARCHAR (15) DEFAULT NULL, '
|| ' SPORTS_ADDED SMALLINT  DEFAULT 0, '
|| ' MOVIES_ADDED SMALLINT  DEFAULT 0, '
|| ' LEGACY_SPORTS_SUB_ADDED smallint  default 0,'
|| ' LEGACY_MOVIES_SUB_ADDED smallint  default 0,'
|| ' SPORTS_PACK_SUB_ADDED smallint  default 0,'
|| ' SPORTS_PACK_ADDED smallint  default 0,'
|| ' LEGACY_SPORTS_SUB_REMOVED smallint  default 0,'
|| ' LEGACY_MOVIES_SUB_REMOVED smallint  default 0,'
|| ' SPORTS_PACK_SUB_REMOVED smallint  default 0,'
|| ' SPORTS_PACK_REMOVED smallint  default 0,'
|| ' BASIC_DTV_ADDED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' BASIC_DTV_REMOVED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' HD_LEGACY_ADDED SMALLINT  DEFAULT 0, '
|| ' HD_BASIC_ADDED SMALLINT  DEFAULT 0, '
|| ' HD_PREMIUM_ADDED SMALLINT  DEFAULT 0, '
|| ' MS_ADDED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' SKY_PLUS_ADDED SMALLINT  DEFAULT 0, '
|| ' SKY_GO_EXTRA_ADDED SMALLINT  DEFAULT 0, '
|| ' NOW_TV_ADDED SMALLINT  DEFAULT 0, '
|| ' PRE_CALL_BB_ACTIVE TINYINT  DEFAULT NULL, '
|| ' PRE_CALL_BB_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_BB_ACTIVE TINYINT  DEFAULT NULL, '
|| ' POST_CALL_BB_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_DTV TINYINT  DEFAULT NULL, '
|| ' TALK_ADDED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' SPORTS_REMOVED SMALLINT  DEFAULT 0, '
|| ' MOVIES_REMOVED SMALLINT  DEFAULT 0, '
|| ' HD_LEGACY_REMOVED SMALLINT  DEFAULT 0, '
|| ' HD_BASIC_REMOVED SMALLINT  DEFAULT 0, '
|| ' HD_PREMIUM_REMOVED SMALLINT  DEFAULT 0, '
|| ' MS_REMOVED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' SKY_PLUS_REMOVED SMALLINT  DEFAULT 0, '
|| ' SKY_GO_EXTRA_REMOVED SMALLINT  DEFAULT 0, '
|| ' NOW_TV_REMOVED SMALLINT  DEFAULT 0, '
|| ' TALK_REMOVED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' PRE_CALL_DTV INT  DEFAULT NULL, '
|| ' PRE_CALL_BASIC_DTV_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_BASIC_DTV_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' PRE_CALL_TOP_TIER INT  DEFAULT NULL, '
|| ' PRE_CALL_TOTAL_PREMIUMS INT  DEFAULT NULL, '
|| ' PRE_CALL_TOTAL_SPORTS INT  DEFAULT NULL, '
|| ' PRE_CALL_TOTAL_MOVIES INT  DEFAULT NULL, '
|| ' POST_CALL_TOP_TIER SMALLINT  DEFAULT 0, '
|| ' POST_CALL_TOTAL_PREMIUMS INT  DEFAULT NULL, '
|| ' POST_CALL_TOTAL_SPORTS INT  DEFAULT NULL, '
|| ' POST_CALL_TOTAL_MOVIES INT  DEFAULT NULL, '
|| ' ANY_OFFER_Active SMALLINT  DEFAULT 0, '
|| ' ANY_OFFER_GIVEN SMALLINT  DEFAULT 0, '
|| ' DTV_OFFER_Active SMALLINT  DEFAULT 0, '
|| ' DTV_OFFER_GIVEN SMALLINT  DEFAULT 0, '
|| ' POST_CALL_SKY_PLUS SMALLINT  DEFAULT 0, '
|| ' OFFER_SUB_TYPE VARCHAR (80) DEFAULT NULL, '
|| ' OFFER_DESCRIPTION VARCHAR (465) DEFAULT NULL, '
|| ' MONTHLY_OFFER_VALUE DECIMAL (5,2) DEFAULT NULL, '
|| ' OFFER_DURATION_MTH INT  DEFAULT NULL, '
|| ' TOTAL_OFFER_VALUE DECIMAL (5,2) DEFAULT NULL, '
|| ' AUTO_TRANSFER_OFFER SMALLINT  DEFAULT 0, '
|| ' TENURE int DEFAULT NULL, '
|| ' TV_REGION VARCHAR (100) DEFAULT NULL, '
|| ' NUMBER_OF_TA_EVENTS INT  DEFAULT NULL, '
|| ' SPORTS_COMPLETE_ADDED SMALLINT  DEFAULT 0, '
|| ' SPORTS_COMPLETE_REMOVED SMALLINT  DEFAULT 0, '
|| ' SPORTS_ACTION_ADDED SMALLINT  DEFAULT 0, '
|| ' SPORTS_ACTION_REMOVED SMALLINT  DEFAULT 0, '
|| ' SPORTS_CRICKET_ADDED SMALLINT  DEFAULT 0, '
|| ' SPORTS_CRICKET_REMOVED SMALLINT  DEFAULT 0, '
|| ' SPORTS_F1_ADDED SMALLINT  DEFAULT 0, '
|| ' SPORTS_F1_REMOVED SMALLINT  DEFAULT 0, '
|| ' SPORTS_FOOTBALL_ADDED SMALLINT  DEFAULT 0, '
|| ' SPORTS_FOOTBALL_REMOVED SMALLINT  DEFAULT 0, '
|| ' SPORTS_GOLF_ADDED SMALLINT  DEFAULT 0, '
|| ' SPORTS_GOLF_REMOVED SMALLINT  DEFAULT 0, '
|| ' SPORTS_PREMIERLEAGUE_ADDED SMALLINT  DEFAULT 0, '
|| ' SPORTS_PREMIERLEAGUE_REMOVED SMALLINT  DEFAULT 0, '
|| ' CINEMA_ADDED SMALLINT  DEFAULT 0, '
|| ' CINEMA_REMOVED SMALLINT  DEFAULT 0, '
|| ' PRE_CALL_SPORTS_ACTIVE TINYINT  DEFAULT 0, '
|| ' POST_CALL_SPORTS_ACTIVE TINYINT  DEFAULT 0, '
|| ' PRE_CALL_MOVIES_ACTIVE TINYINT  DEFAULT 0, '
|| ' POST_CALL_MOVIES_ACTIVE TINYINT  DEFAULT 0 ,'
|| ' OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, ' 
|| ' BASIC_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' PREMIUM_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' Sports_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' Cinema_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' BB_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' LR_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' BASIC_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' PREMIUM_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' Sports_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' Cinema_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' BB_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' LR_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' PRE_CALL_SPORTS_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_SPORTS_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' PRE_CALL_MOVIES_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_MOVIES_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' ANY_NEW_OFFER_Active_Leg_1 integer default null,'
|| ' NEW_DTV_OFFER_Active_Leg_1 smallint default null,'
|| ' SKY_KIDS_ADDED smallint  default	0,'
|| ' SKY_KIDS_REMOVED smallint  default	0,'
|| ' SKY_BOXSETS_ADDED smallint  default	0,'
|| ' SKY_BOXSETS_REMOVED smallint  default	0,'
|| ' SPOTIFY_ADDED smallint  default	0,'
|| ' SPOTIFY_REMOVED smallint  default	0,'
|| ' UOD_ADDED smallint default 0,'
|| ' UOD_REMOVED smallint default 0,'
|| ' Netflix_Added_Product VARCHAR(30) DEFAULT NULL, '
|| ' Netflic_Removed_Product VARCHAR(30) DEFAULT NULL, '
|| ' PRE_CALL_SKY_KIDS smallint  default	0,'
|| ' PRE_CALL_SKY_BOXSETS smallint  default	0,'
|| ' POST_CALL_SKY_KIDS smallint 	default	0,'
|| ' POST_CALL_SKY_BOXSETS smallint 	default	0,'
|| ' PRE_CALL_HD_BASIC smallint 	default	0,'
|| ' PRE_CALL_HD_PREMIUM smallint 	default	0,'
|| ' POST_CALL_HD_BASIC smallint 	default	0,'
|| ' POST_CALL_HD_PREMIUM smallint 	default	0,'
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
|| ' TA_attempt_type varchar	(	255	) default	null,'
|| ' last_ta_date date  default	null,'
|| ' Time_Since_Last_TA_Event varchar	(	15	) default	null,'
|| ' ta_call_event smallint  default	0,'
|| ' turnaround_description char	(	20	) default	null,'
|| ' livechat_turnaround_event smallint  default	0,'
|| ' livechat_turnaround_description char	(	29	) default	null,'
|| ' pre_call_LR tinyint  default	0,'
|| ' post_call_LR tinyint  default	0,'
|| ' LR_added tinyint  default	0,'
|| ' LR_removed tinyint  default	0,'
|| ' pre_call_ms_product_holding varchar	(	80	) default	null,'
|| ' pre_call_ms_count int  default	null,'
|| ' post_call_ms_product_holding varchar	(	80	) default	null,'
|| ' post_call_ms_count int  default	null,'
|| ' ms_count_added tinyint  default	0,'
|| ' ms_count_removed tinyint  default	0,'
|| ' MS_Product_Holding_Added varchar	(	80	) default	null,'
|| ' MS_Product_Holding_Removed varchar	(	80	) default	null,'
|| ' pre_call_talk_product_holding varchar	(	80	) default	null,'
|| ' post_call_talk_product_holding varchar	(	80	) default	null,'
|| ' Talk_Product_Holding_Added varchar	(	80	) default	null,'
|| ' Talk_Product_Holding_Removed varchar	(	80	) default	null,'
|| ' pre_call_chelsea_tv tinyint default 0,'
|| ' post_call_chelsea_tv tinyint default 0,'
|| ' pre_call_mutv tinyint default 0,'
|| ' post_call_mutv tinyint default 0,'
|| ' pre_call_liverpool tinyint default 0,'
|| ' post_call_liverpool tinyint default 0,'
|| ' pre_call_skyasia tinyint default 0,'
|| ' post_call_skyasia tinyint default 0,'
|| ' chelsea_tv_Added tinyint default 0,'
|| ' chelsea_tv_Removed tinyint default 0,'
|| ' mutv_Added tinyint default 0,'
|| ' mutv_Removed tinyint default 0,'
|| ' liverpool_Added tinyint default 0,'
|| ' liverpool_Removed tinyint default 0,'
|| ' skyasia_Added tinyint default 0,'
|| ' skyasia_Removed tinyint default 0,'
|| ' longest_time_in_nf_app DECIMAL (5,2) DEFAULT NULL, '
|| ' total_nf_app_launches DECIMAL (5,2) DEFAULT NULL, '
|| ' total_time_in_nf_app DECIMAL (5,2) DEFAULT NULL, '
|| ' Unique_accounts_viewing_nf DECIMAL (5,2) DEFAULT NULL, '
|| ' avg_longest_time_in_nf_app DECIMAL (5,2) DEFAULT NULL,'
|| ' longest_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL, '
|| ' total_spotify_app_launches DECIMAL (5,2) DEFAULT NULL, '
|| ' total_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL ,'
|| ' Unique_accounts_viewing_spotify DECIMAL (5,2) DEFAULT NULL, '
|| ' avg_longest_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL,'
|| ' Basic_contract_status_pre_call tinyint default 0,'
|| ' Talk_contract_status_pre_call tinyint default 0,'
|| ' BB_contract_status_pre_call tinyint default 0,'
|| ' Add_on_contract_status_pre_call tinyint default 0,'
|| ' Overall_contract_status_pre_call tinyint default 0,'
|| ' Basic_contract_status_post_call tinyint default 0,'
|| ' Talk_contract_status_post_call tinyint default 0,'
|| ' BB_contract_status_post_call tinyint default 0,'
|| ' Add_on_contract_status_post_call tinyint default 0,'
|| ' Overall_contract_status_post_call tinyint default 0,'
|| ' pre_call_sports_complete tinyint default 0,'
|| ' post_call_sports_complete tinyint default 0,'
|| ' pre_call_ala_carte_product_holding varchar(30) default 0,'
|| ' post_call_ala_carte_product_holding varchar(30) default 0,'
|| ' pre_call_sky_go_extra tinyint default 0,'
|| ' post_call_sky_go_extra tinyint default 0,'
|| ' ta_in_last_seven_days tinyint default 0,'
|| ' ta_in_last_one_month tinyint default 0,'
|| ' ta_in_last_six_months tinyint default 0,'
|| ' ta_in_last_one_year tinyint default 0'


dba.sp_drop_table 'Decisioning','ECONOMETRICS_TA_CALLS_OFFERS_ENDING'
dba.sp_create_table 'Decisioning','ECONOMETRICS_TA_CALLS_OFFERS_ENDING', 
   ' YEAR_WEEK VARCHAR (31) DEFAULT NULL, '
|| ' WEEK_START DATE DEFAULT NULL,'
|| ' COUNTRY VARCHAR (16) DEFAULT NULL,'
|| ' SAVED_FLAG SMALLINT DEFAULT 0,'
|| ' ACTUAL_OFFER_STATUS VARCHAR (15) DEFAULT NULL,'
|| ' INTENDED_OFFER_STATUS VARCHAR (15) DEFAULT NULL,'
|| ' SPORTS_ADDED SMALLINT DEFAULT 0,'
|| ' MOVIES_ADDED SMALLINT DEFAULT 0,'
|| ' LEGACY_SPORTS_SUB_ADDED smallint  default 0,'
|| ' LEGACY_MOVIES_SUB_ADDED smallint  default 0,'
|| ' SPORTS_PACK_SUB_ADDED smallint  default 0,'
|| ' SPORTS_PACK_ADDED smallint  default 0,'
|| ' LEGACY_SPORTS_SUB_REMOVED smallint  default 0,'
|| ' LEGACY_MOVIES_SUB_REMOVED smallint  default 0,'
|| ' SPORTS_PACK_SUB_REMOVED smallint  default 0,'
|| ' SPORTS_PACK_REMOVED smallint  default 0,'
|| ' BASIC_DTV_ADDED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' BASIC_DTV_REMOVED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' HD_LEGACY_ADDED SMALLINT DEFAULT 0,'
|| ' HD_BASIC_ADDED SMALLINT DEFAULT 0,'
|| ' HD_PREMIUM_ADDED SMALLINT DEFAULT 0,'
|| ' MS_ADDED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' SKY_PLUS_ADDED SMALLINT DEFAULT 0,'
|| ' SKY_GO_EXTRA_ADDED SMALLINT DEFAULT 0,'
|| ' NOW_TV_ADDED SMALLINT DEFAULT 0,'
|| ' PRE_CALL_BB_ACTIVE TINYINT  DEFAULT NULL, '
|| ' PRE_CALL_BB_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_BB_ACTIVE TINYINT  DEFAULT NULL, '
|| ' POST_CALL_BB_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_DTV TINYINT  DEFAULT NULL, '
|| ' TALK_ADDED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' SPORTS_REMOVED SMALLINT DEFAULT 0,'
|| ' MOVIES_REMOVED SMALLINT DEFAULT 0,'
|| ' HD_LEGACY_REMOVED SMALLINT DEFAULT 0,'
|| ' HD_BASIC_REMOVED SMALLINT DEFAULT 0,'
|| ' HD_PREMIUM_REMOVED SMALLINT DEFAULT 0,'
|| ' MS_REMOVED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' SKY_PLUS_REMOVED SMALLINT DEFAULT 0,'
|| ' SKY_GO_EXTRA_REMOVED SMALLINT DEFAULT 0,'
|| ' NOW_TV_REMOVED SMALLINT DEFAULT 0,'
|| ' TALK_REMOVED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' PRE_CALL_DTV INT DEFAULT NULL,'
|| ' PRE_CALL_BASIC_DTV_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_BASIC_DTV_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' PRE_CALL_TOP_TIER INT DEFAULT NULL,'
|| ' PRE_CALL_TOTAL_PREMIUMS INT DEFAULT NULL,'
|| ' PRE_CALL_TOTAL_SPORTS INT DEFAULT NULL,'
|| ' PRE_CALL_TOTAL_MOVIES INT DEFAULT NULL,'
|| ' POST_CALL_TOP_TIER SMALLINT DEFAULT 0,'
|| ' POST_CALL_TOTAL_PREMIUMS INT DEFAULT NULL,'
|| ' POST_CALL_TOTAL_SPORTS INT DEFAULT NULL,'
|| ' POST_CALL_TOTAL_MOVIES INT DEFAULT NULL,'
|| ' ANY_OFFER_Active SMALLINT DEFAULT 0,'
|| ' ANY_OFFER_GIVEN SMALLINT  DEFAULT 0, '
|| ' DTV_OFFER_Active SMALLINT DEFAULT 0,'
|| ' DTV_OFFER_GIVEN SMALLINT  DEFAULT 0, '
|| ' POST_CALL_SKY_PLUS SMALLINT  DEFAULT 0, '
|| ' OFFER_SUB_TYPE VARCHAR (80) DEFAULT NULL,'
|| ' OFFER_DESCRIPTION VARCHAR (465) DEFAULT NULL,'
|| ' MONTHLY_OFFER_VALUE DECIMAL (5,2) DEFAULT NULL,'
|| ' OFFER_DURATION_MTH INT DEFAULT NULL,'
|| ' TOTAL_OFFER_VALUE DECIMAL (5,2) DEFAULT NULL,'
|| ' AUTO_TRANSFER_OFFER SMALLINT DEFAULT 0,'
|| ' TENURE int DEFAULT NULL,'
|| ' TV_REGION VARCHAR (100) DEFAULT NULL,'
|| ' NUMBER_OF_TA_EVENTS INT DEFAULT NULL,'
|| ' SPORTS_COMPLETE_ADDED SMALLINT DEFAULT 0,'
|| ' SPORTS_COMPLETE_REMOVED SMALLINT DEFAULT 0,'
|| ' SPORTS_ACTION_ADDED SMALLINT DEFAULT 0,'
|| ' SPORTS_ACTION_REMOVED SMALLINT DEFAULT 0,'
|| ' SPORTS_CRICKET_ADDED SMALLINT DEFAULT 0,'
|| ' SPORTS_CRICKET_REMOVED SMALLINT DEFAULT 0,'
|| ' SPORTS_F1_ADDED SMALLINT DEFAULT 0,'
|| ' SPORTS_F1_REMOVED SMALLINT DEFAULT 0,'
|| ' SPORTS_FOOTBALL_ADDED SMALLINT DEFAULT 0,'
|| ' SPORTS_FOOTBALL_REMOVED SMALLINT DEFAULT 0,'
|| ' SPORTS_GOLF_ADDED SMALLINT DEFAULT 0,'
|| ' SPORTS_GOLF_REMOVED SMALLINT DEFAULT 0,'
|| ' SPORTS_PREMIERLEAGUE_ADDED SMALLINT DEFAULT 0,'
|| ' SPORTS_PREMIERLEAGUE_REMOVED SMALLINT DEFAULT 0,'
|| ' CINEMA_ADDED SMALLINT DEFAULT 0,'
|| ' CINEMA_REMOVED SMALLINT DEFAULT 0,'
|| ' PRE_CALL_SPORTS_ACTIVE TINYINT DEFAULT 0,'
|| ' POST_CALL_SPORTS_ACTIVE TINYINT DEFAULT 0,'
|| ' PRE_CALL_MOVIES_ACTIVE TINYINT DEFAULT 0,'
|| ' POST_CALL_MOVIES_ACTIVE TINYINT DEFAULT 0,'
|| ' OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, ' 
|| ' BASIC_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' PREMIUM_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' Sports_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' Cinema_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' BB_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' LR_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' BASIC_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' PREMIUM_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' Sports_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' Cinema_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' BB_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' LR_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' PRE_CALL_SPORTS_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_SPORTS_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' PRE_CALL_MOVIES_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_MOVIES_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' ANY_NEW_OFFER_Active_Leg_1 integer default null,'
|| ' NEW_DTV_OFFER_Active_Leg_1 smallint default null,'
|| ' SKY_KIDS_ADDED smallint  default	0,'
|| ' SKY_KIDS_REMOVED smallint  default	0,'
|| ' SKY_BOXSETS_ADDED smallint  default	0,'
|| ' SKY_BOXSETS_REMOVED smallint  default	0,'
|| ' SPOTIFY_ADDED smallint  default	0,'
|| ' SPOTIFY_REMOVED smallint  default	0,'
|| ' UOD_ADDED smallint default 0,'
|| ' UOD_REMOVED smallint default 0,'
|| ' Netflix_Added_Product VARCHAR(30) DEFAULT NULL, '
|| ' Netflic_Removed_Product VARCHAR(30) DEFAULT NULL, '
|| ' PRE_CALL_SKY_KIDS smallint  default	0,'
|| ' PRE_CALL_SKY_BOXSETS smallint  default	0,'
|| ' POST_CALL_SKY_KIDS smallint 	default	0,'
|| ' POST_CALL_SKY_BOXSETS smallint 	default	0,'
|| ' PRE_CALL_HD_BASIC smallint 	default	0,'
|| ' PRE_CALL_HD_PREMIUM smallint 	default	0,'
|| ' POST_CALL_HD_BASIC smallint 	default	0,'
|| ' POST_CALL_HD_PREMIUM smallint 	default	0,'
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
|| ' TA_attempt_type varchar	(	255	) default	null,'
|| ' last_ta_date date  default	null,'
|| ' Time_Since_Last_TA_Event varchar	(	15	) default	null,'
|| ' ta_call_event smallint  default	0,'
|| ' turnaround_description char	(	20	) default	null,'
|| ' livechat_turnaround_event smallint  default	0,'
|| ' livechat_turnaround_description char	(	29	) default	null,'
|| ' pre_call_LR tinyint  default	0,'
|| ' post_call_LR tinyint  default	0,'
|| ' LR_added tinyint  default	0,'
|| ' LR_removed tinyint  default	0,'
|| ' pre_call_ms_product_holding varchar	(	80	) default	null,'
|| ' pre_call_ms_count int  default	null,'
|| ' post_call_ms_product_holding varchar	(	80	) default	null,'
|| ' post_call_ms_count int  default	null,'
|| ' ms_count_added tinyint  default	0,'
|| ' ms_count_removed tinyint  default	0,'
|| ' MS_Product_Holding_Added varchar	(	80	) default	null,'
|| ' MS_Product_Holding_Removed varchar	(	80	) default	null,'
|| ' pre_call_talk_product_holding varchar	(	80	) default	null,'
|| ' post_call_talk_product_holding varchar	(	80	) default	null,'
|| ' Talk_Product_Holding_Added varchar	(	80	) default	null,'
|| ' Talk_Product_Holding_Removed varchar	(	80	) default	null,'
|| ' pre_call_chelsea_tv tinyint default 0,'
|| ' post_call_chelsea_tv tinyint default 0,'
|| ' pre_call_mutv tinyint default 0,'
|| ' post_call_mutv tinyint default 0,'
|| ' pre_call_liverpool tinyint default 0,'
|| ' post_call_liverpool tinyint default 0,'
|| ' pre_call_skyasia tinyint default 0,'
|| ' post_call_skyasia tinyint default 0,'
|| ' chelsea_tv_Added tinyint default 0,'
|| ' chelsea_tv_Removed tinyint default 0,'
|| ' mutv_Added tinyint default 0,'
|| ' mutv_Removed tinyint default 0,'
|| ' liverpool_Added tinyint default 0,'
|| ' liverpool_Removed tinyint default 0,'
|| ' skyasia_Added tinyint default 0,'
|| ' skyasia_Removed tinyint default 0,'
|| ' longest_time_in_nf_app DECIMAL (5,2) DEFAULT NULL, '
|| ' total_nf_app_launches DECIMAL (5,2) DEFAULT NULL, '
|| ' total_time_in_nf_app DECIMAL (5,2) DEFAULT NULL,'
|| ' Unique_accounts_viewing_nf DECIMAL (5,2) DEFAULT NULL, '
|| ' avg_longest_time_in_nf_app DECIMAL (5,2) DEFAULT NULL,'
|| ' longest_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL, '
|| ' total_spotify_app_launches DECIMAL (5,2) DEFAULT NULL, '
|| ' total_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL ,'
|| ' Unique_accounts_viewing_spotify DECIMAL (5,2) DEFAULT NULL, '
|| ' avg_longest_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL,'
|| ' Basic_contract_status_pre_call tinyint default 0,'
|| ' Talk_contract_status_pre_call tinyint default 0,'
|| ' BB_contract_status_pre_call tinyint default 0,'
|| ' Add_on_contract_status_pre_call tinyint default 0,'
|| ' Overall_contract_status_pre_call tinyint default 0,'
|| ' Basic_contract_status_post_call tinyint default 0,'
|| ' Talk_contract_status_post_call tinyint default 0,'
|| ' BB_contract_status_post_call tinyint default 0,'
|| ' Add_on_contract_status_post_call tinyint default 0,'
|| ' Overall_contract_status_post_call tinyint default 0,'
|| ' pre_call_sports_complete tinyint default 0,'
|| ' post_call_sports_complete tinyint default 0,'
|| ' pre_call_ala_carte_product_holding varchar(30) default 0,'
|| ' post_call_ala_carte_product_holding varchar(30) default 0,'
|| ' pre_call_sky_go_extra tinyint default 0,'
|| ' post_call_sky_go_extra tinyint default 0,'
|| ' ta_in_last_seven_days tinyint default 0,'
|| ' ta_in_last_one_month tinyint default 0,'
|| ' ta_in_last_six_months tinyint default 0,'
|| ' ta_in_last_one_year tinyint default 0'

dba.sp_drop_table 'Decisioning','ECONOMETRICS_TA_CALLS_OFFERS_ACTIVE'
dba.sp_create_table 'Decisioning','ECONOMETRICS_TA_CALLS_OFFERS_ACTIVE', 
   ' YEAR_WEEK VARCHAR (31) DEFAULT NULL,'
|| ' WEEK_START DATE  DEFAULT NULL,'
|| ' COUNTRY VARCHAR (16) DEFAULT NULL,'
|| ' SAVED_FLAG SMALLINT  DEFAULT 0,'
|| ' ACTUAL_OFFER_STATUS VARCHAR (15) DEFAULT NULL,'
|| ' INTENDED_OFFER_STATUS VARCHAR (15) DEFAULT NULL,'
|| ' SPORTS_ADDED SMALLINT  DEFAULT 0,'
|| ' MOVIES_ADDED SMALLINT  DEFAULT 0,'
|| ' LEGACY_SPORTS_SUB_ADDED smallint  default 0,'
|| ' LEGACY_MOVIES_SUB_ADDED smallint  default 0,'
|| ' SPORTS_PACK_SUB_ADDED smallint  default 0,'
|| ' SPORTS_PACK_ADDED smallint  default 0,'
|| ' LEGACY_SPORTS_SUB_REMOVED smallint  default 0,'
|| ' LEGACY_MOVIES_SUB_REMOVED smallint  default 0,'
|| ' SPORTS_PACK_SUB_REMOVED smallint  default 0,'
|| ' SPORTS_PACK_REMOVED smallint  default 0,'
|| ' BASIC_DTV_ADDED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' BASIC_DTV_REMOVED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' HD_LEGACY_ADDED SMALLINT  DEFAULT 0,'
|| ' HD_BASIC_ADDED SMALLINT  DEFAULT 0,'
|| ' HD_PREMIUM_ADDED SMALLINT  DEFAULT 0,'
|| ' MS_ADDED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' SKY_PLUS_ADDED SMALLINT  DEFAULT 0,'
|| ' SKY_GO_EXTRA_ADDED SMALLINT  DEFAULT 0,'
|| ' NOW_TV_ADDED SMALLINT  DEFAULT 0,'
|| ' PRE_CALL_BB_ACTIVE TINYINT  DEFAULT NULL, '
|| ' PRE_CALL_BB_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_BB_ACTIVE TINYINT  DEFAULT NULL, '
|| ' POST_CALL_BB_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_DTV TINYINT  DEFAULT NULL, '
|| ' TALK_ADDED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' SPORTS_REMOVED SMALLINT  DEFAULT 0,'
|| ' MOVIES_REMOVED SMALLINT  DEFAULT 0,'
|| ' HD_LEGACY_REMOVED SMALLINT  DEFAULT 0,'
|| ' HD_BASIC_REMOVED SMALLINT  DEFAULT 0,'
|| ' HD_PREMIUM_REMOVED SMALLINT  DEFAULT 0,'
|| ' MS_REMOVED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' SKY_PLUS_REMOVED SMALLINT  DEFAULT 0,'
|| ' SKY_GO_EXTRA_REMOVED SMALLINT  DEFAULT 0,'
|| ' NOW_TV_REMOVED SMALLINT  DEFAULT 0,'
|| ' TALK_REMOVED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' PRE_CALL_DTV INT  DEFAULT NULL,'
|| ' PRE_CALL_BASIC_DTV_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_BASIC_DTV_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' PRE_CALL_TOP_TIER INT  DEFAULT NULL,'
|| ' PRE_CALL_TOTAL_PREMIUMS INT  DEFAULT NULL,'
|| ' PRE_CALL_TOTAL_SPORTS INT  DEFAULT NULL,'
|| ' PRE_CALL_TOTAL_MOVIES INT  DEFAULT NULL,'
|| ' POST_CALL_TOP_TIER SMALLINT  DEFAULT 0,'
|| ' POST_CALL_TOTAL_PREMIUMS INT  DEFAULT NULL,'
|| ' POST_CALL_TOTAL_SPORTS INT  DEFAULT NULL,'
|| ' POST_CALL_TOTAL_MOVIES INT  DEFAULT NULL,'
|| ' ANY_OFFER_Active SMALLINT  DEFAULT 0,'
|| ' ANY_OFFER_GIVEN SMALLINT  DEFAULT 0, '
|| ' DTV_OFFER_Active SMALLINT  DEFAULT 0,'
|| ' DTV_OFFER_GIVEN SMALLINT  DEFAULT 0, '
|| ' POST_CALL_SKY_PLUS SMALLINT  DEFAULT 0, '
|| ' OFFER_SUB_TYPE VARCHAR (80) DEFAULT NULL,'
|| ' OFFER_DESCRIPTION VARCHAR (465) DEFAULT NULL,'
|| ' MONTHLY_OFFER_VALUE DECIMAL (5,2) DEFAULT NULL,'
|| ' OFFER_DURATION_MTH INT  DEFAULT NULL,'
|| ' TOTAL_OFFER_VALUE DECIMAL (5,2) DEFAULT NULL,'
|| ' AUTO_TRANSFER_OFFER SMALLINT  DEFAULT 0,'
|| ' TENURE int DEFAULT NULL,'
|| ' TV_REGION VARCHAR (100) DEFAULT NULL,'
|| ' NUMBER_OF_TA_EVENTS INT  DEFAULT NULL,'
|| ' SPORTS_COMPLETE_ADDED SMALLINT  DEFAULT 0,'
|| ' SPORTS_COMPLETE_REMOVED SMALLINT  DEFAULT 0,'
|| ' SPORTS_ACTION_ADDED SMALLINT  DEFAULT 0,'
|| ' SPORTS_ACTION_REMOVED SMALLINT  DEFAULT 0,'
|| ' SPORTS_CRICKET_ADDED SMALLINT  DEFAULT 0,'
|| ' SPORTS_CRICKET_REMOVED SMALLINT  DEFAULT 0,'
|| ' SPORTS_F1_ADDED SMALLINT  DEFAULT 0,'
|| ' SPORTS_F1_REMOVED SMALLINT  DEFAULT 0,'
|| ' SPORTS_FOOTBALL_ADDED SMALLINT  DEFAULT 0,'
|| ' SPORTS_FOOTBALL_REMOVED SMALLINT  DEFAULT 0,'
|| ' SPORTS_GOLF_ADDED SMALLINT  DEFAULT 0,'
|| ' SPORTS_GOLF_REMOVED SMALLINT  DEFAULT 0,'
|| ' SPORTS_PREMIERLEAGUE_ADDED SMALLINT  DEFAULT 0,'
|| ' SPORTS_PREMIERLEAGUE_REMOVED SMALLINT  DEFAULT 0,'
|| ' CINEMA_ADDED SMALLINT  DEFAULT 0,'
|| ' CINEMA_REMOVED SMALLINT  DEFAULT 0,'
|| ' PRE_CALL_SPORTS_ACTIVE TINYINT  DEFAULT 0,'
|| ' POST_CALL_SPORTS_ACTIVE TINYINT  DEFAULT 0,'
|| ' PRE_CALL_MOVIES_ACTIVE TINYINT  DEFAULT 0,'
|| ' POST_CALL_MOVIES_ACTIVE TINYINT  DEFAULT 0,'
|| ' OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' BASIC_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' PREMIUM_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' Sports_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' Cinema_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' BB_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' LR_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' BASIC_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' PREMIUM_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' Sports_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' Cinema_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' BB_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' LR_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' PRE_CALL_SPORTS_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_SPORTS_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' PRE_CALL_MOVIES_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_MOVIES_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' ANY_NEW_OFFER_Active_Leg_1 integer default null,'
|| ' NEW_DTV_OFFER_Active_Leg_1 smallint default null,'
|| ' SKY_KIDS_ADDED smallint  default	0,'
|| ' SKY_KIDS_REMOVED smallint  default	0,'
|| ' SKY_BOXSETS_ADDED smallint  default	0,'
|| ' SKY_BOXSETS_REMOVED smallint  default	0,'
|| ' SPOTIFY_ADDED smallint  default	0,'
|| ' SPOTIFY_REMOVED smallint  default	0,'
|| ' UOD_ADDED smallint default 0,'
|| ' UOD_REMOVED smallint default 0,'
|| ' Netflix_Added_Product VARCHAR(30) DEFAULT NULL, '
|| ' Netflic_Removed_Product VARCHAR(30) DEFAULT NULL, '
|| ' PRE_CALL_SKY_KIDS smallint  default	0,'
|| ' PRE_CALL_SKY_BOXSETS smallint  default	0,'
|| ' POST_CALL_SKY_KIDS smallint 	default	0,'
|| ' POST_CALL_SKY_BOXSETS smallint 	default	0,'
|| ' PRE_CALL_HD_BASIC smallint 	default	0,'
|| ' PRE_CALL_HD_PREMIUM smallint 	default	0,'
|| ' POST_CALL_HD_BASIC smallint 	default	0,'
|| ' POST_CALL_HD_PREMIUM smallint 	default	0,'
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
|| ' TA_attempt_type varchar	(	255	) default	null,'
|| ' last_ta_date date  default	null,'
|| ' Time_Since_Last_TA_Event varchar	(	15	) default	null,'
|| ' ta_call_event smallint  default	0,'
|| ' turnaround_description char	(	20	) default	null,'
|| ' livechat_turnaround_event smallint  default	0,'
|| ' livechat_turnaround_description char	(	29	) default	null,'
|| ' pre_call_LR tinyint  default	0,'
|| ' post_call_LR tinyint  default	0,'
|| ' LR_added tinyint  default	0,'
|| ' LR_removed tinyint  default	0,'
|| ' pre_call_ms_product_holding varchar	(	80	) default	null,'
|| ' pre_call_ms_count int  default	null,'
|| ' post_call_ms_product_holding varchar	(	80	) default	null,'
|| ' post_call_ms_count int  default	null,'
|| ' ms_count_added tinyint  default	0,'
|| ' ms_count_removed tinyint  default	0,'
|| ' MS_Product_Holding_Added varchar	(	80	) default	null,'
|| ' MS_Product_Holding_Removed varchar	(	80	) default	null,'
|| ' pre_call_talk_product_holding varchar	(	80	) default	null,'
|| ' post_call_talk_product_holding varchar	(	80	) default	null,'
|| ' Talk_Product_Holding_Added varchar	(	80	) default	null,'
|| ' Talk_Product_Holding_Removed varchar	(	80	) default	null,'
|| ' pre_call_chelsea_tv tinyint default 0,'
|| ' post_call_chelsea_tv tinyint default 0,'
|| ' pre_call_mutv tinyint default 0,'
|| ' post_call_mutv tinyint default 0,'
|| ' pre_call_liverpool tinyint default 0,'
|| ' post_call_liverpool tinyint default 0,'
|| ' pre_call_skyasia tinyint default 0,'
|| ' post_call_skyasia tinyint default 0,'
|| ' chelsea_tv_Added tinyint default 0,'
|| ' chelsea_tv_Removed tinyint default 0,'
|| ' mutv_Added tinyint default 0,'
|| ' mutv_Removed tinyint default 0,'
|| ' liverpool_Added tinyint default 0,'
|| ' liverpool_Removed tinyint default 0,'
|| ' skyasia_Added tinyint default 0,'
|| ' skyasia_Removed tinyint default 0,'
|| ' longest_time_in_nf_app DECIMAL (5,2) DEFAULT NULL, '
|| ' total_nf_app_launches DECIMAL (5,2) DEFAULT NULL, '
|| ' total_time_in_nf_app DECIMAL (5,2) DEFAULT NULL ,'
|| ' Unique_accounts_viewing_nf DECIMAL (5,2) DEFAULT NULL, '
|| ' avg_longest_time_in_nf_app DECIMAL (5,2) DEFAULT NULL,'
|| ' longest_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL, '
|| ' total_spotify_app_launches DECIMAL (5,2) DEFAULT NULL, '
|| ' total_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL ,'
|| ' Unique_accounts_viewing_spotify DECIMAL (5,2) DEFAULT NULL, '
|| ' avg_longest_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL,'
|| ' Basic_contract_status_pre_call tinyint default 0,'
|| ' Talk_contract_status_pre_call tinyint default 0,'
|| ' BB_contract_status_pre_call tinyint default 0,'
|| ' Add_on_contract_status_pre_call tinyint default 0,'
|| ' Overall_contract_status_pre_call tinyint default 0,'
|| ' Basic_contract_status_post_call tinyint default 0,'
|| ' Talk_contract_status_post_call tinyint default 0,'
|| ' BB_contract_status_post_call tinyint default 0,'
|| ' Add_on_contract_status_post_call tinyint default 0,'
|| ' Overall_contract_status_post_call tinyint default 0,'
|| ' pre_call_sports_complete tinyint default 0,'
|| ' post_call_sports_complete tinyint default 0,'
|| ' pre_call_ala_carte_product_holding varchar(30) default 0,'
|| ' post_call_ala_carte_product_holding varchar(30) default 0,'
|| ' pre_call_sky_go_extra tinyint default 0,'
|| ' post_call_sky_go_extra tinyint default 0,'
|| ' ta_in_last_seven_days tinyint default 0,'
|| ' ta_in_last_one_month tinyint default 0,'
|| ' ta_in_last_six_months tinyint default 0,'
|| ' ta_in_last_one_year tinyint default 0'

dba.sp_drop_table 'Decisioning','ECONOMETRICS_TA_CALLS_ACCOUNT_LEVEL'
dba.sp_create_table 'Decisioning','ECONOMETRICS_TA_CALLS_ACCOUNT_LEVEL', 
   ' ACCOUNT_NUMBER varchar (20) default 	null,'
|| ' COUNTRY char (3) default 	null,'
|| ' EVENT_DT date  default 	null,'
|| ' subscription_id varchar (50) default 	null,'
|| ' NUMBER_CALLS int  default 	null,'
|| ' SAVED_FLAG smallint  default 	0,'
|| ' ORDER_DT date  default 	null,'
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
|| ' EVENT_DT_SoD date  default 	null,'
|| ' SPORTS_ADDED smallint  default 	0,'
|| ' MOVIES_ADDED smallint  default 	0,'
|| ' LEGACY_SPORTS_SUB_ADDED smallint  default 	0,'
|| ' LEGACY_MOVIES_SUB_ADDED smallint  default 	0,'
|| ' SPORTS_PACK_SUB_ADDED smallint  default 	0,'
|| ' SPORTS_PACK_ADDED smallint  default 	0,'
|| ' LEGACY_SPORTS_SUB_REMOVED smallint  default 	0,'
|| ' LEGACY_MOVIES_SUB_REMOVED smallint  default 	0,'
|| ' SPORTS_PACK_SUB_REMOVED smallint  default 	0,'
|| ' SPORTS_PACK_REMOVED smallint  default 	0,'
|| ' BASIC_DTV_ADDED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' BASIC_DTV_REMOVED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' HD_LEGACY_ADDED smallint  default 	0,'
|| ' HD_BASIC_ADDED smallint  default 	0,'
|| ' HD_PREMIUM_ADDED smallint  default 	0,'
|| ' MS_ADDED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' SKY_PLUS_ADDED smallint  default 	0,'
|| ' SKY_GO_EXTRA_ADDED smallint  default 	0,'
|| ' NOW_TV_ADDED smallint  default 	0,'
|| ' TALK_ADDED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' SPORTS_REMOVED smallint  default 	0,'
|| ' MOVIES_REMOVED smallint  default 	0,'
|| ' HD_LEGACY_REMOVED smallint  default 	0,'
|| ' HD_BASIC_REMOVED smallint  default 	0,'
|| ' HD_PREMIUM_REMOVED smallint  default 	0,'
|| ' MS_REMOVED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' SKY_PLUS_REMOVED smallint  default 	0,'
|| ' SKY_GO_EXTRA_REMOVED smallint  default 	0,'
|| ' NOW_TV_REMOVED smallint  default 	0,'
|| ' TALK_REMOVED_PRODUCT VARCHAR(80) DEFAULT NULL, '
|| ' SPORTS_COMPLETE_ADDED smallint  default 	0,'
|| ' SPORTS_COMPLETE_REMOVED smallint  default 	0,'
|| ' SPORTS_ACTION_ADDED smallint  default 	0,'
|| ' SPORTS_ACTION_REMOVED smallint  default 	0,'
|| ' SPORTS_CRICKET_ADDED smallint  default 	0,'
|| ' SPORTS_CRICKET_REMOVED smallint  default 	0,'
|| ' SPORTS_F1_ADDED smallint  default 	0,'
|| ' SPORTS_F1_REMOVED smallint  default 	0,'
|| ' SPORTS_FOOTBALL_ADDED smallint  default 	0,'
|| ' SPORTS_FOOTBALL_REMOVED smallint  default 	0,'
|| ' SPORTS_GOLF_ADDED smallint  default 	0,'
|| ' SPORTS_GOLF_REMOVED smallint  default 	0,'
|| ' SPORTS_PREMIERLEAGUE_ADDED smallint  default 	0,'
|| ' SPORTS_PREMIERLEAGUE_REMOVED smallint  default 	0,'
|| ' CINEMA_ADDED smallint  default 	0,'
|| ' CINEMA_REMOVED smallint  default 	0,'
|| ' SKY_KIDS_ADDED smallint  default 	0,'
|| ' SKY_KIDS_REMOVED smallint  default 	0,'
|| ' SKY_BOXSETS_ADDED smallint  default 	0,'
|| ' SKY_BOXSETS_REMOVED smallint  default 	0,'
|| ' SPOTIFY_ADDED smallint  default	0,'
|| ' SPOTIFY_REMOVED smallint  default	0,'
|| ' UOD_ADDED smallint default 0,'
|| ' UOD_REMOVED smallint default 0,'
|| ' Netflix_Added_Product  VARCHAR(80) DEFAULT NULL, '
|| ' Netflix_Removed_Product  VARCHAR(80) DEFAULT NULL, '
|| ' DTV_ADDED smallint  default 	0,'
|| ' DTV_REMOVED smallint  default 	0,'
|| ' BB_ADDED smallint  default 	0,'
|| ' BB_REMOVED smallint  default 	0,'
|| ' PRE_CALL_DTV smallint  default 	0,'
|| ' PRE_CALL_BASIC_DTV_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_BASIC_DTV_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' PRE_CALL_TOP_TIER smallint  default 	0,'
|| ' PRE_CALL_SKY_KIDS smallint  default 	0,'
|| ' PRE_CALL_SKY_BOXSETS smallint  default 	0,'
|| ' PRE_CALL_HD_BASIC int  default 	null,'
|| ' PRE_CALL_HD_PREMIUM int  default 	null,'
|| ' PRE_CALL_TOTAL_PREMIUMS int  default 	null,'
|| ' PRE_CALL_TOTAL_SPORTS int  default 	null,'
|| ' PRE_CALL_TOTAL_MOVIES int  default 	null,'
|| ' BB_ACTIVE tinyint  default 	0,'
|| ' BB_Product_Holding varchar (80) default 	null,'
|| ' PRE_CALL_BB_ACTIVE tinyint  default 	0,'
|| ' PRE_CALL_BB_Product_Holding varchar (80) default 	null,'
|| ' POST_CALL_BB_ACTIVE tinyint  default 	0,'
|| ' POST_CALL_BB_Product_Holding varchar (80) default 	null,'
|| ' POST_CALL_DTV smallint  default 	0,'
|| ' POST_CALL_SKY_KIDS smallint  default 	0,'
|| ' POST_CALL_SKY_BOXSETS smallint  default 	0,'
|| ' POST_CALL_HD_BASIC smallint  default 	0,'
|| ' POST_CALL_HD_PREMIUM smallint  default 	0,'
|| ' POST_CALL_TOP_TIER int  default 	null,'
|| ' POST_CALL_TOTAL_PREMIUMS int  default 	null,'
|| ' POST_CALL_TOTAL_SPORTS int  default 	null,'
|| ' POST_CALL_TOTAL_MOVIES int  default 	null,'
|| ' ACTUAL_OFFER_STATUS varchar (15) default 	null,'
|| ' INTENDED_OFFER_STATUS varchar (15) default 	null,'
|| ' ANY_OFFER_Active smallint  default 	0,'
|| ' ANY_OFFER_GIVEN SMALLINT  DEFAULT 0, '
|| ' Prems_Product_Count tinyint  default 	0,'
|| ' Sports_Product_Count tinyint  default 	0,'
|| ' Movies_Product_Count tinyint  default 	0,'
|| ' PRE_CALL_Prems_Active tinyint  default 	0,'
|| ' Prems_Active tinyint  default 	0,'
|| ' PRE_CALL_Sports_Active tinyint  default 	0,'
|| ' Sports_Active tinyint  default 	0,'
|| ' PRE_CALL_Movies_Active tinyint  default 	0,'
|| ' Movies_Active tinyint  default 	0,'
|| ' Prev_Offer_Start_Dt_Any date  default 	null,'
|| ' Prev_Offer_Intended_end_Dt_Any date  default 	null,'
|| ' Prev_Offer_Actual_End_Dt_Any date  default 	null,'
|| ' Curr_Offer_Start_Dt_Any date  default 	null,'
|| ' Curr_Offer_Intended_end_Dt_Any date  default 	null,'
|| ' Curr_Offer_Actual_End_Dt_Any date  default 	null,'
|| ' Offer_End_Status_Level_1 varchar (30) default 	null,'
|| ' Offer_End_Status_Level_2 varchar (30) default 	null,'
|| ' BASIC_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' PREMIUM_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' Sports_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' Cinema_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' BB_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' LR_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' BASIC_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' PREMIUM_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' Sports_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' Cinema_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' BB_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' LR_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' PRE_CALL_SPORTS_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_SPORTS_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' PRE_CALL_MOVIES_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' POST_CALL_MOVIES_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' ANY_NEW_OFFER_Active_Leg_1 int  default 	null,'
|| ' NEW_DTV_OFFER_Active_leg_1 int  default 	null,'
|| ' Offers_Applied_Lst_1D_Any int  default 	null,'
|| ' Offers_Applied_Lst_1D_DTV int  default 	null,'
|| ' Offers_Applied_Lst_1D_BB int  default 	null,'
|| ' Offers_Applied_Lst_1D_LR int  default 	null,'
|| ' Offers_Applied_Lst_1D_MS int  default 	null,'
|| ' Offers_Applied_Lst_1D_HD int  default 	null,'
|| ' DTV_OFFER_Active smallint  default 	0,'
|| ' DTV_OFFER_GIVEN SMALLINT  DEFAULT 0, '
|| ' BB_OFFER_Active smallint  default 	0,'
|| ' LR_OFFER_Active smallint  default 	0,'
|| ' MS_OFFER_Active smallint  default 	0,'
|| ' HD_OFFER_Active smallint  default 	0,'
|| ' POST_CALL_SKY_PLUS SMALLINT  DEFAULT 0, '
|| ' TENURE int default 	null,'
|| ' TV_REGION varchar (100) default 	null,'
|| ' year_week varchar (31) default 	null,'
|| ' WEEK_START date  default 	null,'
|| ' TA_attempt_type varchar	(	255	) default	null,'
|| ' last_ta_date date  default	null,'
|| ' Time_Since_Last_TA_Event varchar	(	15	) default	null,'
|| ' ta_call_event smallint  default	0,'
|| ' turnaround_description char	(	20	) default	null,'
|| ' livechat_turnaround_event smallint  default	0,'
|| ' livechat_turnaround_description char	(	29	) default	null,'
|| ' pre_call_LR tinyint  default	0,'
|| ' post_call_LR tinyint  default	0,'
|| ' LR_added tinyint  default	0,'
|| ' LR_removed tinyint  default	0,'
|| ' pre_call_ms_product_holding varchar	(	80	) default	null,'
|| ' pre_call_ms_count int  default	null,'
|| ' post_call_ms_product_holding varchar	(	80	) default	null,'
|| ' post_call_ms_count int  default	null,'
|| ' ms_count_added tinyint  default	0,'
|| ' ms_count_removed tinyint  default	0,'
|| ' MS_Product_Holding_Added varchar	(	80	) default	null,'
|| ' MS_Product_Holding_Removed varchar	(	80	) default	null,'
|| ' pre_call_talk_product_holding varchar	(	80	) default	null,'
|| ' post_call_talk_product_holding varchar	(	80	) default	null,'
|| ' Talk_Product_Holding_Added varchar	(	80	) default	null,'
|| ' Talk_Product_Holding_Removed varchar	(	80	) default	null,'
|| ' pre_call_chelsea_tv tinyint default 0,'
|| ' post_call_chelsea_tv tinyint default 0,'
|| ' pre_call_mutv tinyint default 0,'
|| ' post_call_mutv tinyint default 0,'
|| ' pre_call_liverpool tinyint default 0,'
|| ' post_call_liverpool tinyint default 0,'
|| ' pre_call_skyasia tinyint default 0,'
|| ' post_call_skyasia tinyint default 0,'
|| ' chelsea_tv_Added tinyint default 0,'
|| ' chelsea_tv_Removed tinyint default 0,'
|| ' mutv_Added tinyint default 0,'
|| ' mutv_Removed tinyint default 0,'
|| ' liverpool_Added tinyint default 0,'
|| ' liverpool_Removed tinyint default 0,'
|| ' skyasia_Added tinyint default 0,'
|| ' skyasia_Removed tinyint default 0,'
|| ' longest_time_in_nf_app DECIMAL (5,2) DEFAULT NULL, '
|| ' total_nf_app_launches DECIMAL (5,2) DEFAULT NULL, '
|| ' total_time_in_nf_app DECIMAL (5,2) DEFAULT NULL,'
|| ' longest_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL, '
|| ' total_spotify_app_launches DECIMAL (5,2) DEFAULT NULL, '
|| ' total_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL,'
|| ' Basic_contract_status_pre_call tinyint default 0,'
|| ' Talk_contract_status_pre_call tinyint default 0,'
|| ' BB_contract_status_pre_call tinyint default 0,'
|| ' Add_on_contract_status_pre_call tinyint default 0,'
|| ' Overall_contract_status_pre_call tinyint default 0,'
|| ' Basic_contract_status_post_call tinyint default 0,'
|| ' Talk_contract_status_post_call tinyint default 0,'
|| ' BB_contract_status_post_call tinyint default 0,'
|| ' Add_on_contract_status_post_call tinyint default 0,'
|| ' Overall_contract_status_post_call tinyint default 0,'
|| ' pre_call_sports_complete tinyint default 0,'
|| ' post_call_sports_complete tinyint default 0,'
|| ' pre_call_ala_carte_product_holding varchar(30) default 0,'
|| ' post_call_ala_carte_product_holding varchar(30) default 0,'
|| ' pre_call_sky_go_extra tinyint default 0,'
|| ' post_call_sky_go_extra tinyint default 0,'
|| ' ta_in_last_seven_days tinyint default 0,'
|| ' ta_in_last_one_month tinyint default 0,'
|| ' ta_in_last_six_months tinyint default 0,'
|| ' ta_in_last_one_year tinyint default 0'

*/

setuser Decisioning_Procs
GO
DROP PROCEDURE IF EXISTS Decisioning_Procs.Update_Econometrics_TA_Events;
GO
create procedure Decisioning_Procs.Update_Econometrics_TA_Events( PERIOD_START date default null,PERIOD_END date default null ) 
sql security invoker
begin
  set option Query_Temp_Space_Limit = 0;
  if PERIOD_START is null then
    set PERIOD_START = (select max(week_start)-4*7 from Decisioning.ECONOMETRICS_TA_CALLS)
  end if;
  if PERIOD_END is null then
    set PERIOD_END = today()
  end if;
  
  drop table if exists #ta_base;
  select ACCOUNT_NUMBER,COUNTRY,EVENT_DT,subscription_sub_type,subscription_id,
    case when outcome_level_1_Description like '%Turnaround%' then 'TA'
    when outcome_level_1_Description like '%Broadband%' then 'Broadband'
    else outcome_level_1_Description
    end as TA_attempt_type,sum(case when outcome_level_1_Description = 'Turnaround Saved'
    or outcome_level_1_Description = 'Product Only Saved - Broadband'
    or livechat_turnaround_saved = 1 or livechat_outbnd_turnaround_saved = 1 then
      1 else 0 end) as saves,
    count() as TOTAL_CALLS
    into #ta_base
    from CITeam.turnaround_attempts
    where Cancel_Attempt_Flag = 1
    group by ACCOUNT_NUMBER,COUNTRY,EVENT_DT,subscription_sub_type,subscription_id,TA_attempt_type;
  
  drop table if exists #TA_CALLS;
  select ACCOUNT_NUMBER,
    COUNTRY,
    EVENT_DT,
    subscription_sub_type,
    subscription_id,
    TA_attempt_type,
    cast(null as varchar(15)) as Time_Since_Last_TA_Event,
    cast(null as date) as last_ta_date,
    TOTAL_CALLS as NUMBER_CALLS,
    case when SAVES > 0 then 1 else 0 end as SAVED_FLAG
    into #TA_CALLS
    from #TA_Base
    where EVENT_DT >= PERIOD_START
    and EVENT_DT <= PERIOD_END
    and(TOTAL_CALLS = SAVES
    or SAVES = 0) union
  select ACCOUNT_NUMBER,
    COUNTRY,
    EVENT_DT,
    subscription_sub_type,
    subscription_id,
    TA_attempt_type,
    cast(null as varchar(15)) as Time_Since_Last_TA_Event,
    cast(null as date) as last_ta_date,
    SAVES as NUMBER_CALLS,
    1 as SAVED_FLAG
    from #TA_Base
    where EVENT_DT >= PERIOD_START
    and EVENT_DT <= PERIOD_END
    and TOTAL_CALLS <> SAVES
    and SAVES > 0 union
  select ACCOUNT_NUMBER,
    COUNTRY,
    EVENT_DT,
    subscription_sub_type,
    subscription_id,
    TA_attempt_type,
    cast(null as varchar(15)) as Time_Since_Last_TA_Event,
    cast(null as date) as last_ta_date,
    TOTAL_CALLS-SAVES as NUMBER_CALLS,
    0 as SAVED_FLAG
    from #TA_Base
    where EVENT_DT >= PERIOD_START
    and EVENT_DT <= PERIOD_END
    and TOTAL_CALLS <> SAVES
    and SAVES > 0;
	
  drop table if exists #last_ta_date;
  select aa.account_number,aa.event_Dt,aa.subscription_sub_type,aa.TA_attempt_type,max(bb.event_dt) as last_ta_dt,datediff(month,max(bb.event_dt),aa.event_dt) as Time_Since_Last_TA_Event
    into #last_ta_date
    from #ta_Calls as aa
      join CITEam.turnaround_Attempts as bb
      on aa.account_number = bb.account_number
      and aa.subscription_sub_type = bb.subscription_sub_type
      and aa.TA_attempt_type = case when outcome_level_1_Description like '%Turnaround%' then 'TA' when outcome_level_1_Description like '%Broadband%' then 'Broadband' else outcome_level_1_Description end
    where aa.event_dt > bb.event_Dt
    group by aa.account_number,aa.event_Dt,aa.subscription_sub_type,aa.TA_attempt_type;
  
  update #ta_Calls as aa
    set aa.last_ta_date = bb.last_ta_dt,
    aa.Time_Since_Last_TA_Event = case when bb.Time_Since_Last_TA_Event > 36 then '3+ Years'
    when bb.Time_Since_Last_TA_Event between 25 and 36 then '2-3 Years'
    when bb.Time_Since_Last_TA_Event between 13 and 24 then '1-2 Years'
    when bb.Time_Since_Last_TA_Event = 12 then '12 Months'
    when bb.Time_Since_Last_TA_Event = 11 then '11 Months'
    when bb.Time_Since_Last_TA_Event = 10 then '10 Months'
    when bb.Time_Since_Last_TA_Event = 9 then '9 Months'
    when bb.Time_Since_Last_TA_Event = 8 then '8 Months'
    when bb.Time_Since_Last_TA_Event = 7 then '7 Months'
    when bb.Time_Since_Last_TA_Event = 6 then '6 Months'
    when bb.Time_Since_Last_TA_Event = 5 then '5 Months'
    when bb.Time_Since_Last_TA_Event = 4 then '4 Months'
    when bb.Time_Since_Last_TA_Event = 3 then '3 Months'
    when bb.Time_Since_Last_TA_Event = 2 then '2 Months'
    when bb.Time_Since_Last_TA_Event = 1 then '1 Month'
    when bb.Time_Since_Last_TA_Event = 0 then '< 1 Month'
    else null
    end from
    #ta_Calls as aa
    join #last_ta_date as bb
    on aa.account_number = bb.account_number
    and aa.subscription_sub_type = bb.subscription_sub_type
    and aa.TA_attempt_type = bb.TA_attempt_type
    and aa.event_dt = bb.event_Dt;
  
  drop table if exists #TA_CALLS2;
  
  select A.ACCOUNT_NUMBER,
    A.COUNTRY,
    A.EVENT_DT,
    A.subscription_id,
    A.NUMBER_CALLS,
    A.SAVED_FLAG,
    A.TA_attempt_type,
    A.last_ta_date,
    A.Time_Since_Last_TA_Event,
    case when A.TA_attempt_type = 'TA' then 1 else 0 end as ta_call_event,
    case when(A.TA_attempt_type = 'TA' and saved_flag = 1) then 'Turnaround saved'
    when(A.TA_attempt_type = 'TA' and saved_flag = 0) then 'Turnaround not saved'
    else null
    end as turnaround_description,
	case when (A.TA_attempt_type = 'Web Chat' or lower(A.TA_attempt_type) like '%messaging%')  then 1 else 0 end as livechat_turnaround_event,
	
    case when(A.TA_attempt_type = 'Web Chat' and saved_flag = 1) then 'Livechat turnaround saved'
    when(A.TA_attempt_type = 'Web Chat' and saved_flag = 0) then 'Livechat turnaround not saved'
	when lower(A.TA_attempt_type) like '%messaging%' then TA_attempt_type
    else null
    end as livechat_turnaround_description,
    cast(0 as tinyint) as pre_call_LR,
    cast(0 as tinyint) as post_call_LR,
    cast(0 as tinyint) as LR_added,
    cast(0 as tinyint) as LR_removed,
    cast(null as varchar(80)) as pre_call_ms_product_holding,
    cast(0 as integer) as pre_call_ms_count,
    cast(null as varchar(80)) as post_call_ms_product_holding,
    cast(0 as integer) as post_call_ms_count,
    cast(0 as tinyint) as ms_count_added,
    cast(0 as tinyint) as ms_count_removed,
    cast(null as varchar(80)) as MS_Product_Holding_Added,
    cast(null as varchar(80)) as MS_Product_Holding_Removed,
    cast(null as varchar(80)) as pre_call_talk_product_holding,
    cast(null as varchar(80)) as post_call_talk_product_holding,
    cast(null as varchar(80)) as Talk_Product_Holding_Added,
    cast(null as varchar(80)) as Talk_Product_Holding_Removed,
    cast(0 as tinyint) as pre_call_chelsea_tv,
    cast(0 as tinyint) as post_call_chelsea_tv,
    cast(0 as tinyint) as pre_call_mutv,
    cast(0 as tinyint) as post_call_mutv,
    cast(0 as tinyint) as pre_call_liverpool,
    cast(0 as tinyint) as post_call_liverpool,
    cast(0 as tinyint) as pre_call_skyasia,
    cast(0 as tinyint) as post_call_skyasia,
    cast(0 as tinyint) as pre_call_Spotify,
    cast(0 as tinyint) as post_call_Spotify,
    case when SUM(B.SPOTIFY_ADDED) > 0 then 1 else 0 end as Spotify_Added,
    case when SUM(B.SPOTIFY_REMOVED) > 0 then 1 else 0 end as Spotify_Removed,
    case when SUM(B.SPOTIFY_ADDED) > 0 then 1 else 0 end as UOD_ADDED,
    case when SUM(B.SPOTIFY_REMOVED) > 0 then 1 else 0 end as UOD_REMOVED,
    cast(null as varchar(30)) as pre_call_Netflix,
    cast(null as varchar(30)) as post_call_Netflix,
    case when SUM(B.Netflix_Standard_Added) > 0 then 1 else 0 end as Netflix_Standard_Added,
    case when SUM(B.Netflix_Standard_Removed) > 0 then 1 else 0 end as Netflix_Standard_Removed,
    case when SUM(B.Netflix_Premium_Added) > 0 then 1 else 0 end as Netflix_Premium_Added,
    case when SUM(B.Netflix_Premium_Removed) > 0 then 1 else 0 end as Netflix_Premium_Removed,
    cast(null as varchar(30)) as pre_call_ala_carte_product_holding,
    cast(null as varchar(30)) as post_call_ala_carte_product_holding,
    cast(0 as tinyint) as chelsea_tv_Added,
    cast(0 as tinyint) as chelsea_tv_Removed,
    cast(0 as tinyint) as mutv_Added,
    cast(0 as tinyint) as mutv_Removed,
    cast(0 as tinyint) as liverpool_Added,
    cast(0 as tinyint) as liverpool_Removed,
    cast(0 as tinyint) as skyasia_Added,
    cast(0 as tinyint) as skyasia_Removed,
    ORDER_DT,
    cast(A.EVENT_DT-1 as date) as EVENT_DT_SoD,
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
    cast(0 as tinyint) as Basic_contract_status_pre_call,
    cast(0 as tinyint) as Talk_contract_status_pre_call,
    cast(0 as tinyint) as BB_contract_status_pre_call,
    cast(0 as tinyint) as Add_on_contract_status_pre_call,
    cast(0 as tinyint) as Overall_contract_status_pre_call,
    cast(0 as tinyint) as Basic_contract_status_post_call,
    cast(0 as tinyint) as Talk_contract_status_post_call,
    cast(0 as tinyint) as BB_contract_status_post_call,
    cast(0 as tinyint) as Add_on_contract_status_post_call,
    cast(0 as tinyint) as Overall_contract_status_post_call,
    case when SUM(B.SPORTS_ADDED) > 0 then 1 else 0 end as SPORTS_ADDED,
    case when SUM(B.MOVIES_ADDED) > 0 then 1 else 0 end as MOVIES_ADDED,
    case when SUM(B.LEGACY_SPORTS_SUB_ADDED) > 0 then 1 else 0 end as LEGACY_SPORTS_SUB_ADDED,
    case when SUM(B.LEGACY_MOVIES_SUB_ADDED) > 0 then 1 else 0 end as LEGACY_MOVIES_SUB_ADDED,
    case when SUM(B.LEGACY_SPORTS_ADDED) > 0 then 1 else 0 end as LEGACY_SPORTS_ADDED,
    case when SUM(B.LEGACY_MOVIES_ADDED) > 0 then 1 else 0 end as LEGACY_MOVIES_ADDED,
    case when SUM(B.SPORTS_PACK_SUB_ADDED) > 0 then 1 else 0 end as SPORTS_PACK_SUB_ADDED,
    case when SUM(B.SPORTS_PACK_ADDED) > 0 then 1 else 0 end as SPORTS_PACK_ADDED,
    case when SUM(B.LEGACY_SPORTS_SUB_REMOVED) > 0 then 1 else 0 end as LEGACY_SPORTS_SUB_REMOVED,
    case when SUM(B.LEGACY_MOVIES_SUB_REMOVED) > 0 then 1 else 0 end as LEGACY_MOVIES_SUB_REMOVED,
    case when SUM(B.LEGACY_SPORTS_REMOVED) > 0 then 1 else 0 end as LEGACY_SPORTS_REMOVED,
    case when SUM(B.LEGACY_MOVIES_REMOVED) > 0 then 1 else 0 end as LEGACY_MOVIES_REMOVED,
    case when SUM(B.SPORTS_PACK_SUB_REMOVED) > 0 then 1 else 0 end as SPORTS_PACK_SUB_REMOVED,
    case when SUM(B.SPORTS_PACK_REMOVED) > 0 then 1 else 0 end as SPORTS_PACK_REMOVED,
    case when SUM(B.FAMILY_ADDED) > 0 then 1 else 0 end as FAMILY_ADDED,
    case when SUM(B.VARIETY_ADDED) > 0 then 1 else 0 end as VARIETY_ADDED,
    case when SUM(B.ORIGINAL_ADDED) > 0 then 1 else 0 end as ORIGINAL_ADDED,
    case when SUM(B.SKYQ_ADDED) > 0 then 1 else 0 end as SKYQ_LEGACY_ADDED,
    case when SUM(B.HD_LEGACY_ADDED) > 0 then 1 else 0 end as HD_LEGACY_ADDED,
    case when SUM(B.HD_BASIC_ADDED) > 0 then 1 else 0 end as HD_BASIC_ADDED,
    case when SUM(B.HD_PREMIUM_ADDED) > 0 then 1 else 0 end as HD_PREMIUM_ADDED,
    case when SUM(B.MULTISCREEN_ADDED) > 0 then 1 else 0 end as CLASSIC_MS_ADDED,
    case when SUM(B.MULTISCREEN_PLUS_ADDED) > 0 then 1 else 0 end as SKYQ_MS_ADDED,
    case when SUM(B.SKY_PLUS_ADDED) > 0 then 1 else 0 end as SKY_PLUS_ADDED,
    case when SUM(B.SKY_GO_EXTRA_ADDED) > 0 then 1 else 0 end as SKY_GO_EXTRA_ADDED,
    case when SUM(B.NOW_TV_ADDED) > 0 then 1 else 0 end as NOW_TV_ADDED,
    case when SUM(B.BB_UNLIMITED_ADDED) > 0 then 1 else 0 end as BB_UNLIMITED_ADDED,
    case when SUM(B.BB_LITE_ADDED) > 0 then 1 else 0 end as BB_LITE_ADDED,
    case when SUM(B.BB_FIBRE_CAP_ADDED) > 0 then 1 else 0 end as BB_FIBRE_CAP_ADDED,
    case when SUM(B.BB_FIBRE_UNLIMITED_ADDED) > 0 then 1 else 0 end as BB_FIBRE_UNLIMITED_ADDED,
    case when SUM(B.TALKU_ADDED) > 0 then 1 else 0 end as TALKU_ADDED,
    case when SUM(B.TALKW_ADDED) > 0 then 1 else 0 end as TALKW_ADDED,
    case when SUM(B.TALKF_ADDED) > 0 then 1 else 0 end as TALKF_ADDED,
    case when SUM(B.TALKA_ADDED) > 0 then 1 else 0 end as TALKA_ADDED,
    case when SUM(B.TALKP_ADDED) > 0 then 1 else 0 end as TALKP_ADDED,
    case when SUM(B.TALKO_ADDED) > 0 then 1 else 0 end as TALKO_ADDED,
    case when SUM(B.SPORTS_REMOVED) > 0 then 1 else 0 end as SPORTS_REMOVED,
    case when SUM(B.MOVIES_REMOVED) > 0 then 1 else 0 end as MOVIES_REMOVED,
    case when SUM(B.FAMILY_REMOVED) > 0 then 1 else 0 end as FAMILY_REMOVED,
    case when SUM(B.VARIETY_REMOVED) > 0 then 1 else 0 end as VARIETY_REMOVED,
    case when SUM(B.ORIGINAL_REMOVED) > 0 then 1 else 0 end as ORIGINAL_REMOVED,
    case when SUM(B.SKYQ_REMOVED) > 0 then 1 else 0 end as SKYQ_LEGACY_REMOVED,
    case when SUM(B.HD_LEGACY_REMOVED) > 0 then 1 else 0 end as HD_LEGACY_REMOVED,
    case when SUM(B.HD_BASIC_REMOVED) > 0 then 1 else 0 end as HD_BASIC_REMOVED,
    case when SUM(B.HD_PREMIUM_REMOVED) > 0 then 1 else 0 end as HD_PREMIUM_REMOVED,
    case when SUM(B.MULTISCREEN_REMOVED) > 0 then 1 else 0 end as CLASSIC_MS_REMOVED,
    case when SUM(B.MULTISCREEN_PLUS_REMOVED) > 0 then 1 else 0 end as SKYQ_MS_REMOVED,
    case when SUM(B.SKY_PLUS_REMOVED) > 0 then 1 else 0 end as SKY_PLUS_REMOVED,
    case when SUM(B.SKY_GO_EXTRA_REMOVED) > 0 then 1 else 0 end as SKY_GO_EXTRA_REMOVED,
    case when SUM(B.NOW_TV_REMOVED) > 0 then 1 else 0 end as NOW_TV_REMOVED,
    case when SUM(B.BB_UNLIMITED_REMOVED) > 0 then 1 else 0 end as BB_UNLIMITED_REMOVED,
    case when SUM(B.BB_LITE_REMOVED) > 0 then 1 else 0 end as BB_LITE_REMOVED,
    case when SUM(B.BB_FIBRE_CAP_REMOVED) > 0 then 1 else 0 end as BB_FIBRE_CAP_REMOVED,
    case when SUM(B.BB_FIBRE_UNLIMITED_REMOVED) > 0 then 1 else 0 end as BB_FIBRE_UNLIMITED_REMOVED,
    case when SUM(B.TALKU_REMOVED) > 0 then 1 else 0 end as TALKU_REMOVED,
    case when SUM(B.TALKW_REMOVED) > 0 then 1 else 0 end as TALKW_REMOVED,
    case when SUM(B.TALKF_REMOVED) > 0 then 1 else 0 end as TALKF_REMOVED,
    case when SUM(B.TALKA_REMOVED) > 0 then 1 else 0 end as TALKA_REMOVED,
    case when SUM(B.TALKP_REMOVED) > 0 then 1 else 0 end as TALKP_REMOVED,
    case when SUM(B.TALKO_REMOVED) > 0 then 1 else 0 end as TALKO_REMOVED,
    case when SUM(B.SPORTS_COMPLETE_ADDED) > 0 then 1 else 0 end as SPORTS_COMPLETE_ADDED,
    case when SUM(B.SPORTS_COMPLETE_REMOVED) > 0 then 1 else 0 end as SPORTS_COMPLETE_REMOVED,
    case when SUM(B.SPORTS_ACTION_ADDED) > 0 then 1 else 0 end as SPORTS_ACTION_ADDED,
    case when SUM(B.SPORTS_ACTION_REMOVED) > 0 then 1 else 0 end as SPORTS_ACTION_REMOVED,
    case when SUM(B.SPORTS_CRICKET_ADDED) > 0 then 1 else 0 end as SPORTS_CRICKET_ADDED,
    case when SUM(B.SPORTS_CRICKET_REMOVED) > 0 then 1 else 0 end as SPORTS_CRICKET_REMOVED,
    case when SUM(B.SPORTS_F1_ADDED) > 0 then 1 else 0 end as SPORTS_F1_ADDED,
    case when SUM(B.SPORTS_F1_REMOVED) > 0 then 1 else 0 end as SPORTS_F1_REMOVED,
    case when SUM(B.SPORTS_FOOTBALL_ADDED) > 0 then 1 else 0 end as SPORTS_FOOTBALL_ADDED,
    case when SUM(B.SPORTS_FOOTBALL_REMOVED) > 0 then 1 else 0 end as SPORTS_FOOTBALL_REMOVED,
    case when SUM(B.SPORTS_GOLF_ADDED) > 0 then 1 else 0 end as SPORTS_GOLF_ADDED,
    case when SUM(B.SPORTS_GOLF_REMOVED) > 0 then 1 else 0 end as SPORTS_GOLF_REMOVED,
    case when SUM(B.SPORTS_PREMIERLEAGUE_ADDED) > 0 then 1 else 0 end as SPORTS_PREMIERLEAGUE_ADDED,
    case when SUM(B.SPORTS_PREMIERLEAGUE_REMOVED) > 0 then 1 else 0 end as SPORTS_PREMIERLEAGUE_REMOVED,
    case when SUM(B.CINEMA_ADD_ON_ADDED) > 0 then 1 else 0 end as CINEMA_ADDED,
    case when SUM(B.CINEMA_ADD_ON_REMOVED) > 0 then 1 else 0 end as CINEMA_REMOVED,
    case when SUM(B.KIDS_ADDED) > 0 then 1 else 0 end as SKY_KIDS_ADDED,
    case when SUM(B.KIDS_REMOVED) > 0 then 1 else 0 end as SKY_KIDS_REMOVED,
    case when SUM(B.BOXSETS_ADDED) > 0 then 1 else 0 end as SKY_BOXSETS_ADDED,
    case when SUM(B.BOXSETS_REMOVED) > 0 then 1 else 0 end as SKY_BOXSETS_REMOVED,
    case when SUM(case when B.DTV_ADDED_PRODUCT = 'Sky Entertainment' then 1 else 0 end) > 0 then 1 else 0 end as SKY_ENT_ADDED,
    case when SUM(case when B.DTV_REMOVED_PRODUCT = 'Sky Entertainment' then 1 else 0 end) > 0 then 1 else 0 end as SKY_ENT_REMOVED,
    case when SUM(B.DTV_ADDED) > 0 then 1 else 0 end as DTV_ADDED,
    case when SUM(B.DTV_REMOVED) > 0 then 1 else 0 end as DTV_REMOVED,
    case when SUM(B.BB_ADDED) > 0 then 1 else 0 end as BB_ADDED,
    case when SUM(B.BB_REMOVED) > 0 then 1 else 0 end as BB_REMOVED
    into #TA_CALLS2
    from #TA_CALLS as A
      left outer join CITEAM.orders_Daily as B
      on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and A.EVENT_DT = B.ORDER_DT
    group by A.ACCOUNT_NUMBER,
    A.COUNTRY,
    A.EVENT_DT,
    A.subscription_id,
    A.NUMBER_CALLS,
    A.SAVED_FLAG,
    A.last_ta_date,
    A.Time_Since_Last_TA_Event,
    TA_attempt_type,
    ta_call_event,
    turnaround_description,
    livechat_turnaround_event,
    livechat_turnaround_description,
    ORDER_DT,
    EVENT_DT_SoD;
  -- ASR Pivot start 
  select B.ACCOUNT_NUMBER,
    B.effective_from_dt,
    B.effective_to_dt,
    B.COUNTRY,
    B.DTV_ACTIVE_SUBSCRIPTION as DTV,
    case when B.PRODUCT_HOLDING like '%Original%' then 1 else 0 end as ORIGINAL,
    case when B.PRODUCT_HOLDING like '%Variety%' then 1 else 0 end as VARIETY,
    case when B.PRODUCT_HOLDING like '%Box Sets%' then 1 else 0 end as FAMILY,
    case when B.PRODUCT_HOLDING like '%Sky Q%' then 1 else 0 end as SKYQ,
    case when B.PRODUCT_HOLDING like '%Sky Entertainment%' then 1 else 0 end as SKY_ENT,
    B.TT_Active_Subscription as TOP_TIER,
    B.movies_Active_subscription as MOVIES,
    B.sports_Active_subscription as SPORTS,
    B.HD_active_subscription as HD_ANY,
    B.HD_active_subscription as HD_LEGACY,
    cast(null as integer) as HD_BASIC,
    cast(null as integer) as HD_PREMIUM,
    B.MS_active_subscription as MULTISCREEN,
    null as MULTISCREEN_VOL,
    B.SGE_Active_subscription as SKY_GO_EXTRA,
    B.product_holding,
    cast(0 as tinyint) as BB_ACTIVE,
    cast(null as varchar(80)) as BB_Product_Holding,
    cast(0 as tinyint) as SKY_KIDS,
    cast(0 as tinyint) as BOX_SETS,
    cast(0 as tinyint) as SKY_PLUS
    into #ASR_ECON_ONE
    from CITeam.active_subscriber_Report as B
    where B.dtv_Active_subscription = 1;
  select asr.*
    into #bb_only_econ
    from CITeam.active_subscriber_Report as asr
    where asr.bb_Active_subscription = 1;
  update #bb_only_econ as base
    set base.dtv_active_subscription = asr.dtv_active_subscription from
    #bb_only_econ as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.effective_from_dt between asr.effective_from_dt and asr.effective_to_dt-1 and asr.dtv_active_subscription = 1;
  delete from #bb_only_econ where dtv_active_subscription = 1;
  select B.ACCOUNT_NUMBER,
    B.effective_from_dt,
    B.effective_to_dt,
    B.COUNTRY,
    B.DTV_ACTIVE_SUBSCRIPTION as DTV,
    case when B.PRODUCT_HOLDING like '%Original%' then 1 else 0 end as ORIGINAL,
    case when B.PRODUCT_HOLDING like '%Variety%' then 1 else 0 end as VARIETY,
    case when B.PRODUCT_HOLDING like '%Box Sets%' then 1 else 0 end as FAMILY,
    case when B.PRODUCT_HOLDING like '%Sky Q%' then 1 else 0 end as SKYQ,
    case when B.PRODUCT_HOLDING like '%Sky Entertainment%' then 1 else 0 end as SKY_ENT,
    B.TT_Active_Subscription as TOP_TIER,
    B.movies_Active_subscription as MOVIES,
    B.sports_Active_subscription as SPORTS,
    B.HD_active_subscription as HD_ANY,
    B.HD_active_subscription as HD_LEGACY,
    cast(null as integer) as HD_BASIC,
    cast(null as integer) as HD_PREMIUM,
    B.MS_active_subscription as MULTISCREEN,
    null as MULTISCREEN_VOL,
    B.SGE_Active_subscription as SKY_GO_EXTRA,
    B.product_holding,
    cast(0 as tinyint) as BB_ACTIVE,
    B.product_holding as BB_Product_Holding,
    cast(0 as tinyint) as SKY_KIDS,
    cast(0 as tinyint) as BOX_SETS,
    cast(0 as tinyint) as SKY_PLUS
    into #ASR_ECON_TWO
    from #bb_only_econ as B;
  select Base.*
    into #ASR_ECON
    from(select E_Base.* from #ASR_ECON_ONE as E_Base union
      select E_Base.* from #ASR_ECON_TWO as E_Base) as Base;
  update #ASR_ECON as base
    set base.BB_ACTIVE = asr.BB_Active_subscription,base.BB_Product_Holding = asr.product_holding from
    #ASR_ECON as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.effective_from_dt between asr.effective_from_dt and asr.effective_to_dt-1 and asr.BB_active_subscription = 1;
  update #ASR_ECON as base
    set base.top_tier = asr.tt_Active_subscription from
    #ASR_ECON as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.effective_from_dt between asr.effective_from_dt and asr.effective_to_dt-1 and asr.tt_active_subscription = 1;
  update #ASR_ECON as base
    set base.SKY_KIDS = asr.kids_Active_subscription from
    #ASR_ECON as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.effective_from_dt between asr.effective_from_dt and asr.effective_to_dt-1 and asr.kids_Active_subscription = 1;
  update #ASR_ECON as base
    set base.BOX_SETS = asr.boxsets_Active_subscription from
    #ASR_ECON as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.effective_from_dt between asr.effective_from_dt and asr.effective_to_dt-1 and asr.boxsets_Active_subscription = 1;
  update #ASR_ECON as base
    set base.hd_any = asr.HD_Active_subscription,
    hd_legacy = case when asr.CURRENT_PRODUCT_SK = 687 then 1 else 0 end,
    hd_basic = case when asr.CURRENT_PRODUCT_SK in( 43678,53103,53539 ) then 1 else 0 end from
    #ASR_ECON as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.effective_from_dt between asr.effective_from_dt and asr.effective_to_dt-1 and asr.HD_active_subscription = 1
    and asr.CURRENT_PRODUCT_SK <> 43679;
  update #ASR_ECON as base
    set base.hd_any = asr.HD_Active_subscription,
    hd_premium = case when asr.CURRENT_PRODUCT_SK = 43679 then 1 else 0 end from
    #ASR_ECON as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.effective_from_dt between asr.effective_from_dt and asr.effective_to_dt-1 and asr.HD_active_subscription = 1
    and asr.CURRENT_PRODUCT_SK = 43679;
  update #ASR_ECON as base
    set base.SKY_PLUS = 1 from
    #ASR_ECON as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.effective_from_Dt between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.product_holding = 'DTV Sky+';
  update #ASR_ECON as base
    set base.SKY_GO_EXTRA = 1 from
    #ASR_ECON as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.effective_from_Dt between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.SGE_Active_subscription = 1;
  -- end of pivot \x09
  drop table if exists #TA_CALLS3;
  select A.*,
    COALESCE(B.DTV,0) as PRE_CALL_DTV,
    COALESCE(B.ORIGINAL,0) as PRE_CALL_ORIGINAL,
    COALESCE(B.VARIETY,0) as PRE_CALL_VARIETY,
    COALESCE(B.FAMILY,0) as PRE_CALL_FAMILY,
    COALESCE(B.SKYQ,0) as PRE_CALL_SKYQ,
    COALESCE(B.TOP_TIER,0) as PRE_CALL_TOP_TIER,
    COALESCE(B.SKY_ENT,0) as PRE_CALL_SKY_ENT,
    COALESCE(B.SKY_KIDS,0) as PRE_CALL_SKY_KIDS,
    COALESCE(B.BOX_SETS,0) as PRE_CALL_SKY_BOXSETS,
    COALESCE(B.hd_basic,0) as PRE_CALL_HD_BASIC,
    COALESCE(B.hd_premium,0) as PRE_CALL_HD_PREMIUM,
    COALESCE(B.SKY_GO_EXTRA,0) as PRE_CALL_SKY_GO_EXTRA,
    cast(0 as integer) as PRE_CALL_TOTAL_PREMIUMS,
    cast(0 as integer) as PRE_CALL_TOTAL_SPORTS,
    cast(0 as integer) as PRE_CALL_TOTAL_MOVIES,
    cast(0 as tinyint) as BB_ACTIVE,
    cast(null as varchar(80)) as BB_Product_Holding,
    cast(0 as tinyint) as PRE_CALL_BB_ACTIVE,
    cast(null as varchar(80)) as PRE_CALL_BB_Product_Holding,
    cast(0 as tinyint) as POST_CALL_BB_ACTIVE,
    cast(null as varchar(80)) as POST_CALL_BB_Product_Holding,
    case when(COALESCE(B.DTV,0)+A.DTV_ADDED-A.DTV_REMOVED) > 0 then 1 else 0 end as POST_CALL_DTV,
    case when(COALESCE(B.SKY_PLUS,0)+A.SKY_PLUS_ADDED-A.SKY_PLUS_REMOVED) > 0 then 1 else 0 end as POST_CALL_SKY_PLUS,
    case when(COALESCE(B.ORIGINAL,0)+A.ORIGINAL_ADDED-A.ORIGINAL_REMOVED) > 0 then 1 else 0 end as POST_CALL_ORIGINAL,
    case when(COALESCE(B.VARIETY,0)+A.VARIETY_ADDED-A.VARIETY_REMOVED) > 0 then 1 else 0 end as POST_CALL_VARIETY,
    case when(COALESCE(B.FAMILY,0)+A.FAMILY_ADDED-A.FAMILY_REMOVED) > 0 then 1 else 0 end as POST_CALL_FAMILY,
    case when(COALESCE(B.SKYQ,0)+A.SKYQ_LEGACY_ADDED-A.SKYQ_LEGACY_REMOVED) > 0 then 1 else 0 end as POST_CALL_SKYQ,
    case when(COALESCE(B.SKY_ENT,0)+A.SKY_ENT_ADDED-A.SKY_ENT_REMOVED) > 0 then 1 else 0 end as POST_CALL_SKY_ENT,
    case when(COALESCE(B.SKY_KIDS,0)+A.SKY_KIDS_ADDED-A.SKY_KIDS_REMOVED) > 0 then 1 else 0 end as POST_CALL_SKY_KIDS,
    case when(COALESCE(B.BOX_SETS,0)+A.SKY_BOXSETS_ADDED-A.SKY_BOXSETS_REMOVED) > 0 then 1 else 0 end as POST_CALL_SKY_BOXSETS,
    case when(COALESCE(B.hd_basic,0)+A.HD_BASIC_ADDED-A.HD_BASIC_REMOVED) > 0 then 1 else 0 end as POST_CALL_HD_BASIC,
    case when(COALESCE(B.hd_premium,0)+A.HD_PREMIUM_ADDED-A.HD_PREMIUM_REMOVED) > 0 then 1 else 0 end as POST_CALL_HD_PREMIUM,
    cast(0 as integer) as POST_CALL_TOP_TIER,
    cast(0 as integer) as POST_CALL_TOTAL_PREMIUMS,
    cast(0 as integer) as POST_CALL_TOTAL_SPORTS,
    cast(0 as integer) as POST_CALL_TOTAL_MOVIES,
    cast(null as varchar(15)) as ACTUAL_OFFER_STATUS,
    cast(null as varchar(15)) as INTENDED_OFFER_STATUS,
    0 as ANY_OFFER_Active,
    0 as DTV_OFFER_Active,
    0 as BB_OFFER_Active,
    0 as LR_OFFER_Active,
    0 as MS_OFFER_Active,
    0 as HD_OFFER_Active,
    0 as ANY_OFFER_GIVEN,
    0 as DTV_OFFER_GIVEN,
    cast(0 as tinyint) as Prems_Product_Count,
    cast(0 as tinyint) as Sports_Product_Count,
    cast(0 as tinyint) as Movies_Product_Count,
    cast(0 as tinyint) as PRE_CALL_Prems_Active,
    cast(0 as tinyint) as Prems_Active,
    cast(0 as tinyint) as PRE_CALL_Sports_Active,
    cast(0 as tinyint) as Sports_Active,
    cast(0 as tinyint) as PRE_CALL_Movies_Active,
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
    cast(0 as integer) as ANY_NEW_OFFER_Active_Leg_1,
    cast(0 as integer) as NEW_DTV_OFFER_Active_leg_1,
    cast(0 as integer) as Offers_Applied_Lst_1D_Any,
    cast(0 as integer) as Offers_Applied_Lst_1D_DTV,
    cast(0 as integer) as Offers_Applied_Lst_day_any,
    cast(0 as integer) as Offers_Applied_Lst_day_dtv,
    cast(0 as integer) as Offers_Applied_Lst_1D_BB,
    cast(0 as integer) as Offers_Applied_Lst_1D_LR,
    cast(0 as integer) as Offers_Applied_Lst_1D_MS,
    cast(0 as integer) as Offers_Applied_Lst_1D_HD,
    cast(null as varchar(30)) as pre_call_sports_product_holding,
    cast(null as varchar(30)) as post_call_sports_product_holding,
    cast(null as varchar(30)) as pre_call_movies_product_holding,
    cast(null as varchar(30)) as post_call_movies_product_holding,
    -- New fields 31/12/2018 
    cast(0 as tinyint) as pre_call_sports_complete,
    cast(0 as tinyint) as post_call_sports_complete,
    cast(0 as tinyint) as post_call_sky_go_extra,
    cast(0 as tinyint) as ta_in_last_seven_days,
    cast(0 as tinyint) as ta_in_last_one_month,
    cast(0 as tinyint) as ta_in_last_six_months,
    cast(0 as tinyint) as ta_in_last_one_year
    into #TA_CALLS3
    from #TA_CALLS2 as A
      left outer join #ASR_ECON as B
      on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    where A.event_dt-1 between B.effective_from_dt and B.effective_to_dt-1;
  -- update last TA event flags 
  update #ta_calls3
    set ta_in_last_seven_days = case when datediff(day,last_ta_date,event_dt) <= 7 then 1 else 0 end,
    ta_in_last_one_month = case when Time_Since_Last_TA_Event = '1 Month' then 1 else 0 end,
    ta_in_last_six_months = case when Time_Since_Last_TA_Event = '6 Months' then 1 else 0 end,
    ta_in_last_one_year = case when Time_Since_Last_TA_Event = '12 Months' then 1 else 0 end;
  -- Product holding 
  update #TA_CALLS3 as base
    set base.PRE_CALL_SPORTS_PRODUCT_HOLDING = asr.product_holding,
    base.pre_call_sports_complete = case when lower(asr.product_holding) like '%complete%' then 1 else 0 end from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT_SoD between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.Sports_Active_subscription = 1;
  update #TA_CALLS3 as base
    set base.PRE_CALL_MOVIES_PRODUCT_HOLDING = asr.product_holding from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT_SoD between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.Movies_Active_subscription = 1;
  update #TA_CALLS3 as base
    set base.POST_CALL_SPORTS_PRODUCT_HOLDING = asr.product_holding,
    base.post_call_sports_complete = case when lower(asr.product_holding) like '%complete%' then 1 else 0 end from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.Sports_Active_subscription = 1;
  -- update post call sky go extra 
  update #TA_CALLS3 as base
    set base.post_call_sky_go_extra = 1 from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.SGE_Active_subscription = 1;
  update #TA_CALLS3 as base
    set base.POST_CALL_MOVIES_PRODUCT_HOLDING = asr.product_holding from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.Movies_Active_subscription = 1;
  call Decisioning_Procs.Add_Active_Subscriber_Product_Holding_Econ('#TA_CALLS3','EVENT_DT_SoD','Sports','Update Only','Sports_Active','Sports_Product_Count');
  call Decisioning_Procs.Add_Active_Subscriber_Product_Holding_Econ('#TA_CALLS3','EVENT_DT_SoD','Movies','Update Only','Movies_Active','Movies_Product_Count');
  call Decisioning_Procs.Add_Active_Subscriber_Product_Holding_Econ('#TA_CALLS3','EVENT_DT_SoD','Prems','Update Only','Prems_Active','Prems_Product_Count');
  call Decisioning_Procs.Add_Active_Subscriber_Product_Holding('#TA_CALLS3','EVENT_DT_SoD','BB','Update Only','BB_ACTIVE','BB_PRODUCT_HOLDING');
  update #TA_CALLS3
    set PRE_CALL_BB_ACTIVE = BB_ACTIVE,
    PRE_CALL_BB_PRODUCT_HOLDING = BB_PRODUCT_HOLDING;
  update #TA_CALLS3
    set BB_ACTIVE = 0,
    BB_PRODUCT_HOLDING = null;
  call Decisioning_Procs.Add_Active_Subscriber_Product_Holding('#TA_CALLS3','EVENT_DT','BB','Update Only','BB_ACTIVE','BB_PRODUCT_HOLDING');
  update #TA_CALLS3
    set POST_CALL_BB_ACTIVE = BB_ACTIVE,
    POST_CALL_BB_PRODUCT_HOLDING = BB_PRODUCT_HOLDING;
  commit work;
  update #TA_CALLS3
    set PRE_CALL_TOTAL_SPORTS = case when Sports_Product_Count > 0 then Sports_Product_Count
    when SPORTS_REMOVED > 0 then LEGACY_SPORTS_REMOVED+SPORTS_PACK_REMOVED
    else Sports_Product_Count
    end,
    PRE_CALL_TOTAL_MOVIES = case when Movies_Product_Count > 0 then Movies_Product_Count
    when MOVIES_REMOVED > 0 then
      LEGACY_MOVIES_REMOVED+CINEMA_REMOVED
    else Movies_Product_Count
    end;
  commit work;
  update #TA_CALLS3
    set PRE_CALL_TOTAL_PREMIUMS = PRE_CALL_TOTAL_SPORTS+PRE_CALL_TOTAL_MOVIES;
  commit work;
  update #TA_CALLS3
    set PRE_CALL_Prems_Active = case when PRE_CALL_TOTAL_PREMIUMS > 0 then 1 else 0 end,
    PRE_CALL_Sports_Active = case when PRE_CALL_TOTAL_SPORTS > 0 then 1 else 0 end,
    PRE_CALL_Movies_Active = case when PRE_CALL_TOTAL_MOVIES > 0 then 1 else 0 end;
  commit work;
  update #TA_CALLS3
    set Sports_Active = 0,
    Sports_Product_Count = 0,
    Movies_Active = 0,
    Movies_Product_Count = 0,
    Prems_Active = 0,
    Prems_Product_Count = 0;
  commit work;
  call Decisioning_Procs.Add_Active_Subscriber_Product_Holding_Econ('#TA_CALLS3','event_Dt','Sports','Update Only','Sports_Active','Sports_Product_Count');
  call Decisioning_Procs.Add_Active_Subscriber_Product_Holding_Econ('#TA_CALLS3','event_Dt','Movies','Update Only','Movies_Active','Movies_Product_Count');
  update #TA_CALLS3
    set POST_CALL_TOTAL_SPORTS = case when Sports_Product_Count > 0 then Sports_Product_Count
    when SPORTS_PACK_SUB_ADDED > 0 then SPORTS_PACK_ADDED
    when SPORTS_PACK_ADDED > 0 then Pre_Call_Total_Sports+SPORTS_PACK_ADDED
    when LEGACY_SPORTS_ADDED > 0 then LEGACY_SPORTS_ADDED
    when SPORTS_PACK_SUB_REMOVED > 0 then 0
    when SPORTS_PACK_REMOVED > 0 then Pre_Call_Total_Sports-SPORTS_PACK_REMOVED
    when LEGACY_SPORTS_REMOVED > 0 then 0
    else
      Pre_Call_Total_Sports
    end,
    POST_CALL_TOTAL_MOVIES = case when Movies_Product_Count > 0 then Movies_Product_Count
    when CINEMA_ADDED > 0 then CINEMA_ADDED
    when LEGACY_MOVIES_ADDED > 0 then LEGACY_MOVIES_ADDED
    when CINEMA_REMOVED > 0 then 0
    when LEGACY_MOVIES_REMOVED > 0 then 0
    else
      Pre_Call_Total_Movies
    end;
  commit work;
  update #TA_CALLS3
    set POST_CALL_TOP_TIER = case when(POST_CALL_TOTAL_SPORTS > 0 and POST_CALL_TOTAL_MOVIES > 0) then 1 else 0 end;
  update #TA_CALLS3
    set POST_CALL_TOTAL_PREMIUMS = POST_CALL_TOTAL_SPORTS+POST_CALL_TOTAL_MOVIES;
  commit work;
  update #TA_CALLS3
    set PRE_CALL_TOTAL_SPORTS = case when PRE_CALL_TOTAL_SPORTS > 6 then 6 else PRE_CALL_TOTAL_SPORTS end;
  update #TA_CALLS3
    set POST_CALL_TOTAL_PREMIUMS = case when POST_CALL_TOTAL_PREMIUMS < 0 then 0 else POST_CALL_TOTAL_PREMIUMS end,
    POST_CALL_TOTAL_SPORTS = case when POST_CALL_TOTAL_SPORTS < 0 then 0 else POST_CALL_TOTAL_SPORTS end,
    POST_CALL_TOTAL_MOVIES = case when POST_CALL_TOTAL_MOVIES < 0 then 0 else POST_CALL_TOTAL_MOVIES end;
  commit work;
  update #TA_CALLS3
    set Prems_Active = case when POST_CALL_TOTAL_PREMIUMS > 0 then 1 else 0 end,
    Sports_Active = case when POST_CALL_TOTAL_SPORTS > 0 then 1 else 0 end,
    Movies_Active = case when POST_CALL_TOTAL_MOVIES > 0 then 1 else 0 end;
  commit work;
  update #TA_CALLS3 as base
    set base.pre_call_lr = asr.lr_active_subscription from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT_SoD between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.lr_active_subscription = 1;
  update #TA_CALLS3 as base
    set base.post_call_lr = asr.lr_active_subscription from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.lr_active_subscription = 1;
  update #TA_CALLS3 as base
    set base.pre_call_Spotify = asr.Spotify_active_subscription from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT_SoD between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.Spotify_active_subscription = 1;
  update #TA_CALLS3 as base
    set base.post_call_Spotify = asr.Spotify_active_subscription from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.Spotify_active_subscription = 1;
  update #TA_CALLS3 as base
    set base.pre_call_Netflix = asr.product_holding from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT_SoD between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.Netflix_active_subscription = 1;
  update #TA_CALLS3 as base
    set base.post_call_Netflix = asr.product_holding from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.Netflix_active_subscription = 1;
  select account_number,effective_from_Dt,effective_to_Dt,product_holding,count() as vol
    into #asr_ms
    from CITeam.active_subscriber_Report as asr
    where ms_Active_subscription = 1
    group by account_number,effective_from_Dt,effective_to_Dt,product_holding;
  update #TA_CALLS3 as base
    set pre_call_ms_count = asr.vol,
    pre_call_ms_product_holding = asr.product_holding from
    #TA_CALLS3 as base
    join #asr_ms as asr
    on base.account_number = asr.account_number
    where base.event_dt_sod between asr.effective_from_dt and asr.effective_to_dt-1;
  update #TA_CALLS3 as base
    set post_call_ms_count = asr.vol,
    post_call_ms_product_holding = asr.product_holding from
    #TA_CALLS3 as base
    join #asr_ms as asr
    on base.account_number = asr.account_number
    where base.event_dt between asr.effective_from_dt and asr.effective_to_dt-1;
  update #TA_CALLS3 as base
    set base.pre_call_talk_product_holding = asr.product_holding from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT_SoD between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.talk_active_subscription = 1;
  update #TA_CALLS3 as base
    set base.post_call_talk_product_holding = asr.product_holding from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.talk_active_subscription = 1;
  update #TA_CALLS3 as base
    set base.pre_call_chelsea_tv = asr.chelsea_tv_Active_subscription from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT_SoD between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.chelsea_tv_Active_subscription = 1;
  update #TA_CALLS3 as base
    set base.post_call_chelsea_tv = asr.chelsea_tv_Active_subscription from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.chelsea_tv_Active_subscription = 1;
  update #TA_CALLS3 as base
    set base.pre_call_mutv = asr.mutv_active_subscription from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT_SoD between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.mutv_active_subscription = 1;
  update #TA_CALLS3 as base
    set base.post_call_mutv = asr.mutv_active_subscription from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.mutv_active_subscription = 1;
  update #TA_CALLS3 as base
    set base.pre_call_liverpool = asr.liverpool_Active_subscription from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT_SoD between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.liverpool_Active_subscription = 1;
  update #TA_CALLS3 as base
    set base.post_call_liverpool = asr.liverpool_Active_subscription from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.liverpool_Active_subscription = 1;
  update #TA_CALLS3 as base
    set base.pre_call_skyasia = asr.skyasia_active_subscription from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT_SoD between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.skyasia_active_subscription = 1;
  update #TA_CALLS3 as base
    set base.post_call_skyasia = asr.skyasia_active_subscription from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.skyasia_active_subscription = 1;
  -- Ala carte product holding 
  update #TA_CALLS3 as base
    set base.pre_call_ala_carte_product_holding = asr.product_holding from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT_SoD between asr.effective_from_dt and asr.effective_to_dt-1
    and(asr.skyasia_active_subscription+asr.mutv_active_subscription+asr.liverpool_Active_subscription+asr.chelsea_tv_Active_subscription) > 0;
  update #TA_CALLS3 as base
    set base.post_call_ala_carte_product_holding = asr.product_holding from
    #TA_CALLS3 as base
    join CITeam.active_subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.EVENT_DT between asr.effective_from_dt and asr.effective_to_dt-1
    and(asr.skyasia_active_subscription+asr.mutv_active_subscription+asr.liverpool_Active_subscription+asr.chelsea_tv_Active_subscription) > 0;
  update #TA_CALLS3 as base
    set lr_added = case when(pre_call_lr = 0 and post_call_lr = 1) then 1 else 0 end,
    lr_removed = case when(pre_call_lr = 1 and post_call_lr = 0) then 1 else 0 end,
    MS_Product_Holding_Added = case when(pre_call_ms_product_holding is null or pre_call_ms_product_holding <> post_call_ms_product_holding) then post_call_ms_product_holding end,
    MS_Product_Holding_Removed = case when(post_call_ms_product_holding is null or pre_call_ms_product_holding <> post_call_ms_product_holding) then pre_call_ms_product_holding end,
    ms_count_added = case when(pre_call_ms_product_holding <> post_call_ms_product_holding) then pre_call_ms_count
    when(post_call_ms_count-pre_call_ms_count) > 0 then(post_call_ms_count-pre_call_ms_count) else 0 end,
    ms_count_removed = case when(pre_call_ms_product_holding <> post_call_ms_product_holding) then post_call_ms_count
    when(post_call_ms_count-pre_call_ms_count) < 0 then(pre_call_ms_count-post_call_ms_count) else 0 end,
    chelsea_tv_Added = case when(pre_call_chelsea_tv = 0 and post_call_chelsea_tv = 1) then 1 else 0 end,
    chelsea_tv_Removed = case when(pre_call_chelsea_tv = 1 and post_call_chelsea_tv = 0) then 1 else 0 end,
    mutv_Added = case when(pre_call_mutv = 0 and post_call_mutv = 1) then 1 else 0 end,
    mutv_Removed = case when(pre_call_mutv = 1 and post_call_mutv = 0) then 1 else 0 end,
    liverpool_Added = case when(pre_call_liverpool = 0 and post_call_liverpool = 1) then 1 else 0 end,
    liverpool_Removed = case when(pre_call_liverpool = 1 and post_call_liverpool = 0) then 1 else 0 end,
    skyasia_Added = case when(pre_call_skyasia = 0 and post_call_skyasia = 1) then 1 else 0 end,
    skyasia_Removed = case when(pre_call_skyasia = 1 and post_call_skyasia = 0) then 1 else 0 end;
  -- End of product holding 
  ----------------------------------------------------------------------------------------------------
  --------------------------------Contract Flags Update-----------------------------------------------
  ----------------------------------------------------------------------------------------------------
  update #TA_CALLS3 as base
    set base.Basic_contract_status_pre_call = case when(ctr.contract_status in( 'In Contract' ) and PRE_CALL_DTV = 1) then 1 else 0 end from
    #TA_CALLS3 as base
    left outer join CITEAM.DM_Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.event_dt-1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Primary DTV' ) ;
  update #TA_CALLS3 as base
    set base.Talk_contract_status_pre_call = case when(ctr.contract_status in( 'In Contract' ) and pre_call_talk_product_holding is not null) then 1 else 0 end from
    #TA_CALLS3 as base
    left outer join CITEAM.DM_Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.event_dt-1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Sky Talk' ) ;
  update #TA_CALLS3 as base
    set base.BB_contract_status_pre_call = case when(ctr.contract_status in( 'In Contract' ) and PRE_CALL_BB_ACTIVE = 1) then 1 else 0 end from
    #TA_CALLS3 as base
    left outer join CITEAM.DM_Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.event_dt-1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Broadband' ) ;
  update #TA_CALLS3 as base
    set base.Add_on_contract_status_pre_call = case when((PRE_CALL_HD_BASIC+PRE_CALL_HD_PREMIUM+PRE_CALL_SKY_BOXSETS+PRE_CALL_SKY_KIDS+pre_call_ms_count+PRE_CALL_SKY_GO_EXTRA+pre_call_Spotify) > 0 and ctr.contract_status in( 'In Contract' ) ) then 1 else 0 end from
    #TA_CALLS3 as base
    left outer join CITEAM.DM_Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.event_dt-1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Secondary DTV' ) ;
  update #TA_CALLS3 as base
    set base.Add_on_contract_status_pre_call = case when((PRE_CALL_HD_BASIC+PRE_CALL_HD_PREMIUM+PRE_CALL_SKY_BOXSETS+PRE_CALL_SKY_KIDS+pre_call_ms_count+PRE_CALL_SKY_GO_EXTRA+pre_call_Spotify) > 0 and ctr.contract_status in( 'In Contract' ) ) then 1 else 0 end from
    #TA_CALLS3 as base
    left outer join CITEAM.DM_Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.event_dt-1 between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Sky Enhanced Cap Subs' ) and base.Add_on_contract_status_pre_call = 0;
  update #TA_CALLS3 as base
    set base.Overall_contract_status_pre_call
     = case when Basic_contract_status_pre_call = 1 then Basic_contract_status_pre_call
    when Talk_contract_status_pre_call = 1 then Talk_contract_status_pre_call
    when BB_contract_status_pre_call = 1 then BB_contract_status_pre_call
    when Add_on_contract_status_pre_call = 1 then Add_on_contract_status_pre_call
    else 0
    end from #TA_CALLS3 as base;
  ------new contracts----------
  update #TA_CALLS3 as base
    set base.Basic_contract_status_post_call = case when(ctr.contract_status in( 'In Contract' ) and POST_CALL_DTV = 1) then 1 else 0 end from
    #TA_CALLS3 as base
    left outer join CITEAM.DM_Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and ctr.Contract_start_date between base.event_dt and base.event_dt+30
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Primary DTV' ) ;
  update #TA_CALLS3 as base
    set base.Talk_contract_status_post_call = case when(ctr.contract_status in( 'In Contract' ) and post_call_talk_product_holding is not null) then 1 else 0 end from
    #TA_CALLS3 as base
    left outer join CITEAM.DM_Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and ctr.Contract_start_date between base.event_dt and base.event_dt+30
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Sky Talk' ) ;
  update #TA_CALLS3 as base
    set base.BB_contract_status_post_call = case when(ctr.contract_status in( 'In Contract' ) and POST_CALL_BB_ACTIVE = 1) then 1 else 0 end from
    #TA_CALLS3 as base
    left outer join CITEAM.DM_Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and ctr.Contract_start_date between base.event_dt and base.event_dt+30
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Broadband' ) ;
  update #TA_CALLS3 as base
    set base.Add_on_contract_status_post_call = case when(ctr.contract_status in( 'In Contract' ) and(POST_CALL_HD_BASIC+POST_CALL_HD_PREMIUM+POST_CALL_SKY_BOXSETS+POST_CALL_SKY_KIDS+post_call_ms_count+post_call_sky_go_extra+post_call_Spotify) > 0) then 1 else 0 end from
    #TA_CALLS3 as base
    left outer join CITEAM.DM_Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and ctr.Contract_start_date between base.event_dt and base.event_dt+30
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Secondary DTV' ) ;
  update #TA_CALLS3 as base
    set base.Add_on_contract_status_post_call = case when(ctr.contract_status in( 'In Contract' ) and(POST_CALL_HD_BASIC+POST_CALL_HD_PREMIUM+POST_CALL_SKY_BOXSETS+POST_CALL_SKY_KIDS+post_call_ms_count+post_call_sky_go_extra+post_call_Spotify) > 0) then 1 else 0 end from
    #TA_CALLS3 as base
    left outer join CITEAM.DM_Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and ctr.Contract_start_date between base.event_dt and base.event_dt+30
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Sky Enhanced Cap Subs' ) and base.Add_on_contract_status_post_call = 0;
  -----------------existing contracts---------
  update #TA_CALLS3 as base
    set base.Basic_contract_status_post_call = case when(ctr.contract_status in( 'In Contract' ) and POST_CALL_DTV = 1) then 1 else 0 end from
    #TA_CALLS3 as base
    left outer join CITEAM.DM_Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.event_dt between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Primary DTV' ) and Basic_contract_status_post_call = 0;
  update #TA_CALLS3 as base
    set base.Add_on_contract_status_post_call = case when(ctr.contract_status in( 'In Contract' ) and(POST_CALL_HD_BASIC+POST_CALL_HD_PREMIUM+POST_CALL_SKY_BOXSETS+POST_CALL_SKY_KIDS+post_call_ms_count+post_call_sky_go_extra+post_call_Spotify) > 0) then 1 else 0 end from
    #TA_CALLS3 as base
    left outer join CITEAM.DM_Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.event_dt between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Secondary DTV' ) and Basic_contract_status_post_call = 0;
  update #TA_CALLS3 as base
    set base.Add_on_contract_status_post_call = case when(ctr.contract_status in( 'In Contract' ) and(POST_CALL_HD_BASIC+POST_CALL_HD_PREMIUM+POST_CALL_SKY_BOXSETS+POST_CALL_SKY_KIDS+post_call_ms_count+post_call_sky_go_extra+post_call_Spotify) > 0) then 1 else 0 end from
    #TA_CALLS3 as base
    left outer join CITEAM.DM_Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.event_dt between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Sky Enhanced Cap Subs' ) and Basic_contract_status_post_call = 0;
  update #TA_CALLS3 as base
    set base.Talk_contract_status_post_call = case when(ctr.contract_status in( 'In Contract' ) and post_call_talk_product_holding is not null) then 1 else 0 end from
    #TA_CALLS3 as base
    left outer join CITEAM.DM_Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.event_dt between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Sky Talk' ) and Basic_contract_status_post_call = 0;
  update #TA_CALLS3 as base
    set base.BB_contract_status_post_call = case when(ctr.contract_status in( 'In Contract' ) and POST_CALL_BB_ACTIVE = 1) then 1 else 0 end from
    #TA_CALLS3 as base
    left outer join CITEAM.DM_Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.EVENT_DT between ctr.Contract_start_date and ctr.actual_contract_end_date
    where ctr.contract_status in( 'In Contract' ) and subscription_type in( 'Broadband' ) and Basic_contract_status_post_call = 0;
  -----------------overall status--------
  update #TA_CALLS3 as base
    set base.Overall_contract_status_post_call
     = case when Basic_contract_status_post_call = 1 then Basic_contract_status_post_call
    when Talk_contract_status_post_call = 1 then Talk_contract_status_post_call
    when BB_contract_status_post_call = 1 then BB_contract_status_post_call
    when Add_on_contract_status_post_call = 1 then Add_on_contract_status_post_call
    else 0
    end from #TA_CALLS3 as base;
  --------------
  -- contract 
  select account_number,subscription_id,subscription_type,cast(start_date_new as date) as status_start_date,cast(end_date_new as date) as status_end_date,Contract_status
    into #Contracts
    from(select account_number,subscription_id,subscription_type,actual_contract_end_date+1 as start_date_new,coalesce((lead(start_date) over(order by account_number asc,subscription_id asc,start_date asc)-1),'9999-09-09') as end_date_new,'Out Of Contract' as contract_status from decisioning.contracts union all
      select account_number,subscription_id,subscription_type,(max(actual_contract_end_date)+1) as start_date_new,'9999-09-09' as end_date_new,'Out Of Contract' as contract_status from decisioning.contracts group by account_number,subscription_id,subscription_type union all
      select account_number,subscription_id,subscription_type,start_date as start_date_new,actual_contract_end_date as end_Date_new,'In Contract' as contract_status from decisioning.contracts) as a
    where start_date_new <= end_date_new;
  update #TA_CALLS3 as base
    set base.Basic_Contract_Status_Level_2
     = case when PRE_CALL_DTV = 1 then
      (case when ctr.contract_status = 'In Contract' then
        case when ctr.status_end_date between EVENT_DT and(EVENT_DT+7) then 'Contract Ending in Next 1 Wks'
        when ctr.status_end_date between(EVENT_DT+8) and(EVENT_DT+14) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(EVENT_DT+15) and(EVENT_DT+21) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(EVENT_DT+22) and(EVENT_DT+28) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(EVENT_DT+29) and(EVENT_DT+35) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(EVENT_DT+36) and(EVENT_DT+42) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(EVENT_DT+43) and(EVENT_DT+49) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date between(EVENT_DT+50) and(EVENT_DT+56) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date > (EVENT_DT+56) then 'Contract Ending in 8+ Wks'
        else 'No Contract'
        end when ctr.contract_status = 'Out Of Contract' then
        case when ctr.status_start_date-1 between(EVENT_DT-7) and(EVENT_DT-1) then 'Contract Ended in last 1 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-14) and(EVENT_DT-8) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-21) and(EVENT_DT-15) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-28) and(EVENT_DT-22) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-35) and(EVENT_DT-29) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-42) and(EVENT_DT-36) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(EVENT_DT+43) and(EVENT_DT+49) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 between(EVENT_DT+50) and(EVENT_DT+56) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 < (EVENT_DT-56) then
          'No Contract' else 'No Contract' end
      else 'No Contract'
      end)
    else 'No Contract'
    end from #TA_CALLS3 as base
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    and base.event_dt-1 between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and subscription_type in( 'Primary DTV' ) ;
  update #TA_CALLS3 as base
    set base.Add_on_Products_Contract_Status_Level_2_DTV_Extra_Subscription = case when ctr.contract_status = 'In Contract' then
      case when ctr.status_end_date between(EVENT_DT) and(EVENT_DT+7) then 'Contract Ending in Next 1 Wks'
      when ctr.status_end_date between(EVENT_DT+8) and(EVENT_DT+14) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(EVENT_DT+15) and(EVENT_DT+21) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(EVENT_DT+22) and(EVENT_DT+28) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(EVENT_DT+29) and(EVENT_DT+35) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(EVENT_DT+36) and(EVENT_DT+42) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(EVENT_DT+43) and(EVENT_DT+49) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date between(EVENT_DT+50) and(EVENT_DT+56) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date > (EVENT_DT+56) then 'Contract Ending in 8+ Wks'
      else 'No Contract'
      end when ctr.contract_status = 'Out Of Contract' then
      case when ctr.status_start_date-1 between(EVENT_DT-7) and(EVENT_DT-1) then 'Contract Ended in last 1 Wks'
      when ctr.status_start_date-1 between(EVENT_DT-14) and(EVENT_DT-8) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(EVENT_DT-21) and(EVENT_DT-15) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(EVENT_DT-28) and(EVENT_DT-22) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(EVENT_DT-35) and(EVENT_DT-29) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(EVENT_DT-42) and(EVENT_DT-36) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(EVENT_DT+43) and(EVENT_DT+49) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 between(EVENT_DT+50) and(EVENT_DT+56) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 < (EVENT_DT-56) then --then 'Contract Ended 8+ Wks'
        'No Contract' else 'No Contract' end
    else 'No Contract'
    end from
    #TA_CALLS3 as base
    left outer join cust_subs_hist as csh on base.account_number = csh.account_number and base.EVENT_DT between csh.effective_from_dt and csh.effective_to_dt and csh.status_code in( 'AC','AB','PC' ) 
    and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD' and csh.subscription_type in( 'DTV PACKAGE' ) and csh.subscription_sub_type = 'DTV Extra Subscription'
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    and base.EVENT_DT between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and ctr.subscription_type in( 'Secondary DTV' ) and csh.subscription_type in( 'DTV PACKAGE' ) 
    and csh.subscription_sub_type = 'DTV Extra Subscription' and csh.status_code in( 'AC','AB','PC' ) and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD'
    and csh.subscription_id = ctr.subscription_id;
  update #TA_CALLS3 as base
    set base.Add_on_Products_Contract_Status_Level_2_DTV_Sky_plus = case when ctr.contract_status = 'In Contract' then
      case when ctr.status_end_date between(EVENT_DT) and(EVENT_DT+7) then 'Contract Ending in Next 1 Wks'
      when ctr.status_end_date between(EVENT_DT+8) and(EVENT_DT+14) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(EVENT_DT+15) and(EVENT_DT+21) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(EVENT_DT+22) and(EVENT_DT+28) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(EVENT_DT+29) and(EVENT_DT+35) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(EVENT_DT+36) and(EVENT_DT+42) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(EVENT_DT+43) and(EVENT_DT+49) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date between(EVENT_DT+50) and(EVENT_DT+56) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date > (EVENT_DT+56) then 'Contract Ending in 8+ Wks'
      else 'No Contract'
      end when ctr.contract_status = 'Out Of Contract' then
      case when ctr.status_start_date-1 between(EVENT_DT-7) and(EVENT_DT-1) then 'Contract Ended in last 1 Wks'
      when ctr.status_start_date-1 between(EVENT_DT-14) and(EVENT_DT-8) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(EVENT_DT-21) and(EVENT_DT-15) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(EVENT_DT-28) and(EVENT_DT-22) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(EVENT_DT-35) and(EVENT_DT-29) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(EVENT_DT-42) and(EVENT_DT-36) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(EVENT_DT+43) and(EVENT_DT+49) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 between(EVENT_DT+50) and(EVENT_DT+56) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 < (EVENT_DT-56) then --then 'Contract Ended 8+ Wks'
        'No Contract' else 'No Contract' end
    else 'No Contract'
    end from
    #TA_CALLS3 as base
    left outer join cust_subs_hist as csh on base.account_number = csh.account_number and base.EVENT_DT between csh.effective_from_dt and csh.effective_to_dt and csh.status_code in( 'AC','AB','PC' ) 
    and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD' and csh.subscription_type in( 'ENHANCED' ) and csh.subscription_sub_type = 'DTV Sky+'
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    and csh.subscription_id = ctr.subscription_id
    and base.EVENT_DT between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and ctr.subscription_type in( 'Sky Enhanced Cap Subs' ) and csh.subscription_type in( 'ENHANCED' ) 
    and csh.subscription_sub_type = 'DTV Sky+' and csh.status_code in( 'AC','AB','PC' ) and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD'
    and csh.subscription_id = ctr.subscription_id and(base.Add_on_Products_Contract_Status_Level_2 = 'No Contract' or base.Add_on_Products_Contract_Status_Level_2 is null);
  update #TA_CALLS3 as base
    set base.Add_on_Products_Contract_Status_Level_2_DTV_HD
     = case when PRE_CALL_HD_BASIC > 0 then
      (case when ctr.contract_status = 'In Contract' then
        case when ctr.status_end_date between(EVENT_DT) and(EVENT_DT+7) then 'Contract Ending in Next 1 Wks'
        when ctr.status_end_date between(EVENT_DT+8) and(EVENT_DT+14) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(EVENT_DT+15) and(EVENT_DT+21) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(EVENT_DT+22) and(EVENT_DT+28) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(EVENT_DT+29) and(EVENT_DT+35) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(EVENT_DT+36) and(EVENT_DT+42) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(EVENT_DT+43) and(EVENT_DT+49) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date between(EVENT_DT+50) and(EVENT_DT+56) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date > (EVENT_DT+56) then 'Contract Ending in 8+ Wks'
        else 'No Contract'
        end when ctr.contract_status = 'Out Of Contract' then
        case when ctr.status_start_date-1 between(EVENT_DT-7) and(EVENT_DT-1) then 'Contract Ended in last 1 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-14) and(EVENT_DT-8) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-21) and(EVENT_DT-15) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-28) and(EVENT_DT-22) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-35) and(EVENT_DT-29) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-42) and(EVENT_DT-36) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(EVENT_DT+43) and(EVENT_DT+49) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 between(EVENT_DT+50) and(EVENT_DT+56) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 < (EVENT_DT-56) then --then 'Contract Ended 8+ Wks'
          'No Contract' else 'No Contract' end
      else 'No Contract'
      end)
    else 'No Contract'
    end from #TA_CALLS3 as base
    left outer join cust_subs_hist as csh on base.account_number = csh.account_number and base.EVENT_DT between csh.effective_from_dt and csh.effective_to_dt and csh.status_code in( 'AC','AB','PC' ) 
    and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD' and csh.subscription_type in( 'ENHANCED' ) and csh.subscription_sub_type = 'DTV HD'
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.EVENT_DT between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and ctr.subscription_type in( 'Sky Enhanced Cap Subs' ) and csh.subscription_type in( 'ENHANCED' ) 
    and csh.subscription_sub_type = 'DTV HD' and csh.status_code in( 'AC','AB','PC' ) and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD'
    and(base.Add_on_Products_Contract_Status_Level_2 = 'No Contract' or base.Add_on_Products_Contract_Status_Level_2 is null) and csh.subscription_id = ctr.subscription_id;
  update #TA_CALLS3 as base
    set base.Add_on_Products_Contract_Status_Level_2_MS_plus
     = case when pre_call_ms_count > 0 then
      (case when ctr.contract_status = 'In Contract' then
        case when ctr.status_end_date between(EVENT_DT) and(EVENT_DT+7) then 'Contract Ending in Next 1 Wks'
        when ctr.status_end_date between(EVENT_DT+8) and(EVENT_DT+14) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(EVENT_DT+15) and(EVENT_DT+21) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(EVENT_DT+22) and(EVENT_DT+28) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(EVENT_DT+29) and(EVENT_DT+35) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(EVENT_DT+36) and(EVENT_DT+42) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(EVENT_DT+43) and(EVENT_DT+49) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date between(EVENT_DT+50) and(EVENT_DT+56) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date > (EVENT_DT+56) then 'Contract Ending in 8+ Wks'
        else 'No Contract'
        end when ctr.contract_status = 'Out Of Contract' then
        case when ctr.status_start_date-1 between(EVENT_DT-7) and(EVENT_DT-1) then 'Contract Ended in last 1 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-14) and(EVENT_DT-8) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-21) and(EVENT_DT-15) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-28) and(EVENT_DT-22) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-35) and(EVENT_DT-29) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-42) and(EVENT_DT-36) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(EVENT_DT+43) and(EVENT_DT+49) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 between(EVENT_DT+50) and(EVENT_DT+56) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 < (EVENT_DT-56) then --then 'Contract Ended 8+ Wks'
          'No Contract' else 'No Contract' end
      else 'No Contract'
      end)
    else 'No Contract'
    end from #TA_CALLS3 as base
    left outer join cust_subs_hist as csh on base.account_number = csh.account_number and base.EVENT_DT between csh.effective_from_dt and csh.effective_to_dt and csh.status_code in( 'AC','AB','PC' ) 
    and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD' and csh.subscription_type in( 'ENHANCED' ) and csh.subscription_sub_type = 'MS+'
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.EVENT_DT between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and ctr.subscription_type in( 'Sky Enhanced Cap Subs' ) and csh.subscription_type in( 'ENHANCED' ) 
    and csh.subscription_sub_type = 'MS+' and csh.status_code in( 'AC','AB','PC' ) and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD'
    and(base.Add_on_Products_Contract_Status_Level_2 = 'No Contract' or base.Add_on_Products_Contract_Status_Level_2 is null) and csh.subscription_id = ctr.subscription_id;
  update #TA_CALLS3 as base
    set base.Add_on_Products_Contract_Status_Level_2_SKY_BOX_SETS
     = case when PRE_CALL_SKY_BOXSETS > 1 then
      (case when ctr.contract_status = 'In Contract' then
        case when ctr.status_end_date between(EVENT_DT) and(EVENT_DT+7) then 'Contract Ending in Next 1 Wks'
        when ctr.status_end_date between(EVENT_DT+8) and(EVENT_DT+14) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(EVENT_DT+15) and(EVENT_DT+21) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(EVENT_DT+22) and(EVENT_DT+28) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(EVENT_DT+29) and(EVENT_DT+35) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(EVENT_DT+36) and(EVENT_DT+42) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(EVENT_DT+43) and(EVENT_DT+49) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date between(EVENT_DT+50) and(EVENT_DT+56) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date > (EVENT_DT+56) then 'Contract Ending in 8+ Wks'
        else 'No Contract'
        end when ctr.contract_status = 'Out Of Contract' then
        case when ctr.status_start_date-1 between(EVENT_DT-7) and(EVENT_DT-1) then 'Contract Ended in last 1 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-14) and(EVENT_DT-8) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-21) and(EVENT_DT-15) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-28) and(EVENT_DT-22) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-35) and(EVENT_DT-29) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-42) and(EVENT_DT-36) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(EVENT_DT+43) and(EVENT_DT+49) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 between(EVENT_DT+50) and(EVENT_DT+56) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 < (EVENT_DT-56) then --then 'Contract Ended 8+ Wks'
          'No Contract' else 'No Contract' end
      else 'No Contract'
      end)
    else 'No Contract'
    end from #TA_CALLS3 as base
    left outer join cust_subs_hist as csh on base.account_number = csh.account_number and base.EVENT_DT between csh.effective_from_dt and csh.effective_to_dt and csh.status_code in( 'AC','AB','PC' ) 
    and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD' and csh.subscription_type in( 'ENHANCED' ) and csh.subscription_sub_type = 'SKY_BOX_SETS'
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.EVENT_DT between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and ctr.subscription_type in( 'Sky Enhanced Cap Subs' ) and csh.subscription_type in( 'ENHANCED' ) 
    and csh.subscription_sub_type = 'SKY_BOX_SETS' and csh.status_code in( 'AC','AB','PC' ) and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD'
    and(base.Add_on_Products_Contract_Status_Level_2 = 'No Contract' or base.Add_on_Products_Contract_Status_Level_2 is null) and csh.subscription_id = ctr.subscription_id;
  update #TA_CALLS3 as base
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
    end from #TA_CALLS3 as base;
  update #TA_CALLS3 as base
    set base.Talk_Contract_Status_Level_2
     = case when pre_call_talk_product_holding is not null then
      (case when ctr.contract_status = 'In Contract' then
        case when ctr.status_end_date between EVENT_DT and(EVENT_DT+7) then 'Contract Ending in Next 1 Wks'
        when ctr.status_end_date between(EVENT_DT+8) and(EVENT_DT+14) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(EVENT_DT+15) and(EVENT_DT+21) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(EVENT_DT+22) and(EVENT_DT+28) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(EVENT_DT+29) and(EVENT_DT+35) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(EVENT_DT+36) and(EVENT_DT+42) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(EVENT_DT+43) and(EVENT_DT+49) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date between(EVENT_DT+50) and(EVENT_DT+56) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date > (EVENT_DT+56) then 'Contract Ending in 8+ Wks'
        else 'No Contract'
        end when ctr.contract_status = 'Out Of Contract' then
        case when ctr.status_start_date-1 between(EVENT_DT-7) and(EVENT_DT-1) then 'Contract Ended in last 1 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-14) and(EVENT_DT-8) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-21) and(EVENT_DT-15) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-28) and(EVENT_DT-22) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-35) and(EVENT_DT-29) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-42) and(EVENT_DT-36) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(EVENT_DT+43) and(EVENT_DT+49) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 between(EVENT_DT+50) and(EVENT_DT+56) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 < (EVENT_DT-56) then
          'No Contract' else 'No Contract' end
      else 'No Contract'
      end)
    else 'No Contract'
    end from
    #TA_CALLS3 as base
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    and base.event_dt-1 between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and subscription_type in( 'Sky Talk' ) ;
  update #TA_CALLS3 as base
    set base.BB_Contract_Status_Level_2
     = case when PRE_CALL_BB_ACTIVE > 0 then
      (case when ctr.contract_status = 'In Contract' then
        case when ctr.status_end_date between EVENT_DT and(EVENT_DT+7) then 'Contract Ending in Next 1 Wks'
        when ctr.status_end_date between(EVENT_DT+8) and(EVENT_DT+14) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(EVENT_DT+15) and(EVENT_DT+21) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(EVENT_DT+22) and(EVENT_DT+28) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(EVENT_DT+29) and(EVENT_DT+35) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(EVENT_DT+36) and(EVENT_DT+42) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(EVENT_DT+43) and(EVENT_DT+49) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date between(EVENT_DT+50) and(EVENT_DT+56) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date > (EVENT_DT+56) then 'Contract Ending in 8+ Wks'
        else 'No Contract'
        end when ctr.contract_status = 'Out Of Contract' then
        case when ctr.status_start_date-1 between(EVENT_DT-7) and(EVENT_DT-1) then 'Contract Ended in last 1 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-14) and(EVENT_DT-8) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-21) and(EVENT_DT-15) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-28) and(EVENT_DT-22) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-35) and(EVENT_DT-29) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(EVENT_DT-42) and(EVENT_DT-36) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(EVENT_DT+43) and(EVENT_DT+49) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 between(EVENT_DT+50) and(EVENT_DT+56) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 < (EVENT_DT-56) then
          'No Contract' else 'No Contract' end
      else 'No Contract'
      end)
    else 'No Contract'
    end from #TA_CALLS3 as base
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    and base.event_dt-1 between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and subscription_type in( 'Broadband' ) ;
  /*
update #TA_CALLS3 base
set base.Overall_Contract_Status_Level_2 = 
case 
when base.Basic_Contract_Status_Level_2 ='Contract Ending in 8+ Wks' then  base.Basic_Contract_Status_Level_2
when base.BB_Contract_Status_Level_2 ='Contract Ending in 8+ Wks' then  base.BB_Contract_Status_Level_2
when base.Add_on_Products_Contract_Status_Level_2 ='Contract Ending in 8+ Wks' then  base.Add_on_Products_Contract_Status_Level_2
when base.Talk_Contract_Status_Level_2 ='Contract Ending in 8+ Wks' then  base.Talk_Contract_Status_Level_2
when (base.Basic_Contract_Status_Level_2 <>'No Contract' or base.Basic_Contract_Status_Level_2  is not null) then  base.Basic_Contract_Status_Level_2
when (base.BB_Contract_Status_Level_2 <>'No Contract' or base.BB_Contract_Status_Level_2  is not null) then  base.BB_Contract_Status_Level_2
when (base.Add_on_Products_Contract_Status_Level_2 <>'No Contract' or base.Add_on_Products_Contract_Status_Level_2  is not null) then  base.Add_on_Products_Contract_Status_Level_2
when (base.Talk_Contract_Status_Level_2 <>'No Contract' or base.Talk_Contract_Status_Level_2  is not null) then  base.Talk_Contract_Status_Level_2
ELSE 'No Contract' END;
*/
  -- correction for Overall_Contract_Status_Level_2
  update #TA_CALLS3 as base
    set base.Overall_Contract_Status_Level_2
     = case when(base.Basic_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks'
    or base.BB_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks'
    or base.Add_on_Products_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks'
    or base.Talk_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks') then
      'Contract Ending in 8+ Wks'
    when(base.Basic_Contract_Status_Level_2 <> 'No Contract' and base.Basic_Contract_Status_Level_2 is not null) then
      base.Basic_Contract_Status_Level_2
    when(base.BB_Contract_Status_Level_2 <> 'No Contract' and base.BB_Contract_Status_Level_2 is not null) then
      base.BB_Contract_Status_Level_2
    when(base.Add_on_Products_Contract_Status_Level_2 <> 'No Contract' and base.Add_on_Products_Contract_Status_Level_2 is not null) then
      base.Add_on_Products_Contract_Status_Level_2
    when(base.Talk_Contract_Status_Level_2 <> 'No Contract' and base.Talk_Contract_Status_Level_2 is not null) then
      base.Talk_Contract_Status_Level_2
    else 'No Contract'
    end;
  update #TA_CALLS3
    set BB_Contract_Status_Level_1
     = case when BB_Contract_Status_Level_2 in( 'Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
    'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks' ) then
      'Contract End'
    when BB_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then
      'In-Contract'
    else 'No Contract'
    end;
  update #TA_CALLS3
    set Talk_Contract_Status_Level_1
     = case when Talk_Contract_Status_Level_2 in( 'Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
    'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks' ) then
      'Contract End'
    when Talk_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then
      'In-Contract'
    else 'No Contract'
    end;
  update #TA_CALLS3
    set Add_on_Products_Contract_Status_Level_1
     = case when Add_on_Products_Contract_Status_Level_2 in( 'Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
    'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks' ) then
      'Contract End'
    when Add_on_Products_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then
      'In-Contract'
    else 'No Contract'
    end;
  update #TA_CALLS3
    set Basic_Contract_Status_Level_1
     = case when Basic_Contract_Status_Level_2 in( 'Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
    'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks' ) then
      'Contract End'
    when Basic_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then
      'In-Contract'
    else 'No Contract'
    end;
  update #TA_CALLS3
    set Overall_Contract_Status_Level_1
     = case when Overall_Contract_Status_Level_2 in( 'Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
    'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks' ) then
      'Contract End'
    when Overall_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then
      'In-Contract'
    else 'No Contract'
    end;
  -- Contract end 
  -- Offers status  start \x09
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT_SoD','DTV','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_DTV','Curr_Offer_Intended_end_Dt_DTV');
  update #TA_CALLS3
    set Basic_Offer_End_Status_Level_2
     = case when PRE_CALL_DTV = 1 then
      (case when Curr_Offer_Intended_end_Dt_DTV between(EVENT_DT_SoD+1) and(EVENT_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_DTV between(EVENT_DT_SoD+8) and(EVENT_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_DTV between(EVENT_DT_SoD+15) and(EVENT_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_DTV between(EVENT_DT_SoD+22) and(EVENT_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_DTV between(EVENT_DT_SoD+29) and(EVENT_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_DTV between(EVENT_DT_SoD+36) and(EVENT_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_DTV > (EVENT_DT_SoD+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_DTV between(EVENT_DT_SoD-7) and EVENT_DT_SoD then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_DTV between(EVENT_DT_SoD-14) and(EVENT_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_DTV between(EVENT_DT_SoD-21) and(EVENT_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_DTV between(EVENT_DT_SoD-28) and(EVENT_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_DTV between(EVENT_DT_SoD-35) and(EVENT_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_DTV between(EVENT_DT_SoD-42) and(EVENT_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_DTV < (EVENT_DT_SoD-42) then 'Offer Ended 7+ Wks'
      else
        'No Offer'
      end)
    else 'No Offer'
    end;
  update #TA_CALLS3
    set Basic_Offer_End_Status_Level_1
     = case when Basic_Offer_End_Status_Level_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when Basic_Offer_End_Status_Level_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT_SoD','BROADBAND','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_BB','Curr_Offer_Intended_end_Dt_BB');
  update #TA_CALLS3
    set BB_Offer_End_Status_Level_2
     = case when PRE_CALL_BB_ACTIVE = 1 then
      (case when Curr_Offer_Intended_end_Dt_BB between(EVENT_DT_SoD+1) and(EVENT_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_BB between(EVENT_DT_SoD+8) and(EVENT_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_BB between(EVENT_DT_SoD+15) and(EVENT_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_BB between(EVENT_DT_SoD+22) and(EVENT_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_BB between(EVENT_DT_SoD+29) and(EVENT_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_BB between(EVENT_DT_SoD+36) and(EVENT_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_BB > (EVENT_DT_SoD+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_BB between(EVENT_DT_SoD-7) and EVENT_DT_SoD then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_BB between(EVENT_DT_SoD-14) and(EVENT_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_BB between(EVENT_DT_SoD-21) and(EVENT_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_BB between(EVENT_DT_SoD-28) and(EVENT_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_BB between(EVENT_DT_SoD-35) and(EVENT_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_BB between(EVENT_DT_SoD-42) and(EVENT_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_BB < (EVENT_DT_SoD-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #TA_CALLS3
    set BB_Offer_End_Status_Level_1
     = case when BB_Offer_End_Status_Level_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when BB_Offer_End_Status_Level_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT_SoD','LR','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_LR','Curr_Offer_Intended_end_Dt_LR');
  update #TA_CALLS3
    set LR_Offer_End_Status_Level_2
     = case when pre_call_LR = 1 then
      (case when Curr_Offer_Intended_end_Dt_LR between(EVENT_DT_SoD+1) and(EVENT_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_LR between(EVENT_DT_SoD+8) and(EVENT_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_LR between(EVENT_DT_SoD+15) and(EVENT_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_LR between(EVENT_DT_SoD+22) and(EVENT_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_LR between(EVENT_DT_SoD+29) and(EVENT_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_LR between(EVENT_DT_SoD+36) and(EVENT_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_LR > (EVENT_DT_SoD+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_LR between(EVENT_DT_SoD-7) and EVENT_DT_SoD then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_LR between(EVENT_DT_SoD-14) and(EVENT_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_LR between(EVENT_DT_SoD-21) and(EVENT_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_LR between(EVENT_DT_SoD-28) and(EVENT_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_LR between(EVENT_DT_SoD-35) and(EVENT_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_LR between(EVENT_DT_SoD-42) and(EVENT_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_LR < (EVENT_DT_SoD-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #TA_CALLS3
    set LR_Offer_End_Status_Level_1
     = case when LR_Offer_End_Status_Level_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when LR_Offer_End_Status_Level_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- sports 
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT_SoD','Sports','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_Sports','Curr_Offer_Intended_end_Dt_Sports');
  update #TA_CALLS3
    set Sports_OFFER_END_STATUS_LEVEL_2
     = case when PRE_CALL_TOTAL_SPORTS > 0 then
      (case when Curr_Offer_Intended_end_Dt_Sports between(EVENT_DT_SoD+1) and(EVENT_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_Sports between(EVENT_DT_SoD+8) and(EVENT_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_Sports between(EVENT_DT_SoD+15) and(EVENT_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_Sports between(EVENT_DT_SoD+22) and(EVENT_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_Sports between(EVENT_DT_SoD+29) and(EVENT_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_Sports between(EVENT_DT_SoD+36) and(EVENT_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_Sports > (EVENT_DT_SoD+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_Sports between(EVENT_DT_SoD-7) and EVENT_DT_SoD then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_Sports between(EVENT_DT_SoD-14) and(EVENT_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_Sports between(EVENT_DT_SoD-21) and(EVENT_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_Sports between(EVENT_DT_SoD-28) and(EVENT_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_Sports between(EVENT_DT_SoD-35) and(EVENT_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_Sports between(EVENT_DT_SoD-42) and(EVENT_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_Sports < (EVENT_DT_SoD-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #TA_CALLS3
    set Sports_OFFER_END_STATUS_LEVEL_1
     = case when Sports_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when Sports_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then 'On Offer'
    else 'No Offer'
    end;
  -- movies 
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT_SoD','Movies','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_Movies','Curr_Offer_Intended_end_Dt_Movies');
  update #TA_CALLS3
    set Cinema_OFFER_END_STATUS_LEVEL_2
     = case when PRE_CALL_TOTAL_MOVIES > 0 then
      (case when Curr_Offer_Intended_end_Dt_Movies between(EVENT_DT_SoD+1) and(EVENT_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_Movies between(EVENT_DT_SoD+8) and(EVENT_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_Movies between(EVENT_DT_SoD+15) and(EVENT_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_Movies between(EVENT_DT_SoD+22) and(EVENT_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_Movies between(EVENT_DT_SoD+29) and(EVENT_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_Movies between(EVENT_DT_SoD+36) and(EVENT_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_Movies > (EVENT_DT_SoD+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_Movies between(EVENT_DT_SoD-7) and EVENT_DT_SoD then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_Movies between(EVENT_DT_SoD-14) and(EVENT_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_Movies between(EVENT_DT_SoD-21) and(EVENT_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_Movies between(EVENT_DT_SoD-28) and(EVENT_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_Movies between(EVENT_DT_SoD-35) and(EVENT_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_Movies between(EVENT_DT_SoD-42) and(EVENT_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_Movies < (EVENT_DT_SoD-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #TA_CALLS3
    set Cinema_OFFER_END_STATUS_LEVEL_1
     = case when Cinema_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when Cinema_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then 'On Offer'
    else 'No Offer'
    end;
  -- PREMS
  update #TA_CALLS3
    set PREMIUM_Offer_End_Status_Level_1
     = case when PRE_CALL_TOTAL_PREMIUMS > 0 then
      (case when(Sports_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or Cinema_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending') then 'Offer Ending'
      when(Sports_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or Cinema_OFFER_END_STATUS_LEVEL_1 = 'On Offer') then 'On Offer'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #TA_CALLS3
    set PREMIUM_Offer_End_Status_Level_2
     = case when PRE_CALL_TOTAL_PREMIUMS > 0 then
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
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT_SoD','HD','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_HD','Curr_Offer_Intended_end_Dt_HD');
  update #TA_CALLS3
    set HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when PRE_CALL_HD_BASIC > 0 then
      (case when Curr_Offer_Intended_end_Dt_HD between(EVENT_DT_SoD+1) and(EVENT_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_HD between(EVENT_DT_SoD+8) and(EVENT_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_HD between(EVENT_DT_SoD+15) and(EVENT_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_HD between(EVENT_DT_SoD+22) and(EVENT_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_HD between(EVENT_DT_SoD+29) and(EVENT_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_HD between(EVENT_DT_SoD+36) and(EVENT_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_HD > (EVENT_DT_SoD+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_HD between(EVENT_DT_SoD-7) and EVENT_DT_SoD then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_HD between(EVENT_DT_SoD-14) and(EVENT_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_HD between(EVENT_DT_SoD-21) and(EVENT_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_HD between(EVENT_DT_SoD-28) and(EVENT_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_HD between(EVENT_DT_SoD-35) and(EVENT_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_HD between(EVENT_DT_SoD-42) and(EVENT_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_HD < (EVENT_DT_SoD-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #TA_CALLS3
    set HD_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- ms 
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT_SoD','MS','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_MS','Curr_Offer_Intended_end_Dt_MS');
  update #TA_CALLS3
    set MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when pre_call_ms_count > 0 then
      (case when Curr_Offer_Intended_end_Dt_MS between(EVENT_DT_SoD+1) and(EVENT_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_MS between(EVENT_DT_SoD+8) and(EVENT_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_MS between(EVENT_DT_SoD+15) and(EVENT_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_MS between(EVENT_DT_SoD+22) and(EVENT_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_MS between(EVENT_DT_SoD+29) and(EVENT_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_MS between(EVENT_DT_SoD+36) and(EVENT_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_MS > (EVENT_DT_SoD+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_MS between(EVENT_DT_SoD-7) and EVENT_DT_SoD then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_MS between(EVENT_DT_SoD-14) and(EVENT_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_MS between(EVENT_DT_SoD-21) and(EVENT_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_MS between(EVENT_DT_SoD-28) and(EVENT_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_MS between(EVENT_DT_SoD-35) and(EVENT_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_MS between(EVENT_DT_SoD-42) and(EVENT_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_MS < (EVENT_DT_SoD-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #TA_CALLS3
    set MS_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- SGE 
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT_SoD','SGE','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_SGE','Curr_Offer_Intended_end_Dt_SGE');
  update #TA_CALLS3
    set SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when PRE_CALL_SKY_GO_EXTRA > 0 then
      (case when Curr_Offer_Intended_end_Dt_SGE between(EVENT_DT_SoD+1) and(EVENT_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_SGE between(EVENT_DT_SoD+8) and(EVENT_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_SGE between(EVENT_DT_SoD+15) and(EVENT_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_SGE between(EVENT_DT_SoD+22) and(EVENT_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_SGE between(EVENT_DT_SoD+29) and(EVENT_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_SGE between(EVENT_DT_SoD+36) and(EVENT_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_SGE > (EVENT_DT_SoD+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_SGE between(EVENT_DT_SoD-7) and EVENT_DT_SoD then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_SGE between(EVENT_DT_SoD-14) and(EVENT_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_SGE between(EVENT_DT_SoD-21) and(EVENT_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_SGE between(EVENT_DT_SoD-28) and(EVENT_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_SGE between(EVENT_DT_SoD-35) and(EVENT_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_SGE between(EVENT_DT_SoD-42) and(EVENT_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_SGE < (EVENT_DT_SoD-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #TA_CALLS3
    set SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- HD Pack  
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT_SoD','HD PACK','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_HD_PACK','Curr_Offer_Intended_end_Dt_HD_PACK');
  update #TA_CALLS3
    set HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when PRE_CALL_HD_PREMIUM > 0 then
      (case when Curr_Offer_Intended_end_Dt_HD_PACK between(EVENT_DT_SoD+1) and(EVENT_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_HD_PACK between(EVENT_DT_SoD+8) and(EVENT_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_HD_PACK between(EVENT_DT_SoD+15) and(EVENT_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_HD_PACK between(EVENT_DT_SoD+22) and(EVENT_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_HD_PACK between(EVENT_DT_SoD+29) and(EVENT_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_HD_PACK between(EVENT_DT_SoD+36) and(EVENT_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_HD_PACK > (EVENT_DT_SoD+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_HD_PACK between(EVENT_DT_SoD-7) and EVENT_DT_SoD then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_HD_PACK between(EVENT_DT_SoD-14) and(EVENT_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_HD_PACK between(EVENT_DT_SoD-21) and(EVENT_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_HD_PACK between(EVENT_DT_SoD-28) and(EVENT_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_HD_PACK between(EVENT_DT_SoD-35) and(EVENT_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_HD_PACK between(EVENT_DT_SoD-42) and(EVENT_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_HD_PACK < (EVENT_DT_SoD-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #TA_CALLS3
    set HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- Box sets 
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT_SoD','BOX SETS','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_BOX_SETS','Curr_Offer_Intended_end_Dt_BOX_SETS');
  update #TA_CALLS3
    set BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when PRE_CALL_SKY_BOXSETS > 0 then
      (case when Curr_Offer_Intended_end_Dt_BOX_SETS between(EVENT_DT_SoD+1) and(EVENT_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_BOX_SETS between(EVENT_DT_SoD+8) and(EVENT_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_BOX_SETS between(EVENT_DT_SoD+15) and(EVENT_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_BOX_SETS between(EVENT_DT_SoD+22) and(EVENT_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_BOX_SETS between(EVENT_DT_SoD+29) and(EVENT_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_BOX_SETS between(EVENT_DT_SoD+36) and(EVENT_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_BOX_SETS > (EVENT_DT_SoD+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_BOX_SETS between(EVENT_DT_SoD-7) and EVENT_DT_SoD then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_BOX_SETS between(EVENT_DT_SoD-14) and(EVENT_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_BOX_SETS between(EVENT_DT_SoD-21) and(EVENT_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_BOX_SETS between(EVENT_DT_SoD-28) and(EVENT_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_BOX_SETS between(EVENT_DT_SoD-35) and(EVENT_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_BOX_SETS between(EVENT_DT_SoD-42) and(EVENT_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_BOX_SETS < (EVENT_DT_SoD-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #TA_CALLS3
    set BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- SKY Kids 
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT_SoD','SKY_KIDS','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_SKY_KIDS','Curr_Offer_Intended_end_Dt_SKY_KIDS');
  update #TA_CALLS3
    set SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when PRE_CALL_SKY_KIDS > 0 then
      (case when Curr_Offer_Intended_end_Dt_SKY_KIDS between(EVENT_DT_SoD+1) and(EVENT_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_SKY_KIDS between(EVENT_DT_SoD+8) and(EVENT_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_SKY_KIDS between(EVENT_DT_SoD+15) and(EVENT_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_SKY_KIDS between(EVENT_DT_SoD+22) and(EVENT_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_SKY_KIDS between(EVENT_DT_SoD+29) and(EVENT_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_SKY_KIDS between(EVENT_DT_SoD+36) and(EVENT_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_SKY_KIDS > (EVENT_DT_SoD+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_SKY_KIDS between(EVENT_DT_SoD-7) and EVENT_DT_SoD then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_SKY_KIDS between(EVENT_DT_SoD-14) and(EVENT_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_SKY_KIDS between(EVENT_DT_SoD-21) and(EVENT_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_SKY_KIDS between(EVENT_DT_SoD-28) and(EVENT_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_SKY_KIDS between(EVENT_DT_SoD-35) and(EVENT_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_SKY_KIDS between(EVENT_DT_SoD-42) and(EVENT_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_SKY_KIDS < (EVENT_DT_SoD-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #TA_CALLS3
    set SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- Sky Talk 
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT_SoD','TALK','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_TALK','Curr_Offer_Intended_end_Dt_TALK');
  update #TA_CALLS3
    set TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when post_call_talk_product_holding is not null then
      (case when Curr_Offer_Intended_end_Dt_TALK between(EVENT_DT_SoD+1) and(EVENT_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_TALK between(EVENT_DT_SoD+8) and(EVENT_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_TALK between(EVENT_DT_SoD+15) and(EVENT_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_TALK between(EVENT_DT_SoD+22) and(EVENT_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_TALK between(EVENT_DT_SoD+29) and(EVENT_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_TALK between(EVENT_DT_SoD+36) and(EVENT_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_TALK > (EVENT_DT_SoD+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_TALK between(EVENT_DT_SoD-7) and EVENT_DT_SoD then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_TALK between(EVENT_DT_SoD-14) and(EVENT_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_TALK between(EVENT_DT_SoD-21) and(EVENT_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_TALK between(EVENT_DT_SoD-28) and(EVENT_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_TALK between(EVENT_DT_SoD-35) and(EVENT_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_TALK between(EVENT_DT_SoD-42) and(EVENT_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_TALK < (EVENT_DT_SoD-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #TA_CALLS3
    set TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- SPOTIFY 
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT_SoD','SPOTIFY','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_SPOTIFY','Curr_Offer_Intended_end_Dt_SPOTIFY');
  update #TA_CALLS3
    set SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when pre_call_Spotify > 0 then
      (case when Curr_Offer_Intended_end_Dt_SPOTIFY between(EVENT_DT_SoD+1) and(EVENT_DT_SoD+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_SPOTIFY between(EVENT_DT_SoD+8) and(EVENT_DT_SoD+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_SPOTIFY between(EVENT_DT_SoD+15) and(EVENT_DT_SoD+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_SPOTIFY between(EVENT_DT_SoD+22) and(EVENT_DT_SoD+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_SPOTIFY between(EVENT_DT_SoD+29) and(EVENT_DT_SoD+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_SPOTIFY between(EVENT_DT_SoD+36) and(EVENT_DT_SoD+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_SPOTIFY > (EVENT_DT_SoD+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_SPOTIFY between(EVENT_DT_SoD-7) and EVENT_DT_SoD then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_SPOTIFY between(EVENT_DT_SoD-14) and(EVENT_DT_SoD-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_SPOTIFY between(EVENT_DT_SoD-21) and(EVENT_DT_SoD-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_SPOTIFY between(EVENT_DT_SoD-28) and(EVENT_DT_SoD-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_SPOTIFY between(EVENT_DT_SoD-35) and(EVENT_DT_SoD-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_SPOTIFY between(EVENT_DT_SoD-42) and(EVENT_DT_SoD-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_SPOTIFY < (EVENT_DT_SoD-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #TA_CALLS3
    set SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  update #TA_CALLS3
    set ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when(PRE_CALL_HD_BASIC+PRE_CALL_HD_PREMIUM+PRE_CALL_SKY_BOXSETS+PRE_CALL_SKY_KIDS+pre_call_ms_count+case when pre_call_talk_product_holding is not null then 1 else 0 end+PRE_CALL_SKY_GO_EXTRA+pre_call_Spotify) > 0 then
      (case when(SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or MS_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or HD_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending') then 'Offer Ending'
      when(SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or MS_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or HD_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer') then 'On Offer'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #TA_CALLS3
    set ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when(PRE_CALL_HD_BASIC+PRE_CALL_HD_PREMIUM+PRE_CALL_SKY_BOXSETS+PRE_CALL_SKY_KIDS+pre_call_ms_count+case when pre_call_talk_product_holding is not null then 1 else 0 end+PRE_CALL_SKY_GO_EXTRA+pre_call_Spotify) > 0 then
      (case when ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'No Offer' then 'No Offer'
      when ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' then 'Offer Ending in 7+ Wks'
      when ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' then
        (case when(SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks') then 'Offer Ending in Next 1 Wks'
        when(SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks') then 'Offer Ending in Next 2-3 Wks'
        when(SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks') then 'Offer Ending in Next 4-6 Wks'
        when(SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks') then 'Offer Ended in last 1 Wks'
        when(SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks') then 'Offer Ended in last 2-3 Wks'
        when(SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks') then 'Offer Ended in last 4-6 Wks' end)
      end)
    else
      'No Offer'
    end;
  update #TA_CALLS3
    set Offer_End_Status_Level_1
     = case when(PRE_CALL_HD_BASIC+PRE_CALL_HD_PREMIUM+PRE_CALL_SKY_BOXSETS+PRE_CALL_SKY_KIDS+pre_call_ms_count+case when pre_call_talk_product_holding is not null then 1 else 0 end+PRE_CALL_SKY_GO_EXTRA+PRE_CALL_DTV+PRE_CALL_BB_ACTIVE+PRE_CALL_TOTAL_PREMIUMS+pre_call_LR) > 0 then
      (case when(BASIC_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or BB_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or LR_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or PREMIUM_Offer_End_Status_Level_1 = 'Offer Ending' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending') then 'Offer Ending'
      when(BASIC_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or BB_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or LR_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or PREMIUM_Offer_End_Status_Level_1 = 'On Offer' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer') then 'On Offer'
      else
        'No Offer'
      end)
    else 'No Offer'
    end;
  update #TA_CALLS3
    set Offer_End_Status_Level_2
     = case when(PRE_CALL_HD_BASIC+PRE_CALL_HD_PREMIUM+PRE_CALL_SKY_BOXSETS+PRE_CALL_SKY_KIDS+pre_call_ms_count+case when pre_call_talk_product_holding is not null then 1 else 0 end+PRE_CALL_SKY_GO_EXTRA+PRE_CALL_DTV+PRE_CALL_BB_ACTIVE+PRE_CALL_TOTAL_PREMIUMS+pre_call_LR) > 0 then
      (case when Offer_End_Status_Level_1 = 'No Offer' then 'No Offer'
      when Offer_End_Status_Level_1 = 'On Offer' then 'Offer Ending in 7+ Wks'
      when Offer_End_Status_Level_1 = 'Offer Ending' then
        (case when(BASIC_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or BB_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or LR_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or PREMIUM_Offer_End_Status_Level_2 = 'Offer Ending in Next 1 Wks' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks') then 'Offer Ending in Next 1 Wks'
        when(BASIC_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or BB_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or LR_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or PREMIUM_Offer_End_Status_Level_2 = 'Offer Ending in Next 2-3 Wks' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks') then 'Offer Ending in Next 2-3 Wks'
        when(BASIC_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or BB_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or LR_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or PREMIUM_Offer_End_Status_Level_2 = 'Offer Ending in Next 4-6 Wks' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks') then 'Offer Ending in Next 4-6 Wks'
        when(BASIC_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or BB_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or LR_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or PREMIUM_Offer_End_Status_Level_2 = 'Offer Ended in last 1 Wks' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks') then 'Offer Ended in last 1 Wks'
        when(BASIC_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or BB_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or LR_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or PREMIUM_Offer_End_Status_Level_2 = 'Offer Ended in last 2-3 Wks' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks') then 'Offer Ended in last 2-3 Wks'
        when(BASIC_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or BB_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or LR_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or PREMIUM_Offer_End_Status_Level_2 = 'Offer Ended in last 4-6 Wks' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks') then 'Offer Ended in last 4-6 Wks' end)
      end)
    else
      'No Offer'
    end;
  -- end 
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT','ANY','Ordered','New',null,'Update Only','Offers_Applied_Lst_1D_Any');
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT','DTV','Ordered','New',null,'Update Only','Offers_Applied_Lst_1D_DTV');
  update #TA_CALLS3
    set ANY_NEW_OFFER_Active_Leg_1 = case when Offers_Applied_Lst_1D_Any > 0 then 1 else 0 end,
    NEW_DTV_OFFER_Active_leg_1 = case when Offers_Applied_Lst_1D_DTV > 0 then 1 else 0 end;
  update #TA_CALLS3
    set Offers_Applied_Lst_1D_Any = 0,
    Offers_Applied_Lst_1D_DTV = 0;
  commit work;
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT_SoD','ANY','Ordered','All',null,'Update Only','Offers_Applied_Lst_day_any');
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT_SoD','DTV','Ordered','All',null,'Update Only','Offers_Applied_Lst_day_dtv');
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT','ANY','Ordered','All',null,'Update Only','Offers_Applied_Lst_1D_Any');
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT','DTV','Ordered','All',null,'Update Only','Offers_Applied_Lst_1D_DTV');
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT','BB','Ordered','All',null,'Update Only','Offers_Applied_Lst_1D_BB');
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT','Line Rental','All',null,'Ordered','Update Only','Offers_Applied_Lst_1D_LR');
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT','MS','Ordered','All',null,'Update Only','Offers_Applied_Lst_1D_MS');
  call Decisioning_Procs.Add_Offers_Software('#TA_CALLS3','EVENT_DT','HD','Ordered','All',null,'Update Only','Offers_Applied_Lst_1D_HD');
  update #TA_CALLS3 as A
    set A.ANY_OFFER_Active = case when Offers_Applied_Lst_1D_Any > 0 then 1 else 0 end,
    A.DTV_OFFER_Active = case when Offers_Applied_Lst_1D_DTV > 0 then 1 else 0 end,
    A.BB_OFFER_Active = case when Offers_Applied_Lst_1D_BB > 0 then 1 else 0 end,
    A.LR_OFFER_Active = case when Offers_Applied_Lst_1D_LR > 0 then 1 else 0 end,
    A.MS_OFFER_Active = case when Offers_Applied_Lst_1D_MS > 0 then 1 else 0 end,
    A.HD_OFFER_Active = case when Offers_Applied_Lst_1D_HD > 0 then 1 else 0 end,
    A.ANY_OFFER_GIVEN = case when(Offers_Applied_Lst_day_any = 0 and Offers_Applied_Lst_1D_Any > 0) then 1 else 0 end,
    A.DTV_OFFER_GIVEN = case when(Offers_Applied_Lst_day_dtv = 0 and Offers_Applied_Lst_1D_DTV > 0) then 1 else 0 end;
  commit work;
  drop table if exists #TA_CALLS_OFFER_STATUS;
  select D.ACCOUNT_NUMBER,
    D.EVENT_DT,
    case when D.ACTUAL_OFFER_STATUS = 2 then 'Offer End'
    when D.ACTUAL_OFFER_STATUS = 1 then 'On Offer'
    else 'No Offer'
    end as ACTUAL_OFFER_STATUS,
    case when D.INTENDED_OFFER_STATUS = 2 then 'Offer End'
    when D.INTENDED_OFFER_STATUS = 1 then 'On Offer'
    else 'No Offer'
    end as INTENDED_OFFER_STATUS
    into #TA_CALLS_OFFER_STATUS
    from(select distinct A.ACCOUNT_NUMBER,
        A.EVENT_DT,
        MAX(
        case when B.WHOLE_OFFER_END_DT_ACTUAL <> A.EVENT_DT and A.EVENT_DT-55 <= B.WHOLE_OFFER_END_DT_ACTUAL and A.EVENT_DT+35 >= B.WHOLE_OFFER_END_DT_ACTUAL then 2
        when B.WHOLE_OFFER_END_DT_ACTUAL = A.EVENT_DT and A.EVENT_DT-55 <= B.Intended_Offer_End_Dt and A.EVENT_DT+35 >= B.Intended_Offer_End_Dt then 2
        when B.WHOLE_OFFER_END_DT_ACTUAL is not null then 1
        else 0
        end) as ACTUAL_OFFER_STATUS,
        MAX(
        case when A.EVENT_DT-55 <= C.Intended_Offer_End_Dt and A.EVENT_DT+35 >= C.Intended_Offer_End_Dt then 2
        when C.Intended_Offer_End_Dt is not null then 1
        else 0
        end) as INTENDED_OFFER_STATUS
        from #TA_CALLS3 as A
          left outer join CITEAM.Offers_Software as B
          on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
          and A.EVENT_DT > B.WHOLE_OFFER_START_DT_ACTUAL
          and A.EVENT_DT-55 <= B.WHOLE_OFFER_END_DT_ACTUAL
          and lower(B.OFFER_DIM_DESCRIPTION) not like '%price protect%'
          and B.WHOLE_OFFER_AMOUNT_ACTUAL < 0
          left outer join CITEAM.Offers_Software as C
          on A.ACCOUNT_NUMBER = C.ACCOUNT_NUMBER
          and A.EVENT_DT > C.Offer_Leg_Start_Dt_Actual
          and A.EVENT_DT-55 <= C.Intended_Offer_End_Dt
          and lower(B.OFFER_DIM_DESCRIPTION) not like '%price protect%'
          and C.WHOLE_OFFER_AMOUNT_ACTUAL < 0
        group by A.ACCOUNT_NUMBER,A.EVENT_DT) as D
    group by D.ACCOUNT_NUMBER,
    D.EVENT_DT,
    D.ACTUAL_OFFER_STATUS,
    D.INTENDED_OFFER_STATUS;
  update #TA_CALLS3 as A
    set A.ACTUAL_OFFER_STATUS = B.ACTUAL_OFFER_STATUS,
    A.INTENDED_OFFER_STATUS = B.INTENDED_OFFER_STATUS from
    #TA_CALLS_OFFER_STATUS as B
    where A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.EVENT_DT = B.EVENT_DT;
  drop table if exists #ECONOMETRICS_TA_CALLS_NEW;
  select distinct A.*,
    cast(null as integer) as TENURE,
    cast(null as varchar(30)) as SIMPLE_SEGMENT,
    cast(null as varchar(100)) as TV_REGION,
    cast(null as varchar(100)) as mosaic_uk_group,
    right(cast(C.subs_year as varchar),2) || '/' || right(cast(C.subs_year+1 as varchar),2)
     || '-' || case when C.subs_week_of_year < 10 then '0' || cast(C.subs_week_of_year as varchar) else cast(C.subs_week_of_year as varchar) end as year_week,
    A.EVENT_DT as WEEK_START
    /*,
cast(0 as integer) as longest_time_in_nf_app,
cast(0 as integer) as shortest_time_in_nf_app,
cast(0 as integer) as total_nf_app_launches,
cast(0 as integer) as total_significant_nf_app_launches,
cast(0 as integer) as total_time_in_nf_app,
cast(0 as integer) as account_used_nf_app,*/
    into #ECONOMETRICS_TA_CALLS_NEW
    from #TA_CALLS3 as A
      left outer join sky_calendar as C
      on A.EVENT_DT = C.CALENDAR_DATE;
  drop table if exists #TA_weeks;
  select right(cast(subs_year as varchar),2) || '/' || right(cast(subs_year+1 as varchar),2)
     || '-' || case when subs_week_of_year < 10 then '0' || cast(subs_week_of_year as varchar) else cast(subs_week_of_year as varchar) end as year_week,
    min(calendar_date) as week_start
    into #TA_weeks
    from sky_calendar as cal
    group by year_week;
  update #ECONOMETRICS_TA_CALLS_NEW as a
    set a.week_start = b.week_start from
    #TA_weeks as b
    where a.year_week = b.year_week;
  update #ECONOMETRICS_TA_CALLS_NEW as TA
    set TA.TV_Region = B.tv_region,
    TA.TENURE = case when DATEDIFF(month,B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT,TA.event_Dt) < 0 then 0 else DATEDIFF(month,B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT,TA.event_Dt) end from
    #ECONOMETRICS_TA_CALLS_NEW as TA
    join CITeam.Account_TV_Region as B
    on TA.account_number = B.account_number;
  drop table if exists #ECONOMETRICS_TA_CALLS;
  select ta.ACCOUNT_NUMBER,
    COUNTRY,
    EVENT_DT,
    subscription_id,
    NUMBER_CALLS,
    SAVED_FLAG,
    TA_attempt_type,
    last_ta_date,
    Time_Since_Last_TA_Event,
    ta_call_event,
    turnaround_description,
    livechat_turnaround_event,
    livechat_turnaround_description,
    pre_call_LR,
    post_call_LR,
    LR_added,
    LR_removed,
    pre_call_ms_product_holding,
    pre_call_ms_count,
    post_call_ms_product_holding,
    post_call_ms_count,
    ms_count_added,
    ms_count_removed,
    MS_Product_Holding_Added,
    MS_Product_Holding_Removed,
    pre_call_talk_product_holding,
    post_call_talk_product_holding,
    Talk_Product_Holding_Added,
    Talk_Product_Holding_Removed,
    pre_call_chelsea_tv,
    post_call_chelsea_tv,
    pre_call_mutv,
    post_call_mutv,
    pre_call_liverpool,
    post_call_liverpool,
    pre_call_skyasia,
    post_call_skyasia,
    pre_call_Spotify,
    post_call_Spotify,
    Spotify_Added,
    Spotify_Removed,
    UOD_ADDED,
    UOD_REMOVED,
    pre_call_Netflix,
    post_call_Netflix,
    Netflix_Standard_Added,
    Netflix_Standard_Removed,
    Netflix_Premium_Added,
    Netflix_Premium_Removed,
    chelsea_tv_Added,
    chelsea_tv_Removed,
    mutv_Added,
    mutv_Removed,
    liverpool_Added,
    liverpool_Removed,
    skyasia_Added,
    skyasia_Removed,
    ORDER_DT,
    EVENT_DT_SoD,
    Basic_Contract_Status_Level_2,
    Add_on_Products_Contract_Status_Level_2,
    Talk_Contract_Status_Level_2,
    BB_Contract_Status_Level_2,
    Overall_Contract_Status_Level_2,
    Basic_Contract_Status_Level_1,
    Add_on_Products_Contract_Status_Level_1,
    Talk_Contract_Status_Level_1,
    BB_Contract_Status_Level_1,
    Overall_Contract_Status_Level_1,
    SPORTS_ADDED,
    MOVIES_ADDED,
    LEGACY_SPORTS_SUB_ADDED,
    LEGACY_MOVIES_SUB_ADDED,
    LEGACY_SPORTS_ADDED,
    LEGACY_MOVIES_ADDED,
    SPORTS_PACK_SUB_ADDED,
    SPORTS_PACK_ADDED,
    LEGACY_SPORTS_SUB_REMOVED,
    LEGACY_MOVIES_SUB_REMOVED,
    LEGACY_SPORTS_REMOVED,
    LEGACY_MOVIES_REMOVED,
    SPORTS_PACK_SUB_REMOVED,
    SPORTS_PACK_REMOVED,
    FAMILY_ADDED,
    VARIETY_ADDED,
    ORIGINAL_ADDED,
    SKYQ_LEGACY_ADDED,
    HD_LEGACY_ADDED,
    HD_BASIC_ADDED,
    HD_PREMIUM_ADDED,
    CLASSIC_MS_ADDED,
    SKYQ_MS_ADDED,
    SKY_PLUS_ADDED,
    SKY_GO_EXTRA_ADDED,
    NOW_TV_ADDED,
    BB_UNLIMITED_ADDED,
    BB_LITE_ADDED,
    BB_FIBRE_CAP_ADDED,
    BB_FIBRE_UNLIMITED_ADDED,
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
    SKYQ_LEGACY_REMOVED,
    HD_LEGACY_REMOVED,
    HD_BASIC_REMOVED,
    HD_PREMIUM_REMOVED,
    CLASSIC_MS_REMOVED,
    SKYQ_MS_REMOVED,
    SKY_PLUS_REMOVED,
    SKY_GO_EXTRA_REMOVED,
    NOW_TV_REMOVED,
    BB_UNLIMITED_REMOVED,
    BB_LITE_REMOVED,
    BB_FIBRE_CAP_REMOVED,
    BB_FIBRE_UNLIMITED_REMOVED,
    TALKU_REMOVED,
    TALKW_REMOVED,
    TALKF_REMOVED,
    TALKA_REMOVED,
    TALKP_REMOVED,
    TALKO_REMOVED,
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
    CINEMA_ADDED,
    CINEMA_REMOVED,
    SKY_KIDS_ADDED,
    SKY_KIDS_REMOVED,
    SKY_BOXSETS_ADDED,
    SKY_BOXSETS_REMOVED,
    SKY_ENT_ADDED,
    SKY_ENT_REMOVED,
    DTV_ADDED,
    DTV_REMOVED,
    BB_ADDED,
    BB_REMOVED,
    PRE_CALL_DTV,
    PRE_CALL_ORIGINAL,
    PRE_CALL_VARIETY,
    PRE_CALL_FAMILY,
    PRE_CALL_SKYQ,
    PRE_CALL_TOP_TIER,
    PRE_CALL_SKY_ENT,
    PRE_CALL_SKY_KIDS,
    PRE_CALL_SKY_BOXSETS,
    PRE_CALL_HD_BASIC,
    PRE_CALL_HD_PREMIUM,
    PRE_CALL_SKY_GO_EXTRA,
    PRE_CALL_TOTAL_PREMIUMS,
    PRE_CALL_TOTAL_SPORTS,
    PRE_CALL_TOTAL_MOVIES,
    BB_ACTIVE,
    BB_Product_Holding,
    PRE_CALL_BB_ACTIVE,
    PRE_CALL_BB_Product_Holding,
    POST_CALL_BB_ACTIVE,
    POST_CALL_BB_Product_Holding,
    POST_CALL_DTV,
    POST_CALL_SKY_PLUS,
    POST_CALL_ORIGINAL,
    POST_CALL_VARIETY,
    POST_CALL_FAMILY,
    POST_CALL_SKYQ,
    POST_CALL_SKY_ENT,
    POST_CALL_SKY_KIDS,
    POST_CALL_SKY_BOXSETS,
    POST_CALL_HD_BASIC,
    POST_CALL_HD_PREMIUM,
    POST_CALL_TOP_TIER,
    POST_CALL_TOTAL_PREMIUMS,
    POST_CALL_TOTAL_SPORTS,
    POST_CALL_TOTAL_MOVIES,
    ACTUAL_OFFER_STATUS,
    INTENDED_OFFER_STATUS,
    ANY_OFFER_Active,
    DTV_OFFER_Active,
    BB_OFFER_Active,
    LR_OFFER_Active,
    MS_OFFER_Active,
    HD_OFFER_Active,
    ANY_OFFER_GIVEN,
    DTV_OFFER_GIVEN,
    Prems_Product_Count,
    Sports_Product_Count,
    Movies_Product_Count,
    PRE_CALL_Prems_Active,
    Prems_Active,
    PRE_CALL_Sports_Active,
    Sports_Active,
    PRE_CALL_Movies_Active,
    Movies_Active,
    Prev_Offer_Start_Dt_Any,
    Prev_Offer_Intended_end_Dt_Any,
    Prev_Offer_Actual_End_Dt_Any,
    Curr_Offer_Start_Dt_Any,
    Curr_Offer_Intended_end_Dt_Any,
    Curr_Offer_Actual_End_Dt_Any,
    Offer_End_Status_Level_1,
    BASIC_OFFER_END_STATUS_LEVEL_1,
    BB_OFFER_END_STATUS_LEVEL_1,
    LR_OFFER_END_STATUS_LEVEL_1,
    PREMIUM_OFFER_END_STATUS_LEVEL_1,
    Sports_OFFER_END_STATUS_LEVEL_1,
    Cinema_OFFER_END_STATUS_LEVEL_1,
    HD_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    MS_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    Offer_End_Status_Level_2,
    BASIC_OFFER_END_STATUS_LEVEL_2,
    BB_OFFER_END_STATUS_LEVEL_2,
    LR_OFFER_END_STATUS_LEVEL_2,
    PREMIUM_OFFER_END_STATUS_LEVEL_2,
    Sports_OFFER_END_STATUS_LEVEL_2,
    Cinema_OFFER_END_STATUS_LEVEL_2,
    HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    Prev_Offer_Actual_End_Dt_DTV,
    Curr_Offer_Intended_end_Dt_DTV,
    Prev_Offer_Actual_End_Dt_BB,
    Curr_Offer_Intended_end_Dt_BB,
    Prev_Offer_Actual_End_Dt_LR,
    Curr_Offer_Intended_end_Dt_LR,
    Curr_Offer_Intended_end_Dt_Movies,
    Prev_Offer_Actual_End_Dt_Movies,
    Curr_Offer_Intended_end_Dt_Sports,
    Prev_Offer_Actual_End_Dt_Sports,
    Prev_Offer_Actual_End_Dt_HD,
    Curr_Offer_Intended_end_Dt_HD,
    Prev_Offer_Actual_End_Dt_MS,
    Curr_Offer_Intended_end_Dt_MS,
    Prev_Offer_Actual_End_Dt_SGE,
    Curr_Offer_Intended_end_Dt_SGE,
    Prev_Offer_Actual_End_Dt_HD_PACK,
    Curr_Offer_Intended_end_Dt_HD_PACK,
    Prev_Offer_Actual_End_Dt_BOX_SETS,
    Curr_Offer_Intended_end_Dt_BOX_SETS,
    Prev_Offer_Actual_End_Dt_SKY_KIDS,
    Curr_Offer_Intended_end_Dt_SKY_KIDS,
    Prev_Offer_Actual_End_Dt_TALK,
    Curr_Offer_Intended_end_Dt_TALK,
    Prev_Offer_Actual_End_Dt_SPOTIFY,
    Curr_Offer_Intended_end_Dt_SPOTIFY,
    ANY_NEW_OFFER_Active_Leg_1,
    NEW_DTV_OFFER_Active_leg_1,
    Offers_Applied_Lst_1D_Any,
    Offers_Applied_Lst_1D_DTV,
    Offers_Applied_Lst_day_any,
    Offers_Applied_Lst_day_dtv,
    Offers_Applied_Lst_1D_BB,
    Offers_Applied_Lst_1D_LR,
    Offers_Applied_Lst_1D_MS,
    Offers_Applied_Lst_1D_HD,
    pre_call_sports_product_holding,
    post_call_sports_product_holding,
    pre_call_movies_product_holding,
    post_call_movies_product_holding,
    TENURE,
    SIMPLE_SEGMENT,
    TV_REGION,
    mosaic_uk_group,
    year_week,
    WEEK_START,
    case when FAMILY_ADDED > 0 then 'FAMILY' when VARIETY_ADDED > 0 then 'VARIRTY' when ORIGINAL_ADDED > 0 then 'ORIGINAL' when SKYQ_LEGACY_ADDED > 0 then 'SKYQ_LEGACY' when SKY_ENT_ADDED > 0 then 'SKY_ENT' else null end as BASIC_DTV_ADDED_PRODUCT,
    case when FAMILY_REMOVED > 0 then 'FAMILY' when VARIETY_REMOVED > 0 then 'VARIRTY' when ORIGINAL_REMOVED > 0 then 'ORIGINAL' when SKYQ_LEGACY_REMOVED > 0 then 'SKYQ_LEGACY' when SKY_ENT_REMOVED > 0 then 'SKY_ENT' else null end as BASIC_DTV_REMOVED_PRODUCT,
    case when CLASSIC_MS_ADDED > 0 then 'CLASSIC_MS' when SKYQ_MS_ADDED > 0 then 'SKYQ_MS' else null end as MS_ADDED_PRODUCT,
    case when TALKU_ADDED > 0 then 'TALK UNLIMITED' when TALKW_ADDED > 0 then 'TALK WEEKEND' when TALKF_ADDED > 0 then 'TALKF FREETIME' when TALKA_ADDED > 0 then 'TALKA ANYTIME' when TALKP_ADDED > 0 then 'TALK PAY AS YOU GO' when TALKO_ADDED > 0 then 'TALK OFF PEAK' else null end as TALK_ADDED_PRODUCT,
    case when CLASSIC_MS_REMOVED > 0 then 'CLASSIC_MS' when SKYQ_MS_REMOVED > 0 then 'SKYQ_MS' else null end as MS_REMOVED_PRODUCT,
    case when TALKU_REMOVED > 0 then 'TALK UNLIMITED' when TALKW_REMOVED > 0 then 'TALK WEEKEND' when TALKF_REMOVED > 0 then 'TALKF FREETIME' when TALKA_REMOVED > 0 then 'TALKA ANYTIME' when TALKP_REMOVED > 0 then 'TALK PAY AS YOU GO' when TALKO_REMOVED > 0 then 'TALK OFF PEAK' else null end as TALK_REMOVED_PRODUCT,
    case when Netflix_Standard_Added > 0 then 'Netflix_Standard' when Netflix_Premium_Added > 0 then 'Netflix_Premium' else '' end as Netflix_Added_Product,
    case when Netflix_Standard_Removed > 0 then 'Netflix_Standard' when Netflix_Premium_Removed > 0 then 'Netflix_Premium' else '' end as Netflix_Removed_Product,
    case when PRE_CALL_ORIGINAL > 0 then 'ORIGINAL' when PRE_CALL_VARIETY > 0 then 'VARIETY' when PRE_CALL_FAMILY > 0 then 'FAMILY' when PRE_CALL_SKYQ > 0 then 'SKYQ_LEGACY' when PRE_CALL_SKY_ENT > 0 then 'SKY_ENT' else null end as PRE_CALL_BASIC_DTV_PRODUCT_HOLDING,
    case when POST_CALL_ORIGINAL > 0 then 'ORIGINAL' when POST_CALL_VARIETY > 0 then 'VARIETY' when POST_CALL_FAMILY > 0 then 'FAMILY' when POST_CALL_SKYQ > 0 then 'SKYQ_LEGACY' when POST_CALL_SKY_ENT > 0 then 'SKY_ENT' else null end as POST_CALL_BASIC_DTV_PRODUCT_HOLDING,
    (max(coalesce(app_usage_ntfx.longest_time_in_app,0.0)))/60000.0 as longest_time_in_nf_app,
    (min(coalesce(app_usage_ntfx.shortest_time_in_app,0.0)))/60000.0 as shortest_time_in_nf_app,
    sum(coalesce(app_usage_ntfx.total_app_launches,0.0)) as total_nf_app_launches,
    sum(coalesce(app_usage_ntfx.total_significant_app_launches,0.0)) as total_significant_nf_app_launches,
    sum(coalesce(app_usage_ntfx.total_time_in_app,0.0))/60000.0 as total_time_in_nf_app,
    (max(coalesce(app_usage_spotify.longest_time_in_app,0.0)))/60000.0 as longest_time_in_spotify_app,
    (min(coalesce(app_usage_spotify.shortest_time_in_app,0.0)))/60000.0 as shortest_time_in_spotify_app,
    sum(coalesce(app_usage_spotify.total_app_launches,0.0)) as total_spotify_app_launches,
    sum(coalesce(app_usage_spotify.total_significant_app_launches,0.0)) as total_significant_spotify_app_launches,
    sum(coalesce(app_usage_spotify.total_time_in_app,0.0))/60000.0 as total_time_in_spotify_app,
    Basic_contract_status_pre_call,
    Talk_contract_status_pre_call,
    BB_contract_status_pre_call,
    Add_on_contract_status_pre_call,
    Overall_contract_status_pre_call,
    Basic_contract_status_post_call,
    Talk_contract_status_post_call,
    BB_contract_status_post_call,
    Add_on_contract_status_post_call,
    Overall_contract_status_post_call,
    pre_call_sports_complete,
    post_call_sports_complete,
    pre_call_ala_carte_product_holding,
    post_call_ala_carte_product_holding,
    post_call_sky_go_extra,
    ta_in_last_seven_days,
    ta_in_last_one_month,
    ta_in_last_six_months,
    ta_in_last_one_year
    into #ECONOMETRICS_TA_CALLS
    from #ECONOMETRICS_TA_CALLS_NEW as ta
      left outer join q_stb_app_usage as app_usage_ntfx
      on ta.account_number = app_usage_ntfx.account_number
      and cast(app_usage_ntfx.event_datetime as date) between ta.event_dt-30 and ta.event_dt
      and trim(lower(app_usage_ntfx.app_name)) = 'netflix'
      left outer join q_stb_app_usage as app_usage_spotify
      on ta.account_number = app_usage_spotify.account_number
      and cast(app_usage_spotify.event_datetime as date) between ta.event_dt-30 and ta.event_dt
      and trim(lower(app_usage_spotify.app_name)) like 'spotify'
    group by ta.ACCOUNT_NUMBER,
    COUNTRY,
    EVENT_DT,
    subscription_id,
    NUMBER_CALLS,
    SAVED_FLAG,
    TA_attempt_type,
    last_ta_date,
    Time_Since_Last_TA_Event,
    ta_call_event,
    turnaround_description,
    livechat_turnaround_event,
    livechat_turnaround_description,
    pre_call_LR,
    post_call_LR,
    LR_added,
    LR_removed,
    pre_call_ms_product_holding,
    pre_call_ms_count,
    post_call_ms_product_holding,
    post_call_ms_count,
    ms_count_added,
    ms_count_removed,
    MS_Product_Holding_Added,
    MS_Product_Holding_Removed,
    pre_call_talk_product_holding,
    post_call_talk_product_holding,
    Talk_Product_Holding_Added,
    Talk_Product_Holding_Removed,
    pre_call_chelsea_tv,
    post_call_chelsea_tv,
    pre_call_mutv,
    post_call_mutv,
    pre_call_liverpool,
    post_call_liverpool,
    pre_call_skyasia,
    post_call_skyasia,
    pre_call_Spotify,
    post_call_Spotify,
    Spotify_Added,
    Spotify_Removed,
    UOD_ADDED,
    UOD_REMOVED,
    pre_call_Netflix,
    post_call_Netflix,
    Netflix_Standard_Added,
    Netflix_Standard_Removed,
    Netflix_Premium_Added,
    Netflix_Premium_Removed,
    chelsea_tv_Added,
    chelsea_tv_Removed,
    mutv_Added,
    mutv_Removed,
    liverpool_Added,
    liverpool_Removed,
    skyasia_Added,
    skyasia_Removed,
    ORDER_DT,
    EVENT_DT_SoD,
    Basic_Contract_Status_Level_2,
    Add_on_Products_Contract_Status_Level_2,
    Talk_Contract_Status_Level_2,
    BB_Contract_Status_Level_2,
    Overall_Contract_Status_Level_2,
    Basic_Contract_Status_Level_1,
    Add_on_Products_Contract_Status_Level_1,
    Talk_Contract_Status_Level_1,
    BB_Contract_Status_Level_1,
    Overall_Contract_Status_Level_1,
    SPORTS_ADDED,
    MOVIES_ADDED,
    LEGACY_SPORTS_SUB_ADDED,
    LEGACY_MOVIES_SUB_ADDED,
    LEGACY_SPORTS_ADDED,
    LEGACY_MOVIES_ADDED,
    SPORTS_PACK_SUB_ADDED,
    SPORTS_PACK_ADDED,
    LEGACY_SPORTS_SUB_REMOVED,
    LEGACY_MOVIES_SUB_REMOVED,
    LEGACY_SPORTS_REMOVED,
    LEGACY_MOVIES_REMOVED,
    SPORTS_PACK_SUB_REMOVED,
    SPORTS_PACK_REMOVED,
    FAMILY_ADDED,
    VARIETY_ADDED,
    ORIGINAL_ADDED,
    SKYQ_LEGACY_ADDED,
    HD_LEGACY_ADDED,
    HD_BASIC_ADDED,
    HD_PREMIUM_ADDED,
    CLASSIC_MS_ADDED,
    SKYQ_MS_ADDED,
    SKY_PLUS_ADDED,
    SKY_GO_EXTRA_ADDED,
    NOW_TV_ADDED,
    BB_UNLIMITED_ADDED,
    BB_LITE_ADDED,
    BB_FIBRE_CAP_ADDED,
    BB_FIBRE_UNLIMITED_ADDED,
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
    SKYQ_LEGACY_REMOVED,
    HD_LEGACY_REMOVED,
    HD_BASIC_REMOVED,
    HD_PREMIUM_REMOVED,
    CLASSIC_MS_REMOVED,
    SKYQ_MS_REMOVED,
    SKY_PLUS_REMOVED,
    SKY_GO_EXTRA_REMOVED,
    NOW_TV_REMOVED,
    BB_UNLIMITED_REMOVED,
    BB_LITE_REMOVED,
    BB_FIBRE_CAP_REMOVED,
    BB_FIBRE_UNLIMITED_REMOVED,
    TALKU_REMOVED,
    TALKW_REMOVED,
    TALKF_REMOVED,
    TALKA_REMOVED,
    TALKP_REMOVED,
    TALKO_REMOVED,
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
    CINEMA_ADDED,
    CINEMA_REMOVED,
    SKY_KIDS_ADDED,
    SKY_KIDS_REMOVED,
    SKY_BOXSETS_ADDED,
    SKY_BOXSETS_REMOVED,
    SKY_ENT_ADDED,
    SKY_ENT_REMOVED,
    DTV_ADDED,
    DTV_REMOVED,
    BB_ADDED,
    BB_REMOVED,
    PRE_CALL_DTV,
    PRE_CALL_ORIGINAL,
    PRE_CALL_VARIETY,
    PRE_CALL_FAMILY,
    PRE_CALL_SKYQ,
    PRE_CALL_TOP_TIER,
    PRE_CALL_SKY_ENT,
    PRE_CALL_SKY_KIDS,
    PRE_CALL_SKY_BOXSETS,
    PRE_CALL_HD_BASIC,
    PRE_CALL_HD_PREMIUM,
    PRE_CALL_SKY_GO_EXTRA,
    PRE_CALL_TOTAL_PREMIUMS,
    PRE_CALL_TOTAL_SPORTS,
    PRE_CALL_TOTAL_MOVIES,
    BB_ACTIVE,
    BB_Product_Holding,
    PRE_CALL_BB_ACTIVE,
    PRE_CALL_BB_Product_Holding,
    POST_CALL_BB_ACTIVE,
    POST_CALL_BB_Product_Holding,
    POST_CALL_DTV,
    POST_CALL_SKY_PLUS,
    POST_CALL_ORIGINAL,
    POST_CALL_VARIETY,
    POST_CALL_FAMILY,
    POST_CALL_SKYQ,
    POST_CALL_SKY_ENT,
    POST_CALL_SKY_KIDS,
    POST_CALL_SKY_BOXSETS,
    POST_CALL_HD_BASIC,
    POST_CALL_HD_PREMIUM,
    POST_CALL_TOP_TIER,
    POST_CALL_TOTAL_PREMIUMS,
    POST_CALL_TOTAL_SPORTS,
    POST_CALL_TOTAL_MOVIES,
    ACTUAL_OFFER_STATUS,
    INTENDED_OFFER_STATUS,
    ANY_OFFER_Active,
    DTV_OFFER_Active,
    BB_OFFER_Active,
    LR_OFFER_Active,
    MS_OFFER_Active,
    HD_OFFER_Active,
    ANY_OFFER_GIVEN,
    DTV_OFFER_GIVEN,
    Prems_Product_Count,
    Sports_Product_Count,
    Movies_Product_Count,
    PRE_CALL_Prems_Active,
    Prems_Active,
    PRE_CALL_Sports_Active,
    Sports_Active,
    PRE_CALL_Movies_Active,
    Movies_Active,
    Prev_Offer_Start_Dt_Any,
    Prev_Offer_Intended_end_Dt_Any,
    Prev_Offer_Actual_End_Dt_Any,
    Curr_Offer_Start_Dt_Any,
    Curr_Offer_Intended_end_Dt_Any,
    Curr_Offer_Actual_End_Dt_Any,
    Offer_End_Status_Level_1,
    BASIC_OFFER_END_STATUS_LEVEL_1,
    BB_OFFER_END_STATUS_LEVEL_1,
    LR_OFFER_END_STATUS_LEVEL_1,
    PREMIUM_OFFER_END_STATUS_LEVEL_1,
    Sports_OFFER_END_STATUS_LEVEL_1,
    Cinema_OFFER_END_STATUS_LEVEL_1,
    HD_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    MS_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    Offer_End_Status_Level_2,
    BASIC_OFFER_END_STATUS_LEVEL_2,
    BB_OFFER_END_STATUS_LEVEL_2,
    LR_OFFER_END_STATUS_LEVEL_2,
    PREMIUM_OFFER_END_STATUS_LEVEL_2,
    Sports_OFFER_END_STATUS_LEVEL_2,
    Cinema_OFFER_END_STATUS_LEVEL_2,
    HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    Prev_Offer_Actual_End_Dt_DTV,
    Curr_Offer_Intended_end_Dt_DTV,
    Prev_Offer_Actual_End_Dt_BB,
    Curr_Offer_Intended_end_Dt_BB,
    Prev_Offer_Actual_End_Dt_LR,
    Curr_Offer_Intended_end_Dt_LR,
    Curr_Offer_Intended_end_Dt_Movies,
    Prev_Offer_Actual_End_Dt_Movies,
    Curr_Offer_Intended_end_Dt_Sports,
    Prev_Offer_Actual_End_Dt_Sports,
    Prev_Offer_Actual_End_Dt_HD,
    Curr_Offer_Intended_end_Dt_HD,
    Prev_Offer_Actual_End_Dt_MS,
    Curr_Offer_Intended_end_Dt_MS,
    Prev_Offer_Actual_End_Dt_SGE,
    Curr_Offer_Intended_end_Dt_SGE,
    Prev_Offer_Actual_End_Dt_HD_PACK,
    Curr_Offer_Intended_end_Dt_HD_PACK,
    Prev_Offer_Actual_End_Dt_BOX_SETS,
    Curr_Offer_Intended_end_Dt_BOX_SETS,
    Prev_Offer_Actual_End_Dt_SKY_KIDS,
    Curr_Offer_Intended_end_Dt_SKY_KIDS,
    Prev_Offer_Actual_End_Dt_TALK,
    Curr_Offer_Intended_end_Dt_TALK,
    Prev_Offer_Actual_End_Dt_SPOTIFY,
    Curr_Offer_Intended_end_Dt_SPOTIFY,
    ANY_NEW_OFFER_Active_Leg_1,
    NEW_DTV_OFFER_Active_leg_1,
    Offers_Applied_Lst_1D_Any,
    Offers_Applied_Lst_1D_DTV,
    Offers_Applied_Lst_day_any,
    Offers_Applied_Lst_day_dtv,
    Offers_Applied_Lst_1D_BB,
    Offers_Applied_Lst_1D_LR,
    Offers_Applied_Lst_1D_MS,
    Offers_Applied_Lst_1D_HD,
    pre_call_sports_product_holding,
    post_call_sports_product_holding,
    pre_call_movies_product_holding,
    post_call_movies_product_holding,
    TENURE,
    SIMPLE_SEGMENT,
    TV_REGION,
    mosaic_uk_group,
    year_week,
    WEEK_START,
    BASIC_DTV_ADDED_PRODUCT,
    BASIC_DTV_REMOVED_PRODUCT,
    MS_ADDED_PRODUCT,
    MS_REMOVED_PRODUCT,
    TALK_ADDED_PRODUCT,
    TALK_REMOVED_PRODUCT,
    Netflix_Added_Product,
    Netflix_Removed_Product,
    PRE_CALL_BASIC_DTV_PRODUCT_HOLDING,
    POST_CALL_BASIC_DTV_PRODUCT_HOLDING,
    Basic_contract_status_pre_call,
    Talk_contract_status_pre_call,
    BB_contract_status_pre_call,
    Add_on_contract_status_pre_call,
    Overall_contract_status_pre_call,
    Basic_contract_status_post_call,
    Talk_contract_status_post_call,
    BB_contract_status_post_call,
    Add_on_contract_status_post_call,
    Overall_contract_status_post_call,
    pre_call_sports_complete,
    post_call_sports_complete,
    pre_call_ala_carte_product_holding,
    post_call_ala_carte_product_holding,
    post_call_sky_go_extra,
    ta_in_last_seven_days,
    ta_in_last_one_month,
    ta_in_last_six_months,
    ta_in_last_one_year;
  commit work;
  delete from Decisioning.ECONOMETRICS_TA_CALLS_ACCOUNT_LEVEL
    where WEEK_START between PERIOD_START and PERIOD_END;
  insert into Decisioning.ECONOMETRICS_TA_CALLS_ACCOUNT_LEVEL
    select ACCOUNT_NUMBER,
      COUNTRY,
      EVENT_DT,
      subscription_id,
      NUMBER_CALLS,
      SAVED_FLAG,
      ORDER_DT,
      Basic_Contract_Status_Level_2,
      Add_on_Products_Contract_Status_Level_2,
      Talk_Contract_Status_Level_2,
      BB_Contract_Status_Level_2,
      Overall_Contract_Status_Level_2,
      Basic_Contract_Status_Level_1,
      Add_on_Products_Contract_Status_Level_1,
      Talk_Contract_Status_Level_1,
      BB_Contract_Status_Level_1,
      Overall_Contract_Status_Level_1,
      EVENT_DT_SoD,
      SPORTS_ADDED,
      MOVIES_ADDED,
      LEGACY_SPORTS_SUB_ADDED,
      LEGACY_MOVIES_SUB_ADDED,
      SPORTS_PACK_SUB_ADDED,
      SPORTS_PACK_ADDED,
      LEGACY_SPORTS_SUB_REMOVED,
      LEGACY_MOVIES_SUB_REMOVED,
      SPORTS_PACK_SUB_REMOVED,
      SPORTS_PACK_REMOVED,
      BASIC_DTV_ADDED_PRODUCT,
      BASIC_DTV_REMOVED_PRODUCT,
      HD_LEGACY_ADDED,
      HD_BASIC_ADDED,
      HD_PREMIUM_ADDED,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      TALK_ADDED_PRODUCT,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      HD_LEGACY_REMOVED,
      HD_BASIC_REMOVED,
      HD_PREMIUM_REMOVED,
      MS_REMOVED_PRODUCT,
      SKY_PLUS_REMOVED,
      SKY_GO_EXTRA_REMOVED,
      NOW_TV_REMOVED,
      TALK_REMOVED_PRODUCT,
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
      CINEMA_ADDED,
      CINEMA_REMOVED,
      SKY_KIDS_ADDED,
      SKY_KIDS_REMOVED,
      SKY_BOXSETS_ADDED,
      SKY_BOXSETS_REMOVED,
      Spotify_Added,
      Spotify_Removed,
      UOD_ADDED,
      UOD_REMOVED,
      --pre_call_Netflix,
      --post_call_Netflix,
      Netflix_Added_Product,
      Netflix_Removed_Product,
      DTV_ADDED,
      DTV_REMOVED,
      BB_ADDED,
      BB_REMOVED,
      PRE_CALL_DTV,
      PRE_CALL_BASIC_DTV_PRODUCT_HOLDING,
      POST_CALL_BASIC_DTV_PRODUCT_HOLDING,
      PRE_CALL_TOP_TIER,
      PRE_CALL_SKY_KIDS,
      PRE_CALL_SKY_BOXSETS,
      PRE_CALL_HD_BASIC,
      PRE_CALL_HD_PREMIUM,
      PRE_CALL_TOTAL_PREMIUMS,
      PRE_CALL_TOTAL_SPORTS,
      PRE_CALL_TOTAL_MOVIES,
      BB_ACTIVE,
      BB_Product_Holding,
      PRE_CALL_BB_ACTIVE,
      PRE_CALL_BB_Product_Holding,
      POST_CALL_BB_ACTIVE,
      POST_CALL_BB_Product_Holding,
      POST_CALL_DTV,
      POST_CALL_SKY_KIDS,
      POST_CALL_SKY_BOXSETS,
      POST_CALL_HD_BASIC,
      POST_CALL_HD_PREMIUM,
      POST_CALL_TOP_TIER,
      POST_CALL_TOTAL_PREMIUMS,
      POST_CALL_TOTAL_SPORTS,
      POST_CALL_TOTAL_MOVIES,
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      ANY_OFFER_Active,
      ANY_OFFER_GIVEN,
      Prems_Product_Count,
      Sports_Product_Count,
      Movies_Product_Count,
      PRE_CALL_Prems_Active,
      Prems_Active,
      PRE_CALL_Sports_Active,
      Sports_Active,
      PRE_CALL_Movies_Active,
      Movies_Active,
      Prev_Offer_Start_Dt_Any,
      Prev_Offer_Intended_end_Dt_Any,
      Prev_Offer_Actual_End_Dt_Any,
      Curr_Offer_Start_Dt_Any,
      Curr_Offer_Intended_end_Dt_Any,
      Curr_Offer_Actual_End_Dt_Any,
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      BASIC_OFFER_END_STATUS_LEVEL_1,
      PREMIUM_OFFER_END_STATUS_LEVEL_1,
      Sports_OFFER_END_STATUS_LEVEL_1,
      Cinema_OFFER_END_STATUS_LEVEL_1,
      BB_OFFER_END_STATUS_LEVEL_1,
      LR_OFFER_END_STATUS_LEVEL_1,
      ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
      BASIC_OFFER_END_STATUS_LEVEL_2,
      PREMIUM_OFFER_END_STATUS_LEVEL_2,
      Sports_OFFER_END_STATUS_LEVEL_2,
      Cinema_OFFER_END_STATUS_LEVEL_2,
      BB_OFFER_END_STATUS_LEVEL_2,
      LR_OFFER_END_STATUS_LEVEL_2,
      ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
      pre_call_sports_product_holding,
      post_call_sports_product_holding,
      pre_call_movies_product_holding,
      post_call_movies_product_holding,
      ANY_NEW_OFFER_Active_Leg_1,
      NEW_DTV_OFFER_Active_leg_1,
      Offers_Applied_Lst_1D_Any,
      Offers_Applied_Lst_1D_DTV,
      Offers_Applied_Lst_1D_BB,
      Offers_Applied_Lst_1D_LR,
      Offers_Applied_Lst_1D_MS,
      Offers_Applied_Lst_1D_HD,
      DTV_OFFER_Active,
      DTV_OFFER_GIVEN,
      BB_OFFER_Active,
      LR_OFFER_Active,
      MS_OFFER_Active,
      HD_OFFER_Active,
      POST_CALL_SKY_PLUS,
      TENURE,
      TV_REGION,
      year_week,
      WEEK_START,
      TA_attempt_type,
      last_ta_date,
      Time_Since_Last_TA_Event,
      ta_call_event,
      turnaround_description,
      livechat_turnaround_event,
      livechat_turnaround_description,
      pre_call_LR,
      post_call_LR,
      LR_added,
      LR_removed,
      pre_call_ms_product_holding,
      pre_call_ms_count,
      post_call_ms_product_holding,
      post_call_ms_count,
      ms_count_added,
      ms_count_removed,
      MS_Product_Holding_Added,
      MS_Product_Holding_Removed,
      pre_call_talk_product_holding,
      post_call_talk_product_holding,
      Talk_Product_Holding_Added,
      Talk_Product_Holding_Removed,
      pre_call_chelsea_tv,
      post_call_chelsea_tv,
      pre_call_mutv,
      post_call_mutv,
      pre_call_liverpool,
      post_call_liverpool,
      pre_call_skyasia,
      post_call_skyasia,
      chelsea_tv_Added,
      chelsea_tv_Removed,
      mutv_Added,
      mutv_Removed,
      liverpool_Added,
      liverpool_Removed,
      skyasia_Added,
      skyasia_Removed,
      longest_time_in_nf_app,
      total_nf_app_launches,
      total_time_in_nf_app,
      longest_time_in_spotify_app,
      total_spotify_app_launches,
      total_time_in_spotify_app,
      Basic_contract_status_pre_call,
      Talk_contract_status_pre_call,
      BB_contract_status_pre_call,
      Add_on_contract_status_pre_call,
      Overall_contract_status_pre_call,
      Basic_contract_status_post_call,
      Talk_contract_status_post_call,
      BB_contract_status_post_call,
      Add_on_contract_status_post_call,
      Overall_contract_status_post_call,
      pre_call_sports_complete,
      post_call_sports_complete,
      pre_call_ala_carte_product_holding,
      post_call_ala_carte_product_holding,
      pre_call_sky_go_extra,
      post_call_sky_go_extra,
      ta_in_last_seven_days,
      ta_in_last_one_month,
      ta_in_last_six_months,
      ta_in_last_one_year
      from #ECONOMETRICS_TA_CALLS;
  delete from Decisioning.ECONOMETRICS_TA_CALLS
    where WEEK_START between PERIOD_START and PERIOD_END;
  insert into Decisioning.ECONOMETRICS_TA_CALLS
    select YEAR_WEEK,
      WEEK_START,
      COUNTRY,
      SAVED_FLAG,
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      SPORTS_ADDED,
      MOVIES_ADDED,
      LEGACY_SPORTS_SUB_ADDED,
      LEGACY_MOVIES_SUB_ADDED,
      SPORTS_PACK_SUB_ADDED,
      SPORTS_PACK_ADDED,
      LEGACY_SPORTS_SUB_REMOVED,
      LEGACY_MOVIES_SUB_REMOVED,
      SPORTS_PACK_SUB_REMOVED,
      SPORTS_PACK_REMOVED,
      BASIC_DTV_ADDED_PRODUCT,
      BASIC_DTV_REMOVED_PRODUCT,
      HD_LEGACY_ADDED,
      HD_BASIC_ADDED,
      HD_PREMIUM_ADDED,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      PRE_CALL_BB_ACTIVE,
      PRE_CALL_BB_PRODUCT_HOLDING,
      POST_CALL_BB_ACTIVE,
      POST_CALL_BB_PRODUCT_HOLDING,
      POST_CALL_DTV,
      TALK_ADDED_PRODUCT,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      HD_LEGACY_REMOVED,
      HD_BASIC_REMOVED,
      HD_PREMIUM_REMOVED,
      MS_REMOVED_PRODUCT,
      SKY_PLUS_REMOVED,
      SKY_GO_EXTRA_REMOVED,
      NOW_TV_REMOVED,
      TALK_REMOVED_PRODUCT,
      PRE_CALL_DTV,
      PRE_CALL_BASIC_DTV_PRODUCT_HOLDING,
      POST_CALL_BASIC_DTV_PRODUCT_HOLDING,
      PRE_CALL_TOP_TIER,
      PRE_CALL_TOTAL_PREMIUMS,
      PRE_CALL_TOTAL_SPORTS,
      PRE_CALL_TOTAL_MOVIES,
      POST_CALL_TOP_TIER,
      POST_CALL_TOTAL_PREMIUMS,
      POST_CALL_TOTAL_SPORTS,
      POST_CALL_TOTAL_MOVIES,
      ANY_OFFER_Active,
      ANY_OFFER_GIVEN,
      DTV_OFFER_Active,
      DTV_OFFER_GIVEN,
      BB_OFFER_Active,
      LR_OFFER_Active,
      MS_OFFER_Active,
      HD_OFFER_Active,
      POST_CALL_SKY_PLUS,
      TENURE,
      TV_REGION,
      SUM(NUMBER_CALLS) as NUMBER_OF_TA_EVENTS,
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
      CINEMA_ADDED,
      CINEMA_REMOVED,
      PRE_CALL_Sports_Active,
      Sports_Active as POST_CALL_Sports_Active,
      PRE_CALL_Movies_Active,
      Movies_Active as POST_CALL_Movies_Active,
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      BASIC_OFFER_END_STATUS_LEVEL_1,
      PREMIUM_OFFER_END_STATUS_LEVEL_1,
      Sports_OFFER_END_STATUS_LEVEL_1,
      Cinema_OFFER_END_STATUS_LEVEL_1,
      BB_OFFER_END_STATUS_LEVEL_1,
      LR_OFFER_END_STATUS_LEVEL_1,
      ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
      BASIC_OFFER_END_STATUS_LEVEL_2,
      PREMIUM_OFFER_END_STATUS_LEVEL_2,
      Sports_OFFER_END_STATUS_LEVEL_2,
      Cinema_OFFER_END_STATUS_LEVEL_2,
      BB_OFFER_END_STATUS_LEVEL_2,
      LR_OFFER_END_STATUS_LEVEL_2,
      ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
      pre_call_sports_product_holding,
      post_call_sports_product_holding,
      pre_call_movies_product_holding,
      post_call_movies_product_holding,
      ANY_NEW_OFFER_Active_Leg_1,
      NEW_DTV_OFFER_Active_leg_1,
      SKY_KIDS_ADDED,
      SKY_KIDS_REMOVED,
      SKY_BOXSETS_ADDED,
      SKY_BOXSETS_REMOVED,
      Spotify_ADDED,
      SPOTIFY_REMOVED,
      UOD_ADDED,
      UOD_REMOVED,
      --pre_call_Netflix,
      --post_call_Netflix,
      Netflix_Added_Product,
      Netflix_Removed_Product,
      PRE_CALL_SKY_KIDS,
      PRE_CALL_SKY_BOXSETS,
      POST_CALL_SKY_KIDS,
      POST_CALL_SKY_BOXSETS,
      PRE_CALL_HD_BASIC,
      PRE_CALL_HD_PREMIUM,
      POST_CALL_HD_BASIC,
      POST_CALL_HD_PREMIUM,
      Basic_Contract_Status_Level_2,
      Add_on_Products_Contract_Status_Level_2,
      Talk_Contract_Status_Level_2,
      BB_Contract_Status_Level_2,
      Overall_Contract_Status_Level_2,
      Basic_Contract_Status_Level_1,
      Add_on_Products_Contract_Status_Level_1,
      Talk_Contract_Status_Level_1,
      BB_Contract_Status_Level_1,
      Overall_Contract_Status_Level_1,
      TA_attempt_type,
      last_ta_date,
      Time_Since_Last_TA_Event,
      ta_call_event,
      turnaround_description,
      livechat_turnaround_event,
      livechat_turnaround_description,
      pre_call_LR,
      post_call_LR,
      LR_added,
      LR_removed,
      pre_call_ms_product_holding,
      pre_call_ms_count,
      post_call_ms_product_holding,
      post_call_ms_count,
      ms_count_added,
      ms_count_removed,
      MS_Product_Holding_Added,
      MS_Product_Holding_Removed,
      pre_call_talk_product_holding,
      post_call_talk_product_holding,
      Talk_Product_Holding_Added,
      Talk_Product_Holding_Removed,
      pre_call_chelsea_tv,
      post_call_chelsea_tv,
      pre_call_mutv,
      post_call_mutv,
      pre_call_liverpool,
      post_call_liverpool,
      pre_call_skyasia,
      post_call_skyasia,
      chelsea_tv_Added,
      chelsea_tv_Removed,
      mutv_Added,
      mutv_Removed,
      liverpool_Added,
      liverpool_Removed,
      skyasia_Added,
      skyasia_Removed,
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
      Basic_contract_status_pre_call,
      Talk_contract_status_pre_call,
      BB_contract_status_pre_call,
      Add_on_contract_status_pre_call,
      Overall_contract_status_pre_call,
      Basic_contract_status_post_call,
      Talk_contract_status_post_call,
      BB_contract_status_post_call,
      Add_on_contract_status_post_call,
      Overall_contract_status_post_call,
      pre_call_sports_complete,
      post_call_sports_complete,
      pre_call_ala_carte_product_holding,
      post_call_ala_carte_product_holding,
      pre_call_sky_go_extra,
      post_call_sky_go_extra,
      ta_in_last_seven_days,
      ta_in_last_one_month,
      ta_in_last_six_months,
      ta_in_last_one_year
      from #ECONOMETRICS_TA_CALLS
      group by YEAR_WEEK,
      WEEK_START,
      COUNTRY,
      SAVED_FLAG,
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      SPORTS_ADDED,
      MOVIES_ADDED,
      LEGACY_SPORTS_SUB_ADDED,
      LEGACY_MOVIES_SUB_ADDED,
      SPORTS_PACK_SUB_ADDED,
      SPORTS_PACK_ADDED,
      LEGACY_SPORTS_SUB_REMOVED,
      LEGACY_MOVIES_SUB_REMOVED,
      SPORTS_PACK_SUB_REMOVED,
      SPORTS_PACK_REMOVED,
      BASIC_DTV_ADDED_PRODUCT,
      BASIC_DTV_REMOVED_PRODUCT,
      HD_LEGACY_ADDED,
      HD_BASIC_ADDED,
      HD_PREMIUM_ADDED,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      PRE_CALL_BB_ACTIVE,
      PRE_CALL_BB_PRODUCT_HOLDING,
      POST_CALL_BB_ACTIVE,
      POST_CALL_BB_PRODUCT_HOLDING,
      POST_CALL_DTV,
      TALK_ADDED_PRODUCT,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      HD_LEGACY_REMOVED,
      HD_BASIC_REMOVED,
      HD_PREMIUM_REMOVED,
      MS_REMOVED_PRODUCT,
      SKY_PLUS_REMOVED,
      SKY_GO_EXTRA_REMOVED,
      NOW_TV_REMOVED,
      TALK_REMOVED_PRODUCT,
      PRE_CALL_DTV,
      PRE_CALL_BASIC_DTV_PRODUCT_HOLDING,
      POST_CALL_BASIC_DTV_PRODUCT_HOLDING,
      PRE_CALL_TOP_TIER,
      PRE_CALL_TOTAL_PREMIUMS,
      PRE_CALL_TOTAL_SPORTS,
      PRE_CALL_TOTAL_MOVIES,
      POST_CALL_TOP_TIER,
      POST_CALL_TOTAL_PREMIUMS,
      POST_CALL_TOTAL_SPORTS,
      POST_CALL_TOTAL_MOVIES,
      ANY_OFFER_Active,
      ANY_OFFER_GIVEN,
      DTV_OFFER_Active,
      DTV_OFFER_GIVEN,
      BB_OFFER_Active,
      LR_OFFER_Active,
      MS_OFFER_Active,
      HD_OFFER_Active,
      POST_CALL_SKY_PLUS,
      TENURE,
      TV_REGION,
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
      CINEMA_ADDED,
      CINEMA_REMOVED,
      PRE_CALL_Sports_Active,
      POST_CALL_Sports_Active,
      PRE_CALL_Movies_Active,
      POST_CALL_Movies_Active,
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      BASIC_OFFER_END_STATUS_LEVEL_1,
      PREMIUM_OFFER_END_STATUS_LEVEL_1,
      Sports_OFFER_END_STATUS_LEVEL_1,
      Cinema_OFFER_END_STATUS_LEVEL_1,
      BB_OFFER_END_STATUS_LEVEL_1,
      LR_OFFER_END_STATUS_LEVEL_1,
      ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
      BASIC_OFFER_END_STATUS_LEVEL_2,
      PREMIUM_OFFER_END_STATUS_LEVEL_2,
      Sports_OFFER_END_STATUS_LEVEL_2,
      Cinema_OFFER_END_STATUS_LEVEL_2,
      BB_OFFER_END_STATUS_LEVEL_2,
      LR_OFFER_END_STATUS_LEVEL_2,
      ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
      pre_call_sports_product_holding,
      post_call_sports_product_holding,
      pre_call_movies_product_holding,
      post_call_movies_product_holding,
      ANY_NEW_OFFER_Active_Leg_1,
      NEW_DTV_OFFER_Active_leg_1,
      SKY_KIDS_ADDED,
      SKY_KIDS_REMOVED,
      SKY_BOXSETS_ADDED,
      SKY_BOXSETS_REMOVED,
      SPOTIFY_ADDED,
      SPOTIFY_REMOVED,
      UOD_ADDED,
      UOD_REMOVED,
      --pre_call_Netflix,
      --post_call_Netflix,
      --Netflix_Added_Product,
      --Netflix_Removed_Product,
      Netflix_Added_Product,
      Netflix_Removed_Product,
      PRE_CALL_SKY_KIDS,
      PRE_CALL_SKY_BOXSETS,
      POST_CALL_SKY_KIDS,
      POST_CALL_SKY_BOXSETS,
      PRE_CALL_HD_BASIC,
      PRE_CALL_HD_PREMIUM,
      POST_CALL_HD_BASIC,
      POST_CALL_HD_PREMIUM,
      Basic_Contract_Status_Level_2,
      Add_on_Products_Contract_Status_Level_2,
      Talk_Contract_Status_Level_2,
      BB_Contract_Status_Level_2,
      Overall_Contract_Status_Level_2,
      Basic_Contract_Status_Level_1,
      Add_on_Products_Contract_Status_Level_1,
      Talk_Contract_Status_Level_1,
      BB_Contract_Status_Level_1,
      Overall_Contract_Status_Level_1,
      TA_attempt_type,
      last_ta_date,
      Time_Since_Last_TA_Event,
      ta_call_event,
      turnaround_description,
      livechat_turnaround_event,
      livechat_turnaround_description,
      pre_call_LR,
      post_call_LR,
      LR_added,
      LR_removed,
      pre_call_ms_product_holding,
      pre_call_ms_count,
      post_call_ms_product_holding,
      post_call_ms_count,
      ms_count_added,
      ms_count_removed,
      MS_Product_Holding_Added,
      MS_Product_Holding_Removed,
      pre_call_talk_product_holding,
      post_call_talk_product_holding,
      Talk_Product_Holding_Added,
      Talk_Product_Holding_Removed,
      pre_call_chelsea_tv,
      post_call_chelsea_tv,
      pre_call_mutv,
      post_call_mutv,
      pre_call_liverpool,
      post_call_liverpool,
      pre_call_skyasia,
      post_call_skyasia,
      chelsea_tv_Added,
      chelsea_tv_Removed,
      mutv_Added,
      mutv_Removed,
      liverpool_Added,
      liverpool_Removed,
      skyasia_Added,
      skyasia_Removed,
      Basic_contract_status_pre_call,
      Talk_contract_status_pre_call,
      BB_contract_status_pre_call,
      Add_on_contract_status_pre_call,
      Overall_contract_status_pre_call,
      Basic_contract_status_post_call,
      Talk_contract_status_post_call,
      BB_contract_status_post_call,
      Add_on_contract_status_post_call,
      Overall_contract_status_post_call,
      pre_call_sports_complete,
      post_call_sports_complete,
      pre_call_ala_carte_product_holding,
      post_call_ala_carte_product_holding,
      pre_call_sky_go_extra,
      post_call_sky_go_extra,
      ta_in_last_seven_days,
      ta_in_last_one_month,
      ta_in_last_six_months,
      ta_in_last_one_year;
  select ACCOUNT_NUMBER,
    COUNTRY,
    EVENT_DT,
    ORDER_DT,
    NUMBER_CALLS,
    SAVED_FLAG,
    SPORTS_ADDED,
    MOVIES_ADDED,
    LEGACY_SPORTS_SUB_ADDED,
    LEGACY_MOVIES_SUB_ADDED,
    LEGACY_SPORTS_ADDED,
    LEGACY_MOVIES_ADDED,
    SPORTS_PACK_SUB_ADDED,
    SPORTS_PACK_ADDED,
    LEGACY_SPORTS_SUB_REMOVED,
    LEGACY_MOVIES_SUB_REMOVED,
    LEGACY_SPORTS_REMOVED,
    LEGACY_MOVIES_REMOVED,
    SPORTS_PACK_SUB_REMOVED,
    SPORTS_PACK_REMOVED,
    FAMILY_ADDED,
    VARIETY_ADDED,
    ORIGINAL_ADDED,
    SKYQ_LEGACY_ADDED,
    HD_LEGACY_ADDED,
    HD_BASIC_ADDED,
    HD_PREMIUM_ADDED,
    CLASSIC_MS_ADDED,
    SKYQ_MS_ADDED,
    SKY_PLUS_ADDED,
    SKY_GO_EXTRA_ADDED,
    NOW_TV_ADDED,
    PRE_CALL_BB_ACTIVE,
    PRE_CALL_BB_PRODUCT_HOLDING,
    POST_CALL_BB_ACTIVE,
    POST_CALL_BB_PRODUCT_HOLDING,
    POST_CALL_DTV,
    BB_UNLIMITED_ADDED,
    BB_LITE_ADDED,
    BB_FIBRE_CAP_ADDED,
    BB_FIBRE_UNLIMITED_ADDED,
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
    SKYQ_LEGACY_REMOVED,
    HD_LEGACY_REMOVED,
    HD_BASIC_REMOVED,
    HD_PREMIUM_REMOVED,
    CLASSIC_MS_REMOVED,
    SKYQ_MS_REMOVED,
    SKY_PLUS_REMOVED,
    SKY_GO_EXTRA_REMOVED,
    NOW_TV_REMOVED,
    BB_UNLIMITED_REMOVED,
    BB_LITE_REMOVED,
    BB_FIBRE_CAP_REMOVED,
    BB_FIBRE_UNLIMITED_REMOVED,
    TALKU_REMOVED,
    TALKW_REMOVED,
    TALKF_REMOVED,
    TALKA_REMOVED,
    TALKP_REMOVED,
    TALKO_REMOVED,
    PRE_CALL_DTV,
    PRE_CALL_ORIGINAL,
    PRE_CALL_VARIETY,
    PRE_CALL_FAMILY,
    PRE_CALL_SKYQ,
    PRE_CALL_TOP_TIER,
    PRE_CALL_TOTAL_PREMIUMS,
    PRE_CALL_TOTAL_SPORTS,
    PRE_CALL_TOTAL_MOVIES,
    POST_CALL_ORIGINAL,
    POST_CALL_VARIETY,
    POST_CALL_FAMILY,
    POST_CALL_SKYQ,
    POST_CALL_TOP_TIER,
    POST_CALL_TOTAL_PREMIUMS,
    POST_CALL_TOTAL_SPORTS,
    POST_CALL_TOTAL_MOVIES,
    ACTUAL_OFFER_STATUS,
    INTENDED_OFFER_STATUS,
    ANY_OFFER_Active,
    ANY_OFFER_GIVEN,
    DTV_OFFER_Active,
    DTV_OFFER_GIVEN,
    BB_OFFER_Active,
    LR_OFFER_Active,
    MS_OFFER_Active,
    HD_OFFER_Active,
    POST_CALL_SKY_PLUS,
    TENURE,
    SIMPLE_SEGMENT,
    TV_REGION,
    mosaic_uk_group,
    year_week,
    WEEK_START,
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
    CINEMA_ADDED,
    CINEMA_REMOVED,
    PRE_CALL_Prems_Active,
    Prems_Active as POST_CALL_Prems_Active,
    PRE_CALL_Sports_Active,
    Sports_Active as POST_CALL_Sports_Active,
    PRE_CALL_Movies_Active,
    Movies_Active as POST_CALL_Movies_Active,
    Offer_End_Status_Level_1,
    Offer_End_Status_Level_2,
    BASIC_OFFER_END_STATUS_LEVEL_1,
    PREMIUM_OFFER_END_STATUS_LEVEL_1,
    Sports_OFFER_END_STATUS_LEVEL_1,
    Cinema_OFFER_END_STATUS_LEVEL_1,
    BB_OFFER_END_STATUS_LEVEL_1,
    LR_OFFER_END_STATUS_LEVEL_1,
    ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    BASIC_OFFER_END_STATUS_LEVEL_2,
    PREMIUM_OFFER_END_STATUS_LEVEL_2,
    Sports_OFFER_END_STATUS_LEVEL_2,
    Cinema_OFFER_END_STATUS_LEVEL_2,
    BB_OFFER_END_STATUS_LEVEL_2,
    LR_OFFER_END_STATUS_LEVEL_2,
    ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    pre_call_sports_product_holding,
    post_call_sports_product_holding,
    pre_call_movies_product_holding,
    post_call_movies_product_holding,
    ANY_NEW_OFFER_Active_Leg_1,
    NEW_DTV_OFFER_Active_leg_1,
    SKY_KIDS_ADDED,
    SKY_KIDS_REMOVED,
    SKY_BOXSETS_ADDED,
    SKY_BOXSETS_REMOVED,
    SPOTIFY_ADDED,
    SPOTIFY_REMOVED,
    UOD_ADDED,
    UOD_REMOVED,
    --pre_call_Netflix,
    --post_call_Netflix,
    Netflix_Added_Product,
    Netflix_Removed_Product,
    BASIC_DTV_ADDED_PRODUCT,
    BASIC_DTV_REMOVED_PRODUCT,
    SKY_ENT_ADDED,
    SKY_ENT_REMOVED,
    PRE_CALL_SKY_ENT,
    PRE_CALL_SKY_KIDS,
    PRE_CALL_SKY_BOXSETS,
    POST_CALL_SKY_ENT,
    POST_CALL_SKY_KIDS,
    POST_CALL_SKY_BOXSETS,
    PRE_CALL_HD_BASIC,
    PRE_CALL_HD_PREMIUM,
    POST_CALL_HD_BASIC,
    POST_CALL_HD_PREMIUM,
    Basic_Contract_Status_Level_2,
    Add_on_Products_Contract_Status_Level_2,
    Talk_Contract_Status_Level_2,
    BB_Contract_Status_Level_2,
    Overall_Contract_Status_Level_2,
    Basic_Contract_Status_Level_1,
    Add_on_Products_Contract_Status_Level_1,
    Talk_Contract_Status_Level_1,
    BB_Contract_Status_Level_1,
    Overall_Contract_Status_Level_1,
    TA_attempt_type,
    last_ta_date,
    Time_Since_Last_TA_Event,
    ta_call_event,
    turnaround_description,
    livechat_turnaround_event,
    livechat_turnaround_description,
    pre_call_LR,
    post_call_LR,
    LR_added,
    LR_removed,
    pre_call_ms_product_holding,
    pre_call_ms_count,
    post_call_ms_product_holding,
    post_call_ms_count,
    ms_count_added,
    ms_count_removed,
    MS_Product_Holding_Added,
    MS_Product_Holding_Removed,
    pre_call_talk_product_holding,
    post_call_talk_product_holding,
    Talk_Product_Holding_Added,
    Talk_Product_Holding_Removed,
    pre_call_chelsea_tv,
    post_call_chelsea_tv,
    pre_call_mutv,
    post_call_mutv,
    pre_call_liverpool,
    post_call_liverpool,
    pre_call_skyasia,
    post_call_skyasia,
    chelsea_tv_Added,
    chelsea_tv_Removed,
    mutv_Added,
    mutv_Removed,
    liverpool_Added,
    liverpool_Removed,
    skyasia_Added,
    skyasia_Removed,
    MS_ADDED_PRODUCT,
    MS_REMOVED_PRODUCT,
    TALK_ADDED_PRODUCT,
    TALK_REMOVED_PRODUCT,
    PRE_CALL_BASIC_DTV_PRODUCT_HOLDING,
    POSt_CALL_BASIC_DTV_PRODUCT_HOLDING,
    longest_time_in_nf_app,
    total_nf_app_launches,
    total_significant_nf_app_launches,
    total_time_in_nf_app,
    longest_time_in_spotify_app,
    total_spotify_app_launches,
    total_time_in_spotify_app,
    Basic_contract_status_pre_call,
    Talk_contract_status_pre_call,
    BB_contract_status_pre_call,
    Add_on_contract_status_pre_call,
    Overall_contract_status_pre_call,
    Basic_contract_status_post_call,
    Talk_contract_status_post_call,
    BB_contract_status_post_call,
    Add_on_contract_status_post_call,
    Overall_contract_status_post_call,
    pre_call_sports_complete,
    post_call_sports_complete,
    pre_call_ala_carte_product_holding,
    post_call_ala_carte_product_holding,
    pre_call_sky_go_extra,
    post_call_sky_go_extra,
    ta_in_last_seven_days,
    ta_in_last_one_month,
    ta_in_last_six_months,
    ta_in_last_one_year
    into #ECONOMETRICS_TA_CALLS_OFFERS_1
    from #ECONOMETRICS_TA_CALLS;
  select A.*,
    B.subscription_sub_type as OFFER_SUB_TYPE,
    B.OFFER_ID,
    B.OFFER_DIM_DESCRIPTION as OFFER_DESCRIPTION,
    B.Monthly_Offer_Amount as MONTHLY_OFFER_VALUE,
    DATEDIFF(month,B.Whole_Offer_Intended_Start_Dt,B.INTENDED_OFFER_END_DT) as OFFER_DURATION_MTH,
    DATEDIFF(month,B.Whole_Offer_Intended_Start_Dt,B.INTENDED_OFFER_END_DT)*B.Monthly_Offer_Amount as TOTAL_OFFER_VALUE,
    case when B.ORIG_PORTFOLIO_OFFER_ID <> '?' then 1 else 0 end as AUTO_TRANSFER_OFFER
    into #ECONOMETRICS_TA_CALLS_OFFERS_NEW
    from #ECONOMETRICS_TA_CALLS_OFFERS_1 as A
      left outer join Decisioning.Offers_Software as B
      on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and A.EVENT_DT <= B.Offer_leg_end_dt_Actual
      and((A.EVENT_DT = B.Whole_offer_created_dt and B.Offer_Leg = 1) or(A.EVENT_DT = B.Offer_Leg_CREATED_DT and B.Offer_Leg > 1))
      and lower(B.offer_dim_description) not like '%price protect%';
  delete from Decisioning.ECONOMETRICS_TA_CALLS_OFFERS
    where WEEK_START between PERIOD_START and PERIOD_END;
  insert into Decisioning.ECONOMETRICS_TA_CALLS_OFFERS
    select YEAR_WEEK,
      WEEK_START,
      COUNTRY,
      SAVED_FLAG,
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      SPORTS_ADDED,
      MOVIES_ADDED,
      LEGACY_SPORTS_SUB_ADDED,
      LEGACY_MOVIES_SUB_ADDED,
      SPORTS_PACK_SUB_ADDED,
      SPORTS_PACK_ADDED,
      LEGACY_SPORTS_SUB_REMOVED,
      LEGACY_MOVIES_SUB_REMOVED,
      SPORTS_PACK_SUB_REMOVED,
      SPORTS_PACK_REMOVED,
      BASIC_DTV_ADDED_PRODUCT,
      BASIC_DTV_REMOVED_PRODUCT,
      HD_LEGACY_ADDED,
      HD_BASIC_ADDED,
      HD_PREMIUM_ADDED,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      PRE_CALL_BB_ACTIVE,
      PRE_CALL_BB_PRODUCT_HOLDING,
      POST_CALL_BB_ACTIVE,
      POST_CALL_BB_PRODUCT_HOLDING,
      POST_CALL_DTV,
      TALK_ADDED_PRODUCT,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      HD_LEGACY_REMOVED,
      HD_BASIC_REMOVED,
      HD_PREMIUM_REMOVED,
      MS_REMOVED_PRODUCT,
      SKY_PLUS_REMOVED,
      SKY_GO_EXTRA_REMOVED,
      NOW_TV_REMOVED,
      TALK_REMOVED_PRODUCT,
      PRE_CALL_DTV,
      PRE_CALL_BASIC_DTV_PRODUCT_HOLDING,
      POST_CALL_BASIC_DTV_PRODUCT_HOLDING,
      PRE_CALL_TOP_TIER,
      PRE_CALL_TOTAL_PREMIUMS,
      PRE_CALL_TOTAL_SPORTS,
      PRE_CALL_TOTAL_MOVIES,
      POST_CALL_TOP_TIER,
      POST_CALL_TOTAL_PREMIUMS,
      POST_CALL_TOTAL_SPORTS,
      POST_CALL_TOTAL_MOVIES,
      ANY_OFFER_Active,
      ANY_OFFER_GIVEN,
      DTV_OFFER_Active,
      DTV_OFFER_GIVEN,
      POST_CALL_SKY_PLUS,
      OFFER_SUB_TYPE,
      OFFER_DESCRIPTION,
      MONTHLY_OFFER_VALUE,
      OFFER_DURATION_MTH,
      TOTAL_OFFER_VALUE,
      AUTO_TRANSFER_OFFER,
      TENURE,
      TV_REGION,
      SUM(NUMBER_CALLS) as NUMBER_OF_TA_EVENTS,
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
      CINEMA_ADDED,
      CINEMA_REMOVED,
      PRE_CALL_Sports_Active,
      POST_CALL_Sports_Active,
      PRE_CALL_Movies_Active,
      POST_CALL_Movies_Active,
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      BASIC_OFFER_END_STATUS_LEVEL_1,
      PREMIUM_OFFER_END_STATUS_LEVEL_1,
      Sports_OFFER_END_STATUS_LEVEL_1,
      Cinema_OFFER_END_STATUS_LEVEL_1,
      BB_OFFER_END_STATUS_LEVEL_1,
      LR_OFFER_END_STATUS_LEVEL_1,
      ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
      BASIC_OFFER_END_STATUS_LEVEL_2,
      PREMIUM_OFFER_END_STATUS_LEVEL_2,
      Sports_OFFER_END_STATUS_LEVEL_2,
      Cinema_OFFER_END_STATUS_LEVEL_2,
      BB_OFFER_END_STATUS_LEVEL_2,
      LR_OFFER_END_STATUS_LEVEL_2,
      ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
      pre_call_sports_product_holding,
      post_call_sports_product_holding,
      pre_call_movies_product_holding,
      post_call_movies_product_holding,
      ANY_NEW_OFFER_Active_Leg_1,
      NEW_DTV_OFFER_Active_leg_1,
      SKY_KIDS_ADDED,
      SKY_KIDS_REMOVED,
      SKY_BOXSETS_ADDED,
      SKY_BOXSETS_REMOVED,
      SPOTIFY_ADDED,
      SPOTIFY_REMOVED,
      UOD_ADDED,
      UOD_REMOVED,
      --pre_call_Netflix,
      --post_call_Netflix,
      Netflix_Added_Product,
      Netflix_Removed_Product,
      PRE_CALL_SKY_KIDS,
      PRE_CALL_SKY_BOXSETS,
      POST_CALL_SKY_KIDS,
      POST_CALL_SKY_BOXSETS,
      PRE_CALL_HD_BASIC,
      PRE_CALL_HD_PREMIUM,
      POST_CALL_HD_BASIC,
      POST_CALL_HD_PREMIUM,
      Basic_Contract_Status_Level_2,
      Add_on_Products_Contract_Status_Level_2,
      Talk_Contract_Status_Level_2,
      BB_Contract_Status_Level_2,
      Overall_Contract_Status_Level_2,
      Basic_Contract_Status_Level_1,
      Add_on_Products_Contract_Status_Level_1,
      Talk_Contract_Status_Level_1,
      BB_Contract_Status_Level_1,
      Overall_Contract_Status_Level_1,
      TA_attempt_type,
      last_ta_date,
      Time_Since_Last_TA_Event,
      ta_call_event,
      turnaround_description,
      livechat_turnaround_event,
      livechat_turnaround_description,
      pre_call_LR,
      post_call_LR,
      LR_added,
      LR_removed,
      pre_call_ms_product_holding,
      pre_call_ms_count,
      post_call_ms_product_holding,
      post_call_ms_count,
      ms_count_added,
      ms_count_removed,
      MS_Product_Holding_Added,
      MS_Product_Holding_Removed,
      pre_call_talk_product_holding,
      post_call_talk_product_holding,
      Talk_Product_Holding_Added,
      Talk_Product_Holding_Removed,
      pre_call_chelsea_tv,
      post_call_chelsea_tv,
      pre_call_mutv,
      post_call_mutv,
      pre_call_liverpool,
      post_call_liverpool,
      pre_call_skyasia,
      post_call_skyasia,
      chelsea_tv_Added,
      chelsea_tv_Removed,
      mutv_Added,
      mutv_Removed,
      liverpool_Added,
      liverpool_Removed,
      skyasia_Added,
      skyasia_Removed, /*
sum(longest_time_in_nf_app) longest_time_in_nf_app_a,
sum(total_nf_app_launches)total_nf_app_launches_a,
sum(total_time_in_nf_app)total_time_in_nf_app,
sum(case when total_nf_app_launches>0 then 1 else 0 end) Unique_accounts_viewing_nf,
((sum(longest_time_in_nf_app))/( CASE WHEN (sum(case when total_nf_app_launches>0 then 1 else 0 end))=0 then 1 else (sum(case when total_nf_app_launches>0 then 1 else 0 end)) end )) avg_longest_time_in_nf_app,

sum(longest_time_in_spotify_app) longest_time_in_spotify_app_a,
sum(total_spotify_app_launches)total_spotify_app_launches_a,
sum(total_time_in_spotify_app)total_time_in_spotify_app,
sum(case when total_spotify_app_launches>0 then 1 else 0 end) Unique_accounts_viewing_spotify,
((sum(longest_time_in_spotify_app))/( CASE WHEN (sum(case when total_spotify_app_launches>0 then 1 else 0 end))=0 then 1 else (sum(case when total_spotify_app_launches>0 then 1 else 0 end)) end )) avg_longest_time_in_spotify_app
*/
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
      Basic_contract_status_pre_call,
      Talk_contract_status_pre_call,
      BB_contract_status_pre_call,
      Add_on_contract_status_pre_call,
      Overall_contract_status_pre_call,
      Basic_contract_status_post_call,
      Talk_contract_status_post_call,
      BB_contract_status_post_call,
      Add_on_contract_status_post_call,
      Overall_contract_status_post_call,
      pre_call_sports_complete,
      post_call_sports_complete,
      pre_call_ala_carte_product_holding,
      post_call_ala_carte_product_holding,
      pre_call_sky_go_extra,
      post_call_sky_go_extra,
      ta_in_last_seven_days,
      ta_in_last_one_month,
      ta_in_last_six_months,
      ta_in_last_one_year
      from #ECONOMETRICS_TA_CALLS_OFFERS_NEW
      where OFFER_ID is not null
      group by YEAR_WEEK,
      WEEK_START,
      COUNTRY,
      SAVED_FLAG,
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      SPORTS_ADDED,
      MOVIES_ADDED,
      LEGACY_SPORTS_SUB_ADDED,
      LEGACY_MOVIES_SUB_ADDED,
      SPORTS_PACK_SUB_ADDED,
      SPORTS_PACK_ADDED,
      LEGACY_SPORTS_SUB_REMOVED,
      LEGACY_MOVIES_SUB_REMOVED,
      SPORTS_PACK_SUB_REMOVED,
      SPORTS_PACK_REMOVED,
      BASIC_DTV_ADDED_PRODUCT,
      BASIC_DTV_REMOVED_PRODUCT,
      HD_LEGACY_ADDED,
      HD_BASIC_ADDED,
      HD_PREMIUM_ADDED,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      PRE_CALL_BB_ACTIVE,
      PRE_CALL_BB_PRODUCT_HOLDING,
      POST_CALL_BB_ACTIVE,
      POST_CALL_BB_PRODUCT_HOLDING,
      POST_CALL_DTV,
      TALK_ADDED_PRODUCT,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      HD_LEGACY_REMOVED,
      HD_BASIC_REMOVED,
      HD_PREMIUM_REMOVED,
      MS_REMOVED_PRODUCT,
      SKY_PLUS_REMOVED,
      SKY_GO_EXTRA_REMOVED,
      NOW_TV_REMOVED,
      TALK_REMOVED_PRODUCT,
      PRE_CALL_DTV,
      PRE_CALL_BASIC_DTV_PRODUCT_HOLDING,
      POST_CALL_BASIC_DTV_PRODUCT_HOLDING,
      PRE_CALL_TOP_TIER,
      PRE_CALL_TOTAL_PREMIUMS,
      PRE_CALL_TOTAL_SPORTS,
      PRE_CALL_TOTAL_MOVIES,
      POST_CALL_TOP_TIER,
      POST_CALL_TOTAL_PREMIUMS,
      POST_CALL_TOTAL_SPORTS,
      POST_CALL_TOTAL_MOVIES,
      ANY_OFFER_Active,
      ANY_OFFER_GIVEN,
      DTV_OFFER_Active,
      DTV_OFFER_GIVEN,
      POST_CALL_SKY_PLUS,
      OFFER_SUB_TYPE,
      OFFER_DESCRIPTION,
      MONTHLY_OFFER_VALUE,
      OFFER_DURATION_MTH,
      TOTAL_OFFER_VALUE,
      AUTO_TRANSFER_OFFER,
      TENURE,
      TV_REGION,
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
      CINEMA_ADDED,
      CINEMA_REMOVED,
      PRE_CALL_Sports_Active,
      POST_CALL_Sports_Active,
      PRE_CALL_Movies_Active,
      POST_CALL_Movies_Active,
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      BASIC_OFFER_END_STATUS_LEVEL_1,
      PREMIUM_OFFER_END_STATUS_LEVEL_1,
      Sports_OFFER_END_STATUS_LEVEL_1,
      Cinema_OFFER_END_STATUS_LEVEL_1,
      BB_OFFER_END_STATUS_LEVEL_1,
      LR_OFFER_END_STATUS_LEVEL_1,
      ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
      BASIC_OFFER_END_STATUS_LEVEL_2,
      PREMIUM_OFFER_END_STATUS_LEVEL_2,
      Sports_OFFER_END_STATUS_LEVEL_2,
      Cinema_OFFER_END_STATUS_LEVEL_2,
      BB_OFFER_END_STATUS_LEVEL_2,
      LR_OFFER_END_STATUS_LEVEL_2,
      ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
      pre_call_sports_product_holding,
      post_call_sports_product_holding,
      pre_call_movies_product_holding,
      post_call_movies_product_holding,
      ANY_NEW_OFFER_Active_Leg_1,
      NEW_DTV_OFFER_Active_leg_1,
      SKY_KIDS_ADDED,
      SKY_KIDS_REMOVED,
      SKY_BOXSETS_ADDED,
      SKY_BOXSETS_REMOVED,
      SPOTIFY_ADDED,
      SPOTIFY_REMOVED,
      UOD_ADDED,
      UOD_REMOVED,
      --pre_call_Netflix,
      --post_call_Netflix,
      Netflix_Added_Product,
      Netflix_Removed_Product,
      PRE_CALL_SKY_KIDS,
      PRE_CALL_SKY_BOXSETS,
      POST_CALL_SKY_KIDS,
      POST_CALL_SKY_BOXSETS,
      PRE_CALL_HD_BASIC,
      PRE_CALL_HD_PREMIUM,
      POST_CALL_HD_BASIC,
      POST_CALL_HD_PREMIUM,
      Basic_Contract_Status_Level_2,
      Add_on_Products_Contract_Status_Level_2,
      Talk_Contract_Status_Level_2,
      BB_Contract_Status_Level_2,
      Overall_Contract_Status_Level_2,
      Basic_Contract_Status_Level_1,
      Add_on_Products_Contract_Status_Level_1,
      Talk_Contract_Status_Level_1,
      BB_Contract_Status_Level_1,
      Overall_Contract_Status_Level_1,
      TA_attempt_type,
      last_ta_date,
      Time_Since_Last_TA_Event,
      ta_call_event,
      turnaround_description,
      livechat_turnaround_event,
      livechat_turnaround_description,
      pre_call_LR,
      post_call_LR,
      LR_added,
      LR_removed,
      pre_call_ms_product_holding,
      pre_call_ms_count,
      post_call_ms_product_holding,
      post_call_ms_count,
      ms_count_added,
      ms_count_removed,
      MS_Product_Holding_Added,
      MS_Product_Holding_Removed,
      pre_call_talk_product_holding,
      post_call_talk_product_holding,
      Talk_Product_Holding_Added,
      Talk_Product_Holding_Removed,
      pre_call_chelsea_tv,
      post_call_chelsea_tv,
      pre_call_mutv,
      post_call_mutv,
      pre_call_liverpool,
      post_call_liverpool,
      pre_call_skyasia,
      post_call_skyasia,
      chelsea_tv_Added,
      chelsea_tv_Removed,
      mutv_Added,
      mutv_Removed,
      liverpool_Added,
      liverpool_Removed,
      skyasia_Added,
      skyasia_Removed,
      Basic_contract_status_pre_call,
      Talk_contract_status_pre_call,
      BB_contract_status_pre_call,
      Add_on_contract_status_pre_call,
      Overall_contract_status_pre_call,
      Basic_contract_status_post_call,
      Talk_contract_status_post_call,
      BB_contract_status_post_call,
      Add_on_contract_status_post_call,
      Overall_contract_status_post_call,
      pre_call_sports_complete,
      post_call_sports_complete,
      pre_call_ala_carte_product_holding,
      post_call_ala_carte_product_holding,
      pre_call_sky_go_extra,
      post_call_sky_go_extra,
      ta_in_last_seven_days,
      ta_in_last_one_month,
      ta_in_last_six_months,
      ta_in_last_one_year;
  select ACCOUNT_NUMBER,
    COUNTRY,
    EVENT_DT,
    ORDER_DT,
    NUMBER_CALLS,
    SAVED_FLAG,
    SPORTS_ADDED,
    MOVIES_ADDED,
    LEGACY_SPORTS_SUB_ADDED,
    LEGACY_MOVIES_SUB_ADDED,
    LEGACY_SPORTS_ADDED,
    LEGACY_MOVIES_ADDED,
    SPORTS_PACK_SUB_ADDED,
    SPORTS_PACK_ADDED,
    LEGACY_SPORTS_SUB_REMOVED,
    LEGACY_MOVIES_SUB_REMOVED,
    LEGACY_SPORTS_REMOVED,
    LEGACY_MOVIES_REMOVED,
    SPORTS_PACK_SUB_REMOVED,
    SPORTS_PACK_REMOVED,
    FAMILY_ADDED,
    VARIETY_ADDED,
    ORIGINAL_ADDED,
    SKYQ_LEGACY_ADDED,
    HD_LEGACY_ADDED,
    HD_BASIC_ADDED,
    HD_PREMIUM_ADDED,
    CLASSIC_MS_ADDED,
    SKYQ_MS_ADDED,
    SKY_PLUS_ADDED,
    SKY_GO_EXTRA_ADDED,
    NOW_TV_ADDED,
    BB_UNLIMITED_ADDED,
    BB_LITE_ADDED,
    BB_FIBRE_CAP_ADDED,
    BB_FIBRE_UNLIMITED_ADDED,
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
    SKYQ_LEGACY_REMOVED,
    HD_LEGACY_REMOVED,
    HD_BASIC_REMOVED,
    HD_PREMIUM_REMOVED,
    CLASSIC_MS_REMOVED,
    SKYQ_MS_REMOVED,
    SKY_PLUS_REMOVED,
    SKY_GO_EXTRA_REMOVED,
    NOW_TV_REMOVED,
    PRE_CALL_BB_ACTIVE,
    PRE_CALL_BB_PRODUCT_HOLDING,
    POST_CALL_BB_ACTIVE,
    POST_CALL_BB_PRODUCT_HOLDING,
    POST_CALL_DTV,
    BB_UNLIMITED_REMOVED,
    BB_LITE_REMOVED,
    BB_FIBRE_CAP_REMOVED,
    BB_FIBRE_UNLIMITED_REMOVED,
    TALKU_REMOVED,
    TALKW_REMOVED,
    TALKF_REMOVED,
    TALKA_REMOVED,
    TALKP_REMOVED,
    TALKO_REMOVED,
    PRE_CALL_DTV,
    PRE_CALL_ORIGINAL,
    PRE_CALL_VARIETY,
    PRE_CALL_FAMILY,
    PRE_CALL_SKYQ,
    PRE_CALL_TOP_TIER,
    PRE_CALL_TOTAL_PREMIUMS,
    PRE_CALL_TOTAL_SPORTS,
    PRE_CALL_TOTAL_MOVIES,
    POST_CALL_ORIGINAL,
    POST_CALL_VARIETY,
    POST_CALL_FAMILY,
    POST_CALL_SKYQ,
    POST_CALL_TOP_TIER,
    POST_CALL_TOTAL_PREMIUMS,
    POST_CALL_TOTAL_SPORTS,
    POST_CALL_TOTAL_MOVIES,
    ACTUAL_OFFER_STATUS,
    INTENDED_OFFER_STATUS,
    ANY_OFFER_Active,
    ANY_OFFER_GIVEN,
    DTV_OFFER_Active,
    DTV_OFFER_GIVEN,
    POST_CALL_SKY_PLUS,
    TENURE,
    SIMPLE_SEGMENT,
    TV_REGION,
    mosaic_uk_group,
    year_week,
    WEEK_START,
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
    CINEMA_ADDED,
    CINEMA_REMOVED,
    PRE_CALL_Prems_Active,
    Prems_Active as POST_CALL_Prems_Active,
    PRE_CALL_Sports_Active,
    Sports_Active as POST_CALL_Sports_Active,
    PRE_CALL_Movies_Active,
    Movies_Active as POST_CALL_Movies_Active,
    Offer_End_Status_Level_1,
    Offer_End_Status_Level_2,
    BASIC_OFFER_END_STATUS_LEVEL_1,
    PREMIUM_OFFER_END_STATUS_LEVEL_1,
    Sports_OFFER_END_STATUS_LEVEL_1,
    Cinema_OFFER_END_STATUS_LEVEL_1,
    BB_OFFER_END_STATUS_LEVEL_1,
    LR_OFFER_END_STATUS_LEVEL_1,
    ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    BASIC_OFFER_END_STATUS_LEVEL_2,
    PREMIUM_OFFER_END_STATUS_LEVEL_2,
    Sports_OFFER_END_STATUS_LEVEL_2,
    Cinema_OFFER_END_STATUS_LEVEL_2,
    BB_OFFER_END_STATUS_LEVEL_2,
    LR_OFFER_END_STATUS_LEVEL_2,
    ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    pre_call_sports_product_holding,
    post_call_sports_product_holding,
    pre_call_movies_product_holding,
    post_call_movies_product_holding,
    ANY_NEW_OFFER_Active_Leg_1,
    NEW_DTV_OFFER_Active_leg_1,
    SKY_KIDS_ADDED,
    SKY_KIDS_REMOVED,
    SKY_BOXSETS_ADDED,
    SKY_BOXSETS_REMOVED,
    SPOTIFY_ADDED,
    SPOTIFY_REMOVED,
    UOD_ADDED,
    UOD_REMOVED,
    --pre_call_Netflix,
    --post_call_Netflix,
    Netflix_Added_Product,
    Netflix_Removed_Product,
    SKY_ENT_ADDED,
    SKY_ENT_REMOVED,
    PRE_CALL_SKY_ENT,
    PRE_CALL_SKY_KIDS,
    PRE_CALL_SKY_BOXSETS,
    POST_CALL_SKY_ENT,
    POST_CALL_SKY_KIDS,
    POST_CALL_SKY_BOXSETS,
    PRE_CALL_HD_BASIC,
    PRE_CALL_HD_PREMIUM,
    POST_CALL_HD_BASIC,
    POST_CALL_HD_PREMIUM,
    Basic_Contract_Status_Level_2,
    Add_on_Products_Contract_Status_Level_2,
    Talk_Contract_Status_Level_2,
    BB_Contract_Status_Level_2,
    Overall_Contract_Status_Level_2,
    Basic_Contract_Status_Level_1,
    Add_on_Products_Contract_Status_Level_1,
    Talk_Contract_Status_Level_1,
    BB_Contract_Status_Level_1,
    Overall_Contract_Status_Level_1,
    TA_attempt_type,
    last_ta_date,
    Time_Since_Last_TA_Event,
    ta_call_event,
    turnaround_description,
    livechat_turnaround_event,
    livechat_turnaround_description,
    pre_call_LR,
    post_call_LR,
    LR_added,
    LR_removed,
    pre_call_ms_product_holding,
    pre_call_ms_count,
    post_call_ms_product_holding,
    post_call_ms_count,
    ms_count_added,
    ms_count_removed,
    MS_Product_Holding_Added,
    MS_Product_Holding_Removed,
    pre_call_talk_product_holding,
    post_call_talk_product_holding,
    Talk_Product_Holding_Added,
    Talk_Product_Holding_Removed,
    pre_call_chelsea_tv,
    post_call_chelsea_tv,
    pre_call_mutv,
    post_call_mutv,
    pre_call_liverpool,
    post_call_liverpool,
    pre_call_skyasia,
    post_call_skyasia,
    chelsea_tv_Added,
    chelsea_tv_Removed,
    mutv_Added,
    mutv_Removed,
    liverpool_Added,
    liverpool_Removed,
    skyasia_Added,
    skyasia_Removed,
    BASIC_DTV_ADDED_PRODUCT,
    BASIC_DTV_REMOVED_PRODUCT,
    MS_ADDED_PRODUCT,
    MS_REMOVED_PRODUCT,
    TALK_ADDED_PRODUCT,
    TALK_REMOVED_PRODUCT,
    PRE_CALL_BASIC_DTV_PRODUCT_HOLDING,
    POSt_CALL_BASIC_DTV_PRODUCT_HOLDING,
    longest_time_in_nf_app,
    total_nf_app_launches,
    total_significant_nf_app_launches,
    total_time_in_nf_app,
    longest_time_in_spotify_app,
    total_spotify_app_launches,
    total_time_in_spotify_app,
    Basic_contract_status_pre_call,
    Talk_contract_status_pre_call,
    BB_contract_status_pre_call,
    Add_on_contract_status_pre_call,
    Overall_contract_status_pre_call,
    Basic_contract_status_post_call,
    Talk_contract_status_post_call,
    BB_contract_status_post_call,
    Add_on_contract_status_post_call,
    Overall_contract_status_post_call,
    pre_call_sports_complete,
    post_call_sports_complete,
    pre_call_ala_carte_product_holding,
    post_call_ala_carte_product_holding,
    pre_call_sky_go_extra,
    post_call_sky_go_extra,
    ta_in_last_seven_days,
    ta_in_last_one_month,
    ta_in_last_six_months,
    ta_in_last_one_year
    into #ECONOMETRICS_TA_CALLS_OFFERS_2
    from #ECONOMETRICS_TA_CALLS;
  select A.*,
    B.subscription_sub_type as OFFER_SUB_TYPE,
    B.OFFER_ID,
    B.OFFER_DIM_DESCRIPTION as OFFER_DESCRIPTION,
    B.Monthly_Offer_Amount as MONTHLY_OFFER_VALUE,
    DATEDIFF(month,B.Whole_Offer_Intended_Start_Dt,B.INTENDED_OFFER_END_DT) as OFFER_DURATION_MTH,
    DATEDIFF(month,B.Whole_Offer_Intended_Start_Dt,B.INTENDED_OFFER_END_DT)*B.Monthly_Offer_Amount as TOTAL_OFFER_VALUE,
    case when B.ORIG_PORTFOLIO_OFFER_ID <> '?' then 1 else 0 end as AUTO_TRANSFER_OFFER
    into #ECONOMETRICS_TA_CALLS_OFFERS_ENDING_NEW
    from #ECONOMETRICS_TA_CALLS_OFFERS_2 as A
      left outer join Decisioning.Offers_Software as B
      on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and((B.WHOLE_OFFER_END_DT_ACTUAL <> A.EVENT_DT
      and B.WHOLE_OFFER_START_DT_ACTUAL < A.EVENT_DT
      and A.EVENT_DT-42 <= B.WHOLE_OFFER_END_DT_ACTUAL
      and A.EVENT_DT+42 >= B.WHOLE_OFFER_END_DT_ACTUAL)
      or(B.WHOLE_OFFER_END_DT_ACTUAL = A.EVENT_DT
      and B.WHOLE_OFFER_START_DT_ACTUAL < A.EVENT_DT
      and A.EVENT_DT-42 <= B.Intended_Offer_End_Dt
      and A.EVENT_DT+42 >= B.Intended_Offer_End_Dt))
      and B.WHOLE_OFFER_AMOUNT_ACTUAL < 0
      and lower(B.Offer_Dim_Description) not like '%price protect%'
    where OFFER_END_STATUS_LEVEL_1 = 'Offer Ending';
  delete from Decisioning.ECONOMETRICS_TA_CALLS_OFFERS_ENDING
    where WEEK_START between PERIOD_START and PERIOD_END;
  insert into Decisioning.ECONOMETRICS_TA_CALLS_OFFERS_ENDING
    select distinct
      YEAR_WEEK,
      WEEK_START,
      COUNTRY,
      SAVED_FLAG,
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      SPORTS_ADDED,
      MOVIES_ADDED,
      LEGACY_SPORTS_SUB_ADDED,
      LEGACY_MOVIES_SUB_ADDED,
      SPORTS_PACK_SUB_ADDED,
      SPORTS_PACK_ADDED,
      LEGACY_SPORTS_SUB_REMOVED,
      LEGACY_MOVIES_SUB_REMOVED,
      SPORTS_PACK_SUB_REMOVED,
      SPORTS_PACK_REMOVED,
      BASIC_DTV_ADDED_PRODUCT,
      BASIC_DTV_REMOVED_PRODUCT,
      HD_LEGACY_ADDED,
      HD_BASIC_ADDED,
      HD_PREMIUM_ADDED,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      PRE_CALL_BB_ACTIVE,
      PRE_CALL_BB_PRODUCT_HOLDING,
      POST_CALL_BB_ACTIVE,
      POST_CALL_BB_PRODUCT_HOLDING,
      POST_CALL_DTV,
      TALK_ADDED_PRODUCT,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      HD_LEGACY_REMOVED,
      HD_BASIC_REMOVED,
      HD_PREMIUM_REMOVED,
      MS_REMOVED_PRODUCT,
      SKY_PLUS_REMOVED,
      SKY_GO_EXTRA_REMOVED,
      NOW_TV_REMOVED,
      TALK_REMOVED_PRODUCT,
      PRE_CALL_DTV,
      PRE_CALL_BASIC_DTV_PRODUCT_HOLDING,
      POST_CALL_BASIC_DTV_PRODUCT_HOLDING,
      PRE_CALL_TOP_TIER,
      PRE_CALL_TOTAL_PREMIUMS,
      PRE_CALL_TOTAL_SPORTS,
      PRE_CALL_TOTAL_MOVIES,
      POST_CALL_TOP_TIER,
      POST_CALL_TOTAL_PREMIUMS,
      POST_CALL_TOTAL_SPORTS,
      POST_CALL_TOTAL_MOVIES,
      ANY_OFFER_Active,
      ANY_OFFER_GIVEN,
      DTV_OFFER_Active,
      DTV_OFFER_GIVEN,
      POST_CALL_SKY_PLUS,
      OFFER_SUB_TYPE,
      OFFER_DESCRIPTION,
      MONTHLY_OFFER_VALUE,
      OFFER_DURATION_MTH,
      TOTAL_OFFER_VALUE,
      AUTO_TRANSFER_OFFER,
      TENURE,
      TV_REGION,
      SUM(NUMBER_CALLS) as NUMBER_OF_TA_EVENTS,
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
      CINEMA_ADDED,
      CINEMA_REMOVED,
      PRE_CALL_Sports_Active,
      POST_CALL_Sports_Active,
      PRE_CALL_Movies_Active,
      POST_CALL_Movies_Active,
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      BASIC_OFFER_END_STATUS_LEVEL_1,
      PREMIUM_OFFER_END_STATUS_LEVEL_1,
      Sports_OFFER_END_STATUS_LEVEL_1,
      Cinema_OFFER_END_STATUS_LEVEL_1,
      BB_OFFER_END_STATUS_LEVEL_1,
      LR_OFFER_END_STATUS_LEVEL_1,
      ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
      BASIC_OFFER_END_STATUS_LEVEL_2,
      PREMIUM_OFFER_END_STATUS_LEVEL_2,
      Sports_OFFER_END_STATUS_LEVEL_2,
      Cinema_OFFER_END_STATUS_LEVEL_2,
      BB_OFFER_END_STATUS_LEVEL_2,
      LR_OFFER_END_STATUS_LEVEL_2,
      ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
      pre_call_sports_product_holding,
      post_call_sports_product_holding,
      pre_call_movies_product_holding,
      post_call_movies_product_holding,
      ANY_NEW_OFFER_Active_Leg_1,
      NEW_DTV_OFFER_Active_leg_1,
      SKY_KIDS_ADDED,
      SKY_KIDS_REMOVED,
      SKY_BOXSETS_ADDED,
      SKY_BOXSETS_REMOVED,
      SPOTIFY_ADDED,
      SPOTIFY_REMOVED,
      UOD_ADDED,
      UOD_REMOVED,
      -- pre_call_Netflix,
      --post_call_Netflix,
      Netflix_Added_Product,
      Netflix_Removed_Product,
      PRE_CALL_SKY_KIDS,
      PRE_CALL_SKY_BOXSETS,
      POST_CALL_SKY_KIDS,
      POST_CALL_SKY_BOXSETS,
      PRE_CALL_HD_BASIC,
      PRE_CALL_HD_PREMIUM,
      POST_CALL_HD_BASIC,
      POST_CALL_HD_PREMIUM,
      Basic_Contract_Status_Level_2,
      Add_on_Products_Contract_Status_Level_2,
      Talk_Contract_Status_Level_2,
      BB_Contract_Status_Level_2,
      Overall_Contract_Status_Level_2,
      Basic_Contract_Status_Level_1,
      Add_on_Products_Contract_Status_Level_1,
      Talk_Contract_Status_Level_1,
      BB_Contract_Status_Level_1,
      Overall_Contract_Status_Level_1,
      TA_attempt_type,
      last_ta_date,
      Time_Since_Last_TA_Event,
      ta_call_event,
      turnaround_description,
      livechat_turnaround_event,
      livechat_turnaround_description,
      pre_call_LR,
      post_call_LR,
      LR_added,
      LR_removed,
      pre_call_ms_product_holding,
      pre_call_ms_count,
      post_call_ms_product_holding,
      post_call_ms_count,
      ms_count_added,
      ms_count_removed,
      MS_Product_Holding_Added,
      MS_Product_Holding_Removed,
      pre_call_talk_product_holding,
      post_call_talk_product_holding,
      Talk_Product_Holding_Added,
      Talk_Product_Holding_Removed,
      pre_call_chelsea_tv,
      post_call_chelsea_tv,
      pre_call_mutv,
      post_call_mutv,
      pre_call_liverpool,
      post_call_liverpool,
      pre_call_skyasia,
      post_call_skyasia,
      chelsea_tv_Added,
      chelsea_tv_Removed,
      mutv_Added,
      mutv_Removed,
      liverpool_Added,
      liverpool_Removed,
      skyasia_Added,
      skyasia_Removed, /*
sum(longest_time_in_nf_app) longest_time_in_nf_app_a,
sum(total_nf_app_launches)total_nf_app_launches_a,
sum(total_time_in_nf_app)total_time_in_nf_app,
sum(case when total_nf_app_launches>0 then 1 else 0 end) Unique_accounts_viewing_nf,
((sum(longest_time_in_nf_app))/( CASE WHEN (sum(case when total_nf_app_launches>0 then 1 else 0 end))=0 then 1 else (sum(case when total_nf_app_launches>0 then 1 else 0 end)) end )) avg_longest_time_in_nf_app,

sum(longest_time_in_spotify_app) longest_time_in_spotify_app_a,
sum(total_spotify_app_launches)total_spotify_app_launches_a,
sum(total_time_in_spotify_app)total_time_in_spotify_app,
sum(case when total_spotify_app_launches>0 then 1 else 0 end) Unique_accounts_viewing_spotify,
((sum(longest_time_in_spotify_app))/( CASE WHEN (sum(case when total_spotify_app_launches>0 then 1 else 0 end))=0 then 1 else (sum(case when total_spotify_app_launches>0 then 1 else 0 end)) end )) avg_longest_time_in_spotify_app
*/
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
      Basic_contract_status_pre_call,
      Talk_contract_status_pre_call,
      BB_contract_status_pre_call,
      Add_on_contract_status_pre_call,
      Overall_contract_status_pre_call,
      Basic_contract_status_post_call,
      Talk_contract_status_post_call,
      BB_contract_status_post_call,
      Add_on_contract_status_post_call,
      Overall_contract_status_post_call,
      pre_call_sports_complete,
      post_call_sports_complete,
      pre_call_ala_carte_product_holding,
      post_call_ala_carte_product_holding,
      pre_call_sky_go_extra,
      post_call_sky_go_extra,
      ta_in_last_seven_days,
      ta_in_last_one_month,
      ta_in_last_six_months,
      ta_in_last_one_year
      from #ECONOMETRICS_TA_CALLS_OFFERS_ENDING_NEW
      where OFFER_ID is not null
      group by YEAR_WEEK,
      WEEK_START,
      COUNTRY,
      SAVED_FLAG,
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      SPORTS_ADDED,
      MOVIES_ADDED,
      LEGACY_SPORTS_SUB_ADDED,
      LEGACY_MOVIES_SUB_ADDED,
      SPORTS_PACK_SUB_ADDED,
      SPORTS_PACK_ADDED,
      LEGACY_SPORTS_SUB_REMOVED,
      LEGACY_MOVIES_SUB_REMOVED,
      SPORTS_PACK_SUB_REMOVED,
      SPORTS_PACK_REMOVED,
      BASIC_DTV_ADDED_PRODUCT,
      BASIC_DTV_REMOVED_PRODUCT,
      HD_LEGACY_ADDED,
      HD_BASIC_ADDED,
      HD_PREMIUM_ADDED,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      PRE_CALL_BB_ACTIVE,
      PRE_CALL_BB_PRODUCT_HOLDING,
      POST_CALL_BB_ACTIVE,
      POST_CALL_BB_PRODUCT_HOLDING,
      POST_CALL_DTV,
      TALK_ADDED_PRODUCT,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      HD_LEGACY_REMOVED,
      HD_BASIC_REMOVED,
      HD_PREMIUM_REMOVED,
      MS_REMOVED_PRODUCT,
      SKY_PLUS_REMOVED,
      SKY_GO_EXTRA_REMOVED,
      NOW_TV_REMOVED,
      TALK_REMOVED_PRODUCT,
      PRE_CALL_DTV,
      PRE_CALL_BASIC_DTV_PRODUCT_HOLDING,
      POST_CALL_BASIC_DTV_PRODUCT_HOLDING,
      PRE_CALL_TOP_TIER,
      PRE_CALL_TOTAL_PREMIUMS,
      PRE_CALL_TOTAL_SPORTS,
      PRE_CALL_TOTAL_MOVIES,
      POST_CALL_TOP_TIER,
      POST_CALL_TOTAL_PREMIUMS,
      POST_CALL_TOTAL_SPORTS,
      POST_CALL_TOTAL_MOVIES,
      ANY_OFFER_Active,
      ANY_OFFER_GIVEN,
      DTV_OFFER_Active,
      DTV_OFFER_GIVEN,
      POST_CALL_SKY_PLUS,
      OFFER_SUB_TYPE,
      OFFER_DESCRIPTION,
      MONTHLY_OFFER_VALUE,
      OFFER_DURATION_MTH,
      TOTAL_OFFER_VALUE,
      AUTO_TRANSFER_OFFER,
      TENURE,
      TV_REGION,
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
      CINEMA_ADDED,
      CINEMA_REMOVED,
      PRE_CALL_Sports_Active,
      POST_CALL_Sports_Active,
      PRE_CALL_Movies_Active,
      POST_CALL_Movies_Active,
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      BASIC_OFFER_END_STATUS_LEVEL_1,
      PREMIUM_OFFER_END_STATUS_LEVEL_1,
      Sports_OFFER_END_STATUS_LEVEL_1,
      Cinema_OFFER_END_STATUS_LEVEL_1,
      BB_OFFER_END_STATUS_LEVEL_1,
      LR_OFFER_END_STATUS_LEVEL_1,
      ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
      BASIC_OFFER_END_STATUS_LEVEL_2,
      PREMIUM_OFFER_END_STATUS_LEVEL_2,
      Sports_OFFER_END_STATUS_LEVEL_2,
      Cinema_OFFER_END_STATUS_LEVEL_2,
      BB_OFFER_END_STATUS_LEVEL_2,
      LR_OFFER_END_STATUS_LEVEL_2,
      ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
      pre_call_sports_product_holding,
      post_call_sports_product_holding,
      pre_call_movies_product_holding,
      post_call_movies_product_holding,
      ANY_NEW_OFFER_Active_Leg_1,
      NEW_DTV_OFFER_Active_leg_1,
      SKY_KIDS_ADDED,
      SKY_KIDS_REMOVED,
      SKY_BOXSETS_ADDED,
      SKY_BOXSETS_REMOVED,
      SPOTIFY_ADDED,
      SPOTIFY_REMOVED,
      UOD_ADDED,
      UOD_REMOVED,
      --pre_call_Netflix,
      --post_call_Netflix,
      Netflix_Added_Product,
      Netflix_Removed_Product,
      PRE_CALL_SKY_KIDS,
      PRE_CALL_SKY_BOXSETS,
      POST_CALL_SKY_KIDS,
      POST_CALL_SKY_BOXSETS,
      PRE_CALL_HD_BASIC,
      PRE_CALL_HD_PREMIUM,
      POST_CALL_HD_BASIC,
      POST_CALL_HD_PREMIUM,
      Basic_Contract_Status_Level_2,
      Add_on_Products_Contract_Status_Level_2,
      Talk_Contract_Status_Level_2,
      BB_Contract_Status_Level_2,
      Overall_Contract_Status_Level_2,
      Basic_Contract_Status_Level_1,
      Add_on_Products_Contract_Status_Level_1,
      Talk_Contract_Status_Level_1,
      BB_Contract_Status_Level_1,
      Overall_Contract_Status_Level_1,
      TA_attempt_type,
      last_ta_date,
      Time_Since_Last_TA_Event,
      ta_call_event,
      turnaround_description,
      livechat_turnaround_event,
      livechat_turnaround_description,
      pre_call_LR,
      post_call_LR,
      LR_added,
      LR_removed,
      pre_call_ms_product_holding,
      pre_call_ms_count,
      post_call_ms_product_holding,
      post_call_ms_count,
      ms_count_added,
      ms_count_removed,
      MS_Product_Holding_Added,
      MS_Product_Holding_Removed,
      pre_call_talk_product_holding,
      post_call_talk_product_holding,
      Talk_Product_Holding_Added,
      Talk_Product_Holding_Removed,
      pre_call_chelsea_tv,
      post_call_chelsea_tv,
      pre_call_mutv,
      post_call_mutv,
      pre_call_liverpool,
      post_call_liverpool,
      pre_call_skyasia,
      post_call_skyasia,
      chelsea_tv_Added,
      chelsea_tv_Removed,
      mutv_Added,
      mutv_Removed,
      liverpool_Added,
      liverpool_Removed,
      skyasia_Added,
      skyasia_Removed,
      Basic_contract_status_pre_call,
      Talk_contract_status_pre_call,
      BB_contract_status_pre_call,
      Add_on_contract_status_pre_call,
      Overall_contract_status_pre_call,
      Basic_contract_status_post_call,
      Talk_contract_status_post_call,
      BB_contract_status_post_call,
      Add_on_contract_status_post_call,
      Overall_contract_status_post_call,
      pre_call_sports_complete,
      post_call_sports_complete,
      pre_call_ala_carte_product_holding,
      post_call_ala_carte_product_holding,
      pre_call_sky_go_extra,
      post_call_sky_go_extra,
      ta_in_last_seven_days,
      ta_in_last_one_month,
      ta_in_last_six_months,
      ta_in_last_one_year;
  select ACCOUNT_NUMBER,
    COUNTRY,
    EVENT_DT,
    ORDER_DT,
    NUMBER_CALLS,
    SAVED_FLAG,
    SPORTS_ADDED,
    MOVIES_ADDED,
    LEGACY_SPORTS_SUB_ADDED,
    LEGACY_MOVIES_SUB_ADDED,
    LEGACY_SPORTS_ADDED,
    LEGACY_MOVIES_ADDED,
    SPORTS_PACK_SUB_ADDED,
    SPORTS_PACK_ADDED,
    LEGACY_SPORTS_SUB_REMOVED,
    LEGACY_MOVIES_SUB_REMOVED,
    LEGACY_SPORTS_REMOVED,
    LEGACY_MOVIES_REMOVED,
    SPORTS_PACK_SUB_REMOVED,
    SPORTS_PACK_REMOVED,
    FAMILY_ADDED,
    VARIETY_ADDED,
    ORIGINAL_ADDED,
    SKYQ_LEGACY_ADDED,
    HD_LEGACY_ADDED,
    HD_BASIC_ADDED,
    HD_PREMIUM_ADDED,
    CLASSIC_MS_ADDED,
    SKYQ_MS_ADDED,
    SKY_PLUS_ADDED,
    SKY_GO_EXTRA_ADDED,
    NOW_TV_ADDED,
    PRE_CALL_BB_ACTIVE,
    PRE_CALL_BB_PRODUCT_HOLDING,
    POST_CALL_BB_ACTIVE,
    POST_CALL_BB_PRODUCT_HOLDING,
    POST_CALL_DTV,
    BB_UNLIMITED_ADDED,
    BB_LITE_ADDED,
    BB_FIBRE_CAP_ADDED,
    BB_FIBRE_UNLIMITED_ADDED,
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
    SKYQ_LEGACY_REMOVED,
    HD_LEGACY_REMOVED,
    HD_BASIC_REMOVED,
    HD_PREMIUM_REMOVED,
    CLASSIC_MS_REMOVED,
    SKYQ_MS_REMOVED,
    SKY_PLUS_REMOVED,
    SKY_GO_EXTRA_REMOVED,
    NOW_TV_REMOVED,
    BB_UNLIMITED_REMOVED,
    BB_LITE_REMOVED,
    BB_FIBRE_CAP_REMOVED,
    BB_FIBRE_UNLIMITED_REMOVED,
    TALKU_REMOVED,
    TALKW_REMOVED,
    TALKF_REMOVED,
    TALKA_REMOVED,
    TALKP_REMOVED,
    TALKO_REMOVED,
    PRE_CALL_DTV,
    PRE_CALL_ORIGINAL,
    PRE_CALL_VARIETY,
    PRE_CALL_FAMILY,
    PRE_CALL_SKYQ,
    PRE_CALL_TOP_TIER,
    PRE_CALL_TOTAL_PREMIUMS,
    PRE_CALL_TOTAL_SPORTS,
    PRE_CALL_TOTAL_MOVIES,
    POST_CALL_ORIGINAL,
    POST_CALL_VARIETY,
    POST_CALL_FAMILY,
    POST_CALL_SKYQ,
    POST_CALL_TOP_TIER,
    POST_CALL_TOTAL_PREMIUMS,
    POST_CALL_TOTAL_SPORTS,
    POST_CALL_TOTAL_MOVIES,
    ACTUAL_OFFER_STATUS,
    INTENDED_OFFER_STATUS,
    ANY_OFFER_Active,
    ANY_OFFER_GIVEN,
    DTV_OFFER_Active,
    DTV_OFFER_GIVEN,
    POST_CALL_SKY_PLUS,
    TENURE,
    SIMPLE_SEGMENT,
    TV_REGION,
    mosaic_uk_group,
    year_week,
    WEEK_START,
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
    CINEMA_ADDED,
    CINEMA_REMOVED,
    PRE_CALL_Prems_Active,
    Prems_Active as POST_CALL_Prems_Active,
    PRE_CALL_Sports_Active,
    Sports_Active as POST_CALL_Sports_Active,
    PRE_CALL_Movies_Active,
    Movies_Active as POST_CALL_Movies_Active,
    Offer_End_Status_Level_1,
    Offer_End_Status_Level_2,
    BASIC_OFFER_END_STATUS_LEVEL_1,
    PREMIUM_OFFER_END_STATUS_LEVEL_1,
    Sports_OFFER_END_STATUS_LEVEL_1,
    Cinema_OFFER_END_STATUS_LEVEL_1,
    BB_OFFER_END_STATUS_LEVEL_1,
    LR_OFFER_END_STATUS_LEVEL_1,
    ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
    BASIC_OFFER_END_STATUS_LEVEL_2,
    PREMIUM_OFFER_END_STATUS_LEVEL_2,
    Sports_OFFER_END_STATUS_LEVEL_2,
    Cinema_OFFER_END_STATUS_LEVEL_2,
    BB_OFFER_END_STATUS_LEVEL_2,
    LR_OFFER_END_STATUS_LEVEL_2,
    ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
    pre_call_sports_product_holding,
    post_call_sports_product_holding,
    pre_call_movies_product_holding,
    post_call_movies_product_holding,
    ANY_NEW_OFFER_Active_Leg_1,
    NEW_DTV_OFFER_Active_leg_1,
    SKY_KIDS_ADDED,
    SKY_KIDS_REMOVED,
    SKY_BOXSETS_ADDED,
    SKY_BOXSETS_REMOVED,
    SPOTIFY_ADDED,
    SPOTIFY_REMOVED,
    UOD_ADDED,
    UOD_REMOVED,
    --pre_call_Netflix,
    --post_call_Netflix,
    Netflix_Added_Product,
    Netflix_Removed_Product,
    SKY_ENT_ADDED,
    SKY_ENT_REMOVED,
    PRE_CALL_SKY_ENT,
    PRE_CALL_SKY_KIDS,
    PRE_CALL_SKY_BOXSETS,
    POST_CALL_SKY_ENT,
    POST_CALL_SKY_KIDS,
    POST_CALL_SKY_BOXSETS,
    PRE_CALL_HD_BASIC,
    PRE_CALL_HD_PREMIUM,
    POST_CALL_HD_BASIC,
    POST_CALL_HD_PREMIUM,
    Basic_Contract_Status_Level_2,
    Add_on_Products_Contract_Status_Level_2,
    Talk_Contract_Status_Level_2,
    BB_Contract_Status_Level_2,
    Overall_Contract_Status_Level_2,
    Basic_Contract_Status_Level_1,
    Add_on_Products_Contract_Status_Level_1,
    Talk_Contract_Status_Level_1,
    BB_Contract_Status_Level_1,
    Overall_Contract_Status_Level_1,
    TA_attempt_type,
    last_ta_date,
    Time_Since_Last_TA_Event,
    ta_call_event,
    turnaround_description,
    livechat_turnaround_event,
    livechat_turnaround_description,
    pre_call_LR,
    post_call_LR,
    LR_added,
    LR_removed,
    pre_call_ms_product_holding,
    pre_call_ms_count,
    post_call_ms_product_holding,
    post_call_ms_count,
    ms_count_added,
    ms_count_removed,
    MS_Product_Holding_Added,
    MS_Product_Holding_Removed,
    pre_call_talk_product_holding,
    post_call_talk_product_holding,
    Talk_Product_Holding_Added,
    Talk_Product_Holding_Removed,
    pre_call_chelsea_tv,
    post_call_chelsea_tv,
    pre_call_mutv,
    post_call_mutv,
    pre_call_liverpool,
    post_call_liverpool,
    pre_call_skyasia,
    post_call_skyasia,
    chelsea_tv_Added,
    chelsea_tv_Removed,
    mutv_Added,
    mutv_Removed,
    liverpool_Added,
    liverpool_Removed,
    skyasia_Added,
    skyasia_Removed,
    BASIC_DTV_ADDED_PRODUCT,
    BASIC_DTV_REMOVED_PRODUCT,
    MS_ADDED_PRODUCT,
    MS_REMOVED_PRODUCT,
    TALK_ADDED_PRODUCT,
    TALK_REMOVED_PRODUCT,
    PRE_CALL_BASIC_DTV_PRODUCT_HOLDING,
    POSt_CALL_BASIC_DTV_PRODUCT_HOLDING,
    longest_time_in_nf_app,
    total_nf_app_launches,
    total_significant_nf_app_launches,
    total_time_in_nf_app,
    longest_time_in_spotify_app,
    total_spotify_app_launches,
    total_time_in_spotify_app,
    Basic_contract_status_pre_call,
    Talk_contract_status_pre_call,
    BB_contract_status_pre_call,
    Add_on_contract_status_pre_call,
    Overall_contract_status_pre_call,
    Basic_contract_status_post_call,
    Talk_contract_status_post_call,
    BB_contract_status_post_call,
    Add_on_contract_status_post_call,
    Overall_contract_status_post_call,
    pre_call_sports_complete,
    post_call_sports_complete,
    pre_call_ala_carte_product_holding,
    post_call_ala_carte_product_holding,
    pre_call_sky_go_extra,
    post_call_sky_go_extra,
    ta_in_last_seven_days,
    ta_in_last_one_month,
    ta_in_last_six_months,
    ta_in_last_one_year
    into #ECONOMETRICS_TA_CALLS_OFFERS_3
    from #ECONOMETRICS_TA_CALLS;
  select A.*,
    B.subscription_sub_type as OFFER_SUB_TYPE,
    B.OFFER_ID,
    B.OFFER_DIM_DESCRIPTION as OFFER_DESCRIPTION,
    B.Monthly_Offer_Amount as MONTHLY_OFFER_VALUE,
    DATEDIFF(month,B.Whole_Offer_Intended_Start_Dt,B.INTENDED_OFFER_END_DT) as OFFER_DURATION_MTH,
    DATEDIFF(month,B.Whole_Offer_Intended_Start_Dt,B.INTENDED_OFFER_END_DT)*B.Monthly_Offer_Amount as TOTAL_OFFER_VALUE,
    case when B.ORIG_PORTFOLIO_OFFER_ID <> '?' then 1 else 0 end as AUTO_TRANSFER_OFFER
    into #ECONOMETRICS_TA_CALLS_OFFERS_ACTIVE_NEW
    from #ECONOMETRICS_TA_CALLS_OFFERS_3 as A
      left outer join Decisioning.Offers_Software as B
      on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and B.WHOLE_OFFER_END_DT_ACTUAL > (A.EVENT_DT-1)
      and B.WHOLE_OFFER_START_DT_ACTUAL < A.EVENT_DT
      and B.WHOLE_OFFER_AMOUNT_ACTUAL < 0
      and lower(B.Offer_Dim_Description) not like '%price protect%';
  delete from Decisioning.ECONOMETRICS_TA_CALLS_OFFERS_ACTIVE
    where WEEK_START between PERIOD_START and PERIOD_END;
  insert into Decisioning.ECONOMETRICS_TA_CALLS_OFFERS_ACTIVE
    select distinct
      YEAR_WEEK,
      WEEK_START,
      COUNTRY,
      SAVED_FLAG,
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      SPORTS_ADDED,
      MOVIES_ADDED,
      LEGACY_SPORTS_SUB_ADDED,
      LEGACY_MOVIES_SUB_ADDED,
      SPORTS_PACK_SUB_ADDED,
      SPORTS_PACK_ADDED,
      LEGACY_SPORTS_SUB_REMOVED,
      LEGACY_MOVIES_SUB_REMOVED,
      SPORTS_PACK_SUB_REMOVED,
      SPORTS_PACK_REMOVED,
      BASIC_DTV_ADDED_PRODUCT,
      BASIC_DTV_REMOVED_PRODUCT,
      HD_LEGACY_ADDED,
      HD_BASIC_ADDED,
      HD_PREMIUM_ADDED,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      PRE_CALL_BB_ACTIVE,
      PRE_CALL_BB_PRODUCT_HOLDING,
      POST_CALL_BB_ACTIVE,
      POST_CALL_BB_PRODUCT_HOLDING,
      POST_CALL_DTV,
      TALK_ADDED_PRODUCT,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      HD_LEGACY_REMOVED,
      HD_BASIC_REMOVED,
      HD_PREMIUM_REMOVED,
      MS_REMOVED_PRODUCT,
      SKY_PLUS_REMOVED,
      SKY_GO_EXTRA_REMOVED,
      NOW_TV_REMOVED,
      TALK_REMOVED_PRODUCT,
      PRE_CALL_DTV,
      PRE_CALL_BASIC_DTV_PRODUCT_HOLDING,
      POST_CALL_BASIC_DTV_PRODUCT_HOLDING,
      PRE_CALL_TOP_TIER,
      PRE_CALL_TOTAL_PREMIUMS,
      PRE_CALL_TOTAL_SPORTS,
      PRE_CALL_TOTAL_MOVIES,
      POST_CALL_TOP_TIER,
      POST_CALL_TOTAL_PREMIUMS,
      POST_CALL_TOTAL_SPORTS,
      POST_CALL_TOTAL_MOVIES,
      ANY_OFFER_Active,
      ANY_OFFER_GIVEN,
      DTV_OFFER_Active,
      DTV_OFFER_GIVEN,
      POST_CALL_SKY_PLUS,
      OFFER_SUB_TYPE,
      OFFER_DESCRIPTION,
      MONTHLY_OFFER_VALUE,
      OFFER_DURATION_MTH,
      TOTAL_OFFER_VALUE,
      AUTO_TRANSFER_OFFER,
      TENURE,
      TV_REGION,
      SUM(NUMBER_CALLS) as NUMBER_OF_TA_EVENTS,
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
      CINEMA_ADDED,
      CINEMA_REMOVED,
      PRE_CALL_Sports_Active,
      POST_CALL_Sports_Active,
      PRE_CALL_Movies_Active,
      POST_CALL_Movies_Active,
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      BASIC_OFFER_END_STATUS_LEVEL_1,
      PREMIUM_OFFER_END_STATUS_LEVEL_1,
      Sports_OFFER_END_STATUS_LEVEL_1,
      Cinema_OFFER_END_STATUS_LEVEL_1,
      BB_OFFER_END_STATUS_LEVEL_1,
      LR_OFFER_END_STATUS_LEVEL_1,
      ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
      BASIC_OFFER_END_STATUS_LEVEL_2,
      PREMIUM_OFFER_END_STATUS_LEVEL_2,
      Sports_OFFER_END_STATUS_LEVEL_2,
      Cinema_OFFER_END_STATUS_LEVEL_2,
      BB_OFFER_END_STATUS_LEVEL_2,
      LR_OFFER_END_STATUS_LEVEL_2,
      ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
      pre_call_sports_product_holding,
      post_call_sports_product_holding,
      pre_call_movies_product_holding,
      post_call_movies_product_holding,
      ANY_NEW_OFFER_Active_Leg_1,
      NEW_DTV_OFFER_Active_leg_1,
      SKY_KIDS_ADDED,
      SKY_KIDS_REMOVED,
      SKY_BOXSETS_ADDED,
      SKY_BOXSETS_REMOVED,
      SPOTIFY_ADDED,
      SPOTIFY_REMOVED,
      UOD_ADDED,
      UOD_REMOVED,
      -- pre_call_Netflix,
      --post_call_Netflix,
      Netflix_Added_Product,
      Netflix_Removed_Product,
      PRE_CALL_SKY_KIDS,
      PRE_CALL_SKY_BOXSETS,
      POST_CALL_SKY_KIDS,
      POST_CALL_SKY_BOXSETS,
      PRE_CALL_HD_BASIC,
      PRE_CALL_HD_PREMIUM,
      POST_CALL_HD_BASIC,
      POST_CALL_HD_PREMIUM,
      Basic_Contract_Status_Level_2,
      Add_on_Products_Contract_Status_Level_2,
      Talk_Contract_Status_Level_2,
      BB_Contract_Status_Level_2,
      Overall_Contract_Status_Level_2,
      Basic_Contract_Status_Level_1,
      Add_on_Products_Contract_Status_Level_1,
      Talk_Contract_Status_Level_1,
      BB_Contract_Status_Level_1,
      Overall_Contract_Status_Level_1,
      TA_attempt_type,
      last_ta_date,
      Time_Since_Last_TA_Event,
      ta_call_event,
      turnaround_description,
      livechat_turnaround_event,
      livechat_turnaround_description,
      pre_call_LR,
      post_call_LR,
      LR_added,
      LR_removed,
      pre_call_ms_product_holding,
      pre_call_ms_count,
      post_call_ms_product_holding,
      post_call_ms_count,
      ms_count_added,
      ms_count_removed,
      MS_Product_Holding_Added,
      MS_Product_Holding_Removed,
      pre_call_talk_product_holding,
      post_call_talk_product_holding,
      Talk_Product_Holding_Added,
      Talk_Product_Holding_Removed,
      pre_call_chelsea_tv,
      post_call_chelsea_tv,
      pre_call_mutv,
      post_call_mutv,
      pre_call_liverpool,
      post_call_liverpool,
      pre_call_skyasia,
      post_call_skyasia,
      chelsea_tv_Added,
      chelsea_tv_Removed,
      mutv_Added,
      mutv_Removed,
      liverpool_Added,
      liverpool_Removed,
      skyasia_Added,
      skyasia_Removed, /*
sum(longest_time_in_nf_app) longest_time_in_nf_app_a,
sum(total_nf_app_launches)total_nf_app_launches_a,
sum(total_time_in_nf_app)total_time_in_nf_app,
sum(case when total_nf_app_launches>0 then 1 else 0 end) Unique_accounts_viewing_nf,
((sum(longest_time_in_nf_app))/( CASE WHEN (sum(case when total_nf_app_launches>0 then 1 else 0 end))=0 then 1 else (sum(case when total_nf_app_launches>0 then 1 else 0 end)) end )) avg_longest_time_in_nf_app,

sum(longest_time_in_spotify_app) longest_time_in_spotify_app_a,
sum(total_spotify_app_launches)total_spotify_app_launches_a,
sum(total_time_in_spotify_app)total_time_in_spotify_app,
sum(case when total_spotify_app_launches>0 then 1 else 0 end) Unique_accounts_viewing_spotify,
((sum(longest_time_in_spotify_app))/( CASE WHEN (sum(case when total_spotify_app_launches>0 then 1 else 0 end))=0 then 1 else (sum(case when total_spotify_app_launches>0 then 1 else 0 end)) end )) avg_longest_time_in_spotify_app
*/
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
      Basic_contract_status_pre_call,
      Talk_contract_status_pre_call,
      BB_contract_status_pre_call,
      Add_on_contract_status_pre_call,
      Overall_contract_status_pre_call,
      Basic_contract_status_post_call,
      Talk_contract_status_post_call,
      BB_contract_status_post_call,
      Add_on_contract_status_post_call,
      Overall_contract_status_post_call,
      pre_call_sports_complete,
      post_call_sports_complete,
      pre_call_ala_carte_product_holding,
      post_call_ala_carte_product_holding,
      pre_call_sky_go_extra,
      post_call_sky_go_extra,
      ta_in_last_seven_days,
      ta_in_last_one_month,
      ta_in_last_six_months,
      ta_in_last_one_year
      from #ECONOMETRICS_TA_CALLS_OFFERS_ACTIVE_NEW
      where OFFER_ID is not null
      group by YEAR_WEEK,
      WEEK_START,
      COUNTRY,
      SAVED_FLAG,
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      SPORTS_ADDED,
      MOVIES_ADDED,
      LEGACY_SPORTS_SUB_ADDED,
      LEGACY_MOVIES_SUB_ADDED,
      SPORTS_PACK_SUB_ADDED,
      SPORTS_PACK_ADDED,
      LEGACY_SPORTS_SUB_REMOVED,
      LEGACY_MOVIES_SUB_REMOVED,
      SPORTS_PACK_SUB_REMOVED,
      SPORTS_PACK_REMOVED,
      BASIC_DTV_ADDED_PRODUCT,
      BASIC_DTV_REMOVED_PRODUCT,
      HD_LEGACY_ADDED,
      HD_BASIC_ADDED,
      HD_PREMIUM_ADDED,
      MS_ADDED_PRODUCT,
      SKY_PLUS_ADDED,
      SKY_GO_EXTRA_ADDED,
      NOW_TV_ADDED,
      PRE_CALL_BB_ACTIVE,
      PRE_CALL_BB_PRODUCT_HOLDING,
      POST_CALL_BB_ACTIVE,
      POST_CALL_BB_PRODUCT_HOLDING,
      POST_CALL_DTV,
      TALK_ADDED_PRODUCT,
      SPORTS_REMOVED,
      MOVIES_REMOVED,
      HD_LEGACY_REMOVED,
      HD_BASIC_REMOVED,
      HD_PREMIUM_REMOVED,
      MS_REMOVED_PRODUCT,
      SKY_PLUS_REMOVED,
      SKY_GO_EXTRA_REMOVED,
      NOW_TV_REMOVED,
      TALK_REMOVED_PRODUCT,
      PRE_CALL_DTV,
      PRE_CALL_BASIC_DTV_PRODUCT_HOLDING,
      POST_CALL_BASIC_DTV_PRODUCT_HOLDING,
      PRE_CALL_TOP_TIER,
      PRE_CALL_TOTAL_PREMIUMS,
      PRE_CALL_TOTAL_SPORTS,
      PRE_CALL_TOTAL_MOVIES,
      POST_CALL_TOP_TIER,
      POST_CALL_TOTAL_PREMIUMS,
      POST_CALL_TOTAL_SPORTS,
      POST_CALL_TOTAL_MOVIES,
      ANY_OFFER_Active,
      ANY_OFFER_GIVEN,
      DTV_OFFER_Active,
      DTV_OFFER_GIVEN,
      POST_CALL_SKY_PLUS,
      OFFER_SUB_TYPE,
      OFFER_DESCRIPTION,
      MONTHLY_OFFER_VALUE,
      OFFER_DURATION_MTH,
      TOTAL_OFFER_VALUE,
      AUTO_TRANSFER_OFFER,
      TENURE,
      TV_REGION,
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
      CINEMA_ADDED,
      CINEMA_REMOVED,
      PRE_CALL_Sports_Active,
      POST_CALL_Sports_Active,
      PRE_CALL_Movies_Active,
      POST_CALL_Movies_Active,
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      BASIC_OFFER_END_STATUS_LEVEL_1,
      PREMIUM_OFFER_END_STATUS_LEVEL_1,
      Sports_OFFER_END_STATUS_LEVEL_1,
      Cinema_OFFER_END_STATUS_LEVEL_1,
      BB_OFFER_END_STATUS_LEVEL_1,
      LR_OFFER_END_STATUS_LEVEL_1,
      ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1,
      BASIC_OFFER_END_STATUS_LEVEL_2,
      PREMIUM_OFFER_END_STATUS_LEVEL_2,
      Sports_OFFER_END_STATUS_LEVEL_2,
      Cinema_OFFER_END_STATUS_LEVEL_2,
      BB_OFFER_END_STATUS_LEVEL_2,
      LR_OFFER_END_STATUS_LEVEL_2,
      ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2,
      pre_call_sports_product_holding,
      post_call_sports_product_holding,
      pre_call_movies_product_holding,
      post_call_movies_product_holding,
      ANY_NEW_OFFER_Active_Leg_1,
      NEW_DTV_OFFER_Active_leg_1,
      SKY_KIDS_ADDED,
      SKY_KIDS_REMOVED,
      SKY_BOXSETS_ADDED,
      SKY_BOXSETS_REMOVED,
      SPOTIFY_ADDED,
      SPOTIFY_REMOVED,
      UOD_ADDED,
      UOD_REMOVED,
      --\x09pre_call_Netflix,
      --post_call_Netflix,
      Netflix_Added_Product,
      Netflix_Removed_Product,
      PRE_CALL_SKY_KIDS,
      PRE_CALL_SKY_BOXSETS,
      POST_CALL_SKY_KIDS,
      POST_CALL_SKY_BOXSETS,
      PRE_CALL_HD_BASIC,
      PRE_CALL_HD_PREMIUM,
      POST_CALL_HD_BASIC,
      POST_CALL_HD_PREMIUM,
      Basic_Contract_Status_Level_2,
      Add_on_Products_Contract_Status_Level_2,
      Talk_Contract_Status_Level_2,
      BB_Contract_Status_Level_2,
      Overall_Contract_Status_Level_2,
      Basic_Contract_Status_Level_1,
      Add_on_Products_Contract_Status_Level_1,
      Talk_Contract_Status_Level_1,
      BB_Contract_Status_Level_1,
      Overall_Contract_Status_Level_1,
      TA_attempt_type,
      last_ta_date,
      Time_Since_Last_TA_Event,
      ta_call_event,
      turnaround_description,
      livechat_turnaround_event,
      livechat_turnaround_description,
      pre_call_LR,
      post_call_LR,
      LR_added,
      LR_removed,
      pre_call_ms_product_holding,
      pre_call_ms_count,
      post_call_ms_product_holding,
      post_call_ms_count,
      ms_count_added,
      ms_count_removed,
      MS_Product_Holding_Added,
      MS_Product_Holding_Removed,
      pre_call_talk_product_holding,
      post_call_talk_product_holding,
      Talk_Product_Holding_Added,
      Talk_Product_Holding_Removed,
      pre_call_chelsea_tv,
      post_call_chelsea_tv,
      pre_call_mutv,
      post_call_mutv,
      pre_call_liverpool,
      post_call_liverpool,
      pre_call_skyasia,
      post_call_skyasia,
      chelsea_tv_Added,
      chelsea_tv_Removed,
      mutv_Added,
      mutv_Removed,
      liverpool_Added,
      liverpool_Removed,
      skyasia_Added,
      skyasia_Removed,
      Basic_contract_status_pre_call,
      Talk_contract_status_pre_call,
      BB_contract_status_pre_call,
      Add_on_contract_status_pre_call,
      Overall_contract_status_pre_call,
      Basic_contract_status_post_call,
      Talk_contract_status_post_call,
      BB_contract_status_post_call,
      Add_on_contract_status_post_call,
      Overall_contract_status_post_call,
      pre_call_sports_complete,
      post_call_sports_complete,
      pre_call_ala_carte_product_holding,
      post_call_ala_carte_product_holding,
      pre_call_sky_go_extra,
      post_call_sky_go_extra,
      ta_in_last_seven_days,
      ta_in_last_one_month,
      ta_in_last_six_months,
      ta_in_last_one_year
end

GO
GRANT EXECUTE ON Decisioning_Procs.Update_Econometrics_TA_Events TO public;


/*
call Decisioning_Procs.Update_Econometrics_TA_Events();

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'ECONOMETRICS_TA_CALLS');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'ECONOMETRICS_TA_CALLS',  'select * from Decisioning.ECONOMETRICS_TA_CALLS');

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'ECONOMETRICS_TA_CALLS_OFFERS');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'ECONOMETRICS_TA_CALLS_OFFERS',  'select * from Decisioning.ECONOMETRICS_TA_CALLS_OFFERS');

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'ECONOMETRICS_TA_CALLS_OFFERS_ENDING');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'ECONOMETRICS_TA_CALLS_OFFERS_ENDING',  'select * from Decisioning.ECONOMETRICS_TA_CALLS_OFFERS_ENDING');

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'ECONOMETRICS_TA_CALLS_OFFERS_ACTIVE');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'ECONOMETRICS_TA_CALLS_OFFERS_ACTIVE',  'select * from Decisioning.ECONOMETRICS_TA_CALLS_OFFERS_ACTIVE');

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'ECONOMETRICS_TA_CALLS_ACCOUNT_LEVEL');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'ECONOMETRICS_TA_CALLS_ACCOUNT_LEVEL',  'select * from Decisioning.ECONOMETRICS_TA_CALLS_ACCOUNT_LEVEL');

*/