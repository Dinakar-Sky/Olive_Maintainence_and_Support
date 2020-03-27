/**********************************************************************************
** File: Active_Subscriber_Report_ALC.sql
** Name: Active_Subscriber_Report_ALC
** Desc: Code for building Active Subscriber Report for "A-LA-Carte and SkyAsia"
** Auth: Surya Tiwari
** Date: 26/07/2017
************************************************************************************
****                                Change History                              ****
************************************************************************************
** Change#  Date        Author              Description 
** --       ---------   -------------       ------------------------------------
** 1        26/07/2017  Surya Tiwari        First commit
************************************************************************************/
/*
dba.sp_drop_table 'Decisioning','Active_Subscriber_Report_ALC'
dba.sp_create_table 'Decisioning','Active_Subscriber_Report_ALC',
   ' Effective_From_Dt datetime default null, '
|| ' Effective_To_Dt datetime default null, '
|| ' Effective_From_Subs_Week smallint default null, '
|| ' Effective_To_Subs_Week smallint default null, '
|| ' Account_Number varchar (20) default null, '
|| ' Account_Type varchar (255) default null, '
|| ' Account_Sub_Type varchar (255) default null, '
|| ' Owning_Cust_Account_ID varchar (50) default null, '
|| ' Subscription_Type varchar (20) default null, '
|| ' Subscription_Sub_Type varchar (80) default null, '
|| ' Service_Instance_ID varchar (50) default null, '
|| ' Subscription_ID varchar (50) default null, '
|| ' Status_Code varchar (10) default null, '
|| ' Current_Product_sk decimal default null, '
|| ' Product_Holding varchar (80) default null, '
|| ' Country varchar (3) default null, '
|| ' ALC_Active int default 0, '
|| ' ALC_Active_Subscription int default 0 '

*/
SET TEMPORARY OPTION Query_Temp_Space_Limit = 0;
GO
COMMIT;
GO
-----------------------------------------------------------------------------------------------------------------------
-- A-La-Carte Subs
-----------------------------------------------------------------------------------------------------------------------
DROP VARIABLE IF EXISTS Refresh_dt; 
CREATE VARIABLE Refresh_dt DATE;
GO
SET Refresh_Dt = '1900-01-01'; -- '2017-06-16'
-- Set Refresh_Dt = (Select max(effective_from_dt) - 4*7 from Decisioning.Active_Subscriber_Report);
-- Select Refresh_Dt

DROP TABLE IF EXISTS #Subs_Movements;
GO
-- 1. Create Temp table
-- Select potential subs change records that will be basis of incremental update to subs table
SELECT ph_subs_hist_sk
	,Account_Number
	,Account_Type
	,Account_Sub_Type
	,Owning_Cust_Account_ID
	,Subscription_Type
	,Current_Product_sk
	,CAST(NULL AS VARCHAR(80)) AS Subscription_Sub_Type
	,Effective_From_Dt
	,Effective_To_Dt
	,Effective_From_Datetime
	,CAST(NULL AS INTEGER) AS Effective_From_Subs_Week
	,CAST(NULL AS INTEGER) AS Effective_To_Subs_Week
	,CAST(NULL AS INTEGER) AS Active_Subscriber
	,CAST(NULL AS SMALLINT) AS Number_Of_Active_Subs
	,CAST(csh.current_product_description AS VARCHAR(80)) AS Product_Holding
	,Subscription_ID
	,Service_Instance_ID
	,Status_Code
	,SI_LATEST_SRC
	,CAST(NULL AS VARCHAR(3)) AS Country
	,current_product_description
	,ENT_CAT_PROD_SK
	,CAST(NULL AS INTEGER) AS Status_Num
	,CAST(NULL AS INTEGER) AS Prod_Holding_Num
	,CAST(NULL AS smallint) AS ALC_Active_Subs
    ,CAST(NULL AS smallint) AS ALC_Active

INTO #Subs_Movements
FROM Cust_Subs_Hist csh
WHERE 1 = 0;
GO
COMMIT;
GO

