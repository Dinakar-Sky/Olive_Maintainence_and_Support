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
***************************************************************************************************************************************************************

-----------------------------------------------------------------------DDLS------------------------------------------------------------------------------------
dba.sp_drop_table 'Decisioning','ECONOMETRICS_BASE_BETA'
dba.sp_create_table 'Decisioning','ECONOMETRICS_BASE_BETA',
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
|| ' SPOTIFY INT DEFAULT NULL, '
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

|| ' BASIC_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' PREMIUM_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' BB_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' LR_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' BASIC_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' PREMIUM_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' BB_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' LR_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '

|| ' Basic_Contract_Status_Level_2 varchar(30) default null,'
|| ' Add_on_Products_Contract_Status_Level_2 varchar(30) default null,'
|| ' Talk_Contract_Status_Level_2 varchar(30) default null,'
|| ' BB_Contract_Status_Level_2 varchar(30) default null,'
|| ' Basic_Contract_Status_Level_1 varchar(30) default null,'
|| ' Add_on_Products_Contract_Status_Level_1 varchar(30) default null,'
|| ' Talk_Contract_Status_Level_1 varchar(30) default null,'
|| ' BB_Contract_Status_Level_1 varchar(30) default null'


dba.sp_drop_table 'Decisioning','ECONOMETRICS_BASE_OFFERS_BETA'
dba.sp_create_table 'Decisioning','ECONOMETRICS_BASE_OFFERS_BETA',
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
|| ' SPOTIFY INT DEFAULT NULL, '
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

|| ' BASIC_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' PREMIUM_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' BB_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' LR_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' BASIC_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' PREMIUM_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' BB_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' LR_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '

|| ' Basic_Contract_Status_Level_2 varchar(30) default null,'
|| ' Add_on_Products_Contract_Status_Level_2 varchar(30) default null,'
|| ' Talk_Contract_Status_Level_2 varchar(30) default null,'
|| ' BB_Contract_Status_Level_2 varchar(30) default null,'
|| ' Basic_Contract_Status_Level_1 varchar(30) default null,'
|| ' Add_on_Products_Contract_Status_Level_1 varchar(30) default null,'
|| ' Talk_Contract_Status_Level_1 varchar(30) default null,'
|| ' BB_Contract_Status_Level_1 varchar(30) default null'


dba.sp_drop_table 'Decisioning','ECONOMETRICS_BASE_OFFERS_STARTED_BETA'
dba.sp_create_table 'Decisioning','ECONOMETRICS_BASE_OFFERS_STARTED_BETA',
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
|| ' SPOTIFY INT DEFAULT NULL, '
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

|| ' BASIC_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' PREMIUM_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' BB_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' LR_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' BASIC_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' PREMIUM_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' BB_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' LR_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '

|| ' Basic_Contract_Status_Level_2 varchar(30) default null,'
|| ' Add_on_Products_Contract_Status_Level_2 varchar(30) default null,'
|| ' Talk_Contract_Status_Level_2 varchar(30) default null,'
|| ' BB_Contract_Status_Level_2 varchar(30) default null,'
|| ' Basic_Contract_Status_Level_1 varchar(30) default null,'
|| ' Add_on_Products_Contract_Status_Level_1 varchar(30) default null,'
|| ' Talk_Contract_Status_Level_1 varchar(30) default null,'
|| ' BB_Contract_Status_Level_1 varchar(30) default null'


dba.sp_drop_table 'Decisioning','ECONOMETRICS_BASE_ACCOUNT_LEVEL_BETA'
dba.sp_create_table 'Decisioning','ECONOMETRICS_BASE_ACCOUNT_LEVEL_BETA',
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
|| ' SPOTIFY INT DEFAULT NULL, '
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

|| ' BASIC_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' PREMIUM_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' BB_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' LR_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 VARCHAR(30) DEFAULT NULL, '
|| ' BASIC_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' PREMIUM_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' BB_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' LR_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '
|| ' ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 VARCHAR(30) DEFAULT NULL, '

|| ' Basic_Contract_Status_Level_2 varchar(30) default null,'
|| ' Add_on_Products_Contract_Status_Level_2 varchar(30) default null,'
|| ' Talk_Contract_Status_Level_2 varchar(30) default null,'
|| ' BB_Contract_Status_Level_2 varchar(30) default null,'
|| ' Basic_Contract_Status_Level_1 varchar(30) default null,'
|| ' Add_on_Products_Contract_Status_Level_1 varchar(30) default null,'
|| ' Talk_Contract_Status_Level_1 varchar(30) default null,'
|| ' BB_Contract_Status_Level_1 varchar(30) default null'
*/

--setuser Decisioning_Procs
--GO
DROP PROCEDURE IF EXISTS apa83.Update_Econometrics_BaseProfiles_beta;
--GO
CREATE PROCEDURE apa83.Update_Econometrics_BaseProfiles_beta( PERIOD_START DATE DEFAULT NULL,PERIOD_END DATE DEFAULT NULL)
SQL SECURITY INVOKER 
BEGIN

---------------------------------------------------------------------------------------------------------------------
--CREATE VARIABLES
---------------------------------------------------------------------------------------------------------------------
SET OPTIONS Query_Temp_Space_Limit = 0;

IF PERIOD_START IS NULL THEN
	SET PERIOD_START = ( SELECT max(week_start) - 4 * 7 FROM Decisioning.ECONOMETRICS_BASE_BETA);
END IF ;

IF PERIOD_END IS NULL THEN
	SET PERIOD_END = today();
END IF ;

/*
create or replace variable PERIOD_START date;
create or replace variable PERIOD_END date;
SET PERIOD_START = '2016-01-01';
SET PERIOD_END = '2016-01-01';
*/

-- Get week ends
DROP TABLE IF EXISTS #weeks;

select right(cast(subs_year as varchar),2)||'/'||right(cast(subs_year+1 as varchar),2)
                ||'-'||case when subs_week_of_year <10 then '0'||cast(subs_week_of_year as varchar) else cast(subs_week_of_year as varchar) end
                AS year_week,
                CAST (min(calendar_date) AS DATE) as WEEK_START
into            #weeks
from            sky_calendar cal

where           calendar_date>=PERIOD_START
                and calendar_date<=PERIOD_END
group by        year_week;


-- Create replica of active subscriber report for DTV and BB only 
select B.*
INTO #dtv
from CITeam.Active_subscriber_report B
where  B.dtv_Active_subscription = 1 ;

select A.*,B.*
into #DTV_WITH_WEEK 
FROM #WEEKS A
LEFT JOIN
#dtv B
ON A.WEEK_START>=B.effective_from_dt
AND A.WEEK_START<B.effective_to_dt
;

SELECT  
         YEAR_WEEK
        ,WEEK_START 
        ,B.ACCOUNT_NUMBER
        ,B.effective_from_dt
        ,B.effective_to_dt
        ,B.COUNTRY
        ,B.subscription_id
        ,B.DTV_ACTIVE_SUBSCRIPTION AS DTV
        ,case when B.PRODUCT_HOLDING like '%Original%' then 1 else 0 END as ORIGINAL
        ,case when B.PRODUCT_HOLDING like '%Variety%' then 1 else 0 END as VARIETY
        ,case when B.PRODUCT_HOLDING like '%Box Sets%' then 1 else 0 END as FAMILY
        ,case when B.PRODUCT_HOLDING like '%Sky Q%' then 1 else 0 END as  SKYQ
        ,case when B.PRODUCT_HOLDING like '%Sky Entertainment%' then 1 else 0 END as SKY_ENT
        ,B.TT_Active_Subscription as TOP_TIER
        ,B.movies_Active_subscription as MOVIES
        ,B.sports_Active_subscription as SPORTS
        ,B.HD_active_subscription as HD_ANY
        ,B.HD_active_subscription as  HD_LEGACY
        ,CAST(NULL AS varchar(50)) HD_BASIC
        ,CAST(NULL AS INTEGER) as HD_PREMIUM
        ,B.MS_active_subscription as MULTISCREEN
        ,NULL as MULTISCREEN_VOL
        ,B.SGE_Active_subscription as SKY_GO_EXTRA
        ,B.Spotify_Active_Subscription SPotify
        -- Rose Fields 
        ,Cast(0 as tinyint) as SKY_KIDS
        ,Cast(0 as tinyint) as BOX_SETS
        -- END 
        ,B.product_holding
        ,B.LR_ACTIVE_SUBSCRIPTION AS LR
        ,CAST(NULL AS varchar(50)) talk_product_holding
        ,CAST(NULL AS varchar(50)) as MS_product_holding
		,CAST(0 AS tinyint) chelsea_tv
		,CAST(0 AS tinyint) mu_tv
		,CAST(0 AS tinyint) liverpool_tv
		,CAST(0 AS tinyint) skyasia_tv
        ,CAST(NULL AS varchar(50)) as Sports_product_holding
        ,CAST(NULL AS varchar(50)) as Cinema_product_holding
        ,CAST(NULL AS varchar(50)) as Original_Product_Holding
        ,CAST(0 AS INTEGER) as MS_Count
        ,CAST(0 AS INTEGER) as MOBILE
        ,CAST(0 AS INTEGER) SkyQ_Silver
        ,CAST(0 AS INTEGER) Skykids_App
        -- contract status
        --,Cast(null as varchar(30)) as contract_status
            ,Cast('No Contract' as varchar(100)) as Basic_Contract_Status_Level_2
            ,Cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_2
            ,Cast('No Contract' as varchar(100)) as Talk_Contract_Status_Level_2
            ,Cast('No Contract' as varchar(100)) as BB_Contract_Status_Level_2

            ,Cast('No Contract' as varchar(100)) as Basic_Contract_Status_Level_1
            ,Cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_1
            ,Cast('No Contract' as varchar(100)) as Talk_Contract_Status_Level_1
            ,Cast('No Contract' as varchar(100)) as BB_Contract_Status_Level_1
        
into #ASR_ECON_ONE
FROM #DTV_WITH_WEEK B;



-- Calculate only bb customers 
select asr.*
into #bb 
from CITeam.active_subscriber_report asr
where asr.bb_Active_subscription = 1;

select A.*,B.*
into #bb_only_econ 
FROM #WEEKS A
LEFT JOIN
#bb B
ON A.WEEK_START>=B.effective_from_dt
AND A.WEEK_START<B.effective_to_dt
where B.bb_Active_subscription = 1
;

update #bb_only_econ base
set base.dtv_active_subscription  = asr.dtv_active_subscription 
from #bb_only_econ base
inner join CITeam.active_subscriber_report asr
on base.account_number = asr.account_number 
where base.week_start between asr.effective_from_dt and asr.effective_to_dt - 1 and asr.dtv_active_subscription =1;

delete from #bb_only_econ where dtv_active_subscription=1;

SELECT  
        
         YEAR_WEEK
        ,WEEK_START 
        ,B.ACCOUNT_NUMBER
        ,B.effective_from_dt
        ,B.effective_to_dt
        ,B.COUNTRY
        ,B.subscription_id
        ,B.DTV_ACTIVE_SUBSCRIPTION AS DTV
        ,case when B.PRODUCT_HOLDING like '%Original%' then 1 else 0 END as ORIGINAL
        ,case when B.PRODUCT_HOLDING like '%Variety%' then 1 else 0 END as VARIETY
        ,case when B.PRODUCT_HOLDING like '%Box Sets%' then 1 else 0 END as FAMILY
        ,case when B.PRODUCT_HOLDING like '%Sky Q%' then 1 else 0 END as  SKYQ
        ,case when B.PRODUCT_HOLDING like '%Sky Entertainment%' then 1 else 0  END as SKY_ENT
        ,B.TT_Active_Subscription as TOP_TIER
        ,B.movies_Active_subscription as MOVIES
        ,B.sports_Active_subscription as SPORTS
        ,B.HD_active_subscription as HD_ANY
        ,B.HD_active_subscription as  HD_LEGACY
        ,CAST(NULL AS varchar(50)) HD_BASIC
        ,CAST(NULL AS INTEGER) as HD_PREMIUM
        ,B.MS_active_subscription as MULTISCREEN
        ,NULL as MULTISCREEN_VOL
        ,B.SGE_Active_subscription as SKY_GO_EXTRA
        ,B.Spotify_Active_Subscription SPotify
        -- Rose Fields 
        ,Cast(0 as tinyint) as SKY_KIDS
        ,Cast(0 as tinyint) as BOX_SETS
        -- END 
        ,B.product_holding
        ,B.LR_ACTIVE_SUBSCRIPTION AS LR
        ,CAST(NULL AS varchar(50)) talk_product_holding
        ,CAST(NULL AS varchar(50)) as MS_product_holding
        ,CAST(0 AS tinyint) chelsea_tv
		,CAST(0 AS tinyint) mu_tv
		,CAST(0 AS tinyint) liverpool_tv
		,CAST(0 AS tinyint) skyasia_tv
        ,CAST(NULL AS varchar(50)) as Sports_product_holding
        ,CAST(NULL AS varchar(50)) as Cinema_product_holding
        ,CAST(NULL AS varchar(50)) as Original_Product_Holding
        ,CAST(0 AS INTEGER) as MS_Count
        ,CAST(0 AS INTEGER) as MOBILE
        ,CAST(0 AS INTEGER) SkyQ_Silver
        ,CAST(0 AS INTEGER) Skykids_App
        -- contract status
        --,Cast(null as varchar(30)) as contract_status
            ,Cast('No Contract' as varchar(100)) as Basic_Contract_Status_Level_2
            ,Cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_2
            ,Cast('No Contract' as varchar(100)) as Talk_Contract_Status_Level_2
            ,Cast('No Contract' as varchar(100)) as BB_Contract_Status_Level_2

            ,Cast('No Contract' as varchar(100)) as Basic_Contract_Status_Level_1
            ,Cast('No Contract' as varchar(100)) as Add_on_Products_Contract_Status_Level_1
            ,Cast('No Contract' as varchar(100)) as Talk_Contract_Status_Level_1
            ,Cast('No Contract' as varchar(100)) as BB_Contract_Status_Level_1
