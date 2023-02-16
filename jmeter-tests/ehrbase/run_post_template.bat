::@echo off

if "%variables_set%"=="" call ../../variables.bat

jmeter.bat -n -t ehrbase_post_template.jmx -Jsubject_namespace=%OPENEHR_TEST_EHRBASE_SUBJECT_NAMESPACE% -Jsubject_id=%OPENEHR_TEST_EHRBASE_SUBJECT_ID% -Jauth=%OPENEHR_TEST_EHRBASE_AUTH% -Jhost=%OPENEHR_TEST_EHRBASE_HOST% -Jport=%OPENEHR_TEST_EHRBASE_PORT%