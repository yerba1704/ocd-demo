-- do not compile directly, use "@ddl/type/html_pub_sample.tps"
create or replace type html_pub_sample under ocd.stdpub (
  static function about return varchar2,
  static function version return varchar2,
  overriding member function output    return blob,
  overriding member function mime_type return varchar2
) final;