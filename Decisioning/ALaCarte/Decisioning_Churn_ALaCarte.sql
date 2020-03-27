/**********************************************************************************
** File: Churn_ALaCarte.sql
** Name: Churn_ALaCarte
** Desc: Code for calculating Churn for "A-LA-Carte and SkyAsia"
** Auth: Surya Tiwari, Raunak Jhawar
** Date: 19/07/2017
************************************************************************************
****                                Change History                              ****
************************************************************************************
** Change#  Date        Author              Description 
** --       ---------   -------------       ------------------------------------
** 1        19/07/2017  Surya Tiwari        Refactoring the code
************************************************************************************/
/*
dba.sp_drop_table 'Decisioning','Churn_ALaCarte'
dba.sp_create_table 'Decisioning','Churn_ALaCarte',
   ' Subs_Year decimal default null, '
|| ' Subs_Week_Of_Year int default null, '
|| ' Subs_Week_And_Year int default null, '
|| ' Event_Dt date default null, '
|| ' account_number varchar(20) default null, '
|| ' Account_Type varchar(255) default null, '
|| ' Account_Sub_Type varchar(255) default null, '
|| ' cb_Key_Household bigint default null, '
|| ' Created_By_ID varchar(50) default null, '
|| ' Current_Product_sk decimal default null, '
|| ' Ent_Cat_Prod_sk decimal default null, '
|| ' First_Order_ID varchar(50) default null, '
|| ' Order_ID varchar(50) default null, '
|| ' Order_Line_ID varchar(50) default null, '
|| ' PH_Subs_Hist_sk decimal default null, '
|| ' Service_Instance_ID varchar(50) default null, '
|| ' Subscription_ID varchar(50) default null, '
|| ' Owning_Cust_Account_ID varchar(50) default null, '
|| ' Movement_Type varchar(10) default null, '
|| ' subscription_type varchar(20) default null, '
|| ' subscription_sub_type varchar(80) default null, '
|| ' Product_Holding varchar(240) default null, '
|| ' Country char(3) default null, '
|| ' Churn_Type varchar(14) default null, '
|| ' Same_Day_Prev_Status_Move smallint default 0, '
|| ' Same_Day_Cancel smallint default 0, '
|| ' Platform_Churn smallint default 0, '
|| ' Product_Churn smallint default 0, '
|| ' PO_Cancellation smallint default 0, '
|| ' SC_Termination smallint default 0, '
|| ' Platform_PO_Cancellation smallint default 0, '
|| ' Platform_SC_Termination smallint default 0 '
*/

Drop variable if exists Refresh_Dt;
Create variable Refresh_Dt date;
Set Refresh_Dt = '1950-06-19';

Call Decisioning_Procs.Update_Decisioning_Churn_ALaCarte('1950-06-19'); 


-- setuser Decisioning_Procs

Drop Procedure If Exists Decisioning_Procs.Update_Decisioning_Churn_ALaCarte;
Create Procedure Decisioning_Procs.Update_Decisioning_Churn_ALaCarte(Refresh_Dt date default null)
SQL SECURITY INVOKER
BEGIN

If Refresh_Dt is null then
BEGIN
Set Refresh_Dt = (Select Max(Event_Dt) - 4*7 from Decisioning.Churn_ALaCarte);
END;
End If;
DROP TABLE IF EXISTS #Churn_ALaCarte;

