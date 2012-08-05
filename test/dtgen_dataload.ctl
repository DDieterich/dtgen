--
-- DTGen SQL*Loader Control File
--    Full data dump of the DTGEN application
--
--    Generated by DTGen (http://code.google.com/p/dtgen)
--    August    03, 2012  02:52:54 PM
--
-- sqlldr username/password CONTROL=FILENAME
--
--options (rows=1)
--, copyright CHAR (32000)
--THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
load data infile *
into table APPLICATIONS_ACT APPEND when key = 'APPLICATIONS                  ' fields terminated by ''
   (key FILLER position(1:31), abbr CHAR, name CHAR, db_schema CHAR, db_schema_exp CHAR, apex_schema CHAR, apex_ws_name CHAR, apex_app_name CHAR, dbid CHAR, db_auth CHAR, description CHAR, ts_null_override CHAR, ts_onln_data CHAR, ts_onln_indx CHAR, ts_hist_data CHAR, ts_hist_indx CHAR, usr_datatype CHAR, usr_frgn_key CHAR)
into table DOMAINS_ACT APPEND when key = 'DOMAINS                       ' fields terminated by ''
   (key FILLER position(1:31), applications_nk1 CHAR, abbr CHAR, name CHAR, fold CHAR, len FLOAT EXTERNAL, description CHAR)
into table EXCEPTIONS_ACT APPEND when key = 'EXCEPTIONS                    ' fields terminated by ''
   (key FILLER position(1:31), applications_nk1 CHAR, code FLOAT EXTERNAL, name CHAR, message CHAR, cause CHAR, action CHAR)
into table PROGRAMS_ACT APPEND when key = 'PROGRAMS                      ' fields terminated by ''
   (key FILLER position(1:31), applications_nk1 CHAR, name CHAR, type CHAR, description CHAR)
into table TABLES_ACT APPEND when key = 'TABLES                        ' fields terminated by ''
   (key FILLER position(1:31), applications_nk1 CHAR, abbr CHAR, name CHAR, seq FLOAT EXTERNAL, type CHAR, group_name CHAR, mv_refresh_hr FLOAT EXTERNAL, ts_onln_data CHAR, ts_onln_indx CHAR, ts_hist_data CHAR, ts_hist_indx CHAR, description CHAR)
into table CHECK_CONS_ACT APPEND when key = 'CHECK_CONS                    ' fields terminated by ''
   (key FILLER position(1:31), tables_nk1 CHAR, tables_nk2 CHAR, seq FLOAT EXTERNAL, text CHAR, description CHAR)
into table DOMAIN_VALUES_ACT APPEND when key = 'DOMAIN_VALUES                 ' fields terminated by ''
   (key FILLER position(1:31), domains_nk1 CHAR, domains_nk2 CHAR, seq FLOAT EXTERNAL, value CHAR, description CHAR)
into table TAB_COLS_ACT APPEND when key = 'TAB_COLS                      ' fields terminated by ''
   (key FILLER position(1:31), tables_nk1 CHAR, tables_nk2 CHAR, name CHAR, seq FLOAT EXTERNAL, nk FLOAT EXTERNAL, req CHAR, fk_prefix CHAR, fk_tables_nk1 CHAR, fk_tables_nk2 CHAR, d_domains_nk1 CHAR, d_domains_nk2 CHAR, type CHAR, len FLOAT EXTERNAL, scale FLOAT EXTERNAL, fold CHAR, default_value CHAR, upd_res_pct FLOAT EXTERNAL, description CHAR)
into table INDEXES_ACT APPEND when key = 'INDEXES                       ' fields terminated by ''
   (key FILLER position(1:31), tab_cols_nk1 CHAR, tab_cols_nk2 CHAR, tab_cols_nk3 CHAR, tag CHAR, seq FLOAT EXTERNAL)
BEGINDATA
APPLICATIONS                  DTGENDtgen For OracleDTGENDTGENDTGENDTGen&1.&2.Generates Oracle PL/SQL code and APEX User Interfaces
DOMAINS                       DTGENCTYPEColumn TypeU30Column Data type (number, varchar2, etc...)
DOMAINS                       DTGENFLAGFlagU1Flagged
DOMAINS                       DTGENFOLDCase FoldU1Upper case character fold
DOMAINS                       DTGENFTYPEFile TypeU3Type of File
DOMAINS                       DTGENPTYPEProgram TypeU30Type of Program
DOMAINS                       DTGENTTYPETable TypeU3An effectivity table type with begin and end timestamps
DOMAINS                       DTGENYNYes NoU1Yes, true, correct, or affirmative
EXCEPTIONS                    DTGEN-20014gen_many_updatesGEN_MRU updated %i rows for ID %iGenerated Multi-Row Update updated more than 1 row for a given IDCorrect the duplicate primary key ID.
EXCEPTIONS                    DTGEN-20013gen_tseq_orderload_nk_aa(): %s must precede %s in ascending table sequence.A Foreign Key Table with a larger sequence number has been referenced by a Table.Correct the table sequence order.
EXCEPTIONS                    DTGEN-20012gen_apex_initAPEX: %s is null.Initialization data was not found during an APEX import.Initialization values could be incorrect, or APEX has not been properly loaded on target system.
EXCEPTIONS                    DTGEN-20011gen_apex_nfndAPEX: Unable to find %sAPEX data was not found during an import.Import parameter values could be incorrect, or APEX has not been properly loaded on target system.
EXCEPTIONS                    DTGEN-20010gen_mv_dml%s not allowed on materialized view %sData Modification Language (Insert, Update, or Delete) cannot be performed on a Materialized View.Attempt the Data Modification Language (DML) on the database node instead of a Mid-Tier node.
EXCEPTIONS                    DTGEN-20009gen_early_date%s.%s(): The new %s date must be greater than %sThe new date value of the data item precedes its previous value.Ensure the new data value for the data occurs after its current date/time value.
EXCEPTIONS                    DTGEN-20008gen_no_change%s.upd(): Must update one of %s.An attempt was made to update data in a table, but the minimum requirement to change one data value was not met (EFF_BEG_DTM is not considered a data value).Modify the data value of another data item before attempting the update.
EXCEPTIONS                    DTGEN-20007gen_future_date%s.check_rec(): %s cannot be in the future.The data item cannot have a date value that is in the future.Change the date value of the data item to an earlier date/time.
EXCEPTIONS                    DTGEN-20006gen_cust_cons%s.check_rec(): %sCustom ConstraintComply with Constraint
EXCEPTIONS                    DTGEN-20005gen_not_in%s.check_rec(): %s must be one of (%s).The data item does not have a value from the list provided.Provide a value from the list for the this data item.
EXCEPTIONS                    DTGEN-20004gen_null_found%s.check_rec(): %s cannot be null.The data item cannot be null.Provide a value for this data item.
EXCEPTIONS                    DTGEN-20003gen_bad_case%s.check_rec(): %s must be %s case.The letter case of a string has failed to meet the requirement listed.Modifiy the string to conform to the letter case requirement.
EXCEPTIONS                    DTGEN-20002gen_no_userCurrent user has not been set in the %s Package.A call to UTIL.GET_USR was made before a call to UTIL.SET_USR gave a value for the username.Set the username by calling UTIL.SET_USR with a valid value.
EXCEPTIONS                    DTGEN-20001gen_pop_updatepop_audit_bu(): Updates are not allowed.An attempt was made to update data in the POP_AUDIT table.Updates to POP_AUDIT data are not allowed.
PROGRAMS                      DTGENassemblePACKAGEAssembles Install/Uninstall Scripts from Generated Scripts
PROGRAMS                      DTGENgeneratePACKAGEMain Generation Program Unit
TABLES                        DTGENAPPapplications1NONEXTRAApplications to be generated
TABLES                        DTGENFfiles2NONEXTRAFiles for capturing scripts and logs
TABLES                        DTGENFLfile_lines3NONEXTRALines for files
TABLES                        DTGENDOMdomains4NONMAINData domains to be generated as check constraints and/or lists of values for selected columns
TABLES                        DTGENDVdomain_values5NONMAINData domains values for the data domains
TABLES                        DTGENTABtables6NONMAINTables to be generated for each application
TABLES                        DTGENCOLtab_cols7NONMAINColumns to be generated for each table
TABLES                        DTGENINDindexes8NONMAINUnique and non-unique indexes for this table
TABLES                        DTGENCKcheck_cons9NONMAINCheck constraints to be generated for each table
TABLES                        DTGENPRGprograms10NONEXTRAPrograms Registered to Run with the Application
TABLES                        DTGENEXCexceptions11NONEXTRAApplication Exceptions for Error Trapping
CHECK_CONS                    DTGENAPP1instr(db_schema,' ') = 0DB schema name cannot have spaces
CHECK_CONS                    DTGENAPP2instr(apex_schema,' ') = 0APEX schema name cannot have spaces
CHECK_CONS                    DTGENAPP3instr(dbid,' ') = 0Database ID cannot have spaces
CHECK_CONS                    DTGENAPP4db_auth is null or dbid is not nullDatabase ID must not be NULL if Database Authentication is not NULL
CHECK_CONS                    DTGENAPP5db_schema_exp is null or db_schema is not nullDatabase Schema Name must not be NULL if Database Schema Explicit Flag is not NULL
CHECK_CONS                    DTGENCK1seq > 0Check constraint sequence must be greater than 0
CHECK_CONS                    DTGENCOL1instr(name,' ') = 0Column name cannot have spaces
CHECK_CONS                    DTGENCOL2name not in ('id', 'eff_beg_dtm', 'eff_end_dtm', 'aud_beg_usr', 'aud_end_usr', 'aud_beg_dtm', 'aud_end_dtm', 'last_active')Column name cannot be one of 'id', 'eff_beg_dtm', 'eff_end_dtm', 'aud_beg_usr', 'aud_end_usr', 'aud_beg_dtm', 'aud_end_dtm', or 'last_active'
CHECK_CONS                    DTGENCOL3seq > 0Column sequence must be greater than 0
CHECK_CONS                    DTGENCOL4nk > 0Column natural key must be greater than 0
CHECK_CONS                    DTGENCOL5fk_table_id is not null or d_domain_id is not null or type is not nullOne of FK_TABLE_ID, D_DOMAIN_ID, or TYPE must have a value in columns
CHECK_CONS                    DTGENCOL6fk_table_id is null or d_domain_id is nullFK_TABLE_ID and D_DOMAIN_ID cannot both have a value in columns
CHECK_CONS                    DTGENCOL7d_domain_id is null or type is nullD_DOMAIN_ID and TYPE cannot both have a value in columns
CHECK_CONS                    DTGENCOL8fk_table_id is null or type is nullFK_TABLE_ID and TYPE cannot both have a value in columns
CHECK_CONS                    DTGENCOL9fk_prefix is null or (fk_prefix is not null and fk_table_id is not null)Column fk_prefix must be null unless column fk_table_id has a value
CHECK_CONS                    DTGENCOL10len is not null or type != 'VARCHAR2'Len cannot be NULL if type is VARCHAR2
CHECK_CONS                    DTGENCOL11len is null or (len between 1 and 39 and type = 'NUMBER') or type != 'NUMBER'Len (NUMBER precision) must be between 1 and 39
CHECK_CONS                    DTGENCOL12len is null or (len between 1 and 32767 and type = 'VARCHAR2') or type != 'VARCHAR2'Len (VARCHAR2 length) must be between 1 and 32767
CHECK_CONS                    DTGENCOL13len is null or (len between 0 and 9 and type in ('TIMESTAMP WITH TIME ZONE', 'TIMESTAMP WITH LOCAL TIME ZONE')) or type not in ('TIMESTAMP WITH TIME ZONE', 'TIMESTAMP WITH LOCAL TIME ZONE')Len (TIMESTAMP fractional seconds digits) must be between 0 and 9
CHECK_CONS                    DTGENCOL14scale is null or (type = 'NUMBER' and len is not null)Scale must be null unless column type is NUMBER and len is not NULL
CHECK_CONS                    DTGENCOL15scale is null or scale between -84 and 127Scale must be between -84 and 127, or NULL
CHECK_CONS                    DTGENCOL16fold is null or (type = 'VARCHAR2' and type is not null)Column fold must be null unless type is VARCHAR2
CHECK_CONS                    DTGENCOL17nk is null or fk_table_id != table_idSelf-referencing foreign keys (hierarchies) cannot be part of the natural key
CHECK_CONS                    DTGENDOM1len > 0Domain data value length must be greater than 0
CHECK_CONS                    DTGENDV1seq > 0Domain data value sequence number must be greater than 0
CHECK_CONS                    DTGENEXC1code between -20999 and -20000Exception code must be between -20999 and -20000
CHECK_CONS                    DTGENEXC2instr(name,' ') = 0Exception name cannot have spaces
CHECK_CONS                    DTGENIND1seq > 0Index column sequence must be greater than 0
CHECK_CONS                    DTGENPRG1instr(name,' ') = 0Stored Program Unit Name cannot have spaces
CHECK_CONS                    DTGENTAB1instr(abbr,' ') = 0Table abbreviation cannot have spaces
CHECK_CONS                    DTGENTAB2instr(name,' ') = 0Table name cannot have spaces
CHECK_CONS                    DTGENTAB3seq > 0Table sequence number must be greater than 0
CHECK_CONS                    DTGENTAB4seq < 200Table sequence number must be less than 200 because of the â€œpnumâ€ offsets in the generator package
CHECK_CONS                    DTGENTAB5mv_refresh_hr > 0Materialized View Refresh Hours must be greater than 0
CHECK_CONS                    DTGENTAB6instr(ts_onln_data,' ') = 0On-line data table space name cannot have spaces for a table
CHECK_CONS                    DTGENTAB7instr(ts_onln_indx,' ') = 0On-line index table space name cannot have spaces for a table
CHECK_CONS                    DTGENTAB8instr(ts_hist_data,' ') = 0History data table space name cannot have spaces for a table
CHECK_CONS                    DTGENTAB9instr(ts_hist_indx,' ') = 0History index table space name cannot have spaces for a table
DOMAIN_VALUES                 DTGENCTYPE1NUMBERA numeric data type
DOMAIN_VALUES                 DTGENCTYPE2VARCHAR2A character data type
DOMAIN_VALUES                 DTGENCTYPE3DATEA date/time data type
DOMAIN_VALUES                 DTGENCTYPE4TIMESTAMP WITH TIME ZONEA date/time data type with time zone
DOMAIN_VALUES                 DTGENCTYPE5TIMESTAMP WITH LOCAL TIME ZONEA date/time data type with local time zone
DOMAIN_VALUES                 DTGENFLAG1XFlagged
DOMAIN_VALUES                 DTGENFOLD1UUpper case character fold
DOMAIN_VALUES                 DTGENFOLD2LLower case character fold
DOMAIN_VALUES                 DTGENFOLD3IInitial capital case character fold
DOMAIN_VALUES                 DTGENFTYPE1SQLSQL Script
DOMAIN_VALUES                 DTGENFTYPE2LOGLog File
DOMAIN_VALUES                 DTGENPTYPE1PACKAGEIncludes Package Specification and Package Body
DOMAIN_VALUES                 DTGENPTYPE2FUNCTIONStored Function outside of a Package
DOMAIN_VALUES                 DTGENPTYPE3PROCEDUREStored Procedure outside of a Package
DOMAIN_VALUES                 DTGENTTYPE1EFFA historical table type with effective/audit begin/end timestamps and begin/end user recording
DOMAIN_VALUES                 DTGENTTYPE2LOGAn audit table type with audit only begin/end timestamps and begin/end user recording
DOMAIN_VALUES                 DTGENTTYPE3NONA none or nothing table type without begin/end timestamps or begin/end user recording
DOMAIN_VALUES                 DTGENYN1YYes, true, correct, or affirmative
DOMAIN_VALUES                 DTGENYN2NNo, false, incorrect, or negative
TAB_COLS                      DTGENAPPabbr11XVARCHAR25UAbbreviation for this application
TAB_COLS                      DTGENAPPname2XVARCHAR230IName of this application
TAB_COLS                      DTGENAPPdb_schema3VARCHAR230U50Name of the database schema objects owner. Used for user synonym and DB Link creation. Also used for explicit owner of all database objects if db_schema_exp flag is set.
TAB_COLS                      DTGENAPPdb_schema_exp4DTGENFLAG50Explicitly define the schema owner for all database object
TAB_COLS                      DTGENAPPapex_schema5VARCHAR230U50Name of the APEX parsing schema owner for the generated APEX pages
TAB_COLS                      DTGENAPPapex_ws_name6VARCHAR230U50Workspace name (Upper Case) for the generated APEX pages
TAB_COLS                      DTGENAPPapex_app_name7VARCHAR23050Application name (Mixed Case) for the generated APEX pages
TAB_COLS                      DTGENAPPdbid8VARCHAR2200050Database link connect string for mid-tier connections to the centralized database server.
TAB_COLS                      DTGENAPPdb_auth9VARCHAR220050Database link authorization for mid-tier connections to the centralized database server
TAB_COLS                      DTGENAPPdescription10VARCHAR2100040Description of this application
TAB_COLS                      DTGENAPPts_null_override11DTGENFLAGFlag to override all tablespace names to null
TAB_COLS                      DTGENAPPts_onln_data12VARCHAR230L70Default tableapace name for on-line data tables
TAB_COLS                      DTGENAPPts_onln_indx13VARCHAR230L70Default tablespace name for on-line indexes
TAB_COLS                      DTGENAPPts_hist_data14VARCHAR230L70Default tablespace name for history data tables
TAB_COLS                      DTGENAPPts_hist_indx15VARCHAR230L70Default tablespace name for history indexes
TAB_COLS                      DTGENAPPusr_datatype18VARCHAR220U50Datatype for the "_USR" data columns in history tables tables. The default value is VARCHAR2(30).
TAB_COLS                      DTGENAPPusr_frgn_key19VARCHAR2100L50Foreign Key for the "_USR" data columns in history tables. Must be of the form "table", "schema.table", "table(column)",  or "schema.table(column)".
TAB_COLS                      DTGENAPPcopyright20VARCHAR23200050Copyright notice that is placed in the comment header in all generated scripts
TAB_COLS                      DTGENCKtable_id11XDTGENTABSurrogate Key for the table of this check constraint
TAB_COLS                      DTGENCKseq22XNUMBER2Sequence number of this check constraint
TAB_COLS                      DTGENCKtext3XVARCHAR21000Execution (PL/SQL) text for this check constraint
TAB_COLS                      DTGENCKdescription4VARCHAR21000Description of this check constraint
TAB_COLS                      DTGENCOLtable_id11XDTGENTABSurrogate Key for the table of this column
TAB_COLS                      DTGENCOLname22XVARCHAR225LName of this column
TAB_COLS                      DTGENCOLseq3XNUMBER2Sequence number for this column
TAB_COLS                      DTGENCOLnk4NUMBER1Natural key sequence number for this column.  Implies this column requires data (not null).
TAB_COLS                      DTGENCOLreq5DTGENFLAGFlag to indicate if this column is required
TAB_COLS                      DTGENCOLfk_prefix6VARCHAR24LForeign key prefix for multiple foreign keys to the same table
TAB_COLS                      DTGENCOLfk_table_id7fk_DTGENTABSurrogate Key for the foreign key table of this column
TAB_COLS                      DTGENCOLd_domain_id8d_DTGENDOMSurrogate Key for the domain of this column
TAB_COLS                      DTGENCOLtype9DTGENCTYPEType for this column
TAB_COLS                      DTGENCOLlen10NUMBER5The total number of significant decimal digits in a number, or the length of a string, or the number of digits for fractional seconds in a timestamp
TAB_COLS                      DTGENCOLscale11NUMBER3The number of digits from the decimal point to the least significant digit
TAB_COLS                      DTGENCOLfold12DTGENFOLDFlag to indicate if this column should be character case folded
TAB_COLS                      DTGENCOLdefault_value13VARCHAR21000Default Value if no value is provided for this column
TAB_COLS                      DTGENCOLupd_res_pct14NUMBER2040Percentage of column space reserved for data updates
TAB_COLS                      DTGENCOLdescription15VARCHAR2100040Description for this column
TAB_COLS                      DTGENDOMapplication_id11XDTGENAPPSurrogate Key for the application of this data domain
TAB_COLS                      DTGENDOMabbr22XVARCHAR25UName of this data domain
TAB_COLS                      DTGENDOMname3XVARCHAR220IName of this data domain
TAB_COLS                      DTGENDOMfold4XDTGENFOLDValue of this sequence in this data domain
TAB_COLS                      DTGENDOMlen5XNUMBER2Value of this sequence in this data domain
TAB_COLS                      DTGENDOMdescription6VARCHAR2100040Description of this data domain value
TAB_COLS                      DTGENDVdomain_id11XDTGENDOM1Surrogate Key for the application of this data domain
TAB_COLS                      DTGENDVvalue22XVARCHAR2100Value of this sequence in this data domain
TAB_COLS                      DTGENDVseq3XNUMBER2Sequence number for this value in this data domain
TAB_COLS                      DTGENDVdescription4VARCHAR2100040Description of this data domain value
TAB_COLS                      DTGENEXCapplication_id11XDTGENAPPSurrogate Key for the application of this exception
TAB_COLS                      DTGENEXCcode22XNUMBER5RAISE_APPLICATION_ERROR Code for this exception
TAB_COLS                      DTGENEXCname3XVARCHAR230LPRAGMA EXCEPTION_INIT Name for this exception
TAB_COLS                      DTGENEXCmessage4VARCHAR22048Error Message for this exception
TAB_COLS                      DTGENEXCcause5VARCHAR2204840Error Cause for this exception
TAB_COLS                      DTGENEXCaction6VARCHAR2204840Possible Solution for this exception
TAB_COLS                      DTGENFapplication_id11XDTGENAPP1Surrogate Key for the application of this file
TAB_COLS                      DTGENFname22XVARCHAR2301Name of this file
TAB_COLS                      DTGENFtype3XDTGENFTYPE1Type for this file
TAB_COLS                      DTGENFcreated_dt4XDATE1Time/Date this file was created
TAB_COLS                      DTGENFdescription5VARCHAR210001Description for this file
TAB_COLS                      DTGENFLfile_id11XDTGENF1Surrogate Key for the file of this line
TAB_COLS                      DTGENFLseq22XNUMBER91Sequence number for this line in the file
TAB_COLS                      DTGENFLvalue3VARCHAR210001Value or contents of this line in the file
TAB_COLS                      DTGENINDtab_col_id11XDTGENCOLSurrogate Key for the column for this index
TAB_COLS                      DTGENINDtag22XVARCHAR24LTag attached to the table name for this column that uniquely identifies this index
TAB_COLS                      DTGENINDseq33XNUMBER1Sequence number for this column for this index
TAB_COLS                      DTGENPRGapplication_id11XDTGENAPPSurrogate Key for the application of this Shared Program Unit
TAB_COLS                      DTGENPRGname22XVARCHAR230LName of this Stored Program Unit
TAB_COLS                      DTGENPRGtype3XDTGENPTYPEType of this Stored Program Unit
TAB_COLS                      DTGENPRGdescription4VARCHAR21000Description of this Stored Program Unit
TAB_COLS                      DTGENTABapplication_id11XDTGENAPPSurrogate Key for the application of this table
TAB_COLS                      DTGENTABabbr22XVARCHAR25UAbbreviation for this table
TAB_COLS                      DTGENTABname3XVARCHAR215LName of this table
TAB_COLS                      DTGENTABseq4XNUMBER2Report order for this table
TAB_COLS                      DTGENTABtype5XDTGENTTYPEType of this table
TAB_COLS                      DTGENTABgroup_name6VARCHAR230UGroup Name for this table.
TAB_COLS                      DTGENTABmv_refresh_hr7NUMBER31Number of Hours between Materialized View Refresh
TAB_COLS                      DTGENTABts_onln_data8VARCHAR230L40Tablespace name for the on-line data for this table
TAB_COLS                      DTGENTABts_onln_indx9VARCHAR230L40Tablespace name for the on-line indexes for this table
TAB_COLS                      DTGENTABts_hist_data10VARCHAR230L40Tablespace name for the history data for this table
TAB_COLS                      DTGENTABts_hist_indx11VARCHAR230L40Tablespace name for the history indexes for this table
TAB_COLS                      DTGENTABdescription12VARCHAR2100040Description of this table
INDEXES                       DTGENAPPnameux11
INDEXES                       DTGENCOLtable_idux11
INDEXES                       DTGENCOLsequx12
INDEXES                       DTGENDOMapplication_idux11
INDEXES                       DTGENDOMnameux12
INDEXES                       DTGENDVdomain_idux11
INDEXES                       DTGENDVsequx12
INDEXES                       DTGENEXCapplication_idux21
INDEXES                       DTGENEXCnameux22
INDEXES                       DTGENTABapplication_idux11
INDEXES                       DTGENTABnameux12
INDEXES                       DTGENTABapplication_idux21
INDEXES                       DTGENTABsequx22
