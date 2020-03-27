/*
dba.sp_drop_table 'Decisioning','Activations_DTV'
dba.sp_create_table 'Decisioning','Activations_DTV',
  'Subs_Year integer default null,'
||'Subs_Week_Of_Year integer default null,'
||'Subs_Week_And_Year   integer default null,'
||'Event_Dt  date default null,'
||'Account_Number   varchar (20) default null,'
||'Account_Type  varchar (255 )   default null,'
||'Account_Sub_Type  varchar (255 )   default null,'
||'Owning_Cust_Account_ID   varchar (50) default null,'
||'PH_Subs_Hist_sk  decimal(22,0)   default null,'
||'Subscription_Type varchar (20) default null,'
||'Subscription_Sub_Type varchar (80) default null,'
||'Service_Instance_ID  varchar (50) default null,'
||'Subscription_ID  varchar (50) default null,'
||'Status_Code  varchar (10) default null,'
||'Current_Product_sk   integer   default null,'
||'Product_Holding  char (22) default null,'
||'Event_Type   char (16) default null,'
||'Short_Description varchar(255) default null,'
||'Product_Description varchar(240) default null,'
||'Prev_Status_Code  varchar (10) default null,'
||'Country  char (3 ) default null,'
||'ACTIVATION   smallint default null,'
||'NewCust_Activation   smallint default null,'
||'Reinstate_Activation smallint default null,'
||'PO_Reinstate  smallint default null,'
||'PO_Winback   smallint default null,'
||'PO_Reinstate_Over12m  smallint default null,'
||'SC_Reinstate  smallint default null,'
||'SC_Winback   smallint default null,'
||'SC_Reinstate_Over12m  smallint default null,'
||'Order_ID  varchar (150) default null,'
||'primary_product_decoder_number   varchar (17) default null,'
||'primary_box_installed_dt  date default null,'
||'primary_box_replaced_dt  date default null,'
||'primary_box_current_product_description  varchar (240 )   default null,'
||'primary_box_terms_end_date   date default null,'
||'primary_box_x_manufacturer   varchar (50) default null,'
||'primary_box_x_pvr_type   varchar (20) default null,'
||'primary_box_x_description varchar (100 )   default null,'
||'primary_box_x_anytime_storage_capacity   varchar (10) default null'

*/
setuser Decisioning_Procs;
GO
drop procedure if exists Decisioning_Procs.Update_Decisioning_Activations_DTV;
GO
create procedure Decisioning_Procs.Update_Decisioning_Activations_DTV( Refresh_Dt date default null ) 
sql security invoker
begin
  set temporary option Query_Temp_Space_Limit = 0;
  commit work;
  if Refresh_Dt is null then
    set Refresh_Dt
       = (select max(event_dt)-2*7
        from Decisioning.Activations_DTV)
  end if;
  delete from
    Decisioning.Activations_DTV
    where Event_Dt >= Refresh_Dt;
  drop table if exists #WH_PH_SUBS_HIST;
  select null as Subs_Year,
    null as Subs_Week_Of_Year,
    null as Subs_Week_And_Year,
    WH_PH_SUBS_HIST.EFFECTIVE_FROM_DT as Event_Dt,
    Account_number,
    WH_PH_SUBS_HIST.Account_Type,
    WH_PH_SUBS_HIST.Account_Sub_Type,
    WH_PH_SUBS_HIST.Owning_Cust_Account_ID,
    WH_PH_SUBS_HIST.PH_Subs_Hist_sk,
    WH_PH_SUBS_HIST.Subscription_Type,
    WH_PH_SUBS_HIST.Subscription_Sub_Type,
    WH_PH_SUBS_HIST.Service_Instance_ID,
    WH_PH_SUBS_HIST.Subscription_ID,
    WH_PH_SUBS_HIST.Status_Code,
    WH_PH_SUBS_HIST.Current_Product_sk,
    case when current_fo_src_system_catalogue_id in( '14015','14016','14017','14018','14019','14020','14021','14022','14023','14024','14025','14026','14027','14028','14029','14030' ) then 'Sky Q'
    when current_fo_src_system_catalogue_id in( '13876','13877','13878','13879','13880','13881','13882','13883','13884','13885','13886','13887','13888','13889','13890','13891' ) then 'Box Sets'
    when current_fo_src_system_catalogue_id in( '13697','13698','13699','13700','13701','13702','13703','13704','13705','13706','13707','13708','13709','13710','13711','13712' ) then 'Variety'
    when current_fo_src_system_catalogue_id in( '13713','13714','13715','13716','13717','13718','13719','13720','13721','13722','13723','13724','13725','13726','13727','13728','14042','14043','14044','14045','14046','14047','14048','14049','14050','14051','14052','14053','14054','14055','14056','14057' ) then 'Original (Legacy)'
    when current_fo_src_system_catalogue_id in( '14230','14231','14232','14233','14234','14235','14236','14237','14238','14239','14240','14241','14242','14243','14244','14245' ) then 'Original (Legacy 2017)'
    when current_fo_src_system_catalogue_id in( '14380','14381','14382','14383','14384','14385','14386','14387','14388','14389','14390','14391','14392','14393','14394','14395' ) then 'Original'
    when current_product_description like 'Sky Entertainment%' then 'Sky Entertainment'
    when cel.Basic_Desc in( '1 Mix-YNNNNN','1 Mix-NNNYNN','2 Mix-YNNYNN','1 Mix-NNNNNN','0 Mix-NNNNNN','' ) then 'Original (Legacy)'
    when cel.Basic_Desc in( '6 Mix-NNNNNN' ) then 'Variety'
    when current_product_description like 'Sky Q%' then 'Sky Q'
    when current_product_description like '6 Mix%' then 'Variety'
    when current_product_description like 'Kids%' then 'Variety'
    when current_product_description like 'Variety%' then 'Variety'
    when current_product_description like 'Knowledge%' then 'Variety'
    when current_product_description like 'News%' then 'Variety'
    when current_product_description like 'Music%' then 'Variety'
    when current_product_description like 'Sky%' then 'Variety'
    when current_product_description like 'Style%' then 'Variety'
    when current_product_description like 'Extra%' then 'Variety'
    else 'Original (Legacy)'
    end as Product_Description_1,
    case when current_fo_src_system_catalogue_id in( '13710','13726','13889','14055','14243','14393' ) then ' with Cinema 1'
    when current_fo_src_system_catalogue_id in( '13711','13727','13890','14056','14244','14394' ) then ' with Cinema 2'
    when current_fo_src_system_catalogue_id in( '13708','13724','13887','14053','14241','14391' ) then ' with Sports 1'
    when current_fo_src_system_catalogue_id in( '13709','13725','13888','14054','14242','14392' ) then ' with Sports 2'
    when current_fo_src_system_catalogue_id in( '13704','13720','13883','14049','14237','14387' ) then ' with Sports 1 & Cinema 1'
    when current_fo_src_system_catalogue_id in( '13705','13721','13884','14050','14238','14388' ) then ' with Sports 1 & Cinema 2'
    when current_fo_src_system_catalogue_id in( '13706','13722','13885','14051','14239','14389' ) then ' with Sports 2 & Cinema 1'
    when current_fo_src_system_catalogue_id in( '13707','13723','13886','14052','14240','14390' ) then ' with Sports 2 & Cinema 2'
    when current_fo_src_system_catalogue_id in( '13699','13715','13878','14044','14017','14232','14382' ) then ' with Cinema'
    when current_fo_src_system_catalogue_id in( '13698','13714','13877','14043','14016','14231','14381' ) then ' with Sports'
    when current_fo_src_system_catalogue_id in( '13697','13713','13876','14042','14015','14230','14380' ) then ' with Sports & Cinema'
    when current_fo_src_system_catalogue_id in( '13702','13718','13881','14047','14235','14385' ) then ' with Sports 1 & Cinema'
    when current_fo_src_system_catalogue_id in( '13703','13719','13882','14048','14236','14386' ) then ' with Sports 2 & Cinema'
    when current_fo_src_system_catalogue_id in( '13700','13716','13879','14045','14233','14383' ) then ' with Sports & Cinema 1'
    when current_fo_src_system_catalogue_id in( '13701','13717','13880','14046','14234','14384' ) then ' with Sports & Cinema 2'
    when current_product_description like 'Sky World%' then ' with Sports & Cinema'
    when current_product_description like '%with Family Pack - 1B' then ' with Cinema'
    when current_product_description like '%with Family Pack - 1C' then ' with Sports'
    when current_product_description like '%with Family Pack - 1J' then ' with Sports 1 & Cinema 2'
    when current_product_description like '%with Movies Mix' then ' with Cinema'
    when current_product_description like '%with Sports Mix' then ' with Sports'
    when current_product_description like '%with Movies 1' then ' with Cinema 1'
    when current_product_description like '%with Movies 2' then ' with Cinema 2'
    when current_product_description like '%with Sports 1' then ' with Sports 1'
    when current_product_description like '%with Sports 2' then ' with Sports 2'
    when current_product_description like '%with Sports 1 & Movies 1' then ' with Sports 1 & Cinema 1'
    when current_product_description like '%with Sports 1 & Movies 2' then ' with Sports 1 & Cinema 2'
    when current_product_description like '%with Sports 2 & Movies 1' then ' with Sports 2 & Cinema 1'
    when current_product_description like '%with Sports 2 & Movies 2' then ' with Sports 2 & Cinema 2'
    when current_product_description like '%with Sports 1 & Movies Mix' then ' with Sports 1 & Cinema'
    when current_product_description like '%with Sports 2 & Movies Mix' then ' with Sports 2 & Cinema'
    when current_product_description like '%with Sports Mix & Movies 1' then ' with Sports & Cinema 1'
    when current_product_description like '%with Sports Mix & Movies 2' then ' with Sports & Cinema 2'
    when current_product_description like '%with Sports Mix & Movies Mix' then ' with Sports & Cinema' end as Product_Description_2,
    Product_Description_1 as Product_Holding,
    case when Status_Code = 'AC' and Prev_Status_Code in( 'BL','EN','IT','PA','SU' ) then 'Activation'
    when Status_Code in( 'AC','AB','PC' ) and Prev_Status_Code in( 'PO','SC' ) then 'Reinstate'
    when Status_Code in( 'AC','AB','PC' ) and Prev_Status_Code not in( 'AC','AB','PC' ) then 'Other Activation' end as Event_Type,
    Current_Short_Description as Short_Description,
    Current_Product_Description as Product_Description,
    null as Prems,
    0 as Sports,
    0 as Cinema,
    case when Event_Type = 'Reinstate' then Current_Short_Description end as Prev_Short_Description,
    case when Event_Type = 'Reinstate' then Current_Product_Description end as Prev_Product_Description,
    null as Prev_Prems,
    0 as Prev_Sports,
    0 as Prev_Cinema,
    WH_PH_SUBS_HIST.PREV_STATUS_CODE,
    case when WH_PH_SUBS_HIST.CURRENCY_CODE = 'EUR' then 'ROI'
    else 'UK'
    end as Country,
    STATUS_CODE as Movement_Type,
    case when Movement_Type = 'AC' and PREV_STATUS_CODE = 'PO' then 1
    else 0
    end as PO_Reinstate,
    PO_Reinstate-PO_Winback as PO_Reinstate_Over12m,
    case when Movement_Type = 'AC' and PREV_STATUS_CODE = 'PO' and DATEADD(month,12,PREV_STATUS_START_DT) >= STATUS_START_DT then 1
    else 0
    end as PO_Winback,
    case when Movement_Type = 'AC' and PREV_STATUS_CODE = 'SC' then 1
    else 0
    end as SC_Reinstate,
    SC_Reinstate-SC_Winback as SC_Reinstate_Over12m,
    case when Movement_Type = 'AC' and PREV_STATUS_CODE = 'SC' and DATEADD(month,12,PREV_STATUS_START_DT) >= STATUS_START_DT then 1
    else 0
    end as SC_Winback,
    Order_ID,
        --Cast(0 AS smallint) AS primary_is_skyq_box, 
  cast (null AS varchar(17)) as  primary_product_decoder_number, 
  Cast(null AS date) as primary_box_installed_dt , 
  Cast(null AS date) as  primary_box_replaced_dt, 
  Cast(null AS varchar(240)) as primary_box_current_product_description, 
  /*primary_box_interest_source_level_1_description varchar(255) DEFAULT NULL, 
  primary_box_interest_source_level_2_description varchar(255) DEFAULT NULL, 
  primary_box_interest_source_level_3_description varchar(255) DEFAULT NULL, 
  primary_box_status_code varchar(10) DEFAULT NULL, 
  primary_box_status_start_dt date DEFAULT NULL, */
  Cast(null AS date)  primary_box_terms_end_date, 
  Cast(null AS varchar(50)) as primary_box_x_manufacturer, 
  Cast(null AS varchar(20)) as primary_box_x_pvr_type, 
  Cast(null AS varchar(100)) as  primary_box_x_description , 
  Cast(null AS varchar(10)) as primary_box_x_anytime_storage_capacity 
  --primary_box_x_model_number varchar(20) DEFAULT NULL, 
  --Cast(null AS varchar(1)) as primary_box_x_active_box_flag_new 
 -- primary_box_x_subscription_sub_type varchar(50) DEFAULT NULL, 

    
    into #WH_PH_SUBS_HIST
    from Cust_Subs_Hist as WH_PH_SUBS_HIST
      left outer join Cust_Entitlement_Lookup as cel
      on cel.short_description = WH_PH_SUBS_HIST.current_short_description
    where WH_PH_SUBS_HIST.EFFECTIVE_FROM_DT >= Refresh_Dt
    and WH_PH_SUBS_HIST.SUBSCRIPTION_SUB_TYPE = 'DTV Primary Viewing'
    and WH_PH_SUBS_HIST.STATUS_CODE_CHANGED = 'Y'
    and WH_PH_SUBS_HIST.OWNING_CUST_ACCOUNT_ID <> '1';
  
  
