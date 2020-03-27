
setuser Decisioning_Procs
GO
DROP PROCEDURE Decisioning_Procs.Update_Active_Subscriber_Report_HDMSSGE
GO
create or replace procedure Decisioning_Procs.Update_Active_Subscriber_Report_HDMSSGE(Refresh_Dt  date default null ) 
sql security invoker
begin

  set temporary option  Query_Temp_Space_Limit  = 0;
  commit work;

  if  Refresh_Dt  is null then
    set  Refresh_dt  = (select  max ( effective_from_dt )-4*7 from  Decisioning.Active_Subscriber_Report_Src  where  subscription_sub_type  = 'HD');
    set  Refresh_dt  = case when  Refresh_dt  >  today ()-4*7 then  today ()-4*7 else  Refresh_dt  end
  end if;

  drop table if exists #Subs_Movements;

  select  ph_subs_hist_sk ,
     Account_Number ,
     Account_Type ,
     Account_Sub_Type ,
     Owning_Cust_Account_ID ,
     Subscription_Type ,
     Current_Product_sk ,
    cast(null as varchar(80)) as  Subscription_Sub_Type ,
    cast(null as date) as  Effective_From_Dt ,
    cast(null as date) as  Effective_To_Dt ,
     Effective_From_Datetime ,
    cast(null as integer) as  Active_Subscriber ,
    cast(null as integer) as  Effective_From_Subs_Week ,cast(null as integer) as  Effective_To_Subs_Week ,cast(null as smallint) as  Number_Of_Active_Subs ,
    cast(null as varchar(80)) as  Product_Description_1 ,
    cast(null as varchar(80)) as  Product_Description_2 ,
    cast( csh.current_product_description  as varchar(80)) as  Product_Holding ,
     Subscription_ID , Service_Instance_ID , Status_Code , SI_LATEST_SRC ,
    cast(null as varchar(3)) as  Country ,
     current_product_description , ENT_CAT_PROD_SK ,
     current_fo_src_system_catalogue_id ,
     current_short_description ,
    cast(null as integer) as  OfferCode ,cast(null as varchar(240)) as  BOXSET_FLAG ,cast(null as varchar(3)) as  HDPremiumFlag ,
    cast(0 as tinyint) as  Overlapping_Records ,
     Status_Start_Dt ,
     Status_End_Dt ,
     Status_Reason ,
     Prev_Status_Code 
    into #Subs_Movements
    from  Cust_Subs_Hist  as  csh 
    where 1 = 0;
	
	
  commit work;
  create hg index  idx_1  on #Subs_Movements( Owning_Cust_Account_ID );
  create date index  idx_2  on #Subs_Movements( Effective_From_Dt );
  create date index  idx_3  on #Subs_Movements( Effective_To_Dt );
  create lf index  idx_4  on #Subs_Movements( Subscription_Sub_Type );
  create lf index  idx_5  on #Subs_Movements( Number_Of_Active_Subs );
  create lf index  idx_6  on #Subs_Movements( Product_Holding );
  create hg index  idx_9  on #Subs_Movements( current_product_description );
  create hg index  idx_10  on #Subs_Movements( ENT_CAT_PROD_SK );
  create hg index  idx_11  on #Subs_Movements( ph_subs_hist_sk );
  create hg index  idx_12  on #Subs_Movements( subscription_id );
  create lf index  idx_13  on #Subs_Movements( Overlapping_Records );
  create dttm index  idx_14  on #Subs_Movements( Effective_From_Datetime );
  
  insert into #Subs_Movements
    select  ph_subs_hist_sk ,
       Account_Number ,
       Account_Type ,
       Account_Sub_Type ,
       csh.Owning_Cust_Account_ID ,
       Subscription_Type ,
       Current_Product_sk ,
      case when  csh.Subscription_Sub_Type  in( 'DTV Extra Subscription' ) then 'Multiscreen'
      when  csh.Subscription_Sub_Type  in( 'MS+' ) then 'Multiscreen'
      when  csh.Subscription_Sub_Type  in('DTV HD','HD Pack') then 'HD'
      when  csh.Subscription_Sub_Type  = 'Sky Go Extra' then 'Sky Go Extra'
      when  csh.Subscription_Sub_Type  = 'DTV Primary Viewing' then 'DTV Primary Viewing' end as  Subscription_Sub_Type ,
       Effective_From_Dt ,
       Effective_To_Dt ,
       Effective_From_Datetime ,
      cast(null as integer) as  Effective_From_Subs_Week ,
      cast(null as integer) as  Effective_To_Subs_Week ,
      cast(null as integer) as  Active_Subscriber ,
      cast(case when  status_code  in( 'AC','AB','PC' ) then 1 else 0 end as smallint) as  Number_Of_Active_Subs ,
      cast(null as varchar(80)) as  Product_Description_1 ,
      cast(null as varchar(80)) as  Product_Description_2 ,
       csh.Subscription_Sub_Type  as  Product_Holding ,
       Subscription_ID ,
       Service_Instance_ID ,
       Status_Code ,
       SI_LATEST_SRC ,
      case when  currency_code  = 'EUR' then 'ROI' else 'UK' end as  Country ,
       current_product_description ,
       ENT_CAT_PROD_SK ,
       current_fo_src_system_catalogue_id ,
       current_short_description ,
      cast(null as integer) as  OfferCode ,
      cast(null as varchar(240)) as  BOXSET_FLAG ,
      cast(null as varchar(3)) as  HDPremiumFlag ,
      cast(0 as tinyint) as  Overlapping_Records ,
       Status_Start_Dt ,
       Status_End_Dt ,
       Status_Reason ,
       Prev_Status_Code 
      from  Cust_Subs_Hist  as  csh 
      where  csh.effective_to_dt  >=  Refresh_dt 
      and  csh.Subscription_Sub_Type  in( 'Sky Multiscreen','MS+','DTV Extra Subscription','DTV HD','HD Pack','DTV Primary Viewing','Sky Go Extra' ) 
      and  csh.account_number  <> '99999999999999'
      and  csh.OWNING_CUST_ACCOUNT_ID  > '1'
      and  csh.SI_LATEST_SRC  = 'CHORD'
      and  csh.effective_to_dt  >  csh.effective_from_dt ;
	  
	  
  insert into #Subs_Movements
    select  ph_subs_hist_sk ,
       Account_Number ,
       Account_Type ,
       Account_Sub_Type ,
       Owning_Cust_Account_ID ,
       Subscription_Type ,
       Current_Product_sk ,
      'HD' as  Subscription_Sub_Type ,
       Effective_From_Dt ,
       Effective_To_Dt ,
       Effective_From_Datetime ,
      cast(null as integer) as  Effective_From_Subs_Week ,
      cast(null as integer) as  Effective_To_Subs_Week ,
      cast(null as integer) as  Active_Subscriber ,
      cast(case when  status_code  in( 'AC','AB','PC' ) then 1 else 0 end as smallint) as  Number_Of_Active_Subs ,
      cast(null as varchar(80)) as  Product_Description_1 ,
      cast(null as varchar(80)) as  Product_Description_2 ,
      'Ethan' as  Product_Holding ,
       Subscription_ID ,
       Service_Instance_ID ,
       Status_Code ,
       SI_LATEST_SRC ,
       Country ,
       current_product_description ,
       ENT_CAT_PROD_SK ,
       current_fo_src_system_catalogue_id ,
       current_short_description ,
      cast(null as integer) as  OfferCode ,
      cast(null as varchar(240)) as  BOXSET_FLAG ,
      cast(null as varchar(3)) as  HDPremiumFlag ,
      cast(0 as tinyint) as  Overlapping_Records ,
       Status_Start_Dt ,
       Status_End_Dt ,
       Status_Reason ,
       Prev_Status_Code 
      from #Subs_Movements as  sm 
      where  sm.subscription_sub_type  = 'DTV Primary Viewing'
      and(( ENT_CAT_PROD_SK  >= 49451 and  ENT_CAT_PROD_SK  <= 49466)
      or  ENT_CAT_PROD_SK  = 49519);
  
  insert into #Subs_Movements
    select  ph_subs_hist_sk ,
       Account_Number ,
       Account_Type ,
       Account_Sub_Type ,
       Owning_Cust_Account_ID ,
       Subscription_Type ,
       Current_Product_sk ,
      'Sky Go Extra' as  Subscription_Sub_Type ,
       Effective_From_Dt ,
       Effective_To_Dt ,
       Effective_From_Datetime ,
      cast(null as integer) as  Effective_From_Subs_Week ,
      cast(null as integer) as  Effective_To_Subs_Week ,
      cast(null as integer) as  Active_Subscriber ,
      cast(case when  status_code  in( 'AC','AB','PC' ) then 1 else 0 end as smallint) as  Number_Of_Active_Subs ,
      cast(null as varchar(80)) as  Product_Description_1 ,
      cast(null as varchar(80)) as  Product_Description_2 ,
      'Sky Q' as  Product_Holding ,
       Subscription_ID ,
       Service_Instance_ID ,
       Status_Code ,
       SI_LATEST_SRC ,
       Country ,
       current_product_description ,
       ENT_CAT_PROD_SK ,
       current_fo_src_system_catalogue_id ,
       current_short_description ,
      cast(null as integer) as  OfferCode ,
      cast(null as varchar(240)) as  BOXSET_FLAG ,
      cast(null as varchar(3)) as  HDPremiumFlag ,
      cast(0 as tinyint) as  Overlapping_Records ,
       Status_Start_Dt ,
       Status_End_Dt ,
       Status_Reason ,
       Prev_Status_Code 
      from #Subs_Movements as  sm 
      where  sm.subscription_sub_type  = 'DTV Primary Viewing'
      and(( ENT_CAT_PROD_SK  >= 49451 and  ENT_CAT_PROD_SK  <= 49466)
      or  ENT_CAT_PROD_SK  = 49519);
  
  insert into #Subs_Movements
    select  ph_subs_hist_sk ,
       Account_Number ,
       Account_Type ,
       Account_Sub_Type ,
       Owning_Cust_Account_ID ,
       Subscription_Type ,
       Current_Product_sk ,
      'Sky Go Extra' as  Subscription_Sub_Type ,
       Effective_From_Dt ,
       Effective_To_Dt ,
       Effective_From_Datetime ,
      cast(null as integer) as  Effective_From_Subs_Week ,
      cast(null as integer) as  Effective_To_Subs_Week ,
      cast(null as integer) as  Active_Subscriber ,
      cast(case when  status_code  in( 'AC','AB','PC' ) then 1 else 0 end as smallint) as  Number_Of_Active_Subs ,
      cast(null as varchar(80)) as  Product_Description_1 ,
      cast(null as varchar(80)) as  Product_Description_2 ,
       Product_Holding ,
       Subscription_ID ,
       Service_Instance_ID ,
       Status_Code ,
       SI_LATEST_SRC ,
       Country ,
       current_product_description ,
       ENT_CAT_PROD_SK ,
       current_fo_src_system_catalogue_id ,
       current_short_description ,
      cast(null as integer) as  OfferCode ,
      cast(null as varchar(240)) as  BOXSET_FLAG ,
      cast(null as varchar(3)) as  HDPremiumFlag ,
      cast(0 as tinyint) as  Overlapping_Records ,
       Status_Start_Dt ,
       Status_End_Dt ,
       Status_Reason ,
       Prev_Status_Code 
      from #Subs_Movements as  sm 
      where  sm.Product_Holding  = 'MS+';
  
  select  owning_cust_account_id , subscription_id , Max ( Number_Of_Active_Subs ) as  Inc_Active_subscription 
    into #Inactive_Subs
    from #Subs_Movements
    group by  owning_cust_account_id , subscription_id 
    having  Inc_Active_subscription  = 0;
  
  
  commit work;
  create hg index  idx_1  on #Inactive_Subs( owning_cust_account_id );
  create hg index  idx_2  on #Inactive_Subs( subscription_id );
  
  delete from #Subs_Movements as  sm  from
    #Subs_Movements as  sm 
    join #Inactive_Subs as  ins 
    on  ins.owning_cust_account_id  =  sm.owning_cust_account_id 
    and  ins.subscription_id  =  sm.subscription_id ;
  
  select  sm.ph_subs_hist_sk ,cast(null as  datetime ) as  Min_Effective_From_Dt 
    into #Correct_Effect_To_Dates
    from #Subs_Movements as  sm  where 1 = 0;
  
  insert into #Correct_Effect_To_Dates
    select  sm.ph_subs_hist_sk , min ( sm_2.effective_from_dt ) as  Min_Effective_From_Dt 
      from #Subs_Movements as  sm 
        join #Subs_Movements as  sm_2 
        on  sm_2.owning_cust_account_id  =  sm.owning_cust_account_id 
        and  sm_2.subscription_id  =  sm.subscription_id 
        and  sm.effective_to_dt  >  sm_2.effective_from_dt 
        and  sm_2.effective_from_dt  >  sm.effective_from_dt 
        and  sm_2.ph_subs_hist_sk  <>  sm.ph_subs_hist_sk 
      where( sm.Number_Of_Active_Subs  > 0 and  sm_2.Number_Of_Active_Subs  > 0)
      group by  sm.ph_subs_hist_sk ;
  
  update #Subs_Movements as  sm 
    set  Effective_To_Dt  = cast( cetd.Min_Effective_From_Dt  as date) from
    #Correct_Effect_To_Dates as  cetd 
    where  cetd.ph_subs_hist_sk  =  sm.ph_subs_hist_sk ;
  
  drop table if exists #Correct_Effect_To_Dates;
  
  delete from #Subs_Movements as  sm  from
    #Subs_Movements as  sm 
    join #Subs_Movements as  os 
    on  os.owning_cust_account_id  =  sm.owning_cust_account_id 
    and  os.subscription_id  =  sm.subscription_id 
    and  os.subscription_sub_type  =  sm.subscription_sub_type 
    and  os.effective_from_dt  between  sm.effective_from_dt +1 and  sm.effective_to_dt -1
    and  sm.effective_to_dt  = '9999-09-09';
  
  delete from #Subs_Movements where  effective_to_dt  <  Refresh_Dt ;
  
  delete from  Decisioning.Active_Subscriber_Report_Src 
    where  Effective_To_Dt  >=  Refresh_Dt 
    and  subscription_sub_type  = any(select distinct  subscription_sub_type  from #Subs_Movements)
    and  subscription_sub_type  <> 'DTV';
  
  select  sm.ph_subs_hist_sk , sm.effective_to_dt , max ( asr.effective_to_dt ) as  effective_from_dt 
    into #Effective_To
    from #Subs_Movements as  sm 
      join  Decisioning.Active_Subscriber_Report_Src  as  asr 
      on  asr.ph_subs_hist_sk  =  sm.ph_subs_hist_sk 
      and  sm.subscription_sub_type  =  asr.subscription_sub_type 
      and  asr.effective_to_dt  <  Refresh_Dt 
      and  Refresh_dt  between  sm.effective_from_dt +1 and  sm.effective_to_dt 
    group by  sm.ph_subs_hist_sk , sm.effective_to_dt ;
  
  commit work;
  
  create hg index  idx_1  on #Effective_To( ph_subs_hist_sk );
  create date index  idx_2  on #Effective_To( effective_to_dt );
  
  update #Subs_Movements as  sm 
    set  Effective_From_Dt  =  asr.effective_from_dt  from
    #Effective_To as  asr 
    where  asr.ph_subs_hist_sk  =  sm.ph_subs_hist_sk 
    and  asr.effective_to_dt  =  sm.effective_to_dt ;
  
  drop table if exists #Effective_To;
  
  update #Subs_Movements as  sm 
    set  OfferCode  =  cpo.Offer_ID  from
    #Subs_Movements as  sm 
    join  Cust_Product_Offers_Hist  as  cpo 
    on  cpo.cust_account_id  =  sm.owning_cust_account_id 
    and  sm.effective_from_dt  between  cpo.effective_from_dt  and  cpo.effective_to_dt -1
    and  sm.effective_from_dt  between  cpo.offer_start_dt  and  cpo.offer_end_dt -1
    and  cpo.OFFER_STATUS_CODE  in( 'ACT','PTM','BLK' ) 
    and  cpo.offer_ID  = 80152
    where  sm.Subscription_Sub_Type  = 'Sky Go Extra';
  
  select  sm.OWNING_CUST_ACCOUNT_ID , sm.subscription_id ,
     sm.effective_from_dt , WH_PH_SUBS_DTV_PV.current_product_description , WH_PH_SUBS_DTV_PV.effective_from_datetime ,
    case when  WH_PH_SUBS_DTV_PV.Current_Product_Description  = 'Boxsets' then 1 else 2 end as  With_Prems ,
     row_number () over(partition by  sm.OWNING_CUST_ACCOUNT_ID , sm.effective_from_dt  order by  With_Prems  desc, WH_PH_SUBS_DTV_PV.effective_from_datetime  desc, WH_PH_SUBS_DTV_PV.effective_to_datetime  desc) as  Package_Rnk 
    into #Subs_Package
    from #Subs_Movements as  sm 
      join  cust_subs_hist  as  WH_PH_SUBS_DTV_PV 
      on  WH_PH_SUBS_DTV_PV.OWNING_CUST_ACCOUNT_ID  =  sm.OWNING_CUST_ACCOUNT_ID 
      and  sm.effective_from_dt  between  WH_PH_SUBS_DTV_PV.EFFECTIVE_FROM_DT  and  WH_PH_SUBS_DTV_PV.EFFECTIVE_TO_DT -1
      and  WH_PH_SUBS_DTV_PV.SUBSCRIPTION_SUB_TYPE  = 'DTV Primary Viewing'
      and  WH_PH_SUBS_DTV_PV.STATUS_CODE  in( 'AC','AB','PC' ) 
      and  sm.SUBSCRIPTION_SUB_TYPE  = 'HD'
	  and  sm.current_product_sk <> 43679
      and  WH_PH_SUBS_DTV_PV.Current_Product_Description  like 'Box Sets%';
  
  commit work;
  
  create hg index  idx_1  on #Subs_Package( OWNING_CUST_ACCOUNT_ID );
  create hg index  idx_2  on #Subs_Package( subscription_id );
  create date index  idx_3  on #Subs_Package( effective_from_dt );
  create lf index  idx_4  on #Subs_Package( Package_Rnk );
  
  update #Subs_Movements as  sm 
    set  BOXSET_FLAG  =  WH_PH_SUBS_DTV_PV.Current_Product_Description  from
    #Subs_Movements as  sm 
    join #Subs_Package as  WH_PH_SUBS_DTV_PV 
    on  WH_PH_SUBS_DTV_PV.OWNING_CUST_ACCOUNT_ID  =  sm.OWNING_CUST_ACCOUNT_ID 
    and  sm.subscription_id  =  WH_PH_SUBS_DTV_PV.subscription_id 
    and  sm.effective_from_dt  =  WH_PH_SUBS_DTV_PV.effective_from_dt 
    and  WH_PH_SUBS_DTV_PV.Package_Rnk  = 1
	and  sm.current_product_sk <> 43679
    and  WH_PH_SUBS_DTV_PV.Current_Product_Description  like 'Box Sets%'
    and  sm.SUBSCRIPTION_SUB_TYPE  = 'HD';
 
/* 
  update #Subs_Movements as  sm 
    set  HDPremiumFlag  = case when  WH_PH_SUBS_DTV_HD.OWNING_CUST_ACCOUNT_ID  is null then 'No' else 'Yes' end from
    #Subs_Movements as  sm 
    left outer join  cust_subs_hist  as  WH_PH_SUBS_DTV_HD 
    on  WH_PH_SUBS_DTV_HD.OWNING_CUST_ACCOUNT_ID  =  sm.OWNING_CUST_ACCOUNT_ID 
    and  sm.subscription_id  =  WH_PH_SUBS_DTV_HD.subscription_id 
    and  sm.effective_from_dt  between  WH_PH_SUBS_DTV_HD.EFFECTIVE_FROM_DT  and  WH_PH_SUBS_DTV_HD.EFFECTIVE_TO_DT -1
    and  WH_PH_SUBS_DTV_HD.SUBSCRIPTION_SUB_TYPE  = 'HD Pack'
    and  WH_PH_SUBS_DTV_HD.STATUS_CODE  in( 'AC','AB','PC' ) 
    where  sm.SUBSCRIPTION_SUB_TYPE  = 'HD';
  */
  
  update #Subs_Movements
    set  Product_Holding 
     = case  Subscription_Sub_Type 
    when 'Multiscreen' then
      case when  Product_Holding  = 'MS+' and  ENT_CAT_PROD_SK  = 49450 then 'MS+'
      when  Product_Holding  = 'MS+' and  ENT_CAT_PROD_SK  = 52302 then 'Sky Q MS+'
      when  Product_Holding  = 'DTV Extra Subscription' then 'MS' end
    when 'Sky Go Extra' then
      case when  Product_Holding  = 'Sky Q' then 'Sky Q'
      when  Product_Holding  = 'MS+' then 'Sky Q'
      when  OfferCode  is not null then 'Opt-In'
      else 'SGE Paid'
      end
    when 'HD' then
      case 
	  when  Product_Holding  = 'Ethan' and  Country  = 'ROI' then 'HD+ ROI'
      when  Product_Holding  = 'Ethan' then 'HD+'
      when  Country  = 'ROI' then 'ROI HD'
	  when 	current_product_sk = 687 then 'Legacy'
      /*when  (current_product_sk <> 43679 and  BOXSET_FLAG  = 'Box Sets') then 'HD Basic-Box Sets (basic only)'
      when  (current_product_sk <> 43679 and BOXSET_FLAG  like 'Box Sets%') then 'HD Basic-Box Sets with SD Premiums'
	  */
	  when  current_product_sk = 43678 then 'HD Basic'
	  when  current_product_sk = 53103 then 'HD Basic-Sky HD'
	  when  current_product_sk = 43679 and effective_from_dt>='2017-12-12' and current_product_description = 'Sky Sports HD' then 'HD Premium-Rose'
	  when  current_product_sk = 43679 then 'HD Premium'
	  /*
	  when  current_product_sk = 43679 and current_product_description = 'Sky Sports HD Pack' then 'HD Premium-Sky Sports HD Pack'
	  when  current_product_sk = 43679 and current_product_description = 'Sky Sports HD' then 'HD Premium-Sky Sports HD'
	  */
	  /*when  BOXSET_FLAG  = 'Box Sets' and  HDPremiumFlag  = 'No' then 'Box Sets (basic only)'
      when  BOXSET_FLAG  like 'Box Sets%' and  HDPremiumFlag  = 'No' then 'Box Sets with SD Premiums'
      when  BOXSET_FLAG  like 'Box Sets%' and  HDPremiumFlag  = 'Yes' then 'Box Sets with HD Premiums'
	  */
      else 'Legacy'
      end
    end;
  
  delete from #Subs_Movements as  sm  where  subscription_sub_type  in( 'DTV','DTV Primary Viewing' ) ;
  commit work;
  
  insert into  Decisioning.Active_Subscriber_Report_Src (  Effective_From_Dt , Effective_To_Dt , Account_Number , Account_Type , Account_Sub_Type , Owning_Cust_Account_ID , Subscription_Type , Subscription_Sub_Type ,
     Service_Instance_ID , Subscription_ID , ph_subs_hist_sk , Status_Code , Current_Product_sk , Product_Holding , Country , Active_Subscriber , Active_Subscription ,
     PH_Subs_Status_Start_Dt , PH_Subs_Status_End_Dt_Dt , PH_Subs_Prev_Status_Code ,
     PH_Subs_Status_Reason  ) 
    select  osm.Effective_From_Dt ,
       osm.Effective_To_Dt ,
       osm.Account_Number ,
       osm.Account_Type ,
       osm.Account_Sub_Type ,
       osm.Owning_Cust_Account_ID ,
       osm.Subscription_Type ,
       osm.Subscription_Sub_Type ,
       osm.Service_Instance_ID ,
       osm.Subscription_ID ,
       osm.ph_subs_hist_sk ,
       osm.Status_Code ,
       osm.Current_Product_sk ,
       osm.Product_Holding ,
       osm.Country ,
       osm.Number_Of_Active_Subs  as  Active_Subscriber ,
       osm.Number_Of_Active_Subs  as  Active_Subscription ,
       osm.Status_Start_Dt ,
       osm.Status_End_Dt ,
       osm.Prev_Status_Code ,
       osm.Status_Reason 
      from #Subs_Movements as  osm 
      where  osm.Number_Of_Active_Subs  > 0;
  
  commit work;
  
  select  asr.owning_cust_account_id , asr.subscription_sub_type , asr.effective_from_dt  as  Change_Dt 
    into #Active_Subs_Change_Dts
    from  Decisioning.Active_Subscriber_Report_Src  as  asr 
      join  Decisioning.Active_Subscriber_Report_Src  as  asr_2 
      on  asr_2.owning_cust_account_id  =  asr.owning_cust_account_id 
      and  asr_2.subscription_sub_type  =  asr.subscription_sub_type 
      and  asr_2.ph_subs_hist_sk  <>  asr.ph_subs_hist_sk 
      and  asr_2.subscription_id  <>  asr.subscription_id 
      and  asr.effective_from_dt  between  asr_2.effective_from_dt  and  asr_2.effective_to_dt 
      and  asr_2.subscription_sub_type  in('HD','Multiscreen','Sky Go Extra' ) 
      and  asr_2.Active_Subscriber  = 1
    where  asr.Effective_To_Dt  >=  Refresh_Dt 
    and  asr.subscription_sub_type  in('HD','Multiscreen','Sky Go Extra' ) 
    and  asr.Active_Subscriber  = 1
    group by  asr.owning_cust_account_id , asr.subscription_sub_type , asr.effective_from_dt  union
  
  select  asr.owning_cust_account_id , asr.subscription_sub_type , asr.effective_to_dt  as  Change_Dt 
    from  Decisioning.Active_Subscriber_Report_Src  as  asr 
      join  Decisioning.Active_Subscriber_Report_Src  as  asr_2 
      on  asr_2.owning_cust_account_id  =  asr.owning_cust_account_id 
      and  asr_2.subscription_sub_type  =  asr.subscription_sub_type 
      and  asr_2.ph_subs_hist_sk  <>  asr.ph_subs_hist_sk 
      and  asr_2.subscription_id  <>  asr.subscription_id 
      and  asr.effective_to_dt  between  asr_2.effective_from_dt  and  asr_2.effective_to_dt 
      and  asr.subscription_sub_type  in('HD','Multiscreen','Sky Go Extra' ) 
      and  asr_2.Active_Subscriber  = 1
    where  asr.Effective_To_Dt  >=  Refresh_Dt 
    and  asr.subscription_sub_type  in('HD','Multiscreen','Sky Go Extra' ) 
    and  asr.Active_Subscriber  = 1
    group by  asr.owning_cust_account_id , asr.subscription_sub_type , asr.effective_to_dt ;
  
  while(select  count () from #Active_Subs_Change_Dts) > 0 loop
    drop table if exists #Loop_Change_Dts;
    select  owning_cust_account_id , subscription_sub_type , min ( Change_Dt ) as  Change_Dt 
      into #Loop_Change_Dts
      from #Active_Subs_Change_Dts
      group by  owning_cust_account_id , subscription_sub_type ;
    commit work;
    create hg index  idx_1  on #Loop_Change_Dts( owning_cust_account_id );
    create lf index  idx_2  on #Loop_Change_Dts( subscription_sub_type );
    create date index  idx_3  on #Loop_Change_Dts( Change_Dt );
    drop table if exists #temp_Split_Records;
    select  sm .*
      into #temp_Split_Records
      from  Decisioning.Active_Subscriber_Report_Src  as  sm 
        join #Loop_Change_Dts as  lcd 
        on  sm.owning_cust_account_id  =  lcd.owning_cust_account_id 
        and  sm.subscription_sub_type  =  lcd.subscription_sub_type 
        and  lcd.change_dt  between  sm.effective_from_dt +1 and  sm.effective_to_dt -1;
    update #temp_Split_Records as  sm 
      set  effective_to_dt  =  lcd.change_dt  from
      #Loop_Change_Dts as  lcd 
      where  sm.owning_cust_account_id  =  lcd.owning_cust_account_id 
      and  sm.subscription_sub_type  =  lcd.subscription_sub_type 
      and  lcd.change_dt  between  sm.effective_from_dt +1 and  sm.effective_to_dt -1;
    update  Decisioning.Active_Subscriber_Report_Src  as  sm 
      set  effective_from_dt  =  lcd.change_dt  from
      #Loop_Change_Dts as  lcd 
      where  sm.owning_cust_account_id  =  lcd.owning_cust_account_id 
      and  sm.subscription_sub_type  =  lcd.subscription_sub_type 
      and  lcd.change_dt  between  sm.effective_from_dt +1 and  sm.effective_to_dt -1;
    insert into  Decisioning.Active_Subscriber_Report_Src 
      select * from #temp_Split_Records;
    delete from #Active_Subs_Change_Dts as  ascd  from
      #Loop_Change_Dts as  lcd 
      where  ascd.owning_cust_account_id  =  lcd.owning_cust_account_id 
      and  ascd.subscription_sub_type  =  lcd.subscription_sub_type 
      and  ascd.Change_Dt  =  lcd.Change_Dt 
  end loop;
  
  
  drop table if exists #Active_Subs_Change_Dts;
  drop table if exists #Loop_Change_Dts;
  drop table if exists #temp_Split_Records;
  
  update  Decisioning.Active_Subscriber_Report_Src  as  asr 
    set  Effective_From_Subs_Week  = cast( sc.subs_week_and_year  as integer) from
     Decisioning.Active_Subscriber_Report_Src  as  asr 
    join  sky_calendar  as  sc 
    on  sc.calendar_date  =  asr.effective_from_dt 
    where  asr.Effective_From_Subs_Week  is null;
  
  update  Decisioning.Active_Subscriber_Report_Src  as  asr 
    set  Effective_To_Subs_Week  = cast( Coalesce ( sc.subs_week_and_year ,'999999') as integer) from
     Decisioning.Active_Subscriber_Report_Src  as  asr 
    left outer join  sky_calendar  as  sc 
    on  sc.calendar_date  =  asr.effective_to_dt 
    where( asr.Effective_To_Subs_Week  is null
    or  asr.Effective_To_Subs_Week  = 999999);
  
  select  Owning_Cust_Account_ID , ph_subs_hist_sk , Effective_From_Dt , Subscription_Sub_Type ,
    1 as  Prod_Holding_Num ,
    cast(case  status_code 
    when 'AC' then 1
    when 'PC' then 2
    when 'AB' then 3
    else 999
    end as integer) as  Status_Num ,
     Row_Number () over(partition by  Owning_Cust_Account_Id , subscription_sub_type , Effective_From_Dt  order by  Prod_Holding_Num  desc, Status_Num  asc) as  Acc_Rnk 
    into #Order_Subs_Movements
    from  Decisioning.Active_Subscriber_Report_Src  as  asr 
    where  effective_to_dt  >=  Refresh_Dt 
    and  asr.subscription_sub_type  = any(select distinct  subscription_sub_type  from #Subs_Movements);
  
  commit work;
  create hg index  idx_1  on #Order_Subs_Movements( Owning_Cust_Account_ID );
  create hg index  idx_2  on #Order_Subs_Movements( ph_subs_hist_sk );
  create date index  idx_3  on #Order_Subs_Movements( Effective_From_Dt );
  create lf index  idx_4  on #Order_Subs_Movements( Subscription_Sub_Type );
  create lf index  idx_5  on #Order_Subs_Movements( Acc_Rnk );
  
  update  Decisioning.Active_Subscriber_Report_Src  as  asr 
    set  Active_Subscriber  = case when  osm.Acc_Rnk  = 1 then 1 else 0 end from
    #Order_Subs_Movements as  osm 
    where  osm.ph_subs_hist_sk  =  asr.ph_subs_hist_sk 
    and  osm.Owning_Cust_Account_ID  =  asr.Owning_Cust_Account_ID 
    and  osm.Subscription_Sub_Type  =  asr.Subscription_Sub_Type 
    and  osm.Effective_From_Dt  =  asr.Effective_From_Dt ;
	
end

GO
GRANT EXECUTE ON Decisioning_Procs.Update_Active_Subscriber_Report_HDMSSGE TO public;



/*
call vha02.Update_Active_Subscriber_Report_HDMSSGE(today()-28);

temp view for testing:

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'Active_subscriber_Report_HD_TEST');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'Active_subscriber_Report_HD_TEST','select aa.Effective_From_Dt,aa.Effective_To_Dt,aa.Effective_From_Subs_Week,aa.Effective_To_Subs_Week,aa.Account_Number,aa.Account_Type,aa.Account_Sub_Type,aa.Owning_Cust_Account_ID,aa.Subscription_Type,aa.Subscription_Sub_Type,aa.Service_Instance_ID,aa.Subscription_ID,aa.ph_subs_hist_sk,aa.Status_Code,aa.Current_Product_sk,aa.Product_Holding,aa.Country,aa.PH_Subs_Status_Start_Dt,aa.PH_Subs_Status_End_Dt_Dt,aa.PH_Subs_Prev_Status_Code,aa.PH_Subs_Status_Reason,cast(case when aa.subscription_sub_type = ''DTV'' then aa.Active_Subscriber else 0 end as tinyint) as DTV_Active,cast(case when aa.subscription_sub_type = ''DTV'' then aa.Active_Subscription else 0 end as tinyint) as DTV_Active_Subscription,cast(case when aa.subscription_sub_type = ''Broadband'' then aa.Active_Subscriber else 0 end as tinyint) as BB_Active,cast(case when aa.subscription_sub_type = ''Broadband'' then aa.Active_Subscription else 0 end as tinyint) as BB_Active_Subscription,cast(case when aa.subscription_sub_type = ''Talk'' then aa.Active_Subscriber else 0 end as tinyint) as Talk_Active,cast(case when aa.subscription_sub_type = ''Talk'' then aa.Active_Subscription else 0 end as tinyint) as Talk_Active_Subscription,cast(case when aa.subscription_sub_type = ''Line Rental'' then aa.Active_Subscriber else 0 end as tinyint) as LR_Active,cast(case when aa.subscription_sub_type = ''Line Rental'' then aa.Active_Subscription else 0 end as tinyint) as LR_Active_Subscription,cast(case when aa.subscription_sub_type = ''Sports'' then aa.Active_Subscriber else 0 end as tinyint) as Sports_Active,cast(case when aa.subscription_sub_type = ''Sports'' then aa.Active_Subscription else 0 end as tinyint) as Sports_Active_Subscription,cast(case when aa.subscription_sub_type = ''Movies'' then aa.Active_Subscriber else 0 end as tinyint) as Movies_Active,cast(case when aa.subscription_sub_type = ''Movies'' then aa.Active_Subscription else 0 end as tinyint) as Movies_Active_Subscription,cast(case when aa.subscription_sub_type = ''Top Tier'' then aa.Active_Subscriber else 0 end as tinyint) as TT_Active,cast(case when aa.subscription_sub_type = ''Top Tier'' then aa.Active_Subscription else 0 end as tinyint) as TT_Active_Subscription,cast(case when aa.subscription_sub_type = ''HD'' then aa.Active_Subscriber else 0 end as tinyint) as HD_Active,cast(case when aa.subscription_sub_type = ''HD'' then aa.Active_Subscription else 0 end as tinyint) as HD_Active_Subscription,cast(case when aa.subscription_sub_type = ''Multiscreen'' then aa.Active_Subscriber else 0 end as tinyint) as MS_Active,cast(case when aa.subscription_sub_type = ''Multiscreen'' then aa.Active_Subscription else 0 end as tinyint) as MS_Active_Subscription,cast(case when aa.subscription_sub_type = ''Sky Go Extra'' then aa.Active_Subscriber else 0 end as tinyint) as SGE_Active,cast(case when aa.subscription_sub_type = ''Sky Go Extra'' then aa.Active_Subscription else 0 end as tinyint) as SGE_Active_Subscription,cast(case when aa.subscription_sub_type = ''A-LA-CARTE'' and aa.product_holding = ''Chelsea TV'' then aa.Active_Subscriber else 0 end as tinyint) as Chelsea_TV_Active,cast(case when aa.subscription_sub_type = ''A-LA-CARTE'' and aa.product_holding = ''Chelsea TV'' then aa.Active_Subscription else 0 end as tinyint) as Chelsea_TV_Active_Subscription,cast(case when aa.subscription_sub_type = ''A-LA-CARTE'' and aa.product_holding = ''MU TV'' then aa.Active_Subscriber else 0 end as tinyint) as MUTV_Active,cast(case when aa.subscription_sub_type = ''A-LA-CARTE'' and aa.product_holding = ''MU TV'' then aa.Active_Subscription else 0 end as tinyint) as MUTV_Active_Subscription,cast(case when aa.subscription_sub_type = ''A-LA-CARTE'' and aa.product_holding = ''Liverpool TV'' then aa.Active_Subscriber else 0 end as tinyint) as Liverpool_Active,cast(case when aa.subscription_sub_type = ''A-LA-CARTE'' and aa.product_holding = ''Liverpool TV'' then aa.Active_Subscription else 0 end as tinyint) as Liverpool_Active_Subscription,cast(case when aa.subscription_sub_type = ''A-LA-CARTE'' and aa.product_holding = ''Sky Asia'' then aa.Active_Subscriber else 0 end as tinyint) as SkyAsia_Active,cast(case when aa.subscription_sub_type = ''A-LA-CARTE'' and aa.product_holding = ''Sky Asia'' then aa.Active_Subscription else 0 end as tinyint) as SkyAsia_Active_Subscription,cast(case when aa.subscription_sub_type = ''Sky +'' then aa.Active_Subscriber else 0 end as tinyint) as SkyPlus_Active,cast(case when aa.subscription_sub_type = ''Sky +'' then aa.Active_Subscription else 0 end as tinyint) as SkyPlus_Active_Subscription,cast(case when aa.subscription_sub_type = ''BOX_SETS'' then aa.Active_Subscriber else 0 end as tinyint) as BoxSets_Active,cast(case when aa.subscription_sub_type = ''BOX_SETS'' then aa.Active_Subscription else 0 end as tinyint) as BoxSets_Active_Subscription,cast(case when aa.subscription_sub_type = ''KIDS'' then aa.Active_Subscriber else 0 end as tinyint) as Kids_Active,cast(case when aa.subscription_sub_type = ''KIDS'' then aa.Active_Subscription else 0 end as tinyint) as Kids_Active_Subscription from Decisioning.Active_Subscriber_Report_Src aa ')



select product_holding,count(*)
from Decisioning.Active_Subscriber_Report_Src
where subscription_sub_type in('HD')
and today() between effective_from_dt and effective_to_dt
group by product_holding



select product_holding,count(*)
from Decisioning.Active_Subscriber_Report_Src
where subscription_sub_type in('HD')
and today() between effective_from_dt and effective_to_dt
group by product_holding

*/