INTO #ASR_ECON_TWO
from #bb_only_econ B
;


select Base.*
into #ASR_ECON
from 
(select E_Base.* from #ASR_ECON_ONE E_Base
 union select E_Base.* from #ASR_ECON_TWO E_Base) Base
;

-- update contract 
select account_number,subscription_id,subscription_type,cast(start_date_new as date) as status_start_date,cast(end_date_new as date) as status_end_date,Contract_status 
INTO #Contracts
from(
select account_number,subscription_id,subscription_type,actual_contract_end_date+1 as start_date_new,coalesce( ( lead(start_date)  over (order by account_number,subscription_id,start_date) -1 ),'9999-09-09') as end_date_new,'Out Of Contract' as contract_status from decisioning.contracts 
UNION ALL
SELECT account_number,subscription_id,subscription_type,(max(actual_contract_end_date)+1) as start_date_new,'9999-09-09' as end_date_new,'Out Of Contract' as contract_status from decisioning.contracts group by account_number,subscription_id,subscription_type
UNION ALL 
select account_number,subscription_id,subscription_type,start_date as start_date_new,actual_contract_end_date as end_Date_new,'In Contract' as contract_status from decisioning.contracts 
)a
where start_date_new <= end_date_new;
---new
update #ASR_ECON base
set base.Basic_Contract_Status_Level_2 =CASE WHEN ctr.contract_status = 'In Contract' 
                                               THEN 
                                                CASE when ctr.status_end_date between (week_start   ) and (week_start + 7)   then 'Contract Ending in Next 1 Wks'
                                                     when ctr.status_end_date between (week_start + 8) and (week_start + 14)  then 'Contract Ending in Next 2-3 Wks'
                                                     when ctr.status_end_date between (week_start + 15) and (week_start + 21) then 'Contract Ending in Next 2-3 Wks'
                                                     when ctr.status_end_date between (week_start + 22) and (week_start + 28) then 'Contract Ending in Next 4-6 Wks'
                                                     when ctr.status_end_date between (week_start + 29) and (week_start + 35) then 'Contract Ending in Next 4-6 Wks'
                                                     when ctr.status_end_date between (week_start + 36) and (week_start + 42) then 'Contract Ending in Next 4-6 Wks'
                                                     when ctr.status_end_date between (week_start + 43) and (week_start + 49) then 'Contract Ending in Next 7-8 Wks'
                                                     when ctr.status_end_date between (week_start + 50) and (week_start + 56) then 'Contract Ending in Next 7-8 Wks'
                                                     when ctr.status_end_date > (week_start + 56)                           then 'Contract Ending in 9+ Wks'
                                                     else 'No Contract' END
                                              WHEN ctr.contract_status = 'Out Of Contract'
                                                THEN
                                                CASE when ctr.status_start_date-1 between (week_start - 7) and (week_start  -1 )  then 'Contract Ended in last 1 Wks'
                                                     when ctr.status_start_date-1 between (week_start - 14) and (week_start - 8)  then 'Contract Ended in last 2-3 Wks'
                                                     when ctr.status_start_date-1 between (week_start - 21) and (week_start - 15) then 'Contract Ended in last 2-3 Wks'
                                                     when ctr.status_start_date-1 between (week_start - 28) and (week_start - 22) then 'Contract Ended in last 4-6 Wks'
                                                     when ctr.status_start_date-1 between (week_start - 35) and (week_start - 29) then 'Contract Ended in last 4-6 Wks'
                                                     when ctr.status_start_date-1 between (week_start - 42) and (week_start - 36) then 'Contract Ended in last 4-6 Wks'
                                                     when ctr.status_start_date-1 between (week_start + 43) and (week_start + 49) then 'Contract Ended in last 7-8 Wks'
                                                     when ctr.status_start_date-1 between (week_start + 50) and (week_start + 56) then 'Contract Ended in last 7-8 Wks'
                                                     when ctr.status_start_date-1 < (week_start - 56) --then 'Contract Ended 8+ Wks'
                                                     THEN  'No Contract' ELSE 'No Contract' END
                                                     ELSE 'No Contract'
                                        END 
from #ASR_ECON base
left join #Contracts ctr
on base.account_number =ctr.account_number 
--and base.subscription_id = ctr.subscription_id
and base.week_start between ctr.status_start_date and ctr.status_end_date 
where ctr.contract_status in ('In Contract','Out Of Contract') and subscription_type in('Primary DTV');

update #ASR_ECON base
set base.Add_on_Products_Contract_Status_Level_2 = CASE WHEN ctr.contract_status = 'In Contract' 
                                               THEN 
                                                CASE when ctr.status_end_date between (week_start   ) and (week_start + 7)   then 'Contract Ending in Next 1 Wks'
                                                     when ctr.status_end_date between (week_start + 8) and (week_start + 14)  then 'Contract Ending in Next 2-3 Wks'
                                                     when ctr.status_end_date between (week_start + 15) and (week_start + 21) then 'Contract Ending in Next 2-3 Wks'
                                                     when ctr.status_end_date between (week_start + 22) and (week_start + 28) then 'Contract Ending in Next 4-6 Wks'
                                                     when ctr.status_end_date between (week_start + 29) and (week_start + 35) then 'Contract Ending in Next 4-6 Wks'
                                                     when ctr.status_end_date between (week_start + 36) and (week_start + 42) then 'Contract Ending in Next 4-6 Wks'
                                                     when ctr.status_end_date between (week_start + 43) and (week_start + 49) then 'Contract Ending in Next 7-8 Wks'
                                                     when ctr.status_end_date between (week_start + 50) and (week_start + 56) then 'Contract Ending in Next 7-8 Wks'
                                                     when ctr.status_end_date > (week_start + 56)                           then 'Contract Ending in 9+ Wks'
                                                     else 'No Contract' END
                                              WHEN ctr.contract_status = 'Out Of Contract'
                                                THEN
                                               CASE when ctr.status_start_date-1 between (week_start - 7) and (week_start  -1 )  then 'Contract Ended in last 1 Wks'
                                                     when ctr.status_start_date-1 between (week_start - 14) and (week_start - 8)  then 'Contract Ended in last 2-3 Wks'
                                                     when ctr.status_start_date-1 between (week_start - 21) and (week_start - 15) then 'Contract Ended in last 2-3 Wks'
                                                     when ctr.status_start_date-1 between (week_start - 28) and (week_start - 22) then 'Contract Ended in last 4-6 Wks'
                                                     when ctr.status_start_date-1 between (week_start - 35) and (week_start - 29) then 'Contract Ended in last 4-6 Wks'
                                                     when ctr.status_start_date-1 between (week_start - 42) and (week_start - 36) then 'Contract Ended in last 4-6 Wks'
                                                     when ctr.status_start_date-1 between (week_start + 43) and (week_start + 49) then 'Contract Ended in last 7-8 Wks'
                                                     when ctr.status_start_date-1 between (week_start + 50) and (week_start + 56) then 'Contract Ended in last 7-8 Wks'
                                                     when ctr.status_start_date-1 < (week_start - 56) --then 'Contract Ended 8+ Wks'
                                                     THEN  'No Contract' ELSE 'No Contract' END
                                                     ELSE 'No Contract'
                                        END 
from #ASR_ECON base
left join #Contracts ctr
on base.account_number =ctr.account_number 
--and base.subscription_id = ctr.subscription_id
and base.week_start between ctr.status_start_date and ctr.status_end_date 
where ctr.contract_status in ('In Contract','Out Of Contract') and subscription_type in('Secondary DTV','Sky Enhanced Cap Subs');

update #ASR_ECON base
set base.Talk_Contract_Status_Level_2 =CASE WHEN ctr.contract_status = 'In Contract' 
                                               THEN 
                                                CASE when ctr.status_end_date between (week_start   ) and (week_start + 7)   then 'Contract Ending in Next 1 Wks'
                                                     when ctr.status_end_date between (week_start + 8) and (week_start + 14)  then 'Contract Ending in Next 2-3 Wks'
                                                     when ctr.status_end_date between (week_start + 15) and (week_start + 21) then 'Contract Ending in Next 2-3 Wks'
                                                     when ctr.status_end_date between (week_start + 22) and (week_start + 28) then 'Contract Ending in Next 4-6 Wks'
                                                     when ctr.status_end_date between (week_start + 29) and (week_start + 35) then 'Contract Ending in Next 4-6 Wks'
                                                     when ctr.status_end_date between (week_start + 36) and (week_start + 42) then 'Contract Ending in Next 4-6 Wks'
                                                     when ctr.status_end_date between (week_start + 43) and (week_start + 49) then 'Contract Ending in Next 7-8 Wks'
                                                     when ctr.status_end_date between (week_start + 50) and (week_start + 56) then 'Contract Ending in Next 7-8 Wks'
                                                     when ctr.status_end_date > (week_start + 56)                           then 'Contract Ending in 9+ Wks'
                                                     else 'No Contract' END
                                              WHEN ctr.contract_status = 'Out Of Contract'
                                                THEN
                                                 CASE when ctr.status_start_date-1 between (week_start - 7) and (week_start  -1 )  then 'Contract Ended in last 1 Wks'
                                                     when ctr.status_start_date-1 between (week_start - 14) and (week_start - 8)  then 'Contract Ended in last 2-3 Wks'
                                                     when ctr.status_start_date-1 between (week_start - 21) and (week_start - 15) then 'Contract Ended in last 2-3 Wks'
                                                     when ctr.status_start_date-1 between (week_start - 28) and (week_start - 22) then 'Contract Ended in last 4-6 Wks'
                                                     when ctr.status_start_date-1 between (week_start - 35) and (week_start - 29) then 'Contract Ended in last 4-6 Wks'
                                                     when ctr.status_start_date-1 between (week_start - 42) and (week_start - 36) then 'Contract Ended in last 4-6 Wks'
                                                     when ctr.status_start_date-1 between (week_start + 43) and (week_start + 49) then 'Contract Ended in last 7-8 Wks'
                                                     when ctr.status_start_date-1 between (week_start + 50) and (week_start + 56) then 'Contract Ended in last 7-8 Wks'
                                                     when ctr.status_start_date-1 < (week_start - 56) --then 'Contract Ended 8+ Wks'
                                                     THEN  'No Contract' ELSE 'No Contract' END
                                                     ELSE 'No Contract'
                                        END 
from #ASR_ECON base
left join #Contracts ctr
on base.account_number =ctr.account_number 
--and base.subscription_id = ctr.subscription_id
and base.week_start between ctr.status_start_date and ctr.status_end_date 
where ctr.contract_status in ('In Contract','Out Of Contract') and subscription_type in('Sky Talk');

update #ASR_ECON base
set base.BB_Contract_Status_Level_2 = CASE WHEN ctr.contract_status = 'In Contract' 
                                               THEN 
                                                CASE when ctr.status_end_date between (week_start   ) and (week_start + 7)   then 'Contract Ending in Next 1 Wks'
                                                     when ctr.status_end_date between (week_start + 8) and (week_start + 14)  then 'Contract Ending in Next 2-3 Wks'
                                                     when ctr.status_end_date between (week_start + 15) and (week_start + 21) then 'Contract Ending in Next 2-3 Wks'
                                                     when ctr.status_end_date between (week_start + 22) and (week_start + 28) then 'Contract Ending in Next 4-6 Wks'
                                                     when ctr.status_end_date between (week_start + 29) and (week_start + 35) then 'Contract Ending in Next 4-6 Wks'
                                                     when ctr.status_end_date between (week_start + 36) and (week_start + 42) then 'Contract Ending in Next 4-6 Wks'
                                                     when ctr.status_end_date between (week_start + 43) and (week_start + 49) then 'Contract Ending in Next 7-8 Wks'
                                                     when ctr.status_end_date between (week_start + 50) and (week_start + 56) then 'Contract Ending in Next 7-8 Wks'
                                                     when ctr.status_end_date > (week_start + 56)                           then 'Contract Ending in 9+ Wks'
                                                     else 'No Contract' END
                                              WHEN ctr.contract_status = 'Out Of Contract'
                                                THEN
                                                 CASE when ctr.status_start_date-1 between (week_start - 7) and (week_start  -1 )  then 'Contract Ended in last 1 Wks'
                                                     when ctr.status_start_date-1 between (week_start - 14) and (week_start - 8)  then 'Contract Ended in last 2-3 Wks'
                                                     when ctr.status_start_date-1 between (week_start - 21) and (week_start - 15) then 'Contract Ended in last 2-3 Wks'
                                                     when ctr.status_start_date-1 between (week_start - 28) and (week_start - 22) then 'Contract Ended in last 4-6 Wks'
                                                     when ctr.status_start_date-1 between (week_start - 35) and (week_start - 29) then 'Contract Ended in last 4-6 Wks'
                                                     when ctr.status_start_date-1 between (week_start - 42) and (week_start - 36) then 'Contract Ended in last 4-6 Wks'
                                                     when ctr.status_start_date-1 between (week_start + 43) and (week_start + 49) then 'Contract Ended in last 7-8 Wks'
                                                     when ctr.status_start_date-1 between (week_start + 50) and (week_start + 56) then 'Contract Ended in last 7-8 Wks'
                                                     when ctr.status_start_date-1 < (week_start - 56) --then 'Contract Ended 8+ Wks'
                                                     THEN  'No Contract' ELSE 'No Contract' END
                                                     ELSE 'No Contract'
                                        END 
from #ASR_ECON base
left join #Contracts ctr
on base.account_number =ctr.account_number 
--and base.subscription_id = ctr.subscription_id
and base.week_start between ctr.status_start_date and ctr.status_end_date 
where ctr.contract_status in ('In Contract','Out Of Contract') and subscription_type in('Broadband');

Update #ASR_ECON
Set BB_Contract_Status_Level_1 =
        case when BB_Contract_Status_Level_2 in ('Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
            'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks')
                    then 'Contract End'
             when BB_Contract_Status_Level_2 = 'Contract Ending in 9+ Wks'
                    then 'In-Contract'
             else 'No Contract'
        end;

Update #ASR_ECON
Set Talk_Contract_Status_Level_1 =
        case when Talk_Contract_Status_Level_2 in ('Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
            'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks')
                    then 'Contract End'
             when Talk_Contract_Status_Level_2 = 'Contract Ending in 9+ Wks'
                    then 'In-Contract'
             else 'No Contract'
        end;

Update #ASR_ECON
Set Add_on_Products_Contract_Status_Level_1 =
        case when Add_on_Products_Contract_Status_Level_2 in ('Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
            'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks')
                    then 'Contract End'
             when Add_on_Products_Contract_Status_Level_2 = 'Contract Ending in 9+ Wks'
                    then 'In-Contract'
             else 'No Contract'
        end;

Update #ASR_ECON
Set Basic_Contract_Status_Level_1 =
        case when Basic_Contract_Status_Level_2 in ('Contract Ending in Next 1 Wks','Contract Ending in Next 2-3 Wks','Contract Ending in Next 4-6 Wks','Contract Ending in Next 7-8 Wks','Contract Ended in last 1 Wks',
            'Contract Ended in last 2-3 Wks','Contract Ended in last 4-6 Wks','Contract Ended in last 7-8 Wks')
                    then 'Contract End'
             when Basic_Contract_Status_Level_2 = 'Contract Ending in 9+ Wks'
                    then 'In-Contract'
             else 'No Contract'
        end;



update #ASR_ECON base
set base.top_tier = asr.tt_Active_subscription 
from #ASR_ECON base
inner join CITeam.active_subscriber_report asr
on base.account_number = asr.account_number 
where base.week_start between asr.effective_from_dt and asr.effective_to_dt - 1 and asr.tt_active_subscription =1;


update #ASR_ECON base
set base.movies = asr.movies_Active_subscription 
from #ASR_ECON base
inner join CITeam.active_subscriber_report asr
on base.account_number = asr.account_number 
where base.week_start between asr.effective_from_dt and asr.effective_to_dt - 1 and asr.movies_active_subscription =1;

update #ASR_ECON base
set base.SPORTS = asr.sports_Active_subscription 
from #ASR_ECON base
inner join CITeam.active_subscriber_report asr
on base.account_number = asr.account_number 
where base.week_start between asr.effective_from_dt and asr.effective_to_dt - 1 and asr.sports_active_subscription =1;

update #ASR_ECON base
set base.LR = asr.LR_Active_subscription 
from #ASR_ECON base
inner join CITeam.active_subscriber_report asr
on base.account_number = asr.account_number 
where base.week_start between asr.effective_from_dt and asr.effective_to_dt - 1 and asr.LR_active_subscription =1;

update #ASR_ECON base
SET base.chelsea_tv = 1
from #ASR_ECON base
inner join CITeam.active_subscriber_report asr
on base.account_number = asr.account_number 
where base.week_start between asr.effective_from_dt and asr.effective_to_dt - 1 and asr.Chelsea_TV_Active_Subscription  =1;

update #ASR_ECON base
SET base.mu_tv = 1
from #ASR_ECON base
inner join CITeam.active_subscriber_report asr
on base.account_number = asr.account_number 
where base.week_start between asr.effective_from_dt and asr.effective_to_dt - 1 and asr.MUTV_ACTIVE_SUBSCRIPTION=1;

update #ASR_ECON base
SET base.liverpool_tv = 1
from #ASR_ECON base
inner join CITeam.active_subscriber_report asr
on base.account_number = asr.account_number 
where base.week_start between asr.effective_from_dt and asr.effective_to_dt - 1 and asr.Liverpool_ACTIVE_SUBSCRIPTION=1;

update #ASR_ECON base
SET base.skyasia_tv = 1
from #ASR_ECON base
inner join CITeam.active_subscriber_report asr
on base.account_number = asr.account_number 
where base.week_start between asr.effective_from_dt and asr.effective_to_dt - 1 and asr.SkyAsia_ACTIVE_SUBSCRIPTION=1;

update #ASR_ECON base
SET base.talk_product_holding =  asr.product_holding
from #ASR_ECON base
inner join CITeam.active_subscriber_report asr
on base.account_number = asr.account_number 
where base.week_start between asr.effective_from_dt and asr.effective_to_dt - 1 and asr.talk_active_subscription =1;


update #ASR_ECON base
SET base.MS_product_holding = asr.product_holding 
from #ASR_ECON base
inner join CITeam.active_subscriber_report asr
on base.account_number = asr.account_number 
where base.week_start between asr.effective_from_dt and asr.effective_to_dt - 1 and asr.ms_active_subscription =1;

update #ASR_ECON base
SET base.Sports_product_holding = asr.product_holding 
from #ASR_ECON base
inner join CITeam.active_subscriber_report asr
on base.account_number = asr.account_number 
where base.week_start between asr.effective_from_dt and asr.effective_to_dt - 1 and asr.sports_active_subscription =1;

update #ASR_ECON base
SET base.Cinema_product_holding = asr.product_holding 
from #ASR_ECON base
inner join CITeam.active_subscriber_report asr
on base.account_number = asr.account_number 
where base.week_start between asr.effective_from_dt and asr.effective_to_dt - 1 and asr.movies_active_subscription =1;

update #ASR_ECON base
set base.hd_any = asr.HD_Active_subscription 
,hd_legacy = case when asr.CURRENT_PRODUCT_SK = 687 then 1 else 0 end 
,hd_basic  = case when asr.CURRENT_PRODUCT_SK in(43678) then 'Pre-Rose Package' when asr.CURRENT_PRODUCT_SK in(53103) then 'Post-Rose Package' else 'No Package' end 
,hd_premium = case when asr.CURRENT_PRODUCT_SK = 43679 then 1 else 0 end 
from #ASR_ECON base
inner join CITeam.active_subscriber_report asr
on base.account_number = asr.account_number 
where base.week_start between asr.effective_from_dt and asr.effective_to_dt - 1 and asr.HD_active_subscription =1;


update #ASR_ECON base
set 
base.MS_Count=csh.ms_count
from #ASR_ECON base
inner join (select csh.account_number,csh.effective_from_dt,
    sum(case when lower(csh.subscription_sub_type) = 'dtv extra subscription' then 1 else 0 end) as ms_count 
    from cust_subs_hist csh
            where csh.OWNING_CUST_ACCOUNT_ID  >  '1'
              and csh.SI_LATEST_SRC  = 'CHORD'
              and csh.status_code in('AC','AB','PC')
              and csh.effective_to_dt > csh.effective_from_dt 
            group by csh.account_number,csh.effective_from_dt) csh
on base.account_number=csh.account_number
and base.effective_from_dt=csh.effective_from_dt;



update #ASR_ECON base
set 
base.Original_Product_Holding= csh.CURRENT_PRODUCT_DESCRIPTION
from #ASR_ECON base
inner join cust_subs_hist  csh
on base.account_number=csh.account_number
and base.effective_from_dt=csh.effective_from_dt
where csh.subscription_sub_type = 'DTV Primary Viewing'
        and csh.CURRENT_PRODUCT_DESCRIPTION like 'Original%'
        and csh.OWNING_CUST_ACCOUNT_ID  >  '1'
        and csh.SI_LATEST_SRC  = 'CHORD'
        and status_code in('AC','AB','PC')
        and csh.effective_to_dt > csh.effective_from_dt;

update #ASR_ECON base
set 
base.SkyQ_Silver= 1
from #ASR_ECON base
inner join cust_subs_hist  csh
on base.account_number=csh.account_number
and base.effective_from_dt=csh.effective_from_dt
where csh.current_product_description = 'Sky Q Silver Bundle'
        and csh.OWNING_CUST_ACCOUNT_ID  >  '1'
        and csh.SI_LATEST_SRC  = 'CHORD'
        and status_code in('AC','AB','PC')
        and csh.effective_to_dt > csh.effective_from_dt;


update #ASR_ECON base
set 
base.mobile=  case when mav.mobile>1 then 1 else 0 end 
from #ASR_ECON base
inner join cust_single_account_view sav on base.account_number=sav.account_number 
LEFT OUTER JOIN (select account_number,portfolio_id,account_status_dt,count_of_msisdn_active mobile from CUST_SINGLE_MOBILE_ACCOUNT_VIEW where count_of_msisdn_active > 0 and account_status='ACTIVE' ) MAV 
ON SAV.acct_fo_portfolio_id = MAV.portfolio_id and base.week_start > mav.account_status_dt
WHERE sav.ACCOUNT_NUMBER IS NOT NULL ;



select owning_cust_account_id,ph_subs_hist_sk,subscription_id,account_number,effective_from_dt,effective_to_dt 
into #hd_pack
from cust_subs_hist  csh
where subscription_sub_type in('HD Pack')
and csh.account_number != '99999999999999'
        and csh.OWNING_CUST_ACCOUNT_ID  >  '1'
        and csh.SI_LATEST_SRC  = 'CHORD'
        and status_code in('AC','AB','PC')
        and csh.effective_to_dt > csh.effective_from_dt
        group by owning_cust_account_id,ph_subs_hist_sk,subscription_id,account_number,effective_from_dt,effective_to_dt;

update #ASR_ECON base
set 
hd_premium = 1,hd_Any=1
from #ASR_ECON base
inner join #hd_pack asr
on base.account_number = asr.account_number 
where base.week_start between asr.effective_from_dt and asr.effective_to_dt - 1;


update #ASR_ECON base
set base.MULTISCREEN = asr.ms_Active_subscription 
from #ASR_ECON base
inner join CITeam.active_subscriber_report asr
on base.account_number = asr.account_number 
where base.week_start between asr.effective_from_dt and asr.effective_to_dt - 1 and asr.ms_active_subscription =1;

update #ASR_ECON base
set base.SKY_GO_EXTRA = asr.SGE_Active_subscription 
from #ASR_ECON base
inner join CITeam.active_subscriber_report asr
on base.account_number = asr.account_number 
where base.week_start between asr.effective_from_dt and asr.effective_to_dt - 1 and asr.SGE_active_subscription =1;


update #ASR_ECON base
set base.Spotify = asr.Spotify_Active_Subscription
from #ASR_ECON base
inner join CITeam.active_subscriber_report asr
on base.account_number = asr.account_number 
where base.week_start between asr.effective_from_dt and asr.effective_to_dt - 1 and asr.Spotify_Active_Subscription=1;
-- Rose field update 

update #ASR_ECON base
set base.SKY_KIDS = asr.SKY_KIDS_Active_Subscription 
from #ASR_ECON base
inner join Decisioning.Active_Subscriber_Report_kids_boxset asr
on base.account_number = asr.account_number 
where base.week_start between asr.effective_from_dt and asr.effective_to_dt - 1 and asr.SKY_KIDS_Active_Subscription =1;

update #ASR_ECON base
set base.BOX_SETS = asr.SKY_BOX_SETS_Active_Subscription 
from #ASR_ECON base
inner join Decisioning.Active_Subscriber_Report_kids_boxset asr
on base.account_number = asr.account_number 
where base.week_start between asr.effective_from_dt and asr.effective_to_dt - 1 and asr.SKY_BOX_SETS_Active_Subscription =1;


update #ASR_ECON base
set 
base.skykids_app= 1
from #ASR_ECON base
inner join SAM_REGISTRANT sam on base.account_number=sam.account_number
inner join SKYID_ENTITLEMENT ENTITLEMENT on ENTITLEMENT.samprofileid=sam.samprofileid
where ENTITLEMENT.role_dim_role_code = 'skykids' and base.week_start between ENTITLEMENT.role_date_from and ENTITLEMENT.role_date_to;


SELECT   
         YEAR_WEEK
        ,WEEK_START 
        ,B.ACCOUNT_NUMBER
       -- ,B.subscription_id
        ,B.effective_from_dt
        ,B.effective_to_dt
        ,B.COUNTRY
        ,B.DTV
        ,ORIGINAL
        ,VARIETY
        ,FAMILY
        ,SKYQ
        ,SKY_ENT
        ,CAST(NULL AS VARCHAR(30)) AS BASIC_PACKAGE_HOLDING
        ,SKY_KIDS
        ,BOX_SETS
        ,TOP_TIER
        ,MOVIES
        ,SPORTS
        ,HD_ANY
        ,HD_LEGACY
        ,HD_BASIC
        ,HD_PREMIUM
        ,MULTISCREEN
        ,NULL as MULTISCREEN_VOL
        ,SKY_GO_EXTRA
        ,Spotify
        ,LR
        ,talk_product_holding
        ,MS_product_holding
        ,chelsea_tv
		,mu_tv
		,liverpool_tv
		,skyasia_tv
        ,Sports_product_holding
        ,Cinema_product_holding
        ,Original_Product_Holding
        ,MS_Count
        ,MOBILE
        ,SkyQ_Silver
        ,Skykids_App
        ,product_holding
        --,contract_status
        ,Basic_Contract_Status_Level_2
        ,Add_on_Products_Contract_Status_Level_2
        ,Talk_Contract_Status_Level_2
        ,BB_Contract_Status_Level_2
        ,Basic_Contract_Status_Level_1
        ,Add_on_Products_Contract_Status_Level_1
        ,Talk_Contract_Status_Level_1
        ,BB_Contract_Status_Level_1
        ,Cast(0 as tinyint) as BB_ACTIVE
        ,Cast(null as varchar(80)) as BB_Product_Holding
        ,CAST(NULL AS VARCHAR(15)) AS ACTUAL_OFFER_STATUS
        ,CAST(NULL AS VARCHAR(15)) AS INTENDED_OFFER_STATUS
        ,0 AS ANY_OFFER_FLAG
        ,CAST(NULL AS INTEGER) AS DTV_PRIMARY_VIEWING_OFFER
        ,CAST(NULL AS INTEGER) AS BB_OFFER
        ,CAST(NULL AS INTEGER) AS LR_OFFER
        ,CAST(NULL AS INTEGER) AS MS_OFFER
        ,CAST(NULL AS INTEGER) AS HD_OFFER
        ,CAST(NULL AS VARCHAR(45)) AS DTV_OFFER_DESCRIPTION
        ,CAST(NULL AS VARCHAR(45)) AS BB_OFFER_DESCRIPTION
        ,CAST(NULL AS VARCHAR(45)) AS LR_OFFER_DESCRIPTION
        ,CAST(NULL AS VARCHAR(45)) AS MS_OFFER_DESCRIPTION
        ,CAST(NULL AS VARCHAR(45)) AS HD_OFFER_DESCRIPTION
        ,CAST(NULL AS int) AS TENURE
        --,CAST(NULL AS int) AS TENURE_month
        ,CAST(NULL AS VARCHAR(45)) AS SIMPLE_SEGMENT
        ,CAST(NULL AS VARCHAR(45)) AS TV_REGION
        ,CAST(NULL AS VARCHAR(45)) AS mosaic_uk_group
        -- MMC new prems fields ------------------------------------------------------------------------  
        ,Cast(0 as tinyint) as Prems_Product_Count -- as PRE_ORDER_TOTAL_PREMIUMS -- 0,1,2,3,6 for sport + 0,3 or 6 for cinema 
        ,Cast(0 as tinyint) as Sports_Product_Count -- PRE_ORDER_TOTAL_SPORTS -- 0,1,2,3,6
        ,Cast(0 as tinyint) as Movies_Product_Count -- PRE_ORDER_TOTAL_MOVIES -- 0,3,6

        ,Cast(0 as tinyint) as Prems_Active --as PRE_ORDER_DUAL_SPORTS
        ,Cast(0 as tinyint) as Sports_Active --as PRE_ORDER_DUAL_SPORTS
        ,Cast(0 as tinyint) as Movies_Active --as PRE_ORDER_DUAL_SPORTS

        ,Cast(0 as tinyint) as TOTAL_PREMIUMS
        ,Cast(0 as tinyint) as TOTAL_SPORTS
        ,Cast(0 as tinyint) as TOTAL_MOVIES
        ,Cast(null as date) as Prev_Offer_Start_Dt_Any
        ,Cast(null as date) as Prev_Offer_Intended_end_Dt_Any
        ,Cast(null as date) as Prev_Offer_Actual_End_Dt_Any
        ,Cast(null as date) as Curr_Offer_Start_Dt_Any
        ,Cast(null as date) as Curr_Offer_Intended_end_Dt_Any
        ,Cast(null as date) as Curr_Offer_Actual_End_Dt_Any
        ,Cast(null as varchar(30)) as Offer_End_Status_Level_1
        ,Cast(null as varchar(30)) as Offer_End_Status_Level_2

        ,Cast(null as varchar(30)) as BASIC_OFFER_END_STATUS_LEVEL_1
        ,Cast(null as varchar(30)) as PREMIUM_OFFER_END_STATUS_LEVEL_1
        ,Cast(null as varchar(30)) as BB_OFFER_END_STATUS_LEVEL_1
        ,Cast(null as varchar(30)) as LR_OFFER_END_STATUS_LEVEL_1
        ,Cast(null as varchar(30)) as ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1
        ,Cast(null as varchar(30)) as BASIC_OFFER_END_STATUS_LEVEL_2
        ,Cast(null as varchar(30)) as PREMIUM_OFFER_END_STATUS_LEVEL_2
        ,Cast(null as varchar(30)) as BB_OFFER_END_STATUS_LEVEL_2
        ,Cast(null as varchar(30)) as LR_OFFER_END_STATUS_LEVEL_2
        ,Cast(null as varchar(30)) as ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2

        ,Cast(null as date) as Prev_Offer_Actual_End_Dt_DTV
        ,Cast(null as date) as Curr_Offer_Intended_end_Dt_DTV
        ,Cast(null as date) as Curr_Offer_Intended_end_Dt_PREMS
        ,Cast(null as date) as Prev_Offer_Actual_End_Dt_PREMS
        ,Cast(null as date) as Prev_Offer_Actual_End_Dt_BB
        ,Cast(null as date) as Curr_Offer_Intended_end_Dt_BB
        ,Cast(null as date) as Prev_Offer_Actual_End_Dt_LR
        ,Cast(null as date) as Curr_Offer_Intended_end_Dt_LR
        ,Cast(null as date) as Prev_Offer_Actual_End_Dt_HD
        ,Cast(null as date) as Curr_Offer_Intended_end_Dt_HD
        ,Cast(null as date) as Prev_Offer_Actual_End_Dt_MS
        ,Cast(null as date) as Curr_Offer_Intended_end_Dt_MS
        ,Cast(null as date) as Prev_Offer_Actual_End_Dt_SGE
        ,Cast(null as date) as Curr_Offer_Intended_end_Dt_SGE
        ,Cast(null as date) as Prev_Offer_Actual_End_Dt_ADD_ON
        ,Cast(null as date) as Curr_Offer_Intended_end_Dt_ADD_ON
        ,Cast(null as date) as Prev_Offer_Actual_End_Dt_HD_PACK
        ,Cast(null as date) as Curr_Offer_Intended_end_Dt_HD_PACK
        ,Cast(null as date) as Prev_Offer_Actual_End_Dt_BOX_SETS
        ,Cast(null as date) as Curr_Offer_Intended_end_Dt_BOX_SETS
        ,Cast(null as date) as Prev_Offer_Actual_End_Dt_SKY_KIDS
        ,Cast(null as date) as Curr_Offer_Intended_end_Dt_SKY_KIDS
        ,Cast(null as date) as Prev_Offer_Actual_End_Dt_TALK
        ,Cast(null as date) as Curr_Offer_Intended_end_Dt_TALK
        
        ---------------------------------------------------------------------------------------------------
INTO #ECONOMETRICS_BASE
FROM #ASR_ECON B
;


COMMIT;
create hg index idx_1 on #ECONOMETRICS_BASE(ACCOUNT_NUMBER);
create date index idx_2 on #ECONOMETRICS_BASE(WEEK_START);

-------------------------------------------------------------------------            
Call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','DTV','Ordered','All','Update Only',
            'Prev_Offer_Actual_End_Dt_DTV',
            'Curr_Offer_Intended_end_Dt_DTV'
            );  