SET TEMPORARY OPTION Query_Temp_Space_Limit = 0;

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
    ,csh.status_code AS Movement_Type
    ,csh.subscription_type
    ,csh.subscription_sub_type
    ,csh.Current_Product_Description AS Product_Holding
    ,CASE 
        WHEN csh.currency_code = 'EUR' THEN 'ROI'
        ELSE 'UK'
    END Country
    ,CASE 
        WHEN csh_DTV_EoD.account_number IS NULL THEN 'Platform Churn'
        WHEN csh_ALC_EoD.account_number IS NULL THEN 'Product Churn'
    END AS Churn_Type
    ,CASE
        WHEN CAST(csh.PREV_STATUS_START_DT AS date) - CAST(csh.STATUS_START_DT AS date)= 0 THEN 'Y' 
        ELSE 'N' 
    END AS Same_Day_Prev_Status_Move -- Same Day Prev Status Move
    ,CASE 
        WHEN Same_Day_Prev_Status_Move ='Y' AND Movement_Type = 'PO' AND csh.PREV_STATUS_CODE = 'PC' AND csh.STATUS_CODE='PO' THEN 1 
        ELSE 0
    END AS Same_Day_Cancel -- Includes intraday movements activating same day as cancel but excludes customers going direct from AC --> PO
    ,CASE 
        WHEN Churn_Type = 'Platform Churn' THEN 1
        ELSE 0
    END AS Platform_Churn
    ,CASE 
        WHEN Churn_Type = 'Product Churn' THEN 1
        ELSE 0
    END AS Product_Churn

    ,CASE
        WHEN Product_Churn = 1 AND csh.status_code = 'PO' THEN 1
        ELSE 0
    END AS PO_Cancellation
    ,CASE
        WHEN Product_Churn = 1 AND csh.status_code = 'SC' THEN 1
        ELSE 0
    END AS SC_Termination
    
    ,CASE
        WHEN Platform_Churn = 1 AND csh.status_code = 'PO' THEN 1
        ELSE 0
    END AS Platform_PO_Cancellation
    ,CASE
        WHEN Platform_Churn = 1 AND csh.status_code = 'SC' THEN 1
        ELSE 0
    END AS Platform_SC_Termination

INTO #Churn_ALaCarte

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

-- Code to get standard Business date fields
INNER JOIN sky_calendar sc ON CAST(sc.calendar_date as date) = CAST(csh.effective_from_dt as date)

WHERE csh.effective_from_dt >= Refresh_Dt
    AND 
    (
        (csh.subscription_type = 'A-LA-CARTE' AND csh.subscription_sub_type IN ('DTV Chelsea TV', 'LIVERPOOL', 'DTV MUTV'))
    OR 
        (csh.subscription_type = 'ENHANCED' AND csh.subscription_sub_type  = 'SKYASIA')
    )
    AND csh.status_code_changed = 'Y' 
    AND csh.status_code IN ('PO','SC') -- Current status should either be Post Active Cancelled or System Cancelled
    AND csh.prev_status_code IN ('AC', 'AB', 'PC') -- Previous status should any of the Active / Active Blocked / Pending Cancel
    AND csh.effective_from_dt < csh.effective_to_dt 
    AND csh_ALC_SoD.account_number IS NOT NULL -- At Start of Day the account should be active
    AND csh_ALC_EoD.account_number IS NULL; -- At End of Day the account should be inactive


Delete from Decisioning.Churn_ALaCarte where event_dt >= Refresh_dt;

-- Insert into Final Table
INSERT INTO Decisioning.Churn_ALaCarte
SELECT * FROM #Churn_ALaCarte;

/* ======================================== Queries for Testing ========================================

1. Query to test A-La-Carte
SELECT Event_Dt,subscription_sub_type, COUNT(1) 
FROM Decisioning.Churn_ALaCarte
WHERE
subscription_type = 'A-LA-CARTE'
GROUP BY Event_Dt,subscription_sub_type ORDER BY 2,1;

2. Query to test SkyAsia
SELECT Event_Dt,subscription_sub_type, COUNT(1) 
FROM STI18.Churn_ALaCarte
WHERE
subscription_type = 'ENHANCED'
GROUP BY Event_Dt,subscription_sub_type ORDER BY 2,1;

====================================================================================================== */
END;

Grant execute on Decisioning_Procs.Update_Decisioning_Churn_ALaCarte to Decisioning;
