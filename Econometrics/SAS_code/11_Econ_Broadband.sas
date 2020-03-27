proc sql noprint;
  connect to sybaseiq as olive 
  (server=olive_iqm_prod07 database=olive_prod PORT=8000 HOST="upiqm070.bskyb.com"  authdomain="Sybase PRD");
  execute  (
				Call Decisioning_Procs.Update_Econometrics_Broadband();	
           ) by olive;
  disconnect from olive;
quit;