Update #ECONOMETRICS_BASE
Set Basic_Offer_End_Status_Level_2 = 
        case when Curr_Offer_Intended_end_Dt_DTV between (WEEK_START + 1) and (WEEK_START + 7)   then 'Offer Ending in Next 1 Wks'
             when Curr_Offer_Intended_end_Dt_DTV between (WEEK_START + 8) and (WEEK_START + 14)  then 'Offer Ending in Next 2-3 Wks'
             when Curr_Offer_Intended_end_Dt_DTV between (WEEK_START + 15) and (WEEK_START + 21) then 'Offer Ending in Next 2-3 Wks'
             when Curr_Offer_Intended_end_Dt_DTV between (WEEK_START + 22) and (WEEK_START + 28) then 'Offer Ending in Next 4-6 Wks'
             when Curr_Offer_Intended_end_Dt_DTV between (WEEK_START + 29) and (WEEK_START + 35) then 'Offer Ending in Next 4-6 Wks'
             when Curr_Offer_Intended_end_Dt_DTV between (WEEK_START + 36) and (WEEK_START + 42) then 'Offer Ending in Next 4-6 Wks'
             when Curr_Offer_Intended_end_Dt_DTV > (WEEK_START + 42)    then 'Offer Ending in 7+ Wks'
             when Prev_Offer_Actual_End_Dt_DTV between (WEEK_START - 7) and WEEK_START         then 'Offer Ended in last 1 Wks'
             when Prev_Offer_Actual_End_Dt_DTV between (WEEK_START - 14) and (WEEK_START - 8)  then 'Offer Ended in last 2-3 Wks'
             when Prev_Offer_Actual_End_Dt_DTV between (WEEK_START - 21) and (WEEK_START - 15) then 'Offer Ended in last 2-3 Wks'
             when Prev_Offer_Actual_End_Dt_DTV between (WEEK_START - 28) and (WEEK_START - 22) then 'Offer Ended in last 4-6 Wks'
             when Prev_Offer_Actual_End_Dt_DTV between (WEEK_START - 35) and (WEEK_START - 29) then 'Offer Ended in last 4-6 Wks'
             when Prev_Offer_Actual_End_Dt_DTV between (WEEK_START - 42) and (WEEK_START - 36) then 'Offer Ended in last 4-6 Wks'
             when Prev_Offer_Actual_End_Dt_DTV < (WEEK_START - 42)  then 'Offer Ended 7+ Wks'
             else 'No Offer'
        end; 

