/**********************************************************************************
** File: Activations_ALaCarte.sql
** Name: Activations_ALaCarte
** Desc: Code for calculating Activations for "A-La-Carte and SkyAsia"
** Auth: Surya Tiwari, Raunak Jhawar
** Date: 19/07/2017
************************************************************************************
****								Change History								****
************************************************************************************
** Change#	Date 		Author				Description 
** --		---------	-------------		------------------------------------
** 1		19/07/2017	Surya Tiwari		Refactoring the code
** 2		07/08/2017	Surya Tiwari		Added standard coumns
************************************************************************************/
/*
dba.sp_drop_table 'Decisioning','Activations_ALaCarte'
dba.sp_create_table 'Decisioning','Activations_ALaCarte',
   'Subs_Year int default null, '
|| 'Subs_Week_Of_Year int default null, '
|| 'Subs_Week_And_Year int default null, '
|| 'Event_Dt date default null, '
|| 'account_number varchar (20) default null, '
|| 'Account_Type varchar (255) default null, '
|| 'Account_Sub_Type varchar (255) default null, '
|| 'cb_Key_Household bigint default null, '
|| 'Created_By_ID varchar (50) default null, '
|| 'Current_Product_sk bigint default null, '
|| 'Ent_Cat_Prod_sk decimal default null, '
|| 'First_Order_ID varchar (50) default null, '
|| 'Order_ID varchar (50) default null, '
|| 'Order_Line_ID varchar (50) default null, '
|| 'PH_Subs_Hist_sk bigint default null, '
|| 'Service_Instance_ID varchar (50) default null, '
|| 'Subscription_ID varchar (50) default null, '
|| 'Owning_Cust_Account_ID varchar (50) default null, '
|| 'Country char(3)  default null, '
|| 'Activation_Type varchar(28) default null, '
|| 'New_Addition smallint default 0, '
|| 'SC_Platform_Reinstate smallint default 0, '
|| 'PO_Platform_Reinstate smallint default 0, '
|| 'Product_Reinstate smallint default 0, '
|| 'Event_Type varchar(13) default null, '
|| 'Activation smallint default 0, '
|| 'subscription_type varchar (20) default null, '
|| 'subscription_sub_type varchar (80) default null, '
|| 'status_code varchar (10) default null, '
|| 'Product_Holding varchar (240) default null '
*/
Drop variable if exists Refresh_Dt;
Create variable Refresh_Dt date;
Set Refresh_Dt = '1950-06-19';

Call Decisioning_Procs.Update_Decisioning_Activations_ALaCarte('1950-06-19'); 


-- setuser Decisioning_Procs

Drop Procedure If Exists Decisioning_Procs.Update_Decisioning_Activations_ALaCarte;
Create Procedure Decisioning_Procs.Update_Decisioning_Activations_ALaCarte(Refresh_Dt date default null)
SQL SECURITY INVOKER
BEGIN

If Refresh_Dt is null then
BEGIN
Set Refresh_Dt = (Select Max(Event_Dt) - 4*7 from Decisioning.Activations_ALaCarte);
END;
End If;

SET TEMPORARY OPTION Query_Temp_Space_Limit = 0;

DROP TABLE IF EXISTS #Activations_ALaCarte;

