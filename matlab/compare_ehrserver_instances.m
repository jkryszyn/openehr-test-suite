clear all
close all

set(0,'defaultAxesFontSize', 14)

draw = false;
save_results = true;

if ~exist('ehrserver_data.mat')
    threads = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 15, 20, 25, 30, 35, 40, 45, 50];
    
    ehrserver_docker_path = '../jmeter-tests/ehrserver/results/run_1'; % docker on host
    ehrserver_docker_title = 'EHRServer running in Docker';
    ehrserver_local_path = '../jmeter-tests/ehrserver/results/local_run_prod_datasource';
    ehrserver_local_title = 'EHRServer runing locally (server and DB on one machine)';
    ehrserver_separate_path = '../jmeter-tests/ehrserver/results/separate_db2_datasource';
    ehrserver_separate_title = 'EHRServer running locally (server and DB on different machines)';
    
    post_ehrs = 'POST /ehrs';
    get_ehrs = 'GET /ehrs';
    post_compositions = 'POST /compositions';
    get_compositions = 'GET /compositions';
    
    ehrserver_docker_post_ehrs(1) = processCsv([ehrserver_docker_path '/ehrserver_post_ehrs_result.csv'], ehrserver_docker_title, post_ehrs, draw, save_results, 'ehrserver_docker_post_ehrs');
    ehrserver_docker_post_compositions(1) = processCsv([ehrserver_docker_path '/ehrserver_post_compositions_result.csv'], ehrserver_docker_title, post_compositions, draw, save_results, 'ehrserver_docker_post_compositions');

    ehrserver_local_post_ehrs(1) = processCsv([ehrserver_local_path '/ehrserver_post_ehrs_result.csv'], ehrserver_local_title, post_ehrs, draw, save_results, 'ehrserver_local_post_ehrs');
    ehrserver_local_post_compositions(1) = processCsv([ehrserver_local_path '/ehrserver_post_compositions_result.csv'], ehrserver_local_title, post_compositions, draw, save_results, 'ehrserver_local_post_compositions');

    ehrserver_separate_post_ehrs(1) = processCsv([ehrserver_separate_path '/ehrserver_post_ehrs_result.csv'], ehrserver_separate_title, post_ehrs, draw, save_results, 'ehrserver_separate_post_ehrs');
    ehrserver_separate_post_compositions(1) = processCsv([ehrserver_separate_path '/ehrserver_post_compositions_result.csv'], ehrserver_separate_title, post_compositions, draw, save_results, 'ehrserver_separate_post_compositions');

    for i = 1:numel(threads)
        ehrserver_docker_get_ehrs(i) = processCsv([ehrserver_docker_path '/ehrserver_get_ehrs_' num2str(threads(i)) '_threads_result.csv'], ehrserver_docker_title, get_ehrs, draw, save_results, 'ehrserver_docker_get_ehrs');
        ehrserver_docker_get_compositions(i) = processCsv([ehrserver_docker_path '/ehrserver_get_compositions_' num2str(threads(i)) '_threads_result.csv'], ehrserver_docker_title, get_compositions, draw, save_results, 'ehrserver_docker_get_compositions');
    
        ehrserver_local_get_ehr(i) = processCsv([ehrserver_local_path '/ehrserver_get_ehrs_' num2str(threads(i)) '_threads_result.csv'], ehrserver_local_title, get_ehrs, draw, save_results, 'ehrserver_local_get_ehrs');
        ehrserver_local_get_composition(i) = processCsv([ehrserver_local_path '/ehrserver_get_compositions_' num2str(threads(i)) '_threads_result.csv'], ehrserver_local_title, get_compositions, draw, save_results, 'ehrserver_docker_get_compositions');
    
        ehrserver_separate_get_ehr(i) = processCsv([ehrserver_separate_path '/ehrserver_get_ehrs_' num2str(threads(i)) '_threads_result.csv'], ehrserver_separate_title, get_ehrs, draw, save_results, 'ehrserver_separate_get_ehrs');
        ehrserver_separate_get_composition(i) = processCsv([ehrserver_separate_path '/ehrserver_get_compositions_' num2str(threads(i)) '_threads_result.csv'], ehrserver_separate_title, get_compositions, draw, save_results, 'ehrserver_docker_get_compositions');
    end
else
    load("ehrserver_data.mat");
end

saveResults({ehrserver_docker_post_ehrs, ehrserver_local_post_ehrs, ehrserver_separate_post_ehrs}, {ehrserver_docker_title, ehrserver_local_title, ehrserver_separate_title}, threads, 'ehrserver_post_ehrs_results.txt');
saveResults({ehrserver_docker_post_compositions, ehrserver_local_post_compositions, ehrserver_separate_post_compositions}, {ehrserver_docker_title, ehrserver_local_title, ehrserver_separate_title}, threads, 'ehrserver_post_compositions_results.txt');

showResults({ehrserver_docker_get_ehrs, ehrserver_local_get_ehr, ehrserver_separate_get_ehr}, threads, get_ehrs, save_results, 'ehrserver_instance_comparison_get_ehrs');
saveResults({ehrserver_docker_get_ehrs, ehrserver_local_get_ehr, ehrserver_separate_get_ehr}, {ehrserver_docker_title, ehrserver_local_title, ehrserver_separate_title}, threads, 'ehrserver_get_ehr_results.txt');

showResults({ehrserver_docker_get_compositions, ehrserver_local_get_composition, ehrserver_separate_get_composition}, threads, get_compositions, save_results, 'ehrserver_instance_comparison_get_compositions');
saveResults({ehrserver_docker_get_compositions, ehrserver_local_get_composition, ehrserver_separate_get_composition}, {ehrserver_docker_title, ehrserver_local_title, ehrserver_separate_title}, threads, 'ehrserver_get_compositions_results.txt');