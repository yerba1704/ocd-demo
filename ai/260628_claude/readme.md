## URL

https://claude.ai/new with Sonnet 4.6

## PROMPT

Baue bitte eine website wie diese hier

https://docs.oracle.com/en/database/oracle/apex/24.2/aeapi/APEX_CSS.html
https://docs.oracle.com/en/database/oracle/apex/24.2/aeapi/ADD-Procedure.html
https://docs.oracle.com/en/database/oracle/apex/24.2/aeapi/ADD_3RD_PARTY_LIBRARY_FILE-Procedure.html
https://docs.oracle.com/en/database/oracle/apex/24.2/aeapi/ADD_FILE-Procedure.html

Verwende dafür dieses JSON

```json
{
  "name" : "APEX_CSS_MODIFIED",
  "desc" : "The APEX_CSS package provides utility functions for adding CSS styles to HTTP output. This package is usually used for plug-in development.",
  "components" :
  [
    {
      "name" : "C_LIBRARY_JQUERY",
      "type" : "CONSTANT",
      "desc" : "Constant for jquery-ui. Internal use."
    },
    {
      "name" : "C_LIBRARY_JQUERY_UI",
      "type" : "CONSTANT",
      "desc" : "Constant for jquery-ui. Internal use."
    },
    {
      "name" : "ADD_FILE",
      "type" : "PROCEDURE",
      "desc" : "This procedure adds the link tag to load a CSS library. If a library has already been added, it will not be added a second time.",
      "syntax" : "procedure add_file(\n    p_name           in varchar2,\n    p_directory      in varchar2,\n    p_version        in varchar2,\n    p_skip_extension in boolean,\n    p_media_query    in varchar2,\n    p_ie_condition   in varchar2,\n    p_attributes     in varchar2,\n    p_key            in varchar2);",
      "parameters" :
      [
        {
          "name" : "P_NAME",
          "desc" : "Name of the CSS file."
        },
        {
          "name" : "P_DIRECTORY",
          "desc" : "Begin of the URL where the CSS file should be read from. If you use this function for a plug-in you should set this parameter to `p_plugin.file_prefix`."
        },
        {
          "name" : "P_VERSION",
          "desc" : "Identifier of the version of the CSS file. The version will be  added to the CSS filename. In most cases you should use the default of NULL as the value."
        },
        {
          "name" : "P_SKIP_EXTENSION",
          "desc" : "The function automatically adds `.css` to the CSS filename. If set to `TRUE`, the function ignores this addition."
        },
        {
          "name" : "P_MEDIA_QUERY",
          "desc" : "Value set as media query."
        },
        {
          "name" : "P_IE_CONDITION",
          "desc" : "(Desupported) Condition used as Internet Explorer condition."
        },
        {
          "name" : "P_ATTRIBUTES",
          "desc" : "Extra attributes to add to the link tag. NOTE: Callers are responsible for escaping this parameter."
        },
        {
          "name" : "P_KEY",
          "desc" : null
        }
      ],
      "examples" :
      [
        {
          "name" : "EXAMPLE_1",
          "code" : "begin\n-- Adds the CSS file `jquery.autocomplete.css` in the directory specified by\n-- `p_plugin.file_prefix` to the HTML output of the page and makes sure that\n-- it will only be included once if `APEX_CSS.ADD_FILE` is called multiple times\n-- with that name.\n  apex_css.add_file (\n      p_name      => 'jquery.autocomplete',\n      p_directory => p_plugin.file_prefix );\nend;"
        }
      ]
    },
    {
      "name" : "ADD_3RD_PARTY_LIBRARY_FILE",
      "type" : "PROCEDURE",
      "desc" : "This procedure adds the link tag to load a 3rd party CSS file and also takes into account the specified Content Delivery Network (CDN) for the application.\n\nSupported libraries include: - jQuery - jQueryUI\n\nIf a library has already been added, it is not added a second time.",
      "syntax" : "procedure add_3rd_party_library_file(\n    p_library     in varchar2,\n    p_file_name   in varchar2,\n    p_directory   in varchar2,\n    p_version     in varchar2,\n    p_media_query in varchar2,\n    p_attributes  in varchar2);",
      "parameters" :
      [
        {
          "name" : "P_LIBRARY",
          "desc" : "Use one of the `c_library_*` constants"
        },
        {
          "name" : "P_FILE_NAME",
          "desc" : "Specifies the file name without version, `.min` and `.css` If no file name is provided, the default library file will be loaded."
        },
        {
          "name" : "P_DIRECTORY",
          "desc" : "Directory where the file P_FILE_NAME is located."
        },
        {
          "name" : "P_VERSION",
          "desc" : "If no value is provided, then uses the same version shipped with APEX."
        },
        {
          "name" : "P_MEDIA_QUERY",
          "desc" : "Value that is set as media query."
        },
        {
          "name" : "P_ATTRIBUTES",
          "desc" : "Extra attributes to add to the link tag. Note: Callers are responsible for escaping this parameter."
        }
      ],
      "examples" :
      [
        {
          "name" : "EXAMPLE_1",
          "code" : "-- The following example loads the CSS file of the Accordion\n-- component of the jQuery UI.\nbegin\n  apex_css.add_3rd_party_library_file (\n    p_library   => apex_css.c_library_jquery_ui,\n    p_file_name => 'jquery.ui.accordion' );\nend;"
        }
      ]
    },
    {
      "name" : "ADD",
      "type" : "PROCEDURE",
      "desc" : "This procedure adds a CSS style snippet that is included inline in the HTML output. Use this procedure to add new CSS style declarations.",
      "syntax" : "procedure add(\n    p_css in varchar2,\n    p_key in varchar2);",
      "parameters" :
      [
        {
          "name" : "P_CSS",
          "desc" : "The CSS style snippet. For example, `#test {color:#fff}`"
        },
        {
          "name" : "P_KEY",
          "desc" : "Identifier for the style snippet. If specified and a style snippet with the same name has already been added the new style snippet will be ignored."
        }
      ],
      "examples" :
      [
        {
          "name" : "EXAMPLE_1",
          "code" : "-- Adds an inline CSS definition for the class autocomplete into the HTML page.\n-- The key `autocomplete_widget` prevents the definition from being included another\n-- time if the `apex_css.add` is called another time.\nbegin\n  apex_css.add (\n    p_css => '.autocomplete { color:#ffffff }',\n    p_key => 'autocomplete_widget' );\nend;"
        }
      ]
    },
    {
      "name" : "NEW_CSS_REPOSITORY_RECORD",
      "type" : "FUNCTION",
      "desc" : "Use WWV_FLOW_API.CREATE_APP_STATIC_FILE and WWV_FLOW_API.CREATE_WORKSPACE_STATIC_FILE instead.",
      "syntax" : "function new_css_repository_record(\n    p_name           in/out varchar2,\n    p_varchar2_table in dbms_sql.varchar2_table,\n    p_mimetype       in varchar2,\n    p_flow_id        in number,\n    p_notes          in varchar2);",
      "parameters" :
      [
        {
          "name" : "P_NAME",
          "desc" : null
        },
        {
          "name" : "P_VARCHAR2_TABLE",
          "desc" : null
        },
        {
          "name" : "P_MIMETYPE",
          "desc" : null
        },
        {
          "name" : "P_FLOW_ID",
          "desc" : null
        },
        {
          "name" : "P_NOTES",
          "desc" : null
        }
      ]
    },
    {
      "name" : "REMOVE_CSS",
      "type" : "PROCEDURE",
      "syntax" : "procedure remove_css(\n    p_css_name in varchar2,\n    p_flow_id  in number);",
      "parameters" :
      [
        {
          "name" : "P_CSS_NAME",
          "desc" : null
        },
        {
          "name" : "P_FLOW_ID",
          "desc" : null
        }
      ]
    }
  ]
}
```
