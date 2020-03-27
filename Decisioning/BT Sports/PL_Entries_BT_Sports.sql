/*
*********************************************************************************
** File: PL_Entries_BT_Sports.sql
** Name: PL_Entries_BT_Sports
** Desc: Code for calculating Crossgrades for "BT Sports"
** Date: 17/11/2017
************************************************************************************
****								Change History								****
************************************************************************************
** Change#	Date 		Author					Description 
** --		---------	-------------			------------------------------------
***********************************************************************************


dba.sp_drop_table 'Decisioning','PL_Entries_BT_Sports'
dba.sp_create_table 'Decisioning','PL_Entries_BT_Sports',
   'Subs_Year int  default	null,'
|| 'Subs_Week_Of_Year int  default	null,'
|| 'Subs_Week_And_Year int  default	null,'
|| 'event_dt date  default	null,'
|| 'effective_from_dt date  default	null,'
|| 'account_number varchar	(	20	)	default	null,'
|| 'Account_Type varchar	(	255	)	default	null,'
|| 'Account_Sub_Type varchar	(	255	)	default	null,'
|| 'cb_Key_Household bigint  default	null,'
|| 'Created_By_ID varchar	(	50	)	default	null,'
|| 'Current_Product_sk decimal	(	22	) ,'
|| 'Ent_Cat_Prod_sk decimal	(	22	) ,'
|| 'First_Order_ID varchar	(	50	)	default	null,'
|| 'Order_ID varchar	(	50	)	default	null,'
|| 'Order_Line_ID varchar	(	50	)	default	null,'
|| 'PH_Subs_Hist_sk decimal	(	22	) ,'
|| 'Service_Instance_ID varchar	(	50	)	default	null,'
|| 'Subscription_ID varchar	(	50	)	default	null,'
|| 'Owning_Cust_Account_ID varchar	(	50	)	default	null,'
|| 'SUBSCRIPTION_SUB_TYPE varchar	(	80	)	default	null,'
|| 'Product_Holding varchar	(	80	)	default	null,'
|| 'status_code varchar	(	10	)	default	null,'
|| 'Country char	(	3	)	default	null,'
|| 'PC_To_AB int  default	null,'
|| 'AB_Pending_Terminations int  default	null,'
|| 'Same_Day_Cancels int  default	null,'
|| 'Same_Day_PC_Reactivations int  default	null,'
|| 'PC_Pending_Cancellations int  default	null,'
|| 'PO_Total_Reinstate int  default	null,'
|| 'PO_Winback int  default	null,'
|| 'PO_Reinstate_Over12m int  default	null,'
|| 'SC_Total_Reinstate int  default	null,'
|| 'SC_Winback int  default	null,'
|| 'SC_Reinstate_Over12m int  default	null,'
|| 'SC_Gross_Terminations int  default	null,'
|| 'PO_Pipeline_Cancellations int  default	null,'
|| 'PC_Future_Sub_Effective_Dt date  default	null,'
|| 'AB_Future_Sub_Effective_Dt date  default	null,'
|| 'PC_Effective_To_Dt date  default	null,'
|| 'PC_Next_Status_Code varchar	(	15	)	default	null,'
|| 'AB_Effective_To_Dt date  default	null,'
|| 'AB_Next_Status_Code varchar	(	15	)	default	null,'
|| 'Subscriber_Level_PC smallint  default	0,'
|| 'Subscription_Level_PC int  default	null,'
|| 'Subscriber_Level_AB smallint  default	0,'
|| 'Subscription_Level_AB int  default	null,'
|| 'PL_Product_Entry smallint  default	0'

*/
-- call Decisioning_procs.Update_CITeam_PL_Entries_BT_Sports('2019-07-01');
Setuser Decisioning_Procs
GO
Drop procedure if exists Decisioning_procs.Update_CITeam_PL_Entries_BT_Sports;
GO
Create procedure Decisioning_procs.Update_CITeam_PL_Entries_BT_Sports(Refresh_Dt date default null) 
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
Set Refresh_Dt = (Select max(event_dt) - 2*7 from Decisioning.PL_Entries_BT_Sports);
END
End If;

