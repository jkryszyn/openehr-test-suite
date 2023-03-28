@echo off
SETLOCAL EnableDelayedExpansion

call variables.bat

cd jmeter-tests\ehrserver\

if exist .\data\token.txt del /F .\data\token.txt
if exist .\data\single_thread_posting\ rmdir .\data\single_thread_posting\ /q /s
if exist .\results\single_thread_posting\ rmdir .\results\single_thread_posting\ /q /s
call run_post_auth.bat
set /p OPENEHR_TEST_EHRSERVER_AUTH=<.\data\token.txt

set threads_no=1 2 3 4 5 6 7 8 9 10 12 15 20 25 30 35 40 45 50

call run_post_ehrs_single_thread_posting.bat

(for %%t in (%threads_no%) do (
    set OPENEHR_TEST_RAMP_UP=%%t
    set OPENEHR_TEST_THREADS_NO=%%t
    call run_get_ehrs_single_thread_posting.bat
))

call run_post_compositions_single_thread_posting.bat

(for %%t in (%threads_no%) do (
    set OPENEHR_TEST_RAMP_UP=%%t
    set OPENEHR_TEST_THREADS_NO=%%t
    call run_get_compositions_single_thread_posting.bat
))

cd ..\..\
