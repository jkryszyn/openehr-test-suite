@echo off
SETLOCAL EnableDelayedExpansion

call variables.bat

cd jmeter-tests\ehrbase\

set threads_no=1 2 3 4 5 6 7 8 9 10 12 15 20 25 30 35 40 45 50

(for %%t in (%threads_no%) do (
    set del_data_dir=.\data\%%t_threads\
    set del_result_dir=.\results\%%t_threads\
    if exist !del_data_dir! rmdir !del_data_dir! /q /s
    if exist !del_result_dir! rmdir !del_result_dir! /q /s

    set OPENEHR_TEST_RAMP_UP=%%t
    set OPENEHR_TEST_THREADS_NO=%%t

    call run_put_ehr.bat
    call run_get_ehr.bat
    call run_post_composition.bat
    call run_get_composition.bat
))

cd ..\..\