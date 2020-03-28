setuser Decisioning_Procs
GO
DROP PROCEDURE IF EXISTS Decisioning_Procs.PROPENSITY_MART_CHECK;
GO
CREATE PROCEDURE Decisioning_Procs.PROPENSITY_MART_CHECK( PERIOD_START DATE DEFAULT NULL,PERIOD_END DATE DEFAULT NULL)
SQL SECURITY INVOKER 
Begin
SET TEMPORARY OPTION Query_Temp_Space_Limit = 0;



/*   
   
dba.sp_drop_table 'Decisioning','PROPENSITY_MART_CHECK'
dba.sp_create_table 'Decisioning','PROPENSITY_MART_CHECK',
   ' Base_Dt date DEFAULT NULL, '
|| ' feature_name varchar(50) DEFAULT NULL, '
|| ' update_dt DATE DEFAULT NULL'


dba.sp_drop_table 'Decisioning','PROPENSITY_SCORING_MART_DISCRETE'
dba.sp_create_table 'Decisioning','PROPENSITY_SCORING_MART_DISCRETE',
   ' Base_Dt date DEFAULT NULL, '
|| ' feature_name varchar(50) DEFAULT NULL, '
|| ' feature_value varchar(50) DEFAULT NULL, '
|| ' feature_type varchar(50) DEFAULT NULL, '
|| ' population bigint DEFAULT NULL, '
|| ' distinct_population bigint DEFAULT NULL, '
|| ' proportion decimal(10,5) DEFAULT NULL, '
|| ' update_dt DATE DEFAULT NULL '

dba.sp_drop_table 'Decisioning','PROPENSITY_SCORING_MART_CONTINUOUS'
dba.sp_create_table 'Decisioning','PROPENSITY_SCORING_MART_CONTINUOUS',
   ' Base_Dt date DEFAULT NULL, '
|| ' feature_name varchar(50) DEFAULT NULL, '
|| ' minimum_value decimal(10,2) DEFAULT NULL, '
|| ' maximum_value decimal(10,2) DEFAULT NULL, '
|| ' mean_value decimal(10,5) DEFAULT NULL, '
|| ' update_dt DATE DEFAULT NULL '

*/


SELECT B.base_dt, B.feature_name, B.minimum_value, B.maximum_value, B.mean_value, today() as update_dt

