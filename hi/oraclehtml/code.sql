-- FINAL :) -----
clear screen
set serveroutput on
set feedback off
declare
  c_website_instead_of_only_html_code constant boolean:=true;
  c_package_name constant dbms_id_30:='PKG_SAMPLE';
--  c_package_name constant dbms_id_30:='APEX_CSS_MODIFIED';
  c_html_skeleton constant clob:=q'[<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="description" content="">
  <meta name="keywords" content="Technical documentation for PL/SQL package ]'||c_package_name||q'[.">
  <meta name="author" content="ora* CODECOP -- https://github.com/yerba1704/ocd">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>]'||c_package_name||q'[</title>  
</head>
<body>
  <main>
    <article>
<!-- generated code by ora* CODECOP -->
§    </article>
  </main>
</body>
</html>
]';
  l_constants_not_yet_started boolean:=true;
  l_types_not_yet_started boolean:=true;
  l_exceptions_not_yet_started boolean:=true;
  l_html clob;
  cursor pkg_info is
    select toc_oradb,toc_apex,srt,
           listagg( distinct '<li>'||htf.anchor('#'||upper(replace(toc_oradb,' ')),toc_oradb)||'</li>'||chr(10) ) within group(order by toc_oradb) over (partition by 1) as tocinfo_oradb,
           listagg( distinct '<li>'||htf.anchor('#'||upper(replace(toc_apex,' ')),toc_apex)||'</li>'||chr(10) ) within group(order by toc_apex) over (partition by 1) as tocinfo_apex,
           package_name,package_desc,
           component_name, component_type, component_desc, component_syntax, component_index,
           case when srt=lead(srt,1) over (order by srt) then 0 else 1 end as last_component_type_fl,
           case when any_value(parameter_count) is not null then
            '<table><tr><th>Parameter</th><th>Description</th></tr>'||
              listagg('<tr>'||htf.tabledata(parameter_name)||htf.tabledata(parameter_desc)||'</tr>') within group (order by parameter_index)||
            '</table>'
           end as parameterinfo,
           any_value(parameter_count) as parameter_count,
           case when any_value(example_count) is not null then
            listagg('<p>'||example_name||'</p>'||htf.code(example_code)) within group (order by parameter_index)
           end as exampleinfo,
           any_value(example_count) as example_count
      from (
        select case component_type
                when 'CONSTANT'   then 'Constants'
                when 'EXCEPTION'  then 'Exceptions'
                when 'TYPE'       then 'Data Types'
                when 'PROCEDURE'  then 'Summary of '||package_name||' Subprograms'
                when 'FUNCTION'   then 'Summary of '||package_name||' Subprograms'
                  else '?'
               end as toc_oradb,
               case component_type
                when 'CONSTANT'   then 'Constants'
                when 'EXCEPTION'  then 'Exceptions'
                when 'TYPE'       then 'Data Types'
                                  else component_name||' '||initcap(component_type)||
                                       case when count(distinct component_index) over (partition by component_name)>1 then ' Signature '||rank() over (partition by component_name order by component_index)
                                       end
               end as toc_apex,
               case component_type
                when 'CONSTANT' then '10'
                when 'EXCEPTION'then '20'
                when 'TYPE'     then '30'
                                else component_name||' '||initcap(component_type)||
                                     case when count(distinct component_index) over (partition by component_name)>1 then ' Signature '||rank() over (partition by component_name order by component_index)
                                     end
               end as srt,
               jsn.*,
               max(parameter_index) over (partition by component_index) as parameter_count,
               max(example_index) over (partition by component_index) as example_count
          from json_table (
                ocd.api.information(c_package_name),
                '$' columns (
                  package_name varchar2(  30 char) path '$.name',
                  package_desc varchar2(4000 char) path '$.desc',
                  nested '$.components[*]' columns (
                    component_name   varchar2(  30 char) path '$.name',
                    component_type   varchar2(  30 char) path '$.type',
                    component_desc   varchar2(4000 char) path '$.desc',
                    component_syntax varchar2(4000 char) path '$.syntax',
                    component_index for ordinality,
                    nested '$.parameters[*]' columns (
                      parameter_name varchar2(  30 char) path '$.name',
                      parameter_desc varchar2(4000 char) path '$.desc',
                      parameter_index for ordinality
                    ),
                    nested '$.examples[*]' columns (
                      example_name varchar2(  30 char) path '$.name',
                      example_code varchar2(4000 char) path '$.code',
                      example_index for ordinality
                    )
                  )
                )
               ) jsn
    ) sub
    group by toc_oradb, toc_apex, srt, package_name, package_desc, component_name, component_type, component_desc, component_syntax, component_index
    order by srt;
  ---------
  procedure attach(i_html in varchar2) is begin l_html:=l_html||i_html||chr(10); end attach;
