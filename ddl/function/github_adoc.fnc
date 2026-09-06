create or replace function github_adoc(i_package_name in varchar2, i_schema_name in varchar2 default user) return clob authid current_user
as
  c_package_name constant dbms_id_128 not null:=i_package_name;
  c_schema_name constant dbms_id_128 not null:=i_schema_name;
  c_json_string constant clob:=ocd.api.information(i_package_name,i_schema_name);
  c_json json_object_t:=json_object_t(c_json_string);
  l_components json_array_t;
  l_component json_object_t;
  l_parameter json_object_t;
  l_example json_object_t;
  type t_comptype is table of clob index by varchar2(128 char);
  l_content t_comptype;
  l_type dbms_id_128;
  l_toc dbms_id_128;
  l_top clob;
  l_sub clob;
  ---------
-- TODO directly like l_sub...
  procedure attach(i_txt in varchar2 default null) is begin l_top:=l_top||i_txt||chr(10); end attach;
begin
  attach('= '||c_package_name);
  attach;
  attach(c_json.get_string('desc'));
  attach;
  attach('This chapter contains the following topics:');
  attach;
  
  l_components:=c_json.get_array('components');
  for i in 0..l_components.get_size-1 loop
    l_component:=treat(l_components.get(i) as json_object_t);
    l_type:=l_component.get_string('type');
    if l_type='CONSTANT'  then l_type:='Constants';   end if;
    if l_type='SUBTYPE'   then l_type:='Datatypes';   end if;
    if l_type='EXCEPTION' then l_type:='Exceptions';  end if;
    if l_type='PROCEDURE' then l_type:='Subprograms'; end if;
    if l_type='FUNCTION'  then l_type:='Subprograms'; end if;
    -- build subcontent
    if l_type='Subprograms' then
      l_sub:=l_sub||'=== '||l_component.get_string('name')||' '||initcap(l_component.get_string('type'))||chr(10)
                  ||chr(10)
                  ||l_component.get_string('desc')||chr(10)
                  ||chr(10)
                  
                  ||'==== Syntax'||chr(10)
                  ||chr(10)
                  ||'[source]'||chr(10)
                  ||'----'||chr(10)
                  ||l_component.get_string('syntax')||chr(10)
                  ||'----'||chr(10);
      -- with parameters if exists...
      if l_component.get_array('parameters') is not null then
        l_sub:=l_sub||chr(10);
        l_sub:=l_sub||'==== Parameter'||case when l_component.get_array('parameters').get_size>1 then 's' end||chr(10);
        l_sub:=l_sub||chr(10);
        l_sub:=l_sub||'|==='||chr(10);
        l_sub:=l_sub||'|Parameter | Description'||chr(10);
        for p in 0..l_component.get_array('parameters').get_size-1 loop
          l_parameter:=treat(l_component.get_array('parameters').get(p) as json_object_t);
          l_sub:=l_sub||chr(10);
          l_sub:=l_sub||'|'||l_parameter.get_string('name')||chr(10);
          l_sub:=l_sub||'|'||l_parameter.get_string('desc')||chr(10);
        end loop;
        l_sub:=l_sub||'|==='||chr(10);
      end if;
      -- with examples if exists...
      if l_component.get_array('examples') is not null then
        l_sub:=l_sub||chr(10);
        l_sub:=l_sub||'==== Example'||case when l_component.get_array('examples').get_size>1 then 's' end||chr(10);
        l_sub:=l_sub||chr(10);
        for e in 0..l_component.get_array('examples').get_size-1 loop
          l_example:=treat(l_component.get_array('examples').get(e) as json_object_t);
          if l_component.get_array('examples').get_size>1 then
            l_sub:=l_sub||'Example '||to_char(e+1)||chr(10);
          end if;
          l_sub:=l_sub||'[source,sql]'||chr(10);
          l_sub:=l_sub||'----'||chr(10);
          l_sub:=l_sub||l_example.get_string('code')||chr(10);
          l_sub:=l_sub||'----'||chr(10);
        end loop;
      end if;
      l_sub:=l_sub||chr(10);
    end if;
    l_content(l_type):=case when l_content.exists(l_type) then l_content(l_type) end||
                       case l_type
                        when 'Constants'  then chr(10)||'|'||l_component.get_string('name')||chr(10)||'|'||l_component.get_string('datatype')||chr(10)||'|'||l_component.get_string('value')||chr(10)||'|'||l_component.get_string('desc')||chr(10)
                        when 'Datatypes'  then chr(10)||'|'||l_component.get_string('name')||chr(10)||'|'||l_component.get_string('desc') ||chr(10)
                        when 'Exceptions' then chr(10)||'|'||l_component.get_string('name')||chr(10)||'|'||l_component.get_string('desc') ||chr(10)
                        when 'Subprograms'then chr(10)||'|'||'<<'||l_component.get_string('name')||' '||initcap(l_component.get_string('type'))||'>>'||chr(10)||'|'||l_component.get_string('desc') ||chr(10)
                          else 'ERROR!?'
                       end;
  end loop;
  
  -- table of content
  l_toc:=l_content.first;
  loop
    exit when l_toc is null;
    attach('* <<'||case when l_toc='Subprograms' then 'Summary of `'||c_package_name||'` 'end||l_toc||'>>');
    l_toc:=l_content.next(l_toc);
  end loop;
  attach;
  
  -- content sections
  l_toc:=l_content.first;
  loop
    exit when l_toc is null;
    --attach;
    attach('== '||case when l_toc='Subprograms' then 'Summary of `'||c_package_name||'` 'end||l_toc);
    attach;
    case l_toc
      when 'Constants' then
        attach('The `API` package uses the constants listed and described in this topic.');
        attach;
        attach('|===');
        attach('|Name | Type | Value | Description');
      when 'Datatypes' then
        attach('Parameters and Constants in the `'||c_package_name||'` package use these datatypes.');
        attach;
        attach('|===');
        attach('|Name | Type');
      when 'Exceptions' then
        attach('The following table lists exceptions that have been defined for `'||c_package_name||'`.');
        attach;
        attach('|===');
        attach('|Exception | Description');
      when 'Subprograms' then
        attach('This table lists the `'||c_package_name||'` subprograms and briefly describes them.');
        attach;
        attach('|===');
        attach('|Subprogram | Description');
      else null;
    end case;
    
    if l_toc in ('Constants','Datatypes','Exceptions','Subprograms') then
      attach(l_content(l_toc)||'|===' );
      attach();
    end if;
    l_toc:=l_content.next(l_toc);
  end loop;
  
  -- sanitize title for overload subprograms
  for o in (select subprogram_name||' '||initcap(subprogram_type) as subprogram_title,
                   count(*) as subprogram_count
              from json_table ( c_json_string, '$.components[*]' columns ( subprogram_name varchar2 ( 128 ) path '$.name',
                                                                           subprogram_type varchar2 ( 128 ) path '$.type' ) 
                   )
          group by subprogram_name||' '||initcap(subprogram_type)
            having count(*)>1
  ) loop
    for i in 1..o.subprogram_count loop
      l_sub:=regexp_replace( l_sub, '^(=== '||o.subprogram_title||')$', '\1 Signature '||i, 1, 1, 'm' );
      l_top:=regexp_replace( l_top, '^(\|<<'||o.subprogram_title||')>>$', '\1 Signature '||i||'>>', 1, 1, 'm' );
    end loop;
  end loop;

  return l_top||l_sub;
end github_adoc;