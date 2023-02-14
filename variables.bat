@echo off

::EHRbase related settings
set OPENEHR_TEST_EHRBASE_HOST=192.168.116.5
set OPENEHR_TEST_EHRBASE_PORT=8080
set OPENEHR_TEST_EHRBASE_SUBJECT_NAMESPACE=psaipi
set OPENEHR_TEST_EHRBASE_SUBJECT_ID=2901a544-791b-11ec-90d6-0242ac120002
::this is the default value of Basic Auth header from the docs
set OPENEHR_TEST_EHRBASE_AUTH=ZWhyYmFzZS11c2VyOlN1cGVyU2VjcmV0UGFzc3dvcmQ=

::EHRServer related settings
set OPENEHR_TEST_EHRSERVER_HOST=192.168.116.5
set OPENEHR_TEST_EHRSERVER_PORT=8888

::General settings
::number of compositions which will be created for each EHR
set OPENEHR_TEST_CONTRIBUTIONS_PER_USER_NO=10
set OPENEHR_TEST_STARTUP_DELAY=0
set OPENEHR_TEST_DURATION=180

:: flag which indicates if variables were set
set variables_set=1