::@echo off

if "%variables_set%"=="" call ../../variables.bat

jmeter.bat -n -r -t ehrbase_get_composition.jmx -Gthread_no=%OPENEHR_TEST_THREADS_NO% -Gramp_up=%OPENEHR_TEST_RAMP_UP% -Gauth=%OPENEHR_TEST_EHRBASE_AUTH% -Ghost=%OPENEHR_TEST_EHRBASE_HOST% -Gport=%OPENEHR_TEST_EHRBASE_PORT% -Gduration=%OPENEHR_TEST_DURATION% -Gstartup_delay=%OPENEHR_TEST_STARTUP_DELAY%