into #PROPENSITY_SCORING_MART_CONTINUOUS
 FROM
   ((
  SELECT
    base_dt,
    'dtv_cuscan_churns_in_last_30d' AS feature_name,
    MIN(dtv_cuscan_churns_in_last_30d) AS minimum_value,
    MAX(dtv_cuscan_churns_in_last_30d) AS maximum_value,
    AVG(dtv_cuscan_churns_in_last_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'curr_offer_amount_dtv' AS feature_name,
    MIN(curr_offer_amount_dtv) AS minimum_value,
    MAX(curr_offer_amount_dtv) AS maximum_value,
    AVG(curr_offer_amount_dtv) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_cuscan_churns_in_last_5yr' AS feature_name,
    MIN(dtv_cuscan_churns_in_last_5yr) AS minimum_value,
    MAX(dtv_cuscan_churns_in_last_5yr) AS maximum_value,
    AVG(dtv_cuscan_churns_in_last_5yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'offers_applied_lst_36m_dtv' AS feature_name,
    MIN(offers_applied_lst_36m_dtv) AS minimum_value,
    MAX(offers_applied_lst_36m_dtv) AS maximum_value,
    AVG(offers_applied_lst_36m_dtv) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'offers_applied_lst_24m_dtv' AS feature_name,
    MIN(offers_applied_lst_24m_dtv) AS minimum_value,
    MAX(offers_applied_lst_24m_dtv) AS maximum_value,
    AVG(offers_applied_lst_24m_dtv) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_1st_activation' AS feature_name,
    MIN(dtv_1st_activation) AS minimum_value,
    MAX(dtv_1st_activation) AS maximum_value,
    AVG(dtv_1st_activation) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'movies_downgrades_in_last_3yr' AS feature_name,
    MIN(movies_downgrades_in_last_3yr) AS minimum_value,
    MAX(movies_downgrades_in_last_3yr) AS maximum_value,
    AVG(movies_downgrades_in_last_3yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'movies_purchases_in_last_1yr' AS feature_name,
    MIN(movies_purchases_in_last_1yr) AS minimum_value,
    MAX(movies_purchases_in_last_1yr) AS maximum_value,
    AVG(movies_purchases_in_last_1yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'od_dls_completed_in_last_90d' AS feature_name,
    MIN(od_dls_completed_in_last_90d) AS minimum_value,
    MAX(od_dls_completed_in_last_90d) AS maximum_value,
    AVG(od_dls_completed_in_last_90d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'skyfibre_enabled_perc' AS feature_name,
    MIN(skyfibre_enabled_perc) AS minimum_value,
    MAX(skyfibre_enabled_perc) AS maximum_value,
    AVG(skyfibre_enabled_perc) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'experian_factor5_dec' AS feature_name,
    MIN(experian_factor5_dec) AS minimum_value,
    MAX(experian_factor5_dec) AS maximum_value,
    AVG(experian_factor5_dec) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'throughput_speed' AS feature_name,
    MIN(throughput_speed) AS minimum_value,
    MAX(throughput_speed) AS maximum_value,
    AVG(throughput_speed) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'ms_newcust_activations_in_last_30d' AS feature_name,
    MIN(ms_newcust_activations_in_last_30d) AS minimum_value,
    MAX(ms_newcust_activations_in_last_30d) AS maximum_value,
    AVG(ms_newcust_activations_in_last_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_cuscan_churns_in_last_1yr' AS feature_name,
    MIN(dtv_cuscan_churns_in_last_1yr) AS minimum_value,
    MAX(dtv_cuscan_churns_in_last_1yr) AS maximum_value,
    AVG(dtv_cuscan_churns_in_last_1yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_cuscan_churns_in_last_3yr' AS feature_name,
    MIN(dtv_cuscan_churns_in_last_3yr) AS minimum_value,
    MAX(dtv_cuscan_churns_in_last_3yr) AS maximum_value,
    AVG(dtv_cuscan_churns_in_last_3yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'movies_activations_in_last_180d' AS feature_name,
    MIN(movies_activations_in_last_180d) AS minimum_value,
    MAX(movies_activations_in_last_180d) AS maximum_value,
    AVG(movies_activations_in_last_180d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'offers_applied_ever_bb' AS feature_name,
    MIN(offers_applied_ever_bb) AS minimum_value,
    MAX(offers_applied_ever_bb) AS maximum_value,
    AVG(offers_applied_ever_bb) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'offers_applied_lst_12m_dtv' AS feature_name,
    MIN(offers_applied_lst_12m_dtv) AS minimum_value,
    MAX(offers_applied_lst_12m_dtv) AS maximum_value,
    AVG(offers_applied_lst_12m_dtv) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_last_activation' AS feature_name,
    MIN(dtv_last_activation) AS minimum_value,
    MAX(dtv_last_activation) AS maximum_value,
    AVG(dtv_last_activation) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_abs_in_last_1yr' AS feature_name,
    MIN(dtv_abs_in_last_1yr) AS minimum_value,
    MAX(dtv_abs_in_last_1yr) AS maximum_value,
    AVG(dtv_abs_in_last_1yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'bb_churns_in_last_3yr' AS feature_name,
    MIN(bb_churns_in_last_3yr) AS minimum_value,
    MAX(bb_churns_in_last_3yr) AS maximum_value,
    AVG(bb_churns_in_last_3yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'event_purchases_in_last_1yr' AS feature_name,
    MIN(event_purchases_in_last_1yr) AS minimum_value,
    MAX(event_purchases_in_last_1yr) AS maximum_value,
    AVG(event_purchases_in_last_1yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'max_speed_uplift' AS feature_name,
    MIN(max_speed_uplift) AS minimum_value,
    MAX(max_speed_uplift) AS maximum_value,
    AVG(max_speed_uplift) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'h_income_value' AS feature_name,
    MIN(h_income_value) AS minimum_value,
    MAX(h_income_value) AS maximum_value,
    AVG(h_income_value) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'bb_last_activation' AS feature_name,
    MIN(bb_last_activation) AS minimum_value,
    MAX(bb_last_activation) AS maximum_value,
    AVG(bb_last_activation) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_cuscan_churns_in_last_90d' AS feature_name,
    MIN(dtv_cuscan_churns_in_last_90d) AS minimum_value,
    MAX(dtv_cuscan_churns_in_last_90d) AS maximum_value,
    AVG(dtv_cuscan_churns_in_last_90d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_curr_contract_intended_end' AS feature_name,
    MIN(dtv_curr_contract_intended_end) AS minimum_value,
    MAX(dtv_curr_contract_intended_end) AS maximum_value,
    AVG(dtv_curr_contract_intended_end) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL 
(
  SELECT
    base_dt,
    'sports_last_downgrade_dt' AS feature_name,
    MIN(base_dt - sports_last_downgrade_dt) AS minimum_value,
    MAX(base_dt - sports_last_downgrade_dt) AS maximum_value,
    AVG(base_dt -sports_last_downgrade_dt) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'sports_last_activation_dt' AS feature_name,
    MIN(base_dt - sports_last_activation_dt) AS minimum_value,
    MAX(base_dt - sports_last_activation_dt) AS maximum_value,
    AVG(base_dt -sports_last_activation_dt) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_prev_contract_start_dt' AS feature_name,
    MIN(base_dt - dtv_prev_contract_start_dt) AS minimum_value,
    MAX(base_dt - dtv_prev_contract_start_dt) AS maximum_value,
    AVG(base_dt -dtv_prev_contract_start_dt) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'last_bnk_purchased_dt' AS feature_name,
    MIN(base_dt - last_bnk_purchased_dt) AS minimum_value,
    MAX(base_dt - last_bnk_purchased_dt) AS maximum_value,
    AVG(base_dt -last_bnk_purchased_dt) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_last_activation_dt' AS feature_name,
    MIN(base_dt - dtv_last_activation_dt) AS minimum_value,
    MAX(base_dt - dtv_last_activation_dt) AS maximum_value,
    AVG(base_dt -dtv_last_activation_dt) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_curr_contract_intnd_end_dt' AS feature_name,
    MIN(base_dt - dtv_curr_contract_intnd_end_dt) AS minimum_value,
    MAX(base_dt - dtv_curr_contract_intnd_end_dt) AS maximum_value,
    AVG(base_dt -dtv_curr_contract_intnd_end_dt) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_curr_contract_start_dt' AS feature_name,
    MIN(base_dt - dtv_curr_contract_start_dt) AS minimum_value,
    MAX(base_dt - dtv_curr_contract_start_dt) AS maximum_value,
    AVG(base_dt -dtv_curr_contract_start_dt) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'last_movies_purchased_dt' AS feature_name,
    MIN(base_dt - last_movies_purchased_dt) AS minimum_value,
    MAX(base_dt - last_movies_purchased_dt) AS maximum_value,
    AVG(base_dt -last_movies_purchased_dt) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'sge_last_activation_dt' AS feature_name,
    MIN(base_dt - sge_last_activation_dt) AS minimum_value,
    MAX(base_dt - sge_last_activation_dt) AS maximum_value,
    AVG(base_dt -sge_last_activation_dt) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_prev_contract_actual_end_dt' AS feature_name,
    MIN(base_dt - dtv_prev_contract_actual_end_dt) AS minimum_value,
    MAX(base_dt - dtv_prev_contract_actual_end_dt) AS maximum_value,
    AVG(base_dt -dtv_prev_contract_actual_end_dt) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'bb_last_activation_dt' AS feature_name,
    MIN(base_dt - bb_last_activation_dt) AS minimum_value,
    MAX(base_dt - bb_last_activation_dt) AS maximum_value,
    AVG(base_dt -bb_last_activation_dt) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'last_completed_od_dl_dt' AS feature_name,
    MIN(base_dt - last_completed_od_dl_dt) AS minimum_value,
    MAX(base_dt - last_completed_od_dl_dt) AS maximum_value,
    AVG(base_dt -last_completed_od_dl_dt) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'bb_prev_contract_actual_end_dt' AS feature_name,
    MIN(base_dt - bb_prev_contract_actual_end_dt) AS minimum_value,
    MAX(base_dt - bb_prev_contract_actual_end_dt) AS maximum_value,
    AVG(base_dt -bb_prev_contract_actual_end_dt) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'bb_curr_contract_intended_end_dt' AS feature_name,
    MIN(base_dt - bb_curr_contract_intended_end_dt) AS minimum_value,
    MAX(base_dt - bb_curr_contract_intended_end_dt) AS maximum_value,
    AVG(base_dt -bb_curr_contract_intended_end_dt) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'ms_last_activation_dt' AS feature_name,
    MIN(base_dt - ms_last_activation_dt) AS minimum_value,
    MAX(base_dt - ms_last_activation_dt) AS maximum_value,
    AVG(base_dt -ms_last_activation_dt) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt ) 


  UNION ALL 
    (
  SELECT
    base_dt,
    '_1st_TA' AS feature_name,
    MIN(_1st_TA) AS minimum_value,
    MAX(_1st_TA) AS maximum_value,
    AVG(_1st_TA) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'BB_Last_Activation' AS feature_name,
    MIN(BB_Last_Activation) AS minimum_value,
    MAX(BB_Last_Activation) AS maximum_value,
    AVG(BB_Last_Activation) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Curr_Offer_Actual_End_DTV' AS feature_name,
    MIN(Curr_Offer_Actual_End_DTV) AS minimum_value,
    MAX(Curr_Offer_Actual_End_DTV) AS maximum_value,
    AVG(Curr_Offer_Actual_End_DTV) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Curr_Offer_Start_DTV' AS feature_name,
    MIN(Curr_Offer_Start_DTV) AS minimum_value,
    MAX(Curr_Offer_Start_DTV) AS maximum_value,
    AVG(Curr_Offer_Start_DTV) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'DTV_Curr_Contract_Intended_End' AS feature_name,
    MIN(DTV_Curr_Contract_Intended_End) AS minimum_value,
    MAX(DTV_Curr_Contract_Intended_End) AS maximum_value,
    AVG(DTV_Curr_Contract_Intended_End) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'DTV_Last_Activation' AS feature_name,
    MIN(DTV_Last_Activation) AS minimum_value,
    MAX(DTV_Last_Activation) AS maximum_value,
    AVG(DTV_Last_Activation) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'DTV_Last_Active_Block' AS feature_name,
    MIN(DTV_Last_Active_Block) AS minimum_value,
    MAX(DTV_Last_Active_Block) AS maximum_value,
    AVG(DTV_Last_Active_Block) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'last_TA' AS feature_name,
    MIN(last_TA) AS minimum_value,
    MAX(last_TA) AS maximum_value,
    AVG(last_TA) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Subs_Quarter_Of_Year' AS feature_name,
    MIN(Subs_Quarter_Of_Year) AS minimum_value,
    MAX(Subs_Quarter_Of_Year) AS maximum_value,
    AVG(Subs_Quarter_Of_Year) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'DTV_Active' AS feature_name,
    MIN(DTV_Active) AS minimum_value,
    MAX(DTV_Active) AS maximum_value,
    AVG(DTV_Active) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'BB_Active' AS feature_name,
    MIN(BB_Active) AS minimum_value,
    MAX(BB_Active) AS maximum_value,
    AVG(BB_Active) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Sports_Active' AS feature_name,
    MIN(Sports_Active) AS minimum_value,
    MAX(Sports_Active) AS maximum_value,
    AVG(Sports_Active) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Movies_Active' AS feature_name,
    MIN(Movies_Active) AS minimum_value,
    MAX(Movies_Active) AS maximum_value,
    AVG(Movies_Active) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'MS_Active' AS feature_name,
    MIN(MS_Active) AS minimum_value,
    MAX(MS_Active) AS maximum_value,
    AVG(MS_Active) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'SGE_Active' AS feature_name,
    MIN(SGE_Active) AS minimum_value,
    MAX(SGE_Active) AS maximum_value,
    AVG(SGE_Active) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'HD_Active' AS feature_name,
    MIN(HD_Active) AS minimum_value,
    MAX(HD_Active) AS maximum_value,
    AVG(HD_Active) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Sky_Box_Sets_Active' AS feature_name,
    MIN(Sky_Box_Sets_Active) AS minimum_value,
    MAX(Sky_Box_Sets_Active) AS maximum_value,
    AVG(Sky_Box_Sets_Active) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'UOD_Active' AS feature_name,
    MIN(UOD_Active) AS minimum_value,
    MAX(UOD_Active) AS maximum_value,
    AVG(UOD_Active) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'DTV_Activations_In_Last_30D' AS feature_name,
    MIN(DTV_Activations_In_Last_30D) AS minimum_value,
    MAX(DTV_Activations_In_Last_30D) AS maximum_value,
    AVG(DTV_Activations_In_Last_30D) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'DTV_Activations_In_Next_30D' AS feature_name,
    MIN(DTV_Activations_In_Next_30D) AS minimum_value,
    MAX(DTV_Activations_In_Next_30D) AS maximum_value,
    AVG(DTV_Activations_In_Next_30D) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'DTV_NewCust_Actv_In_Lt_90D' AS feature_name,
    MIN(DTV_NewCust_Actv_In_Lt_90D) AS minimum_value,
    MAX(DTV_NewCust_Actv_In_Lt_90D) AS maximum_value,
    AVG(DTV_NewCust_Actv_In_Lt_90D) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'BB_Subscription_Actv_In_Lt_5Yr' AS feature_name,
    MIN(BB_Subscription_Actv_In_Lt_5Yr) AS minimum_value,
    MAX(BB_Subscription_Actv_In_Lt_5Yr) AS maximum_value,
    AVG(BB_Subscription_Actv_In_Lt_5Yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'BB_Subscription_Activations_Ever' AS feature_name,
    MIN(BB_Subscription_Activations_Ever) AS minimum_value,
    MAX(BB_Subscription_Activations_Ever) AS maximum_value,
    AVG(BB_Subscription_Activations_Ever) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'DTV_CusCan_Churns_In_Last_1Yr' AS feature_name,
    MIN(DTV_CusCan_Churns_In_Last_1Yr) AS minimum_value,
    MAX(DTV_CusCan_Churns_In_Last_1Yr) AS maximum_value,
    AVG(DTV_CusCan_Churns_In_Last_1Yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'DTV_PO_Cancellations_In_Last_5Yr' AS feature_name,
    MIN(DTV_PO_Cancellations_In_Last_5Yr) AS minimum_value,
    MAX(DTV_PO_Cancellations_In_Last_5Yr) AS maximum_value,
    AVG(DTV_PO_Cancellations_In_Last_5Yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'BB_Churns_In_Last_30D' AS feature_name,
    MIN(BB_Churns_In_Last_30D) AS minimum_value,
    MAX(BB_Churns_In_Last_30D) AS maximum_value,
    AVG(BB_Churns_In_Last_30D) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'BB_Churns_In_Last_90D' AS feature_name,
    MIN(BB_Churns_In_Last_90D) AS minimum_value,
    MAX(BB_Churns_In_Last_90D) AS maximum_value,
    AVG(BB_Churns_In_Last_90D) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'BB_Churns_In_Last_3Yr' AS feature_name,
    MIN(BB_Churns_In_Last_3Yr) AS minimum_value,
    MAX(BB_Churns_In_Last_3Yr) AS maximum_value,
    AVG(BB_Churns_In_Last_3Yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'BB_Churns_Ever' AS feature_name,
    MIN(BB_Churns_Ever) AS minimum_value,
    MAX(BB_Churns_Ever) AS maximum_value,
    AVG(BB_Churns_Ever) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'DTV_PCs_In_Last_30D' AS feature_name,
    MIN(DTV_PCs_In_Last_30D) AS minimum_value,
    MAX(DTV_PCs_In_Last_30D) AS maximum_value,
    AVG(DTV_PCs_In_Last_30D) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'DTV_PCs_In_Last_1Yr' AS feature_name,
    MIN(DTV_PCs_In_Last_1Yr) AS minimum_value,
    MAX(DTV_PCs_In_Last_1Yr) AS maximum_value,
    AVG(DTV_PCs_In_Last_1Yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'DTV_ABs_In_Last_1Yr' AS feature_name,
    MIN(DTV_ABs_In_Last_1Yr) AS minimum_value,
    MAX(DTV_ABs_In_Last_1Yr) AS maximum_value,
    AVG(DTV_ABs_In_Last_1Yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'DTV_ABs_In_Last_3Yr' AS feature_name,
    MIN(DTV_ABs_In_Last_3Yr) AS minimum_value,
    MAX(DTV_ABs_In_Last_3Yr) AS maximum_value,
    AVG(DTV_ABs_In_Last_3Yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'DTV_ABs_Ever' AS feature_name,
    MIN(DTV_ABs_Ever) AS minimum_value,
    MAX(DTV_ABs_Ever) AS maximum_value,
    AVG(DTV_ABs_Ever) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'DTV_AB_Reactivations_In_Last_1Yr' AS feature_name,
    MIN(DTV_AB_Reactivations_In_Last_1Yr) AS minimum_value,
    MAX(DTV_AB_Reactivations_In_Last_1Yr) AS maximum_value,
    AVG(DTV_AB_Reactivations_In_Last_1Yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'BB_Enter_HM_In_Last_30D' AS feature_name,
    MIN(BB_Enter_HM_In_Last_30D) AS minimum_value,
    MAX(BB_Enter_HM_In_Last_30D) AS maximum_value,
    AVG(BB_Enter_HM_In_Last_30D) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'BB_Enter_HM_In_Last_180D' AS feature_name,
    MIN(BB_Enter_HM_In_Last_180D) AS minimum_value,
    MAX(BB_Enter_HM_In_Last_180D) AS maximum_value,
    AVG(BB_Enter_HM_In_Last_180D) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'BB_Enter_HM_In_Last_5Yr' AS feature_name,
    MIN(BB_Enter_HM_In_Last_5Yr) AS minimum_value,
    MAX(BB_Enter_HM_In_Last_5Yr) AS maximum_value,
    AVG(BB_Enter_HM_In_Last_5Yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'BB_Enter_3rd_Party_In_Last_3Yr' AS feature_name,
    MIN(BB_Enter_3rd_Party_In_Last_3Yr) AS minimum_value,
    MAX(BB_Enter_3rd_Party_In_Last_3Yr) AS maximum_value,
    AVG(BB_Enter_3rd_Party_In_Last_3Yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'BB_Enter_3rd_Party_Ever' AS feature_name,
    MIN(BB_Enter_3rd_Party_Ever) AS minimum_value,
    MAX(BB_Enter_3rd_Party_Ever) AS maximum_value,
    AVG(BB_Enter_3rd_Party_Ever) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Age' AS feature_name,
    MIN(Age) AS minimum_value,
    MAX(Age) AS maximum_value,
    AVG(Age) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'h_number_of_adults' AS feature_name,
    MIN(h_number_of_adults) AS minimum_value,
    MAX(h_number_of_adults) AS maximum_value,
    AVG(h_number_of_adults) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'h_number_of_bedrooms' AS feature_name,
    MIN(h_number_of_bedrooms) AS minimum_value,
    MAX(h_number_of_bedrooms) AS maximum_value,
    AVG(h_number_of_bedrooms) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'h_number_of_children_in_hh' AS feature_name,
    MIN(h_number_of_children_in_hh) AS minimum_value,
    MAX(h_number_of_children_in_hh) AS maximum_value,
    AVG(h_number_of_children_in_hh) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'TAs_in_next_30d' AS feature_name,
    MIN(TAs_in_next_30d) AS minimum_value,
    MAX(TAs_in_next_30d) AS maximum_value,
    AVG(TAs_in_next_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'TA_saves_in_last_30d' AS feature_name,
    MIN(TA_saves_in_last_30d) AS minimum_value,
    MAX(TA_saves_in_last_30d) AS maximum_value,
    AVG(TA_saves_in_last_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Movies_Purchases_In_Last_90d' AS feature_name,
    MIN(Movies_Purchases_In_Last_90d) AS minimum_value,
    MAX(Movies_Purchases_In_Last_90d) AS maximum_value,
    AVG(Movies_Purchases_In_Last_90d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Movies_Purchases_In_Last_1yr' AS feature_name,
    MIN(Movies_Purchases_In_Last_1yr) AS minimum_value,
    MAX(Movies_Purchases_In_Last_1yr) AS maximum_value,
    AVG(Movies_Purchases_In_Last_1yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Movies_Purchases_Ever' AS feature_name,
    MIN(Movies_Purchases_Ever) AS minimum_value,
    MAX(Movies_Purchases_Ever) AS maximum_value,
    AVG(Movies_Purchases_Ever) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Offers_Applied_Lst_30D_DTV' AS feature_name,
    MIN(Offers_Applied_Lst_30D_DTV) AS minimum_value,
    MAX(Offers_Applied_Lst_30D_DTV) AS maximum_value,
    AVG(Offers_Applied_Lst_30D_DTV) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Offers_Applied_Lst_90D_DTV' AS feature_name,
    MIN(Offers_Applied_Lst_90D_DTV) AS minimum_value,
    MAX(Offers_Applied_Lst_90D_DTV) AS maximum_value,
    AVG(Offers_Applied_Lst_90D_DTV) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Offers_Applied_Lst_12M_DTV' AS feature_name,
    MIN(Offers_Applied_Lst_12M_DTV) AS minimum_value,
    MAX(Offers_Applied_Lst_12M_DTV) AS maximum_value,
    AVG(Offers_Applied_Lst_12M_DTV) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Offers_Applied_Lst_24M_DTV' AS feature_name,
    MIN(Offers_Applied_Lst_24M_DTV) AS minimum_value,
    MAX(Offers_Applied_Lst_24M_DTV) AS maximum_value,
    AVG(Offers_Applied_Lst_24M_DTV) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Offers_Applied_Ever_BB' AS feature_name,
    MIN(Offers_Applied_Ever_BB) AS minimum_value,
    MAX(Offers_Applied_Ever_BB) AS maximum_value,
    AVG(Offers_Applied_Ever_BB) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Q_PrimaryBox' AS feature_name,
    MIN(Q_PrimaryBox) AS minimum_value,
    MAX(Q_PrimaryBox) AS maximum_value,
    AVG(Q_PrimaryBox) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'UP_SkyQ' AS feature_name,
    MIN(UP_SkyQ) AS minimum_value,
    MAX(UP_SkyQ) AS maximum_value,
    AVG(UP_SkyQ) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Sports_Activations_In_Last_5Yr' AS feature_name,
    MIN(Sports_Activations_In_Last_5Yr) AS minimum_value,
    MAX(Sports_Activations_In_Last_5Yr) AS maximum_value,
    AVG(Sports_Activations_In_Last_5Yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Sports_Activations_Ever' AS feature_name,
    MIN(Sports_Activations_Ever) AS minimum_value,
    MAX(Sports_Activations_Ever) AS maximum_value,
    AVG(Sports_Activations_Ever) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Sports_New_Adds_Ever' AS feature_name,
    MIN(Sports_New_Adds_Ever) AS minimum_value,
    MAX(Sports_New_Adds_Ever) AS maximum_value,
    AVG(Sports_New_Adds_Ever) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Movies_Activations_In_Last_180D' AS feature_name,
    MIN(Movies_Activations_In_Last_180D) AS minimum_value,
    MAX(Movies_Activations_In_Last_180D) AS maximum_value,
    AVG(Movies_Activations_In_Last_180D) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Movies_Activations_In_Last_1Yr' AS feature_name,
    MIN(Movies_Activations_In_Last_1Yr) AS minimum_value,
    MAX(Movies_Activations_In_Last_1Yr) AS maximum_value,
    AVG(Movies_Activations_In_Last_1Yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Movies_Upgrades_In_Last_1Yr' AS feature_name,
    MIN(Movies_Upgrades_In_Last_1Yr) AS minimum_value,
    MAX(Movies_Upgrades_In_Last_1Yr) AS maximum_value,
    AVG(Movies_Upgrades_In_Last_1Yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Movies_Downgrades_In_Last_3Yr' AS feature_name,
    MIN(Movies_Downgrades_In_Last_3Yr) AS minimum_value,
    MAX(Movies_Downgrades_In_Last_3Yr) AS maximum_value,
    AVG(Movies_Downgrades_In_Last_3Yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Offers_Applied_Ever_Movies' AS feature_name,
    MIN(Offers_Applied_Ever_Movies) AS minimum_value,
    MAX(Offers_Applied_Ever_Movies) AS maximum_value,
    AVG(Offers_Applied_Ever_Movies) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'MS_Existing_Customer_Activation_Ever' AS feature_name,
    MIN(MS_Existing_Customer_Activation_Ever) AS minimum_value,
    MAX(MS_Existing_Customer_Activation_Ever) AS maximum_value,
    AVG(MS_Existing_Customer_Activation_Ever) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Event_Purchases_In_Last_30d' AS feature_name,
    MIN(Event_Purchases_In_Last_30d) AS minimum_value,
    MAX(Event_Purchases_In_Last_30d) AS maximum_value,
    AVG(Event_Purchases_In_Last_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Event_Purchases_In_Last_1yr' AS feature_name,
    MIN(Event_Purchases_In_Last_1yr) AS minimum_value,
    MAX(Event_Purchases_In_Last_1yr) AS maximum_value,
    AVG(Event_Purchases_In_Last_1yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Event_Purchases_Ever' AS feature_name,
    MIN(Event_Purchases_Ever) AS minimum_value,
    MAX(Event_Purchases_Ever) AS maximum_value,
    AVG(Event_Purchases_Ever) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'BnK_Purchases_In_Last_180d' AS feature_name,
    MIN(BnK_Purchases_In_Last_180d) AS minimum_value,
    MAX(BnK_Purchases_In_Last_180d) AS maximum_value,
    AVG(BnK_Purchases_In_Last_180d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'OD_DLs_Completed_In_Last_90d' AS feature_name,
    MIN(OD_DLs_Completed_In_Last_90d) AS minimum_value,
    MAX(OD_DLs_Completed_In_Last_90d) AS maximum_value,
    AVG(OD_DLs_Completed_In_Last_90d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'OD_DLs_Completed_In_Last_3yr' AS feature_name,
    MIN(OD_DLs_Completed_In_Last_3yr) AS minimum_value,
    MAX(OD_DLs_Completed_In_Last_3yr) AS maximum_value,
    AVG(OD_DLs_Completed_In_Last_3yr) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'OD_DLs_Completed_Ever' AS feature_name,
    MIN(OD_DLs_Completed_Ever) AS minimum_value,
    MAX(OD_DLs_Completed_Ever) AS maximum_value,
    AVG(OD_DLs_Completed_Ever) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_Movies_Added_In_Next_30d' AS feature_name,
    MIN(Order_Movies_Added_In_Next_30d) AS minimum_value,
    MAX(Order_Movies_Added_In_Next_30d) AS maximum_value,
    AVG(Order_Movies_Added_In_Next_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_Movies_Added_In_Last_30d' AS feature_name,
    MIN(Order_Movies_Added_In_Last_30d) AS minimum_value,
    MAX(Order_Movies_Added_In_Last_30d) AS maximum_value,
    AVG(Order_Movies_Added_In_Last_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_Movies_Removed_In_Next_30d' AS feature_name,
    MIN(Order_Movies_Removed_In_Next_30d) AS minimum_value,
    MAX(Order_Movies_Removed_In_Next_30d) AS maximum_value,
    AVG(Order_Movies_Removed_In_Next_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_Sports_Added_In_Next_30d' AS feature_name,
    MIN(Order_Sports_Added_In_Next_30d) AS minimum_value,
    MAX(Order_Sports_Added_In_Next_30d) AS maximum_value,
    AVG(Order_Sports_Added_In_Next_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_Sports_Added_In_Last_30d' AS feature_name,
    MIN(Order_Sports_Added_In_Last_30d) AS minimum_value,
    MAX(Order_Sports_Added_In_Last_30d) AS maximum_value,
    AVG(Order_Sports_Added_In_Last_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_Sports_Removed_In_Next_30d' AS feature_name,
    MIN(Order_Sports_Removed_In_Next_30d) AS minimum_value,
    MAX(Order_Sports_Removed_In_Next_30d) AS maximum_value,
    AVG(Order_Sports_Removed_In_Next_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_BB_Unlimited_Added_In_Next_30d' AS feature_name,
    MIN(Order_BB_Unlimited_Added_In_Next_30d) AS minimum_value,
    MAX(Order_BB_Unlimited_Added_In_Next_30d) AS maximum_value,
    AVG(Order_BB_Unlimited_Added_In_Next_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_BB_Unlimited_Added_In_Last_30d' AS feature_name,
    MIN(Order_BB_Unlimited_Added_In_Last_30d) AS minimum_value,
    MAX(Order_BB_Unlimited_Added_In_Last_30d) AS maximum_value,
    AVG(Order_BB_Unlimited_Added_In_Last_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_BB_Lite_Added_In_Next_30d' AS feature_name,
    MIN(Order_BB_Lite_Added_In_Next_30d) AS minimum_value,
    MAX(Order_BB_Lite_Added_In_Next_30d) AS maximum_value,
    AVG(Order_BB_Lite_Added_In_Next_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_BB_Lite_Added_In_Last_30d' AS feature_name,
    MIN(Order_BB_Lite_Added_In_Last_30d) AS minimum_value,
    MAX(Order_BB_Lite_Added_In_Last_30d) AS maximum_value,
    AVG(Order_BB_Lite_Added_In_Last_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_BB_Fibre_Cap_Added_In_Last_30d' AS feature_name,
    MIN(Order_BB_Fibre_Cap_Added_In_Last_30d) AS minimum_value,
    MAX(Order_BB_Fibre_Cap_Added_In_Last_30d) AS maximum_value,
    AVG(Order_BB_Fibre_Cap_Added_In_Last_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_BB_Fibre_Unlimited_Added_In_Next_30d' AS feature_name,
    MIN(Order_BB_Fibre_Unlimited_Added_In_Next_30d) AS minimum_value,
    MAX(Order_BB_Fibre_Unlimited_Added_In_Next_30d) AS maximum_value,
    AVG(Order_BB_Fibre_Unlimited_Added_In_Next_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_BB_Fibre_Unlimited_Added_In_Last_30d' AS feature_name,
    MIN(Order_BB_Fibre_Unlimited_Added_In_Last_30d) AS minimum_value,
    MAX(Order_BB_Fibre_Unlimited_Added_In_Last_30d) AS maximum_value,
    AVG(Order_BB_Fibre_Unlimited_Added_In_Last_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_BB_Fibre_Unlimited_Pro_Added_In_Next_30d' AS feature_name,
    MIN(Order_BB_Fibre_Unlimited_Pro_Added_In_Next_30d) AS minimum_value,
    MAX(Order_BB_Fibre_Unlimited_Pro_Added_In_Next_30d) AS maximum_value,
    AVG(Order_BB_Fibre_Unlimited_Pro_Added_In_Next_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_BB_Fibre_Unlimited_Pro_Added_In_Last_30d' AS feature_name,
    MIN(Order_BB_Fibre_Unlimited_Pro_Added_In_Last_30d) AS minimum_value,
    MAX(Order_BB_Fibre_Unlimited_Pro_Added_In_Last_30d) AS maximum_value,
    AVG(Order_BB_Fibre_Unlimited_Pro_Added_In_Last_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_MULTISCREEN_Added_In_Next_60d' AS feature_name,
    MIN(Order_MULTISCREEN_Added_In_Next_60d) AS minimum_value,
    MAX(Order_MULTISCREEN_Added_In_Next_60d) AS maximum_value,
    AVG(Order_MULTISCREEN_Added_In_Next_60d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_SKY_MOBILE_HANDSET_Added_In_Last_30d' AS feature_name,
    MIN(Order_SKY_MOBILE_HANDSET_Added_In_Last_30d) AS minimum_value,
    MAX(Order_SKY_MOBILE_HANDSET_Added_In_Last_30d) AS maximum_value,
    AVG(Order_SKY_MOBILE_HANDSET_Added_In_Last_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_SKY_MOBILE_TARIFFS_Added_In_Last_30d' AS feature_name,
    MIN(Order_SKY_MOBILE_TARIFFS_Added_In_Last_30d) AS minimum_value,
    MAX(Order_SKY_MOBILE_TARIFFS_Added_In_Last_30d) AS maximum_value,
    AVG(Order_SKY_MOBILE_TARIFFS_Added_In_Last_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'SkyKids_Active' AS feature_name,
    MIN(SkyKids_Active) AS minimum_value,
    MAX(SkyKids_Active) AS maximum_value,
    AVG(SkyKids_Active) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_KIDS_Added_In_Next_30d' AS feature_name,
    MIN(Order_KIDS_Added_In_Next_30d) AS minimum_value,
    MAX(Order_KIDS_Added_In_Next_30d) AS maximum_value,
    AVG(Order_KIDS_Added_In_Next_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_KIDS_Added_In_Last_30d' AS feature_name,
    MIN(Order_KIDS_Added_In_Last_30d) AS minimum_value,
    MAX(Order_KIDS_Added_In_Last_30d) AS maximum_value,
    AVG(Order_KIDS_Added_In_Last_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_HD_BASIC_Added_In_Next_30d' AS feature_name,
    MIN(Order_HD_BASIC_Added_In_Next_30d) AS minimum_value,
    MAX(Order_HD_BASIC_Added_In_Next_30d) AS maximum_value,
    AVG(Order_HD_BASIC_Added_In_Next_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_HD_BASIC_Added_In_Last_30d' AS feature_name,
    MIN(Order_HD_BASIC_Added_In_Last_30d) AS minimum_value,
    MAX(Order_HD_BASIC_Added_In_Last_30d) AS maximum_value,
    AVG(Order_HD_BASIC_Added_In_Last_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_HD_PREMIUM_Added_In_Next_30d' AS feature_name,
    MIN(Order_HD_PREMIUM_Added_In_Next_30d) AS minimum_value,
    MAX(Order_HD_PREMIUM_Added_In_Next_30d) AS maximum_value,
    AVG(Order_HD_PREMIUM_Added_In_Next_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_BOXSETS_Added_In_Next_30d' AS feature_name,
    MIN(Order_BOXSETS_Added_In_Next_30d) AS minimum_value,
    MAX(Order_BOXSETS_Added_In_Next_30d) AS maximum_value,
    AVG(Order_BOXSETS_Added_In_Next_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_BOXSETS_Added_In_Last_30d' AS feature_name,
    MIN(Order_BOXSETS_Added_In_Last_30d) AS minimum_value,
    MAX(Order_BOXSETS_Added_In_Last_30d) AS maximum_value,
    AVG(Order_BOXSETS_Added_In_Last_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_UOD_Added_In_Next_30d' AS feature_name,
    MIN(Order_UOD_Added_In_Next_30d) AS minimum_value,
    MAX(Order_UOD_Added_In_Next_30d) AS maximum_value,
    AVG(Order_UOD_Added_In_Next_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Order_UOD_Added_In_Last_30d' AS feature_name,
    MIN(Order_UOD_Added_In_Last_30d) AS minimum_value,
    MAX(Order_UOD_Added_In_Last_30d) AS maximum_value,
    AVG(Order_UOD_Added_In_Last_30d) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'Up_Mobile' AS feature_name,
    MIN(Up_Mobile) AS minimum_value,
    MAX(Up_Mobile) AS maximum_value,
    AVG(Up_Mobile) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'EXPERIAN_FACTOR1_DEC' AS feature_name,
    MIN(EXPERIAN_FACTOR1_DEC) AS minimum_value,
    MAX(EXPERIAN_FACTOR1_DEC) AS maximum_value,
    AVG(EXPERIAN_FACTOR1_DEC) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'EXPERIAN_FACTOR2_DEC' AS feature_name,
    MIN(EXPERIAN_FACTOR2_DEC) AS minimum_value,
    MAX(EXPERIAN_FACTOR2_DEC) AS maximum_value,
    AVG(EXPERIAN_FACTOR2_DEC) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'EXPERIAN_FACTOR3_DEC' AS feature_name,
    MIN(EXPERIAN_FACTOR3_DEC) AS minimum_value,
    MAX(EXPERIAN_FACTOR3_DEC) AS maximum_value,
    AVG(EXPERIAN_FACTOR3_DEC) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'EXPERIAN_FACTOR4_DEC' AS feature_name,
    MIN(EXPERIAN_FACTOR4_DEC) AS minimum_value,
    MAX(EXPERIAN_FACTOR4_DEC) AS maximum_value,
    AVG(EXPERIAN_FACTOR4_DEC) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'EXPERIAN_FACTOR5_DEC' AS feature_name,
    MIN(EXPERIAN_FACTOR5_DEC) AS minimum_value,
    MAX(EXPERIAN_FACTOR5_DEC) AS maximum_value,
    AVG(EXPERIAN_FACTOR5_DEC) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'EXPERIAN_FACTOR6_DEC' AS feature_name,
    MIN(EXPERIAN_FACTOR6_DEC) AS minimum_value,
    MAX(EXPERIAN_FACTOR6_DEC) AS maximum_value,
    AVG(EXPERIAN_FACTOR6_DEC) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'prev_fbp_count' AS feature_name,
    MIN(prev_fbp_count) AS minimum_value,
    MAX(prev_fbp_count) AS maximum_value,
    AVG(prev_fbp_count) AS mean_value
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    base_dt))B 
;



-- inserting for catrgorical fields




  SELECT B.base_dt, B.feature_name, B.feature_value, B.feature_type,B.population, B.distinct_population, B.population/(select cast(count(*) as decimal(10,1))  from Decisioning.Propensity_Model_Mart_Scoring) as proportion, today() as update_dt 

into  #PROPENSITY_SCORING_MART_DISCRETE 
  FROM 
  ((
  SELECT
    base_dt,
    'bb_enter_hm_in_last_180d' AS feature_name,
    CAST(bb_enter_hm_in_last_180d AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    bb_enter_hm_in_last_180d,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_po_cancellations_ever' AS feature_name,
    CAST(dtv_po_cancellations_ever AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    dtv_po_cancellations_ever,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'ms_active' AS feature_name,
    CAST(ms_active AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    ms_active,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'bb_provider' AS feature_name,
    CAST(bb_provider AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    bb_provider,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'ta_saves_in_last_30d' AS feature_name,
    CAST(ta_saves_in_last_30d AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    ta_saves_in_last_30d,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_product_holding' AS feature_name,
    CAST(dtv_product_holding AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    dtv_product_holding,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'offers_applied_lst_24m_dtv' AS feature_name,
    CAST(offers_applied_lst_24m_dtv AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    offers_applied_lst_24m_dtv,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_ab_reactivations_in_last_1yr' AS feature_name,
    CAST(dtv_ab_reactivations_in_last_1yr AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    dtv_ab_reactivations_in_last_1yr,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'sports_product_holding' AS feature_name,
    CAST(sports_product_holding AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    sports_product_holding,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'sge_active' AS feature_name,
    CAST(sge_active AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    sge_active,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'movies_product_holding' AS feature_name,
    CAST(movies_product_holding AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    movies_product_holding,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'financial_strategy' AS feature_name,
    CAST(financial_strategy AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    financial_strategy,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'h_age_fine' AS feature_name,
    CAST(h_age_fine AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    h_age_fine,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_newcust_actv_in_lt_90d' AS feature_name,
    CAST(dtv_newcust_actv_in_lt_90d AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    dtv_newcust_actv_in_lt_90d,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'h_presence_of_child_aged_0_4' AS feature_name,
    CAST(h_presence_of_child_aged_0_4 AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    h_presence_of_child_aged_0_4,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'h_presence_of_child_aged_5_11' AS feature_name,
    CAST(h_presence_of_child_aged_5_11 AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    h_presence_of_child_aged_5_11,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'h_household_composition' AS feature_name,
    CAST(h_household_composition AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    h_household_composition,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_product_holding_recode' AS feature_name,
    CAST(dtv_product_holding_recode AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    dtv_product_holding_recode,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'vip_status' AS feature_name,
    CAST(vip_status AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    vip_status,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_abs_in_last_3yr' AS feature_name,
    CAST(dtv_abs_in_last_3yr AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    dtv_abs_in_last_3yr,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'h_presence_of_child_aged_12_17' AS feature_name,
    CAST(h_presence_of_child_aged_12_17 AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    h_presence_of_child_aged_12_17,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'prev_fbp_count' AS feature_name,
    CAST(prev_fbp_count AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    prev_fbp_count,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'offers_applied_ever_bb' AS feature_name,
    CAST(offers_applied_ever_bb AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    offers_applied_ever_bb,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'offers_applied_lst_12m_dtv' AS feature_name,
    CAST(offers_applied_lst_12m_dtv AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    offers_applied_lst_12m_dtv,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'skykids_active' AS feature_name,
    CAST(skykids_active AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    skykids_active,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_abs_in_last_1yr' AS feature_name,
    CAST(dtv_abs_in_last_1yr AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    dtv_abs_in_last_1yr,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'home_owner_status' AS feature_name,
    CAST(home_owner_status AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    home_owner_status,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'sports_activations_in_last_3yr' AS feature_name,
    CAST(sports_activations_in_last_3yr AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    sports_activations_in_last_3yr,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'h_family_lifestage' AS feature_name,
    CAST(h_family_lifestage AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    h_family_lifestage,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'subs_quarter_of_year' AS feature_name,
    CAST(subs_quarter_of_year AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    subs_quarter_of_year,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'offers_applied_lst_30d_dtv' AS feature_name,
    CAST(offers_applied_lst_30d_dtv AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    offers_applied_lst_30d_dtv,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'home_owner_status ' AS feature_name,
    CAST(home_owner_status AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    home_owner_status,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'h_prsnc_of_yng_person_at_address' AS feature_name,
    CAST(h_prsnc_of_yng_person_at_address AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    h_prsnc_of_yng_person_at_address,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'bb_product_holding' AS feature_name,
    CAST(bb_product_holding AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    bb_product_holding,
    base_dt )
UNION ALL 
  (
  SELECT
    base_dt,
    'order_bb_lite_added_in_last_30d' AS feature_name,
    CAST(order_bb_lite_added_in_last_30d AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    order_bb_lite_added_in_last_30d,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'order_bb_fibre_cap_added_in_last_30d' AS feature_name,
    CAST(order_bb_fibre_cap_added_in_last_30d AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    order_bb_fibre_cap_added_in_last_30d,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_product_holding' AS feature_name,
    CAST(dtv_product_holding AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    dtv_product_holding,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'order_boxsets_added_in_last_30d' AS feature_name,
    CAST(order_boxsets_added_in_last_30d AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    order_boxsets_added_in_last_30d,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'mobile_active' AS feature_name,
    CAST(mobile_active AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    mobile_active,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_status_code' AS feature_name,
    CAST(dtv_status_code AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    dtv_status_code,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'q_primarybox' AS feature_name,
    CAST(q_primarybox AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    q_primarybox,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'order_sky_mobile_tariffs_added_in_last_30d' AS feature_name,
    CAST(order_sky_mobile_tariffs_added_in_last_30d AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    order_sky_mobile_tariffs_added_in_last_30d,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_active' AS feature_name,
    CAST(dtv_active AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    dtv_active,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'order_sky_mobile_handset_added_in_last_30d' AS feature_name,
    CAST(order_sky_mobile_handset_added_in_last_30d AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    order_sky_mobile_handset_added_in_last_30d,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'sports_active' AS feature_name,
    CAST(sports_active AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    sports_active,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'movies_active ' AS feature_name,
    CAST(movies_active AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    movies_active,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'uod_active' AS feature_name,
    CAST(uod_active AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    uod_active,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'dtv_pcs_in_last_30d' AS feature_name,
    CAST(dtv_pcs_in_last_30d AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    dtv_pcs_in_last_30d,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'order_bb_fibre_unlimited_pro_added_in_last_30d' AS feature_name,
    CAST(order_bb_fibre_unlimited_pro_added_in_last_30d AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    order_bb_fibre_unlimited_pro_added_in_last_30d,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'h_delphi_band' AS feature_name,
    CAST(h_delphi_band AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    h_delphi_band,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'sky_core_affordability_score' AS feature_name,
    CAST(sky_core_affordability_score AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    sky_core_affordability_score,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'order_sports_added_in_last_30d' AS feature_name,
    CAST(order_sports_added_in_last_30d AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    order_sports_added_in_last_30d,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'skykids_active' AS feature_name,
    CAST(skykids_active AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    skykids_active,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'bb_active' AS feature_name,
    CAST(bb_active AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    bb_active,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'sky_mobile_affordability_score' AS feature_name,
    CAST(sky_mobile_affordability_score AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    sky_mobile_affordability_score,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'order_movies_added_in_last_30d' AS feature_name,
    CAST(order_movies_added_in_last_30d AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    order_movies_added_in_last_30d,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'order_bb_unlimited_added_in_last_30d' AS feature_name,
    CAST(order_bb_unlimited_added_in_last_30d AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    order_bb_unlimited_added_in_last_30d,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'order_kids_added_in_last_30d' AS feature_name,
    CAST(order_kids_added_in_last_30d AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    order_kids_added_in_last_30d,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'order_bb_fibre_unlimited_added_in_last_30d' AS feature_name,
    CAST(order_bb_fibre_unlimited_added_in_last_30d AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    order_bb_fibre_unlimited_added_in_last_30d,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'order_uod_added_in_last_30d' AS feature_name,
    CAST(order_uod_added_in_last_30d AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    order_uod_added_in_last_30d,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'sky_box_sets_active' AS feature_name,
    CAST(sky_box_sets_active AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    sky_box_sets_active,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'bb_product_holding' AS feature_name,
    CAST(bb_product_holding AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    bb_product_holding,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'handset_active' AS feature_name,
    CAST(handset_active AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    handset_active,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'bb_enter_hm_in_last_30d' AS feature_name,
    CAST(bb_enter_hm_in_last_30d AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    bb_enter_hm_in_last_30d,
    base_dt )
UNION ALL (
  SELECT
    base_dt,
    'bb_enter_hm_in_last_30d' AS feature_name,
    CAST(bb_enter_hm_in_last_30d AS varchar(50)) AS feature_value,
    'eligibility_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    bb_enter_hm_in_last_30d,
    base_dt )
  union ALL 

  (
    SELECT
    base_dt,
    'credit_tier_code' AS feature_name,
    CAST(credit_tier_code
 AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    credit_tier_code,
    base_dt )
UNION ALL 
(SELECT
    base_dt,
    'Exchange_Name' AS feature_name,
    CAST(Exchange_Name AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    Exchange_Name,
    base_dt )

UNION ALL 
(SELECT
    base_dt,
    'Exchange_Status' AS feature_name,
    CAST(Exchange_Status AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    Exchange_Status,
    base_dt )
UNION ALL 
(SELECT
    base_dt,
    'skyfibre_enabled' AS feature_name,
    CAST(skyfibre_enabled AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    skyfibre_enabled,
    base_dt )
UNION ALL (
SELECT
    base_dt,
    'h_affluence' AS feature_name,
    CAST(h_affluence AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    h_affluence,
    base_dt
)
UNION ALL (
SELECT
    base_dt,
    'h_property_type' AS feature_name,
    CAST(h_property_type AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    h_property_type,
    base_dt
)
UNION ALL (
SELECT
    base_dt,
    'h_residence_type' AS feature_name,
    CAST(h_residence_type AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    h_residence_type,
    base_dt
)

UNION ALL (
SELECT
    base_dt,
    'last_TA_outcome' AS feature_name,
    CAST(last_TA_outcome AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    last_TA_outcome,
    base_dt
)

UNION ALL (
SELECT
    base_dt,
    'p_true_touch_group' AS feature_name,
    CAST(p_true_touch_group AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    p_true_touch_group,
    base_dt
)
UNION ALL (
SELECT
    base_dt,
    'SGE_Product_Holding' AS feature_name,
    CAST(SGE_Product_Holding AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    Decisioning.Propensity_Model_Mart_Scoring
  GROUP BY
    SGE_Product_Holding,
    base_dt
)) B ; 



-- Check if the criteria for categorical and continuous columns 



SELECT B.base_dt, B.feature_name , today() as update_dt 

into #PROPENSITY_MART_CHECK
FROM
   (
  (SELECT base_dt, feature_name from Decisioning.PROPENSITY_SCORING_MART_CONTINUOUS where minimum_value = maximum_value)
  union all
 ( select base_dt, feature_name from Decisioning.PROPENSITY_SCORING_MART_DISCRETE where (proportion = 1)  or population<> distinct_population ))B; 

delete from Decisioning.PROPENSITY_SCORING_MART_CONTINUOUS;
INSERT INTO Decisioning.PROPENSITY_SCORING_MART_CONTINUOUS
select * from #PROPENSITY_SCORING_MART_CONTINUOUS;

delete from Decisioning.PROPENSITY_SCORING_MART_DISCRETE;
INSERT INTO Decisioning.PROPENSITY_SCORING_MART_DISCRETE
select * from #PROPENSITY_SCORING_MART_DISCRETE;

delete from Decisioning.PROPENSITY_MART_CHECK;
INSERT INTO Decisioning.PROPENSITY_MART_CHECK
select * from #PROPENSITY_MART_CHECK;

end
GO
GRANT EXECUTE ON Decisioning_Procs.PROPENSITY_MART_CHECK TO public;


/* create view in Decisioning 
call DBA.sp_DDL ('drop', 'view', 'Decisioning', 'PROPENSITY_SCORING_MART_CONTINUOUS');
call DBA.sp_DDL ('create', 'view', 'Decisioning', 'PROPENSITY_SCORING_MART_CONTINUOUS',  'select * from Decisioning.PROPENSITY_SCORING_MART_CONTINUOUS');

call DBA.sp_DDL ('drop', 'view', 'Decisioning', 'PROPENSITY_SCORING_MART_DISCRETE');
call DBA.sp_DDL ('create', 'view', 'Decisioning', 'PROPENSITY_SCORING_MART_DISCRETE',  'select * from Decisioning.PROPENSITY_SCORING_MART_DISCRETE');

call DBA.sp_DDL ('drop', 'view', 'Decisioning', 'PROPENSITY_MART_CHECK');
call DBA.sp_DDL ('create', 'view', 'Decisioning', 'PROPENSITY_MART_CHECK',  'select * from Decisioning.PROPENSITY_MART_CHECK');

*/