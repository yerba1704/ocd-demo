# URL

https://use.ai/de/ with Claude Opus 4.1

# PROMPT

Baue bitte eine website wie diese hier

https://docs.oracle.com/en/database/oracle/apex/24.2/aeapi/APEX_CSS.html
https://docs.oracle.com/en/database/oracle/apex/24.2/aeapi/ADD-Procedure.html
https://docs.oracle.com/en/database/oracle/apex/24.2/aeapi/ADD_3RD_PARTY_LIBRARY_FILE-Procedure.html
https://docs.oracle.com/en/database/oracle/apex/24.2/aeapi/ADD_FILE-Procedure.html

Verwende dafür dieses JSON

```json
{
  "name" : "PKG_SAMPLE",
  "desc" : "This is an example of a package description.\n\nLine breaks are ignored but blank lines results in paragraphs.",
  "components" :
  [
    {
      "name" : "P_NOOP",
      "type" : "PROCEDURE",
      "desc" : "This is an example of a procedure description.",
      "syntax" : "procedure p_noop;"
    },
    {
      "name" : "P_NOOP",
      "type" : "PROCEDURE",
      "desc" : "This is an example of a procedure description.",
      "syntax" : "procedure p_noop(\n    i_x in pl/sql boolean,\n    i_y in date);",
      "parameters" :
      [
        {
          "name" : "I_X",
          "desc" : null
        },
        {
          "name" : "I_Y",
          "desc" : null
        }
      ]
    },
    {
      "name" : "F_SQUARE",
      "type" : "FUNCTION",
      "desc" : "Function for square a number. The return value is the result of multiplying the parameter by itself.",
      "syntax" : "function f_square(\n    i_value in number default 3)\n  return number;",
      "parameters" :
      [
        {
          "name" : "I_VALUE",
          "desc" : "A numeric value. The square of any non-zero real number, whether positive or negative, is always a positive number."
        }
      ]
    },
    {
      "name" : "F_SQUARE",
      "type" : "FUNCTION",
      "desc" : "Function xyz for square a number.",
      "syntax" : "function f_square(\n    i_a in date,\n    i_b in date)\n  return number;",
      "parameters" :
      [
        {
          "name" : "I_A",
          "desc" : "Abc."
        },
        {
          "name" : "I_B",
          "desc" : "Def."
        }
      ]
    },
    {
      "name" : "C_MAGIC_NUMBER",
      "type" : "CONSTANT",
      "desc" : "This is an example of a constant description."
    },
    {
      "name" : "E_PARSING_FAILED",
      "type" : "EXCEPTION",
      "desc" : "This is an example of an exception description."
    },
    {
      "name" : "T_NUMBER_AA",
      "type" : "TYPE",
      "desc" : "This is an example of an associative array description. It was formerly called PL/SQL table or index-by table."
    },
    {
      "name" : "T_NUMBER_VA",
      "type" : "TYPE",
      "desc" : "This is an example of a varray (variable-size array) description."
    },
    {
      "name" : "T_NUMBER_NT",
      "type" : "TYPE",
      "desc" : "This is an example of a nested table description."
    },
    {
      "name" : "T_OS_R",
      "type" : "TYPE",
      "desc" : "This is an example of an user-defined record type description.",
      "fields" :
      [
        {
          "name" : "PLATFORM",
          "type" : "..tbd...",
          "desc" : "The name of the operating system."
        },
        {
          "name" : "ARCHITECTURE",
          "type" : "..tbd...",
          "desc" : "Processor type of the system (in bit)."
        }
      ]
    }
  ]
}
```
