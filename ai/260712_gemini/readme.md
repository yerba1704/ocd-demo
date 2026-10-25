## URL

https://gemini.google.com/app with Flash

## PROMPT

please create a website in the style of https://docs.oracle.com/en/database/oracle/oracle-database/26/arpls/ with this json:

```json
{
  "name" : "API",
  "desc" : "The API package contains all information to interact with ora* CODECOP. It is executable by all users and works with invokers rights.",
  "components" :
  [
    {
      "name" : "E_RULE_FAILED",
      "type" : "EXCEPTION",
      "desc" : "The rule failed because the specified SQL returned more than 0 rows."
    },
    {
      "name" : "C_RULE_FAILED",
      "type" : "CONSTANT"
    },
    {
      "name" : "E_INVALID_RULE_ID",
      "type" : "EXCEPTION",
      "desc" : "The given ID for the rule could not be found."
    },
    {
      "name" : "C_INVALID_RULE_ID",
      "type" : "CONSTANT"
    },
    {
      "name" : "E_INVALID_CODE",
      "type" : "EXCEPTION",
      "desc" : "The given CODE for the rule could not be found."
    },
    {
      "name" : "C_INVALID_CODE",
      "type" : "CONSTANT"
    },
    {
      "name" : "E_INVALID_VALUE",
      "type" : "EXCEPTION",
      "desc" : "The given VALUE for the rule_object, severity, characteristic or tag could not be found."
    },
    {
      "name" : "C_INVALID_VALUE",
      "type" : "CONSTANT"
    },
    {
      "name" : "SMALL_STRING",
      "type" : "SUBTYPE",
      "desc" : "A string containing max. 20 chars (not nullable)."
    },
    {
      "name" : "BOOL",
      "type" : "SUBTYPE",
      "desc" : "A not nullable natural number between 0 and 1."
    },
    {
      "name" : "PLSQL_UNIT",
      "type" : "CONSTANT",
      "desc" : "(distinct) type_classifcation"
    },
    {
      "name" : "SQL_DATA_OBJECT",
      "type" : "CONSTANT"
    },
    {
      "name" : "DATABASE_OBJECT",
      "type" : "CONSTANT"
    },
    {
      "name" : "APEX",
      "type" : "CONSTANT"
    },
    {
      "name" : "BLOCKER",
      "type" : "CONSTANT",
      "desc" : "severity level"
    },
    {
      "name" : "CRITICAL",
      "type" : "CONSTANT"
    },
    {
      "name" : "MAJOR",
      "type" : "CONSTANT"
    },
    {
      "name" : "MINOR",
      "type" : "CONSTANT"
    },
    {
      "name" : "INFO",
      "type" : "CONSTANT"
    },
    {
      "name" : "CHANGEABILITY",
      "type" : "CONSTANT",
      "desc" : "sqale characteristic"
    },
    {
      "name" : "EFFICIENCY",
      "type" : "CONSTANT"
    },
    {
      "name" : "MAINTAINABILITY",
      "type" : "CONSTANT"
    },
    {
      "name" : "PORTABILITY",
      "type" : "CONSTANT"
    },
    {
      "name" : "RELIABILITY",
      "type" : "CONSTANT"
    },
    {
      "name" : "REUSABILITY",
      "type" : "CONSTANT"
    },
    {
      "name" : "SECURITY",
      "type" : "CONSTANT"
    },
    {
      "name" : "TESTABILITY",
      "type" : "CONSTANT"
    },
    {
      "name" : "VERIFICATION_RESULT",
      "type" : "FUNCTION",
      "desc" : "Execute the sql statement from RULE_ID or CODE in RULESET.",
      "syntax" : "function verification_result(\n    i_rule_id_or_code in varchar2);",
      "parameters" :
      [
        {
          "name" : "I_RULE_ID_OR_CODE",
          "desc" : "A valid RULE_ID or CODE from RULESET. If not valid exception E_INVALID_RULE_ID or E_INVALID_CODE is raised."
        }
      ],
      "examples" :
      [
        {
          "name" : "EXAMPLE_1",
          "code" : "select * from occ.api.verification_result(i_rule_id_or_code => 'PARAMETER_NAMING_RULE');"
        }
      ]
    },
    {
      "name" : "CHECK_RULE",
      "type" : "PROCEDURE",
      "desc" : "Verify the rule according to the RULE_ID or CODE in RULESET.",
      "syntax" : "procedure check_rule(\n    i_rule_id_or_code in varchar2,\n    i_verbose_mode    in boolean default true,\n    i_raise_if_fail   in boolean default false);",
      "parameters" :
      [
        {
          "name" : "I_RULE_ID_OR_CODE",
          "desc" : "A valid RULE_ID or CODE from RULESET. If not valid exception e_invalid_rule_id or e_invalid_code is raised."
        },
        {
          "name" : "I_VERBOSE_MODE",
          "desc" : "Adjust the amount of details."
        },
        {
          "name" : "I_RAISE_IF_FAIL",
          "desc" : "Raise an exception if a rule is failed."
        }
      ],
      "examples" :
      [
        {
          "name" : "EXAMPLE_1",
          "code" : "exec occ.api.check_rule(i_rule_id_or_code => 'OCC-30010');"
        }
      ]
    },
    {
      "name" : "CHECK_RULE",
      "type" : "FUNCTION",
      "desc" : "Verify the rule according to the RULE_ID or CODE in RULESET.",
      "syntax" : "function check_rule(\n    i_rule_id_or_code in varchar2,\n    i_verbose_mode    in binary_integer default 1,\n    i_raise_if_fail   in binary_integer default 0)\n  return string_c;",
      "parameters" :
      [
        {
          "name" : "I_RULE_ID_OR_CODE",
          "desc" : "A valid RULE_ID or CODE from RULESET. If not valid exception e_invalid_rule_id or e_invalid_code is raised."
        },
        {
          "name" : "I_VERBOSE_MODE",
          "desc" : "Adjust the amount of details."
        },
        {
          "name" : "I_RAISE_IF_FAIL",
          "desc" : "Raise an exception if a rule is failed."
        }
      ],
      "examples" :
      [
        {
          "name" : "EXAMPLE_1",
          "code" : "select * from occ.api.check_rule(i_rule_id_or_code => 'OCC-30010');"
        }
      ]
    },
    {
      "name" : "CHECK_RULES",
      "type" : "PROCEDURE",
      "desc" : "Verify all rules that belongs to one of the associated dimension (rule_object, characteristic, severity), a tag or to all defined rules.",
      "syntax" : "procedure check_rules(\n    i_value         in varchar2 default null,\n    i_verbose_mode  in boolean default true,\n    i_raise_if_fail in boolean default false);",
      "parameters" :
      [
        {
          "name" : "I_VALUE",
          "desc" : "One of the following rule_objects, severities, characteristics: PLSQL_UNIT, SQL_DATA_OBJECT, DATABASE_OBJECT, APEX INFO, MINOR, MAJOR, CRITICAL, BLOCKER CHANGEABILITY, EFFICIENCY, MAINTAINABILITY,  PORTABILITY,  RELIABILITY,  REUSABILITY,  SECURITY, TESTABILITY or one of the defined TAGS (case insensitive). If a severity keyword is chosen, all severity levels greater or equal are used. If parameter is not valid exception e_invalid_value is raised. If parameter is NULL all available rules will verified."
        },
        {
          "name" : "I_VERBOSE_MODE",
          "desc" : "Adjust the amount of details."
        },
        {
          "name" : "I_RAISE_IF_FAIL",
          "desc" : "Raise an exception if a rule is failed."
        }
      ],
      "examples" :
      [
        {
          "name" : "EXAMPLE_1",
          "code" : "exec occ.api.check_rules(i_value => OCC.API.MAINTAINABILITY);"
        }
      ]
    },
    {
      "name" : "CHECK_RULES",
      "type" : "FUNCTION",
      "desc" : "Verify all rules that belongs to one of the associated dimension (rule_object, characteristic, severity), a tag or to all defined rules.",
      "syntax" : "function check_rules(\n    i_value         in varchar2 default null,\n    i_verbose_mode  in binary_integer default 1,\n    i_raise_if_fail in binary_integer default 0);",
      "parameters" :
      [
        {
          "name" : "I_VALUE",
          "desc" : "One of the following rule_objects, severities, characteristics: PLSQL_UNIT, SQL_DATA_OBJECT, DATABASE_OBJECT, APEX INFO, MINOR, MAJOR, CRITICAL, BLOCKER CHANGEABILITY, EFFICIENCY, MAINTAINABILITY,  PORTABILITY,  RELIABILITY,  REUSABILITY,  SECURITY, TESTABILITY or one of the defined TAGS (case insensitive). If a severity keyword is chosen, all severity levels greater or equal are used. If parameter is not valid exception e_invalid_value is raised. If parameter is NULL all available rules will verified."
        },
        {
          "name" : "I_VERBOSE_MODE",
          "desc" : "Adjust the amount of details."
        },
        {
          "name" : "I_RAISE_IF_FAIL",
          "desc" : "Raise an exception if a rule is failed."
        }
      ],
      "examples" :
      [
        {
          "name" : "EXAMPLE_1",
          "code" : "select * from occ.api.check_rules(i_value => 'MAINTAINABILITY');"
        }
      ]
    }
  ]
}
```
