::@echo off

if "%variables_set%"=="" call ../../variables.bat

:: Jloops_no=-1 means that the outer loop is infinite. Each thread ends after iterating over it's ehr_uuid file.

jmeter.bat -n -r -t ehrbase_post_composition.jmx -Gthread_no=%OPENEHR_TEST_THREADS_NO% -Gramp_up=%OPENEHR_TEST_RAMP_UP% -Gcontributions_per_user_no=%OPENEHR_TEST_CONTRIBUTIONS_PER_USER_NO% -Gauth=%OPENEHR_TEST_EHRBASE_AUTH% -Ghost=%OPENEHR_TEST_EHRBASE_HOST% -Gport=%OPENEHR_TEST_EHRBASE_PORT% -Gduration=%OPENEHR_TEST_DURATION% -Gstartup_delay=%OPENEHR_TEST_STARTUP_DELAY%