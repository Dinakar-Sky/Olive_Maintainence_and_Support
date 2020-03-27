/*
*********************************************************************************
** File: Activations_BBBOOST.sql
** Name: Activations_BBBOOST
** Desc: Code for calculating Activations for " BBBOOST"
** Auth: Dinakar Karanam, Vikram Haibate
** Date: 14/03/2019
** Last Edit: 14/03/2019
************************************************************************************
****        Change History        ****
************************************************************************************
** Change# Date   Author    		Description 
** --  --------- -------------  	------------------------------------
** 1  19/07/2017 Surya Tiwari       Refactoring the code
** 2  03/01/2017 Vikram Haibate     Add DDL and Procs 
** 3  14/03/2019 Dinakar Karanam    BBBOOST
************************************************************************************/

/*

dba.sp_drop_table 'CITeam','Activations_BBBOOST_beta'
dba.sp_create_table 'CITeam','Activations_BBBOOST_beta',
   'Subs_Year           decimal (       22      )       default         null,'
|| 'Subs_Week_Of_Year           decimal (       5,2     )       default         null,'
|| 'Subs_Week_And_Year          varchar (       6       )       default         null,'
|| 'Event_Dt            date                            default         null,'
|| 'account_number              varchar (       20      )       default         null,'
|| 'Account_Type                varchar (       255     )       default         null,'
|| 'Account_Sub_Type            varchar (       255     )       default         null,'
|| 'cb_Key_Household            bigint                          default         null,'
|| 'Created_By_ID               varchar (       50      )       default         null,'
|| 'Current_Product_sk          decimal (       22      )       default         null,'
|| 'Ent_Cat_Prod_sk             decimal (       22      )       default         null,'
|| 'First_Order_ID              varchar (       50      )       default         null,'
|| 'Order_ID            varchar (       50      )       default         null,'
|| 'Order_Line_ID               varchar (       50      )       default         null,'
|| 'PH_Subs_Hist_sk             decimal (       22      )       default         null,'
|| 'Service_Instance_ID         varchar (       50      )       default         null,'
|| 'Subscription_ID             varchar (       50      )       default         null,'
|| 'Owning_Cust_Account_ID              varchar (       50      )       default         null,'
|| 'Country             char    (       3       )       default         null,'
|| 'subscription_sub_type               varchar (       80      )       default         null,'
|| 'current_product_description         varchar (       240     )       default         null,'
|| 'Activation_Type             char    (       28      )       default         null,'
|| 'Active_BBBOOST_Sub             smallint                                default         0,'
|| 'New_Addition                smallint                                default         0,'
|| 'Existing_Customer_Activation                smallint                                default         0,'
|| 'SC_Platform_Reinstate               smallint                                default         0,'
|| 'PO_Platform_Reinstate               smallint                                default         0,'
|| 'Product_Reinstate           smallint                                default         0'



*/


/* ============================================================================================= */
DROP TABLE IF EXISTS CITeam.Activations_BBBoost_beta;
CREATE TABLE CITeam.Activations_BBBoost_beta(
Subs_Year           decimal (       22      )       default         null,
Subs_Week_Of_Year           decimal (       5,2     )       default         null,
Subs_Week_And_Year          varchar (       6       )       default         null,
Event_Dt            date                            default         null,
account_number              varchar (       20      )       default         null,
Account_Type                varchar (       255     )       default         null,
Account_Sub_Type            varchar (       255     )       default         null,
cb_Key_Household            bigint                          default         null,
Created_By_ID               varchar (       50      )       default         null,
Current_Product_sk          decimal (       22      )       default         null,
Ent_Cat_Prod_sk             decimal (       22      )       default         null,
First_Order_ID              varchar (       50      )       default         null,
Order_ID            varchar (       50      )       default         null,
Order_Line_ID               varchar (       50      )       default         null,
PH_Subs_Hist_sk             decimal (       22      )       default         null,
Service_Instance_ID         varchar (       50      )       default         null,
Subscription_ID             varchar (       50      )       default         null,
Owning_Cust_Account_ID              varchar (       50      )       default         null,
Country             char    (       3       )       default         null,
subscription_sub_type               varchar (       80      )       default         null,
current_product_description         varchar (       240     )       default         null,
Activation_Type             char    (       28      )       default         null,
Active_BBBOOST_Sub             smallint                                default         0,
New_Addition                smallint                                default         0,
Existing_Customer_Activation                smallint                                default         0,
SC_Platform_Reinstate               smallint                                default         0,
PO_Platform_Reinstate               smallint                                default         0,
Product_Reinstate           smallint                                default         0
)
/* ============================================================================================= */
----------------------- SCHEMA NAME TO BE CHANGED FOR ALL CSH REFERENCES -----------------------
-- Setuser Decisioning_Procs
GO 
-- Drop procedure if exists Decisioning_Procs.Update_Decisioning_Activations_BBBOOST;
Drop procedure if exists aqi02.Update_Decisioning_Activations_BBBOOST;
GO
-- Create procedure Decisioning_Procs.Update_Decisioning_Activations_BBBOOST(Refresh_Dt date default null)
Create procedure aqi02.Update_Decisioning_Activations_BBBOOST(Refresh_Dt date default null)
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
-- Set Refresh_Dt = (Select max(event_dt) - 2*7 from Decisioning.Activations_BBBOOST);
Set Refresh_Dt = '2019-07-01';
END
End If;

