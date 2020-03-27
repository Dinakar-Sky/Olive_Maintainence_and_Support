/*
*********************************************************************************
** File: Crossgrades_DTV.sql
** Name: Crossgrades_DTV
** Desc: Code for calculating Crossgrades for "DTV"
** Auth: Raunak Jhawar
** Date: 30/08/2017
************************************************************************************
****                                                            Change History                                                          ****
************************************************************************************
** Change#      Date            Author                          Description
** --           ---------       -------------           ------------------------------------
** 1
***********************************************************************************
*/


/*
dba.sp_drop_table 'Decisioning','Crossgrades_DTV'
dba.sp_create_table 'Decisioning','Crossgrades_DTV',
   'Subs_Year integer default null, '
|| 'Subs_Quarter_Of_Year tinyint default null, '
|| 'Subs_Week_Of_Year integer default null, '
|| 'Subs_Week_And_Year integer default null, '
|| 'Event_Dt date default null, '

|| 'Account_Number varchar(20) default null, '
|| 'Owning_Cust_Account_ID varchar(50) default null, '
|| 'Account_Type varchar(255) default null, '
|| 'Account_Sub_Type  varchar(255) default null, '
|| 'cb_Key_Household bigint default null, '
|| 'Created_By_ID varchar(50) default null, '
|| 'Current_Product_sk integer default null, '
|| 'Ent_Cat_Prod_sk integer default null, '
|| 'First_Order_ID varchar(50) default null, '
|| 'Order_ID varchar(50) default null, '
|| 'Order_Line_ID varchar(50) default null, '
|| 'PH_Subs_Hist_sk decimal(22,0) default null, '
|| 'Service_Instance_ID varchar(50) default null, '
|| 'Subscription_ID varchar(50) default null, '
|| 'Country varchar(3) default null, '
|| 'Base_Product_Holding_SoD varchar(255) default null, '
|| 'Product_Holding_SoD varchar(255) default null, '
|| 'Base_Product_Holding_EoD varchar(255) default null, '
|| 'Product_Holding_EoD varchar(255) default null, '

|| 'Base_Prod_Spin_Up tinyint default 0, '
|| 'Base_Prod_Spin_Down tinyint default 0, '
|| 'Base_Prod_Regrade tinyint default 0, '
|| 'Spin_Up tinyint default 0, '
|| 'Spin_Down tinyint default 0, '
|| 'DTV_Regrade tinyint default 0 '


Create lf index idx_1 on Decisioning.Crossgrades_DTV (Subs_Year);
Create lf index idx_2 on Decisioning.Crossgrades_DTV (Subs_Quarter_Of_Year);
Create lf index idx_3 on Decisioning.Crossgrades_DTV (Subs_Week_Of_Year);
Create hg index idx_4 on Decisioning.Crossgrades_DTV (Subs_Week_And_Year);
Create date index idx_5 on Decisioning.Crossgrades_DTV (Event_Dt);
Create hg index idx_6 on Decisioning.Crossgrades_DTV (Owning_Cust_Account_ID);
Create hg index idx_7 on Decisioning.Crossgrades_DTV (Account_Number);

Create lf index idx_8 on Decisioning.Crossgrades_DTV (Country);
Create lf index idx_9 on Decisioning.Crossgrades_DTV (Product_Holding_SoD);
Create lf index idx_10 on Decisioning.Crossgrades_DTV (Product_Holding_EoD);
Create lf index idx_11 on Decisioning.Crossgrades_DTV (Base_Prod_Spin_Up);
Create lf index idx_12 on Decisioning.Crossgrades_DTV (Base_Prod_Spin_Down);
Create lf index idx_13 on Decisioning.Crossgrades_DTV (Base_Prod_Regrade);
Create lf index idx_14 on Decisioning.Crossgrades_DTV (Spin_Up);
Create lf index idx_15 on Decisioning.Crossgrades_DTV (Spin_Down);
Create lf index idx_16 on Decisioning.Crossgrades_DTV (DTV_Regrade);
Create lf index idx_17 on Decisioning.Crossgrades_DTV (Base_Product_Holding_SoD);
Create lf index idx_18 on Decisioning.Crossgrades_DTV (Base_Product_Holding_EoD);

*/