Update #WH_PH_SUBS_HIST
Set 
CA.primary_product_decoder_number = STB.decoder_nds_number,
CA.primary_box_installed_dt = STB.box_installed_dt,
CA.primary_box_replaced_dt = STB.box_replaced_dt,
CA.primary_box_current_product_description = STB.current_product_description,
/*CA.primary_box_interest_source_level_1_description = STB.interest_source_level_1_description,
CA.primary_box_interest_source_level_2_description = STB.interest_source_level_2_description,
CA.primary_box_interest_source_level_3_description = STB.interest_source_level_3_description,
CA.primary_box_status_code = STB.status_code,
CA.primary_box_status_start_dt = STB.status_start_dt,*/
CA.primary_box_terms_end_date = STB.terms_end_date,
CA.primary_box_x_manufacturer = STB.x_manufacturer,
CA.primary_box_x_pvr_type = STB.x_pvr_type,
CA.primary_box_x_description = STB.x_description,
CA.primary_box_x_anytime_storage_capacity = STB.x_anytime_storage_capacity
--CA.primary_box_x_model_number = STB.x_model_number,
--CA.primary_box_x_active_box_flag_new = STB.X_active_box_flag_new
--CA.primary_box_x_subscription_sub_type = STB.x_subscription_sub_type
from #WH_PH_SUBS_HIST CA
left join 
CUST_SET_TOP_BOX STB
on CA.account_number=STB.account_number
--AND CA.Current_Product_sk = STB.product_sk
--AND CA.Order_ID = STB.Order_ID
--AND  STB.x_active_box_flag_new ='Y'  
AND CA.Service_Instance_ID = STB.Service_Instance_ID 
--AND STB.x_subscription_sub_type= CA.subscription_sub_type --'DTV Primary Viewing'
;



  insert into Decisioning.Activations_DTV
    select Subs_Year,
      Subs_Week_Of_Year,
      Subs_Week_And_Year,
      Event_Dt,
      Account_Number,
      Account_Type,
      Account_Sub_Type,
      Owning_Cust_Account_ID,
      PH_Subs_Hist_sk,
      Subscription_Type,
      Subscription_Sub_Type,
      Service_Instance_ID,
      Subscription_ID,
      Status_Code,
      Current_Product_sk,
      Product_Holding,
      Event_Type,
      null as Short_Description,
      null as Product_Description,
      Prev_Status_Code,
      Country,
      case when Event_Type in( 'Activation','Reinstate','Other Activation' ) then 1
      else 0
      end as ACTIVATION,
      case when Event_Type = 'Activation' then 1
      else 0
      end as NewCust_Activation,
      case when Event_Type = 'Reinstate' then 1
      else 0
      end as Reinstate,
      PO_Reinstate,
      PO_Winback,
      PO_Reinstate_Over12m,
      SC_Reinstate,
      SC_Winback,
      SC_Reinstate_Over12m,
      Order_ID,
      primary_product_decoder_number,
      primary_box_installed_dt,
      primary_box_replaced_dt,
      primary_box_current_product_description,
      primary_box_terms_end_date,
      primary_box_x_manufacturer,
      primary_box_x_pvr_type,
      primary_box_x_description,
      primary_box_x_anytime_storage_capacity
      --primary_box_x_active_box_flag_new
      from #WH_PH_SUBS_HIST
      where Event_Type in( 'Activation','Reinstate','Other Activation' ) ;
	  
  update Decisioning.Activations_DTV as dsra
    set Subs_Year = sc.Subs_Year,
    Subs_Week_And_Year = cast(sc.subs_week_and_year as integer),
    Subs_Week_Of_Year = sc.Subs_Week_Of_Year from
    Decisioning.Activations_DTV as dsra
    join sky_calendar as sc
    on sc.calendar_date = dsra.event_dt
    where dsra.subs_year is null;
	
  update Decisioning.Activations_DTV as dsra
    set Short_Description = csh.Current_Short_Description,
    Product_Description = csh.Current_Product_Description from
    Decisioning.Activations_DTV as dsra
    join cust_subs_hist as csh
    on csh.account_number = dsra.account_number
    and dsra.event_dt between csh.effective_from_dt and csh.effective_to_dt-1
    and csh.SUBSCRIPTION_SUB_TYPE = 'DTV Primary Viewing'
    and csh.Status_Code in( 'AC','AB','PC' ) 
    and csh.OWNING_CUST_ACCOUNT_ID > '1'
    where dsra.Event_Dt >= Refresh_Dt
end
Go
grant execute on Decisioning_Procs.Update_Decisioning_Activations_DTV to public