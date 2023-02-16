::@echo off

if "%variables_set%"=="" call ../../variables.bat

:: Jloops_no=-1 means that the outer loop is infinite. Each thread ends after iterating over it's ehr_uuid file.

jmeter.bat -n -t ehrbase_post_contribution.jmx -Jthread_no=%OPENEHR_TEST_THREADS_NO% -Jramp_up=%OPENEHR_TEST_RAMP_UP% -Jloops_no=-1 -Jcontributions_per_user_no=%OPENEHR_TEST_CONTRIBUTIONS_PER_USER_NO% -Jauth=%OPENEHR_TEST_EHRBASE_AUTH% -Jhost=%OPENEHR_TEST_EHRBASE_HOST% -Jport=%OPENEHR_TEST_EHRBASE_PORT% -Jduration=%OPENEHR_TEST_DURATION% -Jstartup_delay=%OPENEHR_TEST_STARTUP_DELAY%