Update #ECONOMETRICS_BASE
Set Basic_Offer_End_Status_Level_1 = 
        case when Basic_Offer_End_Status_Level_2 in ('Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks') 
                    then 'Offer Ending'
             when Basic_Offer_End_Status_Level_2 = 'Offer Ending in 7+ Wks'                           
                    then 'On Offer'
             else 'No Offer'
        end;    


Call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','PREMS','Ordered','All','Update Only',
            'Prev_Offer_Actual_End_Dt_PREMS',
            'Curr_Offer_Intended_end_Dt_PREMS'
            );  

Update #ECONOMETRICS_BASE
Set PREMIUM_Offer_End_Status_Level_2 = 
        case when Curr_Offer_Intended_end_Dt_PREMS between (WEEK_START + 1) and (WEEK_START + 7)   then 'Offer Ending in Next 1 Wks'
             when Curr_Offer_Intended_end_Dt_PREMS between (WEEK_START + 8) and (WEEK_START + 14)  then 'Offer Ending in Next 2-3 Wks'
             when Curr_Offer_Intended_end_Dt_PREMS between (WEEK_START + 15) and (WEEK_START + 21) then 'Offer Ending in Next 2-3 Wks'
             when Curr_Offer_Intended_end_Dt_PREMS between (WEEK_START + 22) and (WEEK_START + 28) then 'Offer Ending in Next 4-6 Wks'
             when Curr_Offer_Intended_end_Dt_PREMS between (WEEK_START + 29) and (WEEK_START + 35) then 'Offer Ending in Next 4-6 Wks'
             when Curr_Offer_Intended_end_Dt_PREMS between (WEEK_START + 36) and (WEEK_START + 42) then 'Offer Ending in Next 4-6 Wks'
             when Curr_Offer_Intended_end_Dt_PREMS > (WEEK_START + 42)    then 'Offer Ending in 7+ Wks'
             when Prev_Offer_Actual_End_Dt_PREMS between (WEEK_START - 7) and WEEK_START         then 'Offer Ended in last 1 Wks'
             when Prev_Offer_Actual_End_Dt_PREMS between (WEEK_START - 14) and (WEEK_START - 8)  then 'Offer Ended in last 2-3 Wks'
             when Prev_Offer_Actual_End_Dt_PREMS between (WEEK_START - 21) and (WEEK_START - 15) then 'Offer Ended in last 2-3 Wks'
             when Prev_Offer_Actual_End_Dt_PREMS between (WEEK_START - 28) and (WEEK_START - 22) then 'Offer Ended in last 4-6 Wks'
             when Prev_Offer_Actual_End_Dt_PREMS between (WEEK_START - 35) and (WEEK_START - 29) then 'Offer Ended in last 4-6 Wks'
             when Prev_Offer_Actual_End_Dt_PREMS between (WEEK_START - 42) and (WEEK_START - 36) then 'Offer Ended in last 4-6 Wks'
             when Prev_Offer_Actual_End_Dt_PREMS < (WEEK_START - 42)  then 'Offer Ended 7+ Wks'
             else 'No Offer'
        end; 

Update #ECONOMETRICS_BASE
Set PREMIUM_Offer_End_Status_Level_1 = 
        case when PREMIUM_Offer_End_Status_Level_2 in ('Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks') 
                    then 'Offer Ending'
             when PREMIUM_Offer_End_Status_Level_2 = 'Offer Ending in 7+ Wks'                           
                    then 'On Offer'
             else 'No Offer'
        end;    



Call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','BROADBAND','Ordered','All','Update Only',
            'Prev_Offer_Actual_End_Dt_BB',
            'Curr_Offer_Intended_end_Dt_BB'
            );  