Delete from Decisioning.PL_Entries_BT_Sports where Event_Dt >= Refresh_Dt;


DROP TABLE IF EXISTS  #MoR_Subs_Events;

SELECT   
        effective_from_dt
        ,effective_to_dt
        ,account_number
        ,Account_Type
        ,Account_Sub_Type
        ,cb_Key_Household
        ,Created_By_ID
        ,Current_Product_sk
        ,Ent_Cat_Prod_sk
        ,First_Order_ID
        ,Order_ID
        ,Order_Line_ID
        ,PH_Subs_Hist_sk
        ,Service_Instance_ID
        ,Subscription_ID
        ,Owning_Cust_Account_ID
        ,CASE
                WHEN currency_code = 'EUR' THEN 'ROI'
                ELSE 'UK'
        END Country
        ,COUNT(PH_SUBS_SK) Number_Of_Subs -- Number of Subscriptions
        ,SUBSCRIPTION_SUB_TYPE --Subscription Sub Type
        ,SUBSCRIPTION_SUB_TYPE AS Product_Holding
        ,CURRENCY_CODE -- Currency Code
        ,STATUS_CODE -- Status Code
        ,PREV_STATUS_CODE -- Prev Status Code
        ,STATUS_CODE Movement_Type -- Movement Type
        ,STATUS_START_DT Calendar_Date -- Calendar Date
        ,CASE
                WHEN cast(STATUS_START_DT AS DATE) - cast(STATUS_END_DT AS DATE) = 0 THEN 'Y'
                ELSE 'N'
        END Same_Day_Movement -- Same Day Movement
        ,CASE
                WHEN cast(PREV_STATUS_START_DT AS DATE) - cast(STATUS_START_DT AS DATE) = 0     THEN 'Y'
                ELSE 'N'
        END Same_Day_Prev_Status_Move -- Same Day Prev Status Move
        ,CAST(STATUS_START_DT AS DATE) STATUS_START_DT
        ,CAST(PREV_STATUS_START_DT AS DATE) PREV_STATUS_START_DT
        ,Cast(0 as tinyint) as Active_SGE_Sub_EoD
        ,CASE WHEN csh.subscription_sub_type = 'DTV Primary Viewing' THEN 0 ELSE 1 END AS PL_Product_Entry

INTO #MoR_Subs_Events

FROM cust_subs_hist csh

WHERE  
		csh.effective_from_dt >= Refresh_Dt
	AND csh.subscription_sub_type in ('Sport Extra','Sport Extra HD')
	AND OWNING_CUST_ACCOUNT_ID > '1'
    AND STATUS_CODE_CHANGED = 'Y'
    AND account_number IS NOT NULL
    AND status_code in ('AC','AB','PC') 

GROUP BY
         effective_from_dt
        ,effective_to_dt
        ,account_number
        ,Account_Type
        ,Account_Sub_Type
        ,cb_Key_Household
        ,Created_By_ID
        ,Current_Product_sk
        ,Ent_Cat_Prod_sk
        ,First_Order_ID
        ,Order_ID
        ,Order_Line_ID
        ,PH_Subs_Hist_sk
        ,Service_Instance_ID
        ,Subscription_ID
        ,Owning_Cust_Account_ID
        ,Country
        ,SUBSCRIPTION_SUB_TYPE --Subscription Sub Type
        ,CURRENCY_CODE -- Currency Code
        ,STATUS_CODE -- Status Code
        ,PREV_STATUS_CODE -- Prev Status Code
        ,Calendar_Date -- Calendar Date
        ,Same_Day_Movement -- Same Day Movement
        ,Same_Day_Prev_Status_Move -- Same Day Prev Status Move
        -- Route To Market
        ,STATUS_START_DT
        ,PREV_STATUS_START_DT
        ,PL_Product_Entry;