-- 2. Insert A-La-Carte data for a given duration. Select potential subs change records that will be basis of incremental update to subs table
INSERT INTO #Subs_Movements
SELECT ph_subs_hist_sk
	,Account_Number
	,Account_Type
	,Account_Sub_Type
	,Owning_Cust_Account_ID
	,Subscription_Type
	,Current_Product_sk
	,Subscription_Sub_Type
	,Effective_From_Dt
	,Effective_To_Dt
	,Effective_From_Datetime
	,CAST(NULL AS INTEGER) AS Effective_From_Subs_Week
	,CAST(NULL AS INTEGER) AS Effective_To_Subs_Week
	,CAST(NULL AS INTEGER) AS Active_Subscriber
	,CAST(CASE WHEN status_code IN ('AC', 'AB', 'PC') THEN 1 ELSE 0 END AS SMALLINT) AS Number_Of_Active_Subs
	,Subscription_Sub_Type AS Product_Holding
	,Subscription_ID
	,Service_Instance_ID
	,Status_Code
	,SI_LATEST_SRC
	,CASE WHEN currency_code = 'EUR' THEN 'ROI' ELSE 'UK' END Country
	,current_product_description
	,ENT_CAT_PROD_SK
	,CAST(CASE status_code WHEN 'AC' THEN 1 WHEN 'AB' THEN 2 WHEN 'PC' THEN 3 ELSE 999 END AS INTEGER) AS Status_Num
	,CAST(NULL AS INTEGER) AS Prod_Holding_Num
	,CAST(NULL AS smallint) AS ALC_Active_Subs
    ,CAST(NULL AS smallint) AS ALC_Active
FROM Cust_Subs_Hist csh
LEFT JOIN cust_entitlement_lookup cel
	ON cel.short_description = csh.current_short_description
WHERE
	effective_from_dt >= Refresh_dt - 1
	AND 
	(
        (csh.subscription_type = 'A-LA-CARTE' AND csh.subscription_sub_type IN ('DTV Chelsea TV', 'LIVERPOOL', 'DTV MUTV'))
	OR 
        (csh.subscription_type = 'ENHANCED' AND csh.subscription_sub_type  = 'SKYASIA')
	)
	AND OWNING_CUST_ACCOUNT_ID > '1'
	AND SI_LATEST_SRC = 'CHORD'
	AND effective_to_dt > effective_from_dt

UNION

SELECT ph_subs_hist_sk
	,Account_Number
	,Account_Type
	,Account_Sub_Type
	,Owning_Cust_Account_ID
	,Subscription_Type
	,Current_Product_sk
	,Subscription_Sub_Type
	,Effective_From_Dt
	,Effective_To_Dt
	,Effective_From_Datetime
	,CAST(NULL AS INTEGER) AS Effective_From_Subs_Week
	,CAST(NULL AS INTEGER) AS Effective_To_Subs_Week
	,CAST(NULL AS INTEGER) AS Active_Subscriber
	,CAST(CASE WHEN status_code IN ('AC', 'AB', 'PC') THEN 1 ELSE 0 END AS SMALLINT) AS Number_Of_Active_Subs
	,Subscription_Sub_Type AS Product_Holding
	,Subscription_ID
	,Service_Instance_ID
	,Status_Code
	,SI_LATEST_SRC
	,CASE WHEN currency_code = 'EUR' THEN 'ROI' ELSE 'UK' END Country
	,current_product_description
	,ENT_CAT_PROD_SK
	,CAST(CASE status_code WHEN 'AC' THEN 1 WHEN 'AB' THEN 2 WHEN 'PC' THEN 3 ELSE 999 END AS INTEGER) AS Status_Num
	,CAST(NULL AS INTEGER) AS Prod_Holding_Num
	,CAST(NULL AS smallint) AS ALC_Active_Subs
    ,CAST(NULL AS smallint) AS ALC_Active
FROM Cust_Subs_Hist csh noholdlock
LEFT JOIN cust_entitlement_lookup cel noholdlock
	ON cel.short_description = csh.current_short_description
WHERE
	effective_to_dt >= Refresh_dt - 1
	AND 
	(
        (csh.subscription_type = 'A-LA-CARTE' AND csh.subscription_sub_type IN ('DTV Chelsea TV', 'LIVERPOOL', 'DTV MUTV'))
	OR 
        (csh.subscription_type = 'ENHANCED' AND csh.subscription_sub_type  = 'SKYASIA')
	)
	AND OWNING_CUST_ACCOUNT_ID > '1'
	AND SI_LATEST_SRC = 'CHORD'
	AND effective_to_dt > effective_from_dt;