Update #ECONOMETRICS_BASE
Set BB_Offer_End_Status_Level_2 = 
        case when Curr_Offer_Intended_end_Dt_BB between (WEEK_START + 1) and (WEEK_START + 7)   then 'Offer Ending in Next 1 Wks'
             when Curr_Offer_Intended_end_Dt_BB between (WEEK_START + 8) and (WEEK_START + 14)  then 'Offer Ending in Next 2-3 Wks'
             when Curr_Offer_Intended_end_Dt_BB between (WEEK_START + 15) and (WEEK_START + 21) then 'Offer Ending in Next 2-3 Wks'
             when Curr_Offer_Intended_end_Dt_BB between (WEEK_START + 22) and (WEEK_START + 28) then 'Offer Ending in Next 4-6 Wks'
             when Curr_Offer_Intended_end_Dt_BB between (WEEK_START + 29) and (WEEK_START + 35) then 'Offer Ending in Next 4-6 Wks'
             when Curr_Offer_Intended_end_Dt_BB between (WEEK_START + 36) and (WEEK_START + 42) then 'Offer Ending in Next 4-6 Wks'
             when Curr_Offer_Intended_end_Dt_BB > (WEEK_START + 42)    then 'Offer Ending in 7+ Wks'
             when Prev_Offer_Actual_End_Dt_BB between (WEEK_START - 7) and WEEK_START         then 'Offer Ended in last 1 Wks'
             when Prev_Offer_Actual_End_Dt_BB between (WEEK_START - 14) and (WEEK_START - 8)  then 'Offer Ended in last 2-3 Wks'
             when Prev_Offer_Actual_End_Dt_BB between (WEEK_START - 21) and (WEEK_START - 15) then 'Offer Ended in last 2-3 Wks'
             when Prev_Offer_Actual_End_Dt_BB between (WEEK_START - 28) and (WEEK_START - 22) then 'Offer Ended in last 4-6 Wks'
             when Prev_Offer_Actual_End_Dt_BB between (WEEK_START - 35) and (WEEK_START - 29) then 'Offer Ended in last 4-6 Wks'
             when Prev_Offer_Actual_End_Dt_BB between (WEEK_START - 42) and (WEEK_START - 36) then 'Offer Ended in last 4-6 Wks'
             when Prev_Offer_Actual_End_Dt_BB < (WEEK_START - 42)  then 'Offer Ended 7+ Wks'
             else 'No Offer'
        end; 

Update #ECONOMETRICS_BASE
Set BB_Offer_End_Status_Level_1 = 
        case when BB_Offer_End_Status_Level_2 in ('Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks') 
                    then 'Offer Ending'
             when BB_Offer_End_Status_Level_2 = 'Offer Ending in 7+ Wks'                           
                    then 'On Offer'
             else 'No Offer'
        end;    


Call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','LR','Ordered','All','Update Only',
            'Prev_Offer_Actual_End_Dt_LR',
            'Curr_Offer_Intended_end_Dt_LR'
            );  

Update #ECONOMETRICS_BASE
Set LR_Offer_End_Status_Level_2 = 
        case when Curr_Offer_Intended_end_Dt_LR between (WEEK_START + 1) and (WEEK_START + 7)   then 'Offer Ending in Next 1 Wks'
             when Curr_Offer_Intended_end_Dt_LR between (WEEK_START + 8) and (WEEK_START + 14)  then 'Offer Ending in Next 2-3 Wks'
             when Curr_Offer_Intended_end_Dt_LR between (WEEK_START + 15) and (WEEK_START + 21) then 'Offer Ending in Next 2-3 Wks'
             when Curr_Offer_Intended_end_Dt_LR between (WEEK_START + 22) and (WEEK_START + 28) then 'Offer Ending in Next 4-6 Wks'
             when Curr_Offer_Intended_end_Dt_LR between (WEEK_START + 29) and (WEEK_START + 35) then 'Offer Ending in Next 4-6 Wks'
             when Curr_Offer_Intended_end_Dt_LR between (WEEK_START + 36) and (WEEK_START + 42) then 'Offer Ending in Next 4-6 Wks'
             when Curr_Offer_Intended_end_Dt_LR > (WEEK_START + 42)    then 'Offer Ending in 7+ Wks'
             when Prev_Offer_Actual_End_Dt_LR between (WEEK_START - 7) and WEEK_START         then 'Offer Ended in last 1 Wks'
             when Prev_Offer_Actual_End_Dt_LR between (WEEK_START - 14) and (WEEK_START - 8)  then 'Offer Ended in last 2-3 Wks'
             when Prev_Offer_Actual_End_Dt_LR between (WEEK_START - 21) and (WEEK_START - 15) then 'Offer Ended in last 2-3 Wks'
             when Prev_Offer_Actual_End_Dt_LR between (WEEK_START - 28) and (WEEK_START - 22) then 'Offer Ended in last 4-6 Wks'
             when Prev_Offer_Actual_End_Dt_LR between (WEEK_START - 35) and (WEEK_START - 29) then 'Offer Ended in last 4-6 Wks'
             when Prev_Offer_Actual_End_Dt_LR between (WEEK_START - 42) and (WEEK_START - 36) then 'Offer Ended in last 4-6 Wks'
             when Prev_Offer_Actual_End_Dt_LR < (WEEK_START - 42)  then 'Offer Ended 7+ Wks'
             else 'No Offer'
        end; 

Update #ECONOMETRICS_BASE
Set LR_Offer_End_Status_Level_1 = 
        case when LR_Offer_End_Status_Level_2 in ('Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks') 
                    then 'Offer Ending'
             when LR_Offer_End_Status_Level_2 = 'Offer Ending in 7+ Wks'                           
                    then 'On Offer'
             else 'No Offer'
        end;    


Call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','HD','Ordered','All','Update Only',
            'Prev_Offer_Actual_End_Dt_HD',
            'Curr_Offer_Intended_end_Dt_HD'
            );  

Call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','MS','Ordered','All','Update Only',
            'Prev_Offer_Actual_End_Dt_MS',
            'Curr_Offer_Intended_end_Dt_MS'
            );  

Call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','SGE','Ordered','All','Update Only',
            'Prev_Offer_Actual_End_Dt_SGE',
            'Curr_Offer_Intended_end_Dt_SGE'
            );  

Call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','HD PACK','Ordered','All','Update Only',
            'Prev_Offer_Actual_End_Dt_HD_PACK',
            'Curr_Offer_Intended_end_Dt_HD_PCK'
            );  

Call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','BOX SETS','Ordered','All','Update Only',
            'Prev_Offer_Actual_End_Dt_BOX_SETS',
            'Curr_Offer_Intended_end_Dt_BOX_SETS'
            );  

Call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','SKY_KIDS','Ordered','All','Update Only',
            'Prev_Offer_Actual_End_Dt_SKY_KIDS',
            'Curr_Offer_Intended_end_Dt_SKY_KIDS'
            );  

Call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','TALK','Ordered','All','Update Only',
            'Prev_Offer_Actual_End_Dt_TALK',
            'Curr_Offer_Intended_end_Dt_TALK'
            );  


Update #ECONOMETRICS_BASE
SET Prev_Offer_Actual_End_Dt_ADD_ON= 
CASE WHEN Prev_Offer_Actual_End_Dt_HD is not null then Prev_Offer_Actual_End_Dt_HD
    WHEN Prev_Offer_Actual_End_Dt_MS is not null then Prev_Offer_Actual_End_Dt_MS
    WHEN Prev_Offer_Actual_End_Dt_SGE is not null then Prev_Offer_Actual_End_Dt_SGE
    WHEN Prev_Offer_Actual_End_Dt_HD_PACK is not null then Prev_Offer_Actual_End_Dt_HD_PACK
    WHEN Prev_Offer_Actual_End_Dt_BOX_SETS is not null then Prev_Offer_Actual_End_Dt_BOX_SETS
    WHEN Prev_Offer_Actual_End_Dt_SKY_KIDS is not null then Prev_Offer_Actual_End_Dt_SKY_KIDS
    WHEN Prev_Offer_Actual_End_Dt_TALK is not null then Prev_Offer_Actual_End_Dt_TALK END;


Update #ECONOMETRICS_BASE
SET Curr_Offer_Intended_end_Dt_ADD_ON= 
CASE WHEN Curr_Offer_Intended_end_Dt_HD is not null then Curr_Offer_Intended_end_Dt_HD
    WHEN Curr_Offer_Intended_end_Dt_MS is not null then Curr_Offer_Intended_end_Dt_MS
    WHEN Curr_Offer_Intended_end_Dt_SGE is not null then Curr_Offer_Intended_end_Dt_SGE
    WHEN Curr_Offer_Intended_end_Dt_HD_PACK is not null then Curr_Offer_Intended_end_Dt_HD_PACK
    WHEN Curr_Offer_Intended_end_Dt_BOX_SETS is not null then Curr_Offer_Intended_end_Dt_BOX_SETS
    WHEN Curr_Offer_Intended_end_Dt_SKY_KIDS is not null then Curr_Offer_Intended_end_Dt_SKY_KIDS
    WHEN Curr_Offer_Intended_end_Dt_TALK is not null then Curr_Offer_Intended_end_Dt_TALK END;


    Update #ECONOMETRICS_BASE
Set ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 
        case when Curr_Offer_Intended_end_Dt_ADD_ON between (WEEK_START + 1) and (WEEK_START + 7)   then 'Offer Ending in Next 1 Wks'
             when Curr_Offer_Intended_end_Dt_ADD_ON between (WEEK_START + 8) and (WEEK_START + 14)  then 'Offer Ending in Next 2-3 Wks'
             when Curr_Offer_Intended_end_Dt_ADD_ON between (WEEK_START + 15) and (WEEK_START + 21) then 'Offer Ending in Next 2-3 Wks'
             when Curr_Offer_Intended_end_Dt_ADD_ON between (WEEK_START + 22) and (WEEK_START + 28) then 'Offer Ending in Next 4-6 Wks'
             when Curr_Offer_Intended_end_Dt_ADD_ON between (WEEK_START + 29) and (WEEK_START + 35) then 'Offer Ending in Next 4-6 Wks'
             when Curr_Offer_Intended_end_Dt_ADD_ON between (WEEK_START + 36) and (WEEK_START + 42) then 'Offer Ending in Next 4-6 Wks'
             when Curr_Offer_Intended_end_Dt_ADD_ON > (WEEK_START + 42)    then 'Offer Ending in 7+ Wks'
             when Prev_Offer_Actual_End_Dt_ADD_ON between (WEEK_START - 7) and WEEK_START         then 'Offer Ended in last 1 Wks'
             when Prev_Offer_Actual_End_Dt_ADD_ON between (WEEK_START - 14) and (WEEK_START - 8)  then 'Offer Ended in last 2-3 Wks'
             when Prev_Offer_Actual_End_Dt_ADD_ON between (WEEK_START - 21) and (WEEK_START - 15) then 'Offer Ended in last 2-3 Wks'
             when Prev_Offer_Actual_End_Dt_ADD_ON between (WEEK_START - 28) and (WEEK_START - 22) then 'Offer Ended in last 4-6 Wks'
             when Prev_Offer_Actual_End_Dt_ADD_ON between (WEEK_START - 35) and (WEEK_START - 29) then 'Offer Ended in last 4-6 Wks'
             when Prev_Offer_Actual_End_Dt_ADD_ON between (WEEK_START - 42) and (WEEK_START - 36) then 'Offer Ended in last 4-6 Wks'
             when Prev_Offer_Actual_End_Dt_ADD_ON < (WEEK_START - 42)  then 'Offer Ended 7+ Wks'
             else 'No Offer'
        end; 

Update #ECONOMETRICS_BASE
Set ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1 = 
        case when ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 in ('Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks') 
                    then 'Offer Ending'
             when ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2 = 'Offer Ending in 7+ Wks'                           
                    then 'On Offer'
             else 'No Offer'
        end;    


-------------------------------------------------------------------------

-- MMC Populate prems fields with Model T data -----------------------------------------------
Call vha02.Add_Active_Subscriber_Product_Holding('#ECONOMETRICS_BASE','WEEK_START','Sports','Update Only','Sports_Active','Sports_Product_Count');
Call vha02.Add_Active_Subscriber_Product_Holding('#ECONOMETRICS_BASE','WEEK_START','Movies','Update Only','Movies_Active','Movies_Product_Count');
Call vha02.Add_Active_Subscriber_Product_Holding('#ECONOMETRICS_BASE','WEEK_START','Prems','Update Only','Prems_Active','Prems_Product_Count');
Call vha02.Add_Active_Subscriber_Product_Holding('#ECONOMETRICS_BASE','WEEK_START','BB','Update Only','BB_ACTIVE','BB_PRODUCT_HOLDING');

COMMIT;

-- MMC new proc calls to populate offers details ---------------------------------------------
Call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','Any','Ordered','All','Update Only'
            ,'Prev_Offer_Start_Dt_Any','Prev_Offer_Intended_end_Dt_Any','Prev_Offer_Actual_End_Dt_Any'
            ,'Curr_Offer_Start_Dt_Any','Curr_Offer_Intended_end_Dt_Any','Curr_Offer_Actual_End_Dt_Any'
            );


-- Call Decisioning_Procs.Add_Offers_Software('#Premiums','ORDER_DT','All','Ordered','Update Only','Curr_Offer_Intended_end_Dt_All');
/*
Call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','DTV','Ordered','All','Update Only','Curr_Offer_Intended_end_Dt_DTV');
Call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','Broadband','Ordered','All','Update Only','Curr_Offer_Intended_end_Dt_BB');
Call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','Line Rental','Ordered','All','Update Only','Curr_Offer_Intended_end_Dt_LR');
Call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','Multiscreen','Ordered','All','Update Only','Curr_Offer_Intended_end_Dt_MS');
Call Decisioning_Procs.Add_Offers_Software('#ECONOMETRICS_BASE','WEEK_START','HD','Ordered','All','Update Only','Curr_Offer_Intended_end_Dt_HD');
*/
COMMIT;

