proc sql noprint;
  connect to sybaseiq as olive 
  (server=olive_iqm_prod07 database=olive_prod PORT=8000 HOST="upiqm070.bskyb.com"  authdomain="Sybase PRD");
  execute  (
				Call Decisioning_Procs.PL_Entries_ALaCarte();
;	
           ) by olive;
  disconnect from olive;
quit;