COMMIT;

CREATE hg INDEX idx_1 ON #MoR_Subs_Events (Account_number);
CREATE hg INDEX idx_2 ON #MoR_Subs_Events (Calendar_Date);

-- Delete reords where one sub counted as SGE goes in PL but another remains active through the day
DELETE #MoR_Subs_Events MoR
FROM #MoR_Subs_Events MoR_2
WHERE MoR.account_number = MoR_2.account_number
        and MoR.effective_from_dt between MoR_2.effective_from_dt + 1 and MoR_2.effective_to_dt - 1
        and MOR.Status_Code in ('AC');


-- --------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS #PL_Entries_BT_Sports;

SELECT
    CAST(NULL AS INT) AS Subs_Year,
    CAST(NULL AS INT) AS Subs_Week_Of_Year,
    CAST(NULL AS INT) AS Subs_Week_And_Year,
    Calendar_Date as event_dt,
    effective_from_dt,
    account_number,
    Account_Type,
    Account_Sub_Type,
    cb_Key_Household,
    Created_By_ID,
    Current_Product_sk,
    Ent_Cat_Prod_sk,
    First_Order_ID,
    Order_ID,
    Order_Line_ID,
    PH_Subs_Hist_sk,
    Service_Instance_ID,
    Subscription_ID,
    Owning_Cust_Account_ID,
    SUBSCRIPTION_SUB_TYPE,
    Product_Holding,
    status_code,
    Country,

    Sum(CASE
      WHEN STATUS_CODE = 'AB' AND PREV_STATUS_CODE = 'PC'
        THEN Number_Of_Subs
      ELSE 0
      END) AS PC_To_AB, -- Includes intraday movements where customer in AB <24Hrs

    Sum(CASE
      WHEN STATUS_CODE = 'AB' AND PREV_STATUS_CODE = 'AC'
        THEN Number_Of_Subs
      ELSE 0
      END) + PC_To_AB AS AB_Pending_Terminations, -- Includes intraday movements where customer in AB <24Hrs

    Sum(CASE
      WHEN Same_Day_Prev_Status_Move = 'Y' AND Movement_Type = 'PO' AND PREV_STATUS_CODE = 'PC' AND STATUS_CODE = 'PO'
        THEN Number_Of_Subs
      ELSE 0
      END) AS Same_Day_Cancels, --Includes intraday movements activating same day as cancel but excludes customers going direct from AC --> PO

    Sum(CASE
      WHEN Same_Day_Prev_Status_Move = 'Y' AND PREV_STATUS_CODE = 'PC' AND STATUS_CODE = 'AC'
        THEN Number_Of_Subs
      ELSE 0
      END) AS Same_Day_PC_Reactivations,
    Sum(CASE
      WHEN STATUS_CODE = 'PC'
        THEN Number_Of_Subs
      ELSE 0
      END) -- Pending Cancels
    - Same_Day_PC_Reactivations + Sum(CASE
      WHEN Same_Day_Prev_Status_Move = 'Y' AND Movement_Type = 'AB' AND PREV_STATUS_CODE = 'PC' AND STATUS_CODE = 'AB'
        THEN Number_Of_Subs
      ELSE 0
      END) --Same Day Active Block
    - Same_Day_Cancels AS PC_Pending_Cancellations,
    Sum(CASE
      WHEN Movement_Type = 'AC' AND PREV_STATUS_CODE = 'PO'
        THEN Number_Of_Subs
      ELSE 0
      END) AS PO_Total_Reinstate, -- Includes intra day POs that reactivate the same day as cancel

    -- Incldues intra day ACs that cancel same day as reinstate
    PO_Total_Reinstate - PO_Reinstate_Over12m AS PO_Winback,
    Sum(CASE
      WHEN Movement_Type = 'AC' AND PREV_STATUS_CODE = 'PO' AND DATEDIFF(month, PREV_STATUS_START_DT, STATUS_START_DT) > 11
        THEN Number_Of_Subs
      ELSE 0
      END) AS PO_Reinstate_Over12m,
    Sum(CASE
      WHEN Movement_Type = 'AC' AND PREV_STATUS_CODE = 'SC'
        THEN Number_Of_Subs
      ELSE 0
      END) SC_Total_Reinstate, -- Includes intra day SCs that reactivate the same day as cancel

    -- Incldues intra day ACs that cancel same day as reinstate
    SC_Total_Reinstate - SC_Reinstate_Over12m AS SC_Winback,
    Sum(CASE
      WHEN Movement_Type = 'AC' AND PREV_STATUS_CODE = 'SC' AND DATEDIFF(month, PREV_STATUS_START_DT, STATUS_START_DT) > 11
        THEN Number_Of_Subs
      ELSE 0
      END) AS SC_Reinstate_Over12m,
    Sum(CASE
      WHEN Movement_Type = 'SC'
        THEN Number_Of_Subs
      ELSE 0
      END) AS SC_Gross_Terminations, -- Includes intrday SCs
    Sum(CASE
      WHEN Movement_Type = 'PO'
        THEN Number_Of_Subs
      ELSE 0
      END) - Same_Day_Cancels AS PO_Pipeline_Cancellations, -- Includes intraday POs,
    PL_Product_Entry,
    CAST(NULL AS DATE) AS PC_Future_Sub_Effective_Dt,
    CAST(NULL AS DATE) AS AB_Future_Sub_Effective_Dt,
    CAST(NULL AS DATE) AS PC_Effective_To_Dt ,
    CAST(NULL AS VARCHAR(15)) AS PC_Next_Status_Code,
    CAST(NULL AS DATE) AS AB_Effective_To_Dt,
    CAST(NULL AS VARCHAR(15)) AS AB_Next_Status_Code
