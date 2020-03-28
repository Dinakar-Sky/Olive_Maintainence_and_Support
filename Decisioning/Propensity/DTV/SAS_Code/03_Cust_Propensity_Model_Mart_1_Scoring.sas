OPTIONS ERRORABEND;

proc sql noprint;
  connect to sybaseiq as olive 
  (server=olive_iqm_prod07 database=olive_prod PORT=8000 HOST="upiqm070.bskyb.com"  authdomain="Sybase PRD");
  execute  (
				Call Decisioning_Procs.Update_Decisioning_Propensity_Model_Mart('Scoring');	
           ) by olive;
  disconnect from olive;
quit;


%let myfile = "\\WPSAS060\Teams\Decisioning\schedules\Trigger_files\Propensity_Scoring_Done.txt";
data _null_;
  file &myfile.;
run;