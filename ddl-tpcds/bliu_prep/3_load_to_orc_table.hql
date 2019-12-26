create database if not exists ${orc_db};
use ${orc_db} ;


drop table if exists call_center;
create table call_center    stored as orc as select * from ${text_db}.call_center;
drop table if exists catalog_page;
create table catalog_page    stored as orc as select * from ${text_db}.catalog_page;
drop table if exists customer;
create table customer    stored as orc as select * from ${text_db}.customer CLUSTER BY c_customer_sk;
drop table if exists customer_address;
create table customer_address    stored as orc as select * from ${text_db}.customer_address CLUSTER BY ca_address_sk ;
drop table if exists customer_demographics;
create table customer_demographics    stored as orc as select * from ${text_db}.customer_demographics;
drop table if exists date_dim;
create table date_dim    stored as orc as select * from ${text_db}.date_dim;
drop table if exists household_demographics;
create table household_demographics    stored as orc as select * from ${text_db}.household_demographics;
drop table if exists income_band;
create table income_band    stored as orc as select * from ${text_db}.income_band;
drop table if exists inventory;
create table inventory    stored as orc as select * from ${text_db}.inventory CLUSTER BY inv_date_sk;
drop table if exists item;
create table item    stored as orc as select * from ${text_db}.item CLUSTER BY i_item_sk;
drop table if exists promotion;
create table promotion    stored as orc as select * from ${text_db}.promotion;
drop table if exists reason;
create table reason    stored as orc as select * from ${text_db}.reason;
drop table if exists ship_mode;
create table ship_mode    stored as orc as select * from ${text_db}.ship_mode;
drop table if exists store;
create table store    stored as orc as select * from ${text_db}.store CLUSTER BY s_store_sk;
drop table if exists web_site;
create table web_site    stored as orc as select * from ${text_db}.web_site;
drop table if exists time_dim;
create table time_dim    stored as orc as select * from ${text_db}.time_dim;
drop table if exists warehouse;
create table warehouse    stored as orc as select * from ${text_db}.warehouse;
drop table if exists web_page;
create table web_page    stored as orc as select * from ${text_db}.web_page;


analyze table call_center compute statistics for columns;
analyze table catalog_page compute statistics for columns;
analyze table customer compute statistics for columns;
analyze table customer_address compute statistics for columns;
analyze table customer_demographics compute statistics for columns;
analyze table date_dim compute statistics for columns;
analyze table household_demographics compute statistics for columns;
analyze table income_band compute statistics for columns;
analyze table inventory compute statistics for columns;
analyze table item compute statistics for columns;
analyze table promotion compute statistics for columns;
analyze table reason compute statistics for columns;
analyze table ship_mode compute statistics for columns;
analyze table store compute statistics for columns;
analyze table time_dim compute statistics for columns;
analyze table warehouse compute statistics for columns;
analyze table web_page compute statistics for columns;
analyze table web_site compute statistics for columns;

