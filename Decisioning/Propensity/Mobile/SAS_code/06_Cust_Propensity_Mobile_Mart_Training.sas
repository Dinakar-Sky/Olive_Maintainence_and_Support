OPTIONS ERRORABEND;

proc sql noprint;
  connect to sybaseiq as olive 
  (server=olive_iqm_prod07 database=olive_prod PORT=8000 HOST="upiqm070.bskyb.com"  authdomain="Sybase PRD");
  execute  (
				Decisioning_procs.Update_Decisioning_Propensity_Mobile_Mart_Training();
           ) by olive;
  disconnect from olive;
quit;