Setuser Decisioning_Procs
GO 
Drop procedure if exists Decisioning_Procs.Update_Decisioning_Crossgrades_DTV;
GO
Create procedure Decisioning_Procs.Update_Decisioning_Crossgrades_DTV(Refresh_Dt date default null)
SQL SECURITY INVOKER
BEGIN

If Refresh_Dt is null then
BEGIN
Set Refresh_Dt = (Select max(event_dt) - 2*7 from Decisioning.Crossgrades_DTV);
END
End If;

DROP TABLE IF EXISTS #Crossgrades_DTV;

SELECT --top 1000
         csh.effective_from_dt AS Event_Dt
        ,csh.account_number
        ,csh.OWNING_CUST_ACCOUNT_ID
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
        ,CASE WHEN csh.currency_code = 'EUR' THEN 'ROI' ELSE 'UK' END AS Country
        ,csh.status_code
INTO #Crossgrades_CSH
FROM cust_subs_hist csh
WHERE csh.effective_from_dt>= Refresh_dt --BETWEEN '2017-06-01' AND '2017-06-30'
        AND csh.subscription_sub_type = 'DTV Primary Viewing'
        AND csh.status_code IN ('AC', 'AB', 'PC')
        and csh.account_number != '99999999999999'
        and csh.OWNING_CUST_ACCOUNT_ID  >  '1'
        and csh.SI_LATEST_SRC  =  'CHORD'
        AND csh.effective_from_dt < csh.effective_to_dt
        ;

commit;
create hg index idx_1 on #Crossgrades_CSH(account_number);
create hg index idx_2 on #Crossgrades_CSH(subscription_id);
create date index idx_3 on #Crossgrades_CSH(event_dt);