SELECT DISTINCT 
	sc.Subs_Year AS Subs_Year
	,sc.Subs_Week_Of_Year AS Subs_Week_Of_Year
	,sc.Subs_Week_And_Year AS Subs_Week_And_Year
	,csh.effective_from_dt AS Event_Dt
	,csh.account_number
	,csh.Account_Type
    ,csh.Account_Sub_Type
    ,csh.cb_Key_Household
    ,csh.Created_By_ID
    ,csh.Current_Product_sk
    ,csh.Ent_Cat_Prod_sk
    ,csh.First_Order_ID
    ,csh.Order_ID
    ,csh.Order_Line_ID
    ,csh.PH_Subs_Hist_sk
    ,csh.Service_Instance_ID
    ,csh.Subscription_ID
    ,csh.Owning_Cust_Account_ID
	,CASE 
		WHEN csh.currency_code = 'EUR' THEN 'ROI'
		ELSE 'UK'
	END Country
   ,CASE 
		WHEN csh.effective_from_dt = Acc_DTV_First_Activation.First_Act_Dt THEN 'NEW CUSTOMER ACTIVATION'
		WHEN NOT (Acc_ALC_First_Activation.First_Act_Dt < csh.effective_from_dt) THEN 'EXISTING CUSTOMER ACTIVATION'
		WHEN csh_DTV_SoD.account_number IS NULL AND Acc_ALC_First_Activation.First_Act_Dt < csh.effective_from_dt THEN 'PLATFORM REACTIVATION'
		ELSE 'PRODUCT REACTIVATION'
	END AS Activation_Type
	,CASE 
        WHEN Activation_Type = 'NEW CUSTOMER ACTIVATION' THEN 1
        ELSE 0
    END AS New_Addition
	,CASE 
        WHEN csh_DTV_SoD.account_number IS NULL AND csh_DTV_EoD.prev_status_code = 'SC' AND Acc_ALC_First_Activation.First_Act_Dt < csh.effective_from_dt THEN 1
        ELSE 0
    END AS SC_Platform_Reinstate
    ,CASE 
        WHEN csh_DTV_SoD.account_number IS NULL AND csh_DTV_EoD.prev_status_code = 'PO' AND Acc_ALC_First_Activation.First_Act_Dt < csh.effective_from_dt THEN 1
        ELSE 0
    END AS PO_Platform_Reinstate
    ,CASE 
        WHEN csh.prev_status_code IN ('PO','SC') THEN 1
        ELSE 0
    END AS Product_Reinstate
    ,CASE 
        WHEN csh.Status_Code = 'AC' AND csh.Prev_Status_Code IN  ('BL','EN','IT','PA','SU') THEN 'Activation'
        WHEN Product_Reinstate = 1 THEN 'Reinstatement'
    END AS Event_Type
    ,CASE 
        WHEN Event_Type IN ('Activation','Reinstatement') THEN 1 ELSE 0 
    END AS Activation
    ,csh.subscription_type
	,csh.subscription_sub_type
	,csh.status_code
	,csh.Current_Product_Description AS Product_Holding

INTO #Activations_ALaCarte

FROM cust_subs_hist csh

-- Code to check availability of DTV as a Base product during Start of Day
LEFT JOIN cust_subs_hist csh_DTV_SoD
	ON csh_DTV_SoD.account_number = csh.account_number 
	AND csh.status_start_dt BETWEEN csh_DTV_SoD.effective_from_dt + 1 AND csh_DTV_SoD.effective_to_dt 
	AND csh_DTV_SoD.subscription_sub_type = 'DTV Primary Viewing' 
	AND csh_DTV_SoD.status_code IN ('AC', 'AB', 'PC')

-- Code to check availability of DTV as a Base product during End of Day
LEFT JOIN cust_subs_hist csh_DTV_EoD
	ON csh_DTV_EoD.account_number = csh.account_number 
	AND csh.status_start_dt BETWEEN csh_DTV_EoD.effective_from_dt AND csh_DTV_EoD.effective_to_dt - 1
	AND csh_DTV_EoD.subscription_sub_type = 'DTV Primary Viewing' 
	AND csh_DTV_EoD.status_code IN ('AC', 'AB', 'PC')
	
-- Code to check availability of A-La-Carte subscription during Start of Day
LEFT JOIN cust_subs_hist csh_ALC_SoD
	ON csh_ALC_SoD.account_number = csh.account_number 
	AND csh.status_start_dt BETWEEN csh_ALC_SoD.effective_from_dt + 1 AND csh_ALC_SoD.effective_to_dt 
	AND csh_ALC_SoD.subscription_type = csh.subscription_type
	AND csh_ALC_SoD.subscription_sub_type = csh.subscription_sub_type
	AND csh_ALC_SoD.status_code IN ('AC', 'AB', 'PC')

-- Code to check availability of A-La-Carte subscription during End of Day
LEFT JOIN cust_subs_hist csh_ALC_EoD
	ON csh_ALC_EoD.account_number = csh.account_number 
	AND csh.status_start_dt BETWEEN csh_ALC_EoD.effective_from_dt AND csh_ALC_EoD.effective_to_dt - 1
	AND csh_ALC_EoD.subscription_type = csh.subscription_type
	AND csh_ALC_EoD.subscription_sub_type = csh.subscription_sub_type
	AND csh_ALC_EoD.status_code IN ('AC', 'AB', 'PC')

