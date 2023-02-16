::@echo off

if "%variables_set%"=="" call ../../variables.bat

jmeter.bat -n -t ehrbase_put_ehr.jmx -Jthread_no=%OPENEHR_TEST_THREADS_NO% -Jramp_up=%OPENEHR_TEST_RAMP_UP% -Jsubject_namespace=%OPENEHR_TEST_EHRBASE_SUBJECT_NAMESPACE% -Jsubject_id=%OPENEHR_TEST_EHRBASE_SUBJECT_ID% -Jauth=%OPENEHR_TEST_EHRBASE_AUTH% -Jhost=%OPENEHR_TEST_EHRBASE_HOST% -Jport=%OPENEHR_TEST_EHRBASE_PORT% -Jduration=%OPENEHR_TEST_DURATION% -Jstartup_delay=%OPENEHR_TEST_STARTUP_DELAY%