Update #ECONOMETRICS_BASE
Set Offer_End_Status_Level_2 =
        case when Curr_Offer_Intended_end_Dt_Any between (WEEK_START + 1) and (WEEK_START + 7)   then 'Offer Ending in Next 1 Wks'
             when Curr_Offer_Intended_end_Dt_Any between (WEEK_START + 8) and (WEEK_START + 14)  then 'Offer Ending in Next 2-3 Wks'
             when Curr_Offer_Intended_end_Dt_Any between (WEEK_START + 15) and (WEEK_START + 21) then 'Offer Ending in Next 2-3 Wks'
             when Curr_Offer_Intended_end_Dt_Any between (WEEK_START + 22) and (WEEK_START + 28) then 'Offer Ending in Next 4-6 Wks'
             when Curr_Offer_Intended_end_Dt_Any between (WEEK_START + 29) and (WEEK_START + 35) then 'Offer Ending in Next 4-6 Wks'
             when Curr_Offer_Intended_end_Dt_Any between (WEEK_START + 36) and (WEEK_START + 42) then 'Offer Ending in Next 4-6 Wks'
             when Curr_Offer_Intended_end_Dt_Any > (WEEK_START + 42)                           then 'Offer Ending in 7+ Wks'
             when Prev_Offer_Actual_End_Dt_Any between (WEEK_START - 7) and WEEK_START         then 'Offer Ended in last 1 Wks'
             when Prev_Offer_Actual_End_Dt_Any between (WEEK_START - 14) and (WEEK_START - 8)  then 'Offer Ended in last 2-3 Wks'
             when Prev_Offer_Actual_End_Dt_Any between (WEEK_START - 21) and (WEEK_START - 15) then 'Offer Ended in last 2-3 Wks'
             when Prev_Offer_Actual_End_Dt_Any between (WEEK_START - 28) and (WEEK_START - 22) then 'Offer Ended in last 4-6 Wks'
             when Prev_Offer_Actual_End_Dt_Any between (WEEK_START - 35) and (WEEK_START - 29) then 'Offer Ended in last 4-6 Wks'
             when Prev_Offer_Actual_End_Dt_Any between (WEEK_START - 42) and (WEEK_START - 36) then 'Offer Ended in last 4-6 Wks'
             when Prev_Offer_Actual_End_Dt_Any < (WEEK_START - 42) then 'Offer Ended 7+ Wks'
             else 'No Offer'
        end;

COMMIT;

Update #ECONOMETRICS_BASE
Set Offer_End_Status_Level_1 =
        case when Offer_End_Status_Level_2 in ('Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks',
            'Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks')
                    then 'Offer Ending'
             when Offer_End_Status_Level_2 = 'Offer Ending in 7+ Wks'
                    then 'On Offer'
             else 'No Offer'
        end;

COMMIT;

-- MMC - Update 
UPDATE #ECONOMETRICS_BASE
Set TOTAL_PREMIUMS = case when (Sports_Active+Movies_Active)>1 then 1 else 0 END,
    TOTAL_SPORTS = Sports_Product_Count,
    TOTAL_MOVIES = Movies_Product_Count
    ;

COMMIT;


DROP TABLE IF EXISTS #BASE_OFFER_STATUS;

SELECT D.ACCOUNT_NUMBER
                   ,D.WEEK_START
                   ,CASE WHEN D.ACTUAL_OFFER_STATUS=2 THEN 'Offer End'
                        WHEN D.ACTUAL_OFFER_STATUS=1 THEN 'On Offer'
                        ELSE 'No Offer'
                   END AS ACTUAL_OFFER_STATUS
                   ,CASE WHEN D.INTENDED_OFFER_STATUS=2 THEN 'Offer End'
                        WHEN D.INTENDED_OFFER_STATUS=1 THEN 'On Offer'
                        ELSE 'No Offer'
                   END AS INTENDED_OFFER_STATUS

INTO #BASE_OFFER_STATUS
FROM
(
    SELECT DISTINCT A.ACCOUNT_NUMBER
                    ,A.WEEK_START
                    ,MAX(CASE
                        WHEN B.WHOLE_OFFER_END_DT_ACTUAL<>A.WEEK_START AND A.WEEK_START-55<=B.WHOLE_OFFER_END_DT_ACTUAL AND A.WEEK_START+35>=B.WHOLE_OFFER_END_DT_ACTUAL THEN 2
                        WHEN B.WHOLE_OFFER_END_DT_ACTUAL=A.WEEK_START AND A.WEEK_START-55<=B.Intended_Offer_End_Dt AND A.WEEK_START+35>=B.Intended_Offer_End_Dt THEN 2
                        WHEN B.WHOLE_OFFER_END_DT_ACTUAL IS NOT NULL THEN 1
                        ELSE 0
                        END)
                    AS ACTUAL_OFFER_STATUS
                    ,MAX(CASE
                        WHEN A.WEEK_START-55<=C.Intended_Offer_End_Dt AND A.WEEK_START+35>=C.Intended_Offer_End_Dt THEN 2
                        WHEN C.Intended_Offer_End_Dt IS NOT NULL THEN 1
                        ELSE 0
                        END)
                    AS INTENDED_OFFER_STATUS

    FROM #ECONOMETRICS_BASE A
    LEFT JOIN
    Decisioning.Offers_Software B

    ON A.ACCOUNT_NUMBER=B.ACCOUNT_NUMBER
    AND A.WEEK_START>=B.WHOLE_OFFER_START_DT_ACTUAL
    AND A.WEEK_START-55<=B.WHOLE_OFFER_END_DT_ACTUAL
    AND lower(B.offer_dim_description) not like 'price protect%'
    AND B.WHOLE_OFFER_AMOUNT_ACTUAL<0

    LEFT JOIN
    Decisioning.Offers_Software C

    ON A.ACCOUNT_NUMBER=C.ACCOUNT_NUMBER
    AND A.WEEK_START>=C.Offer_Leg_Start_Dt_Actual
    AND A.WEEK_START-55<=C.Intended_Offer_End_Dt
    AND lower(C.offer_dim_description) not like 'price protect%'
    AND C.WHOLE_OFFER_AMOUNT_ACTUAL<0

    GROUP BY A.ACCOUNT_NUMBER
                    ,A.WEEK_START

)D
GROUP BY 
     D.ACCOUNT_NUMBER
    ,D.WEEK_START
    ,D.ACTUAL_OFFER_STATUS
    ,D.INTENDED_OFFER_STATUS
;


COMMIT;

-- UPDATE TABLE
UPDATE #ECONOMETRICS_BASE A

SET A.ACTUAL_OFFER_STATUS=B.ACTUAL_OFFER_STATUS
        ,A.INTENDED_OFFER_STATUS=B.INTENDED_OFFER_STATUS

FROM #BASE_OFFER_STATUS B

WHERE A.ACCOUNT_NUMBER=B.ACCOUNT_NUMBER
AND A.WEEK_START=B.WEEK_START
;

COMMIT;

-- Drop temp tables
DROP TABLE IF EXISTS #BASE_OFFER_STATUS;
COMMIT;

-- ADD FLAG IF ACCOUNT HAS ANY OFFER
UPDATE #ECONOMETRICS_BASE A
SET A.ANY_OFFER_FLAG= Case when Curr_Offer_Intended_end_Dt_Any is not null then 1 else 0 end,
A.DTV_PRIMARY_VIEWING_OFFER = Case when Curr_Offer_Intended_end_Dt_DTV is not null then 1 else 0 end,
A.BB_OFFER= Case when Curr_Offer_Intended_end_Dt_BB is not null then 1 else 0 end,
A.LR_OFFER= Case when Curr_Offer_Intended_end_Dt_LR is not null then 1 else 0 end,
A.MS_OFFER=Case when Curr_Offer_Intended_end_Dt_MS is not null then 1 else 0 end,
A.HD_OFFER=Case when Curr_Offer_Intended_end_Dt_HD is not null then 1 else 0 end;

COMMIT;

-----------------------------------------------------------------------------------------------
-- UPDATE THE TV_REGION  and Tenure 

UPDATE #ECONOMETRICS_BASE base
SET base.TV_Region = B.tv_region,
base.TENURE = case when DATEDIFF(month,B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT,base.WEEK_START)<0 then 0 else DATEDIFF(month,B.ACCT_FIRST_ACCOUNT_ACTIVATION_DT,base.WEEK_START) end
FROM #ECONOMETRICS_BASE base
INNER JOIN CITeam.Account_TV_Region B
ON base.account_number = B.account_number;

UPDATE #ECONOMETRICS_BASE A
SET A.BASIC_PACKAGE_HOLDING=CASE WHEN ORIGINAL>0 THEN 'ORIGINAL'
                                 WHEN VARIETY>0 THEN 'VARIETY'
                                 WHEN FAMILY>0 THEN 'FAMILY'
                                 WHEN SKYQ>0 THEN 'SKYQ'
                                 WHEN SKY_ENT>0 THEN 'SKY_ENT'
                                 ELSE '' END
FROM #ECONOMETRICS_BASE A;

-- table at account level 

DELETE FROM Decisioning.ECONOMETRICS_BASE_ACCOUNT_LEVEL_BETA
WHERE WEEK_START BETWEEN PERIOD_START AND PERIOD_END;
COMMIT;
INSERT INTO Decisioning.ECONOMETRICS_BASE_ACCOUNT_LEVEL_BETA
SELECT
        YEAR_WEEK
        ,WEEK_START
        ,account_number
        --,subscription_id
        ,effective_from_dt
        ,effective_to_dt
        ,COUNTRY
        ,ACTUAL_OFFER_STATUS
        ,INTENDED_OFFER_STATUS
        ,DTV
        ,ORIGINAL
        ,VARIETY
        ,FAMILY
        ,SKYQ
        ,SKY_ENT
        ,BASIC_PACKAGE_HOLDING
        ,SKY_KIDS
        ,BOX_SETS
        ,TOP_TIER
        ,MOVIES
        ,SPORTS
        ,HD_ANY
        ,HD_LEGACY
        ,HD_BASIC
        ,HD_PREMIUM
        ,BB_ACTIVE
        ,BB_PRODUCT_HOLDING
        ,LR
        ,talk_product_holding
        ,MS_product_holding
        ,chelsea_tv
		,mu_tv
		,liverpool_tv
		,skyasia_tv
        ,SKY_GO_EXTRA
        ,Spotify
        ,Sports_product_holding
        ,Cinema_product_holding
        ,Original_Product_Holding
        ,MS_Count
        ,MOBILE
        ,SkyQ_Silver
        ,Skykids_App
        ,ANY_OFFER_FLAG
        ,DTV_PRIMARY_VIEWING_OFFER
        ,BB_OFFER
        ,LR_OFFER
        ,MS_OFFER
        ,HD_OFFER
        ,DTV_OFFER_DESCRIPTION
        ,BB_OFFER_DESCRIPTION
        ,LR_OFFER_DESCRIPTION
        ,MS_OFFER_DESCRIPTION
        ,HD_OFFER_DESCRIPTION
        ,TENURE
        ,TV_REGION
        ,TOTAL_PREMIUMS
        ,TOTAL_SPORTS
        ,TOTAL_MOVIES
        ,Offer_End_Status_Level_1
        ,Offer_End_Status_Level_2

        ,BASIC_OFFER_END_STATUS_LEVEL_1
        ,PREMIUM_OFFER_END_STATUS_LEVEL_1
        ,BB_OFFER_END_STATUS_LEVEL_1
        ,LR_OFFER_END_STATUS_LEVEL_1
        ,ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1
        ,BASIC_OFFER_END_STATUS_LEVEL_2
        ,PREMIUM_OFFER_END_STATUS_LEVEL_2
        ,BB_OFFER_END_STATUS_LEVEL_2
        ,LR_OFFER_END_STATUS_LEVEL_2
        ,ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2
        --,contract_status
        ,Basic_Contract_Status_Level_2
        ,Add_on_Products_Contract_Status_Level_2
        ,Talk_Contract_Status_Level_2
        ,BB_Contract_Status_Level_2
        ,Basic_Contract_Status_Level_1
        ,Add_on_Products_Contract_Status_Level_1
        ,Talk_Contract_Status_Level_1
        ,BB_Contract_Status_Level_1
FROM #ECONOMETRICS_BASE;

COMMIT;


DELETE FROM Decisioning.ECONOMETRICS_BASE_BETA
WHERE WEEK_START BETWEEN PERIOD_START AND PERIOD_END;
COMMIT;
INSERT INTO Decisioning.ECONOMETRICS_BASE_BETA
SELECT
        YEAR_WEEK
        ,WEEK_START
        ,COUNTRY
        ,ACTUAL_OFFER_STATUS
        ,INTENDED_OFFER_STATUS
        ,DTV
        ,BASIC_PACKAGE_HOLDING
        ,SKY_KIDS
        ,BOX_SETS
        ,TOP_TIER
        ,MOVIES
        ,SPORTS
        ,HD_ANY
        ,HD_LEGACY
        ,HD_BASIC
        ,HD_PREMIUM
        ,BB_ACTIVE
        ,BB_PRODUCT_HOLDING
        ,LR
        ,talk_product_holding
        ,MS_product_holding
        ,chelsea_tv
		,mu_tv
		,liverpool_tv
		,skyasia_tv
        ,SKY_GO_EXTRA
        ,Spotify
        ,Sports_product_holding
        ,Cinema_product_holding
        ,Original_Product_Holding
        ,MS_Count
        ,MOBILE
        ,SkyQ_Silver
        ,Skykids_App
        ,ANY_OFFER_FLAG
        ,DTV_PRIMARY_VIEWING_OFFER
        ,BB_OFFER
        ,LR_OFFER
        ,MS_OFFER
        ,HD_OFFER
        ,TENURE
        ,TV_REGION
        ,TOTAL_PREMIUMS
        ,TOTAL_SPORTS
        ,TOTAL_MOVIES
        -------------------------------------------------------------------------------------------------
        ,COUNT(*) as NUMBER_OF_ACCOUNTS
        ,Offer_End_Status_Level_1
        ,Offer_End_Status_Level_2
        ,BASIC_OFFER_END_STATUS_LEVEL_1
        ,PREMIUM_OFFER_END_STATUS_LEVEL_1
        ,BB_OFFER_END_STATUS_LEVEL_1
        ,LR_OFFER_END_STATUS_LEVEL_1
        ,ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1
        ,BASIC_OFFER_END_STATUS_LEVEL_2
        ,PREMIUM_OFFER_END_STATUS_LEVEL_2
        ,BB_OFFER_END_STATUS_LEVEL_2
        ,LR_OFFER_END_STATUS_LEVEL_2
        ,ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2
        --,contract_status
        ,Basic_Contract_Status_Level_2
        ,Add_on_Products_Contract_Status_Level_2
        ,Talk_Contract_Status_Level_2
        ,BB_Contract_Status_Level_2
        ,Basic_Contract_Status_Level_1
        ,Add_on_Products_Contract_Status_Level_1
        ,Talk_Contract_Status_Level_1
        ,BB_Contract_Status_Level_1