INTO #PL_Entries_BT_Sports
FROM #MoR_Subs_Events

GROUP BY
    event_dt,
        effective_from_dt,
        account_number,
        Account_Type,
        Account_Sub_Type,
        cb_Key_Household,
        Created_By_ID,
        Current_Product_sk,
        Ent_Cat_Prod_sk,
        First_Order_ID,
        Order_ID,
        Order_Line_ID,
        PH_Subs_Hist_sk,
        Service_Instance_ID,
        Subscription_ID,
        Owning_Cust_Account_ID,
        SUBSCRIPTION_SUB_TYPE,
        Product_Holding,
        status_code,
        Country,
        PL_Product_Entry
HAVING PC_To_AB + AB_Pending_Terminations + Same_Day_Cancels + Same_Day_PC_Reactivations + PC_Pending_Cancellations + PO_Total_Reinstate + SC_Total_Reinstate + SC_Gross_Terminations + PO_Pipeline_Cancellations > 0;
-- WHERE #MoR_Subs_Events.Subs_Week_And_Year IS NULL



UPDATE #PL_Entries_BT_Sports MoR
SET Subs_Year = sc.subs_year, Subs_Week_Of_Year = sc.Subs_Week_Of_Year, Subs_Week_And_Year = sc.Subs_Week_And_Year
FROM #PL_Entries_BT_Sports MoR
INNER JOIN sky_calendar sc
    ON sc.calendar_date = MoR.Event_dt
WHERE MoR.Subs_Week_And_Year IS NULL;




--------------------------------------------------------------------------------------
------------------------- Add Future Subs Effective Dt -------------------------------
--------------------------------------------------------------------------------------
DROP TABLE IF EXISTS #PC_Future_Effective_Dt;

SELECT MoR.account_number, 
     MoR.event_dt, 
     csh.status_end_dt status_end_dt, 
     csh.future_sub_effective_dt,
     csh.effective_from_datetime, 
     csh.effective_to_datetime,
     ROW_NUMBER() OVER (PARTITION BY MoR.account_number, MoR.event_dt ORDER BY csh.effective_from_datetime DESC) PC_Rnk
