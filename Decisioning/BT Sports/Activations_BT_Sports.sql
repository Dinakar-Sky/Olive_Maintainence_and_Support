/*
*********************************************************************************
** File: Activations_BT_Sports.sql
** Name: Activations_BT_Sports
** Desc: Code for calculating Activations for "BT Sports"
** Date: 16/08/2019
************************************************************************************
****        Change History        ****
************************************************************************************
** Change# Date   Author                  Description 
** --  --------- -------------  ------------------------------------

************************************************************************************

dba.sp_drop_table 'Decisioning','Activations_BT_Sports'
dba.sp_create_table 'Decisioning','Activations_BT_Sports',
   'Subs_Year decimal	(	22	)	default	null,'
|| 'Subs_Week_Of_Year decimal	(	5,2	)	default	null,'
|| 'Subs_Week_And_Year varchar	(	6	)	default	null,'
|| 'Event_Dt date  default	null,'
|| 'account_number varchar	(	20	)	default	null,'
|| 'status_code varchar	(	20	)	default	null,'
|| 'Account_Type varchar	(	255	)	default	null,'
|| 'Account_Sub_Type varchar	(	255	)	default	null,'
|| 'cb_Key_Household bigint  default	null,'
|| 'Created_By_ID varchar	(	50	)	default	null,'
|| 'Current_Product_sk decimal	(	22	)	default	null,'
|| 'Ent_Cat_Prod_sk decimal	(	22	)	default	null,'
|| 'First_Order_ID varchar	(	80	)	default	null,'
|| 'Order_ID varchar	(	80	)	default	null,'
|| 'Order_Line_ID varchar	(	80	)	default	null,'
|| 'PH_Subs_Hist_sk decimal	(	22	)	default	null,'
|| 'Service_Instance_ID varchar	(	50	)	default	null,'
|| 'Subscription_ID varchar	(	80	)	default	null,'
|| 'Owning_Cust_Account_ID varchar	(	50	)	default	null,'
|| 'Country char	(	3	)	default	null,'
|| 'subscription_sub_type varchar	(	80	)	default	null,'
|| 'current_product_description varchar	(	240	)	default	null,'
|| 'Activation_Type char	(	28	)	default	null,'
|| 'Active_BT_Sports_Sub smallint  default	0,'
|| 'New_Addition smallint  default	0,'
|| 'Existing_Customer_Activation smallint  default	0,'
|| 'SC_Platform_Reinstate smallint  default	0,'
|| 'PO_Platform_Reinstate smallint  default	0,'
|| 'Product_Reinstate smallint  default	0,'
|| 'Sport_Extra_HD_Added smallint  default	0'

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'Activations_BT_Sports')
call DBA.sp_DDL ('create', 'view', 'CITeam', 'Activations_BT_Sports',  ' Select * from Decisioning.Activations_BT_Sports')

*/ 

----------------------- SCHEMA NAME TO BE CHANGED FOR ALL CSH REFERENCES ----------------------- 
-- call Decisioning_Procs.Update_Decisioning_Activations_BT_Sports('2019-07-01')

Setuser Decisioning_Procs
GO
Drop procedure if exists Decisioning_Procs.Update_Decisioning_Activations_BT_Sports;
GO
Create procedure Decisioning_Procs.Update_Decisioning_Activations_BT_Sports(Refresh_Dt date default null) 
SQL SECURITY INVOKER

BEGIN
SET TEMPORARY OPTION Query_Temp_Space_Limit = 0;
commit;

/*
Drop variable if exists Refresh_Dt;
Create variable Refresh_Dt date;
Set Refresh_Dt = '2017-06-01';
*/

If Refresh_Dt is null then 
BEGIN 
Set Refresh_Dt = (Select max(event_dt) - 2*7 from Decisioning.Activations_BT_Sports);
END
End If;

Delete from Decisioning.Activations_BT_Sports where Event_Dt >= Refresh_Dt;

DROP TABLE IF EXISTS #Activations_BT_Sports;

SELECT DISTINCT
 sc.Subs_Year AS Subs_Year
 ,sc.Subs_Week_Of_Year AS Subs_Week_Of_Year
 ,sc.Subs_Week_And_Year AS Subs_Week_And_Year
 ,csh.effective_from_dt AS Event_Dt
 ,csh.account_number
 ,csh.status_code
 ,csh.Account_Type
 ,csh.Account_Sub_Type
 ,csh.cb_Key_Household
 ,csh.Created_By_ID
 ,csh.Current_Product_sk
 ,csh.Ent_Cat_Prod_sk
 ,cast(csh.First_Order_ID as varchar(80))
 ,cast(csh.Order_ID as varchar(80))
 ,cast(csh.Order_Line_ID as varchar(80))
 ,csh.PH_Subs_Hist_sk
 ,csh.Service_Instance_ID
 ,cast(csh.Subscription_ID as varchar(80))
 ,csh.Owning_Cust_Account_ID
 ,CASE 
  WHEN csh.currency_code = 'EUR' THEN 'ROI' 
  ELSE 'UK' 
 END Country
 ,csh.subscription_sub_type
 ,csh.current_product_description
 ,CASE 
  WHEN csh.effective_from_dt = Acc_DTV_First_Activation.First_Act_Dt THEN 'NEW CUSTOMER ACTIVATION' 
  WHEN NOT (Acc_BT_Sports_First_Activation.First_Act_Dt < csh.effective_from_dt) THEN 'EXISTING CUSTOMER ACTIVATION' 
  WHEN csh_DTV_SoD.account_number IS NULL AND Acc_BT_Sports_First_Activation.First_Act_Dt < csh.effective_from_dt THEN 'PLATFORM REACTIVATION' 
  ELSE 'PRODUCT REACTIVATION' END Activation_Type
 ,CASE 
  WHEN  csh_BT_Sports_EoD.account_number IS NOT NULL THEN 1 
  ELSE 0 
 END Active_BT_Sports_Sub
 ,CASE 
     WHEN Activation_Type = 'NEW CUSTOMER ACTIVATION' THEN 1
     ELSE 0
 END AS New_Addition
 ,CASE 
     WHEN Activation_Type ='EXISTING CUSTOMER ACTIVATION' THEN 1
     ELSE 0 
 END AS Existing_Customer_Activation
 ,CASE 
     WHEN csh_DTV_SoD.account_number IS NULL AND csh_DTV_EoD.prev_status_code = 'SC' AND Acc_BT_Sports_First_Activation.First_Act_Dt < csh.effective_from_dt THEN 1
     ELSE 0
 END AS SC_Platform_Reinstate
 ,CASE 
     WHEN csh_DTV_SoD.account_number IS NULL AND csh_DTV_EoD.prev_status_code = 'PO' AND Acc_BT_Sports_First_Activation.First_Act_Dt < csh.effective_from_dt THEN 1
     ELSE 0
 END AS PO_Platform_Reinstate
 ,CASE 
     WHEN csh.prev_status_code IN ('PO','SC') THEN 1
     ELSE 0
 END AS Product_Reinstate
 , NULL as Sport_Extra_HD_Added

