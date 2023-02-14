::@echo off

if "%variables_set%"=="" call ../../variables.bat

jmeter -n -t ehrserver_post_auth.jmx -Jhost=%OPENEHR_TEST_EHRSERVER_HOST% -Jport=%OPENEHR_TEST_EHRSERVER_PORT%