Select csh.*
        ,csh_DTV_SoD.effective_to_dt SoD_Effective_To_Dt
        ,csh_DTV_SoD.current_product_description AS Prev_Product_Desc
        ,Case when csh_DTV_SoD.current_fo_src_system_catalogue_id In ('14015','14016','14017','14018','14019','14020','14021','14022','14023','14024','14025','14026','14027','14028','14029','14030') then 'Sky Q'
              when csh_DTV_SoD.current_fo_src_system_catalogue_id In ('13876','13877','13878','13879','13880','13881','13882','13883','13884','13885','13886','13887','13888','13889','13890','13891') then 'Box Sets'
              when csh_DTV_SoD.current_fo_src_system_catalogue_id In ('13697','13698','13699','13700','13701','13702','13703','13704','13705','13706','13707','13708','13709','13710','13711','13712') then 'Variety'
              when csh_DTV_SoD.current_fo_src_system_catalogue_id In ('13713','13714','13715','13716','13717','13718','13719','13720','13721','13722','13723','13724','13725','13726','13727','13728','14042','14043','14044','14045','14046','14047','14048','14049','14050','14051','14052','14053','14054','14055','14056','14057') then 'Original (Legacy)'
              when csh_DTV_SoD.current_fo_src_system_catalogue_id In ('14230','14231','14232','14233','14234','14235','14236','14237','14238','14239','14240','14241','14242','14243','14244','14245') then 'Original (Legacy 2017)'
              when csh_DTV_SoD.current_fo_src_system_catalogue_id In ('14380','14381','14382','14383','14384','14385','14386','14387','14388','14389','14390','14391','14392','14393','14394','14395') then 'Original'
              when csh_DTV_SoD.current_product_description LIKE 'Sky Entertainment%' then 'Sky Entertainment'
 --             when CEL_SOD.Basic_Desc In ('1 Mix-YNNNNN','1 Mix-NNNYNN','2 Mix-YNNYNN','1 Mix-NNNNNN','0 Mix-NNNNNN','') then 'Original (Legacy)'
 --             when CEL_SOD.Basic_Desc In ('6 Mix-NNNNNN') then 'Variety'
              when csh_DTV_SoD.current_product_description like 'Sky Q%' then 'Sky Q'
              when csh_DTV_SoD.current_product_description like '6 Mix%' then 'Variety'
              when csh_DTV_SoD.current_product_description like 'Kids%' then 'Variety'
              when csh_DTV_SoD.current_product_description like 'Variety%' then 'Variety'
              when csh_DTV_SoD.current_product_description like 'Knowledge%' then 'Variety'
              when csh_DTV_SoD.current_product_description like 'News%' then 'Variety'
              when csh_DTV_SoD.current_product_description like 'Music%' then 'Variety'
              when csh_DTV_SoD.current_product_description like 'Sky%' then 'Variety'
              when csh_DTV_SoD.current_product_description like 'Style%' then 'Variety'
              when csh_DTV_SoD.current_product_description like 'Extra%' then 'Variety'
              else 'Original (Legacy)'
        end as Product_Description_1_SoD
       ,Case when csh_DTV_SoD.current_fo_src_system_catalogue_id In ('13710','13726','13889','14055','14243','14393') then ' with Cinema 1'
             when csh_DTV_SoD.current_fo_src_system_catalogue_id In ('13711','13727','13890','14056','14244','14394') then ' with Cinema 2'
             when csh_DTV_SoD.current_fo_src_system_catalogue_id In ('13708','13724','13887','14053','14241','14391') then ' with Sports 1'
             when csh_DTV_SoD.current_fo_src_system_catalogue_id In ('13709','13725','13888','14054','14242','14392') then ' with Sports 2'
             when csh_DTV_SoD.current_fo_src_system_catalogue_id In ('13704','13720','13883','14049','14237','14387') then ' with Sports 1 & Cinema 1'
             when csh_DTV_SoD.current_fo_src_system_catalogue_id In ('13705','13721','13884','14050','14238','14388') then ' with Sports 1 & Cinema 2'
             when csh_DTV_SoD.current_fo_src_system_catalogue_id In ('13706','13722','13885','14051','14239','14389') then ' with Sports 2 & Cinema 1'
             when csh_DTV_SoD.current_fo_src_system_catalogue_id In ('13707','13723','13886','14052','14240','14390') then ' with Sports 2 & Cinema 2'
             when csh_DTV_SoD.current_fo_src_system_catalogue_id In ('13699','13715','13878','14044','14017','14232','14382') then ' with Cinema'
             when csh_DTV_SoD.current_fo_src_system_catalogue_id In ('13698','13714','13877','14043','14016','14231','14381') then ' with Sports'
             when csh_DTV_SoD.current_fo_src_system_catalogue_id In ('13697','13713','13876','14042','14015','14230','14380') then ' with Sports & Cinema'
             when csh_DTV_SoD.current_fo_src_system_catalogue_id In ('13702','13718','13881','14047','14235','14385') then ' with Sports 1 & Cinema'
             when csh_DTV_SoD.current_fo_src_system_catalogue_id In ('13703','13719','13882','14048','14236','14386') then ' with Sports 2 & Cinema'
             when csh_DTV_SoD.current_fo_src_system_catalogue_id In ('13700','13716','13879','14045','14233','14383') then ' with Sports & Cinema 1'
             when csh_DTV_SoD.current_fo_src_system_catalogue_id In ('13701','13717','13880','14046','14234','14384') then ' with Sports & Cinema 2'
             when csh_DTV_SoD.current_product_description like 'Sky World%' then ' with Sports & Cinema'
             when csh_DTV_SoD.current_product_description like '%with Family Pack - 1B' then ' with Cinema'
             when csh_DTV_SoD.current_product_description like '%with Family Pack - 1C' then ' with Sports'
             when csh_DTV_SoD.current_product_description like '%with Family Pack - 1J' then ' with Sports 1 & Cinema 2'
             when csh_DTV_SoD.current_product_description like '%with Movies Mix' then ' with Cinema'
             when csh_DTV_SoD.current_product_description like '%with Sports Mix' then ' with Sports'
             when csh_DTV_SoD.current_product_description like '%with Movies 1' then ' with Cinema 1'
             when csh_DTV_SoD.current_product_description like '%with Movies 2' then ' with Cinema 2'
             when csh_DTV_SoD.current_product_description like '%with Sports 1' then ' with Sports 1'
             when csh_DTV_SoD.current_product_description like '%with Sports 2' then ' with Sports 2'
             when csh_DTV_SoD.current_product_description like '%with Sports 1 & Movies 1' then ' with Sports 1 & Cinema 1'
             when csh_DTV_SoD.current_product_description like '%with Sports 1 & Movies 2' then ' with Sports 1 & Cinema 2'
             when csh_DTV_SoD.current_product_description like '%with Sports 2 & Movies 1' then ' with Sports 2 & Cinema 1'
             when csh_DTV_SoD.current_product_description like '%with Sports 2 & Movies 2' then ' with Sports 2 & Cinema 2'
             when csh_DTV_SoD.current_product_description like '%with Sports 1 & Movies Mix' then ' with Sports 1 & Cinema'
             when csh_DTV_SoD.current_product_description like '%with Sports 2 & Movies Mix' then ' with Sports 2 & Cinema'
             when csh_DTV_SoD.current_product_description like '%with Sports Mix & Movies 1' then ' with Sports & Cinema 1'
             when csh_DTV_SoD.current_product_description like '%with Sports Mix & Movies 2' then ' with Sports & Cinema 2'
             when csh_DTV_SoD.current_product_description like '%with Sports Mix & Movies Mix' then ' with Sports & Cinema'
       end as Product_Description_2_SoD
        ,Product_Description_1_SoD || Product_Description_2_SoD as Product_Holding_SoD
 --       ,CEL_SOD.SHORT_DESCRIPTION AS PREV_SHORT_DESCRIPTION
 --       ,CEL_SOD.GENRE AS PREV_PACKAGE_DESC
 --       ,CEL_SOD.BASE_DESC AS PREV_BASE_DESC
        ,csh_DTV_SoD.x_ent_current_contribution_gbp AS Prev_Contribution_GBP
