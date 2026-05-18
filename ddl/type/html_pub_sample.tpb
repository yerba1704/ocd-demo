/*
select ocd.api.information(i_package_name => 'APEX_CSS_MODIFIED',
                           i_schema_name  => 'OCD_DEMO')
  from dual;

set serveroutput on
declare
  l_obj html_pub_sample:=html_pub_sample('OCD_DEMO','PKG_SAMPLE');
begin
  dbms_output.new_line;
  dbms_output.put_line( '     ABOUT: '|| html_pub_sample.about() );
  dbms_output.put_line( '   VERSION: '|| html_pub_sample.version() );
  dbms_output.new_line;
  dbms_output.put_line( ' MIME_TYPE: '|| l_obj.mime_type);
  dbms_output.put_line( '    OUTPUT: '|| to_clob(l_obj.output) );
end;
/
*/
create or replace type body html_pub_sample as
----------------------------------------------------------------------------------------------------------------------------------------------------------------
  static function about return varchar2 is c_info constant dbms_id_128:='Sample Publisher for OCD (basic HTML document).'; begin return c_info; end about;
----------------------------------------------------------------------------------------------------------------------------------------------------------------
  static function version return varchar2 is c_version constant dbms_id_30:='v1.0.0'; begin return c_version; end version;
----------------------------------------------------------------------------------------------------------------------------------------------------------------
  overriding member function output return blob is
    l_x integer;
    --> https://connor-mcdonald.com/2024/10/14/better-json-from-clob-to-blob/
    function clob2blob (p_clob clob) return blob deterministic as
      l_tgt_idx  int := 1;
      l_src_idx  int := 1;
      l_blob     blob;
      l_lang     int := dbms_lob.default_lang_ctx;
      l_err      int := dbms_lob.warn_inconvertible_char;
    begin
     dbms_lob.createtemporary(
       lob_loc => l_blob,
       cache   => true);
     dbms_lob.converttoblob(
      dest_lob    =>l_blob,
      src_clob    =>p_clob,
      amount      =>dbms_lob.lobmaxsize,
      dest_offset =>l_tgt_idx,
      src_offset  =>l_src_idx,
      blob_csid   =>dbms_lob.default_csid,
      lang_context=>l_lang,
      warning     =>l_err);
      
      return l_blob;
    end;
  begin
    --  self.component_info('PKG_name')||self.component_info('BESTANDTEIL1')||self.component_info('BESTANDTEIL2')||
    return clob2blob( ocd.api.information(i_package_name => self.package_name, i_schema_name => self.schema_name)||
                      '<html>?<a href="www.google.de" > und?</a><h1>Works great!</h1></html>'
                    );
  end;
----------------------------------------------------------------------------------------------------------------------------------------------------------------
  overriding member function mime_type return varchar2 is c_mime_type constant dbms_id_30:='text/html'; begin return c_mime_type; end mime_type;
------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  member function component_info(i_name in varchar2) return clob is
--    c_name constant dbms_id_128 not null:=upper(i_name);
--    l_out clob;
--    lr_cc component_content%rowtype;
--    l_tmp varchar2(32767 char);
--  begin
--  
----  komplett die startseite als view vorhalten, und zwar in html, md etc.
--  
--  
--  
--  
--  
--/*    https://www.w3schools.com/howto/howto_js_vertical_tabs.asp
--statt divs lieber article header footer... menu links aufklappbar wäre nice (?https://www.w3schools.com/howto/howto_css_subnav.asp)
--*/    select * into lr_cc
--      from component_content
--     where package_id=self.package_id
--       and ident=c_name;
--/*
--<div id="London" class="tabcontent">
--  <h3>London</h3>
--  <p>London is the capital city of England.</p>
--</div>
--*/
--    case lr_cc.code
--      when 'SP'
--        then 
--          select listagg(toc,chr(10)) within group(order by srt) into l_tmp from (
--            select toc, avg(srt) as srt from (
--              select decode(code, 'PC', -1,
--                                  'PS', order_sequence,
--                            5) as srt,
--                     decode(code, 'PC', '<li>Constants</li>'||chr(10),
--                                  'PS', '<li>'||ident||'</li>'||chr(10),
--                            null) as toc
--                from component_content
--               where package_id='B353ED155B344832DEC3522DEF616817'--self.package_id
--                 and code!='SP'
--            ) group by toc
--          );
--          l_out:='<div id="'||c_name||'" class="tabcontent">'||chr(10)||
--                 '  <h3>'||c_name||'</h3>'||chr(10)||
--                 '  <p>'||lr_cc.doc||'</p>'||chr(10)||
--                 '  <ul>'||chr(10)||
--                 '    '||l_tmp||
--                 '  </ul>'||chr(10)||
--             '</div>';
--      else
--        null;
--     end case;
--    
--    return l_out;
--  end;
------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  member procedure prn(self in out nocopy html_pub_sample)
--  is
--  begin
--
----  select '<h1>#IDENTIFIER#</h2>' as html, 1 as so from dual 
----    union all
----  select '<p>#IMPLICIT_COMMENT#</p>' as html, 2 as so from dual  
----    union all
----  select '<ul>#LOOP_PS#</li></ul>' as html, 3 as so from dual  
--  
--  
--    dbms_output.put_line('beschreibung vom outout typen.... version 3.2. thanks to contributor etc.');
--  end;
----------------------------------------------------------------------------------------------------------------------------------------------------------------
end;
/
