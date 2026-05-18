clear screen

  /************************************/
 /** INSTALL ora*CODEDOC (OCD-DEMO) **/
/************************************/

whenever sqlerror exit failure rollback
whenever oserror exit failure rollback

set serveroutput on
set feedback on
set echo off
set heading off
set verify off

--------------------------------------------------------------------------------

define ocd_demo_password   = ora0CODEDOCdemo1password
define ocd_demo_tablespace = sysaux

--------------------------------------------------------------------------------
prompt >>> create ocd_demo user

create user ocd_demo identified by "&ocd_demo_password"
                       default tablespace &ocd_demo_tablespace
                       quota 5m on &ocd_demo_tablespace;
grant create session,
      create procedure,
      create type,
      under any type
   to ocd_demo;

alter session set current_schema=ocd_demo;
alter session set plsql_warnings='DISABLE:ALL';
--------------------------------------------------------------------------------
prompt >>> create some apex packages

--@ddl/package/wwv_flow_security_minimal.pks

--@ddl/package/apex_acl.pks
--@ddl/package/apex_acl_mod.pks
--@ddl/package/apex_ai.pks
@ddl/package/pkg_sample.pks
@ddl/package/apex_css.pks
@ddl/package/apex_css_modified.pks
@ddl/type/html_pub_sample.tps
@ddl/type/html_pub_sample.tpb
--------------------------------------------------------------------------------
--prompt >>> create some sys packages
--prompt >>> grant necessary roles
--
--@dcl/worker.pks
--@dcl/public/api.pks
--------------------------------------------------------------------------------
prompt >>> done <<<