INTO #Crossgrades_SoD

FROM #Crossgrades_CSH csh

     INNER JOIN
     cust_subs_hist csh_DTV_SoD
        ON csh_DTV_SoD.account_number = csh.account_number
                AND csh_DTV_SoD.subscription_id = csh.subscription_id
                AND csh.Event_dt BETWEEN csh_DTV_SoD.effective_from_dt + 1 AND csh_DTV_SoD.effective_to_dt
                AND csh_DTV_SoD.subscription_sub_type = 'DTV Primary Viewing'
                AND csh_DTV_SoD.status_code IN ('AC', 'AB', 'PC')

--     INNER JOIN
--     cust_entitlement_lookup CEL_SOD
--        ON CEL_SOD.short_description = csh_DTV_SoD.current_short_description

WHERE csh_DTV_SoD.account_number IS NOT NULL
        ;

commit;
create hg index idx_1 on #Crossgrades_SoD(account_number);
create hg index idx_2 on #Crossgrades_SoD(subscription_id);
create date index idx_3 on #Crossgrades_SoD(event_dt);














Select csh.*
        ,csh_DTV_EoD.Effective_From_Dt EoD_Effective_From_Dt
        ,Case when csh_DTV_EoD.current_fo_src_system_catalogue_id In ('14015','14016','14017','14018','14019','14020','14021','14022','14023','14024','14025','14026','14027','14028','14029','14030') then 'Sky Q'
              when csh_DTV_EoD.current_fo_src_system_catalogue_id In ('13876','13877','13878','13879','13880','13881','13882','13883','13884','13885','13886','13887','13888','13889','13890','13891') then 'Box Sets'
              when csh_DTV_EoD.current_fo_src_system_catalogue_id In ('13697','13698','13699','13700','13701','13702','13703','13704','13705','13706','13707','13708','13709','13710','13711','13712') then 'Variety'
              when csh_DTV_EoD.current_fo_src_system_catalogue_id In ('13713','13714','13715','13716','13717','13718','13719','13720','13721','13722','13723','13724','13725','13726','13727','13728','14042','14043','14044','14045','14046','14047','14048','14049','14050','14051','14052','14053','14054','14055','14056','14057') then 'Original (Legacy)'
              when csh_DTV_EoD.current_fo_src_system_catalogue_id In ('14230','14231','14232','14233','14234','14235','14236','14237','14238','14239','14240','14241','14242','14243','14244','14245') then 'Original (Legacy 2017)'
              when csh_DTV_EoD.current_fo_src_system_catalogue_id In ('14380','14381','14382','14383','14384','14385','14386','14387','14388','14389','14390','14391','14392','14393','14394','14395') then 'Original'
              when csh_DTV_EoD.current_product_description LIKE 'Sky Entertainment%' then 'Sky Entertainment'
              when CEL_EOD.Basic_Desc In ('1 Mix-YNNNNN','1 Mix-NNNYNN','2 Mix-YNNYNN','1 Mix-NNNNNN','0 Mix-NNNNNN','') then 'Original (Legacy)'
              when CEL_EOD.Basic_Desc In ('6 Mix-NNNNNN') then 'Variety'
              when csh_DTV_EoD.current_product_description like 'Sky Q%' then 'Sky Q'
              when csh_DTV_EoD.current_product_description like '6 Mix%' then 'Variety'
              when csh_DTV_EoD.current_product_description like 'Kids%' then 'Variety'
              when csh_DTV_EoD.current_product_description like 'Variety%' then 'Variety'
              when csh_DTV_EoD.current_product_description like 'Knowledge%' then 'Variety'
              when csh_DTV_EoD.current_product_description like 'News%' then 'Variety'
              when csh_DTV_EoD.current_product_description like 'Music%' then 'Variety'
              when csh_DTV_EoD.current_product_description like 'Sky%' then 'Variety'
              when csh_DTV_EoD.current_product_description like 'Style%' then 'Variety'
              when csh_DTV_EoD.current_product_description like 'Extra%' then 'Variety'
              else 'Original (Legacy)'
        end as Product_Description_1_EoD
       ,Case when csh_DTV_EoD.current_fo_src_system_catalogue_id In ('13710','13726','13889','14055','14243','14393') then ' with Cinema 1'
             when csh_DTV_EoD.current_fo_src_system_catalogue_id In ('13711','13727','13890','14056','14244','14394') then ' with Cinema 2'
             when csh_DTV_EoD.current_fo_src_system_catalogue_id In ('13708','13724','13887','14053','14241','14391') then ' with Sports 1'
             when csh_DTV_EoD.current_fo_src_system_catalogue_id In ('13709','13725','13888','14054','14242','14392') then ' with Sports 2'
             when csh_DTV_EoD.current_fo_src_system_catalogue_id In ('13704','13720','13883','14049','14237','14387') then ' with Sports 1 & Cinema 1'
             when csh_DTV_EoD.current_fo_src_system_catalogue_id In ('13705','13721','13884','14050','14238','14388') then ' with Sports 1 & Cinema 2'
             when csh_DTV_EoD.current_fo_src_system_catalogue_id In ('13706','13722','13885','14051','14239','14389') then ' with Sports 2 & Cinema 1'
             when csh_DTV_EoD.current_fo_src_system_catalogue_id In ('13707','13723','13886','14052','14240','14390') then ' with Sports 2 & Cinema 2'
             when csh_DTV_EoD.current_fo_src_system_catalogue_id In ('13699','13715','13878','14044','14017','14232','14382') then ' with Cinema'
             when csh_DTV_EoD.current_fo_src_system_catalogue_id In ('13698','13714','13877','14043','14016','14231','14381') then ' with Sports'
             when csh_DTV_EoD.current_fo_src_system_catalogue_id In ('13697','13713','13876','14042','14015','14230','14380') then ' with Sports & Cinema'
             when csh_DTV_EoD.current_fo_src_system_catalogue_id In ('13702','13718','13881','14047','14235','14385') then ' with Sports 1 & Cinema'
             when csh_DTV_EoD.current_fo_src_system_catalogue_id In ('13703','13719','13882','14048','14236','14386') then ' with Sports 2 & Cinema'
             when csh_DTV_EoD.current_fo_src_system_catalogue_id In ('13700','13716','13879','14045','14233','14383') then ' with Sports & Cinema 1'
             when csh_DTV_EoD.current_fo_src_system_catalogue_id In ('13701','13717','13880','14046','14234','14384') then ' with Sports & Cinema 2'
             when csh_DTV_EoD.current_product_description like 'Sky World%' then ' with Sports & Cinema'
             when csh_DTV_EoD.current_product_description like '%with Family Pack - 1B' then ' with Cinema'
             when csh_DTV_EoD.current_product_description like '%with Family Pack - 1C' then ' with Sports'
             when csh_DTV_EoD.current_product_description like '%with Family Pack - 1J' then ' with Sports 1 & Cinema 2'
             when csh_DTV_EoD.current_product_description like '%with Movies Mix' then ' with Cinema'
             when csh_DTV_EoD.current_product_description like '%with Sports Mix' then ' with Sports'
             when csh_DTV_EoD.current_product_description like '%with Movies 1' then ' with Cinema 1'
             when csh_DTV_EoD.current_product_description like '%with Movies 2' then ' with Cinema 2'
             when csh_DTV_EoD.current_product_description like '%with Sports 1' then ' with Sports 1'
             when csh_DTV_EoD.current_product_description like '%with Sports 2' then ' with Sports 2'
             when csh_DTV_EoD.current_product_description like '%with Sports 1 & Movies 1' then ' with Sports 1 & Cinema 1'
             when csh_DTV_EoD.current_product_description like '%with Sports 1 & Movies 2' then ' with Sports 1 & Cinema 2'
             when csh_DTV_EoD.current_product_description like '%with Sports 2 & Movies 1' then ' with Sports 2 & Cinema 1'
             when csh_DTV_EoD.current_product_description like '%with Sports 2 & Movies 2' then ' with Sports 2 & Cinema 2'
             when csh_DTV_EoD.current_product_description like '%with Sports 1 & Movies Mix' then ' with Sports 1 & Cinema'
             when csh_DTV_EoD.current_product_description like '%with Sports 2 & Movies Mix' then ' with Sports 2 & Cinema'
             when csh_DTV_EoD.current_product_description like '%with Sports Mix & Movies 1' then ' with Sports & Cinema 1'
             when csh_DTV_EoD.current_product_description like '%with Sports Mix & Movies 2' then ' with Sports & Cinema 2'
             when csh_DTV_EoD.current_product_description like '%with Sports Mix & Movies Mix' then ' with Sports & Cinema'
       end as Product_Description_2_EoD
        ,Product_Description_1_EoD || Product_Description_2_EoD as Product_Holding_EoD

        ,csh_DTV_EoD.current_product_description AS Curr_Product_Desc
        ,CEL_EOD.SHORT_DESCRIPTION AS CURR_SHORT_DESCRIPTION
        ,CEL_EOD.GENRE AS CURR_PACKAGE_DESC
        ,CEL_EOD.BASE_DESC AS CURR_BASE_DESC
        ,csh_DTV_EoD.x_ent_current_contribution_gbp AS Curr_Contribution_GBP