GO

CREATE hg INDEX idx_1 ON #Subs_Movements (account_number);
CREATE DATE INDEX idx_2 ON #Subs_Movements (Effective_From_Dt);
CREATE DATE INDEX idx_3 ON #Subs_Movements (Effective_To_Dt);
CREATE lf INDEX idx_4 ON #Subs_Movements (Subscription_Sub_Type);
CREATE lf INDEX idx_5 ON #Subs_Movements (Number_Of_Active_Subs);
CREATE lf INDEX idx_6 ON #Subs_Movements (Product_Holding);
CREATE lf INDEX idx_7 ON #Subs_Movements (Status_Num);
CREATE lf INDEX idx_8 ON #Subs_Movements (Prod_Holding_Num);
CREATE hg INDEX idx_9 ON #Subs_Movements (current_product_description);
CREATE hg INDEX idx_10 ON #Subs_Movements (ENT_CAT_PROD_SK);
GO
COMMIT;
GO
--SELECT TOP 100 * FROM #Subs_Movements
---------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS #Acc_Subs_Changes;
GO

-- 3. Create table of potential subs change dates for each account
SELECT Account_Number
	,Subscription_Sub_Type
	,Effective_From_Dt AS Subs_Change_Dt
INTO #Acc_Subs_Changes
FROM #Subs_Movements WH_PH_SUBS_HIST
WHERE Subs_Change_Dt >= Refresh_Dt
GROUP BY Account_Number
	,Subs_Change_Dt
	,Subscription_Sub_Type

UNION

SELECT Account_Number
	,Subscription_Sub_Type
	,Effective_To_Dt AS Subs_Change_Dt
FROM #Subs_Movements WH_PH_SUBS_HIST
WHERE Subs_Change_Dt >= Refresh_Dt
GROUP BY Account_Number
	,Subs_Change_Dt
	,Subscription_Sub_Type

UNION

SELECT DISTINCT Account_Number
	,Subscription_Sub_Type
	,CAST(Refresh_Dt - 1 AS DATE) AS Subs_Change_Dt -- To get subs as at end of day before refresh_dt
FROM #Subs_Movements WH_PH_SUBS_HIST
WHERE CAST(Refresh_Dt - 1 AS DATE) BETWEEN effective_from_dt AND effective_to_dt - 1;
GO
COMMIT;
GO
--SELECT TOP 100 * FROM #Acc_Subs_Changes


CREATE hg INDEX idx_1 ON #Acc_Subs_Changes (account_number);
CREATE DATE INDEX idx_2 ON #Acc_Subs_Changes (Subs_Change_Dt);
CREATE lf INDEX idx_3 ON #Acc_Subs_Changes (Subscription_Sub_Type);

GO
DROP TABLE IF EXISTS #Order_Subs_Movements;
GO
-- 4. Create ordered table of subs changes
SELECT change.Subs_Change_Dt
	,change.Account_Number
	,change.Subscription_Sub_Type
	,subs.Effective_From_Dt
	,subs.Effective_To_Dt
	,subs.Effective_From_Subs_Week
	,subs.Effective_To_Subs_Week
	,subs.Active_Subscriber
	,subs.Number_Of_Active_Subs
	,subs.Product_Holding
	,subs.Subscription_ID
	,subs.Service_Instance_ID
	,subs.Status_Code
	,subs.SI_LATEST_SRC
	,subs.Country
	,subs.current_product_description
	,subs.ENT_CAT_PROD_SK
	,subs.OWNING_CUST_ACCOUNT_ID
	,subs.Status_Num
	,subs.Prod_Holding_Num
	,subs.Account_Type
	,subs.Account_Sub_Type
	,subs.Subscription_Type
	,subs.Current_Product_sk
INTO #Order_Subs_Movements
FROM #Acc_Subs_Changes change
LEFT JOIN #Subs_Movements subs
	ON subs.account_number = change.account_number
		AND change.Subs_Change_Dt BETWEEN subs.effective_from_dt AND subs.effective_to_dt - 1
		AND change.Subscription_Sub_Type = subs.Subscription_Sub_Type;
GO
COMMIT;
GO
-- SELECT TOP 100 * FROM #Order_Subs_Movements;