INTO #Activations_BT_Sports

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

-- Code to check availability of BT Sports during Start of Day  
LEFT JOIN  cust_subs_hist  csh_BT_Sports_SoD ON  csh_BT_Sports_SoD.account_number = csh.account_number
 AND csh.status_start_dt BETWEEN  csh_BT_Sports_SoD.effective_from_dt + 1 AND  csh_BT_Sports_SoD.effective_to_dt
 AND  csh_BT_Sports_SoD.subscription_sub_type in ('Sport Extra','Sport Extra HD')
 AND  csh_BT_Sports_SoD.status_code IN ('AC', 'AB', 'PC')

-- Code to check availability of BT Sports during End of Day  
LEFT JOIN  cust_subs_hist  csh_BT_Sports_EoD ON  csh_BT_Sports_EoD.account_number = csh.account_number
 AND csh.status_start_dt BETWEEN  csh_BT_Sports_EoD.effective_from_dt AND  csh_BT_Sports_EoD.effective_to_dt - 1
 AND  csh_BT_Sports_EoD.subscription_sub_type in ('Sport Extra','Sport Extra HD')
 AND  csh_BT_Sports_EoD.status_code IN ('AC', 'AB', 'PC')

-- Code to get First Activation Date for DTV   
LEFT JOIN (
 SELECT account_number, MIN(status_start_dt) First_Act_Dt
 FROM  cust_subs_hist
 WHERE subscription_sub_type = 'DTV Primary Viewing'
  AND status_code IN ('AC', 'AB', 'PC')
  AND status_start_dt < status_end_dt
 GROUP BY account_number
 ) Acc_DTV_First_Activation ON Acc_DTV_First_Activation.account_number = csh.account_number

-- Code to get First Activation Date for BT Sports 
LEFT JOIN (
 SELECT account_number, MIN(effective_from_dt) First_Act_Dt
 FROM  cust_subs_hist
 WHERE  subscription_type in ('A-LA-CARTE','ENHANCED')
 AND subscription_sub_type in ('Sport Extra','Sport Extra HD')
  AND status_code IN ('AC', 'AB', 'PC')
  AND effective_from_dt < effective_to_dt
 GROUP BY account_number
 ) Acc_BT_Sports_First_Activation ON Acc_BT_Sports_First_Activation.account_number = csh.account_number

INNER JOIN sky_calendar sc ON sc.calendar_date = csh.effective_from_dt -- To be enabled

WHERE
 csh.effective_from_dt>=Refresh_Dt
 AND csh.subscription_type in ('A-LA-CARTE','ENHANCED')
 AND csh.subscription_sub_type in ('Sport Extra','Sport Extra HD')
 AND csh.status_code IN ('AC', 'AB', 'PC')
 AND csh.effective_from_dt < csh.effective_to_dt
 AND  csh_BT_Sports_SoD.account_number IS NULL
 AND  csh_BT_Sports_EoD.account_number IS NOT NULL;


DROP TABLE IF EXISTS #Sport_Extra_Cust;

SELECT a.account_number, a.event_dt, a.subscription_sub_type
INTO #Sport_Extra_Cust
FROM #Activations_BT_Sports a
JOIN #Activations_BT_Sports b 
ON a.account_number = b.account_number 
AND a.event_dt = b.event_dt 
AND a.subscription_sub_type = 'Sport Extra'
AND a.subscription_sub_type <> b.subscription_sub_type
GROUP BY a.account_number, a.event_dt, a.subscription_sub_type; 


UPDATE #Activations_BT_Sports a
SET a.Sport_Extra_HD_Added = 1
FROM #Activations_BT_Sports a
JOIN #Sport_Extra_Cust b
ON a.account_number = b.account_number 
AND a.event_dt = b.event_dt 
AND a.subscription_sub_type = b.subscription_sub_type;


INSERT INTO Decisioning.Activations_BT_Sports SELECT * FROM #Activations_BT_Sports;


END;
GO
Grant Execute on Decisioning_Procs.Update_Decisioning_Activations_BT_Sports to public;
 

/* ======================================== Queries for Testing ========================================

call Decisioning_Procs.Update_Decisioning_Activations_BT_Sports('2017-10-01');
Select top 100 * from Decisioning.Activations_BT_Sports; 
select count(*) from  Decisioning.Activations_BT_Sports;
select activation_type, count(*) from Decisioning.Activations_BT_Sports group by activation_type
====================================================================================================== 
*/