INTO #Crossgrades_EoD

FROM #Crossgrades_SoD csh

     INNER JOIN
     cust_subs_hist csh_DTV_EoD
        ON csh_DTV_EoD.account_number = csh.account_number
                AND csh_DTV_EoD.subscription_id = csh.subscription_id
                AND csh.Event_dt BETWEEN csh_DTV_EoD.effective_from_dt AND csh_DTV_EoD.effective_to_dt - 1
                AND csh_DTV_EoD.subscription_sub_type = 'DTV Primary Viewing'
                AND csh_DTV_EoD.status_code IN ('AC', 'AB', 'PC')

     INNER JOIN
     cust_entitlement_lookup CEL_EOD
        ON CEL_EOD.short_description = csh_DTV_EoD.current_short_description

WHERE csh_DTV_EoD.account_number IS NOT NULL
      ;

commit;
create hg index idx_1 on #Crossgrades_EoD(account_number);
create hg index idx_2 on #Crossgrades_EoD(subscription_id);
create date index idx_3 on #Crossgrades_EoD(event_dt);
create cmp index idx_4 on #Crossgrades_EoD(Prev_Contribution_GBP,Curr_Contribution_GBP);
create date index idx_5 on #Crossgrades_EoD(SoD_Effective_To_Dt);
create date index idx_6 on #Crossgrades_EoD(EoD_Effective_From_Dt);