begin
  /* Reference: https://docs.oracle.com/en/database/oracle/apex/24.2/aeapi/APEX_AI.html */
  for i in pkg_info loop
    -- toc
    if l_html is null then
      attach( htf.header(1,i.package_name) );     -- h1   <packagename>
      attach( '<p>'||i.package_desc||'</p>' );    -- p    <packagedesc>
      attach( htf.ulistopen );                    -- ul
      attach( rtrim(i.tocinfo_apex,chr(10)) );    --  li+a <tocinfo>
      attach( htf.ulistclose );                   -- ul
    end if;

      if i.component_type in ('CONSTANT') then
        if l_constants_not_yet_started then
          attach( htf.header (nsize=>2,cheader=>i.toc_apex,cattributes=>'id="'||upper(replace(i.toc_apex,' '))||'"') );
          attach( '<p>The '||c_package_name||' package defines several constants for specifying parameter values.</p>' );
          attach( '<table><tr><th>Name</th><th>Description</th></tr>' );
          l_constants_not_yet_started:=false;
        end if;
        attach('<tr>'||htf.tabledata(i.component_name)||htf.tabledata(i.component_desc)||'</tr>');
        if i.last_component_type_fl=1 then
          attach('</table>');
        end if;
      end if;
  
      if i.component_type in ('TYPE') then
        if l_types_not_yet_started then
          attach( htf.header (nsize=>2,cheader=>i.toc_apex,cattributes=>'id="'||upper(replace(i.toc_apex,' '))||'"') );
          attach( '<p>The '||c_package_name||' package uses the following data types.</p>' );
          attach( '<table><tr><th>Name</th><th>Description</th></tr>' );
          l_types_not_yet_started:=false;
        end if;
        attach('<tr>'||htf.tabledata(i.component_name)||htf.tabledata(i.component_desc)||'</tr>');
        if i.last_component_type_fl=1 then
          attach('</table>');
        end if;
      end if;
  
      if i.component_type in ('EXCEPTION') then
        if l_exceptions_not_yet_started then
          attach( htf.header (nsize=>2,cheader=>i.toc_apex,cattributes=>'id="'||upper(replace(i.toc_apex,' '))||'"') );
          attach( '<p>The following table lists exceptions that have been defined for '||c_package_name||'.</p>' );
          attach( '<table><tr><th>Name</th><th>Description</th></tr>' );
          l_exceptions_not_yet_started:=false;
        end if;
        attach('<tr>'||htf.tabledata(i.component_name)||htf.tabledata(i.component_desc)||'</tr>');
        if i.last_component_type_fl=1 then
          attach('</table>');
        end if;
      end if;
  
      if i.component_type in ('FUNCTION','PROCEDURE') then
        attach( htf.header (nsize=>2,cheader=>i.toc_apex,cattributes=>'id="'||upper(replace(i.toc_apex,' '))||'"') );
        attach( '<p>'||i.component_desc||'</p>' );
        attach( htf.header (nsize=>3,cheader=>'Syntax') );
        attach( htf.code(i.component_syntax) );
        if i.parameterinfo is not null then 
          attach( htf.header (nsize=>3,cheader=>'Parameter'||case when i.parameter_count>1 then 's' end) );
          attach( i.parameterinfo );
        end if;
  --TODO subprogram example (nicht als stumpfe tabelle)
        if i.exampleinfo is not null then
          attach( htf.header (nsize=>3,cheader=>'Example'||case when i.example_count>1 then 's' end) );
          attach( i.exampleinfo );
        end if;
  --TODO subprogram example copy button
      end if;
  end loop toc;

  -- output
  if c_website_instead_of_only_html_code 
    then dbms_output.put_line( replace(c_html_skeleton,'§',l_html) );
    else dbms_output.put_line( l_html );
  end if;
end;
/
set feedback on