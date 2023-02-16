::@echo off

if "%variables_set%"=="" call ../../variables.bat

jmeter -n -t ehrserver_post_compositions_single_thread_posting.jmx -Jthread_no=%OPENEHR_TEST_THREADS_NO% -Jramp_up=%OPENEHR_TEST_RAMP_UP% -Jcontributions_per_user_no=%OPENEHR_TEST_CONTRIBUTIONS_PER_USER_NO% -Jauth=%OPENEHR_TEST_EHRSERVER_AUTH% -Jhost=%OPENEHR_TEST_EHRSERVER_HOST% -Jport=%OPENEHR_TEST_EHRSERVER_PORT% -Jduration=%OPENEHR_TEST_DURATION% -Jstartup_delay=%OPENEHR_TEST_STARTUP_DELAY%