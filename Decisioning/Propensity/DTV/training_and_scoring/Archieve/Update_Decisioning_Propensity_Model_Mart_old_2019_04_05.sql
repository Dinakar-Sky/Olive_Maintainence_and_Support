create procedure Decisioning_Procs.Update_Decisioning_Propensity_Model_Mart( 
  in Propensity_Table varchar(100), -- 'Training' or 'Scoring' or 'Evaluation'
  in start_date date default null,
  in end_date date default null ) 
sql security invoker
begin
  declare Loop_Num integer;
  declare Dynamic_SQL long varchar;
  declare Eval_Column_Name varchar(100);
  declare Proc_Trgt_Table varchar(100);
  declare Model_Name varchar(100);
  declare Obs_Dt_Field varchar(100);
  declare Score_Field varchar(100);
  declare Decile_Field varchar(100);
  set temporary option Query_Temp_Space_Limit = 0;
  commit work;
  -------------------------------------------
  --  0.0 Configuration
  -------------------------------------------
  if Propensity_Table not in( 'Training','Scoring','Evaluation' ) then return end if;
  if Propensity_Table = 'Training' then
    if end_date is null then
      set end_date = (select max(calendar_date) from sky_calendar where datepart(day,calendar_date+1) = 1 and calendar_date < today()-30)
    end if;
    if start_date is null then
      set start_date = End_date
    end if
  elseif Propensity_Table = 'Scoring' then
    set end_date = case when end_date is null then(select max(calendar_date) from sky_calendar where calendar_date < today()) else end_date end;
    set start_date = end_date
  end if;
  -- Select start_date,end_date;
  /*------------------------------------------------------------------------------------------------------------------------------------*/
  --  1.0 Create Propensity_Model_Mart dataset
  /*------------------------------------------------------------------------------------------------------------------------------------*/
  call dba.sp_drop_table('Decisioning','Propensity_Model_Mart');
  call dba.sp_create_table('Decisioning','Propensity_Model_Mart',
  'Base_Dt Date default null, '
   || 'account_number varchar(20) default null ');
  commit work;
  create hg index idx_1 on Decisioning.Propensity_Model_Mart(Account_Number);
  create date index idx_2 on Decisioning.Propensity_Model_Mart(Base_Dt);
  if Propensity_Table in( 'Training','Scoring' ) then
    drop table if exists #Qtr_Wk_End_Dts;
    execute immediate 'SELECT calendar_date '
       || 'INTO #Qtr_Wk_End_Dts '
       || 'FROM sky_calendar '
       || 'WHERE calendar_date BETWEEN start_date AND end_date '
       || case when Propensity_Table = 'Training' then ' and datepart(DAY,calendar_date+1) = 1 ' end;
    create lf index idx_1 on #Qtr_Wk_End_Dts(Calendar_Date);
    insert into Decisioning.Propensity_Model_Mart
      --top 10
      select cast(wk.calendar_date as date) as Base_Dt,account_number --,product_holding DTV_Product_Holding,status_code as DTV_Status_Code
        from #Qtr_Wk_End_Dts as wk
          join Decisioning.Active_Subscriber_Report as asr
          on wk.calendar_date between effective_from_dt and effective_to_dt-1
          and subscription_sub_type = 'DTV'
        group by Base_Dt,account_number union
      select cast(wk.calendar_date as date) as Base_Dt,account_number --,product_holding BB_Product_Holding,status_code as BB_Status_Code
        from #Qtr_Wk_End_Dts as wk
          join Decisioning.Active_Subscriber_Report as asr
          on wk.calendar_date between effective_from_dt and effective_to_dt-1
          and subscription_sub_type = 'Broadband'
        group by Base_Dt,account_number;
    commit work
  elseif Propensity_Table = 'Evaluation' then
    insert into Decisioning.Propensity_Model_Mart
      select Base_Dt,Account_Number
        from Decisioning.Propensity_Model_Mart_Evaluation
  end if;
  -- Select * from sp_Columns('Propensity_Model_Mart') where table_owner = 'Decisioning'
  -- Select top 100 * from Decisioning.Propensity_Model_Mart where 
  /*------------------------------------------------------------------------------------------------------------------------------------*/
  --  1.1 Add Model T Attributes to Model Base Table
  /*------------------------------------------------------------------------------------------------------------------------------------*/
  set Proc_Trgt_Table
     = case Propensity_Table
    when 'Training' then 'Decisioning.Propensity_Model_Mart'
    when 'Scoring' then 'Decisioning.Propensity_Model_Mart'
    when 'Evaluation' then 'Decisioning.Propensity_Model_Mart' end;
  if Propensity_Table in( 'Training','Scoring' ) then
    call Decisioning_procs.Add_Subs_Calendar_Fields(Proc_Trgt_Table,'Base_Dt');
    call Decisioning_procs.Add_Active_Subscriber_Product_Holding(Proc_Trgt_Table,'Base_Dt','DTV');
    call Decisioning_procs.Add_Active_Subscriber_Product_Holding(Proc_Trgt_Table,'Base_Dt','BB');
    call Decisioning_procs.Add_Active_Subscriber_Product_Holding(Proc_Trgt_Table,'Base_Dt','Sports');
    call Decisioning_procs.Add_Active_Subscriber_Product_Holding(Proc_Trgt_Table,'Base_Dt','Movies');
    call Decisioning_procs.Add_Active_Subscriber_Product_Holding(Proc_Trgt_Table,'Base_Dt','MULTISCREEN');
    call Decisioning_procs.Add_Active_Subscriber_Product_Holding(Proc_Trgt_Table,'Base_Dt','SGE');
    call Decisioning_Procs.Add_Active_Subscriber_Product_Holding(Proc_Trgt_Table,'Base_Dt','HD');
    call Decisioning_Procs.Add_Active_Subscriber_Product_Holding(Proc_Trgt_Table,'Base_Dt','SkyKids');
    commit work;
    call Decisioning_Procs.Add_Activations_DTV(Proc_Trgt_Table,'Base_Dt');
    call Decisioning_Procs.Add_Activation_BB(Proc_Trgt_Table,'Base_Dt');
    call Decisioning_Procs.Add_Activations_Prems(Proc_Trgt_Table,'Base_Dt','Sports');
    call Decisioning_Procs.Add_Activations_Prems(Proc_Trgt_Table,'Base_Dt','Movies');
    call Decisioning_Procs.Add_Activations_MS(Proc_Trgt_Table,'Base_Dt');
    commit work;
    call Decisioning_Procs.Add_Churn_DTV(Proc_Trgt_Table,'Base_Dt');
    call Decisioning_Procs.Add_Churn_BB(Proc_Trgt_Table,'Base_Dt');
    call Decisioning_Procs.Add_Churn_Prems(Proc_Trgt_Table,'Base_Dt','Sports');
    call Decisioning_Procs.Add_Churn_Prems(Proc_Trgt_Table,'Base_Dt','Movies');
    call Decisioning_Procs.Add_PL_Entries_DTV(Proc_Trgt_Table,'Base_Dt');
    call Decisioning_Procs.Add_PL_Entries_BB(Proc_Trgt_Table,'Base_Dt');
    commit work;
    call Decisioning_procs.Add_Demographics_To_Base(Proc_Trgt_Table,'Base_Dt');
    commit work;
    call Decisioning_procs.Add_Fibre_Areas(Proc_Trgt_Table);
    call Decisioning_Procs.Add_Turnaround_Attempts(Proc_Trgt_Table,'Base_Dt','TA Events');
    call Decisioning_Procs.Add_Calls_Answered(Proc_Trgt_Table,'Base_Dt','Value');
    call Decisioning_procs.Add_BB_Provider(Proc_Trgt_Table,'Base_Dt');
    call Decisioning_procs.Add_Broadband_Postcode_Exchange_To_Base(Proc_Trgt_Table);
    commit work;
    call Decisioning_procs.Add_OD_Downloads(Proc_Trgt_Table,'Base_Dt');
    commit work;
    call Decisioning_procs.Add_Contract_Details(Proc_Trgt_Table,'Base_Dt','DTV');
    call Decisioning_procs.Add_Contract_Details(Proc_Trgt_Table,'Base_Dt','BB');
    commit work;
    call Decisioning_procs.Add_Offers_Software(Proc_Trgt_Table,'Base_Dt','DTV');
    call Decisioning_procs.Add_Offers_Software(Proc_Trgt_Table,'Base_Dt','BB');
    call Decisioning_procs.Add_Offers_Software(Proc_Trgt_Table,'Base_Dt','Sports');
    call Decisioning_procs.Add_Offers_Software(Proc_Trgt_Table,'Base_Dt','Movies');
    call Decisioning_procs.Add_Offers_Software(Proc_Trgt_Table,'Base_Dt','Any');
    commit work;
    call Decisioning_Procs.Add_Sports_App_Usage(Proc_Trgt_Table,'Base_Dt');
    call Decisioning_procs.Add_Team_Preferences(Proc_Trgt_Table,'Base_Dt');
    -- Adding the SGE Activation proc to get SGE_Last_Activation variables for mobile model. To be changed from gma80 to decisioing location once the proc is available in decisioning
    call Decisioning_procs.Add_Activations_SGE(Proc_Trgt_Table,'Base_Dt','Drop and Replace');
    commit work
  end if;
  call Decisioning_procs.Add_Software_Orders(Proc_Trgt_Table,'Base_Dt','Movies');
  call Decisioning_procs.Add_Software_Orders(Proc_Trgt_Table,'Base_Dt','Sports');
  call Decisioning_procs.Add_Software_Orders(Proc_Trgt_Table,'Base_Dt','HD_BASIC','Exclude Regrades','Account_Number',null,'Drop and Replace','Order_HD_BASIC_Added_In_next_30d','Order_HD_BASIC_Added_In_Last_30d');
  call Decisioning_procs.Add_Software_Orders(Proc_Trgt_Table,'Base_Dt','FAMILY','Exclude Regrades','Account_Number',null,'Drop and Replace','Order_FAMILY_Added_In_Next_30d','Order_FAMILY_Added_In_Last_30d');
  call Decisioning_procs.Add_Software_Orders(Proc_Trgt_Table,'Base_Dt','BB_UNLIMITED','Exclude Regrades','Account_Number',null,'Drop and Replace','Order_BB_UNLIMITED_Added_In_Next_30d','Order_BB_UNLIMITED_Added_In_Last_30d');
  call Decisioning_procs.Add_Software_Orders(Proc_Trgt_Table,'Base_Dt','BB_LITE','Exclude Regrades','Account_Number',null,'Drop and Replace','Order_BB_LITE_Added_In_Next_30d','Order_BB_LITE_Added_In_Last_30d');
  call Decisioning_procs.Add_Software_Orders(Proc_Trgt_Table,'Base_Dt','BB_FIBRE_CAP','Exclude Regrades','Account_Number',null,'Drop and Replace','Order_BB_FIBRE_CAP_Added_In_Next_30d','Order_BB_FIBRE_CAP_Added_In_Last_30d');
  call Decisioning_procs.Add_Software_Orders(Proc_Trgt_Table,'Base_Dt','BB_FIBRE_UNLIMITED','Exclude Regrades','Account_Number',null,'Drop and Replace','Order_BB_FIBRE_UNLIMITED_Added_In_Next_30d','Order_BB_FIBRE_UNLIMITED_Added_In_Last_30d');
  call Decisioning_procs.Add_Software_Orders(Proc_Trgt_Table,'Base_Dt','BB_FIBRE_UNLIMITED_PRO','Exclude Regrades','Account_Number',null,'Drop and Replace','Order_BB_FIBRE_UNLIMITED_PRO_Added_In_Next_30d','Order_BB_FIBRE_UNLIMITED_PRO_Added_In_Last_30d');
  call Decisioning_procs.Add_Software_Orders(Proc_Trgt_Table,'Base_Dt','MS+','Exclude Regrades','Account_Number',null,'Drop and Replace');
  call Decisioning_procs.Add_Software_Orders(Proc_Trgt_Table,'Base_Dt','MS+','Exclude Regrades','Account_Number',null,'Drop and Replace','Order_MULTISCREEN_PLUS_Added_In_Next_30d','Order_MULTISCREEN_PLUS_Removed_In_Next_30d');
  call Decisioning_procs.Add_Software_Orders(Proc_Trgt_Table,'Base_Dt','MS','Exclude Regrades','Account_Number',null,'Drop and Replace','Order_MULTISCREEN_Added_in_next_60d','Order_MULTISCREEN_removed_in_next_60d');
  call Decisioning_procs.Add_Software_Orders(Proc_Trgt_Table,'Base_Dt','Mobile Subs','Exclude Regrades','Account_Number');
  call Decisioning_procs.Add_Software_Orders(Proc_Trgt_Table,'Base_Dt','SKY_MOBILE_HANDSET','Exclude Regrades','Account_Number',null,'Drop and Replace','Order_SKY_MOBILE_HANDSET_Added_In_Next_30d','Order_SKY_MOBILE_HANDSET_Added_In_Last_30d','Order_SKY_MOBILE_HANDSET_Removed_In_Next_30d');
  call Decisioning_procs.Add_Software_Orders(Proc_Trgt_Table,'Base_Dt','KIDS');
  commit work;
  call Decisioning_procs.Add_OTT_Purchases(Proc_Trgt_Table,'Base_Dt'); -- ALL OTT
  call Decisioning_procs.Add_OTT_Purchases(Proc_Trgt_Table,'Base_Dt','Movies');
  call Decisioning_procs.Add_OTT_Purchases(Proc_Trgt_Table,'Base_Dt','BNK');
  call Decisioning_procs.Add_OTT_Purchases(Proc_Trgt_Table,'Base_Dt','EVENT');
  commit work;
  /*------------------------------------------------------------------------------------------------------------------------------------*/
  --  2.0 Creating extra variables
  /*------------------------------------------------------------------------------------------------------------------------------------*/
  if Propensity_Table in( 'Training','Scoring' ) then
    --  2.1 NOW TV Variables
    alter table Decisioning.Propensity_Model_Mart add
      NTV_Ents_Last_30D bit not null default 0,add
      NTV_Ents_Last_90D bit not null default 0;
    update Decisioning.Propensity_Model_Mart as csr
      set NTV_Ents_Last_30D = 1 from
      citeam.nowtv_accounts_ents as ntvents
      where csr.account_number = ntvents.account_number
      and ntvents.subscriber_this_period = 1
      and DATEDIFF(dd,csr.base_dt,ntvents.period_start_date) >= -30
      and DATEDIFF(dd,csr.base_dt,ntvents.period_start_date) <= 0
      and ntvents.accountid is not null;
    update Decisioning.Propensity_Model_Mart as csr
      set NTV_Ents_Last_90D = 1 from
      citeam.nowtv_accounts_ents as ntvents
      where csr.account_number = ntvents.account_number
      and ntvents.subscriber_this_period = 1
      and DATEDIFF(dd,csr.base_dt,ntvents.period_start_date) >= -90
      and DATEDIFF(dd,csr.base_dt,ntvents.period_start_date) <= 0
      and ntvents.accountid is not null;
    --  2.2 Recode DTV product holding
    -- Recode in view
    alter table Decisioning.Propensity_Model_Mart add
      DTV_product_holding_recode varchar(40) null;
    update Decisioning.Propensity_Model_Mart
      set DTV_product_holding_recode = case when DTV_Product_Holding = 'Box Sets' then 'Box Sets'
      when DTV_Product_Holding = 'Box Sets with Cinema' then 'Box Sets with Cinema'
      when DTV_Product_Holding = 'Box Sets with Cinema 1' then 'Box Sets with Cinema'
      when DTV_Product_Holding = 'Box Sets with Cinema 2' then 'Box Sets with Cinema'
      when DTV_Product_Holding = 'Box Sets with Sports' then 'Box Sets with Sports'
      when DTV_Product_Holding = 'Box Sets with Sports & Cinema' then 'Box Sets with Sports & Cinema'
      when DTV_Product_Holding = 'Box Sets with Sports & Cinema 1' then 'Box Sets with Sports & Cinema'
      when DTV_Product_Holding = 'Box Sets with Sports & Cinema 2' then 'Box Sets with Sports & Cinema'
      when DTV_Product_Holding = 'Box Sets with Sports 1' then 'Box Sets with Sports'
      when DTV_Product_Holding = 'Box Sets with Sports 1 & Cinema' then 'Box Sets with Sports & Cinema'
      when DTV_Product_Holding = 'Box Sets with Sports 2' then 'Box Sets with Sports'
      when DTV_Product_Holding = 'Box Sets with Sports 2 & Cinema' then 'Box Sets with Sports & Cinema'
      when DTV_Product_Holding = 'Original' then 'Original'
      when DTV_Product_Holding = 'Original (Legacy 2017)' then 'Original'
      when DTV_Product_Holding = 'Original (Legacy 2017) with Cinema' then 'Original with Cinema'
      when DTV_Product_Holding = 'Original (Legacy 2017) with Sports' then 'Original with Sports'
      when DTV_Product_Holding = 'Original (Legacy 2017) with Sports & Cinema' then 'Original with Sports & Cinema'
      when DTV_Product_Holding = 'Original (Legacy 2017) with Sports 1' then 'Original with Sports'
      when DTV_Product_Holding = 'Original (Legacy 2017) with Sports 1 & Cinema' then 'Original with Sports & Cinema'
      when DTV_Product_Holding = 'Original (Legacy 2017) with Sports 2' then 'Original with Sports'
      when DTV_Product_Holding = 'Original (Legacy 2017) with Sports 2 & Cinema' then 'Original with Sports & Cinema'
      when DTV_Product_Holding = 'Original (Legacy)' then 'Original'
      when DTV_Product_Holding = 'Original (Legacy) with Cinema' then 'Original with Cinema'
      when DTV_Product_Holding = 'Original (Legacy) with Cinema 1' then 'Original with Cinema'
      when DTV_Product_Holding = 'Original (Legacy) with Cinema 2' then 'Original with Cinema'
      when DTV_Product_Holding = 'Original (Legacy) with Sports' then 'Original with Sports'
      when DTV_Product_Holding = 'Original (Legacy) with Sports & Cinema' then 'Original with Sports & Cinema'
      when DTV_Product_Holding = 'Original (Legacy) with Sports & Cinema 1' then 'Original with Sports & Cinema'
      when DTV_Product_Holding = 'Original (Legacy) with Sports 1' then 'Original with Sports'
      when DTV_Product_Holding = 'Original (Legacy) with Sports 1 & Cinema' then 'Original with Sports & Cinema'
      when DTV_Product_Holding = 'Original (Legacy) with Sports 1 & Cinema 1' then 'Original with Sports & Cinema'
      when DTV_Product_Holding = 'Original (Legacy) with Sports 1 & Cinema 2' then 'Original with Sports & Cinema'
      when DTV_Product_Holding = 'Original (Legacy) with Sports 2' then 'Original with Sports'
      when DTV_Product_Holding = 'Original (Legacy) with Sports 2 & Cinema' then 'Original with Sports & Cinema'
      when DTV_Product_Holding = 'Original with Cinema' then 'Original with Cinema'
      when DTV_Product_Holding = 'Original with Sports' then 'Original with Sports'
      when DTV_Product_Holding = 'Original with Sports & Cinema' then 'Original with Sports & Cinema'
      when DTV_Product_Holding = 'Original with Sports 1' then 'Original with Sports'
      when DTV_Product_Holding = 'Original with Sports 1 & Cinema' then 'Original with Sports & Cinema'
      when DTV_Product_Holding = 'Original with Sports 2' then 'Original with Sports'
      when DTV_Product_Holding = 'Original with Sports 2 & Cinema' then 'Original with Sports & Cinema'
      when DTV_Product_Holding = 'Sky Q' then 'Sky Q'
      when DTV_Product_Holding = 'Sky Q with Cinema' then 'Sky Q with Cinema'
      when DTV_Product_Holding = 'Sky Q with Sports' then 'Sky Q with Sports'
      when DTV_Product_Holding = 'Sky Q with Sports & Cinema' then 'Sky Q with Sports & Cinema'
      when DTV_Product_Holding = 'Sky Q with Sports 1' then 'Sky Q with Sports'
      when DTV_Product_Holding = 'Sky Q with Sports 2' then 'Sky Q with Sports'
      when DTV_Product_Holding = 'Variety' then 'Variety'
      when DTV_Product_Holding = 'Variety with Cinema' then 'Variety with Cinema'
      when DTV_Product_Holding = 'Variety with Cinema 1' then 'Variety with Cinema'
      when DTV_Product_Holding = 'Variety with Cinema 2' then 'Variety with Cinema'
      when DTV_Product_Holding = 'Variety with Sports' then 'Variety with Sports'
      when DTV_Product_Holding = 'Variety with Sports & Cinema' then 'Variety with Sports & Cinema'
      when DTV_Product_Holding = 'Variety with Sports & Cinema 1' then 'Variety with Sports & Cinema'
      when DTV_Product_Holding = 'Variety with Sports & Cinema 2' then 'Variety with Sports & Cinema'
      when DTV_Product_Holding = 'Variety with Sports 1' then 'Variety with Sports'
      when DTV_Product_Holding = 'Variety with Sports 1 & Cinema' then 'Variety with Sports & Cinema'
      when DTV_Product_Holding = 'Variety with Sports 1 & Cinema 1' then 'Variety with Sports & Cinema'
      when DTV_Product_Holding = 'Variety with Sports 1 & Cinema 2' then 'Variety with Sports & Cinema'
      when DTV_Product_Holding = 'Variety with Sports 2' then 'Variety with Sports'
      when DTV_Product_Holding = 'Variety with Sports 2 & Cinema' then 'Variety with Sports & Cinema'
      when DTV_Product_Holding = 'Variety with Sports 2 & Cinema 1' then 'Variety with Sports & Cinema'
      when DTV_Product_Holding = 'Variety with Sports 2 & Cinema 2' then 'Variety with Sports & Cinema'
      when DTV_Product_Holding is null then 'None'
      else DTV_Product_Holding
      end;
    --  2.3 Cleanup
    --      2.3.1 Age
    update Decisioning.Propensity_Model_Mart
      set Age
       = case when Age between 18 and 95 then Age
      when Age between 1916 and 1999 then 2018-Age
      when Age between 1816 and 1899 then 1918-Age
      when Age between 1016 and 1099 then 1118-Age
      when h_age_fine = '18-25' then 22
      when h_age_fine = '26-30' then 28
      when h_age_fine = '31-35' then 33
      when h_age_fine = '36-40' then 37
      when h_age_fine = '41-45' then 43
      when h_age_fine = '46-50' then 48
      when h_age_fine = '51-55' then 53
      when h_age_fine = '56-60' then 58
      when h_age_fine = '61-65' then 63
      when h_age_fine = '66-70' then 68
      when h_age_fine = '71-75' then 73
      when h_age_fine = '76+' then 80
      else null
      end;
    alter table Decisioning.Propensity_Model_Mart add
      Q_PrimaryBox tinyint null default 0;
    drop table if exists #sky_q_elig;
    select stb.account_number,
      min(case when x_description in( 'Sky Q Silver','Sky Q Mini','Sky Q 2TB box','Sky Q','Sky Q 1TB box' ) then 0 --- Known box descriptions
      when UPPER(x_description) like '%SKY Q%' then 0 --- Any other new model
      else 1
      end) as PrimaryBoxType,
      base.base_dt
      into #sky_q_elig
      from cust_set_top_box as stb
        join Decisioning.Propensity_Model_Mart as base
        on stb.account_number = base.account_number
        and stb.created_dt <= base.base_dt
      where base.account_number is not null
      group by stb.account_number,
      base.base_dt;
    commit work;
    create hg index id1 on #sky_q_elig(account_number);
    create date index id2 on #sky_q_elig(base_dt);
    update Decisioning.Propensity_Model_Mart as base
      set Q_PrimaryBox = trgt.PrimaryBoxType from
      #sky_q_elig as trgt
      where trgt.account_number = base.account_number
      and trgt.base_dt = base.base_dt;
    alter table Decisioning.Propensity_Model_Mart add
      UP_SkyQ tinyint null default 0;
    select stb.account_number,
      MAX(case when x_description in( 'Sky Q Silver','Sky Q Mini','Sky Q 2TB box','Sky Q','Sky Q 1TB box' ) then 1 --- Known box descriptions
      when UPPER(x_description) like '%SKY Q%' then 1 --- Any other new model
      else 0
      end) as PrimaryBoxType,base.base_dt
      into #sky_q_up
      from cust_set_top_box as stb
        join Decisioning.Propensity_Model_Mart as base
        on stb.account_number = base.account_number and stb.created_dt between DATEADD(day,1,base_dt) and DATEADD(month,1,base_dt) -- Installations within the next 30 days after the observation date
      where base.account_number is not null
      group by stb.account_number,base.base_dt;
    commit work;
    create hg index id1 on #sky_q_up(account_number);
    create date index id2 on #sky_q_up(base_dt);
    update Decisioning.Propensity_Model_Mart as base
      set UP_SkyQ = b.PrimaryBoxType from
      Decisioning.Propensity_Model_Mart as base
      join #sky_q_up as b
      on b.account_number = base.account_number
      and b.base_dt = base.base_dt;
    alter table Decisioning.Propensity_Model_Mart add
      Mobile_Up_Order bit not null default
      0,add
      Mobile_Active bit not null default 0;
    select c.account_number,
      MAX(a.prod_earliest_mobile_ordered_dt) as dt,
      base_dt
      into #mobile
      from cust_single_mobile_account_view as a
        join cust_single_mobile_view as b
        on a.account_number = b.account_number
        join cust_single_account_view as c
        on a.portfolio_id = c.acct_fo_portfolio_id
        join Decisioning.Propensity_Model_Mart as x
        on x.account_number = c.account_number and a.prod_earliest_mobile_ordered_dt <= base_dt
      group by c.account_number,base_dt;
    commit work;
    create hg index id1 on #mobile(account_number);
    create date index id2 on #mobile(base_dt);
    create dttm index id3 on #mobile(dt);
    update Decisioning.Propensity_Model_Mart as a
      set Mobile_Active = case when cps.account_number is null then 0 else 1 end from
      Decisioning.Propensity_Model_Mart as a
      left outer join #mobile as cps
      on a.account_number = cps.account_number
      and a.base_dt = cps.base_dt;
    select c.account_number,
      MAX(a.prod_earliest_mobile_ordered_dt) as dt,
      base_dt
      into #mobile_up
      from cust_single_mobile_account_view as a
        join cust_single_mobile_view as b
        on a.account_number = b.account_number
        join cust_single_account_view as c
        on a.portfolio_id = c.acct_fo_portfolio_id
        join Decisioning.Propensity_Model_Mart as x
        on x.account_number = c.account_number
        and a.prod_earliest_mobile_ordered_dt between DATEADD(day,1,base_dt) and DATEADD(month,1,base_dt)
      group by c.account_number,base_dt;
    commit work;
    create hg index id1 on #mobile_up(account_number);
    create date index id2 on #mobile_up(base_dt);
    create dttm index id3 on #mobile_up(dt);
    update Decisioning.Propensity_Model_Mart as a
      set Mobile_Up_Order = case when cps.account_number is not null then 1 else 0 end from
      Decisioning.Propensity_Model_Mart as a
      left outer join #mobile_up as cps
      on a.account_number = cps.account_number
      and a.base_dt = cps.base_dt;
    -- Mobile handset eligible
    alter table Decisioning.Propensity_Model_Mart add
      Handset_Active bit not null default 0;
    drop table if exists #mobile_handset_tab;
    select account_number,created_dt
      into #mobile_handset_tab
      from CUST_NON_SUBSCRIPTIONS
      where current_charge_grouping_desc = 'Mobile Handset';
    drop table if exists #mobile_handset_tab2;
    select b.account_number,max(c.created_dt) as dt,d.base_dt
      into #mobile_handset_tab2
      from cust_single_mobile_view as a
        join cust_single_account_view as b
        on a.portfolio_id = b.acct_fo_portfolio_id
        join #mobile_handset_tab as c
        on a.account_number = c.account_number
        join Decisioning.Propensity_Model_Mart as d
        on d.account_number = b.account_number
        and c.created_dt <= d.base_dt
      group by b.account_number,base_dt;
    commit work;
    create hg index idx_1 on #mobile_handset_tab2(account_number);
    create date index idx_2 on #mobile_handset_tab2(base_dt);
    update Decisioning.Propensity_Model_Mart as a
      set Handset_Active = case when cps.account_number is null then 0 else 1 end from
      Decisioning.Propensity_Model_Mart as a
      left outer join #mobile_handset_tab2 as cps
      on a.account_number = cps.account_number
      and a.base_dt = cps.base_dt
  end if;
  /*------------------------------------------------------------------------------------------------------------------------------------*/
  --  3.0 Update field names to make them SAS compatible
  /*------------------------------------------------------------------------------------------------------------------------------------*/
  if Propensity_Table in( 'Training','Scoring' ) then
    alter table decisioning.Propensity_Model_Mart rename DTV_NewCust_Activations_In_Last_1D to DTV_NewCust_Actv_In_Lt_1D;
    alter table decisioning.Propensity_Model_Mart rename DTV_NewCust_Activations_In_Last_30D to DTV_NewCust_Actv_In_Lt_30D;
    alter table decisioning.Propensity_Model_Mart rename DTV_NewCust_Activations_In_Last_90D to DTV_NewCust_Actv_In_Lt_90D;
    alter table decisioning.Propensity_Model_Mart rename DTV_NewCust_Activations_In_Last_180D to DTV_NewCust_Actv_In_Lt_180D;
    alter table decisioning.Propensity_Model_Mart rename DTV_NewCust_Activations_In_Last_1Yr to DTV_NewCust_Actv_In_Lt_1Yr;
    alter table decisioning.Propensity_Model_Mart rename DTV_NewCust_Activations_In_Last_3Yr to DTV_NewCust_Actv_In_Lt_3Yr;
    alter table decisioning.Propensity_Model_Mart rename DTV_NewCust_Activations_In_Last_5Yr to DTV_NewCust_Actv_In_Lt_5Yr;
    alter table decisioning.Propensity_Model_Mart rename DTV_NewCust_Activations_In_Next_7D to DTV_NewCust_Actv_In_Nx_7D;
    alter table decisioning.Propensity_Model_Mart rename DTV_NewCust_Activations_In_Next_30D to DTV_NewCust_Actv_In_Nx_30D;
    alter table decisioning.Propensity_Model_Mart rename BB_Subscriber_Activations_In_Last_1D to BB_Subscriber_Actv_In_Lt_1D;
    alter table decisioning.Propensity_Model_Mart rename BB_Subscriber_Activations_In_Last_30D to BB_Subscriber_Actv_In_Lt_30D;
    alter table decisioning.Propensity_Model_Mart rename BB_Subscriber_Activations_In_Last_90D to BB_Subscriber_Actv_In_Lt_90D;
    alter table decisioning.Propensity_Model_Mart rename BB_Subscriber_Activations_In_Last_180D to BB_Subscriber_Actv_In_Lt_180D;
    alter table decisioning.Propensity_Model_Mart rename BB_Subscriber_Activations_In_Last_1Yr to BB_Subscriber_Actv_In_Lt_1Yr;
    alter table decisioning.Propensity_Model_Mart rename BB_Subscriber_Activations_In_Last_3Yr to BB_Subscriber_Actv_In_Lt_3Yr;
    alter table decisioning.Propensity_Model_Mart rename BB_Subscriber_Activations_In_Last_5Yr to BB_Subscriber_Actv_In_Lt_5Yr;
    alter table decisioning.Propensity_Model_Mart rename BB_Subscriber_Activations_In_Next_7D to BB_Subscriber_Actv_In_Nx_7D;
    alter table decisioning.Propensity_Model_Mart rename BB_Subscriber_Activations_In_Next_30D to BB_Subscriber_Actv_In_Nx_30D;
    alter table decisioning.Propensity_Model_Mart rename BB_Subscription_Activations_In_Last_1D to BB_Subscription_Actv_In_Lt_1D;
    alter table decisioning.Propensity_Model_Mart rename BB_Subscription_Activations_In_Last_30D to BB_Subscription_Actv_In_Lt_30D;
    alter table decisioning.Propensity_Model_Mart rename BB_Subscription_Activations_In_Last_90D to BB_Subscription_Actv_In_Lt_90D;
    alter table decisioning.Propensity_Model_Mart rename BB_Subscription_Activations_In_Last_180D to BB_Subscription_Actv_In_Lt_180D;
    alter table decisioning.Propensity_Model_Mart rename BB_Subscription_Activations_In_Last_1Yr to BB_Subscription_Actv_In_Lt_1Yr;
    alter table decisioning.Propensity_Model_Mart rename BB_Subscription_Activations_In_Last_3Yr to BB_Subscription_Actv_In_Lt_3Yr;
    alter table decisioning.Propensity_Model_Mart rename BB_Subscription_Activations_In_Last_5Yr to BB_Subscription_Actv_In_Lt_5Yr;
    alter table decisioning.Propensity_Model_Mart rename BB_Subscription_Activations_In_Next_7D to BB_Subscription_Actv_In_Nx_7D;
    alter table decisioning.Propensity_Model_Mart rename BB_Subscription_Activations_In_Next_30D to BB_Subscription_Actv_In_Nx_30D;
    alter table decisioning.Propensity_Model_Mart rename DTV_PO_Cancellations_In_Last_180D to DTV_PO_Cancellations_In_Lt_180D;
    alter table decisioning.Propensity_Model_Mart rename DTV_Last_PC_Future_Sub_Effective_Dt to DTV_Lt_PC_Future_Sub_Eff_Dt;
    alter table decisioning.Propensity_Model_Mart rename DTV_Next_PC_Future_Sub_Effective_Dt to DTV_Nx_PC_Future_Sub_Eff_Dt;
    alter table decisioning.Propensity_Model_Mart rename DTV_Last_AB_Future_Sub_Effective_Dt to DTV_Lt_AB_Future_Sub_Eff_Dt;
    alter table decisioning.Propensity_Model_Mart rename DTV_Next_AB_Future_Sub_Effective_Dt to DTV_Nx_AB_Future_Sub_Eff_Dt;
    alter table decisioning.Propensity_Model_Mart rename DTV_PC_Reactivations_In_Last_180D to DTV_PC_Reactivations_In_Lt_180D;
    alter table decisioning.Propensity_Model_Mart rename DTV_AB_Reactivations_In_Last_180D to DTV_AB_Reactivations_In_Lt_180D;
    alter table decisioning.Propensity_Model_Mart rename h_number_of_children_in_household to h_number_of_children_in_hh;
    alter table decisioning.Propensity_Model_Mart rename h_presence_of_young_person_at_address to h_prsnc_of_yng_person_at_address;
    alter table decisioning.Propensity_Model_Mart rename DTV_Curr_Contract_Intended_End_Dt to DTV_Curr_Contract_Intnd_End_Dt;
    alter table decisioning.Propensity_Model_Mart rename DTV_Prev_Contract_Intended_End_Dt to DTV_Prev_Contract_Intnd_End_Dt;
    --  2.3.2 Turn dates into days
    alter table Decisioning.Propensity_Model_Mart add
      DTV_Last_cuscan_churn integer null,add
      DTV_Last_Activation integer null,add
      DTV_Curr_Contract_Intended_End integer null,add
      DTV_Curr_Contract_Start integer null,add
      DTV_Last_SysCan_Churn integer null,add
      Curr_Offer_Start_DTV integer null,add
      Curr_Offer_Actual_End_DTV integer null,add
      DTV_1st_Activation integer null,add
      BB_Curr_Contract_Intended_End integer null,add
      BB_Curr_Contract_Start integer null,add
      DTV_Last_Active_Block integer null,add
      DTV_Last_Pending_Cancel integer null,add
      BB_Last_Activation integer null,add
      _1st_TA integer null,add
      last_TA integer null,add
      _1st_TA_save integer null,add
      last_TA_save integer null,add
      _1st_TA_nonsave integer null,add
      last_TA_nonsave integer null;
    update Decisioning.Propensity_Model_Mart
      set DTV_Last_cuscan_churn = DATEDIFF(day,DTV_Last_CusCan_Churn_Dt,base_dt),
      DTV_Last_Activation = DATEDIFF(day,DTV_Last_Activation_Dt,base_dt),
      DTV_Curr_Contract_Intended_End = DATEDIFF(day,DTV_Curr_Contract_Intnd_End_Dt,base_dt),
      DTV_Curr_Contract_Start = DATEDIFF(day,DTV_Curr_Contract_Start_Dt,base_dt),
      DTV_Last_SysCan_Churn = DATEDIFF(day,DTV_Last_SysCan_Churn_Dt,base_dt),
      Curr_Offer_Start_DTV = DATEDIFF(day,Curr_Offer_Start_Dt_DTV,base_dt),
      Curr_Offer_Actual_End_DTV = DATEDIFF(day,Curr_Offer_Actual_End_Dt_DTV,base_dt),
      DTV_1st_Activation = DATEDIFF(day,DTV_1st_Activation_Dt,base_dt),
      BB_Curr_Contract_Intended_End = DATEDIFF(day,BB_Curr_Contract_Intended_End_Dt,base_dt),
      BB_Curr_Contract_Start = DATEDIFF(day,BB_Curr_Contract_Start_Dt,base_dt),
      DTV_Last_Active_Block = DATEDIFF(day,DTV_Last_Active_Block_Dt,base_dt),
      DTV_Last_Pending_Cancel = DATEDIFF(day,DTV_Last_Pending_Cancel_Dt,base_dt),
      BB_Last_Activation = DATEDIFF(day,BB_Last_Activation_Dt,base_dt),
      _1st_TA = DATEDIFF(day,_1st_TA_dt,base_dt),
      last_TA = DATEDIFF(day,last_TA_dt,base_dt),
      _1st_TA_save = DATEDIFF(day,_1st_TA_save_dt,base_dt),
      last_TA_save = DATEDIFF(day,last_TA_save_dt,base_dt),
      _1st_TA_nonsave = DATEDIFF(day,_1st_TA_nonsave_dt,base_dt),
      last_TA_nonsave = DATEDIFF(day,last_TA_nonsave_dt,base_dt)
  end if;
  /*------------------------------------------------------------------------------------------------------------------------------------*/
  --  4.0 Delete old records from Decisioning propensity tables and insert new records from temp table
  /*------------------------------------------------------------------------------------------------------------------------------------*/
  if Propensity_Table = 'Scoring' then
    delete from Decisioning.Propensity_Model_Mart_Scoring
  --         Delete from Decisioning.Propensity_Model_Mart_Evaluation where Base_Dt in (Select distinct Base_Dt from Decisioning.Propensity_Model_Mart);
  elseif Propensity_Table = 'Training' then
    select distinct Base_Dt into #Base_Dts from Decisioning.Propensity_Model_Mart_Training union
    select distinct Base_Dt from Decisioning.Propensity_Model_Mart;
    select *,row_number() over(order by Base_Dt desc) as Dt_Rnk into #Rnk_Base_Dts from #Base_Dts;
    delete from Decisioning.Propensity_Model_Mart_Training as prop
      where Base_Dt = any(select Base_Dt from #Rnk_Base_Dts as dts where Dt_Rnk > 18);
    delete from Decisioning.Propensity_Model_Mart_Training as prop
      where Base_Dt = any(select distinct Base_Dt from Decisioning.Propensity_Model_Mart)
  end if;
  -- Select len(column_name),* from sp_columns('Propensity_Model_Mart_Scoring') where table_owner = 'Decisioning';
  -- Alter table Decisioning.Propensity_Model_Mart_Scoring drop DTV_Prev_Contract_Intended_End_Dt
  if Propensity_Table in( 'Scoring','Training' ) then
    drop table if exists #Propensity_Mart_Fields;
    execute immediate ''
       || 'Select *,Row_Number() over(order by column_name) as Row_ID '
       || 'into #Propensity_Mart_Fields '
       || 'from sp_columns(''Propensity_Model_Mart_' || Propensity_Table || ''') '
       || 'where table_owner = ''Decisioning'' ';
    -- Select * from #Propensity_Mart_Fields
    set Dynamic_SQL = '';
    set Loop_Num = 1;
    while Loop_Num <= (select count() from #Propensity_Mart_Fields) loop
      set Dynamic_SQL = Dynamic_SQL || (select max(column_name) from #Propensity_Mart_Fields where Row_ID = Loop_Num) || ',';
      set Loop_Num = Loop_Num+1
    end loop;
    set Dynamic_SQL = Left(Dynamic_SQL,len(Dynamic_SQL)-1);
    execute immediate 'Insert into Decisioning.Propensity_Model_Mart_' || Propensity_Table || '('
       || Dynamic_SQL || ') '
       || 'Select '
       || Dynamic_SQL
       || ' from Decisioning.Propensity_Model_Mart ';
    if Propensity_Table = 'Scoring' then
      --         BEGIN
      --
      --                 Execute( 'Insert into Decisioning.Propensity_Model_Mart_Evaluation('
      --                 ||       Dynamic_SQL || ') '
      --                 ||       'Select '
      --                 ||       Dynamic_SQL
      --                 ||       ' from Decisioning.Propensity_Model_Mart '
      --                 );
      --
      -- -- Do weekly Update of target variable in Evaluation table
      --
      --         END;
    end if
  elseif Propensity_Table = 'Evaluation' then
    drop table if exists #Model_Scores;
    create table #Model_Scores(
      Model_Name varchar(100) null,
      Obs_Dt_Field varchar(100) null,
      Score_Field varchar(100) null,
      Decile_Field varchar(100) null,
      );
    insert into #Model_Scores values
      ( 'SAS_MM.mobile_handset_upsell_scored','Base_Dt','EM_EventProbability','Decile' ) ,
      ( 'SAS_MM.mobile_subs_upsell_scored','Base_Dt','EM_EventProbability','Decile' ) ,
      ( 'SAS_MM.sky_q_upsell_scored','Base_Dt','EM_EventProbability','Decile' ) ,
      ( 'SAS_MM.movie_upsell_scored','Base_Dt','EM_EventProbability','Decile' ) ,
      ( 'SAS_MM.sports_upsell_scored','Base_Dt','EM_EventProbability','Decile' ) ,
      ( 'SAS_MM.rental_lps_upsell_scored','Base_Dt','EM_EventProbability','Decile' ) ,
      ( 'SAS_MM.rental_nu_upsell_scored','Base_Dt','EM_EventProbability','Decile' ) ,
      ( 'SAS_MM.bnk_lps_upsell_scored','Base_Dt','EM_EventProbability','Decile' ) ,
      ( 'SAS_MM.bnk_nu_upsell_scored','Base_Dt','EM_EventProbability','Decile' ) ,
      ( 'SAS_MM.bb_upsell_scored','Base_Dt','EM_EventProbability','Decile' ) ,
      ( 'SAS_MM.boxset_upsell_scored','Base_Dt','EM_EventProbability','Decile' ) ,
      ( 'SAS_MM.fibre_upsell_scored','Base_Dt','EM_EventProbability','Decile' ) ,
      ( 'SAS_MM.fibre_reg_dtv1_upsell_scored','Base_Dt','EM_EventProbability','Decile' ) ,
      ( 'SAS_MM.fibre_reg_dtv0_upsell_scored','Base_Dt','EM_EventProbability','Decile' ) ;
    --        Select * from sp_columns('Propensity_Model_Mart_Evaluation') where table_owner = 'Decisioning';
    -- Add new fields for new model scores and deciles as required
    set Loop_Num = 1;
    while Loop_Num <= (select count() from #Model_Scores) loop
      set Eval_Column_Name
         = (select substr(Model_Name,charindex('.',Model_Name)+1,len(Model_Name)-charindex('.',Model_Name)) as Model
          from #Model_Scores as trgt where rowid(trgt) = Loop_Num);
      commit work;
      -- Check if Model Score field exists in Eval table and add it if not present
      drop table if exists #Field_Exists;
      select column_name into #Field_Exists from sp_columns('Propensity_Model_Mart_Evaluation')
        where table_owner = 'Decisioning' and lower(column_name) = lower(Eval_Column_Name || '_Score');
      commit work;
      if(select count() from #Field_Exists) = 0 then
        execute immediate 'Alter table Decisioning.Propensity_Model_Mart_Evaluation'
           || ' Add(' || Eval_Column_Name || '_Score numeric(12,10) default null)'
      end if;
      -- Check if Decile Score field exists in Eval table and add it if not present
      drop table if exists #Field_Exists;
      select column_name into #Field_Exists from sp_columns('Propensity_Model_Mart_Evaluation')
        where table_owner = 'Decisioning' and lower(column_name) = lower(Eval_Column_Name || '_Decile');
      commit work;
      if(select count() from #Field_Exists) = 0 then
        execute immediate 'Alter table Decisioning.Propensity_Model_Mart_Evaluation'
           || ' Add(' || Eval_Column_Name || '_Decile integer default null)'
      end if;
      set Loop_Num = Loop_Num+1
    end loop;
    -- Get list of fields to be updated
    drop table if exists #Eval_Update_Column_Names;
    select Column_Name
      into #Eval_Update_Column_Names
      from sp_columns('Propensity_Model_Mart')
      where table_owner = 'Decisioning'
      and(lower(Column_Name) like '%nx_%'
      or lower(Column_Name) like '%next_%')
      and Column_Name = any(select column_name from sp_columns('Propensity_Model_Mart_Evaluation') where table_owner = 'Decisioning');
    -- Select * from #Eval_Update_Column_Names
    -- Update Evaluation table figures
    set Dynamic_SQL = 'Update Decisioning.Propensity_Model_Mart_Evaluation pmme Set ';
    set Loop_Num = 1;
    while Loop_Num <= (select count() from #Eval_Update_Column_Names) loop
      set Eval_Column_Name = (select max(column_name) from #Eval_Update_Column_Names as trgt where rowid(trgt) = Loop_Num);
      --         Select Eval_Column_Name
      commit work;
      set Dynamic_SQL = Dynamic_SQL || ' ' || Eval_Column_Name || ' = pmm.' || Eval_Column_Name || ',';
      set Loop_Num = Loop_Num+1
    end loop;
    execute immediate Substr(Dynamic_SQL,1,len(Dynamic_SQL)-1)
       || ' from Decisioning.Propensity_Model_Mart pmm '
       || ' where pmm.account_number = pmme.account_number '
       || '       and pmm.base_dt = pmme.base_dt ';
    -- Get latest latest score/decile info from SAS_MM scored tables
    set Loop_Num = 1;
    while Loop_Num <= (select count() from #Model_Scores) loop
      set Model_Name = (select Model_Name from #Model_Scores as trgt where rowid(trgt) = Loop_Num);
      set Obs_Dt_Field = (select Obs_Dt_Field from #Model_Scores as trgt where rowid(trgt) = Loop_Num);
      set Score_Field = (select Score_Field from #Model_Scores as trgt where rowid(trgt) = Loop_Num);
      set Decile_Field = (select Decile_Field from #Model_Scores as trgt where rowid(trgt) = Loop_Num);
      --         Select Model_Name,Obs_Dt_Field,Score_Field,Decile_Field
      set Eval_Column_Name
         = substr(Model_Name,charindex('.',Model_Name)+1,len(Model_Name)-charindex('.',Model_Name));
      --         Select Eval_Column_Name;
      execute immediate ' Update Decisioning.Propensity_Model_Mart_Evaluation pmme'
         || ' Set ' || Eval_Column_Name || '_Score = trgt.' || Score_Field || ','
         || Eval_Column_Name || '_Decile = trgt.' || Decile_Field
         || ' from ' || Model_Name || ' as trgt '
         || ' where trgt.account_number = pmme.account_number '
         || '       and trgt.base_dt = pmme.base_dt ';
      set Loop_Num = Loop_Num+1
    end loop
  /*Call dba.sp_drop_table('Decisioning','Propensity_Model_Mart'); */
  end if
end