INTO #PC_Future_Effective_Dt
FROM #PL_Entries_BT_Sports MoR
INNER JOIN cust_subs_hist csh
ON csh.account_number = MoR.account_number 
    AND csh.status_start_dt = MoR.Event_dt 
    AND csh.status_end_dt >= '2017-06-01' 
   -- AND (csh.subscription_sub_type = 'Sky Go Extra' OR (csh.subscription_sub_type = 'DTV Primary Viewing' AND csh.current_short_description LIKE '%1M1024%'))
    AND csh.subscription_sub_type in ('Sport Extra','Sport Extra HD')
	AND csh.OWNING_CUST_ACCOUNT_ID > '1' 
    AND csh.STATUS_CODE_CHANGED = 'Y' 
    AND csh.status_code = 'PC'
WHERE Same_Day_Cancels > 0 OR PC_Pending_Cancellations > 0 OR Same_Day_PC_Reactivations > 0 AND (MoR.PC_Effective_To_Dt IS NULL OR MoR.PC_Future_Sub_Effective_Dt IS NULL);


DELETE
FROM #PC_Future_Effective_Dt
WHERE PC_Rnk > 1;


COMMIT;


UPDATE #PL_Entries_BT_Sports MoR
SET MoR.PC_Future_Sub_Effective_Dt = PC.future_sub_effective_dt
FROM #PL_Entries_BT_Sports MoR
INNER JOIN #PC_Future_Effective_Dt PC
  ON PC.account_number = MoR.account_number AND pc.event_dt = MoR.event_dt;


COMMIT;


DROP TABLE IF EXISTS #PC_Status_Change;

SELECT MoR.account_number, 
       MoR.event_dt, 
       csh.status_end_dt PC_Effective_To_dt, 
       Cast(NULL AS VARCHAR(10)) AS Next_Status_Code, 
       ROW_NUMBER() OVER (PARTITION BY MoR.account_number, MoR.event_dt ORDER BY status_end_dt DESC) Status_change_rnk
INTO #PC_Status_Change
FROM #PL_Entries_BT_Sports MoR
INNER JOIN cust_subs_hist csh
  ON CSH.account_number = MoR.account_number 
    AND csh.status_start_dt = MoR.event_dt 
    AND csh.status_end_dt >= MoR.event_dt 
   -- AND (csh.subscription_sub_type = 'Sky Go Extra' OR (csh.subscription_sub_type = 'DTV Primary Viewing' AND csh.current_short_description LIKE '%1M1024%'))
     AND csh.subscription_sub_type in ('Sport Extra','Sport Extra HD')
	AND csh.status_code = 'PC' 
    AND csh.status_code_changed = 'Y'
WHERE (Same_Day_Cancels > 0 OR PC_Pending_Cancellations > 0 OR Same_Day_PC_Reactivations > 0) AND MoR.PC_Effective_To_Dt IS NULL;

UPDATE #PC_Status_Change MoR
SET Next_Status_Code = csh.status_code
FROM #PC_Status_Change MoR
INNER JOIN cust_subs_hist CSH
  ON CSH.account_number = MoR.account_number 
  AND CSH.status_start_dt = MoR.PC_Effective_To_dt
 -- AND (csh.subscription_sub_type = 'Sky Go Extra' OR (csh.subscription_sub_type = 'DTV Primary Viewing' AND csh.current_short_description LIKE '%1M1024%'))
 AND csh.subscription_sub_type in ('Sport Extra','Sport Extra HD')
 AND csh.prev_status_code = 'PC' AND csh.status_code != 'PC' AND csh.status_code_changed = 'Y';


UPDATE #PL_Entries_BT_Sports
SET PC_Effective_To_Dt = CSH.PC_Effective_To_dt, PC_Next_Status_Code = CSH.Next_Status_Code
FROM #PL_Entries_BT_Sports MoR
INNER JOIN #PC_Status_Change CSH
  ON CSH.account_number = MoR.account_number AND CSH.event_dt = MoR.event_dt
