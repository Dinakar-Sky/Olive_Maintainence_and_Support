/*
*********************************************************************************
** File: Crossgrades_Boxsets.sql
** Name: Crossgrades_Boxsets
** Desc: Code for calculating Crossgrades for "Boxsets"
** Auth: Raunak Jhawar
** Date: 17/11/2017
************************************************************************************
****								Change History								****
************************************************************************************
** Change#	Date 		Author				Description 
** --		---------	-------------		------------------------------------
** 1		17/11/2017	Raunak Jhawar		First commit
** 2        03/01/2018  Vikram Haibate      Add DDL and Procs 
************************************************************************************/

/*
dba.sp_drop_table 'Decisioning','Crossgrades_Boxsets'
dba.sp_create_table 'Decisioning','Crossgrades_Boxsets',
   'Subs_Year DECIMAL (22) Default  Null,' 
|| 'Subs_Week_Of_Year DECIMAL (5,2) Default  Null,' 
|| 'Subs_Week_And_Year VARCHAR (6) Default  Null,' 
|| 'Event_Dt DATE  Default  Null,' 
|| 'Account_Number VARCHAR (20) Default  Null,' 
|| 'Owning_Cust_Account_Id VARCHAR (50) Default  Null,' 
|| 'Country CHAR (3) Default  Null,' 
|| 'Status_Code VARCHAR (10) Default  Null,' 
|| 'Prev_Product_Desc VARCHAR (240) Default  Null,' 
|| 'Curr_Product_Desc VARCHAR (240) Default  Null,' 
|| 'Boxsets_Regrade SMALLINT  Default  0,' 
|| 'Spin_Up SMALLINT  Default  0,' 
|| 'Spin_Down SMALLINT  Default  0,' 
|| 'Account_Type_CSH_DTV_EOD VARCHAR (255) Default  Null,' 
|| 'Account_Sub_Type_CSH_DTV_EOD VARCHAR (255) Default  Null,' 
|| 'Cb_Key_Household_CSH_DTV_EOD BIGINT  Default  Null,' 
|| 'Created_By_Id_CSH_DTV_EOD VARCHAR (50) Default  Null,' 
|| 'Current_Product_Sk_CSH_DTV_EOD DECIMAL (22) Default  Null,' 
|| 'Ent_Cat_Prod_Sk_CSH_DTV_EOD DECIMAL (22) Default  Null,' 
|| 'First_Order_ID_CSH_DTV_EOD VARCHAR (50) Default  Null,' 
|| 'Order_Id_CSH_DTV_EOD VARCHAR (50) Default  Null,' 
|| 'Order_Line_Id_CSH_DTV_EOD VARCHAR (50) Default  Null,' 
|| 'Ph_Subs_Hist_Sk_CSH_DTV_EOD DECIMAL (22) Default  Null,' 
|| 'Service_Instance_Id_CSH_DTV_EOD VARCHAR (50) Default  Null,' 
|| 'Subscription_ID_CSH_DTV_EOD VARCHAR (50) Default  Null' 



*/
Setuser Decisioning_Procs;
Go 
Drop procedure if exists Decisioning_Procs.Update_Decisioning_Crossgrades_Boxsets;
GO
Create procedure Decisioning_Procs.Update_Decisioning_Crossgrades_Boxsets(Refresh_Dt date default null) 
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
Set Refresh_Dt = (Select max(event_dt) - 2*7 from Decisioning.Crossgrades_Boxsets);
END
End If;

Delete from Decisioning.Crossgrades_Boxsets where Event_Dt >= Refresh_Dt;


DROP TABLE IF EXISTS  #Crossgrades_Boxsets;

