clear all
close all


ehrserver_separate_title = 'EHRServer running locally (server and DB on different machines)';
ehrserver_local_title = 'EHRServer runing locally (server and DB on one machine)';
ehrserver_docker_title = 'EHRServer running in Docker';

get_ehr = 'GET /ehrs';
get_composition = 'GET /compositions';

%processCsv('../jmeter-tests/ehrserver/results/separate_db2_datasource/ehrserver_get_ehrs_40_threads_result.csv', ehrserver_separate_title, get_ehr, true, true, 'ehrserver_get_ehrs_separate_40threads_');
%processCsv('../jmeter-tests/ehrserver/results/local_run_prod_datasource/ehrserver_get_ehrs_50_threads_result.csv', ehrserver_local_title, get_ehr, true, true, 'ehrserver_get_ehrs_local_50threads_');
%processCsv('../jmeter-tests/ehrserver/results/run_1/ehrserver_get_ehrs_50_threads_result.csv', ehrserver_docker_title, get_ehr, true, true, 'ehrserver_get_ehrs_docker_50threads_');

%processCsv('../jmeter-tests/ehrserver/results/separate_db2_datasource/ehrserver_get_compositions_45_threads_result.csv', ehrserver_separate_title, get_composition, true, true, 'ehrserver_get_compositions_separate_45threads');
%processCsv('../jmeter-tests/ehrserver/results/local_run_prod_datasource/ehrserver_get_ehrs_35_threads_result.csv', ehrserver_local_title, get_composition, true, true, 'ehrserver_get_compositions_local_35_threads');
processCsv('../jmeter-tests/ehrserver/results/run_1/ehrserver_get_compositions_50_threads_result.csv', ehrserver_docker_title, get_composition, true, true, 'ehrserver_get_compositions_docker_50threads_');