WHERE Status_change_rnk = 1;


/*
Code for AB blocks
*/
DROP TABLE IF EXISTS #AB_Status_Change;

SELECT MoR.account_number, 
       MoR.event_dt, 
       CSH.status_end_dt AB_Effective_To_dt, 
       Cast(NULL AS VARCHAR(10)) AS Next_Status_Code, 
       Row_number() OVER (PARTITION BY MoR.account_number, MoR.event_dt ORDER BY status_end_dt DESC) Status_change_rnk
INTO #AB_Status_Change
FROM #PL_Entries_BT_Sports MoR
INNER JOIN cust_subs_hist CSH
  ON CSH.account_number = MoR.account_number 
    AND CSH.status_start_dt = MoR.event_dt
    AND csh.status_end_dt >= MoR.event_dt 
   -- AND (csh.subscription_sub_type = 'Sky Go Extra' OR (csh.subscription_sub_type = 'DTV Primary Viewing' AND csh.current_short_description LIKE '%1M1024%'))
    AND csh.subscription_sub_type in ('Sport Extra','Sport Extra HD')
	AND csh.status_code = 'AB' 
    AND csh.status_code_changed = 'Y'
WHERE MOR.AB_Pending_Terminations > 0 AND MoR.AB_Effective_To_Dt IS NULL;
    

UPDATE #AB_Status_Change MoR
SET Next_Status_Code = csh.status_code
FROM #AB_Status_Change MoR
INNER JOIN cust_subs_hist CSH
  ON CSH.account_number = MoR.account_number 
  AND CSH.status_start_dt = MoR.AB_Effective_To_dt 
  -- AND (csh.subscription_sub_type = 'Sky Go Extra' OR (csh.subscription_sub_type = 'DTV Primary Viewing' AND csh.current_short_description LIKE '%1M1024%'))
  AND csh.subscription_sub_type in ('Sport Extra','Sport Extra HD')
  AND csh.prev_status_code = 'AB' AND csh.status_code != 'AB' AND csh.status_code_changed = 'Y';


UPDATE #PL_Entries_BT_Sports
SET AB_Effective_To_Dt = CSH.AB_Effective_To_dt, 
AB_Next_Status_Code = CSH.Next_Status_Code
FROM #PL_Entries_BT_Sports MoR
INNER JOIN #AB_Status_Change CSH
  ON CSH.account_number = MoR.account_number AND CSH.event_dt = MoR.event_dt
WHERE Status_change_rnk = 1;


UPDATE #PL_Entries_BT_Sports MoR
SET MoR.AB_Future_Sub_Effective_Dt = Cast(event_dt + 50 AS DATE)
WHERE AB_Pending_Terminations > 0 AND (AB_Effective_To_Dt IS NULL OR AB_Future_Sub_Effective_Dt IS NULL);



