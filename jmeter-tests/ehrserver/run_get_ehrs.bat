::@echo off

if "%variables_set%"=="" call ../../variables.bat

jmeter -n -t ehrserver_get_ehrs.jmx -Jthread_no=%OPENEHR_TEST_THREADS_NO% -Jramp_up=%OPENEHR_TEST_RAMP_UP% -Jauth=%OPENEHR_TEST_EHRSERVER_AUTH% -Jhost=%OPENEHR_TEST_EHRSERVER_HOST% -Jport=%OPENEHR_TEST_EHRSERVER_PORT% -Jduration=%OPENEHR_TEST_DURATION% -Jstartup_delay=%OPENEHR_TEST_STARTUP_DELAY%