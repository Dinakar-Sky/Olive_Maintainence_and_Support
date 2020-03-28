/*

dba.sp_drop_table 'Decisioning','Propensity_Mobile_Mart_Scoring'
dba.sp_create_table 'Decisioning','Propensity_Mobile_Mart_Scoring', 
  'base_dt date default	null,'
||'mobile_account_number varchar (20) default	null,'
||'portfolio_id varchar (50) default	null,'
||'owning_cust_account_id varchar (50) default	null,'
||'dtv_account_number varchar (20) default	null,'
||'country char (3) default	null,'
||'sim_active tinyint default	0,'
||'sum_tariff_plans_GB decimal (2) default	null,'
||'cnt_plans int default	null,'
||'cnt_service_id int default	null,'
||'cnt_active_status_cd int default	null,'
||'sum_active_tariff_plans_GB decimal (2) default	null,'
||'cnt_active_plans int default	null,'
||'piggybank_1_gb tinyint default	0,'
||'add_on_1_gb tinyint default	0,'
||'international_add_on tinyint default	0,'
||'talk_text_add_on tinyint default	0,'
||'handset_active tinyint default	0,'
||'handset_description varchar (100) default	null,'
||'tablet_active tinyint default	0,'
||'tablet_description varchar (100) default	null,'
||'sim_only_customer tinyint default	0,'
||'mobile_offer_end_status_level_1 varchar (50) default	null,'
||'mobile_offer_end_status_level_2 varchar (50) default	null,'
||'payment_plan_name varchar (255) default	null,'
||'agreement_status varchar (15) default	null,'
||'cash_price bigint default	null,'
||'activation_date date default	null,'
||'activation_offset_days decimal (5) default	null,'
--||'actual_trade_in_dt date default	null,'
--||'actual_trade_in_value decimal (18) default	null,'
||'affordability_value bigint default	null,'
||'contract_signed_date date default	null,'
||'cool_off_end_dt date default	null,'
||'cool_off_start_dt date default	null,'
||'delivery_dt date default	null,'
||'discount_value bigint default	null,'
||'final_repay_date date default	null,'
||'payment_plan_id varchar (47) default	null,'
||'payment_plan_prop_id varchar (47) default	null,'
||'prepaid_value bigint default	null,'
||'repayment_amount decimal (18) default	null,'
--||'retained_value varchar (47) default	null,'
||'swap_end_dt date default	null,'
||'swap_start_dt date default	null,'
||'total_value bigint default	null,'
||'unallocated_repayments decimal (3) default	null,'
||'unallocated_value bigint default	null,'
||'unbilled_repayments decimal (3) default	null,'
||'unbilled_value bigint default	null,'
||'email_allowed varchar(5) default	 null,'
||'postal_mail_allowed varchar(5) default	 null,'
||'promo_email_allowed varchar(5) default	null,'
||'promo_mail_allowed varchar(5) default	null,'
||'promo_phone_allowed varchar(5) default	null,'
||'sms_allowed varchar(5) default	null,'
||'telephone_contact_allowed varchar(5) default	null,'
||'viewing_data_capture_allowed varchar(5) default	null,'
||'viewing_data_marketing_allowed varchar(5) default	null,'
||'count_data_plan_size_mob1gb int default	null,'
||'count_data_plan_size_mob3gb int default	null,'
||'count_data_plan_size_mob5gb int default	null,'
||'count_mobile_int_addon_product int default	null,'
||'count_mobile_tt_addon_product int default	null,'
||'count_of_msisdn_active int default	null,'
--||'sim_prev_msisdn_1 int default	null,'
||'piggybank_score decimal (18) default	null,'
||'retention_score decimal (18) default	null,'
||'person_type varchar (10) default	null,'
||'igor_new_balance_mb decimal (18) default	null,'
||'igor_previous_balance_mb decimal (18) default	null,'
||'igor_redeemed_value_mb decimal (18) default	null,'
||'igor_unallocated_value_mb decimal (18) default	null,'
||'igor_redemption_flag tinyint default	null,'
||'igor_redemption_count tinyint default	null,'
||'igor_redemption_cum_sum decimal (3) default	null,'
||'prod_earliest_mobile_activation_dt date default	null,'
||'prod_latest_mobile_activation_dt date default	null,'
||'corporate_voice_vol decimal (18) default	null,'
||'daytime_mms_vol decimal (18) default	null,'
||'daytime_sms_vol decimal (18) default	null,'
||'daytime_voice_vol decimal (18) default	null,'
||'evening_mms_vol decimal (18) default	null,'
||'evening_sms_vol decimal (18) default	null,'
||'evening_voice_vol decimal (18) default	null,'
||'freephone_voice_vol decimal (18) default	null,'
||'home_data_kb decimal (18) default	null,'
||'home_mms_vol decimal (18) default	null,'
||'home_sms_vol decimal (18) default	null,'
||'sky_mms_vol decimal (18) default	null,'
||'sky_sms_vol decimal (18) default	null,'
||'sky_voice_vol decimal (18) default	null,'
||'roaming_mms_vol decimal (18) default	null,'
||'roaming_sms_vol decimal (18) default	null,'
||'wknd_sms_vol decimal (18) default	null,'
||'wknd_voice_vol decimal (18) default	null,'
||'total_data_kb decimal (18) default	null,'
||'total_home_voice_secs decimal (18) default	null,'
||'total_incoming_secs decimal (18) default	null,'
||'total_outgoing_secs decimal (18) default	null,'
||'total_roaming_secs decimal (18) default	null,'
||'active_hs_count tinyint default	0,'
||'active_apple_hs_count tinyint default	0'


		
drop table if exists 	Propensity_Mobile_Mart_Scoring;	
create table Propensity_Mobile_Mart_Scoring		
	(	
 	base_dt date  default	null,
 	mobile_account_number varchar(20) default null,	
 	portfolio_id varchar(50) default null,
 	owning_cust_account_id varchar(50) default null,
 	dtv_account_number varchar(20) default null,	
	country char (3) default	null,
	sim_active tinyint  default	null,
	sum_tariff_plans_GB decimal(2) default null,
	cnt_plans int default null,
	cnt_service_id int default null,
	cnt_active_status_cd int default null,
	sum_active_tariff_plans_GB decimal(2) default null,
	cnt_active_plans int default null,	
	piggybank_1_gb tinyint  default	0,
	add_on_1_gb tinyint  default	0,
	international_add_on tinyint  default	0,
	talk_text_add_on tinyint  default	0,
	handset_active tinyint  default	0,
	handset_description varchar (100) default	null,
	tablet_active tinyint  default	0,
	tablet_description varchar (100) default	null,
	sim_only_customer tinyint  default	null,
	mobile_offer_end_status_level_1 varchar (50) default	0,
	mobile_offer_end_status_level_2 varchar (50) default	0,
	payment_plan_name varchar (255) default	null,
	agreement_status varchar (15) default	null,
	cash_price bigint  default	0,
	activation_date date  default	null,
	activation_offset_days decimal (5) default	null,
	--actual_trade_in_dt date  default	null,
	--actual_trade_in_value decimal (18) default	null,
	affordability_value bigint  default	null,
	contract_signed_date date  default	null,
	cool_off_end_dt date  default	null,
	cool_off_start_dt date  default	null,
	delivery_dt date  default	null,
	discount_value bigint  default	null,
	final_repay_date date  default	null,
	payment_plan_id varchar (47) default	null,
	payment_plan_prop_id varchar (47) default	null,
	prepaid_value bigint  default	null,
	repayment_amount decimal (18) default	null,
	--retained_value varchar (47) default	null,
	swap_end_dt date  default	null,
	swap_start_dt date  default	null,
	total_value bigint  default	null,
	unallocated_repayments decimal (3) default	null,
	unallocated_value bigint  default	null,
	unbilled_repayments decimal (3) default	null,
	unbilled_value bigint  default	null,
	email_allowed varchar(5) default null,	
	postal_mail_allowed varchar(5) default null,	
	promo_email_allowed varchar(5) default null,	
	promo_mail_allowed varchar(5) default null,	
	promo_phone_allowed varchar(5) default null,	
	sms_allowed varchar(5) default null,	
	telephone_contact_allowed varchar(5) default null,	
	viewing_data_capture_allowed varchar(5) default null,	
	viewing_data_marketing_allowed varchar(5) default null,	
	count_data_plan_size_mob1gb int default null,	
	count_data_plan_size_mob3gb int default null,	
	count_data_plan_size_mob5gb int default null,	
	count_mobile_int_addon_product int default null,	
	count_mobile_tt_addon_product int default null,	
	count_of_msisdn_active int default null,	
	sim_prev_msisdn_1 int default null,	
	piggybank_score decimal (18) default null,	
	retention_score decimal (18) default null,	
	person_type varchar (10) default null,	
	igor_new_balance_mb decimal (18) default null,	
	igor_previous_balance_mb decimal (18) default null,	
	igor_redeemed_value_mb decimal (18) default null,	
	igor_unallocated_value_mb decimal (18) default null,
	igor_redemption_flag tinyint default null,
	igor_redemption_count tinyint default null,
	igor_redemption_cum_sum decimal(3) default null,
	prod_earliest_mobile_activation_dt date default null,
	prod_latest_mobile_activation_dt date default null,
	corporate_voice_vol decimal (18) default null,
	 daytime_mms_vol decimal (18) default null,
	 daytime_sms_vol decimal (18) default null,
	 daytime_voice_vol decimal (18) default null,
	 evening_mms_vol decimal (18) default null,
	 evening_sms_vol decimal (18) default null,
	 evening_voice_vol decimal (18) default null,
	 freephone_voice_vol decimal (18) default null,
	 home_data_kb decimal (18) default null,
	 home_mms_vol decimal (18) default null,
	 home_sms_vol decimal (18) default null,
	 sky_mms_vol decimal (18) default null,
	 sky_sms_vol decimal (18) default null,
	 sky_voice_vol decimal (18) default null,
	 roaming_mms_vol decimal (18) default null,
	 roaming_sms_vol decimal (18) default null,
	 wknd_sms_vol decimal (18) default null,
	 wknd_voice_vol decimal (18) default null,
	 total_data_kb decimal (18) default null,
	 total_home_voice_secs decimal (18) default null,
	 total_incoming_secs decimal (18) default null,
	 total_outgoing_secs decimal (18) default null,
	 total_roaming_secs	decimal (18) default null,
	 active_hs_count tinyint default null,
	 active_apple_hs_count tinyint default null
	);	


*/