INSERT INTO Decisioning.PL_Entries_BT_Sports 
(Subs_Year,
Subs_Week_Of_Year,
Subs_Week_And_Year,
event_dt,
effective_from_dt,
account_number,
Account_Type,
Account_Sub_Type,
cb_Key_Household,
Created_By_ID,
Current_Product_sk,
Ent_Cat_Prod_sk,
First_Order_ID,
Order_ID,
Order_Line_ID,
PH_Subs_Hist_sk,
Service_Instance_ID,
Subscription_ID,
Owning_Cust_Account_ID,
SUBSCRIPTION_SUB_TYPE,
Product_Holding,
status_code,
Country,
PC_To_AB,
AB_Pending_Terminations,
Same_Day_Cancels,
Same_Day_PC_Reactivations,
PC_Pending_Cancellations,
PO_Total_Reinstate,
PO_Winback,
PO_Reinstate_Over12m,
SC_Total_Reinstate,
SC_Winback,
SC_Reinstate_Over12m,
SC_Gross_Terminations,
PO_Pipeline_Cancellations,
PC_Future_Sub_Effective_Dt,
AB_Future_Sub_Effective_Dt,
PC_Effective_To_Dt,
PC_Next_Status_Code,
AB_Effective_To_Dt,
AB_Next_Status_Code,
Subscriber_Level_PC, 
Subscription_Level_PC, 
Subscriber_Level_AB, 
Subscription_Level_AB,
PL_Product_Entry
)
SELECT 
PL.Subs_Year,
PL.Subs_Week_Of_Year,
PL.Subs_Week_And_Year,
PL.event_dt,
PL.effective_from_dt,
PL.account_number,
PL.Account_Type,
PL.Account_Sub_Type,
PL.cb_Key_Household,
PL.Created_By_ID,
PL.Current_Product_sk,
PL.Ent_Cat_Prod_sk,
PL.First_Order_ID,
PL.Order_ID,
PL.Order_Line_ID,
PL.PH_Subs_Hist_sk,
PL.Service_Instance_ID,
PL.Subscription_ID,
PL.Owning_Cust_Account_ID,
PL.SUBSCRIPTION_SUB_TYPE,
PL.Product_Holding,
PL.status_code,
PL.Country,
PL.PC_To_AB,
PL.AB_Pending_Terminations,
PL.Same_Day_Cancels,
PL.Same_Day_PC_Reactivations,
PL.PC_Pending_Cancellations,
PL.PO_Total_Reinstate,
PL.PO_Winback,
PL.PO_Reinstate_Over12m,
PL.SC_Total_Reinstate,
PL.SC_Winback,
PL.SC_Reinstate_Over12m,
PL.SC_Gross_Terminations,
PL.PO_Pipeline_Cancellations,
PL.PC_Future_Sub_Effective_Dt,
PL.AB_Future_Sub_Effective_Dt,
PL.PC_Effective_To_Dt,
PL.PC_Next_Status_Code,
PL.AB_Effective_To_Dt,
PL.AB_Next_Status_Code,
CASE 
    WHEN PL.status_code = 'PC' AND ACT.account_number IS NULL THEN 1 ELSE 0
END AS Subscriber_Level_PC, 
CASE 
    WHEN PL.status_code = 'PC' AND Subscriber_Level_PC = 0 THEN COUNT(1) OVER(PARTITION BY PL.account_number, PL.Event_Dt, PL.subscription_id) ELSE 0 
END AS Subscription_Level_PC,
CASE 
    WHEN PL.status_code = 'AB' AND ACT.account_number IS NULL THEN 1 ELSE 0
END AS Subscriber_Level_AB, 
CASE 
    WHEN PL.status_code = 'AB' AND Subscriber_Level_AB = 0 THEN COUNT(1) OVER(PARTITION BY PL.account_number, PL.Event_Dt, PL.subscription_id) ELSE 0 
END AS Subscription_Level_AB,
PL_Product_Entry

FROM #PL_Entries_BT_Sports PL LEFT JOIN CITeam.Activations_BT_Sports ACT
ON PL.account_number = ACT.account_number AND PL.Event_Dt = ACT.Event_Dt
AND PL.subscription_sub_type = ACT.subscription_sub_type;


END;
GO
Grant Execute on Decisioning_procs.Update_CITeam_PL_Entries_BT_Sports to public;

/* ======================================== Queries for Testing ========================================
call Decisioning_procs.Update_CITeam_PL_Entries_BT_Sports('2017-10-01');
SELECT TOP 1000 * FROM CITeam.PL_Entries_BT_Sports;
select count(*) from CITeam.PL_Entries_BT_Sports;


call DBA.sp_DDL ('drop', 'view', 'CITeam', 'PL_Entries_BT_Sports');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'PL_Entries_BT_Sports',  'select * from CITeam.PL_Entries_BT_Sports');

====================================================================================================== */
