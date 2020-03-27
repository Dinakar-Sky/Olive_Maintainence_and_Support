/* ***************************************************************************************************************************************************************
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
Project:        Base population
Created:        29/02/2018
Owner  :        Fractal
--------------------------------------------------------------------------------------------------------------------------------------------------------------
Program to extract holidngs on a weekly basis to get base population 

***************************************************************************************************************************************************************
****                                                              Change History                                                                           ****
*****************************************************************************************************************************************************************
Change#   Date         Author    	       Description 
** --       ---------   ------------- 	 ------------------------------------
** 1       03/01/2018   Vikram Haibate       Initial release 
** 2       01/03/2018   Vikram Haibate       Removed dependency on top mart
** 3       14/03/2018   Vikram Haibate       Adding rose changes(Sky ENtertainment Bundle)
** 4       13/04/2018   Vikram Haibate       Added HD legacy,hd_basic and hd_premiums in final marts 
** 5       31/05/2018   VIkram Haibate		 change in table name
** 6       25/06/2018   Vikram Haibate       drop columns 
** 7       27/06/2918   Aaditya Padmawar     Addded contract columns
** 8       03/07/2018   Aaditya Padmawar     Added extra Fields
** 9       06/08/2018   Vikram Haibate 		 Split ALA-Carte and change definition of talk_product_holding -> beta 3
** 7 	   24/12/2018 	Vikram Haibate		 Adding cinema and MOvies offers 
** 8 	   04/01/2019 	Vikram Haibate		 Adding Ala carte product holding and sports complete flag
** 9 	   22/02/2019   Vikram Haibate		 Changes deployed in the production 
***************************************************************************************************************************************************************

-----------------------------------------------------------------------DDLS------------------------------------------------------------------------------------
dba.sp_drop_table 'Decisioning','ECONOMETRICS_BASE'
dba.sp_create_table 'Decisioning','ECONOMETRICS_BASE',
   ' YEAR_WEEK VARCHAR (31) DEFAULT NULL, '
|| ' WEEK_START DATE DEFAULT NULL, '
|| ' COUNTRY VARCHAR (5) DEFAULT NULL, '
|| ' ACTUAL_OFFER_STATUS VARCHAR (15) DEFAULT NULL, '
|| ' INTENDED_OFFER_STATUS VARCHAR (15) DEFAULT NULL, '
|| ' DTV INT DEFAULT NULL, '
|| ' BASIC_PACKAGE_HOLDING VARCHAR (50) DEFAULT NULL, '
|| ' SKY_KIDS TINYINT DEFAULT 0, '
|| ' SKY_BOXSETS TINYINT DEFAULT 0, '
|| ' TOP_TIER INT DEFAULT NULL, '
|| ' MOVIES INT DEFAULT NULL, '
|| ' SPORTS INT DEFAULT NULL, '
|| ' HD_ANY INT DEFAULT NULL, '
|| ' HD_LEGACY INT DEFAULT NULL, '
|| ' HD_BASIC VARCHAR (50) DEFAULT NULL, '
|| ' HD_PREMIUM INT DEFAULT NULL, '
|| ' BB_ACTIVE TINYINT  DEFAULT NULL, '
|| ' BB_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' LR INT DEFAULT NULL, '
|| ' talk_product_holding VARCHAR (50) DEFAULT NULL, '
|| ' MS_product_holding VARCHAR (50) DEFAULT NULL, '
|| ' chelsea_tv TINYINT DEFAULT 0, '
|| ' mu_tv TINYINT DEFAULT 0, '
|| ' liverpool_tv TINYINT DEFAULT 0, '
|| ' skyasia_tv TINYINT DEFAULT 0, '
|| ' SKY_GO_EXTRA INT DEFAULT NULL, '
|| ' SPOTIFY TINYINT DEFAULT 0, '
||'  Netflix TINYINT DEFAULT 0, '
||'  Netflix_Product_Holding  VARCHAR (50) DEFAULT NULL, '
|| ' Sports_product_holding VARCHAR (50) DEFAULT NULL, '
|| ' Cinema_product_holding VARCHAR (50) DEFAULT NULL, '
|| ' Original_Product_Holding VARCHAR (50) DEFAULT NULL, '
|| ' MS_Count INT DEFAULT NULL, '
|| ' MOBILE INT DEFAULT NULL, '
|| ' SkyQ_Silver INT DEFAULT NULL, '
|| ' Skykids_app INT DEFAULT NULL, '
|| ' ANY_OFFER_ACTIVE SMALLINT DEFAULT 0, '
|| ' DTV_OFFER INT DEFAULT NULL, '
|| ' BB_OFFER INT DEFAULT NULL, '
|| ' LR_OFFER INT DEFAULT NULL, '
|| ' MS_OFFER INT DEFAULT NULL, '
|| ' HD_OFFER INT DEFAULT NULL, '
|| ' TENURE int DEFAULT 0, '
|| ' TV_REGION VARCHAR (45) DEFAULT NULL, '
|| ' TOTAL_PREMIUMS TINYINT DEFAULT 0, '
|| ' TOTAL_SPORTS TINYINT DEFAULT 0, '
|| ' TOTAL_MOVIES TINYINT DEFAULT 0, '
|| ' NUMBER_OF_ACCOUNTS INT DEFAULT NULL, '
|| ' Offer_End_Status_Level_1 varchar(30) default null, '
|| ' Offer_End_Status_Level_2 varchar(30) default null, '
|| ' Sports_OFFER_END_STATUS_LEVEL_1 varchar(30) default null, '
|| ' Cinema_OFFER_END_STATUS_LEVEL_1 varchar(30) default null, '
|| ' Sports_OFFER_END_STATUS_LEVEL_2 varchar(30) default null, '
|| ' Cinema_OFFER_END_STATUS_LEVEL_2 varchar(30) default null, '
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
|| ' ala_carte_product_holding varchar(30) default null,'
|| ' sports_complete TINYINT DEFAULT 0 '

dba.sp_drop_table 'Decisioning','ECONOMETRICS_BASE_OFFERS'
dba.sp_create_table 'Decisioning','ECONOMETRICS_BASE_OFFERS',
   ' YEAR_WEEK VARCHAR (31) DEFAULT NULL, '
|| ' WEEK_START DATE DEFAULT NULL, '
|| ' COUNTRY VARCHAR (5) DEFAULT NULL, '
|| ' ACTUAL_OFFER_STATUS VARCHAR (15) DEFAULT NULL, '
|| ' INTENDED_OFFER_STATUS VARCHAR (15) DEFAULT NULL, '
|| ' DTV INT DEFAULT NULL, '
|| ' BASIC_PACKAGE_HOLDING VARCHAR (50) DEFAULT NULL, '
|| ' SKY_KIDS TINYINT DEFAULT 0, '
|| ' SKY_BOXSETS TINYINT DEFAULT 0, '
|| ' TOP_TIER INT DEFAULT NULL, '
|| ' MOVIES INT DEFAULT NULL, '
|| ' SPORTS INT DEFAULT NULL, '
|| ' HD_ANY INT DEFAULT NULL, '
|| ' HD_LEGACY INT DEFAULT NULL, '
|| ' HD_BASIC VARCHAR (50) DEFAULT NULL, '
|| ' HD_PREMIUM INT DEFAULT NULL, '
|| ' BB_ACTIVE TINYINT  DEFAULT NULL, '
|| ' BB_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' LR INT DEFAULT NULL, '
|| ' talk_product_holding VARCHAR (50) DEFAULT NULL, '
|| ' MS_product_holding VARCHAR (50) DEFAULT NULL, '
|| ' chelsea_tv TINYINT DEFAULT 0, '
|| ' mu_tv TINYINT DEFAULT 0, '
|| ' liverpool_tv TINYINT DEFAULT 0, '
|| ' skyasia_tv TINYINT DEFAULT 0, '
|| ' SKY_GO_EXTRA INT DEFAULT NULL, '
|| ' SPOTIFY TINYINT DEFAULT 0, '
||'  Netflix TINYINT DEFAULT 0, '
||'  Netflix_Product_Holding  VARCHAR (50) DEFAULT NULL, '
|| ' Sports_product_holding VARCHAR (50) DEFAULT NULL, '
|| ' Cinema_product_holding VARCHAR (50) DEFAULT NULL, '
|| ' Original_Product_Holding VARCHAR (50) DEFAULT NULL, '
|| ' MS_Count INT DEFAULT NULL, '
|| ' MOBILE INT DEFAULT NULL, '
|| ' SkyQ_Silver INT DEFAULT NULL, '
|| ' Skykids_app INT DEFAULT NULL, '
|| ' OFFER_SUB_TYPE VARCHAR (80) DEFAULT NULL, '
|| ' OFFER_DESCRIPTION VARCHAR (465) DEFAULT NULL, '
|| ' MONTHLY_OFFER_VALUE DECIMAL (5,2) DEFAULT NULL, '
|| ' OFFER_DURATION_MTH INT DEFAULT NULL, '
|| ' TOTAL_OFFER_VALUE DECIMAL (5,2) DEFAULT NULL, '
|| ' OFFER_GIVEAWAY_EVENT VARCHAR (100) DEFAULT NULL, '
|| ' TENURE int DEFAULT 0, '
|| ' TV_REGION VARCHAR (45) DEFAULT NULL, '
|| ' TOTAL_PREMIUMS TINYINT DEFAULT 0, '
|| ' TOTAL_SPORTS TINYINT DEFAULT 0, '
|| ' TOTAL_MOVIES TINYINT DEFAULT 0, '
|| ' NUMBER_OF_ACCOUNTS INT DEFAULT NULL, '
|| ' NUMBER_OF_ACCOUNTS_OFFER_STARTED INT DEFAULT NULL, '
|| ' NUMBER_OF_ACCOUNTS_OFFER_ENDED INT DEFAULT NULL, '
|| ' Offer_End_Status_Level_1 varchar(30) default null, '
|| ' Offer_End_Status_Level_2 varchar(30) default null, '
|| ' Sports_OFFER_END_STATUS_LEVEL_1 varchar(30) default null, '
|| ' Cinema_OFFER_END_STATUS_LEVEL_1 varchar(30) default null, '
|| ' Sports_OFFER_END_STATUS_LEVEL_2 varchar(30) default null, '
|| ' Cinema_OFFER_END_STATUS_LEVEL_2 varchar(30) default null, '
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
|| ' ala_carte_product_holding varchar(30) default null,'
|| ' sports_complete TINYINT DEFAULT 0 '


dba.sp_drop_table 'Decisioning','ECONOMETRICS_BASE_OFFERS_STARTED'
dba.sp_create_table 'Decisioning','ECONOMETRICS_BASE_OFFERS_STARTED',
   ' YEAR_WEEK VARCHAR (31) DEFAULT NULL, '
|| ' WEEK_START DATE DEFAULT NULL, '
|| ' COUNTRY VARCHAR (5) DEFAULT NULL, '
|| ' ACTUAL_OFFER_STATUS VARCHAR (15) DEFAULT NULL, '
|| ' INTENDED_OFFER_STATUS VARCHAR (15) DEFAULT NULL, '
|| ' DTV INT DEFAULT NULL, '
|| ' BASIC_PACKAGE_HOLDING VARCHAR (50) DEFAULT NULL, '
|| ' SKY_KIDS TINYINT DEFAULT 0, '
|| ' SKY_BOXSETS TINYINT DEFAULT 0, '
|| ' TOP_TIER INT DEFAULT NULL, '
|| ' MOVIES INT DEFAULT NULL, '
|| ' SPORTS INT DEFAULT NULL, '
|| ' HD_ANY INT DEFAULT NULL, '
|| ' HD_LEGACY INT DEFAULT NULL, '
|| ' HD_BASIC VARCHAR (50) DEFAULT NULL, '
|| ' HD_PREMIUM INT DEFAULT NULL, '
|| ' BB_ACTIVE TINYINT  DEFAULT NULL, '
|| ' BB_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' LR INT DEFAULT NULL, '
|| ' talk_product_holding VARCHAR (50) DEFAULT NULL, '
|| ' MS_product_holding VARCHAR (50) DEFAULT NULL, '
|| ' chelsea_tv TINYINT DEFAULT 0, '
|| ' mu_tv TINYINT DEFAULT 0, '
|| ' liverpool_tv TINYINT DEFAULT 0, '
|| ' skyasia_tv TINYINT DEFAULT 0, '
|| ' SKY_GO_EXTRA INT DEFAULT NULL, '
|| ' SPOTIFY TINYINT DEFAULT 0, '
||'  Netflix TINYINT DEFAULT 0, '
||'  Netflix_Product_Holding  VARCHAR (50) DEFAULT NULL, '
|| ' Sports_product_holding VARCHAR (50) DEFAULT NULL, '
|| ' Cinema_product_holding VARCHAR (50) DEFAULT NULL, '
|| ' Original_Product_Holding VARCHAR (50) DEFAULT NULL, '
|| ' MS_Count INT DEFAULT NULL, '
|| ' MOBILE INT DEFAULT NULL, '
|| ' SkyQ_Silver INT DEFAULT NULL, '
|| ' Skykids_app INT DEFAULT NULL, '
|| ' OFFER_SUB_TYPE VARCHAR (80) DEFAULT NULL, '
|| ' OFFER_DESCRIPTION VARCHAR (465) DEFAULT NULL, '
|| ' MONTHLY_OFFER_VALUE DECIMAL (5,2) DEFAULT NULL, '
|| ' OFFER_DURATION_MTH INT DEFAULT NULL, '
|| ' TOTAL_OFFER_VALUE DECIMAL (5,2) DEFAULT NULL, '
|| ' OFFER_GIVEAWAY_EVENT VARCHAR (100) DEFAULT NULL, '
|| ' TENURE int DEFAULT 0, '
|| ' TV_REGION VARCHAR (45) DEFAULT NULL, '
|| ' TOTAL_PREMIUMS TINYINT DEFAULT 0, '
|| ' TOTAL_SPORTS TINYINT DEFAULT 0, '
|| ' TOTAL_MOVIES TINYINT DEFAULT 0, '
|| ' NUMBER_OF_ACCOUNTS_OFFER_STARTED INT DEFAULT NULL, '
|| ' Offer_End_Status_Level_1 varchar(30) default null, '
|| ' Offer_End_Status_Level_2 varchar(30) default null, '
|| ' Sports_OFFER_END_STATUS_LEVEL_1 varchar(30) default null, '
|| ' Cinema_OFFER_END_STATUS_LEVEL_1 varchar(30) default null, '
|| ' Sports_OFFER_END_STATUS_LEVEL_2 varchar(30) default null, '
|| ' Cinema_OFFER_END_STATUS_LEVEL_2 varchar(30) default null, '
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
|| ' ala_carte_product_holding varchar(30) default null,'
|| ' sports_complete TINYINT DEFAULT 0 '


dba.sp_drop_table 'Decisioning','ECONOMETRICS_BASE_ACCOUNT_LEVEL'
dba.sp_create_table 'Decisioning','ECONOMETRICS_BASE_ACCOUNT_LEVEL',
   ' YEAR_WEEK VARCHAR (31) DEFAULT NULL, '
|| ' WEEK_START DATE DEFAULT NULL, '
|| ' ACCOUNT_NUMBER varchar (100) DEFAULT NULL,'
|| ' EFFECTIVE_FROM_DT date DEFAULT NULL,'
|| ' EFFECTIVE_TO_DT date DEFAULT NULL,'
|| ' COUNTRY VARCHAR (5) DEFAULT NULL, '
|| ' ACTUAL_OFFER_STATUS VARCHAR (15) DEFAULT NULL, '
|| ' INTENDED_OFFER_STATUS VARCHAR (15) DEFAULT NULL, '
|| ' DTV INT DEFAULT NULL, '
|| ' ORIGINAL INT DEFAULT NULL, '
|| ' VARIETY INT DEFAULT NULL, '
|| ' FAMILY INT DEFAULT NULL, '
|| ' SKYQ INT DEFAULT NULL, '   
|| ' SKY_ENT TINYINT DEFAULT 0, '
|| ' BASIC_PACKAGE_HOLDING VARCHAR (50) DEFAULT NULL, '
|| ' SKY_KIDS TINYINT DEFAULT 0, '
|| ' BOX_SETS TINYINT DEFAULT 0, '
|| ' TOP_TIER INT DEFAULT NULL, '
|| ' MOVIES INT DEFAULT NULL, '
|| ' SPORTS INT DEFAULT NULL, '
|| ' HD_ANY INT DEFAULT NULL, '
|| ' HD_LEGACY INT DEFAULT NULL, '
|| ' HD_BASIC VARCHAR (50) DEFAULT NULL, '
|| ' HD_PREMIUM INT DEFAULT NULL, '
|| ' BB_ACTIVE TINYINT  DEFAULT NULL, '
|| ' BB_PRODUCT_HOLDING VARCHAR(80) DEFAULT NULL, '
|| ' LR INT DEFAULT NULL, '
|| ' talk_product_holding VARCHAR (50) DEFAULT NULL, '
|| ' MS_product_holding VARCHAR (50) DEFAULT NULL, '
|| ' chelsea_tv TINYINT DEFAULT 0, '
|| ' mu_tv TINYINT DEFAULT 0, '
|| ' liverpool_tv TINYINT DEFAULT 0, '
|| ' skyasia_tv TINYINT DEFAULT 0, '
|| ' SKY_GO_EXTRA INT DEFAULT NULL, '
|| ' SPOTIFY TINYINT DEFAULT 0, '
||'  Netflix TINYINT DEFAULT 0, '
||'  Netflix_Product_Holding  VARCHAR (50) DEFAULT NULL, '
|| ' Sports_product_holding VARCHAR (50) DEFAULT NULL, '
|| ' Cinema_product_holding VARCHAR (50) DEFAULT NULL, '
|| ' Original_Product_Holding VARCHAR (50) DEFAULT NULL, '
|| ' MS_Count INT DEFAULT NULL, '
|| ' MOBILE INT DEFAULT NULL, '
|| ' SkyQ_Silver INT DEFAULT NULL, '
|| ' Skykids_app INT DEFAULT NULL, '
|| ' ANY_OFFER_FLAG SMALLINT DEFAULT 0, '
|| ' DTV_PRIMARY_VIEWING_OFFER INT DEFAULT NULL, '
|| ' BB_OFFER INT DEFAULT NULL, '
|| ' LR_OFFER INT DEFAULT NULL, '
|| ' MS_OFFER INT DEFAULT NULL, '
|| ' HD_OFFER INT DEFAULT NULL, '
|| ' DTV_OFFER_DESCRIPTION VARCHAR (45) DEFAULT NULL, '
|| ' BB_OFFER_DESCRIPTION VARCHAR (45) DEFAULT NULL, '
|| ' LR_OFFER_DESCRIPTION VARCHAR (45) DEFAULT NULL, '
|| ' MS_OFFER_DESCRIPTION VARCHAR (45) DEFAULT NULL, '
|| ' HD_OFFER_DESCRIPTION VARCHAR (45) DEFAULT NULL, '
|| ' TENURE int DEFAULT 0, '
|| ' TV_REGION VARCHAR (45) DEFAULT NULL, '
|| ' TOTAL_PREMIUMS TINYINT DEFAULT 0, '
|| ' TOTAL_SPORTS TINYINT DEFAULT 0, '
|| ' TOTAL_MOVIES TINYINT DEFAULT 0, '
|| ' Offer_End_Status_Level_1 varchar(30) default null, '
|| ' Offer_End_Status_Level_2 varchar(30) default null, '
|| ' Sports_OFFER_END_STATUS_LEVEL_1 varchar(30) default null, '
|| ' Cinema_OFFER_END_STATUS_LEVEL_1 varchar(30) default null, '
|| ' Sports_OFFER_END_STATUS_LEVEL_2 varchar(30) default null, '
|| ' Cinema_OFFER_END_STATUS_LEVEL_2 varchar(30) default null, '
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
|| ' longest_time_in_nf_app DECIMAL (5,2) DEFAULT NULL, '
|| ' total_nf_app_launches DECIMAL (5,2) DEFAULT NULL, '
|| ' total_time_in_nf_app DECIMAL (5,2) DEFAULT NULL,'
|| ' longest_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL, '
|| ' total_spotify_app_launches DECIMAL (5,2) DEFAULT NULL, '
|| ' total_time_in_spotify_app DECIMAL (5,2) DEFAULT NULL, '
|| ' ala_carte_product_holding varchar(30) default null,'
|| ' sports_complete TINYINT DEFAULT 0 '
*/

