/* DDL
dba.sp_drop_table 'CITeam','PROPENSITY_SCORING_MART_CHECK'
dba.sp_create_table 'CITeam','PROPENSITY_SCORING_MART_CHECK',
   ' base_dt date DEFAULT NULL, '
|| ' didq_check_datetime TIMESTAMP DEFAULT NULL, '
|| ' population int DEFAULT NULL, '
|| ' unique_population int DEFAULT NULL, '
|| ' status varchar(10) DEFAULT NULL, '
|| ' status_comment varchar(70) DEFAULT NULL '
*/

/* DUMMY RECORDS
insert into CITeam.PROPENSITY_SCORING_MART_CHECK
values ('2019-08-25', 'NA', 11359160, 10791200,'FAILED', 'Test record - Difference in count vs unique count of population'); 
insert into CITeam.PROPENSITY_SCORING_MART_CHECK
values ('2019-09-01', 'NA', 10251640, 10251640,'FAILED', 'Test record - > 5% variance over previous weeks population'); 
*/

setuser Decisioning_Procs
GO
DROP PROCEDURE IF EXISTS Decisioning_Procs.PROPENSITY_MART_DIDQ_CHECK;
GO
CREATE PROCEDURE Decisioning_Procs.PROPENSITY_MART_DIDQ_CHECK()
SQL SECURITY INVOKER 
BEGIN

SET TEMPORARY OPTION Query_Temp_Space_Limit = 0;

INSERT INTO CITeam.PROPENSITY_SCORING_MART_CHECK (didq_check_datetime,base_dt, population, unique_population)
SELECT 
    CURRENT_TIMESTAMP
    ,base_dt
    ,count(account_number)
    ,count(DISTINCT account_number)
FROM  Decisioning.Propensity_Model_Mart_Scoring
GROUP BY base_dt;

-- delete from CITeam.PROPENSITY_SCORING_MART_CHECK
-- select * from #PROPENSITY_SCORING_MART_CHECK1

DROP TABLE IF EXISTS #PROPENSITY_SCORING_MART_CHECK1;
SELECT TOP 2
    a.base_dt
    ,a.population AS current_population
    ,a.unique_population AS current_unique_population
    ,LAG(a.unique_population, 1, NULL) OVER (ORDER BY a.base_dt) AS previous_population
    ,((CAST((a.population - a.unique_population) AS FLOAT))/ a.population) * 100 AS var1
    ,(CAST((current_unique_population - previous_population) AS FLOAT)/current_unique_population)*100 AS var2
    ,CASE 
        WHEN var1 > 5.0  THEN 'FAILED'
        WHEN var2 > 5.0  THEN 'FAILED'
    ELSE 'SUCCESS' END AS status
    ,CASE 
		WHEN var1 > 5.0 THEN 'Difference in count vs unique count of population'
		WHEN var2 > 5.0  THEN '> 5% variance over previous weeks population' 
    ELSE 'NA' END AS status_comment
INTO #PROPENSITY_SCORING_MART_CHECK1
FROM CITeam.PROPENSITY_SCORING_MART_CHECK AS a
ORDER BY a.base_dt DESC;

UPDATE CITeam.PROPENSITY_SCORING_MART_CHECK a
SET 
    a.status = b.status
    ,a.status_comment = b.status_comment
FROM CITeam.PROPENSITY_SCORING_MART_CHECK a
JOIN #PROPENSITY_SCORING_MART_CHECK1 b
ON a.base_dt = b.base_dt;

END
GO
GRANT EXECUTE ON Decisioning_Procs.PROPENSITY_MART_DIDQ_CHECK TO PUBLIC;
