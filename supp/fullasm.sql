
--  SPOOL script to create all script files for an application
-- &1. is the DTGEN application abbreviation
set define '&'
set feedback off
set linesize 4000
set pagesize 0
set serveroutput on format wrapped
set trimspool on
set verify off

spool install_db.sql
execute dtgen_util.assemble_script('&1.','INSTALL','DB');
spool install_db_sec.sql
execute dtgen_util.assemble_script('&1.','INSTALL','DB','sec');
spool install_mt.sql
execute dtgen_util.assemble_script('&1.','INSTALL','MT');
spool install_mt_sec.sql
execute dtgen_util.assemble_script('&1.','INSTALL','MT','sec');
spool install_usr.sql
execute dtgen_util.assemble_script('&1.','INSTALL','USR');
spool install_gui.sql
execute dtgen_util.assemble_script('&1.','INSTALL','GUI');
spool uninstall_db.sql
execute dtgen_util.assemble_script('&1.','UNINSTALL','DB');
spool uninstall_mt.sql
execute dtgen_util.assemble_script('&1.','UNINSTALL','MT');
spool uninstall_usr.sql
execute dtgen_util.assemble_script('&1.','UNINSTALL','USR');
spool dtgen_dataload.dat
execute dtgen_util.data_script('&1.')
spool off

set verify on
set pagesize 20
set linesize 80
set feedback 6

--
--  ============================================================
--
--  The folowing creates individual files for each script
--
--  NOTE: This approach is an advanced option and requires
--     proper assembly of the install and uninstall files
--     that are created.  Use of the dtgen_util package as 
--     shown above is preferred.
--
-- @select_file &1. drop_usyn
-- @select_file &1. drop_mods
-- @select_file &1. drop_aa
-- @select_file &1. drop_oltp
-- @select_file &1. drop_dist
-- @select_file &1. drop_integ
-- @select_file &1. drop_ods
-- @select_file &1. drop_gdst
-- @select_file &1. drop_glob
-- 
-- @select_file &1. create_glob
-- @select_file &1. create_glob_sec
-- @select_file &1. create_gdst
-- @select_file &1. create_gdst_sec
-- @select_file &1. create_ods
-- @select_file &1. create_ods_sec
-- @select_file &1. create_integ
-- @select_file &1. create_integ_sec
-- @select_file &1. create_dist
-- @select_file &1. create_dist_sec
-- @select_file &1. create_oltp
-- @select_file &1. create_oltp_sec
-- @select_file &1. create_aa
-- @select_file &1. create_aa_sec
-- @select_file &1. create_mods
-- @select_file &1. create_mods_sec
-- @select_file &1. create_usyn
-- 
-- @select_file &1. create_flow
-- 
-- @comp_file &1.
-- 
