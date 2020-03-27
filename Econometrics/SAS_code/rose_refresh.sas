OPTIONS ERRORABEND;

proc sql noprint;
  connect to sybaseiq as olive 
  (server=olive_iqm_prod07 database=olive_prod PORT=8000 HOST="upiqm070.bskyb.com"  authdomain="Sybase PRD");
  execute  (
				Call sdd03.rose_refresh();	
           ) by olive;
  disconnect from olive;
quit; 