-- Delete from Decisioning.Activations_BBBOOST where Event_Dt >= Refresh_Dt;
Delete from CITeam.Activations_BBBoost_beta where Event_Dt >= Refresh_Dt;


DROP TABLE IF EXISTS #Activations_BBBOOST;

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
 ,csh.subscription_sub_type
 ,csh.current_product_description
 ,CASE
  WHEN csh.effective_from_dt = Acc_DTV_First_Activation.First_Act_Dt THEN 'NEW CUSTOMER ACTIVATION' 
  WHEN NOT (Acc_BBBOOST_First_Activation.First_Act_Dt < csh.effective_from_dt) THEN 'EXISTING CUSTOMER ACTIVATION' 
  WHEN csh_DTV_SoD.account_number IS NULL AND Acc_BBBOOST_First_Activation.First_Act_Dt < csh.effective_from_dt THEN 'PLATFORM REACTIVATION' 
  ELSE 'PRODUCT REACTIVATION' END Activation_Type
 ,CASE
  WHEN  csh_BBBOOST_EoD.account_number IS NOT NULL THEN 1 
  ELSE 0 
 END Active_SKY_BBBOOST_Sub
 ,CASE 
     WHEN Activation_Type = 'NEW CUSTOMER ACTIVATION' THEN 1
     ELSE 0
 END AS New_Addition
 ,CASE
     WHEN Activation_Type ='EXISTING CUSTOMER ACTIVATION' THEN 1
     ELSE 0
 END AS Existing_Customer_Activation
 ,CASE 
     WHEN csh_DTV_SoD.account_number IS NULL AND csh_DTV_EoD.prev_status_code = 'SC' AND Acc_BBBOOST_First_Activation.First_Act_Dt < csh.effective_from_dt THEN 1
     ELSE 0
 END AS SC_Platform_Reinstate
 ,CASE 
     WHEN csh_DTV_SoD.account_number IS NULL AND csh_DTV_EoD.prev_status_code = 'PO' AND Acc_BBBOOST_First_Activation.First_Act_Dt < csh.effective_from_dt THEN 1
     ELSE 0
 END AS PO_Platform_Reinstate
 ,CASE
     WHEN csh.prev_status_code IN ('PO','SC') THEN 1
     ELSE 0
 END AS Product_Reinstate

INTO #Activations_BBBOOST

FROM  cust_subs_hist csh

-- Code to check availability of DTV as a Base product during Start of Day
LEFT JOIN  cust_subs_hist csh_DTV_SoD ON csh_DTV_SoD.account_number = csh.account_number
 AND csh.status_start_dt BETWEEN csh_DTV_SoD.effective_from_dt + 1 AND csh_DTV_SoD.effective_to_dt
 AND csh_DTV_SoD.subscription_sub_type = 'DTV Primary Viewing'
 AND csh_DTV_SoD.status_code IN ('AC', 'AB', 'PC')