SELECT 
	 sc.Subs_Year AS Subs_Year
	,sc.Subs_Week_Of_Year AS Subs_Week_Of_Year
	,sc.Subs_Week_And_Year AS Subs_Week_And_Year
	,csh.effective_from_dt AS Event_Dt
	,csh.account_number
	,csh.OWNING_CUST_ACCOUNT_ID
	,CASE WHEN csh.currency_code = 'EUR' THEN 'ROI' ELSE 'UK' END AS Country
	,csh.status_code	
	,csh_Boxsets_SoD.current_product_description AS Prev_Product_Desc
	,csh_Boxsets_EoD.current_product_description AS Curr_Product_Desc	
	,CASE WHEN csh_Boxsets_SoD.current_product_description <> csh_Boxsets_EoD.current_product_description THEN 1 ELSE 0 END AS Boxsets_Regrade
	,CASE WHEN csh_Boxsets_SoD.x_ent_current_contribution_gbp < csh_Boxsets_EoD.x_ent_current_contribution_gbp THEN 1 ELSE 0 END AS Spin_Up
	,CASE WHEN csh_Boxsets_SoD.x_ent_current_contribution_gbp > csh_Boxsets_EoD.x_ent_current_contribution_gbp THEN 1 ELSE 0 END AS Spin_Down
	,csh_Boxsets_EoD.Account_Type AS Account_Type_csh_DTV_EoD
	,csh_Boxsets_EoD.Account_Sub_Type AS Account_Sub_Type_csh_DTV_EoD
	,csh_Boxsets_EoD.cb_Key_Household AS cb_Key_Household_csh_DTV_EoD
	,csh_Boxsets_EoD.Created_By_ID AS Created_By_ID_csh_DTV_EoD
	,csh_Boxsets_EoD.Current_Product_sk AS Current_Product_sk_csh_DTV_EoD
	,csh_Boxsets_EoD.Ent_Cat_Prod_sk AS Ent_Cat_Prod_sk_csh_DTV_EoD
	,csh_Boxsets_EoD.First_Order_ID AS First_Order_ID_csh_DTV_EoD
	,csh_Boxsets_EoD.Order_ID AS Order_ID_csh_DTV_EoD
	,csh_Boxsets_EoD.Order_Line_ID AS Order_Line_ID_csh_DTV_EoD
	,csh_Boxsets_EoD.PH_Subs_Hist_sk AS PH_Subs_Hist_sk_csh_DTV_EoD
	,csh_Boxsets_EoD.Service_Instance_ID AS Service_Instance_ID_csh_DTV_EoD
	,csh_Boxsets_EoD.Subscription_ID AS Subscription_ID_csh_DTV_EoD

INTO #Crossgrades_Boxsets
	
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

LEFT OUTER JOIN cust_subs_hist csh_Boxsets_SoD
	ON csh_Boxsets_SoD.account_number = csh.account_number
		AND csh.status_start_dt BETWEEN csh_Boxsets_SoD.effective_from_dt + 1 AND csh_Boxsets_SoD.effective_to_dt
		AND csh_Boxsets_SoD.subscription_type = 'ENHANCED'
		AND csh_Boxsets_SoD.subscription_sub_type = 'SKY_BOX_SETS'
		AND csh_Boxsets_SoD.status_code IN ('AC', 'AB', 'PC')
		
LEFT OUTER JOIN cust_subs_hist csh_Boxsets_EoD
	ON csh_Boxsets_EoD.account_number = csh.account_number
		AND csh.status_start_dt BETWEEN csh_Boxsets_EoD.effective_from_dt AND csh_Boxsets_EoD.effective_to_dt - 1
		AND csh_Boxsets_EoD.subscription_type = 'ENHANCED'
		AND csh_Boxsets_EoD.subscription_sub_type = 'SKY_BOX_SETS'
		AND csh_Boxsets_EoD.status_code IN ('AC', 'AB', 'PC')
	
INNER JOIN sky_calendar sc
	ON CAST(sc.calendar_date AS DATE) = CAST(csh.effective_from_dt AS DATE) 
	
WHERE 
		csh.effective_from_dt >= Refresh_Dt
	AND csh.status_code_changed = 'Y'
	AND csh.subscription_type = 'ENHANCED'
	AND csh.subscription_sub_type = 'SKY_BOX_SETS'
	AND csh.status_code IN ('AC', 'AB', 'PC')
	AND csh.effective_from_dt < csh.effective_to_dt
	AND csh_DTV_SoD.account_number IS NOT NULL
	AND csh_DTV_EoD.account_number IS NOT NULL
	AND csh_Boxsets_SoD.account_number IS NOT NULL
	AND csh_Boxsets_EoD.account_number IS NOT NULL 
	AND Boxsets_Regrade > 0;

INSERT INTO Decisioning.Crossgrades_Boxsets
SELECT * FROM #Crossgrades_Boxsets;

END;
GO 
Grant Execute on Decisioning_Procs.Update_Decisioning_Crossgrades_Boxsets to public;


/* ======================================== Queries for Testing ========================================
call Decisioning_Procs.Update_Decisioning_Crossgrades_Boxsets('2017-10-01');
Select top 100 * from Decisioning.Crossgrades_Boxsets;
Select count(*) from Decisioning.Crossgrades_Boxsets; 


call DBA.sp_DDL ('drop', 'view', 'CITeam', 'Crossgrades_Boxsets');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'Crossgrades_Boxsets',  'select * from Decisioning.Crossgrades_Boxsets');

====================================================================================================== 
*/

 