create or replace package body dtgen_util as

/************************************************************
DTGEN "utility" Package Body

Copyright (c) 2011, Duane.Dieterich@gmail.com
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
************************************************************/

LF  CONSTANT  varchar2(1)  := chr(10);  -- Line Feed character
CR  CONSTANT  varchar2(1)  := chr(13);  -- Carriage Return character
FS  CONSTANT  varchar2(1)  := chr(28);  -- Field Separator character
RS  CONSTANT  varchar2(1)  := chr(30);  -- Record Separator character

lo_opname     varchar2(64);  -- Operation Name for LongOps
lo_num_units  number;        -- Number of Units for LongOps

USE_RCLOB     boolean      := FALSE;

----------------------------------------
procedure p
      (line_in  in  varchar2)
is
begin
   if USE_RCLOB
   then
      rclob := rclob || line_in || chr(10);
   else
      dbms_output.put_line(line_in);
   end if;
end p;
----------------------------------------
function get_aa_key_name
      (aa_key_in    in  varchar2
      ,suffix_in    in  varchar2)
   return varchar2
is
   rstr varchar2(100);
begin
   case aa_key_in
      when 'DB'  then rstr := 'Database';
      when 'MT'  then rstr := 'Mid-Tier';
      when 'GUI' then rstr := 'APEX Maintenance GUI';
      when 'USR' then rstr := 'User Synonym';
      else rstr := aa_key_in;
   end case;
   if suffix_in is not null
   then
      if suffix_in = 'sec'
      then
         rstr := rstr || ' Security';
      else
         rstr := rstr || ' ' || suffix_in;
      end if;
   end if;
   return rstr;
end get_aa_key_name;
----------------------------------------
procedure assemble_script
      (app_abbr_in  in  varchar2
      ,action_in    in  varchar2
      ,own_key_in   in  varchar2
      ,suffix_in    in  varchar2 default '')
is
   aa_key     varchar2(100) := lower(action_in||'_'||own_key_in);
   file_name  varchar2(100);
begin
   rclob := '';
   begin
      vc2_list := aa_vc2(aa_key);
   exception
      when no_data_found then
         raise_application_error (-20000, '", aa_key "' || aa_key ||
                                          '" is not recognized');
      when others then
         raise;
   end;
   lo_opname := 'DTGen ' || app_abbr_in || ' ' ||
                initcap(action_in) || ' Script Assembly';
   lo_num_units := vc2_list.count + 1;  -- Add one for util.end_longops
   util.init_longops(lo_opname, lo_num_units,
      get_aa_key_name(aa_key, suffix_in), 'tables');
   p('');
   p('--');
   p('--  ' || initcap(action_in) || ' ' ||
          get_aa_key_name(aa_key, suffix_in) ||
          ' Scripts for ' || app_abbr_in);
   p('--');
   p('--  The ' || vc2_list.count || ' scripts included are:');
   for i in 1 .. vc2_list.count
   loop
      if suffix_in is not null
      then
         p('--    -) ' || vc2_list(i) || '_' || suffix_in);
      else
         p('--    -) ' || vc2_list(i));
      end if;
   end loop;
   p('--');
   p('');
   for i in 1 .. vc2_list.count
   loop
      file_name := vc2_list(i);
      if suffix_in is not null
      then
         file_name := file_name || '_' || suffix_in;
      end if;
      p('');
      p('select '' -) ' || file_name || '  '' as FILE_NAME from dual;');
      p('');
      for buff in (
         select value from file_lines_act
          where files_nk1 = upper(app_abbr_in)
           and  files_nk2 = lower(file_name)
          order by seq )
      loop
         p(buff.value);
      end loop;
      p('');
      util.add_longops (1);
   end loop;
   util.end_longops;
end assemble_script;
----------------------------------------
function assemble_script
      (app_abbr_in  in  varchar2
      ,action_in    in  varchar2
      ,own_key_in   in  varchar2
      ,suffix_in    in  varchar2 default '')
   return clob
