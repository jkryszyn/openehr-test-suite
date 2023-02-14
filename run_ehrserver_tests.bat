@echo off
SETLOCAL EnableDelayedExpansion

call variables.bat

cd jmeter-tests\ehrserver\

del .\data\token.txt
call run_post_auth.bat
set /p OPENEHR_TEST_EHRSERVER_AUTH=<.\data\token.txt

set threads_no=1 2 5 10 20 30 40 50 50

(for %%t in (%threads_no%) do (
    set del_data_dir=.\data\%%t_threads\
    set del_result_dir=.\results\%%t_threads\
    if exist !del_data_dir! rmdir !del_data_dir! /q /s
    if exist !del_result_dir! rmdir !del_result_dir! /q /s

    set OPENEHR_TEST_RAMP_UP=%%t

    set OPENEHR_TEST_THREADS_NO=%%t
    call run_post_ehrs.bat
    call run_get_ehrs.bat

    set OPENEHR_TEST_THREADS_NO=1
    call run_post_compositions.bat

    set OPENEHR_TEST_THREADS_NO=%%t
    call run_get_compositions.bat
))

cd ..\..\
