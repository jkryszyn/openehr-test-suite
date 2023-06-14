clear all
close all

set(0,'defaultAxesFontSize', 14)

draw = false;
save_results = false;

if ~exist('ehrbase_data.mat')
    threads = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 15, 20, 25, 30, 35, 40, 45 50];
    
    ehrbase_docker_path = '../jmeter-tests/ehrbase/results/run_1'; % docker on host
    ehrbase_docker_title = 'EHRbase running in Docker';
    ehrbase_local_path = '../jmeter-tests/ehrbase/results/local_run_3';
    ehrbase_local_title = 'EHRbase runing locally (server and DB on one machine)';
    ehrbase_separate_path = '../jmeter-tests/ehrbase/results/separate_db_2';
    ehrbase_separate_title = 'EHRbase running locally (server and DB on different machines)';
    
    put_ehr = 'PUT /ehr';
    get_ehr = 'GET /ehr';
    post_composition = 'POST /composition';
    get_composition = 'GET /composition';
    
    for i = 1:numel(threads)
        ehrbase_docker_put_ehr(i) = processCsv([ehrbase_docker_path '/' num2str(threads(i)) '_threads/ehrbase_put_ehr_' num2str(threads(i)) '_threads_result.csv'], ehrbase_docker_title, put_ehr, draw, save_results, ['ehrbase_docker_put_ehr_' num2str(threads(i)) 'threads']);
        ehrbase_docker_get_ehr(i) = processCsv([ehrbase_docker_path '/' num2str(threads(i)) '_threads/ehrbase_get_ehr_' num2str(threads(i)) '_threads_result.csv'], ehrbase_docker_title, get_ehr, draw, save_results, ['ehrbase_docker_get_ehr_' num2str(threads(i)) 'threads']);
        ehrbase_docker_post_composition(i) = processCsv([ehrbase_docker_path '/' num2str(threads(i)) '_threads/ehrbase_post_composition_' num2str(threads(i)) '_threads_result.csv'], ehrbase_docker_title, post_composition, draw, save_results, ['ehrbase_docker_post_composition_' num2str(threads(i)) 'threads']);
        ehrbase_docker_get_composition(i) = processCsv([ehrbase_docker_path '/' num2str(threads(i)) '_threads/ehrbase_get_composition_' num2str(threads(i)) '_threads_result.csv'], ehrbase_docker_title, get_composition, draw, save_results, ['ehrbase_docker_get_composition_' num2str(threads(i)) 'threads']);
    
        ehrbase_local_put_ehr(i) = processCsv([ehrbase_local_path '/' num2str(threads(i)) '_threads/ehrbase_put_ehr_' num2str(threads(i)) '_threads_result.csv'], ehrbase_local_title, put_ehr, draw, save_results, ['ehrbase_local_put_ehr_' num2str(threads(i)) 'threads']);
        ehrbase_local_get_ehr(i) = processCsv([ehrbase_local_path '/' num2str(threads(i)) '_threads/ehrbase_get_ehr_' num2str(threads(i)) '_threads_result.csv'], ehrbase_local_title, get_ehr, draw, save_results, ['ehrbase_local_get_ehr_' num2str(threads(i)) 'threads']);
        ehrbase_local_post_composition(i) = processCsv([ehrbase_local_path '/' num2str(threads(i)) '_threads/ehrbase_post_composition_' num2str(threads(i)) '_threads_result.csv'], ehrbase_local_title, post_composition, draw, save_results, ['ehrbase_local_post_composition_' num2str(threads(i)) 'threads']);
        ehrbase_local_get_composition(i) = processCsv([ehrbase_local_path '/' num2str(threads(i)) '_threads/ehrbase_get_composition_' num2str(threads(i)) '_threads_result.csv'], ehrbase_local_title, get_composition, draw, save_results, ['ehrbase_local_get_composition_' num2str(threads(i)) 'threads']);
    
        ehrbase_separate_put_ehr(i) = processCsv([ehrbase_separate_path '/' num2str(threads(i)) '_threads/ehrbase_put_ehr_' num2str(threads(i)) '_threads_result.csv'], ehrbase_separate_title, put_ehr, draw, save_results, ['ehrbase_separate_put_ehr_' num2str(threads(i)) 'threads']);
        ehrbase_separate_get_ehr(i) = processCsv([ehrbase_separate_path '/' num2str(threads(i)) '_threads/ehrbase_get_ehr_' num2str(threads(i)) '_threads_result.csv'], ehrbase_separate_title, get_ehr, draw, save_results, ['ehrbase_separate_get_ehr_' num2str(threads(i)) 'threads']);
        ehrbase_separate_post_composition(i) = processCsv([ehrbase_separate_path '/' num2str(threads(i)) '_threads/ehrbase_post_composition_' num2str(threads(i)) '_threads_result.csv'], ehrbase_separate_title, post_composition, draw, save_results, ['ehrbase_separate_post_composition_' num2str(threads(i)) 'threads']);
        ehrbase_separate_get_composition(i) = processCsv([ehrbase_separate_path '/' num2str(threads(i)) '_threads/ehrbase_get_composition_' num2str(threads(i)) '_threads_result.csv'], ehrbase_separate_title, get_composition, draw, save_results, ['ehrbase_separate_get_composition_' num2str(threads(i)) 'threads']);
    end
else
    load("ehrbase_data.mat");
end

%showResults({ehrbase_docker_put_ehr, ehrbase_local_put_ehr, ehrbase_separate_put_ehr}, threads, put_ehr, save_results, 'ehrbase_instance_comparison_put_ehr');
saveResults({ehrbase_docker_put_ehr, ehrbase_local_put_ehr, ehrbase_separate_put_ehr}, {ehrbase_docker_title, ehrbase_local_title, ehrbase_separate_title}, threads, 'ehrbase_put_ehr_results.txt');

%showResults({ehrbase_docker_get_ehr, ehrbase_local_get_ehr, ehrbase_separate_get_ehr}, threads, get_ehr, save_results, 'ehrbase_instance_comparison_get_ehr');
saveResults({ehrbase_docker_get_ehr, ehrbase_local_get_ehr, ehrbase_separate_get_ehr}, {ehrbase_docker_title, ehrbase_local_title, ehrbase_separate_title}, threads, 'ehrbase_get_ehr_results.txt');

%showResults({ehrbase_docker_post_composition, ehrbase_local_post_composition, ehrbase_separate_post_composition}, threads, post_composition, save_results, 'ehrbase_instance_comparison_post_composition');
saveResults({ehrbase_docker_post_composition, ehrbase_local_post_composition, ehrbase_separate_post_composition}, {ehrbase_docker_title, ehrbase_local_title, ehrbase_separate_title}, threads, 'ehrbase_post_composition_results.txt');

%showResults({ehrbase_docker_get_composition, ehrbase_local_get_composition, ehrbase_separate_get_composition}, threads, get_composition, save_results, 'ehrbase_instance_comparison_get_composition');
saveResults({ehrbase_docker_get_composition, ehrbase_local_get_composition, ehrbase_separate_get_composition}, {ehrbase_docker_title, ehrbase_local_title, ehrbase_separate_title}, threads, 'ehrbase_get_composition_results.txt');