setuser Decisioning_Procs
GO
DROP PROCEDURE IF EXISTS Decisioning_Procs.Update_Econometrics_BaseProfiles;
GO
create procedure Decisioning_Procs.Update_Econometrics_BaseProfiles( PERIOD_START date default null,PERIOD_END date default null ) 
sql security invoker
begin
  ---------------------------------------------------------------------------------------------------------------------
  --CREATE VARIABLES
  ---------------------------------------------------------------------------------------------------------------------
  set option Query_Temp_Space_Limit = 0;
  if PERIOD_START is null then
    set PERIOD_START = (select max(week_start)-4*7 from Decisioning.ECONOMETRICS_BASE)
  end if;
  if PERIOD_END is null then
    set PERIOD_END = today()
  end if;
  /*
create or replace variable PERIOD_START date;
create or replace variable PERIOD_END date;
SET PERIOD_START = '2016-01-01';
SET PERIOD_END = '2016-01-01';
*/
  -- Get week ends
  drop table if exists #weeks;
  select right(cast(subs_year as varchar),2) || '/' || right(cast(subs_year+1 as varchar),2)
     || '-' || case when subs_week_of_year < 10 then '0' || cast(subs_week_of_year as varchar) else cast(subs_week_of_year as varchar) end as year_week,
    cast(min(calendar_date) as date) as WEEK_START
    into #weeks
    from sky_calendar as cal
    where calendar_date >= PERIOD_START
    and calendar_date <= PERIOD_END
    group by year_week;
  -- Create replica of active subscriber report for DTV and BB only 
  select B.*
    into #dtv
    from CITeam.active_subscriber_report as B
    where B.dtv_Active_subscription = 1;
  select A.*,B.*
    into #DTV_WITH_WEEK
    from #WEEKS as A
      left outer join #dtv as B
      on A.WEEK_START >= B.effective_from_dt
      and A.WEEK_START < B.effective_to_dt;
  select YEAR_WEEK,
    WEEK_START,
    B.ACCOUNT_NUMBER,
    B.effective_from_dt,
    B.effective_to_dt,
    B.COUNTRY,
    B.subscription_id,
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
    cast(null as varchar(50)) as HD_BASIC,
    cast(null as integer) as HD_PREMIUM,
    B.MS_active_subscription as MULTISCREEN,
    null as MULTISCREEN_VOL,
    B.SGE_Active_subscription as SKY_GO_EXTRA,
    B.Spotify_Active_Subscription as Spotify,
    B.Netflix_Active_Subscription as Netflix,
    cast(null as varchar(50)) as Netflix_Product_Holding,
    -- Rose Fields 
    cast(0 as tinyint) as SKY_KIDS,
    cast(0 as tinyint) as BOX_SETS,
    -- END 
    B.product_holding,
    B.LR_ACTIVE_SUBSCRIPTION as LR,
    cast(null as varchar(50)) as talk_product_holding,
    cast(null as varchar(50)) as MS_product_holding,
    cast(0 as tinyint) as chelsea_tv,
    cast(0 as tinyint) as mu_tv,
    cast(0 as tinyint) as liverpool_tv,
    cast(0 as tinyint) as skyasia_tv,
    cast(null as varchar(50)) as Sports_product_holding,
    cast(null as varchar(50)) as Cinema_product_holding,
    cast(null as varchar(50)) as Original_Product_Holding,
    cast(0 as integer) as MS_Count,
    cast(0 as integer) as MOBILE,
    cast(0 as integer) as SkyQ_Silver,
    cast(0 as integer) as Skykids_App,
    cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_2_DTV_Extra_Subscription,
    cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_2_DTV_Sky_plus,
    cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_2_DTV_HD,
    cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_2_MS_plus,
    cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_2_SKY_BOX_SETS,
    cast('No Contract' as varchar(100)) as Basic_Contract_Status_Level_2,
    cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_2,
    cast('No Contract' as varchar(100)) as Talk_Contract_Status_Level_2,
    cast('No Contract' as varchar(100)) as BB_Contract_Status_Level_2,
    cast('No Contract' as varchar(100)) as Overall_Contract_Status_Level_2,
    cast('No Contract' as varchar(100)) as Basic_Contract_Status_Level_1,
    cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_1,
    cast('No Contract' as varchar(100)) as Talk_Contract_Status_Level_1,
    cast('No Contract' as varchar(100)) as BB_Contract_Status_Level_1,
    cast('No Contract' as varchar(100)) as Overall_Contract_Status_Level_1,
    cast(null as varchar(30)) as ala_carte_product_holding,
    cast(0 as tinyint) as sports_complete
    into #ASR_ECON_ONE
    from #DTV_WITH_WEEK as B;
  -- Calculate only bb customers 
  select asr.*
    into #bb
    from CITeam.active_subscriber_report as asr
    where asr.bb_Active_subscription = 1;
  select A.*,B.*
    into #bb_only_econ
    from #WEEKS as A
      left outer join #bb as B
      on A.WEEK_START >= B.effective_from_dt
      and A.WEEK_START < B.effective_to_dt
    where B.bb_Active_subscription = 1;
  update #bb_only_econ as base
    set base.dtv_active_subscription = asr.dtv_active_subscription from
    #bb_only_econ as base
    join CITeam.active_subscriber_report as asr
    on base.account_number = asr.account_number
    where base.week_start between asr.effective_from_dt and asr.effective_to_dt-1 and asr.dtv_active_subscription = 1;
  delete from #bb_only_econ where dtv_active_subscription = 1;
  select YEAR_WEEK,
    WEEK_START,
    B.ACCOUNT_NUMBER,
    B.effective_from_dt,
    B.effective_to_dt,
    B.COUNTRY,
    B.subscription_id,
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
    cast(null as varchar(50)) as HD_BASIC,
    cast(null as integer) as HD_PREMIUM,
    B.MS_active_subscription as MULTISCREEN,
    null as MULTISCREEN_VOL,
    B.SGE_Active_subscription as SKY_GO_EXTRA,
    B.Spotify_Active_Subscription as SPOTIFY,
    B.Netflix_Active_Subscription as Netflix,
    cast(null as varchar(50)) as Netflix_Product_Holding,
    -- Rose Fields 
    cast(0 as tinyint) as SKY_KIDS,
    cast(0 as tinyint) as BOX_SETS,
    -- END 
    B.product_holding,
    B.LR_ACTIVE_SUBSCRIPTION as LR,
    cast(null as varchar(50)) as talk_product_holding,
    cast(null as varchar(50)) as MS_product_holding,
    cast(0 as tinyint) as chelsea_tv,
    cast(0 as tinyint) as mu_tv,
    cast(0 as tinyint) as liverpool_tv,
    cast(0 as tinyint) as skyasia_tv,
    cast(null as varchar(50)) as Sports_product_holding,
    cast(null as varchar(50)) as Cinema_product_holding,
    cast(null as varchar(50)) as Original_Product_Holding,
    cast(0 as integer) as MS_Count,
    cast(0 as integer) as MOBILE,
    cast(0 as integer) as SkyQ_Silver,
    cast(0 as integer) as Skykids_App,
    cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_2_DTV_Extra_Subscription,
    cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_2_DTV_Sky_plus,
    cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_2_DTV_HD,
    cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_2_MS_plus,
    cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_2_SKY_BOX_SETS,
    cast('No Contract' as varchar(100)) as Basic_Contract_Status_Level_2,
    cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_2,
    cast('No Contract' as varchar(100)) as Talk_Contract_Status_Level_2,
    cast('No Contract' as varchar(100)) as BB_Contract_Status_Level_2,
    cast('No Contract' as varchar(100)) as Overall_Contract_Status_Level_2,
    cast('No Contract' as varchar(100)) as Basic_Contract_Status_Level_1,
    cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_1,
    cast('No Contract' as varchar(100)) as Talk_Contract_Status_Level_1,
    cast('No Contract' as varchar(100)) as BB_Contract_Status_Level_1,
    cast('No Contract' as varchar(100)) as Overall_Contract_Status_Level_1,
    cast(null as varchar(30)) as ala_carte_product_holding,
    cast(0 as tinyint) as sports_complete
    into #ASR_ECON_TWO
    from #bb_only_econ as B;
  select Base.*
    into #ASR_ECON
    from(select E_Base.* from #ASR_ECON_ONE as E_Base union
      select E_Base.* from #ASR_ECON_TWO as E_Base) as Base;
  -- Update product holding 
  update #ASR_ECON as base
    set base.top_tier = asr.tt_Active_subscription from
    #ASR_ECON as base
    join CITeam.active_subscriber_report as asr
    on base.account_number = asr.account_number
    where base.week_start between asr.effective_from_dt and asr.effective_to_dt-1 and asr.tt_active_subscription = 1;
  update #ASR_ECON as base
    set base.movies = asr.movies_Active_subscription,
    base.Cinema_product_holding = asr.product_holding from
    #ASR_ECON as base
    join CITeam.active_subscriber_report as asr
    on base.account_number = asr.account_number
    where base.week_start between asr.effective_from_dt and asr.effective_to_dt-1 and asr.movies_active_subscription = 1;
  update #ASR_ECON as base
    set base.SPORTS = asr.sports_Active_subscription,
    base.Sports_product_holding = asr.product_holding,
    base.sports_complete = case when lower(asr.product_holding) like '%complete%' then 1 else 0 end from
    #ASR_ECON as base
    join CITeam.active_subscriber_report as asr
    on base.account_number = asr.account_number
    where base.week_start between asr.effective_from_dt and asr.effective_to_dt-1 and asr.sports_active_subscription = 1;
  update #ASR_ECON as base
    set base.LR = asr.LR_Active_subscription from
    #ASR_ECON as base
    join CITeam.active_subscriber_report as asr
    on base.account_number = asr.account_number
    where base.week_start between asr.effective_from_dt and asr.effective_to_dt-1 and asr.LR_active_subscription = 1;
  update #ASR_ECON as base
    set base.chelsea_tv = 1 from
    #ASR_ECON as base
    join CITeam.active_subscriber_report as asr
    on base.account_number = asr.account_number
    where base.week_start between asr.effective_from_dt and asr.effective_to_dt-1 and asr.Chelsea_TV_Active_Subscription = 1;
  update #ASR_ECON as base
    set base.mu_tv = 1 from
    #ASR_ECON as base
    join CITeam.active_subscriber_report as asr
    on base.account_number = asr.account_number
    where base.week_start between asr.effective_from_dt and asr.effective_to_dt-1 and asr.MUTV_ACTIVE_SUBSCRIPTION = 1;
  update #ASR_ECON as base
    set base.liverpool_tv = 1 from
    #ASR_ECON as base
    join CITeam.active_subscriber_report as asr
    on base.account_number = asr.account_number
    where base.week_start between asr.effective_from_dt and asr.effective_to_dt-1 and asr.Liverpool_ACTIVE_SUBSCRIPTION = 1;
  update #ASR_ECON as base
    set base.skyasia_tv = 1 from
    #ASR_ECON as base
    join CITeam.active_subscriber_report as asr
    on base.account_number = asr.account_number
    where base.week_start between asr.effective_from_dt and asr.effective_to_dt-1 and asr.SkyAsia_ACTIVE_SUBSCRIPTION = 1;
  -- Ala carte product holding 
  update #ASR_ECON as base
    set base.ala_carte_product_holding = asr.product_holding from
    #ASR_ECON as base
    join CITeam.active_subscriber_report as asr
    on base.account_number = asr.account_number
    where base.week_start between asr.effective_from_dt and asr.effective_to_dt-1
    and(asr.SkyAsia_ACTIVE_SUBSCRIPTION+asr.Liverpool_ACTIVE_SUBSCRIPTION+asr.MUTV_ACTIVE_SUBSCRIPTION+asr.Chelsea_TV_Active_Subscription) > 0;
  update #ASR_ECON as base
    set base.talk_product_holding = asr.product_holding from
    #ASR_ECON as base
    join CITeam.active_subscriber_report as asr
    on base.account_number = asr.account_number
    where base.week_start between asr.effective_from_dt and asr.effective_to_dt-1 and asr.talk_active_subscription = 1;
  update #ASR_ECON as base
    set base.Netflix = asr.Netflix_Active_subscription,
    base.netflix_product_holding = asr.product_holding from
    #ASR_ECON as base
    join CITeam.active_subscriber_report as asr
    on base.account_number = asr.account_number
    where base.week_start between asr.effective_from_dt and asr.effective_to_dt-1
    and asr.netflix_active_subscription = 1 and asr.product_holding <> 'UOD';
  update #ASR_ECON as base
    set base.MS_product_holding = asr.product_holding from
    #ASR_ECON as base
    join CITeam.active_subscriber_report as asr
    on base.account_number = asr.account_number
    where base.week_start between asr.effective_from_dt and asr.effective_to_dt-1 and asr.ms_active_subscription = 1;
  update #ASR_ECON as base
    set base.hd_any = asr.HD_Active_subscription,
    hd_legacy = case when asr.CURRENT_PRODUCT_SK = 687 then 1 else 0 end,
    hd_basic = case when asr.CURRENT_PRODUCT_SK in( 43678 ) then 'Pre-Rose Package' when asr.CURRENT_PRODUCT_SK in( 53103,53539 ) then 'Post-Rose Package' else 'No Package' end,
    hd_premium = case when asr.CURRENT_PRODUCT_SK = 43679 then 1 else 0 end from
    #ASR_ECON as base
    join CITeam.active_subscriber_report as asr
    on base.account_number = asr.account_number
    where base.week_start between asr.effective_from_dt and asr.effective_to_dt-1 and asr.HD_active_subscription = 1;
  update #ASR_ECON as base
    set base.MS_Count = csh.ms_count from
    #ASR_ECON as base
    join(select csh.account_number,csh.effective_from_dt,
      sum(case when lower(csh.subscription_sub_type) = 'dtv extra subscription' then 1 else 0 end) as ms_count
      from cust_subs_hist as csh
      where csh.OWNING_CUST_ACCOUNT_ID > '1'
      and csh.SI_LATEST_SRC = 'CHORD'
      and csh.status_code in( 'AC','AB','PC' ) 
      and csh.effective_to_dt > csh.effective_from_dt
      group by csh.account_number,csh.effective_from_dt) as csh
    on base.account_number = csh.account_number
    and base.effective_from_dt = csh.effective_from_dt;
  update #ASR_ECON as base
    set base.Original_Product_Holding = csh.CURRENT_PRODUCT_DESCRIPTION from
    #ASR_ECON as base
    join cust_subs_hist as csh
    on base.account_number = csh.account_number
    and base.effective_from_dt = csh.effective_from_dt
    where csh.subscription_sub_type = 'DTV Primary Viewing'
    and csh.CURRENT_PRODUCT_DESCRIPTION like 'Original%'
    and csh.OWNING_CUST_ACCOUNT_ID > '1'
    and csh.SI_LATEST_SRC = 'CHORD'
    and status_code in( 'AC','AB','PC' ) 
    and csh.effective_to_dt > csh.effective_from_dt;
  update #ASR_ECON as base
    set base.SkyQ_Silver = 1 from
    #ASR_ECON as base
    join cust_subs_hist as csh
    on base.account_number = csh.account_number
    and base.effective_from_dt = csh.effective_from_dt
    where csh.current_product_description = 'Sky Q Silver Bundle'
    and csh.OWNING_CUST_ACCOUNT_ID > '1'
    and csh.SI_LATEST_SRC = 'CHORD'
    and status_code in( 'AC','AB','PC' ) 
    and csh.effective_to_dt > csh.effective_from_dt;
  update #ASR_ECON as base
    set base.mobile = case when mav.mobile > 1 then 1 else 0 end from
    #ASR_ECON as base
    join cust_single_account_view as sav on base.account_number = sav.account_number
    left outer join(select account_number,portfolio_id,account_status_dt,count_of_msisdn_active as mobile from CUST_SINGLE_MOBILE_ACCOUNT_VIEW where count_of_msisdn_active > 0 and account_status = 'ACTIVE') as MAV
    on SAV.acct_fo_portfolio_id = MAV.portfolio_id and base.week_start > mav.account_status_dt
    where sav.ACCOUNT_NUMBER is not null;
  select owning_cust_account_id,ph_subs_hist_sk,subscription_id,account_number,effective_from_dt,effective_to_dt
    into #hd_pack
    from cust_subs_hist as csh
    where subscription_sub_type in( 'HD Pack' ) 
    and csh.account_number <> '99999999999999'
    and csh.OWNING_CUST_ACCOUNT_ID > '1'
    and csh.SI_LATEST_SRC = 'CHORD'
    and status_code in( 'AC','AB','PC' ) 
    and csh.effective_to_dt > csh.effective_from_dt
    group by owning_cust_account_id,ph_subs_hist_sk,subscription_id,account_number,effective_from_dt,effective_to_dt;
  update #ASR_ECON as base
    set hd_premium = 1,hd_Any = 1 from
    #ASR_ECON as base
    join #hd_pack as asr
    on base.account_number = asr.account_number
    where base.week_start between asr.effective_from_dt and asr.effective_to_dt-1;
  update #ASR_ECON as base
    set base.MULTISCREEN = asr.ms_Active_subscription from
    #ASR_ECON as base
    join CITeam.active_subscriber_report as asr
    on base.account_number = asr.account_number
    where base.week_start between asr.effective_from_dt and asr.effective_to_dt-1 and asr.ms_active_subscription = 1;
  update #ASR_ECON as base
    set base.SKY_GO_EXTRA = asr.SGE_Active_subscription from
    #ASR_ECON as base
    join CITeam.active_subscriber_report as asr
    on base.account_number = asr.account_number
    where base.week_start between asr.effective_from_dt and asr.effective_to_dt-1 and asr.SGE_active_subscription = 1;
  update #ASR_ECON as base
    set base.SPOTIFY = asr.SPOTIFY_Active_subscription from
    #ASR_ECON as base
    join CITeam.active_subscriber_report as asr
    on base.account_number = asr.account_number
    where base.week_start between asr.effective_from_dt and asr.effective_to_dt-1 and asr.Spotify_active_subscription = 1;
  -- Rose field update 
  update #ASR_ECON as base
    set base.SKY_KIDS = asr.KIDS_Active_Subscription from
    #ASR_ECON as base
    join CITeam.Active_Subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.week_start between asr.effective_from_dt and asr.effective_to_dt-1 and asr.KIDS_Active_Subscription = 1;
  update #ASR_ECON as base
    set base.BOX_SETS = asr.BOXSETS_Active_Subscription from
    #ASR_ECON as base
    join CITeam.Active_Subscriber_Report as asr
    on base.account_number = asr.account_number
    where base.week_start between asr.effective_from_dt and asr.effective_to_dt-1 and asr.BOXSETS_Active_Subscription = 1;
  update #ASR_ECON as base
    set base.skykids_app = 1 from
    #ASR_ECON as base
    join SAM_REGISTRANT as sam on base.account_number = sam.account_number
    join SKYID_ENTITLEMENT as ENTITLEMENT on ENTITLEMENT.samprofileid = sam.samprofileid
    where ENTITLEMENT.role_dim_role_code = 'skykids' and base.week_start between ENTITLEMENT.role_date_from and ENTITLEMENT.role_date_to;
  select YEAR_WEEK,
    WEEK_START,
    B.ACCOUNT_NUMBER,
    -- ,B.subscription_id
    B.effective_from_dt,
    B.effective_to_dt,
    B.COUNTRY,
    B.DTV,
    ORIGINAL,
    VARIETY,
    FAMILY,
    SKYQ,
    SKY_ENT,
    cast(null as varchar(30)) as BASIC_PACKAGE_HOLDING,
    SKY_KIDS,
    BOX_SETS,
    TOP_TIER,
    MOVIES,
    SPORTS,
    HD_ANY,
    HD_LEGACY,
    HD_BASIC,
    HD_PREMIUM,
    MULTISCREEN,
    null as MULTISCREEN_VOL,
    SKY_GO_EXTRA,
    SPOTIFY,
    Netflix,
    Netflix_Product_Holding,
    LR,
    talk_product_holding,
    MS_product_holding,
    chelsea_tv,
    mu_tv,
    liverpool_tv,
    skyasia_tv,
    Sports_product_holding,
    Cinema_product_holding,
    Original_Product_Holding,
    MS_Count,
    MOBILE,
    SkyQ_Silver,
    Skykids_App,
    product_holding,
    --,contract_status
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
    Add_on_Products_Contract_Status_Level_2_DTV_Extra_Subscription,
    Add_on_Products_Contract_Status_Level_2_DTV_Sky_plus,
    Add_on_Products_Contract_Status_Level_2_DTV_HD,
    Add_on_Products_Contract_Status_Level_2_MS_plus,
    Add_on_Products_Contract_Status_Level_2_SKY_BOX_SETS,
    ala_carte_product_holding,
    sports_complete,
    cast(0 as tinyint) as BB_ACTIVE,
    cast(null as varchar(80)) as BB_Product_Holding,
    cast(null as varchar(15)) as ACTUAL_OFFER_STATUS,
    cast(null as varchar(15)) as INTENDED_OFFER_STATUS,
    0 as ANY_OFFER_FLAG,
    cast(null as integer) as DTV_PRIMARY_VIEWING_OFFER,
    cast(null as integer) as BB_OFFER,
    cast(null as integer) as LR_OFFER,
    cast(null as integer) as MS_OFFER,
    cast(null as integer) as HD_OFFER,
    cast(null as varchar(45)) as DTV_OFFER_DESCRIPTION,
    cast(null as varchar(45)) as BB_OFFER_DESCRIPTION,
    cast(null as varchar(45)) as LR_OFFER_DESCRIPTION,
    cast(null as varchar(45)) as MS_OFFER_DESCRIPTION,
    cast(null as varchar(45)) as HD_OFFER_DESCRIPTION,
    cast(null as integer) as TENURE,
    --,CAST(NULL AS int) AS TENURE_month
    cast(null as varchar(45)) as SIMPLE_SEGMENT,
    cast(null as varchar(45)) as TV_REGION,
    cast(null as varchar(45)) as mosaic_uk_group,
    -- MMC new prems fields ------------------------------------------------------------------------  
    cast(0 as tinyint) as Prems_Product_Count, -- as PRE_ORDER_TOTAL_PREMIUMS -- 0,1,2,3,6 for sport + 0,3 or 6 for cinema 
    cast(0 as tinyint) as Sports_Product_Count, -- PRE_ORDER_TOTAL_SPORTS -- 0,1,2,3,6
    cast(0 as tinyint) as Movies_Product_Count, -- PRE_ORDER_TOTAL_MOVIES -- 0,3,6
    cast(0 as tinyint) as Prems_Active, --as PRE_ORDER_DUAL_SPORTS
    cast(0 as tinyint) as Sports_Active, --as PRE_ORDER_DUAL_SPORTS
    cast(0 as tinyint) as Movies_Active, --as PRE_ORDER_DUAL_SPORTS
    cast(0 as tinyint) as TOTAL_PREMIUMS,
    cast(0 as tinyint) as TOTAL_SPORTS,
    cast(0 as tinyint) as TOTAL_MOVIES,
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
    cast(null as decimal(5,2)) as longest_time_in_nf_app,
    cast(null as decimal(5,2)) as shortest_time_in_nf_app,
    cast(null as decimal(5,2)) as total_nf_app_launches,
    cast(null as decimal(5,2)) as total_time_in_nf_app,
    cast(null as decimal(5,2)) as longest_time_in_spotify_app,
    cast(null as decimal(5,2)) as shortest_time_in_spotify_app,
    cast(null as decimal(5,2)) as total_spotify_app_launches,
    cast(null as decimal(5,2)) as total_time_in_spotify_app
    ---------------------------------------------------------------------------------------------------
    into #ECONOMETRICS_BASE
    from #ASR_ECON as B;
  select a.account_number,a.week_start,a.effective_from_dt,a.effective_to_dt,
    (max(coalesce(longest_time_in_app,0.0)))/60000.0 as longest_time_in_nf_app,
    (min(coalesce(shortest_time_in_app,0.0)))/60000.0 as shortest_time_in_nf_app,
    sum(coalesce(total_app_launches,0.0)) as total_nf_app_launches,
    sum(coalesce(total_time_in_app,0.0))/60000.0 as total_time_in_nf_app
    into #weekly_netflix_app_usage
    from #ECONOMETRICS_BASE as a
      left outer join q_stb_app_usage as b
      on a.account_number = b.account_number
      and cast(b.event_datetime as date) between a.week_start and a.week_start+6
      and lower(trim(app_name)) = 'netflix'
    group by a.account_number,a.week_start,a.effective_from_dt,a.effective_to_dt;
  select a.account_number,a.week_start,a.effective_from_dt,a.effective_to_dt,
    (max(coalesce(longest_time_in_app,0.0)))/60000.0 as longest_time_in_spotify_app,
    (min(coalesce(shortest_time_in_app,0.0)))/60000.0 as shortest_time_in_spotify_app,
    sum(coalesce(total_app_launches,0.0)) as total_spotify_app_launches,
    sum(coalesce(total_time_in_app,0.0))/60000.0 as total_time_in_spotify_app
    into #weekly_spotify_app_usage
    from #ECONOMETRICS_BASE as a
      left outer join q_stb_app_usage as b
      on a.account_number = b.account_number
      and cast(b.event_datetime as date) between a.week_start and a.week_start+6
      and lower(trim(app_name)) like '%spotify%'
    group by a.account_number,a.week_start,a.effective_from_dt,a.effective_to_dt;
  update #ECONOMETRICS_BASE as base
    set base.longest_time_in_nf_app = coalesce(B.longest_time_in_nf_app,0.0),
    base.shortest_time_in_nf_app = coalesce(B.shortest_time_in_nf_app,0.0),
    base.total_nf_app_launches = coalesce(B.total_nf_app_launches,0.0),
    base.total_time_in_nf_app = coalesce(B.total_time_in_nf_app,0.0) from
    #ECONOMETRICS_BASE as base
    join #weekly_netflix_app_usage as b
    on base.account_number = B.account_number and base.week_start = B.week_start;
  update #ECONOMETRICS_BASE as base
    set base.longest_time_in_spotify_app = coalesce(B.longest_time_in_spotify_app,0.0),
    base.shortest_time_in_spotify_app = coalesce(B.shortest_time_in_spotify_app,0.0),
    base.total_spotify_app_launches = coalesce(B.total_spotify_app_launches,0.0),
    base.total_time_in_spotify_app = coalesce(B.total_time_in_spotify_app,0.0) from
    #ECONOMETRICS_BASE as base
    join #weekly_spotify_app_usage as b
    on base.account_number = B.account_number and base.week_start = B.week_start;
  commit work;
  create hg index idx_1 on #ECONOMETRICS_BASE(ACCOUNT_NUMBER);
  create date index idx_2 on #ECONOMETRICS_BASE(WEEK_START);
  -- MMC Populate prems fields with Model T data -----------------------------------------------
  call Decisioning_Procs.Add_Active_Subscriber_Product_Holding_Econ('#ECONOMETRICS_BASE','WEEK_START','Sports','Update Only','Sports_Active','Sports_Product_Count');
  call Decisioning_Procs.Add_Active_Subscriber_Product_Holding_Econ('#ECONOMETRICS_BASE','WEEK_START','Movies','Update Only','Movies_Active','Movies_Product_Count');
  call Decisioning_Procs.Add_Active_Subscriber_Product_Holding_Econ('#ECONOMETRICS_BASE','WEEK_START','Prems','Update Only','Prems_Active','Prems_Product_Count');
  call Decisioning_Procs.Add_Active_Subscriber_Product_Holding('#ECONOMETRICS_BASE','WEEK_START','BB','Update Only','BB_ACTIVE','BB_PRODUCT_HOLDING');
  commit work;
  -- MMC - Update 
  update #ECONOMETRICS_BASE
    set TOTAL_PREMIUMS = Sports_Product_Count+Movies_Product_Count,
    TOTAL_SPORTS = Sports_Product_Count,
    TOTAL_MOVIES = Movies_Product_Count;
  commit work;
  -- update contract 
  select account_number,subscription_id,subscription_type,cast(start_date_new as date) as status_start_date,cast(end_date_new as date) as status_end_date,Contract_status
    into #Contracts
    from(select account_number,subscription_id,subscription_type,actual_contract_end_date+1 as start_date_new,coalesce((lead(start_date) over(order by account_number asc,subscription_id asc,start_date asc)-1),'9999-09-09') as end_date_new,'Out Of Contract' as contract_status from decisioning.contracts union all
      select account_number,subscription_id,subscription_type,(max(actual_contract_end_date)+1) as start_date_new,'9999-09-09' as end_date_new,'Out Of Contract' as contract_status from decisioning.contracts group by account_number,subscription_id,subscription_type union all
      select account_number,subscription_id,subscription_type,start_date as start_date_new,actual_contract_end_date as end_Date_new,'In Contract' as contract_status from decisioning.contracts) as a
    where start_date_new <= end_date_new;
  ---new
  update #ECONOMETRICS_BASE as base
    set base.Basic_Contract_Status_Level_2
     = case when DTV > 0 then
      (case when ctr.contract_status = 'In Contract' then
        case when ctr.status_end_date between(week_start) and(week_start+7) then 'Contract Ending in Next 1 Wks'
        when ctr.status_end_date between(week_start+8) and(week_start+14) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(week_start+15) and(week_start+21) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(week_start+22) and(week_start+28) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(week_start+29) and(week_start+35) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(week_start+36) and(week_start+42) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(week_start+43) and(week_start+49) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date between(week_start+50) and(week_start+56) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date > (week_start+56) then 'Contract Ending in 8+ Wks'
        else 'No Contract'
        end when ctr.contract_status = 'Out Of Contract' then
        case when ctr.status_start_date-1 between(week_start-7) and(week_start-1) then 'Contract Ended in last 1 Wks'
        when ctr.status_start_date-1 between(week_start-14) and(week_start-8) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(week_start-21) and(week_start-15) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(week_start-28) and(week_start-22) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(week_start-35) and(week_start-29) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(week_start-42) and(week_start-36) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(week_start+43) and(week_start+49) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 between(week_start+50) and(week_start+56) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 < (week_start-56) then --then 'Contract Ended 8+ Wks'
          'No Contract' else 'No Contract' end
      else 'No Contract'
      end)
    else 'No Contract'
    end from #ECONOMETRICS_BASE as base
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.week_start between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and subscription_type in( 'Primary DTV' ) ;
  update #ECONOMETRICS_BASE as base
    set base.Add_on_Products_Contract_Status_Level_2_DTV_Extra_Subscription = case when ctr.contract_status = 'In Contract' then
      case when ctr.status_end_date between(week_start) and(week_start+7) then 'Contract Ending in Next 1 Wks'
      when ctr.status_end_date between(week_start+8) and(week_start+14) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(week_start+15) and(week_start+21) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(week_start+22) and(week_start+28) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(week_start+29) and(week_start+35) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(week_start+36) and(week_start+42) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(week_start+43) and(week_start+49) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date between(week_start+50) and(week_start+56) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date > (week_start+56) then 'Contract Ending in 8+ Wks'
      else 'No Contract'
      end when ctr.contract_status = 'Out Of Contract' then
      case when ctr.status_start_date-1 between(week_start-7) and(week_start-1) then 'Contract Ended in last 1 Wks'
      when ctr.status_start_date-1 between(week_start-14) and(week_start-8) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(week_start-21) and(week_start-15) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(week_start-28) and(week_start-22) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(week_start-35) and(week_start-29) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(week_start-42) and(week_start-36) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(week_start+43) and(week_start+49) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 between(week_start+50) and(week_start+56) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 < (week_start-56) then --then 'Contract Ended 8+ Wks'
        'No Contract' else 'No Contract' end
    else 'No Contract'
    end from
    #ECONOMETRICS_BASE as base
    left outer join cust_subs_hist as csh on base.account_number = csh.account_number and base.week_start between csh.effective_from_dt and csh.effective_to_dt and csh.status_code in( 'AC','AB','PC' ) 
    and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD' and csh.subscription_type in( 'DTV PACKAGE' ) and csh.subscription_sub_type = 'DTV Extra Subscription'
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.week_start between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and ctr.subscription_type in( 'Secondary DTV' ) and csh.subscription_type in( 'DTV PACKAGE' ) 
    and csh.subscription_sub_type = 'DTV Extra Subscription' and csh.status_code in( 'AC','AB','PC' ) and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD' and csh.subscription_id = ctr.subscription_id;
  update #ECONOMETRICS_BASE as base
    set base.Add_on_Products_Contract_Status_Level_2_DTV_Sky_plus
     = case when ctr.contract_status = 'In Contract' then
      case when ctr.status_end_date between(week_start) and(week_start+7) then 'Contract Ending in Next 1 Wks'
      when ctr.status_end_date between(week_start+8) and(week_start+14) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(week_start+15) and(week_start+21) then 'Contract Ending in Next 2-3 Wks'
      when ctr.status_end_date between(week_start+22) and(week_start+28) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(week_start+29) and(week_start+35) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(week_start+36) and(week_start+42) then 'Contract Ending in Next 4-6 Wks'
      when ctr.status_end_date between(week_start+43) and(week_start+49) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date between(week_start+50) and(week_start+56) then 'Contract Ending in Next 7-8 Wks'
      when ctr.status_end_date > (week_start+56) then 'Contract Ending in 8+ Wks'
      else 'No Contract'
      end when ctr.contract_status = 'Out Of Contract' then
      case when ctr.status_start_date-1 between(week_start-7) and(week_start-1) then 'Contract Ended in last 1 Wks'
      when ctr.status_start_date-1 between(week_start-14) and(week_start-8) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(week_start-21) and(week_start-15) then 'Contract Ended in last 2-3 Wks'
      when ctr.status_start_date-1 between(week_start-28) and(week_start-22) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(week_start-35) and(week_start-29) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(week_start-42) and(week_start-36) then 'Contract Ended in last 4-6 Wks'
      when ctr.status_start_date-1 between(week_start+43) and(week_start+49) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 between(week_start+50) and(week_start+56) then 'Contract Ended in last 7-8 Wks'
      when ctr.status_start_date-1 < (week_start-56) then --then 'Contract Ended 8+ Wks'
        'No Contract' else 'No Contract' end
    else 'No Contract'
    end from
    #ECONOMETRICS_BASE as base
    left outer join cust_subs_hist as csh on base.account_number = csh.account_number and base.week_start between csh.effective_from_dt and csh.effective_to_dt and csh.status_code in( 'AC','AB','PC' ) 
    and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD' and csh.subscription_type in( 'ENHANCED' ) and csh.subscription_sub_type = 'DTV Sky+'
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.week_start between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and ctr.subscription_type in( 'Sky Enhanced Cap Subs' ) and csh.subscription_type in( 'ENHANCED' ) 
    and csh.subscription_sub_type = 'DTV Sky+' and csh.status_code in( 'AC','AB','PC' ) and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD' and csh.subscription_id = ctr.subscription_id;
  update #ECONOMETRICS_BASE as base
    set base.Add_on_Products_Contract_Status_Level_2_DTV_HD
     = case when HD_BASIC <> 'No Package' then
      (case when ctr.contract_status = 'In Contract' then
        case when ctr.status_end_date between(week_start) and(week_start+7) then 'Contract Ending in Next 1 Wks'
        when ctr.status_end_date between(week_start+8) and(week_start+14) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(week_start+15) and(week_start+21) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(week_start+22) and(week_start+28) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(week_start+29) and(week_start+35) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(week_start+36) and(week_start+42) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(week_start+43) and(week_start+49) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date between(week_start+50) and(week_start+56) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date > (week_start+56) then 'Contract Ending in 8+ Wks'
        else 'No Contract'
        end when ctr.contract_status = 'Out Of Contract' then
        case when ctr.status_start_date-1 between(week_start-7) and(week_start-1) then 'Contract Ended in last 1 Wks'
        when ctr.status_start_date-1 between(week_start-14) and(week_start-8) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(week_start-21) and(week_start-15) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(week_start-28) and(week_start-22) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(week_start-35) and(week_start-29) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(week_start-42) and(week_start-36) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(week_start+43) and(week_start+49) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 between(week_start+50) and(week_start+56) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 < (week_start-56) then --then 'Contract Ended 8+ Wks'
          'No Contract' else 'No Contract' end
      else 'No Contract'
      end)
    else 'No Contract'
    end from #ECONOMETRICS_BASE as base
    left outer join cust_subs_hist as csh on base.account_number = csh.account_number and base.week_start between csh.effective_from_dt and csh.effective_to_dt and csh.status_code in( 'AC','AB','PC' ) 
    and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD' and csh.subscription_type in( 'ENHANCED' ) and csh.subscription_sub_type = 'DTV HD'
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.week_start between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and ctr.subscription_type in( 'Sky Enhanced Cap Subs' ) and csh.subscription_type in( 'ENHANCED' ) 
    and csh.subscription_sub_type = 'DTV HD' and csh.status_code in( 'AC','AB','PC' ) and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD' and csh.subscription_id = ctr.subscription_id;
  update #ECONOMETRICS_BASE as base
    set base.Add_on_Products_Contract_Status_Level_2_MS_plus
     = case when ms_count > 0 then
      (case when ctr.contract_status = 'In Contract' then
        case when ctr.status_end_date between(week_start) and(week_start+7) then 'Contract Ending in Next 1 Wks'
        when ctr.status_end_date between(week_start+8) and(week_start+14) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(week_start+15) and(week_start+21) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(week_start+22) and(week_start+28) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(week_start+29) and(week_start+35) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(week_start+36) and(week_start+42) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(week_start+43) and(week_start+49) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date between(week_start+50) and(week_start+56) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date > (week_start+56) then 'Contract Ending in 8+ Wks'
        else 'No Contract'
        end when ctr.contract_status = 'Out Of Contract' then
        case when ctr.status_start_date-1 between(week_start-7) and(week_start-1) then 'Contract Ended in last 1 Wks'
        when ctr.status_start_date-1 between(week_start-14) and(week_start-8) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(week_start-21) and(week_start-15) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(week_start-28) and(week_start-22) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(week_start-35) and(week_start-29) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(week_start-42) and(week_start-36) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(week_start+43) and(week_start+49) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 between(week_start+50) and(week_start+56) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 < (week_start-56) then --then 'Contract Ended 8+ Wks'
          'No Contract' else 'No Contract' end
      else 'No Contract'
      end)
    else 'No Contract'
    end from #ECONOMETRICS_BASE as base
    left outer join cust_subs_hist as csh on base.account_number = csh.account_number and base.week_start between csh.effective_from_dt and csh.effective_to_dt and csh.status_code in( 'AC','AB','PC' ) 
    and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD' and csh.subscription_type in( 'ENHANCED' ) and csh.subscription_sub_type = 'MS+'
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.week_start between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and ctr.subscription_type in( 'Sky Enhanced Cap Subs' ) and csh.subscription_type in( 'ENHANCED' ) 
    and csh.subscription_sub_type = 'MS+' and csh.status_code in( 'AC','AB','PC' ) and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD' and csh.subscription_id = ctr.subscription_id;
  update #ECONOMETRICS_BASE as base
    set base.Add_on_Products_Contract_Status_Level_2_SKY_BOX_SETS
     = case when BOX_SETS > 0 then
      (case when ctr.contract_status = 'In Contract' then
        case when ctr.status_end_date between(week_start) and(week_start+7) then 'Contract Ending in Next 1 Wks'
        when ctr.status_end_date between(week_start+8) and(week_start+14) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(week_start+15) and(week_start+21) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(week_start+22) and(week_start+28) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(week_start+29) and(week_start+35) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(week_start+36) and(week_start+42) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(week_start+43) and(week_start+49) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date between(week_start+50) and(week_start+56) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date > (week_start+56) then 'Contract Ending in 8+ Wks'
        else 'No Contract'
        end when ctr.contract_status = 'Out Of Contract' then
        case when ctr.status_start_date-1 between(week_start-7) and(week_start-1) then 'Contract Ended in last 1 Wks'
        when ctr.status_start_date-1 between(week_start-14) and(week_start-8) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(week_start-21) and(week_start-15) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(week_start-28) and(week_start-22) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(week_start-35) and(week_start-29) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(week_start-42) and(week_start-36) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(week_start+43) and(week_start+49) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 between(week_start+50) and(week_start+56) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 < (week_start-56) then --then 'Contract Ended 8+ Wks'
          'No Contract' else 'No Contract' end
      else 'No Contract'
      end)
    else 'No Contract'
    end from #ECONOMETRICS_BASE as base
    left outer join cust_subs_hist as csh on base.account_number = csh.account_number and base.week_start between csh.effective_from_dt and csh.effective_to_dt and csh.status_code in( 'AC','AB','PC' ) 
    and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD' and csh.subscription_type in( 'ENHANCED' ) and csh.subscription_sub_type = 'SKY_BOX_SETS'
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.week_start between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and ctr.subscription_type in( 'Sky Enhanced Cap Subs' ) and csh.subscription_type in( 'ENHANCED' ) 
    and csh.subscription_sub_type = 'SKY_BOX_SETS' and csh.status_code in( 'AC','AB','PC' ) and csh.OWNING_CUST_ACCOUNT_ID > '1' and csh.SI_LATEST_SRC = 'CHORD' and csh.subscription_id = ctr.subscription_id;
  update #ECONOMETRICS_BASE as base
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
    end from #ECONOMETRICS_BASE as base;
  update #ECONOMETRICS_BASE as base
    set base.Talk_Contract_Status_Level_2
     = case when talk_product_holding is not null then
      (case when ctr.contract_status = 'In Contract' then
        case when ctr.status_end_date between(week_start) and(week_start+7) then 'Contract Ending in Next 1 Wks'
        when ctr.status_end_date between(week_start+8) and(week_start+14) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(week_start+15) and(week_start+21) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(week_start+22) and(week_start+28) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(week_start+29) and(week_start+35) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(week_start+36) and(week_start+42) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(week_start+43) and(week_start+49) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date between(week_start+50) and(week_start+56) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date > (week_start+56) then 'Contract Ending in 8+ Wks'
        else 'No Contract'
        end when ctr.contract_status = 'Out Of Contract' then
        case when ctr.status_start_date-1 between(week_start-7) and(week_start-1) then 'Contract Ended in last 1 Wks'
        when ctr.status_start_date-1 between(week_start-14) and(week_start-8) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(week_start-21) and(week_start-15) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(week_start-28) and(week_start-22) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(week_start-35) and(week_start-29) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(week_start-42) and(week_start-36) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(week_start+43) and(week_start+49) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 between(week_start+50) and(week_start+56) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 < (week_start-56) then --then 'Contract Ended 8+ Wks'
          'No Contract' else 'No Contract' end
      else 'No Contract'
      end)
    else 'No Contract'
    end from #ECONOMETRICS_BASE as base
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.week_start between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and subscription_type in( 'Sky Talk' ) ;
  update #ECONOMETRICS_BASE as base
    set base.BB_Contract_Status_Level_2
     = case when BB_ACTIVE > 0 then
      (case when ctr.contract_status = 'In Contract' then
        case when ctr.status_end_date between(week_start) and(week_start+7) then 'Contract Ending in Next 1 Wks'
        when ctr.status_end_date between(week_start+8) and(week_start+14) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(week_start+15) and(week_start+21) then 'Contract Ending in Next 2-3 Wks'
        when ctr.status_end_date between(week_start+22) and(week_start+28) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(week_start+29) and(week_start+35) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(week_start+36) and(week_start+42) then 'Contract Ending in Next 4-6 Wks'
        when ctr.status_end_date between(week_start+43) and(week_start+49) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date between(week_start+50) and(week_start+56) then 'Contract Ending in Next 7-8 Wks'
        when ctr.status_end_date > (week_start+56) then 'Contract Ending in 8+ Wks'
        else 'No Contract'
        end when ctr.contract_status = 'Out Of Contract' then
        case when ctr.status_start_date-1 between(week_start-7) and(week_start-1) then 'Contract Ended in last 1 Wks'
        when ctr.status_start_date-1 between(week_start-14) and(week_start-8) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(week_start-21) and(week_start-15) then 'Contract Ended in last 2-3 Wks'
        when ctr.status_start_date-1 between(week_start-28) and(week_start-22) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(week_start-35) and(week_start-29) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(week_start-42) and(week_start-36) then 'Contract Ended in last 4-6 Wks'
        when ctr.status_start_date-1 between(week_start+43) and(week_start+49) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 between(week_start+50) and(week_start+56) then 'Contract Ended in last 7-8 Wks'
        when ctr.status_start_date-1 < (week_start-56) then --then 'Contract Ended 8+ Wks'
          'No Contract' else 'No Contract' end
      else 'No Contract'
      end)
    else 'No Contract'
    end from #ECONOMETRICS_BASE as base
    left outer join #Contracts as ctr
    on base.account_number = ctr.account_number
    --and base.subscription_id = ctr.subscription_id
    and base.week_start between ctr.status_start_date and ctr.status_end_date
    where ctr.contract_status in( 'In Contract','Out Of Contract' ) and subscription_type in( 'Broadband' ) ;
  /* 
update #ECONOMETRICS_BASE base
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
ELSE 'No Contract'END;
*/
  -- correction for Overall_Contract_Status_Level_2 
  update #ECONOMETRICS_BASE as base
    set base.Overall_Contract_Status_Level_2
     = case when base.Basic_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then base.Basic_Contract_Status_Level_2
    when base.BB_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then base.BB_Contract_Status_Level_2
    when base.Add_on_Products_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then base.Add_on_Products_Contract_Status_Level_2
    when base.Talk_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then base.Talk_Contract_Status_Level_2
    when(base.Basic_Contract_Status_Level_2 <> 'No Contract' and base.Basic_Contract_Status_Level_2 is not null) then base.Basic_Contract_Status_Level_2
    when(base.BB_Contract_Status_Level_2 <> 'No Contract' and base.BB_Contract_Status_Level_2 is not null) then base.BB_Contract_Status_Level_2
    when(base.Add_on_Products_Contract_Status_Level_2 <> 'No Contract' and base.Add_on_Products_Contract_Status_Level_2 is not null) then base.Add_on_Products_Contract_Status_Level_2
    when(base.Talk_Contract_Status_Level_2 <> 'No Contract' and base.Talk_Contract_Status_Level_2 is not null) then base.Talk_Contract_Status_Level_2
    else 'No Contract'
    end;
  update #ECONOMETRICS_BASE
    set BB_Contract_Status_Level_1
     = case when BB_Contract_Status_Level_2 in( 'Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
    'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks' ) then
      'Contract End'
    when BB_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then
      'In-Contract'
    else 'No Contract'
    end;
  update #ECONOMETRICS_BASE
    set Talk_Contract_Status_Level_1
     = case when Talk_Contract_Status_Level_2 in( 'Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
    'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks' ) then
      'Contract End'
    when Talk_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then
      'In-Contract'
    else 'No Contract'
    end;
  update #ECONOMETRICS_BASE
    set Add_on_Products_Contract_Status_Level_1
     = case when Add_on_Products_Contract_Status_Level_2 in( 'Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
    'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks' ) then
      'Contract End'
    when Add_on_Products_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then
      'In-Contract'
    else 'No Contract'
    end;
  update #ECONOMETRICS_BASE
    set Basic_Contract_Status_Level_1
     = case when Basic_Contract_Status_Level_2 in( 'Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
    'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks' ) then
      'Contract End'
    when Basic_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then
      'In-Contract'
    else 'No Contract'
    end;
  update #ECONOMETRICS_BASE
    set Overall_Contract_Status_Level_1
     = case when Overall_Contract_Status_Level_2 in( 'Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
    'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks' ) then
      'Contract End'
    when Overall_Contract_Status_Level_2 = 'Contract Ending in 8+ Wks' then
      'In-Contract'
    else 'No Contract'
    end;
  -- contract end 
  -- Offers status  start \x09
  call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','DTV','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_DTV','Curr_Offer_Intended_end_Dt_DTV');
  update #ECONOMETRICS_BASE
    set Basic_Offer_End_Status_Level_2
     = case when DTV = 1 then
      (case when Curr_Offer_Intended_end_Dt_DTV between(WEEK_START+1) and(WEEK_START+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_DTV between(WEEK_START+8) and(WEEK_START+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_DTV between(WEEK_START+15) and(WEEK_START+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_DTV between(WEEK_START+22) and(WEEK_START+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_DTV between(WEEK_START+29) and(WEEK_START+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_DTV between(WEEK_START+36) and(WEEK_START+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_DTV > (WEEK_START+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_DTV between(WEEK_START-7) and WEEK_START then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_DTV between(WEEK_START-14) and(WEEK_START-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_DTV between(WEEK_START-21) and(WEEK_START-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_DTV between(WEEK_START-28) and(WEEK_START-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_DTV between(WEEK_START-35) and(WEEK_START-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_DTV between(WEEK_START-42) and(WEEK_START-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_DTV < (WEEK_START-42) then 'Offer Ended 7+ Wks'
      else
        'No Offer'
      end)
    else 'No Offer'
    end;
  update #ECONOMETRICS_BASE
    set Basic_Offer_End_Status_Level_1
     = case when Basic_Offer_End_Status_Level_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when Basic_Offer_End_Status_Level_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','BROADBAND','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_BB','Curr_Offer_Intended_end_Dt_BB');
  update #ECONOMETRICS_BASE
    set BB_Offer_End_Status_Level_2
     = case when BB_ACTIVE = 1 then
      (case when Curr_Offer_Intended_end_Dt_BB between(WEEK_START+1) and(WEEK_START+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_BB between(WEEK_START+8) and(WEEK_START+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_BB between(WEEK_START+15) and(WEEK_START+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_BB between(WEEK_START+22) and(WEEK_START+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_BB between(WEEK_START+29) and(WEEK_START+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_BB between(WEEK_START+36) and(WEEK_START+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_BB > (WEEK_START+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_BB between(WEEK_START-7) and WEEK_START then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_BB between(WEEK_START-14) and(WEEK_START-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_BB between(WEEK_START-21) and(WEEK_START-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_BB between(WEEK_START-28) and(WEEK_START-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_BB between(WEEK_START-35) and(WEEK_START-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_BB between(WEEK_START-42) and(WEEK_START-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_BB < (WEEK_START-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #ECONOMETRICS_BASE
    set BB_Offer_End_Status_Level_1
     = case when BB_Offer_End_Status_Level_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when BB_Offer_End_Status_Level_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','LR','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_LR','Curr_Offer_Intended_end_Dt_LR');
  update #ECONOMETRICS_BASE
    set LR_Offer_End_Status_Level_2
     = case when LR = 1 then
      (case when Curr_Offer_Intended_end_Dt_LR between(WEEK_START+1) and(WEEK_START+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_LR between(WEEK_START+8) and(WEEK_START+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_LR between(WEEK_START+15) and(WEEK_START+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_LR between(WEEK_START+22) and(WEEK_START+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_LR between(WEEK_START+29) and(WEEK_START+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_LR between(WEEK_START+36) and(WEEK_START+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_LR > (WEEK_START+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_LR between(WEEK_START-7) and WEEK_START then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_LR between(WEEK_START-14) and(WEEK_START-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_LR between(WEEK_START-21) and(WEEK_START-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_LR between(WEEK_START-28) and(WEEK_START-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_LR between(WEEK_START-35) and(WEEK_START-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_LR between(WEEK_START-42) and(WEEK_START-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_LR < (WEEK_START-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #ECONOMETRICS_BASE
    set LR_Offer_End_Status_Level_1
     = case when LR_Offer_End_Status_Level_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when LR_Offer_End_Status_Level_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- sports 
  call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','Sports','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_Sports','Curr_Offer_Intended_end_Dt_Sports');
  update #ECONOMETRICS_BASE
    set Sports_OFFER_END_STATUS_LEVEL_2
     = case when TOTAL_SPORTS > 0 then
      (case when Curr_Offer_Intended_end_Dt_Sports between(WEEK_START+1) and(WEEK_START+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_Sports between(WEEK_START+8) and(WEEK_START+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_Sports between(WEEK_START+15) and(WEEK_START+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_Sports between(WEEK_START+22) and(WEEK_START+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_Sports between(WEEK_START+29) and(WEEK_START+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_Sports between(WEEK_START+36) and(WEEK_START+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_Sports > (WEEK_START+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_Sports between(WEEK_START-7) and WEEK_START then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_Sports between(WEEK_START-14) and(WEEK_START-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_Sports between(WEEK_START-21) and(WEEK_START-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_Sports between(WEEK_START-28) and(WEEK_START-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_Sports between(WEEK_START-35) and(WEEK_START-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_Sports between(WEEK_START-42) and(WEEK_START-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_Sports < (WEEK_START-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #ECONOMETRICS_BASE
    set Sports_OFFER_END_STATUS_LEVEL_1
     = case when Sports_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when Sports_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then 'On Offer'
    else 'No Offer'
    end;
  -- movies 
  call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','Movies','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_Movies','Curr_Offer_Intended_end_Dt_Movies');
  update #ECONOMETRICS_BASE
    set Cinema_OFFER_END_STATUS_LEVEL_2
     = case when TOTAL_MOVIES > 0 then
      (case when Curr_Offer_Intended_end_Dt_Movies between(WEEK_START+1) and(WEEK_START+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_Movies between(WEEK_START+8) and(WEEK_START+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_Movies between(WEEK_START+15) and(WEEK_START+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_Movies between(WEEK_START+22) and(WEEK_START+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_Movies between(WEEK_START+29) and(WEEK_START+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_Movies between(WEEK_START+36) and(WEEK_START+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_Movies > (WEEK_START+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_Movies between(WEEK_START-7) and WEEK_START then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_Movies between(WEEK_START-14) and(WEEK_START-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_Movies between(WEEK_START-21) and(WEEK_START-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_Movies between(WEEK_START-28) and(WEEK_START-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_Movies between(WEEK_START-35) and(WEEK_START-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_Movies between(WEEK_START-42) and(WEEK_START-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_Movies < (WEEK_START-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #ECONOMETRICS_BASE
    set Cinema_OFFER_END_STATUS_LEVEL_1
     = case when Cinema_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when Cinema_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then 'On Offer'
    else 'No Offer'
    end;
  -- PREMS
  update #ECONOMETRICS_BASE
    set PREMIUM_Offer_End_Status_Level_1
     = case when TOTAL_PREMIUMS > 0 then
      (case when(Sports_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or Cinema_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending') then 'Offer Ending'
      when(Sports_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or Cinema_OFFER_END_STATUS_LEVEL_1 = 'On Offer') then 'On Offer'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #ECONOMETRICS_BASE
    set PREMIUM_Offer_End_Status_Level_2
     = case when TOTAL_PREMIUMS > 0 then
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
  call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','HD','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_HD','Curr_Offer_Intended_end_Dt_HD');
  update #ECONOMETRICS_BASE
    set HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when HD_BASIC <> 'No Package' then
      (case when Curr_Offer_Intended_end_Dt_HD between(WEEK_START+1) and(WEEK_START+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_HD between(WEEK_START+8) and(WEEK_START+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_HD between(WEEK_START+15) and(WEEK_START+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_HD between(WEEK_START+22) and(WEEK_START+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_HD between(WEEK_START+29) and(WEEK_START+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_HD between(WEEK_START+36) and(WEEK_START+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_HD > (WEEK_START+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_HD between(WEEK_START-7) and WEEK_START then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_HD between(WEEK_START-14) and(WEEK_START-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_HD between(WEEK_START-21) and(WEEK_START-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_HD between(WEEK_START-28) and(WEEK_START-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_HD between(WEEK_START-35) and(WEEK_START-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_HD between(WEEK_START-42) and(WEEK_START-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_HD < (WEEK_START-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #ECONOMETRICS_BASE
    set HD_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- ms 
  call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','MS','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_MS','Curr_Offer_Intended_end_Dt_MS');
  update #ECONOMETRICS_BASE
    set MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when MS_Count > 0 then
      (case when Curr_Offer_Intended_end_Dt_MS between(WEEK_START+1) and(WEEK_START+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_MS between(WEEK_START+8) and(WEEK_START+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_MS between(WEEK_START+15) and(WEEK_START+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_MS between(WEEK_START+22) and(WEEK_START+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_MS between(WEEK_START+29) and(WEEK_START+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_MS between(WEEK_START+36) and(WEEK_START+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_MS > (WEEK_START+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_MS between(WEEK_START-7) and WEEK_START then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_MS between(WEEK_START-14) and(WEEK_START-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_MS between(WEEK_START-21) and(WEEK_START-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_MS between(WEEK_START-28) and(WEEK_START-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_MS between(WEEK_START-35) and(WEEK_START-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_MS between(WEEK_START-42) and(WEEK_START-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_MS < (WEEK_START-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #ECONOMETRICS_BASE
    set MS_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- SGE 
  call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','SGE','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_SGE','Curr_Offer_Intended_end_Dt_SGE');
  update #ECONOMETRICS_BASE
    set SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when SKY_GO_EXTRA > 0 then
      (case when Curr_Offer_Intended_end_Dt_SGE between(WEEK_START+1) and(WEEK_START+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_SGE between(WEEK_START+8) and(WEEK_START+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_SGE between(WEEK_START+15) and(WEEK_START+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_SGE between(WEEK_START+22) and(WEEK_START+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_SGE between(WEEK_START+29) and(WEEK_START+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_SGE between(WEEK_START+36) and(WEEK_START+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_SGE > (WEEK_START+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_SGE between(WEEK_START-7) and WEEK_START then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_SGE between(WEEK_START-14) and(WEEK_START-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_SGE between(WEEK_START-21) and(WEEK_START-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_SGE between(WEEK_START-28) and(WEEK_START-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_SGE between(WEEK_START-35) and(WEEK_START-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_SGE between(WEEK_START-42) and(WEEK_START-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_SGE < (WEEK_START-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #ECONOMETRICS_BASE
    set SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- HD Pack  
  call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','HD PACK','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_HD_PACK','Curr_Offer_Intended_end_Dt_HD_PACK');
  update #ECONOMETRICS_BASE
    set HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when HD_PREMIUM > 0 then
      (case when Curr_Offer_Intended_end_Dt_HD_PACK between(WEEK_START+1) and(WEEK_START+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_HD_PACK between(WEEK_START+8) and(WEEK_START+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_HD_PACK between(WEEK_START+15) and(WEEK_START+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_HD_PACK between(WEEK_START+22) and(WEEK_START+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_HD_PACK between(WEEK_START+29) and(WEEK_START+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_HD_PACK between(WEEK_START+36) and(WEEK_START+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_HD_PACK > (WEEK_START+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_HD_PACK between(WEEK_START-7) and WEEK_START then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_HD_PACK between(WEEK_START-14) and(WEEK_START-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_HD_PACK between(WEEK_START-21) and(WEEK_START-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_HD_PACK between(WEEK_START-28) and(WEEK_START-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_HD_PACK between(WEEK_START-35) and(WEEK_START-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_HD_PACK between(WEEK_START-42) and(WEEK_START-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_HD_PACK < (WEEK_START-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #ECONOMETRICS_BASE
    set HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- Box sets 
  call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','BOX SETS','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_BOX_SETS','Curr_Offer_Intended_end_Dt_BOX_SETS');
  update #ECONOMETRICS_BASE
    set BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when BOX_SETS > 0 then
      (case when Curr_Offer_Intended_end_Dt_BOX_SETS between(WEEK_START+1) and(WEEK_START+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_BOX_SETS between(WEEK_START+8) and(WEEK_START+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_BOX_SETS between(WEEK_START+15) and(WEEK_START+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_BOX_SETS between(WEEK_START+22) and(WEEK_START+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_BOX_SETS between(WEEK_START+29) and(WEEK_START+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_BOX_SETS between(WEEK_START+36) and(WEEK_START+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_BOX_SETS > (WEEK_START+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_BOX_SETS between(WEEK_START-7) and WEEK_START then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_BOX_SETS between(WEEK_START-14) and(WEEK_START-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_BOX_SETS between(WEEK_START-21) and(WEEK_START-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_BOX_SETS between(WEEK_START-28) and(WEEK_START-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_BOX_SETS between(WEEK_START-35) and(WEEK_START-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_BOX_SETS between(WEEK_START-42) and(WEEK_START-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_BOX_SETS < (WEEK_START-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #ECONOMETRICS_BASE
    set BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- SKY Kids 
  call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','SKY_KIDS','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_SKY_KIDS','Curr_Offer_Intended_end_Dt_SKY_KIDS');
  update #ECONOMETRICS_BASE
    set SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when SKY_KIDS > 0 then
      (case when Curr_Offer_Intended_end_Dt_SKY_KIDS between(WEEK_START+1) and(WEEK_START+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_SKY_KIDS between(WEEK_START+8) and(WEEK_START+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_SKY_KIDS between(WEEK_START+15) and(WEEK_START+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_SKY_KIDS between(WEEK_START+22) and(WEEK_START+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_SKY_KIDS between(WEEK_START+29) and(WEEK_START+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_SKY_KIDS between(WEEK_START+36) and(WEEK_START+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_SKY_KIDS > (WEEK_START+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_SKY_KIDS between(WEEK_START-7) and WEEK_START then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_SKY_KIDS between(WEEK_START-14) and(WEEK_START-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_SKY_KIDS between(WEEK_START-21) and(WEEK_START-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_SKY_KIDS between(WEEK_START-28) and(WEEK_START-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_SKY_KIDS between(WEEK_START-35) and(WEEK_START-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_SKY_KIDS between(WEEK_START-42) and(WEEK_START-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_SKY_KIDS < (WEEK_START-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #ECONOMETRICS_BASE
    set SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- Sky Talk 
  call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','TALK','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_TALK','Curr_Offer_Intended_end_Dt_TALK');
  update #ECONOMETRICS_BASE
    set TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when talk_product_holding is not null then
      (case when Curr_Offer_Intended_end_Dt_TALK between(WEEK_START+1) and(WEEK_START+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_TALK between(WEEK_START+8) and(WEEK_START+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_TALK between(WEEK_START+15) and(WEEK_START+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_TALK between(WEEK_START+22) and(WEEK_START+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_TALK between(WEEK_START+29) and(WEEK_START+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_TALK between(WEEK_START+36) and(WEEK_START+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_TALK > (WEEK_START+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_TALK between(WEEK_START-7) and WEEK_START then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_TALK between(WEEK_START-14) and(WEEK_START-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_TALK between(WEEK_START-21) and(WEEK_START-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_TALK between(WEEK_START-28) and(WEEK_START-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_TALK between(WEEK_START-35) and(WEEK_START-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_TALK between(WEEK_START-42) and(WEEK_START-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_TALK < (WEEK_START-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #ECONOMETRICS_BASE
    set TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  -- SPOTIFY 
  call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','SPOTIFY','Ordered','All',null,'Update Only','Prev_Offer_Actual_End_Dt_SPOTIFY','Curr_Offer_Intended_end_Dt_SPOTIFY');
  update #ECONOMETRICS_BASE
    set SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when SPOTIFY > 0 then
      (case when Curr_Offer_Intended_end_Dt_SPOTIFY between(WEEK_START+1) and(WEEK_START+7) then 'Offer Ending in Next 1 Wks'
      when Curr_Offer_Intended_end_Dt_SPOTIFY between(WEEK_START+8) and(WEEK_START+14) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_SPOTIFY between(WEEK_START+15) and(WEEK_START+21) then 'Offer Ending in Next 2-3 Wks'
      when Curr_Offer_Intended_end_Dt_SPOTIFY between(WEEK_START+22) and(WEEK_START+28) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_SPOTIFY between(WEEK_START+29) and(WEEK_START+35) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_SPOTIFY between(WEEK_START+36) and(WEEK_START+42) then 'Offer Ending in Next 4-6 Wks'
      when Curr_Offer_Intended_end_Dt_SPOTIFY > (WEEK_START+42) then 'Offer Ending in 7+ Wks'
      when Prev_Offer_Actual_End_Dt_SPOTIFY between(WEEK_START-7) and WEEK_START then 'Offer Ended in last 1 Wks'
      when Prev_Offer_Actual_End_Dt_SPOTIFY between(WEEK_START-14) and(WEEK_START-8) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_SPOTIFY between(WEEK_START-21) and(WEEK_START-15) then 'Offer Ended in last 2-3 Wks'
      when Prev_Offer_Actual_End_Dt_SPOTIFY between(WEEK_START-28) and(WEEK_START-22) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_SPOTIFY between(WEEK_START-35) and(WEEK_START-29) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_SPOTIFY between(WEEK_START-42) and(WEEK_START-36) then 'Offer Ended in last 4-6 Wks'
      when Prev_Offer_Actual_End_Dt_SPOTIFY < (WEEK_START-42) then 'Offer Ended 7+ Wks'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #ECONOMETRICS_BASE
    set SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks' ) then
      'Offer Ending'
    when SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks' then
      'On Offer'
    else 'No Offer'
    end;
  update #ECONOMETRICS_BASE
    set ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1
     = case when(case when hd_basic <> 'No Package' then 1 else 0 end+coalesce(HD_PREMIUM,0)+coalesce(BOX_SETS,0)+coalesce(SKY_KIDS,0)+coalesce(MULTISCREEN,0)+case when talk_product_holding is not null then 1 else 0 end+coalesce(SKY_GO_EXTRA,0)+coalesce(SPOTIFY,0)) > 0 then
      (case when(SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or MS_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or HD_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending') then 'Offer Ending'
      when(SPOTIFY_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or TALK_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or SKY_KIDS_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or BOX_SETS_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or SGE_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or HD_PACK_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or MS_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or HD_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer') then 'On Offer'
      else 'No Offer'
      end)
    else 'No Offer'
    end;
  update #ECONOMETRICS_BASE
    set ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2
     = case when(case when hd_basic <> 'No Package' then 1 else 0 end+coalesce(HD_PREMIUM,0)+coalesce(BOX_SETS,0)+coalesce(SKY_KIDS,0)+coalesce(MULTISCREEN,0)+case when talk_product_holding is not null then 1 else 0 end+coalesce(SKY_GO_EXTRA,0)+coalesce(SPOTIFY,0)) > 0 then
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
  /*
case when (case when hd_basic<> 'No Package' then 1 else 0 end +HD_PREMIUM+BOX_SETS+SKY_KIDS+MULTISCREEN+case when talk_product_holding is not null then 1 else 0 end +SKY_GO_EXTRA+DTV+BB_ACTIVE+TOTAL_PREMIUMS+LR)>0 then
(
)
else 'No Offer' end

*/
  update #ECONOMETRICS_BASE
    set Offer_End_Status_Level_1
     = case when(BASIC_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or BB_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or LR_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending' or PREMIUM_Offer_End_Status_Level_1 = 'Offer Ending' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'Offer Ending') then 'Offer Ending'
    when(BASIC_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or BB_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or LR_OFFER_END_STATUS_LEVEL_1 = 'On Offer' or PREMIUM_Offer_End_Status_Level_1 = 'On Offer' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 'On Offer') then 'On Offer'
    else
      'No Offer'
    end;
  /*
case when (case when hd_basic<> 'No Package' then 1 else 0 end +HD_PREMIUM+BOX_SETS+SKY_KIDS+MULTISCREEN+case when talk_product_holding is not null then 1 else 0 end +SKY_GO_EXTRA+DTV+BB_ACTIVE+TOTAL_PREMIUMS+LR)>0 then
(  

) else 'No Offer' end
*/
  update #ECONOMETRICS_BASE
    set Offer_End_Status_Level_2
     = case when Offer_End_Status_Level_1 = 'No Offer' then 'No Offer'
    when Offer_End_Status_Level_1 = 'On Offer' then 'Offer Ending in 7+ Wks'
    when Offer_End_Status_Level_1 = 'Offer Ending' then
      (case when(BASIC_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or BB_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or LR_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks' or PREMIUM_Offer_End_Status_Level_2 = 'Offer Ending in Next 1 Wks' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 1 Wks') then 'Offer Ending in Next 1 Wks'
      when(BASIC_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or BB_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or LR_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks' or PREMIUM_Offer_End_Status_Level_2 = 'Offer Ending in Next 2-3 Wks' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 2-3 Wks') then 'Offer Ending in Next 2-3 Wks'
      when(BASIC_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or BB_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or LR_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks' or PREMIUM_Offer_End_Status_Level_2 = 'Offer Ending in Next 4-6 Wks' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in Next 4-6 Wks') then 'Offer Ending in Next 4-6 Wks'
      when(BASIC_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or BB_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or LR_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks' or PREMIUM_Offer_End_Status_Level_2 = 'Offer Ended in last 1 Wks' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 1 Wks') then 'Offer Ended in last 1 Wks'
      when(BASIC_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or BB_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or LR_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks' or PREMIUM_Offer_End_Status_Level_2 = 'Offer Ended in last 2-3 Wks' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 2-3 Wks') then 'Offer Ended in last 2-3 Wks'
      when(BASIC_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or BB_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or LR_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks' or PREMIUM_Offer_End_Status_Level_2 = 'Offer Ended in last 4-6 Wks' or ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ended in last 4-6 Wks') then
        'Offer Ended in last 4-6 Wks'
      end)
    end;
  -- end 
  drop table if exists #BASE_OFFER_STATUS;
  select D.ACCOUNT_NUMBER,
    D.WEEK_START,
    case when D.ACTUAL_OFFER_STATUS = 2 then 'Offer End'
    when D.ACTUAL_OFFER_STATUS = 1 then 'On Offer'
    else 'No Offer'
    end as ACTUAL_OFFER_STATUS,
    case when D.INTENDED_OFFER_STATUS = 2 then 'Offer End'
    when D.INTENDED_OFFER_STATUS = 1 then 'On Offer'
    else 'No Offer'
    end as INTENDED_OFFER_STATUS
    into #BASE_OFFER_STATUS
    from(select distinct A.ACCOUNT_NUMBER,
        A.WEEK_START,
        MAX(
        case when B.WHOLE_OFFER_END_DT_ACTUAL <> A.WEEK_START and A.WEEK_START-55 <= B.WHOLE_OFFER_END_DT_ACTUAL and A.WEEK_START+35 >= B.WHOLE_OFFER_END_DT_ACTUAL then 2
        when B.WHOLE_OFFER_END_DT_ACTUAL = A.WEEK_START and A.WEEK_START-55 <= B.Intended_Offer_End_Dt and A.WEEK_START+35 >= B.Intended_Offer_End_Dt then 2
        when B.WHOLE_OFFER_END_DT_ACTUAL is not null then 1
        else 0
        end) as ACTUAL_OFFER_STATUS,
        MAX(
        case when A.WEEK_START-55 <= C.Intended_Offer_End_Dt and A.WEEK_START+35 >= C.Intended_Offer_End_Dt then 2
        when C.Intended_Offer_End_Dt is not null then 1
        else 0
        end) as INTENDED_OFFER_STATUS
        from #ECONOMETRICS_BASE as A
          left outer join Decisioning.Offers_Software as B
          on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
          and A.WEEK_START >= B.WHOLE_OFFER_START_DT_ACTUAL
          and A.WEEK_START-55 <= B.WHOLE_OFFER_END_DT_ACTUAL
          and lower(B.offer_dim_description) not like 'price protect%'
          and B.WHOLE_OFFER_AMOUNT_ACTUAL < 0
          left outer join Decisioning.Offers_Software as C
          on A.ACCOUNT_NUMBER = C.ACCOUNT_NUMBER
          and A.WEEK_START >= C.Offer_Leg_Start_Dt_Actual
          and A.WEEK_START-55 <= C.Intended_Offer_End_Dt
          and lower(C.offer_dim_description) not like 'price protect%'
          and C.WHOLE_OFFER_AMOUNT_ACTUAL < 0
        group by A.ACCOUNT_NUMBER,
        A.WEEK_START) as D
    group by D.ACCOUNT_NUMBER,
    D.WEEK_START,
    D.ACTUAL_OFFER_STATUS,
    D.INTENDED_OFFER_STATUS;
  commit work;
  -- UPDATE TABLE
  update #ECONOMETRICS_BASE as A
    set A.ACTUAL_OFFER_STATUS = B.ACTUAL_OFFER_STATUS,
    A.INTENDED_OFFER_STATUS = B.INTENDED_OFFER_STATUS from
    #BASE_OFFER_STATUS as B
    where A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and A.WEEK_START = B.WEEK_START;
  commit work;
  -- Drop temp tables
  drop table if exists #BASE_OFFER_STATUS;
  commit work;
  -- ADD FLAG IF ACCOUNT HAS ANY OFFER
  update #ECONOMETRICS_BASE as A
    set A.ANY_OFFER_FLAG = case when Offer_End_Status_Level_2 <> 'No Offer' then 1 else 0 end,
    A.DTV_PRIMARY_VIEWING_OFFER = case when Basic_Offer_End_Status_Level_2 <> 'No Offer' then 1 else 0 end,
    A.BB_OFFER = case when BB_Offer_End_Status_Level_2 <> 'No Offer' then 1 else 0 end,
    A.LR_OFFER = case when LR_Offer_End_Status_Level_2 <> 'No Offer' then 1 else 0 end,
    A.MS_OFFER = case when MS_PRODUCTS_OFFER_END_STATUS_LEVEL_2 <> 'No Offer' then 1 else 0 end,
    A.HD_OFFER = case when HD_PRODUCTS_OFFER_END_STATUS_LEVEL_2 <> 'No Offer' then 1 else 0 end;
  commit work;
  -----------------------------------------------------------------------------------------------
  -- UPDATE THE TV_REGION  and Tenure 
  update #ECONOMETRICS_BASE as base
    set base.TV_Region = B.tv_region,
    base.TENURE = case when DATEDIFF(month,B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT,base.WEEK_START) < 0 then 0 else DATEDIFF(month,B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT,base.WEEK_START) end from
    #ECONOMETRICS_BASE as base
    join CITeam.Account_TV_Region as B
    on base.account_number = B.account_number;
  update #ECONOMETRICS_BASE as A
    set A.BASIC_PACKAGE_HOLDING = case when ORIGINAL > 0 then 'ORIGINAL'
    when VARIETY > 0 then 'VARIETY'
    when FAMILY > 0 then 'FAMILY'
    when SKYQ > 0 then 'SKYQ'
    when SKY_ENT > 0 then 'SKY_ENT'
    else ''
    end from #ECONOMETRICS_BASE as A;
  -- table at account level 
  delete from Decisioning.ECONOMETRICS_BASE_ACCOUNT_LEVEL
    where WEEK_START between PERIOD_START and PERIOD_END;
  commit work;
  insert into Decisioning.ECONOMETRICS_BASE_ACCOUNT_LEVEL
    select YEAR_WEEK,
      WEEK_START,
      account_number,
      --,subscription_id
      effective_from_dt,
      effective_to_dt,
      COUNTRY,
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      DTV,
      ORIGINAL,
      VARIETY,
      FAMILY,
      SKYQ,
      SKY_ENT,
      BASIC_PACKAGE_HOLDING,
      SKY_KIDS,
      BOX_SETS,
      TOP_TIER,
      MOVIES,
      SPORTS,
      HD_ANY,
      HD_LEGACY,
      HD_BASIC,
      HD_PREMIUM,
      BB_ACTIVE,
      BB_PRODUCT_HOLDING,
      LR,
      talk_product_holding,
      MS_product_holding,
      chelsea_tv,
      mu_tv,
      liverpool_tv,
      skyasia_tv,
      SKY_GO_EXTRA,
      SPOTIFY,
      Netflix,
      Netflix_Product_Holding,
      Sports_product_holding,
      Cinema_product_holding,
      Original_Product_Holding,
      MS_Count,
      MOBILE,
      SkyQ_Silver,
      Skykids_App,
      ANY_OFFER_FLAG,
      DTV_PRIMARY_VIEWING_OFFER,
      BB_OFFER,
      LR_OFFER,
      MS_OFFER,
      HD_OFFER,
      DTV_OFFER_DESCRIPTION,
      BB_OFFER_DESCRIPTION,
      LR_OFFER_DESCRIPTION,
      MS_OFFER_DESCRIPTION,
      HD_OFFER_DESCRIPTION,
      TENURE,
      TV_REGION,
      TOTAL_PREMIUMS,
      TOTAL_SPORTS,
      TOTAL_MOVIES,
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      Sports_OFFER_END_STATUS_LEVEL_1,
      Cinema_OFFER_END_STATUS_LEVEL_1,
      Sports_OFFER_END_STATUS_LEVEL_2,
      Cinema_OFFER_END_STATUS_LEVEL_2,
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
      longest_time_in_nf_app,
      total_nf_app_launches,
      total_time_in_nf_app,
      longest_time_in_spotify_app,
      total_spotify_app_launches,
      total_time_in_spotify_app,
      ala_carte_product_holding,
      sports_complete
      from #ECONOMETRICS_BASE;
  commit work;
  delete from Decisioning.ECONOMETRICS_BASE
    where WEEK_START between PERIOD_START and PERIOD_END;
  commit work;
  insert into Decisioning.ECONOMETRICS_BASE
    select YEAR_WEEK,
      WEEK_START,
      COUNTRY,
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      DTV,
      BASIC_PACKAGE_HOLDING,
      SKY_KIDS,
      BOX_SETS,
      TOP_TIER,
      MOVIES,
      SPORTS,
      HD_ANY,
      HD_LEGACY,
      HD_BASIC,
      HD_PREMIUM,
      BB_ACTIVE,
      BB_PRODUCT_HOLDING,
      LR,
      talk_product_holding,
      MS_product_holding,
      chelsea_tv,
      mu_tv,
      liverpool_tv,
      skyasia_tv,
      SKY_GO_EXTRA,
      SPOTIFY,
      Netflix,
      Netflix_Product_Holding,
      Sports_product_holding,
      Cinema_product_holding,
      Original_Product_Holding,
      MS_Count,
      MOBILE,
      SkyQ_Silver,
      Skykids_App,
      ANY_OFFER_FLAG,
      DTV_PRIMARY_VIEWING_OFFER,
      BB_OFFER,
      LR_OFFER,
      MS_OFFER,
      HD_OFFER,
      TENURE,
      TV_REGION,
      TOTAL_PREMIUMS,
      TOTAL_SPORTS,
      TOTAL_MOVIES,
      -------------------------------------------------------------------------------------------------
      COUNT() as NUMBER_OF_ACCOUNTS,
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      Sports_OFFER_END_STATUS_LEVEL_1,
      Cinema_OFFER_END_STATUS_LEVEL_1,
      Sports_OFFER_END_STATUS_LEVEL_2,
      Cinema_OFFER_END_STATUS_LEVEL_2,
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
      sum(coalesce(longest_time_in_nf_app,0.0)) as longest_time_in_nf_app_a,
      sum(coalesce(total_nf_app_launches,0.0)) as total_nf_app_launches_a,
      sum(coalesce(total_time_in_nf_app,0.0)) as total_time_in_nf_app,
      sum(case when coalesce(total_nf_app_launches,0.0) > 0 then 1 else 0 end) as Unique_accounts_viewing_nf,
      ((sum(coalesce(longest_time_in_nf_app,0.0)))/(case when(sum(case when coalesce(total_nf_app_launches,0.0) > 0 then 1 else 0 end)) = 0 then 1 else(sum(case when coalesce(total_nf_app_launches,0.0) > 0 then 1 else 0 end)) end)) as avg_longest_time_in_nf_app,
      sum(coalesce(longest_time_in_spotify_app,0.0)) as longest_time_in_spotify_app_a,
      sum(coalesce(total_spotify_app_launches,0.0)) as total_spotify_app_launches_a,
      sum(coalesce(total_time_in_spotify_app,0.0)) as total_time_in_spotify_app,
      sum(case when coalesce(total_spotify_app_launches,0.0) > 0 then 1 else 0 end) as Unique_accounts_viewing_spotify,
      ((sum(coalesce(longest_time_in_spotify_app,0.0)))/(case when(sum(case when coalesce(total_spotify_app_launches,0.0) > 0 then 1 else 0 end)) = 0 then 1 else(sum(case when coalesce(total_spotify_app_launches,0.0) > 0 then 1 else 0 end)) end)) as avg_longest_time_in_spotify_app,
      ala_carte_product_holding,
      sports_complete
      from #ECONOMETRICS_BASE
      group by YEAR_WEEK,
      WEEK_START,
      COUNTRY,
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      DTV,
      BASIC_PACKAGE_HOLDING,
      SKY_KIDS,
      BOX_SETS,
      TOP_TIER,
      MOVIES,
      SPORTS,
      HD_ANY,
      HD_LEGACY,
      HD_BASIC,
      HD_PREMIUM,
      BB_ACTIVE,
      BB_PRODUCT_HOLDING,
      LR,
      talk_product_holding,
      MS_product_holding,
      chelsea_tv,
      mu_tv,
      liverpool_tv,
      skyasia_tv,
      SKY_GO_EXTRA,
      SPOTIFY,
      Netflix,
      Netflix_Product_Holding,
      Sports_product_holding,
      Cinema_product_holding,
      Original_Product_Holding,
      MS_Count,
      MOBILE,
      SkyQ_Silver,
      Skykids_App,
      ANY_OFFER_FLAG,
      DTV_PRIMARY_VIEWING_OFFER,
      BB_OFFER,
      LR_OFFER,
      MS_OFFER,
      HD_OFFER,
      DTV_OFFER_DESCRIPTION,
      BB_OFFER_DESCRIPTION,
      LR_OFFER_DESCRIPTION,
      MS_OFFER_DESCRIPTION,
      HD_OFFER_DESCRIPTION,
      TENURE,
      TV_REGION,
      -- MMC new prems fields ------------------------------------------------------------------------  
      TOTAL_PREMIUMS,
      TOTAL_SPORTS,
      TOTAL_MOVIES,
      -------------------------------------------------------------------------------------------------
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      Sports_OFFER_END_STATUS_LEVEL_1,
      Cinema_OFFER_END_STATUS_LEVEL_1,
      Sports_OFFER_END_STATUS_LEVEL_2,
      Cinema_OFFER_END_STATUS_LEVEL_2,
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
      ala_carte_product_holding,
      sports_complete;
  commit work;
  drop table if exists #ECONOMETRICS_BASE_OFFERS_2;
  select A.YEAR_WEEK,
    A.WEEK_START,
    A.effective_from_dt,
    A.effective_to_dt,
    A.product_holding,
    A.ACCOUNT_NUMBER,
    A.COUNTRY,
    A.DTV,
    A.ORIGINAL,
    A.VARIETY,
    A.FAMILY,
    A.SKYQ,
    A.SKY_ENT,
    A.BASIC_PACKAGE_HOLDING,
    A.SKY_KIDS,
    A.BOX_SETS,
    A.TOP_TIER,
    A.MOVIES,
    A.SPORTS,
    A.HD_ANY,
    A.HD_LEGACY,
    A.HD_BASIC,
    A.HD_PREMIUM,
    A.MULTISCREEN,
    A.MULTISCREEN_VOL,
    A.SKY_GO_EXTRA,
    A.SPOTIFY,
    A.Netflix,
    A.Netflix_Product_Holding,
    A.Sports_product_holding,
    A.Cinema_product_holding,
    A.Original_Product_Holding,
    A.MS_Count,
    A.MOBILE,
    A.SkyQ_Silver,
    A.Skykids_App,
    A.BB_ACTIVE,
    A.BB_PRODUCT_HOLDING,
    A.LR,
    A.talk_product_holding,
    A.MS_product_holding,
    A.chelsea_tv,
    A.mu_tv,
    A.liverpool_tv,
    A.skyasia_tv,
    A.ACTUAL_OFFER_STATUS,
    A.INTENDED_OFFER_STATUS,
    A.ANY_OFFER_FLAG,
    A.DTV_PRIMARY_VIEWING_OFFER,
    A.BB_OFFER,
    A.LR_OFFER,
    A.MS_OFFER,
    A.HD_OFFER,
    A.DTV_OFFER_DESCRIPTION,
    A.BB_OFFER_DESCRIPTION,
    A.LR_OFFER_DESCRIPTION,
    A.MS_OFFER_DESCRIPTION,
    A.HD_OFFER_DESCRIPTION,
    A.TENURE,
    --,A.TENURE_MONTH
    A.SIMPLE_SEGMENT,
    A.TV_REGION,
    A.MOSAIC_UK_GROUP,
    A.PREMS_PRODUCT_COUNT,
    A.SPORTS_PRODUCT_COUNT,
    A.MOVIES_PRODUCT_COUNT,
    A.PREMS_ACTIVE,
    A.SPORTS_ACTIVE,
    A.MOVIES_ACTIVE,
    A.TOTAL_PREMIUMS,
    A.TOTAL_SPORTS,
    A.TOTAL_MOVIES,
    A.PREV_OFFER_START_DT_ANY,
    A.PREV_OFFER_INTENDED_END_DT_ANY,
    A.PREV_OFFER_ACTUAL_END_DT_ANY,
    A.CURR_OFFER_START_DT_ANY,
    A.CURR_OFFER_INTENDED_END_DT_ANY,
    A.CURR_OFFER_ACTUAL_END_DT_ANY,
    A.OFFER_END_STATUS_LEVEL_1,
    A.OFFER_END_STATUS_LEVEL_2,
    A.Sports_OFFER_END_STATUS_LEVEL_1,
    A.Cinema_OFFER_END_STATUS_LEVEL_1,
    A.Sports_OFFER_END_STATUS_LEVEL_2,
    A.Cinema_OFFER_END_STATUS_LEVEL_2,
    A.CURR_OFFER_INTENDED_END_DT_DTV,
    A.CURR_OFFER_INTENDED_END_DT_BB,
    A.CURR_OFFER_INTENDED_END_DT_LR,
    A.CURR_OFFER_INTENDED_END_DT_MS,
    A.CURR_OFFER_INTENDED_END_DT_HD,
    --,contract_status
    A.Basic_Contract_Status_Level_2,
    A.Add_on_Products_Contract_Status_Level_2,
    A.Talk_Contract_Status_Level_2,
    A.BB_Contract_Status_Level_2,
    A.Overall_Contract_Status_Level_2,
    A.Basic_Contract_Status_Level_1,
    A.Add_on_Products_Contract_Status_Level_1,
    A.Talk_Contract_Status_Level_1,
    A.BB_Contract_Status_Level_1,
    A.Overall_Contract_Status_Level_1,
    B.subscription_sub_type as OFFER_SUB_TYPE,
    B.OFFER_ID,
    B.OFFER_DIM_DESCRIPTION as OFFER_DESCRIPTION,
    B.Monthly_Offer_Amount as MONTHLY_OFFER_VALUE,
    DATEDIFF(month,B.Whole_Offer_start_dt_Actual,B.Whole_Offer_end_dt_Actual) as OFFER_DURATION_MTH,
    DATEDIFF(month,B.Whole_Offer_start_dt_Actual,B.Whole_Offer_end_dt_Actual)*B.Monthly_Offer_Amount as TOTAL_OFFER_VALUE,
    case when B.ORIG_PORTFOLIO_OFFER_ID <> '?' then 1 else 0 end as AUTO_TRANSFER_OFFER,
    cast(null as varchar(30)) as OFFER_GIVEAWAY_EVENT, -- *B.CREATED_OFFER_SEGMENT_GROUPED_1
    case when B.Whole_Offer_START_dt_Actual <= (A.WEEK_START+6) and B.Whole_Offer_START_dt_Actual >= A.WEEK_START then
      1 else 0 end as OFFER_START_FLAG,
    case when B.Whole_Offer_end_dt_Actual <= (A.WEEK_START+6) and B.Whole_Offer_end_dt_Actual >= A.WEEK_START then
      1 else 0 end as OFFER_ENDING_FLAG,
    A.longest_time_in_nf_app,
    A.total_nf_app_launches,
    A.total_time_in_nf_app,
    A.longest_time_in_spotify_app,
    A.total_spotify_app_launches,
    A.total_time_in_spotify_app,
    A.ala_carte_product_holding,
    A.sports_complete
    into #ECONOMETRICS_BASE_OFFERS_2
    from #ECONOMETRICS_BASE as A
      left outer join Decisioning.Offers_Software as B
      on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
      and A.WEEK_START <= B.Offer_leg_end_dt_Actual
      and(A.WEEK_START+6) >= B.Offer_leg_START_dt_Actual
      and lower(B.offer_dim_description) not like '%price protect%'
    group by A.YEAR_WEEK,
    A.WEEK_START,
    A.effective_from_dt,
    A.effective_to_dt,
    A.product_holding,
    A.ACCOUNT_NUMBER,
    A.COUNTRY,
    A.DTV,
    A.ORIGINAL,
    A.VARIETY,
    A.FAMILY,
    A.SKYQ,
    A.SKY_ENT,
    A.BASIC_PACKAGE_HOLDING,
    SKY_KIDS,
    BOX_SETS,
    A.TOP_TIER,
    A.MOVIES,
    A.SPORTS,
    A.HD_ANY,
    A.HD_LEGACY,
    A.HD_BASIC,
    A.HD_PREMIUM,
    A.MULTISCREEN,
    A.MULTISCREEN_VOL,
    A.SKY_GO_EXTRA,
    A.SPOTIFY,
    A.Netflix,
    A.Netflix_Product_Holding,
    A.Sports_product_holding,
    A.Cinema_product_holding,
    A.Original_Product_Holding,
    A.MS_Count,
    A.MOBILE,
    A.SkyQ_Silver,
    A.Skykids_App,
    A.BB_ACTIVE,
    A.BB_PRODUCT_HOLDING,
    A.LR,
    A.talk_product_holding,
    A.MS_product_holding,
    A.chelsea_tv,
    A.mu_tv,
    A.liverpool_tv,
    A.skyasia_tv,
    A.ACTUAL_OFFER_STATUS,
    A.INTENDED_OFFER_STATUS,
    A.ANY_OFFER_FLAG,
    A.DTV_PRIMARY_VIEWING_OFFER,
    A.BB_OFFER,
    A.LR_OFFER,
    A.MS_OFFER,
    A.HD_OFFER,
    A.DTV_OFFER_DESCRIPTION,
    A.BB_OFFER_DESCRIPTION,
    A.LR_OFFER_DESCRIPTION,
    A.MS_OFFER_DESCRIPTION,
    A.HD_OFFER_DESCRIPTION,
    A.TENURE,
    --,A.TENURE_MONTH
    A.SIMPLE_SEGMENT,
    A.TV_REGION,
    A.MOSAIC_UK_GROUP,
    A.PREMS_PRODUCT_COUNT,
    A.SPORTS_PRODUCT_COUNT,
    A.MOVIES_PRODUCT_COUNT,
    A.PREMS_ACTIVE,
    A.SPORTS_ACTIVE,
    A.MOVIES_ACTIVE,
    A.TOTAL_PREMIUMS,
    A.TOTAL_SPORTS,
    A.TOTAL_MOVIES,
    A.PREV_OFFER_START_DT_ANY,
    A.PREV_OFFER_INTENDED_END_DT_ANY,
    A.PREV_OFFER_ACTUAL_END_DT_ANY,
    A.CURR_OFFER_START_DT_ANY,
    A.CURR_OFFER_INTENDED_END_DT_ANY,
    A.CURR_OFFER_ACTUAL_END_DT_ANY,
    A.OFFER_END_STATUS_LEVEL_1,
    A.OFFER_END_STATUS_LEVEL_2,
    A.Sports_OFFER_END_STATUS_LEVEL_1,
    A.Cinema_OFFER_END_STATUS_LEVEL_1,
    A.Sports_OFFER_END_STATUS_LEVEL_2,
    A.Cinema_OFFER_END_STATUS_LEVEL_2,
    A.CURR_OFFER_INTENDED_END_DT_DTV,
    A.CURR_OFFER_INTENDED_END_DT_BB,
    A.CURR_OFFER_INTENDED_END_DT_LR,
    A.CURR_OFFER_INTENDED_END_DT_MS,
    A.CURR_OFFER_INTENDED_END_DT_HD,
    B.subscription_sub_type,
    B.OFFER_ID,
    B.OFFER_DIM_DESCRIPTION,
    B.Monthly_Offer_Amount,
    OFFER_DURATION_MTH,
    TOTAL_OFFER_VALUE,
    AUTO_TRANSFER_OFFER,
    OFFER_GIVEAWAY_EVENT,
    OFFER_START_FLAG,
    OFFER_ENDING_FLAG,
    --,contract_status
    A.Basic_Contract_Status_Level_2,
    A.Add_on_Products_Contract_Status_Level_2,
    A.Talk_Contract_Status_Level_2,
    A.BB_Contract_Status_Level_2,
    A.Overall_Contract_Status_Level_2,
    A.Basic_Contract_Status_Level_1,
    A.Add_on_Products_Contract_Status_Level_1,
    A.Talk_Contract_Status_Level_1,
    A.BB_Contract_Status_Level_1,
    A.Overall_Contract_Status_Level_1,
    A.longest_time_in_nf_app,
    A.total_nf_app_launches,
    A.total_time_in_nf_app,
    A.longest_time_in_spotify_app,
    A.total_spotify_app_launches,
    A.total_time_in_spotify_app,
    A.ala_carte_product_holding,
    A.sports_complete;
  commit work;
  delete from Decisioning.ECONOMETRICS_BASE_OFFERS
    where WEEK_START between PERIOD_START and PERIOD_END;
  commit work;
  insert into Decisioning.ECONOMETRICS_BASE_OFFERS
    select YEAR_WEEK,
      WEEK_START,
      COUNTRY,
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      DTV,
      BASIC_PACKAGE_HOLDING,
      SKY_KIDS,
      BOX_SETS,
      TOP_TIER,
      MOVIES,
      SPORTS,
      HD_ANY,
      HD_LEGACY,
      HD_BASIC,
      HD_PREMIUM,
      BB_ACTIVE,
      BB_PRODUCT_HOLDING,
      LR,
      talk_product_holding,
      MS_product_holding,
      chelsea_tv,
      mu_tv,
      liverpool_tv,
      skyasia_tv,
      SKY_GO_EXTRA,
      SPOTIFY,
      Netflix,
      Netflix_Product_Holding,
      Sports_product_holding,
      Cinema_product_holding,
      Original_Product_Holding,
      MS_Count,
      MOBILE,
      SkyQ_Silver,
      Skykids_App,
      OFFER_SUB_TYPE,
      OFFER_DESCRIPTION,
      MONTHLY_OFFER_VALUE,
      OFFER_DURATION_MTH,
      TOTAL_OFFER_VALUE,
      OFFER_GIVEAWAY_EVENT,
      TENURE,
      --,TENURE_MONTH
      TV_REGION,
      -- MMC new prems fields ------------------------------------------------------------------------
      TOTAL_PREMIUMS,
      TOTAL_SPORTS,
      TOTAL_MOVIES,
      ------------------------------------------------------------------------------------------------  
      COUNT() as NUMBER_OF_ACCOUNTS,
      SUM(OFFER_START_FLAG) as NUMBER_OF_ACCOUNTS_OFFER_STARTED,
      SUM(OFFER_ENDING_FLAG) as NUMBER_OF_ACCOUNTS_OFFER_ENDED,
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      Sports_OFFER_END_STATUS_LEVEL_1,
      Cinema_OFFER_END_STATUS_LEVEL_1,
      Sports_OFFER_END_STATUS_LEVEL_2,
      Cinema_OFFER_END_STATUS_LEVEL_2,
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
      sum(coalesce(longest_time_in_nf_app,0.0)) as longest_time_in_nf_app_a,
      sum(coalesce(total_nf_app_launches,0.0)) as total_nf_app_launches_a,
      sum(coalesce(total_time_in_nf_app,0.0)) as total_time_in_nf_app,
      sum(case when coalesce(total_nf_app_launches,0.0) > 0 then 1 else 0 end) as Unique_accounts_viewing_nf,
      ((sum(coalesce(longest_time_in_nf_app,0.0)))/(case when(sum(case when coalesce(total_nf_app_launches,0.0) > 0 then 1 else 0 end)) = 0 then 1 else(sum(case when coalesce(total_nf_app_launches,0.0) > 0 then 1 else 0 end)) end)) as avg_longest_time_in_nf_app,
      sum(coalesce(longest_time_in_spotify_app,0.0)) as longest_time_in_spotify_app_a,
      sum(coalesce(total_spotify_app_launches,0.0)) as total_spotify_app_launches_a,
      sum(coalesce(total_time_in_spotify_app,0.0)) as total_time_in_spotify_app,
      sum(case when coalesce(total_spotify_app_launches,0.0) > 0 then 1 else 0 end) as Unique_accounts_viewing_spotify,
      ((sum(coalesce(longest_time_in_spotify_app,0.0)))/(case when(sum(case when coalesce(total_spotify_app_launches,0.0) > 0 then 1 else 0 end)) = 0 then 1 else(sum(case when coalesce(total_spotify_app_launches,0.0) > 0 then 1 else 0 end)) end)) as avg_longest_time_in_spotify_app,
      ala_carte_product_holding,
      sports_complete
      from #ECONOMETRICS_BASE_OFFERS_2
      where OFFER_ID is not null
      group by YEAR_WEEK,
      WEEK_START,
      COUNTRY,
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      DTV,
      BASIC_PACKAGE_HOLDING,
      SKY_KIDS,
      BOX_SETS,
      TOP_TIER,
      MOVIES,
      SPORTS,
      HD_ANY,
      HD_LEGACY,
      HD_BASIC,
      HD_PREMIUM,
      BB_ACTIVE,
      BB_PRODUCT_HOLDING,
      LR,
      talk_product_holding,
      MS_product_holding,
      chelsea_tv,
      mu_tv,
      liverpool_tv,
      skyasia_tv,
      SKY_GO_EXTRA,
      SPOTIFY,
      Netflix,
      Netflix_Product_Holding,
      Sports_product_holding,
      Cinema_product_holding,
      Original_Product_Holding,
      MS_Count,
      MOBILE,
      SkyQ_Silver,
      Skykids_App,
      OFFER_SUB_TYPE,
      OFFER_DESCRIPTION,
      MONTHLY_OFFER_VALUE,
      OFFER_DURATION_MTH,
      TOTAL_OFFER_VALUE,
      OFFER_GIVEAWAY_EVENT,
      TENURE,
      -- ,TENURE_MONTH
      TV_REGION,
      -- MMC new prems fields ------------------------------------------------------------------------
      TOTAL_PREMIUMS,
      TOTAL_SPORTS,
      TOTAL_MOVIES,
      ------------------------------------------------------------------------------------------------
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      Sports_OFFER_END_STATUS_LEVEL_1,
      Cinema_OFFER_END_STATUS_LEVEL_1,
      Sports_OFFER_END_STATUS_LEVEL_2,
      Cinema_OFFER_END_STATUS_LEVEL_2,
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
      ala_carte_product_holding,
      sports_complete;
  commit work;
  -- CREATE SUMMARY OF ALL OFFERS STARTED AND UPDATE HOLDINGS TO BE AT END OF WEEK
  drop table if exists #ECONOMETRICS_BASE_OFFERS_STARTED_1;
  select *
    into #ECONOMETRICS_BASE_OFFERS_STARTED_1
    from #ECONOMETRICS_BASE_OFFERS_2
    where OFFER_START_FLAG = 1;
  commit work;
  create hg index idx_3 on #ECONOMETRICS_BASE_OFFERS_STARTED_1(ACCOUNT_NUMBER);
  create date index idx_4 on #ECONOMETRICS_BASE_OFFERS_STARTED_1(WEEK_START);
  -- Drop temp tables
  drop table if exists #ECONOMETRICS_BASE_OFFERS_2;
  commit work;
  -- UPDATE HOLDINGS TO END OF THE WEEK
  update #ECONOMETRICS_BASE_OFFERS_STARTED_1 as A
    set A.DTV = B.DTV,
    A.ORIGINAL = B.ORIGINAL,
    A.VARIETY = B.VARIETY,
    A.FAMILY = B.FAMILY,
    A.SKYQ = B.SKYQ,
    A.SKY_ENT = B.SKY_ENT,
    A.BASIC_PACKAGE_HOLDING = case when B.ORIGINAL > 0 then 'ORIGINAL'
    when B.VARIETY > 0 then 'VARIETY'
    when B.FAMILY > 0 then 'FAMILY'
    when B.SKYQ > 0 then 'SKYQ'
    when B.SKY_ENT > 0 then 'SKY_ENT'
    else ''
    end,A.SKY_KIDS = B.SKY_KIDS,
    A.BOX_SETS = B.BOX_SETS,
    A.TOP_TIER = B.TOP_TIER,
    A.MOVIES = B.MOVIES,
    A.SPORTS = B.SPORTS,
    A.HD_ANY = B.HD_ANY,
    A.HD_LEGACY = B.HD_LEGACY,
    A.HD_BASIC = B.HD_BASIC,
    A.HD_PREMIUM = B.HD_PREMIUM,
    A.SKY_GO_EXTRA = B.SKY_GO_EXTRA,
    A.SPOTIFY = B.SPOTIFY,
    A.Netflix = B.Netflix,
    A.Netflix_Product_Holding = B.Netflix_Product_Holding,
    A.LR = B.LR,
    A.talk_product_holding = B.talk_product_holding,
    A.MS_product_holding = B.MS_product_holding,
    A.Sports_product_holding = B.Sports_product_holding,
    A.Cinema_product_holding = B.Cinema_product_holding,
    A.Original_Product_Holding = b.Original_Product_Holding,
    A.MS_Count = B.MS_Count,
    A.MOBILE = B.MOBILE,
    A.SkyQ_Silver = B.SkyQ_Silver,
    A.Skykids_App = B.Skykids_App,
    A.chelsea_tv = B.chelsea_tv,
    A.mu_tv = B.mu_tv,
    A.liverpool_tv = B.liverpool_tv,
    A.skyasia_tv = B.skyasia_tv,
    A.ala_carte_product_holding = B.ala_carte_product_holding,
    A.sports_complete = B.sports_complete from
    #ECONOMETRICS_BASE_OFFERS_STARTED_1 as A
    join #ASR_ECON as B
    on A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
    and(A.WEEK_START+6) >= B.EFFECTIVE_FROM_DT
    and(A.WEEK_START+6) < B.EFFECTIVE_TO_DT;
  commit work;
  delete from Decisioning.ECONOMETRICS_BASE_OFFERS_STARTED
    where WEEK_START between PERIOD_START and PERIOD_END;
  commit work;
  insert into Decisioning.ECONOMETRICS_BASE_OFFERS_STARTED
    select YEAR_WEEK,
      WEEK_START,
      COUNTRY,
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      DTV,
      BASIC_PACKAGE_HOLDING,
      SKY_KIDS,
      BOX_SETS,
      TOP_TIER,
      MOVIES,
      SPORTS,
      HD_ANY,
      HD_LEGACY,
      HD_BASIC,
      HD_PREMIUM,
      BB_ACTIVE,
      BB_PRODUCT_HOLDING,
      LR,
      talk_product_holding,
      MS_product_holding,
      chelsea_tv,
      mu_tv,
      liverpool_tv,
      skyasia_tv,
      SKY_GO_EXTRA,
      SPOTIFY,
      Netflix,
      Netflix_Product_Holding,
      Sports_product_holding,
      Cinema_product_holding,
      Original_Product_Holding,
      MS_Count,
      MOBILE,
      SkyQ_Silver,
      Skykids_App,
      OFFER_SUB_TYPE,
      OFFER_DESCRIPTION,
      MONTHLY_OFFER_VALUE,
      OFFER_DURATION_MTH,
      TOTAL_OFFER_VALUE,
      OFFER_GIVEAWAY_EVENT,
      TENURE,
      TV_REGION,
      TOTAL_PREMIUMS,
      TOTAL_SPORTS,
      TOTAL_MOVIES,
      ------------------------------------------------------------------------------------------------
      SUM(OFFER_START_FLAG) as NUMBER_OF_ACCOUNTS_OFFER_STARTED,
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      Sports_OFFER_END_STATUS_LEVEL_1,
      Cinema_OFFER_END_STATUS_LEVEL_1,
      Sports_OFFER_END_STATUS_LEVEL_2,
      Cinema_OFFER_END_STATUS_LEVEL_2,
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
      sum(coalesce(longest_time_in_nf_app,0.0)) as longest_time_in_nf_app_a,
      sum(coalesce(total_nf_app_launches,0.0)) as total_nf_app_launches_a,
      sum(coalesce(total_time_in_nf_app,0.0)) as total_time_in_nf_app,
      sum(case when coalesce(total_nf_app_launches,0.0) > 0 then 1 else 0 end) as Unique_accounts_viewing_nf,
      ((sum(coalesce(longest_time_in_nf_app,0.0)))/(case when(sum(case when coalesce(total_nf_app_launches,0.0) > 0 then 1 else 0 end)) = 0 then 1 else(sum(case when coalesce(total_nf_app_launches,0.0) > 0 then 1 else 0 end)) end)) as avg_longest_time_in_nf_app,
      sum(coalesce(longest_time_in_spotify_app,0.0)) as longest_time_in_spotify_app_a,
      sum(coalesce(total_spotify_app_launches,0.0)) as total_spotify_app_launches_a,
      sum(coalesce(total_time_in_spotify_app,0.0)) as total_time_in_spotify_app,
      sum(case when coalesce(total_spotify_app_launches,0.0) > 0 then 1 else 0 end) as Unique_accounts_viewing_spotify,
      ((sum(coalesce(longest_time_in_spotify_app,0.0)))/(case when(sum(case when coalesce(total_spotify_app_launches,0.0) > 0 then 1 else 0 end)) = 0 then 1 else(sum(case when coalesce(total_spotify_app_launches,0.0) > 0 then 1 else 0 end)) end)) as avg_longest_time_in_spotify_app,
      ala_carte_product_holding,
      sports_complete
      from #ECONOMETRICS_BASE_OFFERS_STARTED_1
      where OFFER_ID is not null
      group by YEAR_WEEK,
      WEEK_START,
      COUNTRY,
      ACTUAL_OFFER_STATUS,
      INTENDED_OFFER_STATUS,
      DTV,
      BASIC_PACKAGE_HOLDING,
      SKY_KIDS,
      BOX_SETS,
      TOP_TIER,
      MOVIES,
      SPORTS,
      HD_ANY,
      HD_LEGACY,
      HD_BASIC,
      HD_PREMIUM,
      BB_ACTIVE,
      BB_PRODUCT_HOLDING,
      LR,
      talk_product_holding,
      MS_product_holding,
      chelsea_tv,
      mu_tv,
      liverpool_tv,
      skyasia_tv,
      SKY_GO_EXTRA,
      SPOTIFY,
      Netflix,
      Netflix_Product_Holding,
      Sports_product_holding,
      Cinema_product_holding,
      Original_Product_Holding,
      MS_Count,
      MOBILE,
      SkyQ_Silver,
      Skykids_App,
      OFFER_SUB_TYPE,
      OFFER_DESCRIPTION,
      MONTHLY_OFFER_VALUE,
      OFFER_DURATION_MTH,
      TOTAL_OFFER_VALUE,
      OFFER_GIVEAWAY_EVENT,
      TENURE,
      TV_REGION,
      -- MMC new prems fields ------------------------------------------------------------------------
      TOTAL_PREMIUMS,
      TOTAL_SPORTS,
      TOTAL_MOVIES,
      ------------------------------------------------------------------------------------------------
      Offer_End_Status_Level_1,
      Offer_End_Status_Level_2,
      Sports_OFFER_END_STATUS_LEVEL_1,
      Cinema_OFFER_END_STATUS_LEVEL_1,
      Sports_OFFER_END_STATUS_LEVEL_2,
      Cinema_OFFER_END_STATUS_LEVEL_2,
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
      ala_carte_product_holding,
      sports_complete;
  commit work
end

GO
GRANT EXECUTE ON Decisioning_Procs.Update_Econometrics_BaseProfiles TO public;


/*

CALL Decisioning_Procs.Update_Econometrics_BaseProfiles(today()-20,today());
*/

/* create view in CITeam 
call DBA.sp_DDL ('drop', 'view', 'CITeam', 'ECONOMETRICS_BASE');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'ECONOMETRICS_BASE',  'select * from Decisioning.ECONOMETRICS_BASE');

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'ECONOMETRICS_BASE_OFFERS');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'ECONOMETRICS_BASE_OFFERS',  'select * from Decisioning.ECONOMETRICS_BASE_OFFERS');

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'ECONOMETRICS_BASE_OFFERS_STARTED');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'ECONOMETRICS_BASE_OFFERS_STARTED',  'select * from Decisioning.ECONOMETRICS_BASE_OFFERS_STARTED');

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'ECONOMETRICS_BASE_ACCOUNT_LEVEL');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'ECONOMETRICS_BASE_ACCOUNT_LEVEL',  'select * from Decisioning.ECONOMETRICS_BASE_ACCOUNT_LEVEL');


*/