setuser Decisioning_procs;
GO
DROP PROCEDURE if exists Decisioning_procs.Update_Decisioning_Propensity_Mobile_Mart_Scoring
GO

create procedure Decisioning_procs.Update_Decisioning_Propensity_Mobile_Mart_Scoring() 
sql security invoker
begin 

set options query_temp_space_limit = 0; 


drop table if exists #weeks_uk;

select  cast(today()-day(today())+1 as date) as  start_dt, today() as base_Dt,
	      'GBP' as currency_code 
into #weeks_uk
;

drop table if exists #weeks_roi;

select cast(today()-day(today())+1 as date) as  start_dt, today() as base_Dt,
	      'EUR' as currency_code 
into #weeks_roi;

drop table if exists #weeks;
select * 
into #weeks
from (select * from #weeks_uk union select * from #weeks_roi) aa;


-- mobile customers 
drop table if exists #mobile_account_numbers_temp;
select account_number,account_currency_code,portfolio_id,owning_cust_account_id
,row_number() over(partition by account_number order by cast(order_created_dt as date) desc ) as rank_num
into #mobile_account_numbers_temp
from cust_Sales_order_fact
where 
 (
	type_61_adds>0 or type_75_adds>0 or type_64_adds>0 or type_62_adds>0 
	or type_60_adds>0    or type_63_adds>0 or type_79_adds>0 or type_58_adds>0 or type_59_adds>0 or type_61_removes>0
	or type_75_REMOVES>0 or type_64_REMOVES>0 or type_62_removes>0 or type_60_REMOVES>0 or type_63_REMOVES> 0
	or type_79_REMOVES>0 or type_58_REMOVES>0 or type_59_REMOVES>0
	);
--group by account_number ,account_currency_code,portfolio_id,owning_cust_account_id;


drop table if exists #mobile_account_numbers;
select a.* 
into #mobile_account_numbers
from #mobile_account_numbers_temp a
where rank_num = 1;


-- Mobile customers with week 

drop table if exists #mobile_base_with_week;

select base_dt,account_number,currency_code,portfolio_id,owning_cust_account_id
into #mobile_base_with_week  
from #weeks aa
inner join
#mobile_account_numbers bb
on aa.currency_code = bb.account_currency_code;

drop table if exists #mobile_base;
select 


base_dt
,currency_code
,case when currency_code = 'EUR' then 'ROI' when currency_code = 'GBP' then 'UK' end as country
,portfolio_id
,owning_cust_account_id
,account_number as mobile_account_number
,cast(null as varchar(100)) as dtv_account_number
,cast(0 as tinyint) as sim_active
,cast(null as decimal(2)) as sum_tariff_plans_GB
,cast(null as int) as cnt_plans
,cast(null as int) as cnt_service_id
,cast(null as int) as cnt_active_status_cd
,cast(null as decimal(2)) as sum_active_tariff_plans_GB
,cast(null as int) as cnt_active_plans
,cast(0 as tinyint) as piggybank_1_gb
,cast(0 as tinyint) as add_on_1_gb
,cast(0 as tinyint) as international_add_on
,cast(0 as tinyint) as talk_text_add_on
,cast(0 as tinyint) as handset_active 
,cast(null as varchar(100)) as handset_description
,cast(0 as tinyint) as tablet_active 
,cast(null as varchar(100)) as tablet_description
,cast(0 as tinyint) as sim_only_customer
,cast(null as varchar(50)) as mobile_offer_end_status_level_1
,cast(null as varchar(50)) as mobile_offer_end_status_level_2

,cast(null as varchar(255)) as payment_plan_name
,cast(null as varchar(15)) as agreement_status
,cast(0 as bigint) as cash_price
,cast(null as date) as  activation_date
,cast(null as decimal(5)) as activation_offset_days
--,cast(null as date) as actual_trade_in_dt
--,cast(null as decimal(18)) as  actual_trade_in_value
,cast(0 as bigint) as  affordability_value
,cast(null as date) as  contract_signed_date
,cast(null as date) as  cool_off_end_dt
,cast(null as date) as  cool_off_start_dt
,cast(null as date) as  delivery_dt
,cast(0 as bigint) as  discount_value
,cast(null as date) as  final_repay_date
,cast(null as varchar(47)) as payment_plan_id
,cast(null as varchar(47)) as payment_plan_prop_id
,cast(0 as bigint) as  prepaid_value
,cast(null as decimal(18)) as repayment_amount
--,cast(null as varchar(47)) retained_value
,cast(null as date) as swap_end_dt
,cast(null as date) as swap_start_dt
,cast(0 as bigint) as total_value
,cast(null as decimal(3)) as unallocated_repayments
,cast(0 as bigint) as unallocated_value
,cast(null as decimal(3)) as unbilled_repayments
,cast(0 as bigint) as unbilled_value
,cast(null as varchar(5)) as  email_allowed
,cast(null as varchar(5)) as  postal_mail_allowed
,cast(null as varchar(5)) as  promo_phone_allowed
,cast(null as varchar(5)) as  promo_email_allowed
,cast(null as varchar(5)) as  promo_mail_allowed
,cast(null as varchar(5)) as  sms_allowed
,cast(null as varchar(5)) as  telephone_contact_allowed
,cast(null as varchar(5)) as  viewing_data_capture_allowed
,cast(null as varchar(5)) as  viewing_data_marketing_allowed
,cast(0 as int) as  count_data_plan_size_mob1gb
,cast(0 as int) as  count_data_plan_size_mob3gb
,cast(0 as int) as  count_data_plan_size_mob5gb
,cast(0 as int) as  count_mobile_int_addon_product
,cast(0 as int) as  count_mobile_tt_addon_product
,cast(0 as int) as   count_of_msisdn_active
--,cast(null as int) as   sim_prev_msisdn_1
,cast(0 as decimal(18)) as   piggybank_score
,cast(0 as decimal(18)) retention_score
,cast(null as varchar(10)) person_type

-- Changes for igor update

,cast(null as decimal(18)) igor_new_balance_mb
,cast(null as decimal(18)) igor_previous_balance_mb
,cast(null as decimal(18)) igor_redeemed_value_mb
,cast(null as decimal(18)) igor_unallocated_value_mb
,cast(null as tinyint) igor_redemption_flag
,cast(null as tinyint) igor_redemption_count
,cast(null as decimal(3)) igor_redemption_cum_sum

------------------------------------
,cast(null as date) prod_earliest_mobile_activation_dt
,cast(null as date) prod_latest_mobile_activation_dt
, cast(0 as decimal(18)) corporate_voice_vol
, cast(0 as decimal(18)) daytime_mms_vol
, cast(0 as decimal(18)) daytime_sms_vol
, cast(0 as decimal(18)) daytime_voice_vol
, cast(0 as decimal(18)) evening_mms_vol
, cast(0 as decimal(18)) evening_sms_vol
, cast(0 as decimal(18)) evening_voice_vol
, cast(0 as decimal(18)) freephone_voice_vol
, cast(0 as decimal(18)) home_data_kb
, cast(0 as decimal(18)) home_mms_vol
, cast(0 as decimal(18)) home_sms_vol
, cast(0 as decimal(18)) sky_mms_vol
, cast(0 as decimal(18)) sky_sms_vol
, cast(0 as decimal(18)) sky_voice_vol
, cast(0 as decimal(18)) roaming_mms_vol
, cast(0 as decimal(18)) roaming_sms_vol
, cast(0 as decimal(18)) wknd_sms_vol
, cast(0 as decimal(18)) wknd_voice_vol
, cast(0 as decimal(18)) total_data_kb
, cast(0 as decimal(18)) total_home_voice_secs
, cast(0 as decimal(18)) total_incoming_secs
, cast(0 as decimal(18)) total_outgoing_secs
, cast(0 as decimal(18)) total_roaming_secs
, cast(null as tinyint) active_hs_count
, cast(null as tinyint) active_apple_hs_count

into #mobile_base
from #mobile_base_with_week;


-- update dtv account number 

update #mobile_base base
set base.dtv_account_number = bb.account_number
from #mobile_base base
left join CITeam.customer_dim bb
on base.portfolio_id = bb.portfolio_id 
where base.mobile_account_number <> bb.account_number;

-- Mobile tariff 
/*
cancel  -> CN 
Pre-active -> OIP
Active  -> AC,R,CRQ,BCRQ

*/

drop table if exists #mobile_tariff;
select 
account_number
,currency_code
,cast(prod_latest_mobile_status_start_dt as date) as refrence_dt
,current_tariff_description
,prod_latest_mobile_status_code as status_code 
into #mobile_tariff
from 
CUST_SINGLE_MOBILE_VIEW
group by 
account_number
,currency_code
,refrence_dt
,current_tariff_description
,status_code;

delete from #mobile_tariff where (account_number is null or refrence_dt is null or status_code is null);

drop table if exists #mobile_tariff_with_rank;
select 
account_number,currency_code,refrence_dt,status_code,current_tariff_description,dense_rank() over (partition by account_number,currency_code order by refrence_dt asc) as rank
into #mobile_tariff_with_rank
from #mobile_tariff;

drop table if exists #mobile_tariff_base;
select aa.account_number,aa.currency_code,aa.refrence_dt as effective_from_dt,bb.refrence_dt as effective_to_dt,aa.status_code,aa.current_tariff_description
into #mobile_tariff_base
from #mobile_tariff_with_rank aa
left join (select account_number,currency_code,refrence_dt,rank from #mobile_tariff_with_rank group by account_number,currency_code,refrence_dt,rank) bb 
on aa.account_number = bb.account_number
and aa.currency_code=bb.currency_code
and aa.rank+1 = bb.rank;

update #mobile_tariff_base
set effective_to_dt = '9999-09-09'
where effective_to_dt is null;

update #mobile_base base
set sim_active = 1 	
from #mobile_base  base 
inner join #mobile_tariff_base tariff 
on base.mobile_account_number = tariff.account_number 
and  base.base_dt between tariff.effective_from_dt and tariff.effective_to_dt -1 
and tariff.status_code in('AC','R','CRQ','BCRQ');


drop table if exists #mobile_tariff;
select 
account_number
,currency_code
,service_instance_id
,cb_data_date
,current_tariff_description
,prod_latest_mobile_status_code as status_code
,dense_rank() over(partition by account_number, month(cb_data_date), year(cb_data_date) order by cb_data_date desc) as rank_num
into #mobile_tariff
from 
CUST_SINGLE_MOBILE_VIEW;

delete from #mobile_tariff where (account_number is null or status_code is null);

drop table if exists #mobile_tariff_latest;
select 
account_number
,currency_code
,service_instance_id
,cb_data_date
,current_tariff_description
,status_code
into #mobile_tariff_latest
from #mobile_tariff
where rank_num = 1;

--drop table #mobile_tariff;

drop table if exists #mobile_tariff_total;
select account_number 
,currency_code
,cb_data_date
,sum(case 	when current_tariff_description like '%MB%' 
				then CAST(REPLACE(current_tariff_description, 'MB' , '') AS FLOAT)/1000 
				when current_tariff_description like '%GB%' 
				then CAST(REPLACE(current_tariff_description, 'GB' , '') AS FLOAT)
				else 0 end) as sum_tariff_plans_GB
,count(current_tariff_description) as cnt_plans
,count(service_instance_id) as cnt_service_id
,sum(case when status_code='AC' then 1 else 0 end) as cnt_active_status_cd
,sum(case 	when status_code='AC' and current_tariff_description like '%MB%' 
				then CAST(REPLACE(current_tariff_description, 'MB' , '') AS FLOAT)/1000 
			when status_code='AC' and current_tariff_description like '%GB%' 
				then CAST(REPLACE(current_tariff_description, 'GB' , '') AS FLOAT)
				else 0 end) as sum_active_tariff_plans_GB
,count(case when status_code='AC' and current_tariff_description is not null then 1 else 0 end) as cnt_active_plans
into #mobile_tariff_total
from #mobile_tariff_latest 
where status_code in('AC','R','CRQ','BCRQ')
group by account_number, currency_code, cb_data_date;


update #mobile_base base
set sum_tariff_plans_GB = total.sum_tariff_plans_GB
	,cnt_plans = total.cnt_plans
	,cnt_service_id = total.cnt_service_id
	,cnt_active_status_cd = total.cnt_active_status_cd
	,sum_active_tariff_plans_GB = total.sum_active_tariff_plans_GB
	,cnt_active_plans = total.cnt_active_plans

from #mobile_base base
inner join #mobile_tariff_total total
on base.mobile_account_number = total.account_number and base.currency_code = total.currency_code
and month(base.base_dt) = month(total.cb_data_date) and year(base.base_dt) = year(total.cb_data_date);


drop table if exists #mobile_add_on;
select 
account_number
,currency_code
,cast(one_off_addon_product_status_start_dt as date) as refrence_dt
,one_off_addon_product
,one_off_addon_product_status_code as status_code 
into #mobile_add_on
from 
CUST_SINGLE_MOBILE_VIEW
group by 
account_number
,currency_code
,refrence_dt
,one_off_addon_product
,status_code;

delete from #mobile_add_on where (account_number is null or refrence_dt is null or status_code is null);

drop table if exists #mobile_add_on_with_rank;
select 
account_number,currency_code,refrence_dt,status_code,one_off_addon_product,dense_rank() over (partition by account_number,currency_code order by refrence_dt asc) as rank
into #mobile_add_on_with_rank
from #mobile_add_on;

drop table if exists #mobile_add_on_base;
select aa.account_number,aa.currency_code,aa.refrence_dt as effective_from_dt,bb.refrence_dt as effective_to_dt,aa.status_code,aa.one_off_addon_product
into #mobile_add_on_base
from #mobile_add_on_with_rank aa
left join (select account_number,currency_code,refrence_dt,rank from #mobile_add_on_with_rank group by account_number,currency_code,refrence_dt,rank) bb 
on aa.account_number = bb.account_number
and aa.currency_code=bb.currency_code
and aa.rank+1 = bb.rank;

update #mobile_add_on_base
set effective_to_dt = '9999-09-09'
where effective_to_dt is null;



update #mobile_base base
set piggybank_1_gb = 1
from #mobile_base  base 
inner join #mobile_add_on_base add_on 
on base.mobile_account_number = add_on.account_number 
where  base.base_dt between add_on.effective_from_dt and add_on.effective_to_dt -1 
and one_off_addon_product = '1GB Piggybank'
and add_on.status_code in('PU');

update #mobile_base base
set add_on_1_gb = 1
from #mobile_base  base 
inner join #mobile_add_on_base add_on 
on base.mobile_account_number = add_on.account_number 
where  base.base_dt between add_on.effective_from_dt and add_on.effective_to_dt -1 
and one_off_addon_product = '1GB Add On'
and add_on.status_code in('PU');




-- Mobile international Add-on 
/*
pre-active - OIP
active - AC,CRQ,BCRQ,R
cancel  - CN 
*/

drop table if exists #mobile_int_add_on;
select 
account_number
,currency_code
,cast(one_off_addon_product_status_start_dt as date) as refrence_dt
,'International add on' as product_holding 
,prod_latest_mobile_int_status_code as status_code 
into #mobile_int_add_on
from 
CUST_SINGLE_MOBILE_VIEW
group by 
account_number
,currency_code
,refrence_dt
,product_holding
,status_code;

delete from #mobile_int_add_on where (account_number is null or refrence_dt is null or status_code is null);

drop table if exists #mobile_int_add_on_with_rank;
select 
account_number,currency_code,refrence_dt,status_code,product_holding,dense_rank() over (partition by account_number,currency_code order by refrence_dt asc) as rank
into #mobile_int_add_on_with_rank
from #mobile_int_add_on;

drop table if exists #mobile_int_add_on_base;
select aa.account_number,aa.currency_code,aa.refrence_dt as effective_from_dt,bb.refrence_dt as effective_to_dt,aa.status_code,aa.product_holding
into #mobile_int_add_on_base
from #mobile_int_add_on_with_rank aa
left join (select account_number,currency_code,refrence_dt,rank from #mobile_int_add_on_with_rank group by account_number,currency_code,refrence_dt,rank) bb 
on aa.account_number = bb.account_number
and aa.currency_code=bb.currency_code
and aa.rank+1 = bb.rank;

update #mobile_int_add_on_base
set effective_to_dt = '9999-09-09'
where effective_to_dt is null;



update #mobile_base base
set international_add_on = 1
from #mobile_base  base 
inner join #mobile_int_add_on_base int_add_on 
on base.mobile_account_number = int_add_on.account_number 
where  base.base_dt between int_add_on.effective_from_dt and int_add_on.effective_to_dt -1 
and int_add_on.status_code in('AC','R','CRQ','BCRQ');




-- Mobile talk text add on
/*
Pre-Active : OIP
Active : AC,CRQ,BCRQ,R
Cancel : CN

*/

drop table if exists #mobile_talk_text_add_on;
select 
account_number
,currency_code
,cast(prod_latest_mobile_tt_status_start_dt as date) as refrence_dt
,'Talk Text add on' as product_holding 
,prod_latest_mobile_tt_status_code as status_code 
into #mobile_talk_text_add_on
from 
CUST_SINGLE_MOBILE_VIEW
group by 
account_number
,currency_code
,refrence_dt
,product_holding
,status_code;

delete from #mobile_talk_text_add_on where (account_number is null or refrence_dt is null or status_code is null);

drop table if exists #mobile_talk_text_add_on_with_rank;
select 
account_number,currency_code,refrence_dt,status_code,product_holding,dense_rank() over (partition by account_number,currency_code order by refrence_dt asc) as rank
into #mobile_talk_text_add_on_with_rank
from #mobile_talk_text_add_on;

drop table if exists #mobile_talk_text_add_on_base;
select aa.account_number,aa.currency_code,aa.refrence_dt as effective_from_dt,bb.refrence_dt as effective_to_dt,aa.status_code,aa.product_holding
into #mobile_talk_text_add_on_base
from #mobile_talk_text_add_on_with_rank aa
left join (select account_number,currency_code,refrence_dt,rank from #mobile_talk_text_add_on_with_rank group by account_number,currency_code,refrence_dt,rank) bb 
on aa.account_number = bb.account_number
and aa.currency_code=bb.currency_code
and aa.rank+1 = bb.rank;

update #mobile_talk_text_add_on_base
set effective_to_dt = '9999-09-09'
where effective_to_dt is null;


update #mobile_base base
set talk_text_add_on = 1
from #mobile_base  base 
inner join #mobile_talk_text_add_on_base talk_add_on 
on base.mobile_account_number = talk_add_on.account_number 
where  base.base_dt between talk_add_on.effective_from_dt and talk_add_on.effective_to_dt -1 
and talk_add_on.status_code in('AC','R','CRQ','BCRQ');

/*
update #mobile_base aa
set  aa.active_campaign_name = bb.campaign_name
from #mobile_base aa
inner join CITeam.Mobile_Campaign_data bb
on aa.tariff_plan = bb.offered_plan
where aa.base_dt between bb.effective_from_dt and bb.effective_to_dt;
*/

-- mobile additional info

drop table if exists #mobile_add_info;
select 
account_number
, email_allowed
, postal_mail_allowed
, promo_phone_allowed
, promo_email_allowed
, promo_mail_allowed
, sms_allowed
, telephone_contact_allowed
, viewing_data_capture_allowed
, viewing_data_marketing_allowed
, count_data_plan_size_mob1gb
, count_data_plan_size_mob3gb
, count_data_plan_size_mob5gb
, count_mobile_int_addon_product
, count_mobile_tt_addon_product
, count_of_msisdn_active
--, sim_prev_msisdn_1
, piggybank_score
, retention_score
, person_type
--, igor_new_balance
--, igor_previous_balance
--, igor_redeemed_value
--, igor_unallocated_value
, currency_code
, cast(prod_earliest_mobile_activation_dt as date) as prod_earliest_mobile_activation_dt
, cast(prod_latest_mobile_activation_dt as date) as prod_latest_mobile_activation_dt
, cast(prod_earliest_mobile_activation_dt as date) as refrence_dt
, prod_latest_mobile_status_code as status_code
into #mobile_add_info
from 
CUST_SINGLE_MOBILE_ACCOUNT_VIEW
group by 
account_number
, email_allowed
, postal_mail_allowed
, promo_phone_allowed
, promo_email_allowed
, promo_mail_allowed
, sms_allowed
, telephone_contact_allowed
, viewing_data_capture_allowed
, viewing_data_marketing_allowed
, count_data_plan_size_mob1gb
, count_data_plan_size_mob3gb
, count_data_plan_size_mob5gb
, count_mobile_int_addon_product
, count_mobile_tt_addon_product
, count_of_msisdn_active
--, sim_prev_msisdn_1
, piggybank_score
, retention_score
, person_type
--, igor_new_balance
--, igor_previous_balance
--, igor_redeemed_value
--, igor_unallocated_value
, currency_code
, refrence_dt
, status_code
, prod_earliest_mobile_activation_dt
, prod_latest_mobile_activation_dt;

delete from #mobile_add_info where (account_number is null or refrence_dt is null or status_code is null);

drop table if exists #mobile_add_info_with_rank;
select 
account_number
, email_allowed
, postal_mail_allowed
, promo_phone_allowed
, promo_email_allowed
, promo_mail_allowed
, sms_allowed
, telephone_contact_allowed
, viewing_data_capture_allowed
, viewing_data_marketing_allowed
, count_data_plan_size_mob1gb
, count_data_plan_size_mob3gb
, count_data_plan_size_mob5gb
, count_mobile_int_addon_product
, count_mobile_tt_addon_product
, count_of_msisdn_active
--, sim_prev_msisdn_1
, piggybank_score
, retention_score
, person_type
--, igor_new_balance
--, igor_previous_balance
--, igor_redeemed_value
--, igor_unallocated_value
, refrence_dt
, status_code
, currency_code
, prod_earliest_mobile_activation_dt
, prod_latest_mobile_activation_dt

, dense_rank() over (partition by account_number
, email_allowed
, postal_mail_allowed
, promo_phone_allowed
, promo_email_allowed
, promo_mail_allowed
, sms_allowed
, telephone_contact_allowed
, viewing_data_capture_allowed
, viewing_data_marketing_allowed
, count_data_plan_size_mob1gb
, count_data_plan_size_mob3gb
, count_data_plan_size_mob5gb
, count_mobile_int_addon_product
, count_mobile_tt_addon_product
, count_of_msisdn_active
--, sim_prev_msisdn_1
, piggybank_score
, retention_score
, person_type
--, igor_new_balance
--, igor_previous_balance
--, igor_redeemed_value
--, igor_unallocated_value
, status_code 
, currency_code
, prod_earliest_mobile_activation_dt
, prod_latest_mobile_activation_dt
order by refrence_dt asc) as rank
into #mobile_add_info_with_rank
from #mobile_add_info;

drop table if exists #mobile_add_info_base;
select aa.account_number
, aa.email_allowed
, aa.postal_mail_allowed
, aa.promo_phone_allowed
, aa.promo_email_allowed
, aa.promo_mail_allowed
, aa.sms_allowed
, aa.telephone_contact_allowed
, aa.viewing_data_capture_allowed
, aa.viewing_data_marketing_allowed
, aa.count_data_plan_size_mob1gb
, aa.count_data_plan_size_mob3gb
, aa.count_data_plan_size_mob5gb
, aa.count_mobile_int_addon_product
, aa.count_mobile_tt_addon_product
, aa.count_of_msisdn_active
--, aa.sim_prev_msisdn_1
, aa.piggybank_score
, aa.retention_score
, aa.person_type
--, aa.igor_new_balance
--, aa.igor_previous_balance
--, aa.igor_redeemed_value
--, aa.igor_unallocated_value
, aa.status_code 
, aa.currency_code
, aa.prod_earliest_mobile_activation_dt
, aa.prod_latest_mobile_activation_dt

, aa.refrence_dt as effective_from_dt
, bb.refrence_dt as effective_to_dt
into #mobile_add_info_base
from #mobile_add_info_with_rank aa
left join (select account_number,currency_code,refrence_dt,rank from 
#mobile_add_info_with_rank 
group by account_number,currency_code,refrence_dt,rank) bb 
on aa.account_number = bb.account_number
and aa.currency_code=bb.currency_code
and aa.rank+1 = bb.rank;

update #mobile_add_info_base
set effective_to_dt = '9999-09-09'
where effective_to_dt is null;


update #mobile_base base
set base.email_allowed = add_info.email_allowed
,base.postal_mail_allowed=add_info.postal_mail_allowed
,base.promo_phone_allowed=add_info.promo_phone_allowed
,base.promo_email_allowed=add_info.promo_email_allowed
,base.promo_mail_allowed=add_info.promo_mail_allowed
,base.sms_allowed=add_info.sms_allowed
,base.telephone_contact_allowed=add_info.telephone_contact_allowed
,base.viewing_data_capture_allowed=add_info.viewing_data_capture_allowed
,base.viewing_data_marketing_allowed=add_info.viewing_data_marketing_allowed
,base.count_data_plan_size_mob1gb=add_info.count_data_plan_size_mob1gb
,base.count_data_plan_size_mob3gb=add_info.count_data_plan_size_mob3gb
,base.count_data_plan_size_mob5gb=add_info.count_data_plan_size_mob5gb
,base.count_mobile_int_addon_product=add_info.count_mobile_int_addon_product
,base.count_mobile_tt_addon_product=add_info.count_mobile_tt_addon_product
,base.count_of_msisdn_active=add_info.count_of_msisdn_active
--,base.sim_prev_msisdn_1=add_info.sim_prev_msisdn_1
,base.piggybank_score=add_info.piggybank_score
,base.retention_score=add_info.retention_score
,base.person_type=add_info.person_type
--,base.igor_new_balance=add_info.igor_new_balance
--,base.igor_previous_balance=add_info.igor_previous_balance
--,base.igor_redeemed_value=add_info.igor_redeemed_value
--,base.igor_unallocated_value=add_info.igor_unallocated_value
,base.prod_earliest_mobile_activation_dt = add_info.prod_earliest_mobile_activation_dt
,base.prod_latest_mobile_activation_dt = add_info.prod_latest_mobile_activation_dt

from #mobile_base  base 
inner join #mobile_add_info_base add_info 
on base.mobile_account_number = add_info.account_number 
where  base.base_dt between add_info.effective_from_dt and add_info.effective_to_dt -1 
and add_info.status_code in('AC','R','CRQ','BCRQ');


---Update in logic of pulling igor balance

--1. Igor Redemption Calculation 
Drop table if exists #igor_redemptions;
Select  account_number , cast(igor_trans_date as date), prod_latest_mobile_status_code as status_code 
      , min(cb_data_date) as start_date
      , max(cb_data_date) as end_date
      , max(igor_new_balance /1024/1024)as igor_new_balance_mb
      , max(igor_previous_balance/1024/1024) as igor_previous_balance_mb
      , max(igor_redeemed_value/1024/1024) as igor_redeemed_value_mb
      , max(igor_unallocated_value/1024/1024) as igor_unallocated_value_mb
into #igor_redemptions
from CUST_SINGLE_MOBILE_VIEW
--where end_date <= (select max(base_dt) from #mobile_base) --additional line to remove duplicates
group by  account_number, igor_trans_date, status_code;

--2.  Total igor usage by the end month of igor allowance  
Drop table if exists #igor_redemptions2;
Select *
, case when a.igor_redeemed_value_mb >=1 then 1 else 0 end as igor_redemption_flag
, a.igor_redeemed_value_mb/1024 as igor_redemption_count
, sum(a.igor_redeemed_value_mb/1024) OVER(PARTITION BY a.account_number  ORDER BY a.account_number,a.igor_trans_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS igor_redemption_cum_sum
into #igor_redemptions2
from #igor_redemptions a
inner join #weeks as b
on  a.end_date between b.start_dt and b.base_dt
and b.currency_code = 'GBP'
;


update #mobile_base base
set 
base.igor_new_balance_mb=add_info.igor_new_balance_mb
,base.igor_previous_balance_mb=add_info.igor_previous_balance_mb
,base.igor_redeemed_value_mb=add_info.igor_redeemed_value_mb
,base.igor_unallocated_value_mb=add_info.igor_unallocated_value_mb
,base.igor_redemption_flag = add_info.igor_redemption_flag
,base.igor_redemption_count = add_info.igor_redemption_count
,base.igor_redemption_cum_sum = add_info.igor_redemption_cum_sum

from #mobile_base  base 
inner join #igor_redemptions2 add_info 
on base.mobile_account_number = add_info.account_number 
and base.base_dt = add_info.base_dt 
and add_info.status_code in('AC','R','CRQ','BCRQ');

---------------------------------------------------------------------

Update #mobile_base  aa
Set Mobile_Offer_End_Status_Level_2 = 
        case 
		     when offer_end_dt between (base_dt + 1) and (base_dt + 7)   then 'Offer Ending in Next 1 Wks'
             when offer_end_dt between (base_dt + 8) and (base_dt + 14)  then 'Offer Ending in Next 2-3 Wks'
             when offer_end_dt between (base_dt + 15) and (base_dt + 21) then 'Offer Ending in Next 2-3 Wks'
             when offer_end_dt between (base_dt + 22) and (base_dt + 28) then 'Offer Ending in Next 4-6 Wks'
             when offer_end_dt between (base_dt + 29) and (base_dt + 35) then 'Offer Ending in Next 4-6 Wks'
             when offer_end_dt between (base_dt + 36) and (base_dt + 42) then 'Offer Ending in Next 4-6 Wks'
             when offer_end_dt > (base_dt + 42)    then 'Offer Ending in 7+ Wks'
			 
             when effective_to_dt between (base_dt - 7) and base_dt         then 'Offer Ended in last 1 Wks'
             when effective_to_dt between (base_dt - 14) and (base_dt - 8)  then 'Offer Ended in last 2-3 Wks'
             when effective_to_dt between (base_dt - 21) and (base_dt - 15) then 'Offer Ended in last 2-3 Wks'
             when effective_to_dt between (base_dt - 28) and (base_dt - 22) then 'Offer Ended in last 4-6 Wks'
             when effective_to_dt between (base_dt - 35) and (base_dt - 29) then 'Offer Ended in last 4-6 Wks'
             when effective_to_dt between (base_dt - 42) and (base_dt - 36) then 'Offer Ended in last 4-6 Wks'
             when effective_to_dt < (base_dt - 42)  then 'Offer Ended 7+ Wks'
             
			 else 'No Offer'
        end

from #mobile_base aa
inner join CITeam.mobile_offers bb
on aa.Mobile_Account_Number = bb.account_number
where  offer_activated = 1;
	
update #mobile_base
	set Mobile_Offer_End_Status_Level_1
              = case when Mobile_Offer_End_Status_Level_2 in( 'Offer Ending in Next 1 Wks','Offer Ending in Next 2-3 Wks','Offer Ending in Next 4-6 Wks','Offer Ended in last 1 Wks','Offer Ended in last 2-3 Wks','Offer Ended in last 4-6 Wks','Offer Ended 7+ Wks' ) then
					'Offer Ending'
					 when Mobile_Offer_End_Status_Level_2 = 'Offer Ending in 7+ Wks' then 'On Offer'
				else 'No Offer'
end;


update #mobile_base base 
set 
 base.payment_plan_name = cca.payment_plan_name
,base.agreement_status = cca.agreement_status
,base.cash_price = cca.cash_price
,base.activation_date = cca.activation_date
,base.activation_offset_days = cca.activation_offset_days
--,base.actual_trade_in_dt = cca.actual_trade_in_dt
--,base.actual_trade_in_value = cca.actual_trade_in_value
,base.affordability_value = cca.affordability_value
,base.contract_signed_date = cca.contract_signed_date
,base.cool_off_end_dt = cca.cool_off_end_dt
,base.cool_off_start_dt = cca.cool_off_start_dt
,base.delivery_dt = cca.delivery_dt
,base.discount_value = cca.discount_value
,base.final_repay_date = cca.final_repay_date
,base.payment_plan_id = cca.payment_plan_id
,base.payment_plan_prop_id = cca.payment_plan_prop_id
,base.prepaid_value = cca.prepaid_value
,base.repayment_amount = cca.repayment_amount
--,base.retained_value = cca.retained_value
,base.swap_end_dt = cca.swap_end_dt
,base.swap_start_dt = cca.swap_start_dt
,base.total_value = cca.total_value
,base.unallocated_repayments = cca.unallocated_repayments
,base.unallocated_value = cca.unallocated_value
,base.unbilled_repayments = cca.unbilled_repayments
,base.unbilled_value = cca.unbilled_value
,base.handset_active = 1
,base.handset_description = cca.handset_description
from #mobile_base  base 
inner join cust_mobile_cca_agreement cca
on base.mobile_account_number = cca.account_number
where base.base_dt between cast(cca.activation_date as date) and cast(coalesce(cca.closed_date,next_repay_date)  as date) -1 
and cca.agreement_status in('ACTIVE','COMPLETE')  and cca.handset_description is not null 
--and (lower(cca.handset_description) not like '%pad%' and lower(cca.handset_description) not like '%tab%')
and cca.repayment_band=1;


update #mobile_base base 
set 
 base.tablet_active = 1
,base.tablet_description = cca.handset_description

from #mobile_base  base 
inner join cust_mobile_cca_agreement cca
on base.mobile_account_number = cca.account_number
where base.base_dt between cast(cca.activation_date as date) and cast(coalesce(cca.closed_date,next_repay_date)  as date) -1 
and cca.agreement_status in('ACTIVE','COMPLETE')  and cca.handset_description is not null 
--and (lower(cca.handset_description) like '%pad%' or  lower(cca.handset_description)  like '%tab%')
and cca.repayment_band=1;


drop table if exists #mobile_hs;
select base.mobile_account_number
	,base.base_dt
	,cca.handset_description

into #mobile_hs
from #mobile_base  base 
inner join cust_mobile_cca_agreement cca
on base.mobile_account_number = cca.account_number
and base.base_dt between cast(cca.activation_date as date) and cast(coalesce(cca.closed_date,next_repay_date)  as date) -1 
and cca.agreement_status in('ACTIVE','COMPLETE')  and cca.handset_description is not null 
--and (lower(cca.handset_description) like '%pad%' or  lower(cca.handset_description)  like '%tab%')
and cca.repayment_band = 1;

drop table if exists #mobile_hs_count;
select mobile_account_number, base_dt
,count(distinct handset_description) as active_hs_count
,sum(case when upper(handset_description) like '%APPLE%' then 1 else 0 end) as active_apple_hs_count

into #mobile_hs_count
from #mobile_hs
group by mobile_account_number, base_dt;

update #mobile_base
	set base.active_hs_count = hs.active_hs_count
	,base.active_apple_hs_count = hs.active_apple_hs_count
from #mobile_hs_count hs
inner join #mobile_base base
on base.mobile_account_number = hs.mobile_account_number and base.base_dt = hs.base_dt;



update #mobile_base base 
set sim_only_customer = case when (sim_active = 1 and handset_active = 0) then 1 else 0 end;


drop table if exists #mobile_monthly_usage;

select account_number
, sum(corporate_voice_volume) as corporate_voice_vol
, sum(daytime_mms_volume) as daytime_mms_vol
, sum(daytime_sms_volume) as daytime_sms_vol
, sum(daytime_voice_volume) as daytime_voice_vol
, sum(evening_mms_volume) as evening_mms_vol
, sum(evening_sms_volume) as evening_sms_vol
, sum(evening_voice_volume) as evening_voice_vol
, sum(freephone_voice_volume) as freephone_voice_vol
, sum(home_data_kb) as home_data_kb
, sum(home_mms_volume) as home_mms_vol
, sum(home_sms_volume) as home_sms_vol
, sum(incoming_sky_mobile_mms_volume) as sky_mms_vol
, sum(incoming_sky_mobile_sms_volume) as sky_sms_vol
, sum(incoming_sky_mobile_voice_vol) as sky_voice_vol
, sum(roaming_mms_volume) as roaming_mms_vol
, sum(roaming_sms_volume) as roaming_sms_vol
, sum(weekend_sms_volume) as wknd_sms_vol
, sum(weekend_voice_volume) as wknd_voice_vol
, sum(total_data_kb) as total_data_kb
, sum(total_home_voice_secs) as total_home_voice_secs
, sum(total_incoming_voice_seconds) as total_incoming_secs
, sum(total_outgoing_voice_secs) as total_outgoing_secs
, sum(total_roaming_voice_secs) as total_roaming_secs


into #mobile_monthly_usage
from mobile_daily_usage

where cb_data_date >= today() - 31
group by 
account_number;

update #mobile_base
	set base.corporate_voice_vol=usage.corporate_voice_vol,
		base.daytime_mms_vol=usage.daytime_mms_vol,
		base.daytime_sms_vol=usage.daytime_sms_vol,
		base.daytime_voice_vol=usage.daytime_voice_vol,
		base.evening_mms_vol=usage.evening_mms_vol,
		base.evening_sms_vol=usage.evening_sms_vol,
		base.evening_voice_vol=usage.evening_voice_vol,
		base.freephone_voice_vol=usage.freephone_voice_vol,
		base.home_data_kb=usage.home_data_kb,
		base.home_mms_vol=usage.home_mms_vol,
		base.home_sms_vol=usage.home_sms_vol,
		base.sky_mms_vol=usage.sky_mms_vol,
		base.sky_sms_vol=usage.sky_sms_vol,
		base.sky_voice_vol=usage.sky_voice_vol,
		base.roaming_mms_vol=usage.roaming_mms_vol,
		base.roaming_sms_vol=usage.roaming_sms_vol,
		base.wknd_sms_vol=usage.wknd_sms_vol,
		base.wknd_voice_vol=usage.wknd_voice_vol,
		base.total_data_kb=usage.total_data_kb,
		base.total_home_voice_secs=usage.total_home_voice_secs,
		base.total_incoming_secs=usage.total_incoming_secs,
		base.total_outgoing_secs=usage.total_outgoing_secs,
		base.total_roaming_secs=usage.total_roaming_secs
	from #mobile_base base
	inner join #mobile_monthly_usage usage
	on base.mobile_account_number = usage.account_number;
	

delete from #mobile_base
where (sim_active+handset_active+tablet_active) = 0;


update #mobile_base
	set prod_earliest_mobile_activation_dt = null,
	prod_latest_mobile_activation_dt = null
	where base_dt < prod_earliest_mobile_activation_dt;

update #mobile_base
	set prod_earliest_mobile_activation_dt = null,
	prod_latest_mobile_activation_dt = null
	where prod_latest_mobile_activation_dt < prod_earliest_mobile_activation_dt;


delete from Decisioning.Propensity_Mobile_Mart_Scoring;
insert into Decisioning.Propensity_Mobile_Mart_Scoring
select 
base_dt
,mobile_account_number
,portfolio_id
,owning_cust_account_id
,dtv_account_number
,country
,sim_active
,sum_tariff_plans_GB
,cnt_plans
,cnt_service_id
,cnt_active_status_cd
,sum_active_tariff_plans_GB
,cnt_active_plans
,piggybank_1_gb
,add_on_1_gb
,international_add_on
,talk_text_add_on
,handset_active
,handset_description
,tablet_active
,tablet_description
,sim_only_customer
,mobile_offer_end_status_level_1
,mobile_offer_end_status_level_2
,payment_plan_name
,agreement_status
,cash_price
,activation_date
,activation_offset_days
--,actual_trade_in_dt
--,actual_trade_in_value
,affordability_value
,contract_signed_date
,cool_off_end_dt
,cool_off_start_dt
,delivery_dt
,discount_value
,final_repay_date
,payment_plan_id
,payment_plan_prop_id
,prepaid_value
,repayment_amount
--,retained_value
,swap_end_dt
,swap_start_dt
,total_value
,unallocated_repayments
,unallocated_value
,unbilled_repayments
,unbilled_value
, email_allowed
, postal_mail_allowed
, promo_phone_allowed
, promo_email_allowed
, promo_mail_allowed
, sms_allowed
, telephone_contact_allowed
, viewing_data_capture_allowed
, viewing_data_marketing_allowed
, count_data_plan_size_mob1gb
, count_data_plan_size_mob3gb
, count_data_plan_size_mob5gb
, count_mobile_int_addon_product
, count_mobile_tt_addon_product
, count_of_msisdn_active
--, sim_prev_msisdn_1
, piggybank_score
, retention_score
, person_type
-- Changes for igor update

, igor_new_balance_mb
, igor_previous_balance_mb
, igor_redeemed_value_mb
, igor_unallocated_value_mb
, igor_redemption_flag
, igor_redemption_count
, igor_redemption_cum_sum

------------------------------
, prod_earliest_mobile_activation_dt
, prod_latest_mobile_activation_dt
, corporate_voice_vol
, daytime_mms_vol
, daytime_sms_vol
, daytime_voice_vol
, evening_mms_vol
, evening_sms_vol
, evening_voice_vol
, freephone_voice_vol
, home_data_kb
, home_mms_vol
, home_sms_vol
, sky_mms_vol
, sky_sms_vol
, sky_voice_vol
, roaming_mms_vol
, roaming_sms_vol
, wknd_sms_vol
, wknd_voice_vol
, total_data_kb
, total_home_voice_secs
, total_incoming_secs
, total_outgoing_secs
, total_roaming_secs
, active_hs_count
, active_apple_hs_count

from #mobile_base
;

end 

GO
GRANT EXECUTE ON Decisioning_procs.Update_Decisioning_Propensity_Mobile_Mart_Scoring TO public;

/*
call Decisioning_procs.Update_Decisioning_Propensity_Mobile_Mart_Scoring();


View 

call DBA.sp_DDL ('drop', 'view', 'CITeam', 'Propensity_Mobile_Mart_Scoring');
call DBA.sp_DDL ('create', 'view', 'CITeam', 'Propensity_Mobile_Mart_Scoring',  'select * from Decisioning.Propensity_Mobile_Mart_Scoring');

*/