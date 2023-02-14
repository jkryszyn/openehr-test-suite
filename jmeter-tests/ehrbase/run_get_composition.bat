::@echo off

if "%variables_set%"=="" call ../../variables.bat

jmeter -n -t ehrbase_get_composition.jmx -Jthread_no=%OPENEHR_TEST_THREADS_NO% -Jramp_up=%OPENEHR_TEST_RAMP_UP% -Jauth=%OPENEHR_TEST_EHRBASE_AUTH% -Jhost=%OPENEHR_TEST_EHRBASE_HOST% -Jport=%OPENEHR_TEST_EHRBASE_PORT% -Jduration=%OPENEHR_TEST_DURATION% -Jstartup_delay=%OPENEHR_TEST_STARTUP_DELAY%