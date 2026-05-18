create or replace package pkg_sample authid current_user
-- This is an example of a package description.
--
-- Line breaks are ignored but blank lines results in paragraphs.
is
  pragma deprecate(pkg_sample, 'PKG_SAMPLE has been deprecated, use ... instead.');

  -- This is an example of a procedure description.
  procedure p_noop;
  pragma deprecate (p_noop);

  -- Function for square a number.  
  -- The return value is the result of multiplying the parameter by itself.
  -- @A numeric value.
  -- The square of any non-zero real number, whether positive or negative, is
  -- always a positive number.
  -- ^select pkg_sample.f_square from dual;
  -- ^
  --select pkg_sample.f_square(4)
  --  from dual;
  -- ^begin
  --  dbms_output.put_line( 'square of 2 is '||f_square(2) );
  --end;
  function f_square(i_value number default 3) return number;

  -- This is an example of a constant description.
  c_magic_number constant integer := 1704;

  -- This is an example of an exception description.
  e_parsing_failed exception; 
  pragma deprecate (e_parsing_failed, 'PKG_SAMPLE.E_PARSING_FAILED is deprecated, use ... instead.');

  -- This is an example of an associative array description.
  -- It was formerly called PL/SQL table or index-by table.
  type t_number_aa is table of number index by varchar2(64 char); 
  -- This is an example of a varray (variable-size array) description.
  type t_number_va is varray(5) of number;
  -- This is an example of a nested table description.
  type t_number_nt is table of number;

  -- This is an example of an user-defined record type description.
  -- @The name of the operating system.
  -- @Processor type of the system (in bit).
  type t_os_r is record (
      platform     varchar2(64 char),
      architecture integer
  );
end pkg_sample;