-- Code to get First Activation Date for DTV
LEFT JOIN (
	SELECT account_number, MIN(status_start_dt) First_Act_Dt
	FROM cust_subs_hist
	WHERE subscription_sub_type = 'DTV Primary Viewing' 
	AND status_code IN ('AC', 'AB', 'PC') 
	AND status_start_dt < status_end_dt
	GROUP BY account_number
	) Acc_DTV_First_Activation
	ON Acc_DTV_First_Activation.account_number = csh.account_number
	  
-- Code to get First Activation Date for A-La-Carte subscription
LEFT JOIN (
	SELECT account_number, subscription_type, subscription_sub_type, MIN(effective_from_dt) First_Act_Dt
	FROM cust_subs_hist
	WHERE 
	(
		(subscription_type = 'A-LA-CARTE' AND subscription_sub_type IN ('DTV Chelsea TV', 'LIVERPOOL', 'DTV MUTV'))
		OR 
		(subscription_type = 'ENHANCED' AND subscription_sub_type  = 'SKYASIA')
	)
	AND status_code IN ('AC', 'AB', 'PC') 
	AND effective_from_dt < effective_to_dt
	GROUP BY account_number, subscription_type, subscription_sub_type
	) Acc_ALC_First_Activation
	ON Acc_ALC_First_Activation.account_number = csh.account_number 
	AND Acc_ALC_First_Activation.subscription_type = csh.subscription_type
	AND Acc_ALC_First_Activation.subscription_sub_type = csh.subscription_sub_type

INNER JOIN sky_calendar sc ON CAST(sc.calendar_date AS DATE) = CAST(csh.effective_from_dt AS DATE)

WHERE csh.effective_from_dt >= Refresh_Dt
	AND 
	(
        (csh.subscription_type = 'A-LA-CARTE' AND csh.subscription_sub_type IN ('DTV Chelsea TV', 'LIVERPOOL', 'DTV MUTV'))
	OR 
        (csh.subscription_type = 'ENHANCED' AND csh.subscription_sub_type  = 'SKYASIA')
	)
	AND csh.status_code_changed = 'Y' 
	AND csh.status_code IN ('AC', 'AB', 'PC')  -- Current status should any of the Active / Active Blocked / Pending Cancel
	AND csh.effective_from_dt < csh.effective_to_dt 
	AND csh_ALC_SoD.account_number IS NULL -- At Start of Day the account should be inactive
	AND csh_ALC_EoD.account_number IS NOT NULL; -- At End of Day the account should be active



Delete from Decisioning.Activations_ALaCarte where event_dt >= Refresh_Dt;

-- Insert into Final Table
-- GO
INSERT INTO Decisioning.Activations_ALaCarte
SELECT *
FROM #Activations_ALaCarte;

-- SELECT *
-- INTO sti18.Activations_ALaCarte
-- FROM #Activations_ALaCarte;

/* ======================================== Queries for Testing ========================================
1. Query to test A-La-Carte ('DTV Chelsea TV', 'LIVERPOOL', 'DTV MUTV')
SELECT Event_Dt,subscription_sub_type, COUNT(1) 
FROM Decisioning.Activations_ALaCarte
WHERE subscription_type = 'A-LA-CARTE'
-- AND Activation_type IN ('NEW CUSTOMER ACTIVATION', 'EXISTING CUSTOMER ACTIVATION') -- Disable this for calculating Reinstatements
AND Product_Reinstate = 1
GROUP BY Event_Dt,subscription_sub_type ORDER BY 2,1;

2. Query to test SkyAsia
SELECT Event_Dt,subscription_sub_type, COUNT(1) 
FROM Decisioning.Activations_ALaCarte
WHERE subscription_type = 'ENHANCED'
-- AND Activation_type IN ('NEW CUSTOMER ACTIVATION', 'EXISTING CUSTOMER ACTIVATION') -- Disable this for calculating Reinstatements
AND Product_Reinstate = 1
GROUP BY Event_Dt,subscription_sub_type ORDER BY 2,1;

SELECT TOP 100 * FROM Decisioning.Activations_ALaCarte;

====================================================================================================== */
END;

Grant execute on Decisioning_Procs.Update_Decisioning_Activations_ALaCarte to Decisioning;