FROM #ECONOMETRICS_BASE
GROUP BY
        YEAR_WEEK
        ,WEEK_START
        ,COUNTRY
        ,ACTUAL_OFFER_STATUS
        ,INTENDED_OFFER_STATUS
        ,DTV
        ,BASIC_PACKAGE_HOLDING
        ,SKY_KIDS
        ,BOX_SETS
        ,TOP_TIER
        ,MOVIES
        ,SPORTS
        ,HD_ANY
        ,HD_LEGACY
        ,HD_BASIC
        ,HD_PREMIUM
        ,BB_ACTIVE
        ,BB_PRODUCT_HOLDING
        ,LR
        ,talk_product_holding
        ,MS_product_holding
        ,chelsea_tv
		,mu_tv
		,liverpool_tv
		,skyasia_tv
        ,SKY_GO_EXTRA
        ,Spotify
        ,Sports_product_holding
        ,Cinema_product_holding
        ,Original_Product_Holding
        ,MS_Count
        ,MOBILE
        ,SkyQ_Silver
        ,Skykids_App
        ,ANY_OFFER_FLAG
        ,DTV_PRIMARY_VIEWING_OFFER
        ,BB_OFFER
        ,LR_OFFER
        ,MS_OFFER
        ,HD_OFFER
        ,DTV_OFFER_DESCRIPTION
        ,BB_OFFER_DESCRIPTION
        ,LR_OFFER_DESCRIPTION
        ,MS_OFFER_DESCRIPTION
        ,HD_OFFER_DESCRIPTION
        ,TENURE
        ,TV_REGION
        -- MMC new prems fields ------------------------------------------------------------------------  
        ,TOTAL_PREMIUMS
        ,TOTAL_SPORTS
        ,TOTAL_MOVIES
        -------------------------------------------------------------------------------------------------
        ,Offer_End_Status_Level_1
        ,Offer_End_Status_Level_2
        ,BASIC_OFFER_END_STATUS_LEVEL_1
        ,PREMIUM_OFFER_END_STATUS_LEVEL_1
        ,BB_OFFER_END_STATUS_LEVEL_1
        ,LR_OFFER_END_STATUS_LEVEL_1
        ,ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1
        ,BASIC_OFFER_END_STATUS_LEVEL_2
        ,PREMIUM_OFFER_END_STATUS_LEVEL_2
        ,BB_OFFER_END_STATUS_LEVEL_2
        ,LR_OFFER_END_STATUS_LEVEL_2
        ,ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2
        --,contract_status
        ,Basic_Contract_Status_Level_2
        ,Add_on_Products_Contract_Status_Level_2
        ,Talk_Contract_Status_Level_2
        ,BB_Contract_Status_Level_2
        ,Basic_Contract_Status_Level_1
        ,Add_on_Products_Contract_Status_Level_1
        ,Talk_Contract_Status_Level_1
        ,BB_Contract_Status_Level_1
       
;

COMMIT;

DROP TABLE IF EXISTS #ECONOMETRICS_BASE_OFFERS_2;

SELECT   A.*
        ,B.SUBS_TYPE AS OFFER_SUB_TYPE
        ,B.OFFER_ID
        ,B.OFFER_DIM_DESCRIPTION AS OFFER_DESCRIPTION
        ,B.Monthly_Offer_Amount AS MONTHLY_OFFER_VALUE
        ,DATEDIFF(MONTH,B.Whole_Offer_start_dt_Actual,B.Whole_Offer_end_dt_Actual) AS OFFER_DURATION_MTH
        ,DATEDIFF(MONTH,B.Whole_Offer_start_dt_Actual,B.Whole_Offer_end_dt_Actual)*B.Monthly_Offer_Amount AS TOTAL_OFFER_VALUE
        ,CASE WHEN B.ORIG_PORTFOLIO_OFFER_ID<>'?' THEN 1 ELSE 0 END AS AUTO_TRANSFER_OFFER
        ,Cast(null as varchar(30)) -- *B.CREATED_OFFER_SEGMENT_GROUPED_1
            AS OFFER_GIVEAWAY_EVENT
        ,CASE WHEN B.Whole_Offer_START_dt_Actual<=(A.WEEK_START+6) AND B.Whole_Offer_START_dt_Actual>=A.WEEK_START
                THEN 1 ELSE 0
         END AS OFFER_START_FLAG
        ,CASE WHEN B.Whole_Offer_end_dt_Actual<=(A.WEEK_START+6) AND B.Whole_Offer_end_dt_Actual>=A.WEEK_START
                THEN 1 ELSE 0
         END AS OFFER_ENDING_FLAG

INTO #ECONOMETRICS_BASE_OFFERS_2

FROM #ECONOMETRICS_BASE A
     LEFT JOIN
     Decisioning.Offers_Software B
     ON A.ACCOUNT_NUMBER=B.ACCOUNT_NUMBER
        AND A.WEEK_START<=B.Offer_leg_end_dt_Actual
        AND (A.WEEK_START+6)>=B.Offer_leg_START_dt_Actual
        AND lower(B.offer_dim_description) not like '%price protect%'

GROUP BY
     A.YEAR_WEEK
    ,A.WEEK_START
    ,A.effective_from_dt
    ,A.effective_to_dt
    ,A.product_holding
    ,A.ACCOUNT_NUMBER
    ,A.COUNTRY
    ,A.DTV
    ,A.ORIGINAL
    ,A.VARIETY
    ,A.FAMILY
    ,A.SKYQ
    ,A.SKY_ENT
    ,A.BASIC_PACKAGE_HOLDING
    ,SKY_KIDS
    ,BOX_SETS
    ,A.TOP_TIER
    ,A.MOVIES
    ,A.SPORTS
    ,A.HD_ANY
    ,A.HD_LEGACY
    ,A.HD_BASIC
    ,A.HD_PREMIUM
    ,A.MULTISCREEN
    ,A.MULTISCREEN_VOL
    ,A.SKY_GO_EXTRA
    ,A.Spotify
    ,A.Sports_product_holding
    ,A.Cinema_product_holding
    ,A.Original_Product_Holding
    ,A.MS_Count
    ,A.MOBILE
    ,A.SkyQ_Silver
    ,A.Skykids_App
    ,A.BB_ACTIVE
    ,A.BB_PRODUCT_HOLDING
    ,A.LR
    ,A.talk_product_holding
    ,A.MS_product_holding
	,A.chelsea_tv
	,A.mu_tv
	,A.liverpool_tv
	,A.skyasia_tv
    ,A.ACTUAL_OFFER_STATUS
    ,A.INTENDED_OFFER_STATUS
    ,A.ANY_OFFER_FLAG
    ,A.DTV_PRIMARY_VIEWING_OFFER
    ,A.BB_OFFER
    ,A.LR_OFFER
    ,A.MS_OFFER
    ,A.HD_OFFER
    ,A.DTV_OFFER_DESCRIPTION
    ,A.BB_OFFER_DESCRIPTION
    ,A.LR_OFFER_DESCRIPTION
    ,A.MS_OFFER_DESCRIPTION
    ,A.HD_OFFER_DESCRIPTION
    ,A.TENURE
    --,A.TENURE_MONTH
    ,A.SIMPLE_SEGMENT
    ,A.TV_REGION
    ,A.MOSAIC_UK_GROUP
    ,A.PREMS_PRODUCT_COUNT
    ,A.SPORTS_PRODUCT_COUNT
    ,A.MOVIES_PRODUCT_COUNT
    ,A.PREMS_ACTIVE
    ,A.SPORTS_ACTIVE
    ,A.MOVIES_ACTIVE
    ,A.TOTAL_PREMIUMS
    ,A.TOTAL_SPORTS
    ,A.TOTAL_MOVIES
    ,A.PREV_OFFER_START_DT_ANY
    ,A.PREV_OFFER_INTENDED_END_DT_ANY
    ,A.PREV_OFFER_ACTUAL_END_DT_ANY
    ,A.CURR_OFFER_START_DT_ANY
    ,A.CURR_OFFER_INTENDED_END_DT_ANY
    ,A.CURR_OFFER_ACTUAL_END_DT_ANY

    ,A.OFFER_END_STATUS_LEVEL_1
    ,A.OFFER_END_STATUS_LEVEL_2
    ,A.BASIC_OFFER_END_STATUS_LEVEL_1
    ,A.PREMIUM_OFFER_END_STATUS_LEVEL_1
    ,A.BB_OFFER_END_STATUS_LEVEL_1
    ,A.LR_OFFER_END_STATUS_LEVEL_1
    ,A.ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1
    ,A.BASIC_OFFER_END_STATUS_LEVEL_2
    ,A.PREMIUM_OFFER_END_STATUS_LEVEL_2
    ,A.BB_OFFER_END_STATUS_LEVEL_2
    ,A.LR_OFFER_END_STATUS_LEVEL_2

    ,A.ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2
    ,A.CURR_OFFER_INTENDED_END_DT_DTV
    ,A.CURR_OFFER_INTENDED_END_DT_BB
    ,A.CURR_OFFER_INTENDED_END_DT_LR
    ,A.CURR_OFFER_INTENDED_END_DT_MS
    ,A.CURR_OFFER_INTENDED_END_DT_HD
    ,B.SUBS_TYPE
    ,B.OFFER_ID
    ,B.OFFER_DIM_DESCRIPTION
    ,B.Monthly_Offer_Amount
    ,OFFER_DURATION_MTH
    ,TOTAL_OFFER_VALUE
    ,AUTO_TRANSFER_OFFER
    ,OFFER_GIVEAWAY_EVENT
    ,OFFER_START_FLAG
    ,OFFER_ENDING_FLAG
    --,contract_status
    ,A.Basic_Contract_Status_Level_2
    ,A.Add_on_Products_Contract_Status_Level_2
    ,A.Talk_Contract_Status_Level_2
    ,A.BB_Contract_Status_Level_2
    ,A.Basic_Contract_Status_Level_1
    ,A.Add_on_Products_Contract_Status_Level_1
    ,A.Talk_Contract_Status_Level_1
    ,A.BB_Contract_Status_Level_1

    , a.Prev_Offer_Actual_End_Dt_DTV
    , a.Curr_Offer_Intended_end_Dt_DTV
    , a.Curr_Offer_Intended_end_Dt_PREMS
    , a.Prev_Offer_Actual_End_Dt_PREMS
    , a.Prev_Offer_Actual_End_Dt_BB
    , a.Curr_Offer_Intended_end_Dt_BB
    , a.Prev_Offer_Actual_End_Dt_LR
    , a.Curr_Offer_Intended_end_Dt_LR
    , a.Prev_Offer_Actual_End_Dt_HD
    , a.Curr_Offer_Intended_end_Dt_HD
    , a.Prev_Offer_Actual_End_Dt_MS
    , a.Curr_Offer_Intended_end_Dt_MS
    , a.Prev_Offer_Actual_End_Dt_SGE
    , a.Curr_Offer_Intended_end_Dt_SGE
    , a.Prev_Offer_Actual_End_Dt_ADD_ON
    , a.Curr_Offer_Intended_end_Dt_ADD_ON
    , a.Prev_Offer_Actual_End_Dt_HD_PACK
    , a.Curr_Offer_Intended_end_Dt_HD_PACK
    , a.Prev_Offer_Actual_End_Dt_BOX_SETS
    , a.Curr_Offer_Intended_end_Dt_BOX_SETS
    , a.Prev_Offer_Actual_End_Dt_SKY_KIDS
    , a.Curr_Offer_Intended_end_Dt_SKY_KIDS
    , a.Prev_Offer_Actual_End_Dt_TALK
    , a.Curr_Offer_Intended_end_Dt_TALK  
;

COMMIT;

DELETE FROM Decisioning.ECONOMETRICS_BASE_OFFERS_BETA
WHERE WEEK_START BETWEEN PERIOD_START AND PERIOD_END;
COMMIT;

