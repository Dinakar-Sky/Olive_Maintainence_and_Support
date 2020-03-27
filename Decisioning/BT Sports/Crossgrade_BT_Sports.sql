/*
*********************************************************************************
** File: Crossgrades_BT_Sports.sql
** Name: Crossgrades_BT_Sports
** Desc: Code for calculating Crossgrades for "BT Sports"
** Date: 17/11/2017
************************************************************************************
****								Change History								****
************************************************************************************
** Change#	Date 		Author				Description 
** --		---------	-------------		------------------------------------
************************************************************************************/

/*
dba.sp_drop_table 'CITeam','Crossgrades_BT_Sports'
dba.sp_create_table 'CITeam','Crossgrades_BT_Sports',
   'Subs_Year decimal ( 22 ) default null,'
|| 'Subs_Week_Of_Year decimal ( 22 ) default null,'
|| 'Subs_Week_And_Year varchar ( 6 ) default null,'
|| 'Event_Dt date  default null,'
|| 'account_number varchar ( 20 ) default null,'
|| 'OWNING_CUST_ACCOUNT_ID varchar ( 50 ) default null,'
|| 'Country char ( 3 ) default null,'
|| 'status_code varchar ( 10 ) default null,'
|| 'Prev_Product_Desc varchar ( 240 ) default null,'
|| 'Curr_Product_Desc varchar ( 240 ) default null,'
|| 'BT_Sports_Regrade smallint  default 0,'
|| 'Account_Type_csh_DTV_EoD varchar ( 255 ) default null,'
|| 'Account_Sub_Type_csh_DTV_EoD varchar ( 255 ) default null,'
|| 'cb_Key_Household_csh_DTV_EoD bigint  default null,'
|| 'Created_By_ID_csh_DTV_EoD varchar ( 50 ) default null,'
|| 'Current_Product_sk_csh_DTV_EoD decimal ( 22 ) default null,'
|| 'Ent_Cat_Prod_sk_csh_DTV_EoD decimal ( 22 ) default null,'
|| 'First_Order_ID_csh_DTV_EoD varchar ( 50 ) default null,'
|| 'Order_ID_csh_DTV_EoD varchar ( 50 ) default null,'
|| 'Order_Line_ID_csh_DTV_EoD varchar ( 50 ) default null,'
|| 'PH_Subs_Hist_sk_csh_DTV_EoD decimal ( 22 ) default null,'
|| 'Service_Instance_ID_csh_DTV_EoD varchar ( 50 ) default null,'
|| 'Subscription_ID_csh_DTV_EoD varchar ( 50 ) default null'
*/

Setuser aqi02;
Go 
Drop procedure if exists aqi02.Update_CITeam_Crossgrades_BT_Sports;
GO
Create procedure aqi02.Update_CITeam_Crossgrades_BT_Sports(Refresh_Dt date default null) 
SQL SECURITY INVOKER

BEGIN
SET TEMPORARY OPTION Query_Temp_Space_Limit = 0;
commit;

/*
Drop variable if exists Refresh_Dt;
Create variable Refresh_Dt date;
Set Refresh_Dt = '2017-11-30';
*/

If Refresh_Dt is null then 
BEGIN 
Set Refresh_Dt = (Select max(event_dt) - 2*7 from CITeam.Crossgrades_BT_Sports);
END
End If;

Delete from CITeam.Crossgrades_BT_Sports where Event_Dt >= Refresh_Dt;


DROP TABLE IF EXISTS  #Crossgrades_BT_Sports;

SELECT sc.Subs_Year AS Subs_Year
	,sc.Subs_Week_Of_Year AS Subs_Week_Of_Year
	,sc.Subs_Week_And_Year AS Subs_Week_And_Year
	,csh.effective_from_dt AS Event_Dt
	,csh.account_number
	,csh.OWNING_CUST_ACCOUNT_ID
	,CASE WHEN csh.currency_code = 'EUR' THEN 'ROI' ELSE 'UK' END AS Country
	,csh.status_code	
	,csh_BT_Sports_SoD.current_product_description AS Prev_Product_Desc
	,csh_BT_Sports_EoD.current_product_description AS Curr_Product_Desc	
	,CASE WHEN csh_BT_Sports_SoD.current_product_description <> csh_BT_Sports_EoD.current_product_description THEN 1 ELSE 0 END AS BT_Sports_Regrade
	,csh_BT_Sports_EoD.Account_Type AS Account_Type_csh_DTV_EoD
	,csh_BT_Sports_EoD.Account_Sub_Type AS Account_Sub_Type_csh_DTV_EoD
	,csh_BT_Sports_EoD.cb_Key_Household AS cb_Key_Household_csh_DTV_EoD
	,csh_BT_Sports_EoD.Created_By_ID AS Created_By_ID_csh_DTV_EoD
	,csh_BT_Sports_EoD.Current_Product_sk AS Current_Product_sk_csh_DTV_EoD
	,csh_BT_Sports_EoD.Ent_Cat_Prod_sk AS Ent_Cat_Prod_sk_csh_DTV_EoD
	,csh_BT_Sports_EoD.First_Order_ID AS First_Order_ID_csh_DTV_EoD
	,csh_BT_Sports_EoD.Order_ID AS Order_ID_csh_DTV_EoD
	,csh_BT_Sports_EoD.Order_Line_ID AS Order_Line_ID_csh_DTV_EoD
	,csh_BT_Sports_EoD.PH_Subs_Hist_sk AS PH_Subs_Hist_sk_csh_DTV_EoD
	,csh_BT_Sports_EoD.Service_Instance_ID AS Service_Instance_ID_csh_DTV_EoD
	,csh_BT_Sports_EoD.Subscription_ID AS Subscription_ID_csh_DTV_EoD