CREATE hg INDEX idx_1 ON #Order_Subs_Movements (account_number);
CREATE DATE INDEX idx_2 ON #Order_Subs_Movements (Effective_From_Dt);
CREATE DATE INDEX idx_3 ON #Order_Subs_Movements (Effective_To_Dt);
CREATE lf INDEX idx_4 ON #Order_Subs_Movements (Subscription_Sub_Type);
CREATE lf INDEX idx_5 ON #Order_Subs_Movements (Number_Of_Active_Subs);
CREATE lf INDEX idx_6 ON #Order_Subs_Movements (Product_Holding);
CREATE lf INDEX idx_7 ON #Order_Subs_Movements (Status_Num);
CREATE DATE INDEX idx_8 ON #Order_Subs_Movements (Subs_Change_Dt);

---------------------------------------------------------------------------------------------------
GO
DROP TABLE IF EXISTS #Order_Subs_Movements_2;
GO
SELECT subs.*
	-- Rank of the dates the changes were applied to each subscription so effective to dates can be readjusted
	,Dense_Rank() OVER (PARTITION BY account_number, subscription_id ORDER BY Subs_Change_Dt ASC) Subs_Change_Rnk
	-- Rank the product holding of all active subs on the date and change was applied
	,Dense_Rank() OVER (PARTITION BY account_number, subscription_sub_type, Subs_Change_Dt ORDER BY Number_Of_Active_Subs DESC, effective_from_dt /*Prod_Holding_Num*/ DESC,Status_Num ASC) ALC_Prod_Holding_Rnk
    -- Assign unique identifier to each record
    ,Row_Number() OVER (PARTITION BY account_number, subscription_sub_type, Subs_Change_Dt, Number_Of_Active_Subs, effective_from_dt, Status_Num ORDER BY Effective_To_Dt DESC) ALC_Record_Rnk
INTO #Order_Subs_Movements_2
FROM #Order_Subs_Movements subs;

-- SELECT TOP 100 * FROM #Order_Subs_Movements_2 WHERE Subs_Change_Rnk > 1;
GO
COMMIT;
GO
CREATE hg INDEX idx_1 ON #Order_Subs_Movements_2 (account_number);
CREATE DATE INDEX idx_2 ON #Order_Subs_Movements_2 (Effective_From_Dt);
CREATE DATE INDEX idx_3 ON #Order_Subs_Movements_2 (Effective_To_Dt);
CREATE lf INDEX idx_4 ON #Order_Subs_Movements_2 (Subscription_Sub_Type);
CREATE lf INDEX idx_5 ON #Order_Subs_Movements_2 (Number_Of_Active_Subs);
CREATE lf INDEX idx_6 ON #Order_Subs_Movements_2 (Product_Holding);
CREATE lf INDEX idx_7 ON #Order_Subs_Movements_2 (Status_Num);
CREATE lf INDEX idx_8 ON #Order_Subs_Movements_2 (Subs_Change_Rnk);

GO
UPDATE #Order_Subs_Movements_2
SET Active_subscriber = 1
WHERE Number_Of_Active_Subs > 0 AND ALC_Prod_Holding_Rnk = 1 AND ALC_Record_Rnk = 1;
GO
-- Update effective from and to dates for each leg of the subs hists
UPDATE #Order_Subs_Movements_2 osm
SET Effective_From_Dt = Subs_Change_Dt
	-- WHERE Subs_Change_Dt != '1900-01-01'
	;
GO
UPDATE #Order_Subs_Movements_2 osm
SET Effective_To_Dt = osm_2.Subs_Change_Dt
FROM #Order_Subs_Movements_2 osm
INNER JOIN #Order_Subs_Movements_2 osm_2
	ON osm_2.account_number = osm.account_number
		AND osm_2.subscription_id = osm.subscription_id
		AND osm_2.Subs_Change_Rnk = osm.Subs_Change_Rnk + 1
		--  AND osm.Subs_Change_Dt != '1900-01-01'
		;
