create or replace package generate
as

/************************************************************
DTGEN "generate" Package Specification

Copyright (c) 2011, Duane.Dieterich@gmail.com
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
************************************************************/

   TYPE cr_nt_type IS TABLE
      OF varchar2(80);
   cr_nt  cr_nt_type;

   TYPE line_rec_type is RECORD
      (value file_lines.value%TYPE
      );
   TYPE line_t_type IS TABLE
      OF line_rec_type;
   FUNCTION exception_lines
      RETURN line_t_type PIPELINED;

   TYPE tab_col_va_type IS VARRAY(10)   -- Array of 10 TAB_COLS%ROWTYPE
      OF tab_cols%rowtype;
   TYPE fk_tid_va_type IS VARRAY(10)   -- Array of 10 FK_TABLE_IDs
      OF tab_cols.fk_table_id%type;

   TYPE nk_aa_rec_type IS RECORD   -- A TABLES%ROWTYPE with 10 TAB_COLS%ROWTYPE
      (tbuff           tables%rowtype
      ,cbuff_va        tab_col_va_type
      ,lvl1_fk_tid_va  fk_tid_va_type
      );
   TYPE nk_aa_type IS TABLE       -- Associative Array of TABLES%ROWTYPE
      OF nk_aa_rec_type           --   Each of which have 10 TAB_COLS%ROWTYPE
      INDEX BY PLS_INTEGER;

   nk_aa  nk_aa_type;

   TYPE sec_lines_type IS TABLE
      OF VARCHAR2(4000) INDEX BY PLS_INTEGER;

   procedure init
         (app_abbr_in  in  varchar2);

   -- Drop/Delete Scripts
   procedure drop_usyn;
   procedure drop_mods;
   procedure drop_aa;
   procedure drop_oltp;
   procedure drop_dist;
   procedure drop_integ;
   procedure drop_ods;
   -- Global Drop/Delete Scripts
   procedure drop_gusr;
   procedure drop_gdst;
   procedure drop_glob;

   -- Global Create Scripts
   procedure create_glob;
   procedure create_gdst;
   procedure create_gusr;
   -- Create Scripts
   procedure create_ods;
   procedure create_integ;
   procedure create_dist;
   procedure create_oltp;
   procedure create_aa;
   procedure create_mods;
   procedure create_usyn;

   -- Create GUI Script
   procedure create_flow;

end generate;