-- Code to check availability of DTV as a Base product during End of Day
LEFT JOIN  cust_subs_hist csh_DTV_EoD ON csh_DTV_EoD.account_number = csh.account_number
 AND csh.status_start_dt BETWEEN csh_DTV_EoD.effective_from_dt AND csh_DTV_EoD.effective_to_dt - 1
 AND csh_DTV_EoD.subscription_sub_type = 'DTV Primary Viewing'
 AND csh_DTV_EoD.status_code IN ('AC', 'AB', 'PC')

-- Code to check availability of BBBOOST during Start of Day
LEFT JOIN  cust_subs_hist  csh_BBBOOST_SoD ON  csh_BBBOOST_SoD.account_number = csh.account_number
 AND csh.status_start_dt BETWEEN  csh_BBBOOST_SoD.effective_from_dt + 1 AND  csh_BBBOOST_SoD.effective_to_dt
 AND  csh_BBBOOST_SoD.subscription_sub_type = 'BBBOOST'
 AND  csh_BBBOOST_SoD.status_code IN ('AC', 'AB', 'PC')

-- Code to check availability of BBBOOST during End of Day  
LEFT JOIN  cust_subs_hist  csh_BBBOOST_EoD ON  csh_BBBOOST_EoD.account_number = csh.account_number
 AND csh.status_start_dt BETWEEN  csh_BBBOOST_EoD.effective_from_dt AND  csh_BBBOOST_EoD.effective_to_dt - 1
 AND  csh_BBBOOST_EoD.subscription_sub_type = 'BBBOOST'
 AND  csh_BBBOOST_EoD.status_code IN ('AC', 'AB', 'PC')

-- Code to get First Activation Date for DTV   
LEFT JOIN (
 SELECT account_number, MIN(status_start_dt) First_Act_Dt
 FROM  cust_subs_hist
 WHERE subscription_sub_type = 'DTV Primary Viewing'
  AND status_code IN ('AC', 'AB', 'PC')
  AND status_start_dt < status_end_dt
 GROUP BY account_number
 ) Acc_DTV_First_Activation ON Acc_DTV_First_Activation.account_number = csh.account_number

-- Code to get First Activation Date for BBBOOST  
LEFT JOIN (
 SELECT account_number, MIN(effective_from_dt) First_Act_Dt
 FROM  cust_subs_hist
 WHERE SUBSCRIPTION_TYPE = 'BB RELATED SUBS'
  AND subscription_sub_type = 'BBBOOST'
  AND status_code IN ('AC', 'AB', 'PC')
  AND effective_from_dt < effective_to_dt
 GROUP BY account_number
 ) Acc_BBBOOST_First_Activation ON Acc_BBBOOST_First_Activation.account_number = csh.account_number

INNER JOIN sky_calendar sc ON sc.calendar_date = csh.effective_from_dt -- To be enabled

WHERE 
         csh.effective_from_dt >= Refresh_Dt
 AND csh.subscription_type = 'BB RELATED SUBS'
 AND csh.subscription_sub_type = 'BBBOOST'
 AND csh.status_code IN ('AC', 'AB', 'PC')
 AND csh.effective_from_dt < csh.effective_to_dt
 AND csh_BBBOOST_SoD.account_number IS NULL
 AND csh_BBBOOST_EoD.account_number IS NOT NULL;

-- INSERT INTO Decisioning.Activations_BBBOOST SELECT * FROM #Activations_BBBOOST;
INSERT INTO CITeam.Activations_BBBoost_beta SELECT * FROM #Activations_BBBOOST;

END
GO
-- Grant Execute on Decisioning_Procs.Update_Decisioning_Activations_BBBOOST to Decisioning;
Grant Execute on aks03.Update_Decisioning_Activations_BBBOOST to public;


/* 
======================================== Queries for Testing ========================================
Call aqi02.Update_Decisioning_Activations_BBBOOST('2019-07-01');

Select top 100 * from Decisioning.Activations_BBBOOST;
Select count(*) from Decisioning.Activations_BBBOOST;
======================================================================================================
*/


select distinct current_product_description from CITeam.Activations_BBBoost_beta