is
begin
   USE_RCLOB := TRUE;
   assemble_script(app_abbr_in, action_in, own_key_in, suffix_in);
   USE_RCLOB := FALSE;
   return rclob;
end assemble_script;
----------------------------------------
procedure data_script
      (app_abbr_in  in  varchar2)
is
   cursor table_cursor is
      select max(lvl) lvl
            ,tab      name
       from  (select partab
                    ,level lvl
                    ,tab
               from  (select puc.table_name  partab
                            ,uc.table_name   tab
                       from  user_constraints puc
                            ,user_tables      tab
                            ,user_constraints uc
                       where puc.constraint_name = uc.r_constraint_name
                        and  tab.table_name      = uc.table_name
                        and  uc.constraint_type  = 'R' 
                      union all
                      select null        partab
                            ,table_name  tab
                       from  user_tables)
               connect by prior tab = partab )
       where tab not in ('FILES','FILES_PDAT',
                         'FILES_AUD','FILES_HIST',
                         'FILE_LINES','FILE_LINES_PDAT',
                         'FILE_LINES_AUD','FILE_LINES_HIST',
                         'UTIL_LOG')
       group by tab
       order by 1, 2;
   cursor column_cursor (tab_name varchar2) is
      select vc.column_name  name
            ,vc.data_type    type
            ,vc.data_length  len
       from  user_tab_columns  vc
       where vc.table_name = tab_name || '_ACT'
        and  vc.column_name not like '%ID_PATH'
        and  vc.column_name not like '%NK_PATH'
        and  vc.column_name not in (
             select cc.column_name
              from  user_cons_columns cc
                   ,user_constraints con
              where  cc.table_name      = tab_name
               and   cc.constraint_name = con.constraint_name
               and  con.constraint_type in ('P', 'R')
               and  con.table_name      = tab_name  )
       order by vc.column_id;
   type db_list_type   is table of varchar2(32767);
   db_list    db_list_type;      -- Data Buffer Array
   cs         varchar2(32767);   -- Column String
   ss         varchar2(32767);   -- SQL String
