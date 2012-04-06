create or replace
package util
is

   -- Package Util
   --    Utility settings and functions
   --    (A copy is located locally on a each node)
   --
   --    Generated by DTGen (http://code.google.com/p/dtgen)
   --    April     02, 2012  04:02:19 PM

   -- request_lock: A lock is already held by the GLOB package
   -- release_lock: No lock is currently held by the GLOB package
   LOCK_ERROR     CONSTANT INTEGER := -1;
   -- Lock function was successful
   LOCK_SUCCESS   CONSTANT INTEGER := 0;
   -- request_lock only.  Not applicable for release_lock
   LOCK_TIMEOUT   CONSTANT INTEGER := 1;
   -- request_lock only.  Not applicable for release_lock
   LOCK_DEADLOCK  CONSTANT INTEGER := 2;
   LOCK_PARM_ERR  CONSTANT INTEGER := 3;
   -- request_lock: Already own lock specified
   -- release_lock: Do not own lock specified
   LOCK_OWN_ID    CONSTANT INTEGER := 4;
   -- Illegal lock handle
   LOCK_ILLEGAL   CONSTANT INTEGER := 5;

   -- Separates values within a set of Natural Keys
   nk_sep  constant varchar2(1) := ',';
   -- Separates values in a path hierarchy
   path_sep  constant varchar2(1) := ':';

   -- TRUE - gen_no_change error is ignored during UPDATE
   -- FALSE - gen_no_change error is enforced during UPDATE
   ignore_no_change  boolean := true;

   first_dtm  constant timestamp with time zone :=
        to_timestamp_tz('1970-01-01 00:00:00 UTC','YYYY-MM-DD HH24:MI:SS TZR');
   last_dtm   constant timestamp with time zone :=
        to_timestamp_tz('4713-12-31 23:59:59 UTC','YYYY-MM-DD HH24:MI:SS TZR');

   asof_dtm  timestamp with time zone :=
        to_timestamp_tz('2011-01-01 00:00:00 UTC','YYYY-MM-DD HH24:MI:SS TZR');

   current_usr varchar2(30);

   function get_version
      return varchar2;

   function get_first_dtm
      return timestamp with time zone;
   function get_last_dtm
      return timestamp with time zone;

   procedure set_asof_dtm
         (asof_dtm_in  in  timestamp with time zone
         );
   function get_asof_dtm
      return timestamp with time zone;

   function is_equal
         (t1_in  in  varchar2
         ,t2_in  in  varchar2
         )
      return boolean;
   function is_equal
         (n1_in  in  number
         ,n2_in  in  number
         )
      return boolean;

   procedure set_usr
         (usr_in  in  varchar2
         );
   function get_usr
      return varchar;

   procedure init_longops
         (opname_in       in  varchar2
         ,totalwork_in    in  number
         ,target_desc_in  in  varchar2
         ,units_in        in  varchar2);
   procedure add_longops
         (add_sofar_in  in  number);
   procedure end_longops;

   procedure log
         (txt_in  in  varchar2
         ,loc_in  in  varchar2 default null
         );
   procedure err
         (txt_in  in  varchar2
         );

   function db_object_exists
         (name_in  in  varchar2
         ,type_in  in  varchar2
         )
     return boolean;

   function col_to_clob
         (col_in  in  col_type
         )
     return clob;
   function col_data
         (col_in   in  col_type
         ,name_in  in  varchar2
         )
     return varchar2;

end util;