INSERT INTO Decisioning.ECONOMETRICS_BASE_OFFERS_BETA
SELECT
        YEAR_WEEK
        ,WEEK_START
        ,COUNTRY
        ,ACTUAL_OFFER_STATUS
        ,INTENDED_OFFER_STATUS
        ,DTV
        ,BASIC_PACKAGE_HOLDING
        ,SKY_KIDS
        ,BOX_SETS
        ,TOP_TIER
        ,MOVIES
        ,SPORTS
        ,HD_ANY
        ,HD_LEGACY
        ,HD_BASIC
        ,HD_PREMIUM
        ,BB_ACTIVE
        ,BB_PRODUCT_HOLDING
        ,LR
        ,talk_product_holding
        ,MS_product_holding
        ,chelsea_tv
		,mu_tv
		,liverpool_tv
		,skyasia_tv
        ,SKY_GO_EXTRA
        ,Spotify
        ,Sports_product_holding
        ,Cinema_product_holding
        ,Original_Product_Holding
        ,MS_Count
        ,MOBILE
        ,SkyQ_Silver
        ,Skykids_App
        ,OFFER_SUB_TYPE
        ,OFFER_DESCRIPTION
        ,MONTHLY_OFFER_VALUE
        ,OFFER_DURATION_MTH
        ,TOTAL_OFFER_VALUE
        ,OFFER_GIVEAWAY_EVENT
        ,TENURE
        --,TENURE_MONTH
        ,TV_REGION
        -- MMC new prems fields ------------------------------------------------------------------------
        ,TOTAL_PREMIUMS
        ,TOTAL_SPORTS
        ,TOTAL_MOVIES
        ------------------------------------------------------------------------------------------------  
        ,COUNT(*) AS NUMBER_OF_ACCOUNTS
        ,SUM(OFFER_START_FLAG) AS NUMBER_OF_ACCOUNTS_OFFER_STARTED
        ,SUM(OFFER_ENDING_FLAG) AS NUMBER_OF_ACCOUNTS_OFFER_ENDED
        ,Offer_End_Status_Level_1
        ,Offer_End_Status_Level_2

        ,BASIC_OFFER_END_STATUS_LEVEL_1
        ,PREMIUM_OFFER_END_STATUS_LEVEL_1
        ,BB_OFFER_END_STATUS_LEVEL_1
        ,LR_OFFER_END_STATUS_LEVEL_1
        ,ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1
        ,BASIC_OFFER_END_STATUS_LEVEL_2
        ,PREMIUM_OFFER_END_STATUS_LEVEL_2
        ,BB_OFFER_END_STATUS_LEVEL_2
        ,LR_OFFER_END_STATUS_LEVEL_2
        ,ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2
        --,contract_status
        ,Basic_Contract_Status_Level_2
        ,Add_on_Products_Contract_Status_Level_2
        ,Talk_Contract_Status_Level_2
        ,BB_Contract_Status_Level_2
        ,Basic_Contract_Status_Level_1
        ,Add_on_Products_Contract_Status_Level_1
        ,Talk_Contract_Status_Level_1
        ,BB_Contract_Status_Level_1



FROM #ECONOMETRICS_BASE_OFFERS_2

WHERE OFFER_ID is not null

GROUP BY
        YEAR_WEEK
        ,WEEK_START
        ,COUNTRY
        ,ACTUAL_OFFER_STATUS
        ,INTENDED_OFFER_STATUS
        ,DTV
        ,BASIC_PACKAGE_HOLDING
        ,SKY_KIDS
        ,BOX_SETS
        ,TOP_TIER
        ,MOVIES
        ,SPORTS
        ,HD_ANY
        ,HD_LEGACY
        ,HD_BASIC
        ,HD_PREMIUM
        ,BB_ACTIVE
        ,BB_PRODUCT_HOLDING
        ,LR
        ,talk_product_holding
        ,MS_product_holding
        ,chelsea_tv
		,mu_tv
		,liverpool_tv
		,skyasia_tv
        ,SKY_GO_EXTRA
        ,Spotify
        ,Sports_product_holding
        ,Cinema_product_holding
        ,Original_Product_Holding
        ,MS_Count
        ,MOBILE
        ,SkyQ_Silver
        ,Skykids_App
        ,OFFER_SUB_TYPE
        ,OFFER_DESCRIPTION
        ,MONTHLY_OFFER_VALUE
        ,OFFER_DURATION_MTH
        ,TOTAL_OFFER_VALUE
        ,OFFER_GIVEAWAY_EVENT
        ,TENURE
       -- ,TENURE_MONTH
        ,TV_REGION
        -- MMC new prems fields ------------------------------------------------------------------------
        ,TOTAL_PREMIUMS
        ,TOTAL_SPORTS
        ,TOTAL_MOVIES
        ------------------------------------------------------------------------------------------------
        ,Offer_End_Status_Level_1
        ,Offer_End_Status_Level_2

        ,BASIC_OFFER_END_STATUS_LEVEL_1
        ,PREMIUM_OFFER_END_STATUS_LEVEL_1
        ,BB_OFFER_END_STATUS_LEVEL_1
        ,LR_OFFER_END_STATUS_LEVEL_1
        ,ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1
        ,BASIC_OFFER_END_STATUS_LEVEL_2
        ,PREMIUM_OFFER_END_STATUS_LEVEL_2
        ,BB_OFFER_END_STATUS_LEVEL_2
        ,LR_OFFER_END_STATUS_LEVEL_2
        ,ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2

        --,contract_status
        ,Basic_Contract_Status_Level_2
        ,Add_on_Products_Contract_Status_Level_2
        ,Talk_Contract_Status_Level_2
        ,BB_Contract_Status_Level_2
        ,Basic_Contract_Status_Level_1
        ,Add_on_Products_Contract_Status_Level_1
        ,Talk_Contract_Status_Level_1
        ,BB_Contract_Status_Level_1


;

COMMIT;

-- CREATE SUMMARY OF ALL OFFERS STARTED AND UPDATE HOLDINGS TO BE AT END OF WEEK

DROP TABLE IF EXISTS #ECONOMETRICS_BASE_OFFERS_STARTED_1;

SELECT *
INTO #ECONOMETRICS_BASE_OFFERS_STARTED_1
FROM #ECONOMETRICS_BASE_OFFERS_2
WHERE OFFER_START_FLAG=1
;

COMMIT;

create hg index idx_3 on #ECONOMETRICS_BASE_OFFERS_STARTED_1(ACCOUNT_NUMBER);
create date index idx_4 on #ECONOMETRICS_BASE_OFFERS_STARTED_1(WEEK_START);

-- Drop temp tables
DROP TABLE IF EXISTS #ECONOMETRICS_BASE_OFFERS_2;
COMMIT;


-- UPDATE HOLDINGS TO END OF THE WEEK

UPDATE #ECONOMETRICS_BASE_OFFERS_STARTED_1 A
SET
        A.DTV=B.DTV
        ,A.ORIGINAL=B.ORIGINAL
        ,A.VARIETY=B.VARIETY
        ,A.FAMILY=B.FAMILY
        ,A.SKYQ=B.SKYQ
        ,A.SKY_ENT= B.SKY_ENT
        ,A.BASIC_PACKAGE_HOLDING= CASE   WHEN B.ORIGINAL>0 THEN 'ORIGINAL'
                                         WHEN B.VARIETY>0 THEN 'VARIETY'
                                         WHEN B.FAMILY>0 THEN 'FAMILY'
                                         WHEN B.SKYQ>0 THEN 'SKYQ'
                                         WHEN B.SKY_ENT>0 THEN 'SKY_ENT'
                                         ELSE '' END
        ,A.SKY_KIDS=B.SKY_KIDS
        ,A.BOX_SETS=B.BOX_SETS
        ,A.TOP_TIER=B.TOP_TIER
        ,A.MOVIES=B.MOVIES
        ,A.SPORTS=B.SPORTS
        ,A.HD_ANY=B.HD_ANY
        ,A.HD_LEGACY=B.HD_LEGACY
        ,A.HD_BASIC=B.HD_BASIC
        ,A.HD_PREMIUM=B.HD_PREMIUM
        ,A.SKY_GO_EXTRA=B.SKY_GO_EXTRA
        ,A.Spotify=B.Spotify
        ,A.LR=B.LR
        ,A.talk_product_holding=B.talk_product_holding
        ,A.MS_product_holding=B.MS_product_holding
        ,A.Sports_product_holding=B.Sports_product_holding
        ,A.Cinema_product_holding=B.Cinema_product_holding
        ,A.Original_Product_Holding=b.Original_Product_Holding
        ,A.MS_Count=B.MS_Count
        ,A.MOBILE=B.MOBILE
        ,A.SkyQ_Silver=B.SkyQ_Silver
        ,A.Skykids_App=B.Skykids_App
		,A.chelsea_tv   = B.chelsea_tv
		,A.mu_tv        = B.mu_tv
		,A.liverpool_tv = B.liverpool_tv
		,A.skyasia_tv   = B.skyasia_tv
FROM #ECONOMETRICS_BASE_OFFERS_STARTED_1 A
INNER JOIN
#ASR_ECON B

ON A.ACCOUNT_NUMBER=B.ACCOUNT_NUMBER
AND (A.WEEK_START+6)>=B.EFFECTIVE_FROM_DT
AND (A.WEEK_START+6)<B.EFFECTIVE_TO_DT
;
COMMIT;

DELETE FROM Decisioning.ECONOMETRICS_BASE_OFFERS_STARTED_BETA
WHERE WEEK_START BETWEEN PERIOD_START AND PERIOD_END
;

COMMIT;

INSERT INTO Decisioning.ECONOMETRICS_BASE_OFFERS_STARTED_BETA
SELECT 
        YEAR_WEEK
        ,WEEK_START
        ,COUNTRY
        ,ACTUAL_OFFER_STATUS
        ,INTENDED_OFFER_STATUS
        ,DTV
        ,BASIC_PACKAGE_HOLDING
        ,SKY_KIDS
        ,BOX_SETS
        ,TOP_TIER
        ,MOVIES
        ,SPORTS
        ,HD_ANY
        ,HD_LEGACY
        ,HD_BASIC
        ,HD_PREMIUM
        ,BB_ACTIVE
        ,BB_PRODUCT_HOLDING
        ,LR
        ,talk_product_holding
        ,MS_product_holding
		,chelsea_tv
		,mu_tv
		,liverpool_tv
		,skyasia_tv
        ,SKY_GO_EXTRA
        ,Spotify
        ,Sports_product_holding
        ,Cinema_product_holding
        ,Original_Product_Holding
        ,MS_Count
        ,MOBILE
        ,SkyQ_Silver
        ,Skykids_App
        ,OFFER_SUB_TYPE
        ,OFFER_DESCRIPTION
        ,MONTHLY_OFFER_VALUE
        ,OFFER_DURATION_MTH
        ,TOTAL_OFFER_VALUE
        ,OFFER_GIVEAWAY_EVENT
        ,TENURE
        ,TV_REGION
        ,TOTAL_PREMIUMS
        ,TOTAL_SPORTS
        ,TOTAL_MOVIES
        ------------------------------------------------------------------------------------------------
        ,SUM(OFFER_START_FLAG) AS NUMBER_OF_ACCOUNTS_OFFER_STARTED
        ,Offer_End_Status_Level_1
        ,Offer_End_Status_Level_2

        ,BASIC_OFFER_END_STATUS_LEVEL_1
        ,PREMIUM_OFFER_END_STATUS_LEVEL_1
        ,BB_OFFER_END_STATUS_LEVEL_1
        ,LR_OFFER_END_STATUS_LEVEL_1
        ,ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1
        ,BASIC_OFFER_END_STATUS_LEVEL_2
        ,PREMIUM_OFFER_END_STATUS_LEVEL_2
        ,BB_OFFER_END_STATUS_LEVEL_2
        ,LR_OFFER_END_STATUS_LEVEL_2
        ,ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2

        --,contract_status
        ,Basic_Contract_Status_Level_2
        ,Add_on_Products_Contract_Status_Level_2
        ,Talk_Contract_Status_Level_2
        ,BB_Contract_Status_Level_2
        ,Basic_Contract_Status_Level_1
        ,Add_on_Products_Contract_Status_Level_1
        ,Talk_Contract_Status_Level_1
        ,BB_Contract_Status_Level_1


FROM #ECONOMETRICS_BASE_OFFERS_STARTED_1

WHERE OFFER_ID is not null

GROUP BY
        YEAR_WEEK
        ,WEEK_START
        ,COUNTRY
        ,ACTUAL_OFFER_STATUS
        ,INTENDED_OFFER_STATUS
        ,DTV
        ,BASIC_PACKAGE_HOLDING
        ,SKY_KIDS
        ,BOX_SETS
        ,TOP_TIER
        ,MOVIES
        ,SPORTS
        ,HD_ANY
        ,HD_LEGACY
        ,HD_BASIC
        ,HD_PREMIUM
        ,BB_ACTIVE
        ,BB_PRODUCT_HOLDING
        ,LR
        ,talk_product_holding
        ,MS_product_holding
		,chelsea_tv
		,mu_tv
		,liverpool_tv
		,skyasia_tv

        ,SKY_GO_EXTRA
        ,Spotify
        ,Sports_product_holding
        ,Cinema_product_holding
        ,Original_Product_Holding
        ,MS_Count
        ,MOBILE
        ,SkyQ_Silver
        ,Skykids_App
        ,OFFER_SUB_TYPE
        ,OFFER_DESCRIPTION
        ,MONTHLY_OFFER_VALUE
        ,OFFER_DURATION_MTH
        ,TOTAL_OFFER_VALUE
        ,OFFER_GIVEAWAY_EVENT
        ,TENURE
        ,TV_REGION
        -- MMC new prems fields ------------------------------------------------------------------------
        ,TOTAL_PREMIUMS
        ,TOTAL_SPORTS
        ,TOTAL_MOVIES
        ------------------------------------------------------------------------------------------------
        ,Offer_End_Status_Level_1
        ,Offer_End_Status_Level_2

        ,BASIC_OFFER_END_STATUS_LEVEL_1
        ,PREMIUM_OFFER_END_STATUS_LEVEL_1
        ,BB_OFFER_END_STATUS_LEVEL_1
        ,LR_OFFER_END_STATUS_LEVEL_1
        ,ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_1
        ,BASIC_OFFER_END_STATUS_LEVEL_2
        ,PREMIUM_OFFER_END_STATUS_LEVEL_2
        ,BB_OFFER_END_STATUS_LEVEL_2
        ,LR_OFFER_END_STATUS_LEVEL_2
        ,ADD_ON_PRODUCTS_OFFER_END_STATUS_LEVEL_2
        --,contract_status
        ,Basic_Contract_Status_Level_2
        ,Add_on_Products_Contract_Status_Level_2
        ,Talk_Contract_Status_Level_2
        ,BB_Contract_Status_Level_2
        ,Basic_Contract_Status_Level_1
        ,Add_on_Products_Contract_Status_Level_1
        ,Talk_Contract_Status_Level_1
        ,BB_Contract_Status_Level_1

;

COMMIT;
END
--GO

--GRANT EXECUTE ON Decisioning_Procs.Update_Econometrics_BaseProfiles TO public;

/*

CALL apa83.Update_Econometrics_BaseProfiles_beta();
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