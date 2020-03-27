/*
*********************************************************************************
** File: Churn_BBBOOST.sql
** Name: Churn_BBBOOST
** Desc: Code for calculating Churn for "BBBOOST"
** Auth: Dinakar Karanam, Vikram Haibate
** Date: 14/03/2019     
************************************************************************************
****                                Change History                              ****
************************************************************************************
** Change#  Date        Author              Description 
** --       ---------   -------------       ------------------------------------
        1               17/11/2017      Raunak Jhawar           First commit
        2       03/01/2018  Vikram Haibate              Added new DDL and Procs
		3	14/03/2019  Dinakar Karanam		BBBOOST
***********************************************************************************


dba.sp_drop_table 'Decisioning','Churn_BBBOOST'
dba.sp_create_table 'Decisioning','Churn_BBBOOST',
  'Subs_Year            decimal (       22      )       default null,'
||'Subs_Week_Of_Year            decimal (       22      )       default null,'
||'Subs_Week_And_Year           varchar (       6       )       default null,'
||'Event_Dt             date                            default null,'
||'account_number               varchar (       20      )       default null,'
||'Account_Type         varchar (       255     )       default null,'
||'Account_Sub_Type             varchar (       255     )       default null,'
||'cb_Key_Household             bigint                          default null,'
||'Created_By_ID                varchar (       50      )       default null,'
||'Current_Product_sk           decimal (       22      )       default null,'
||'Ent_Cat_Prod_sk              decimal (       22      )       default null,'
||'First_Order_ID               varchar (       50      )       default null,'
||'Order_ID             varchar (       50      )       default null,'
||'Order_Line_ID                varchar (       50      )       default null,'
||'PH_Subs_Hist_sk              decimal (       22      )       default null,'
||'Service_Instance_ID          varchar (       50      )       default null,'
||'Subscription_ID              varchar (       50      )       default null,'
||'Movement_Type                varchar (       10      )       default null,'
||'Owning_Cust_Account_ID               varchar (       50      )       default null,'
||'Country              char    (       3       )       default null,'
||'Churn_Type           char    (       14      )       default null,'
||'Same_Day_Cancel              smallint                                default 0,'
||'PO_Cancellation              smallint                                default 0,'
||'SC_Termination               smallint                                default 0,'
||'Platform_Churn               smallint                                default 0,'
||'Product_Churn                smallint                                default 0,'
||'Platform_PO_Cancellation             smallint                                default 0,'
||'Platform_SC_Termination              smallint                                default 0,'
||'subscription_sub_type                varchar (       80      )       default null,'
||'current_product_description          varchar (       240     )       default null,'
||'Subscriber_Level             smallint                                default 0'

*/

Setuser Decisioning_Procs
GO 
Drop procedure if exists Decisioning_Procs.Update_Decisioning_Churn_BBBOOST;
GO
Create procedure Decisioning_Procs.Update_Decisioning_Churn_BBBOOST(Refresh_Dt date default null)
SQL SECURITY INVOKER

BEGIN

SET TEMPORARY OPTION Query_Temp_Space_Limit = 0;
commit;

/*
Drop variable if exists Refresh_Dt;
Create variable Refresh_Dt date;
Set Refresh_Dt = '2019-01-01';
*/

If Refresh_Dt is null then
BEGIN 
Set Refresh_Dt = (Select max(event_dt) - 2*7 from Decisioning.Churn_BBBOOST);
END
End If;

Delete from Decisioning.Churn_BBBOOST where Event_Dt >= Refresh_Dt;

DROP TABLE IF EXISTS #Churn_BBBOOST_Temp;

SELECT
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
,csh.status_code AS Movement_Type
,csh.Owning_Cust_Account_ID
,CASE
    WHEN csh.currency_code = 'EUR' THEN 'ROI'
    ELSE 'UK'
END AS Country
,CASE 
    WHEN DTV_EoD.account_number IS NULL THEN 'Platform Churn'
    WHEN BBBOOST_EoD.account_number IS NULL THEN 'Product Churn'
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
        WHEN Product_Churn = 1 AND csh.status_code = 'PO' THEN 1
        ELSE 0
    END AS PO_Cancellation
    ,CASE
        WHEN Product_Churn = 1 AND csh.status_code = 'SC' THEN 1
        ELSE 0
    END AS SC_Termination

,CASE
    WHEN Churn_Type = 'Platform Churn' THEN 1
    ELSE 0
END AS Platform_Churn
,CASE 
    WHEN Churn_Type = 'Product Churn' THEN 1
    ELSE 0
END AS Product_Churn
,CASE
    WHEN DTV_EoD.account_number IS NULL AND csh.status_code = 'PO' THEN 1
    ELSE 0
END AS Platform_PO_Cancellation
,CASE
    WHEN DTV_EoD.account_number IS NULL AND csh.status_code = 'SC' THEN 1
    ELSE 0
END AS Platform_SC_Termination
,csh.subscription_sub_type
,csh.current_product_description
    
INTO #Churn_BBBOOST_Temp

FROM cust_subs_hist csh
LEFT JOIN cust_subs_hist DTV_SoD ON DTV_SoD.account_number = csh.account_number
    AND csh.status_start_dt BETWEEN DTV_SoD.effective_from_dt + 1 AND DTV_SoD.effective_to_dt
    AND DTV_SoD.subscription_sub_type = 'DTV Primary Viewing'
    AND DTV_SoD.status_code IN ('AC', 'AB', 'PC')
    
