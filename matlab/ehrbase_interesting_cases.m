clear all
close all

ehrbase_docker_title = 'EHRbase running in Docker';
ehrbase_separate_title = 'EHRServer running locally (server and DB on different machines)';
ehrbase_local_title = 'EHRbase runing locally (server and DB on one machine)';

put_ehr = 'PUT /ehr';
get_ehr = 'GET /ehr';
post_composition = 'POST /composition';
get_composition = 'GET /composition';

%processCsv('../jmeter-tests/ehrbase/results/local_run_3/50_threads/ehrbase_put_ehr_50_threads_result.csv', ehrbase_local_title, put_ehr, true, true, 'ehrbase_local_50threads_');
processCsv('../jmeter-tests/ehrbase/results/run_1/50_threads/ehrbase_put_ehr_50_threads_result.csv', ehrbase_docker_title, get_ehr, true, false, 'ehrbase_docker_50threads_');
%processCsv('../jmeter-tests/ehrbase/results/separate_db_2/50_threads/ehrbase_put_ehr_50_threads_result.csv', ehrbase_separate_title, post_composition, true, true, 'ehrbase_separate_50threads_');