Select csh.*
        ,CASE WHEN Prev_Contribution_GBP < Curr_Contribution_GBP THEN 1 ELSE 0 END AS Spin_Up
        ,CASE WHEN Prev_Contribution_GBP > Curr_Contribution_GBP THEN 1 ELSE 0 END AS Spin_Down
        ,CASE WHEN Product_Holding_SoD <> Product_Holding_EoD THEN 1 ELSE 0 END AS DTV_Regrade
        ,Row_Number() over(partition by csh.account_number,csh.subscription_id,csh.Event_dt
                           order by csh.SoD_Effective_To_Dt) as SoD_Record_Rnk
        ,Row_Number() over(partition by csh.account_number,csh.subscription_id,csh.Event_dt
                           order by csh.EoD_Effective_From_Dt desc) as EoD_Record_Rnk
into #Crossgrades_DTV
from #Crossgrades_EoD csh
where DTV_Regrade > 0;

Delete from #Crossgrades_DTV where SoD_Record_Rnk > 1 or EoD_Record_Rnk > 1;

-- Select top 1000 * from  #Crossgrades_DTV;


DELETE FROM Decisioning.Crossgrades_DTV
WHERE Event_Dt >= Refresh_dt;

INSERT INTO Decisioning.Crossgrades_DTV
SELECT
null as Subs_Year,
null as Subs_Quarter_Of_Year,
null as Subs_Week_Of_Year,
null as Subs_Week_And_Year,
Event_Dt,