begin
   rclob := '';
   p('--');
   p('-- DTGen SQL*Loader Control File Header');
   p('--    Full data dump of the ' || app_abbr_in || ' application');
   p('--    ');
   p('--    Generated by DTGen (http://code.google.com/p/dtgen)');
   p('--    ' || to_char(sysdate,'Month DD, YYYY  HH:MI:SS AM'));
   p('--');
   p('-- 1) Copy this Header to a file named "dtgen_dataload.ctl"');
   p('--    (The split is necessary for the "STR" record terminator)');
   p('--    (The "STR" record terminator is necessary for records with embedded LineFeeds)');
   p('--    (1E = Record Separator, 0D = Carriage Return, 0A = LineFeed)');
   p('-- 2) sqlldr username/password CONTROL=dtgen_dataload.ctl');
   p('--    (This header is included in each datafile and skipped via the "skip = 1")');
   p('--');
   p('-- NOTE: CLOBs won''t load into _ACT views due to');
   p('--      "ORA-22816: unsupported feature with RETURNING clause"');
   p('--');
   p('options (skip = 1)');
   p('load data infile dtgen_dataload.dat  "STR x''1E0D0A''"');
   lo_num_units := 0;
   for tbuff in table_cursor
   loop
      cs := 'into table ' || tbuff.name;
      if tbuff.name != 'APPLICATIONS' then
         cs := cs || '_ACT';
      end if;
      cs := cs || ' APPEND when key = ''' || rpad(tbuff.name,30) || FS ||
                  ''' fields terminated by ''' || FS || '''';
      p(cs);
      cs := '   (key FILLER position(1:31)';
      for cbuff in column_cursor(tbuff.name)
      loop
         cs := cs ||', ' || lower(cbuff.name) || ' ' ||
            case cbuff.type
               when 'VARCHAR2' then
                  'CHAR(' || cbuff.len || ')'
               when 'NUMBER' then
                  'FLOAT EXTERNAL'
               when 'DATE' then
                  'DATE "DD-MON-YY HH24:MI:SS"'
               when 'TIMESTAMP WITH TIME ZONE' then
                  'TIMESTAMP(9) WITH TIME ZONE "DD-MON-YYYY HH24:MI:SS.FFFFFFFFF TZR"'
               when 'TIMESTAMP WITH LOCAL TIME ZONE' then
                  'TIMESTAMP(9) WITH LOCAL TIME ZONE "DD-MON-YYYY HH24:MI:SS.FFFFFFFFF TZR"'
               when 'CLOB' then
                  'CHAR(32767)'
               else 'Datatype Error'
            end;
      end loop;
      p(cs || ')');
      lo_num_units := lo_num_units + 1;
   end loop;
   lo_num_units := lo_num_units + 1;  -- Add one for util.end_longops
   lo_opname := 'DTGen ' || app_abbr_in || ' Install Script Assembly';
   util.init_longops(lo_opname, lo_num_units, 'SQL*Loader.ctl', 'tables');
   p('----------   End of Control File Header   ----------' || RS || CR);
   for tbuff in table_cursor
   loop
      ss := 'select ''' || rpad(tbuff.name,30) || '''';
      ss := ss || ' || ''' || FS || ''' || ';
      for cbuff in column_cursor(tbuff.name)
      loop
         case cbuff.type
            when 'CLOB' then
               ss := ss || cbuff.name;
            when 'DATE' then
               ss := ss || 'to_char(' || cbuff.name ||
                          ',''DD-MON-YY HH24:MI:SS'')';
            when 'NUMBER' then
               ss := ss || cbuff.name;
            when 'VARCHAR2' then
               ss := ss || cbuff.name;
            when 'TIMESTAMP WITH TIME ZONE' then
               ss := ss || 'to_char(' || cbuff.name ||
                           ',''DD-MON-YYYY HH24:MI:SS.FFFFFFFFF TZR'')';
            when 'TIMESTAMP WITH LOCAL TIME ZONE' then
               ss := ss || 'to_char(' || cbuff.name ||
                           ',''DD-MON-YYYY HH24:MI:SS.FFFFFFFFF TZR'')';
            else
               ss := ss || 'Datatype Error on ' || cbuff.name ||
                           '(' || cbuff.type || ')';
         end case;
         ss := ss || ' || ''' || FS || ''' || ';
      end loop;
      ss := substr(ss,1,length(ss)-11) ||
            ' from ' || tbuff.name || '_ACT where ';
      -- This app_abbr_in filter is table specific
      case tbuff.name
         -- Level 1
         when 'APPLICATIONS'  then ss := ss || 'abbr = ''';
         -- Level 2
         when 'DOMAINS'       then ss := ss || 'applications_nk1 = ''';
         when 'EXCEPTIONS'    then ss := ss || 'applications_nk1 = ''';
         when 'PROGRAMS'      then ss := ss || 'applications_nk1 = ''';
         when 'TABLES'        then ss := ss || 'applications_nk1 = ''';
         -- Level 3
         when 'DOMAIN_VALUES' then ss := ss || 'domains_nk1 = ''';
         when 'CHECK_CONS'    then ss := ss || 'tables_nk1 = ''';
         when 'TAB_COLS'      then ss := ss || 'tables_nk1 = ''';
         -- Level 4
         when 'TAB_INDS'       then ss := ss || 'tab_cols_nk1 = ''';
         else
            raise_application_error (-20000, 'dtgen_util.data_script(): '||
               'Unknown Table Name "' || tbuff.name || '"');
      end case;
      ss := ss || app_abbr_in || ''' order by ';
      -- For a table with a Self-Referencing Foreign Key,
      --   Use the PATH to load parent data first.
      -- This order by clause is table specific
      case tbuff.name
         -- Level 1
         when 'APPLICATIONS'  then ss := ss || 'abbr';
         -- Level 2
         when 'DOMAINS'       then ss := ss || 'applications_nk1, abbr';
         when 'EXCEPTIONS'    then ss := ss || 'applications_nk1, code';
         when 'PROGRAMS'      then ss := ss || 'applications_nk1, name';
         when 'TABLES'        then ss := ss || 'applications_nk1, seq';
         -- Level 3
         when 'DOMAIN_VALUES' then ss := ss || 'domains_nk1, domains_nk2, seq';
         when 'CHECK_CONS'    then ss := ss || 'tables_nk1, tables_nk2, seq';
         when 'TAB_COLS'      then ss := ss || 'tables_nk1, tables_nk2, seq';
         -- Level 4
         when 'TAB_INDS'       then ss := ss || 'tab_cols_nk1, tab_cols_nk2, tag, seq';
         else
            raise_application_error (-20000, 'dtgen_util.data_script(): '||
               'Unknown Table Name "' || tbuff.name || '"');
      end case;
      -- p(ss);
      execute immediate ss bulk collect into db_list;
      for i in 1 .. db_list.count
      loop
         p(db_list(i) || RS || CR);
      end loop;
      util.add_longops (1);
   end loop;
   util.end_longops;
end data_script;
----------------------------------------
function data_script
      (app_abbr_in  in  varchar2)
   return clob
is
begin
   USE_RCLOB := TRUE;
   data_script(app_abbr_in);
   USE_RCLOB := FALSE;
   return rclob;
end data_script;
----------------------------------------
function delete_app
      (app_abbr_in  in  varchar2)
   return number
is
   retnum  number;
begin
   delete from exceptions_act where applications_nk1 = app_abbr_in;
   retnum := SQL%ROWCOUNT;
   delete from programs_act where applications_nk1 = app_abbr_in;
   retnum := retnum + SQL%ROWCOUNT;
   delete from check_cons_act where tables_nk1 = app_abbr_in;
   retnum := retnum + SQL%ROWCOUNT;
   delete from tab_inds_act where tab_cols_nk1 = app_abbr_in;
   retnum := retnum + SQL%ROWCOUNT;
   delete from tab_cols_act where tables_nk1 = app_abbr_in;
   retnum := retnum + SQL%ROWCOUNT;
   delete from tables_act where applications_nk1 = app_abbr_in;
   retnum := retnum + SQL%ROWCOUNT;
   delete from domain_values_act where domains_nk1 = app_abbr_in;
   retnum := retnum + SQL%ROWCOUNT;
   delete from domains_act where applications_nk1 = app_abbr_in;
   retnum := retnum + SQL%ROWCOUNT;
   delete from file_lines_act where files_nk1 = app_abbr_in;
   retnum := retnum + SQL%ROWCOUNT;
   delete from files_act where applications_nk1 = app_abbr_in;
   retnum := retnum + SQL%ROWCOUNT;
   delete from applications_act where abbr = app_abbr_in;
   return retnum;
end delete_app;
----------------------------------------
procedure delete_files
      (app_abbr_in  in  varchar2)
is
begin
   delete from file_lines_act
    where files_nk1 = app_abbr_in;
   delete from files_act
    where applications_nk1 = app_abbr_in;
end delete_files;
----------------------------------------
begin
   aa_vc2('install_db') := vc2_list_type
      ('create_glob'
      ,'create_ods'
      ,'create_integ'
      ,'create_oltp'
      ,'create_aa'
      ,'create_mods');
   aa_vc2('uninstall_db') := vc2_list_type
      ('drop_mods'
      ,'drop_aa'
      ,'drop_oltp'
      ,'drop_integ'
      ,'drop_ods'
      ,'drop_glob');
   aa_vc2('install_mt') := vc2_list_type
      ('create_gdst'
      ,'create_dist'
      ,'create_oltp'
      ,'create_mods');
   aa_vc2('uninstall_mt') := vc2_list_type
      ('drop_mods'
      ,'drop_oltp'
      ,'drop_dist'
      ,'drop_gdst');
   aa_vc2('install_gui') := vc2_list_type
      ('create_flow');
   aa_vc2('install_usr') := vc2_list_type
      ('create_gusr'
      ,'create_usyn');
   aa_vc2('uninstall_usr') := vc2_list_type
      ('drop_usyn'
      ,'drop_gusr');
END dtgen_util;
