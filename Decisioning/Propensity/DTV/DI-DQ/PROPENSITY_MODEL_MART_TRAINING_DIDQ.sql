/*
dba.sp_drop_table 'CITeam','PROPENSITY_TRAINING_MODEL_MART_COUNT_CHECK'
dba.sp_create_table 'CITeam','PROPENSITY_TRAINING_MODEL_MART_COUNT_CHECK',
   'base_dt date default null,'
|| 'population bigint default null,'
|| 'unique_population bigint default null,'
|| 'update_dt date default null'

dba.sp_drop_table 'CITeam','PROPENSITY_TRAINING_MART_CHECK'
dba.sp_create_table 'CITeam','PROPENSITY_TRAINING_MART_CHECK',
   'base_dt date default null,'
|| 'faeture_name varchar(50) default null,'
|| 'update_dt date default null'
  
 dba.sp_drop_table 'CITeam','PROPENSITY_TRAINING_MART_DISCRETE'   
  dba.sp_create_table 'CITeam','PROPENSITY_TRAINING_MART_DISCRETE',
   'base_dt date default null,'
|| 'feature_name varchar(50) default null,'
|| 'feature_value varchar(50) default null,'
|| 'feature_type varchar(50) default null,'
|| 'population bigint default null,'
|| 'distinct_population bigint default null,'
|| 'proportion decimal(10,5) default null,'
|| 'update_dt date default null'
 
  dba.sp_drop_table 'CITeam','PROPENSITY_TRAINING_MART_CONTINUOUS'     
    dba.sp_create_table 'CITeam','PROPENSITY_TRAINING_MART_CONTINUOUS',
   'base_dt date default null,'
|| 'feature_name varchar(50) default null,'
|| 'minimum_value DECIMAL(10,2) default null,'
|| 'maximum_value DECIMAL(10,2) default null,'
|| 'mean_value DECIMAL(10,5) default null,'
|| 'update_dt date default null'

*/


setuser Decisioning_Procs
GO
DROP PROCEDURE IF EXISTS Decisioning_procs.PROPENSITY_MODEL_MART_TRAINING_DIDQ;
GO
create procedure Decisioning_procs.PROPENSITY_MODEL_MART_TRAINING_DIDQ() 
sql security invoker
begin

set option Query_Temp_Space_Limit = 0;

delete from CITeam.PROPENSITY_TRAINING_MODEL_MART_COUNT_CHECK;
INSERT INTO
  CITeam.PROPENSITY_TRAINING_MODEL_MART_COUNT_CHECK (
  SELECT
    BASE_DT,
    COUNT(*) POPULATION,
    COUNT(DISTINCT ACCOUNT_NUMBER) UNIQUE_POPULATION,
    TODAY() UPDATE_DT
  FROM
    CITEAM.PROPENSITY_MODEL_MART_TRAINING
  GROUP BY
    BASE_DT
  ORDER BY
    BASE_DT);
    
 delete from    CITeam.PROPENSITY_TRAINING_MART_CONTINUOUS;
INSERT INTO CITeam.PROPENSITY_TRAINING_MART_CONTINUOUS
SELECT B.base_dt, B.feature_name, B.minimum_value, B.maximum_value, B.mean_value, today() as update_dt FROM
   ((
  SELECT
    base_dt,
    'dtv_cuscan_churns_in_last_30d' AS feature_name,
    MIN(dtv_cuscan_churns_in_last_30d) AS minimum_value,
    MAX(dtv_cuscan_churns_in_last_30d) AS maximum_value,
    AVG(dtv_cuscan_churns_in_last_30d) AS mean_value
  FROM
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
  GROUP BY
    base_dt ))B; 

-- inserting for catrgorical fields


delete from CITeam.PROPENSITY_TRAINING_MART_DISCRETE;
INSERT INTO CITeam.PROPENSITY_TRAINING_MART_DISCRETE
  SELECT B.base_dt, B.feature_name, B.feature_value, B.feature_type,B.population, B.distinct_population, B.population/(select cast(count(*) as decimal(10,1))  from CITeam.Propensity_Model_Mart_Training) as proportion, today() as update_dt FROM 
  ((
  SELECT
    base_dt,
    'bb_enter_hm_in_last_180d' AS feature_name,
    CAST(bb_enter_hm_in_last_180d AS varchar(50)) AS feature_value,
    'model_feature' AS feature_type,
    COUNT(*) population,
    COUNT(DISTINCT account_number) distinct_population
  FROM
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
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
    CITeam.Propensity_Model_Mart_Training
  GROUP BY
    bb_enter_hm_in_last_30d,
    base_dt )) B ; 


-- Check if the criteria for categorical and continuous columns 



delete from CITeam.PROPENSITY_TRAINING_MART_CHECK;
INSERT INTO CITeam.PROPENSITY_TRAINING_MART_CHECK
SELECT B.base_dt, B.feature_name , today() as update_dt FROM
   (
  (SELECT base_dt, feature_name from CITeam.PROPENSITY_TRAINING_MART_CONTINUOUS where minimum_value = maximum_value)
  union all
 ( select base_dt, feature_name from CITeam.PROPENSITY_TRAINING_MART_DISCRETE where (proportion = 1)  or population<> distinct_population ))B; 



end
  