Account_Number,
Owning_Cust_Account_ID,
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
Country,
Product_Description_1_SoD as Base_Product_Holding_SoD,
Product_Holding_SoD,
Product_Description_1_EoD as Base_Product_Holding_EoD,
Product_Holding_EoD,

Case when Product_Description_1_SoD = 'Sky Q' then 0
     when Product_Description_1_SoD = 'Box Sets' and Product_Description_1_EoD in ('Sky Q') then 1
     when Product_Description_1_SoD = 'Variety' and Product_Description_1_EoD in ('Box Sets','Sky Q') then 1
     when Product_Description_1_SoD in ('Original','Original (Legacy)','Original (Legacy 2017)')
                and Product_Description_1_EoD in ('Variety','Box Sets','Sky Q') then 1
     else 0
end as Base_Prod_Spin_Up,
Case when Product_Description_1_SoD = 'Sky Q'
                and Product_Description_1_EoD in ('Original','Original (Legacy)','Original (Legacy 2017)','Variety','Box Sets') then 1
     when Product_Description_1_SoD = 'Box Sets' and Product_Description_1_EoD in ('Original','Original (Legacy)','Original (Legacy 2017)','Variety') then 1
     when Product_Description_1_SoD = 'Variety' and Product_Description_1_EoD in ('Original','Original (Legacy)','Original (Legacy 2017)') then 1
     when Product_Description_1_SoD in ('Original','Original (Legacy)','Original (Legacy 2017)') then 0
     else 0
end as Base_Prod_Spin_Down,
Case when Product_Description_1_SoD != Product_Description_1_EoD then 1 else 0 end as Base_Prod_DTV_Regrade,
Spin_Up,
Spin_Down,
DTV_Regrade

FROM #Crossgrades_DTV;

Update Decisioning.Crossgrades_DTV cdtv
Set    Subs_Year = sc.subs_year,
       Subs_Quarter_Of_Year = sc.Subs_Quarter_Of_Year,
       Subs_Week_Of_Year = sc.Subs_Week_Of_Year,
       Subs_Week_And_Year = Cast(sc.Subs_Week_And_Year as integer)
from sky_calendar sc
where cdtv.subs_year is null and sc.calendar_date = cdtv.event_dt;

END;

Grant Execute on Decisioning_Procs.Update_Decisioning_Crossgrades_DTV to Decisioning; 

/* ======================================== Queries for Testing ========================================
create view in CITeam 

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'Crossgrades_DTV');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'Crossgrades_DTV',  'select * from Decisioning.Crossgrades_DTV');

===================================================================================================== */