INTO #Crossgrades_BT_Sports
	
FROM cust_subs_hist csh

LEFT OUTER JOIN cust_subs_hist csh_DTV_SoD
	ON csh_DTV_SoD.account_number = csh.account_number
		AND csh.status_start_dt BETWEEN csh_DTV_SoD.effective_from_dt + 1 AND csh_DTV_SoD.effective_to_dt
		AND csh_DTV_SoD.subscription_sub_type = 'DTV Primary Viewing'
		AND csh_DTV_SoD.status_code IN ('AC', 'AB', 'PC')
		
LEFT OUTER JOIN cust_subs_hist csh_DTV_EoD
	ON csh_DTV_EoD.account_number = csh.account_number
		AND csh.status_start_dt BETWEEN csh_DTV_EoD.effective_from_dt AND csh_DTV_EoD.effective_to_dt - 1
		AND csh_DTV_EoD.subscription_sub_type = 'DTV Primary Viewing'
		AND csh_DTV_EoD.status_code IN ('AC', 'AB', 'PC')	

LEFT OUTER JOIN cust_subs_hist csh_BT_Sports_SoD
	ON csh_BT_Sports_SoD.account_number = csh.account_number
		AND csh.status_start_dt BETWEEN csh_BT_Sports_SoD.effective_from_dt + 1 AND csh_BT_Sports_SoD.effective_to_dt
		AND csh_BT_Sports_SoD.subscription_type  in ('A-LA-CARTE','ENHANCED')
		AND csh_BT_Sports_SoD.subscription_sub_type  in ('Sport Extra','Sport Extra HD')
		AND csh_BT_Sports_SoD.status_code IN ('AC', 'AB', 'PC')
		
LEFT OUTER JOIN cust_subs_hist csh_BT_Sports_EoD
	ON csh_BT_Sports_EoD.account_number = csh.account_number
		AND csh.status_start_dt BETWEEN csh_BT_Sports_EoD.effective_from_dt AND csh_BT_Sports_EoD.effective_to_dt - 1
		AND csh_BT_Sports_EoD.subscription_type  in ('A-LA-CARTE','ENHANCED')
		AND csh_BT_Sports_EoD.subscription_sub_type  in ('Sport Extra','Sport Extra HD')
		AND csh_BT_Sports_EoD.status_code IN ('AC', 'AB', 'PC')
	
INNER JOIN sky_calendar sc
	ON CAST(sc.calendar_date AS DATE) = CAST(csh.effective_from_dt AS DATE) 
	
WHERE 
	csh.effective_from_dt >= Refresh_Dt
	AND csh.status_code_changed = 'Y'
	AND csh.subscription_type in ('A-LA-CARTE','ENHANCED')
	AND csh.subscription_sub_type = '	 '
	AND csh.status_code IN ('AC', 'AB', 'PC')
	AND csh.effective_from_dt < csh.effective_to_dt
	AND csh_DTV_SoD.account_number IS NOT NULL
	AND csh_DTV_EoD.account_number IS NOT NULL
	AND csh_BT_Sports_SoD.account_number IS NOT NULL
	AND csh_BT_Sports_EoD.account_number IS NOT NULL 
	AND BT_Sports_Regrade > 0
	;
	
INSERT INTO CITeam.Crossgrades_BT_Sports
SELECT * FROM #Crossgrades_BT_Sports;
END;
GO 
Grant Execute on aqi02.Update_CITeam_Crossgrades_BT_Sports to public;

/* ======================================== Queries for Testing ========================================
call aqi02.Update_CITeam_Crossgrades_BT_Sports('2017-10-01');
Select top 100 * from CITeam.Crossgrades_BT_Sports;
Select count(*) from CITeam.Crossgrades_BT_Sports; 



call DBA.sp_DDL ('drop', 'view', 'CITeam', 'Crossgrades_BT_Sports');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'Crossgrades_BT_Sports',  'select * from CITeam.Crossgrades_BT_Sports');
====================================================================================================== 
*/