GO
COMMIT;
GO
-- Delete records where subs didn't actually change on the subs change date
DELETE #Order_Subs_Movements_2 osm
FROM #Order_Subs_Movements_2 osm
INNER JOIN #Order_Subs_Movements_2 osm_2
	ON osm_2.account_number = osm.account_number
		AND osm_2.subscription_id = osm.subscription_id
		AND osm_2.effective_to_dt = osm.effective_from_dt
		AND osm_2.Product_Holding = osm.Product_Holding
		AND osm_2.Number_Of_Active_Subs = osm.Number_Of_Active_Subs
		AND Coalesce(osm_2.Active_Subscriber, 0) = Coalesce(osm.Active_Subscriber, 0)
		AND osm_2.Status_Code = osm.Status_Code;

GO
DROP TABLE IF EXISTS #Status_end_Dates;
GO
-- Recalculate effective to dates now uneccesary records have been removed
SELECT osm.account_number
	,osm.subscription_id
	,osm.effective_from_dt
	,Coalesce(MIN(osm_2.effective_from_dt), CAST('9999-09-09' AS DATE)) AS Effective_To_Dt
INTO #Status_end_Dates
FROM #Order_Subs_Movements_2 osm
LEFT JOIN #Order_Subs_Movements_2 osm_2
	ON osm_2.account_number = osm.account_number
		AND osm_2.subscription_id = osm.subscription_id
		AND osm_2.effective_from_dt > osm.effective_from_dt
GROUP BY osm.account_number
	,osm.subscription_id
	,osm.effective_from_dt;
GO
-- SELECT TOP 100 * FROM #Status_end_Dates;

UPDATE #Order_Subs_Movements_2 osm
SET Effective_To_Dt = osm_2.Effective_To_Dt
FROM #Order_Subs_Movements_2 osm
INNER JOIN #Status_end_Dates osm_2
	ON osm_2.account_number = osm.account_number
		AND osm_2.subscription_id = osm.subscription_id
		AND osm_2.effective_from_dt = osm.effective_from_dt;
GO
COMMIT;
GO
-- Update Effective From and To Subs Week fields
UPDATE #Order_Subs_Movements_2 osm2
SET Effective_From_Subs_Week = CAST(sc.subs_week_and_year AS INTEGER)
FROM #Order_Subs_Movements_2 osm2
INNER JOIN sky_calendar sc
	ON sc.calendar_date = osm2.effective_from_dt
WHERE osm2.Effective_From_Subs_Week IS NULL;

GO

UPDATE #Order_Subs_Movements_2 osm2
SET Effective_To_Subs_Week = CAST(Coalesce(sc.subs_week_and_year, '999999') AS INTEGER)
FROM #Order_Subs_Movements_2 osm2
LEFT JOIN sky_calendar sc
	ON sc.calendar_date = osm2.effective_to_dt
WHERE osm2.Effective_To_Subs_Week IS NULL
	OR osm2.Effective_To_Subs_Week = 999999;

-- SELECT TOP 100 * FROM #Order_Subs_Movements_2 WHERE Subs_Change_Rnk > 1;
GO	
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Makes update to Decisioning.Active_Subscriber_Report
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DELETE
FROM Decisioning.Active_Subscriber_Report_ALC
WHERE Effective_From_Dt >= Refresh_Dt 
    AND subscription_type = 'A-LA-CARTE';
GO
-- Delete records from #Order_Subs_Movements_2 which are a continuation of existing Active_Subscriber_Report table
UPDATE Decisioning.Active_Subscriber_Report_ALC asr
SET effective_to_dt = osm.effective_to_dt
FROM Decisioning.Active_Subscriber_Report_ALC asr
INNER JOIN #Order_Subs_Movements_2 osm
	ON osm.account_number = asr.account_number
		AND osm.subscription_id = asr.subscription_id
		AND osm.Product_Holding = asr.Product_Holding
		AND osm.Status_Code = asr.Status_Code
WHERE osm.Subs_Change_Dt = /*'1900-01-01'*/ Refresh_Dt - 1
	AND Refresh_dt BETWEEN osm.effective_from_dt + 1 AND osm.effective_to_dt
	AND Refresh_dt BETWEEN asr.effective_from_dt + 1 AND asr.effective_to_dt
	AND asr.subscription_sub_type = 'A-LA-CARTE';
GO
DELETE #Order_Subs_Movements_2 osm
WHERE osm.Subs_Change_Dt = Refresh_Dt - 1;
GO
DELETE #Order_Subs_Movements_2 osm
WHERE osm.Subs_Change_Dt = '9999-09-09';
GO
COMMIT;
GO
-- Delete records where there are no active subs to be inserted into ouput table
DELETE
FROM #Order_Subs_Movements_2
WHERE Number_Of_Active_Subs = 0;
GO

