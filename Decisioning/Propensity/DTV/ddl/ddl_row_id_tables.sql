dba.sp_drop_table 'Decisioning','propensity_training_deleted_rowids'
dba.sp_create_table 'Decisioning','propensity_training_deleted_rowids',
   ' row_id bigint DEFAULT NULL '


dba.sp_drop_table 'Decisioning','propensity_training_inserted_rowids'
dba.sp_create_table 'Decisioning','propensity_training_inserted_rowids',
   ' row_id bigint DEFAULT NULL '