LEFT JOIN cust_subs_hist DTV_EoD ON DTV_EoD.account_number = csh.account_number
    AND csh.status_start_dt BETWEEN DTV_EoD.effective_from_dt AND DTV_EoD.effective_to_dt - 1
    AND DTV_EoD.subscription_sub_type = 'DTV Primary Viewing'
    AND DTV_EoD.status_code IN ('AC', 'AB', 'PC')
    
LEFT JOIN cust_subs_hist BBBOOST_SoD ON BBBOOST_SoD.account_number = csh.account_number
    AND csh.status_start_dt BETWEEN BBBOOST_SoD.effective_from_dt + 1 AND BBBOOST_SoD.effective_to_dt
    AND BBBOOST_SoD.subscription_sub_type = 'BBBOOST'
    AND BBBOOST_SoD.status_code IN ('AC', 'AB', 'PC')

LEFT JOIN cust_subs_hist BBBOOST_EoD -- Active MS subs at start of day
    ON BBBOOST_EoD.account_number = csh.account_number
    AND csh.status_start_dt BETWEEN BBBOOST_EoD.effective_from_dt AND BBBOOST_EoD.effective_to_dt - 1
    AND BBBOOST_EoD.subscription_sub_type = 'BBBOOST'
    AND BBBOOST_EoD.status_code IN ('AC', 'AB', 'PC')

INNER JOIN sky_calendar sc ON sc.calendar_date = csh.effective_from_dt

WHERE 
                csh.effective_from_dt >= Refresh_Dt
    AND csh.status_code IN ('CN', 'SC')
        AND csh.subscription_type = 'BB RELATED SUBS'
        AND csh.subscription_sub_type = 'BBBOOST'
    AND csh.prev_status_code IN ('AC','AB','PC')
    AND csh.effective_from_dt < csh.effective_to_dt
    AND BBBOOST_SoD.account_number IS NOT NULL
    AND BBBOOST_EoD.account_number IS NULL;
        
----------------------------------------------------------------------------------------------
-- Add Subscriber Level flag to reoncile the numbers at account level

DROP TABLE IF EXISTS #Churn_BBBOOST;

SELECT 
    Subs_Year
    ,Subs_Week_Of_Year
    ,Subs_Week_And_Year
    ,Event_Dt
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
    ,Movement_Type
    ,Owning_Cust_Account_ID
    ,Country
    ,Churn_Type
    ,Same_Day_Cancel
    ,PO_Cancellation 
    ,SC_Termination
    ,Platform_Churn
    ,Product_Churn
    ,Platform_PO_Cancellation
    ,Platform_SC_Termination
    ,subscription_sub_type
    ,current_product_description
    ,CASE
        WHEN RowNum = 1 THEN 1
        ELSE 0
    END AS Subscriber_Level
INTO #Churn_BBBOOST 
FROM (
    SELECT 
    ROW_NUMBER() OVER (PARTITION BY account_number, Event_Dt, subscription_sub_type, current_product_description ORDER BY Event_Dt DESC) AS RowNum, *
    FROM #Churn_BBBOOST_Temp
) FinalChurn_SGE;
----------------------------------------------------------------------------------------------
-- Insert into final table
INSERT INTO Decisioning.Churn_BBBOOST (
Subs_Year, Subs_Week_Of_Year, Subs_Week_And_Year, Event_Dt, account_number, Account_Type, Account_Sub_Type, 
cb_Key_Household, Created_By_ID, Current_Product_sk, Ent_Cat_Prod_sk, First_Order_ID, Order_ID, Order_Line_ID,
PH_Subs_Hist_sk, Service_Instance_ID, Subscription_ID,Movement_Type, Owning_Cust_Account_ID, Country,
Churn_Type,Same_Day_Cancel,PO_Cancellation ,SC_Termination,Platform_Churn, Product_Churn, Platform_PO_Cancellation, Platform_SC_Termination, 
subscription_sub_type, current_product_description, Subscriber_Level) 

SELECT  Subs_Year, Subs_Week_Of_Year, Subs_Week_And_Year, Event_Dt, account_number, Account_Type, Account_Sub_Type,
cb_Key_Household, Created_By_ID, Current_Product_sk, Ent_Cat_Prod_sk, First_Order_ID, Order_ID, Order_Line_ID, 
PH_Subs_Hist_sk, Service_Instance_ID, Subscription_ID,Movement_Type, Owning_Cust_Account_ID, Country,
Churn_Type,Same_Day_Cancel,PO_Cancellation ,SC_Termination, Platform_Churn, Product_Churn, Platform_PO_Cancellation, Platform_SC_Termination,
subscription_sub_type, current_product_description, Subscriber_Level
FROM #Churn_BBBOOST;

----------------------------------------------------------------------------------------------
-- Drop all temp tables

DROP TABLE IF EXISTS #Churn_BBBOOST_Temp;
END
GO
Grant Execute on Decisioning_Procs.Update_Decisioning_Churn_BBBOOST to Decisioning;

/* 
======================================== Queries for Testing ========================================
call Decisioning_Procs.Update_Decisioning_Churn_BBBOOST('2019-01-01');

select top 10 * from Decisioning.Churn_BBBOOST;

select count(*) from Decisioning.Churn_BBBOOST;
====================================================================================================== 
*/