-- DROP TABLE IF EXISTS Decisioning.Active_Subscriber_Report_ALC
-- Insert new records into Active_Subscriber_Report table
INSERT INTO Decisioning.Active_Subscriber_Report_ALC (
	Effective_From_Dt
	,Effective_To_Dt
	,Effective_From_Subs_Week
	,Effective_To_Subs_Week
	,Account_Number
	,Account_Type
	,Account_Sub_Type
	,Owning_Cust_Account_ID
	,Subscription_Type
	,Subscription_Sub_Type
	,Service_Instance_ID
	,Subscription_ID
	,Status_Code
	,Current_Product_sk
	,Product_Holding
	,Country
    ,ALC_Active
    ,ALC_Active_Subscription
	)
	
SELECT osm.Effective_From_Dt
	,osm.Effective_To_Dt
	,NULL AS Effective_From_Subs_Week
	,NULL AS Effective_To_Subs_Week
	,osm.Account_Number
	,osm.Account_Type
	,osm.Account_Sub_Type
	,osm.Owning_Cust_Account_ID
	,osm.Subscription_Type
	,osm.Subscription_Sub_Type
	,osm.Service_Instance_ID
	,osm.Subscription_ID
	,osm.Status_Code
	,osm.Current_Product_sk
	-- ,osm.current_product_description
	-- ,osm.ENT_CAT_PROD_SK
	,osm.Product_Holding
	,osm.Country
	,osm.Active_Subscriber AS ALC_Active
	,osm.Number_Of_Active_Subs AS ALC_Active_Subscription
-- INTO Decisioning.Active_Subscriber_Report_ALC
FROM #Order_Subs_Movements_2 osm;
GO
COMMIT;
GO

-- Update Effective From and To Subs Week fields
UPDATE Decisioning.Active_Subscriber_Report_ALC asr
SET Effective_From_Subs_Week = CAST(sc.subs_week_and_year AS INTEGER)
FROM Decisioning.Active_Subscriber_Report_ALC asr
INNER JOIN sky_calendar sc
	ON sc.calendar_date = asr.effective_from_dt
WHERE 
	(
        (asr.subscription_type = 'A-LA-CARTE' AND asr.subscription_sub_type IN ('DTV Chelsea TV', 'LIVERPOOL', 'DTV MUTV'))
	OR 
        (asr.subscription_type = 'ENHANCED' AND asr.subscription_sub_type  = 'SKYASIA')
	)
    AND asr.Effective_From_Subs_Week IS NULL;

GO

UPDATE Decisioning.Active_Subscriber_Report_ALC asr
SET Effective_To_Subs_Week = CAST(Coalesce(sc.subs_week_and_year, '999999') AS INTEGER)
FROM Decisioning.Active_Subscriber_Report_ALC asr
LEFT JOIN sky_calendar sc
	ON sc.calendar_date = asr.effective_to_dt
WHERE 
	(
        (asr.subscription_type = 'A-LA-CARTE' AND asr.subscription_sub_type IN ('DTV Chelsea TV', 'LIVERPOOL', 'DTV MUTV'))
	OR 
        (asr.subscription_type = 'ENHANCED' AND asr.subscription_sub_type  = 'SKYASIA')
	)
    AND (asr.Effective_To_Subs_Week IS NULL OR asr.Effective_To_Subs_Week = 999999);
GO
COMMIT;
GO

/* ======================================== Queries for Testing ========================================

SELECT Effective_From_Dt,Subscription_Sub_Type, SUM(ALC_Active) AS Total_Active, SUM(ALC_Active_Subscription) AS Total_Active_Subscription, COUNT(1) 
FROM Decisioning.Active_Subscriber_Report_ALC
WHERE Effective_From_Dt BETWEEN '2017-06-16' AND '2017-06-22' 
GROUP BY Effective_From_Dt, Subscription_Sub_Type
ORDER BY 2,1;

SELECT TOP 100 * FROM Decisioning.Active_Subscriber_Report_ALC;
SELECT * FROM SP_COLUMNS('Active_Subscriber_Report')

====================================================================================================== */