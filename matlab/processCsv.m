function [ret_object] = processCsv(filename, server_name, endpoint_name, draw, save_plots, save_filename_prefix)

prctls = [90 95 99 99.99 100];
%ustawiamy parametr - ilosc sekund po rozgrzewce
N = 60;

T = readtable(filename);
ret_object.timestamps_all = T{:,1};
ret_object.timestamps_all = ret_object.timestamps_all - ret_object.timestamps_all(1);
ret_object.elapsed_all = T{:,2};
ret_object.bytes_all = T{:,10};
ret_object.sentBytes_all = T{:,11};
ret_object.latency_all = T{:,15};
ret_object.connect_all = T{:,17};
ret_object.success_all = T{:,8};
ret_object.response_code = T{:,4};
ret_object.server_name = server_name;
ret_object.endpoint_name = endpoint_name;

if(iscell(ret_object.response_code) == 1)
    ret_object.response_code = str2double(ret_object.response_code);
end

idx_200 = ret_object.response_code >= 200 & ret_object.response_code < 300;
idx_500 = ret_object.response_code == 500;

ret_object.request_numbers.all = numel(idx_200);
ret_object.request_numbers.success = nnz(idx_200);
ret_object.request_numbers.failure = numel(idx_200) - nnz(idx_200);
ret_object.request_numbers.failure_500 = nnz(idx_500);
ret_object.request_numbers.failure_other = numel(idx_200) - nnz(idx_200) -nnz(idx_500);

ret_object.timestamps_all = ret_object.timestamps_all(idx_200);
ret_object.elapsed_all = ret_object.elapsed_all(idx_200);
ret_object.bytes_all = ret_object.bytes_all(idx_200);
ret_object.sentBytes_all = ret_object.sentBytes_all(idx_200);
ret_object.latency_all = ret_object.latency_all(idx_200);
ret_object.connect_all = ret_object.connect_all(idx_200);
ret_object.success_all = ret_object.success_all(idx_200);

%noweParametry
ret_object.timestamps = ret_object.timestamps_all(ret_object.timestamps_all >= ret_object.timestamps_all(end) - N*1000);
ret_object.elapsed = ret_object.elapsed_all(ret_object.timestamps_all >= ret_object.timestamps_all(end) - N*1000);
%
ret_object.latency = ret_object.latency_all(ret_object.timestamps_all >= ret_object.timestamps_all(end) - N*1000);
%
ret_object.connect = ret_object.connect_all(ret_object.timestamps_all >= ret_object.timestamps_all(end) - N*1000);
%ret_object.bytes = ret_object.bytes_all(ret_object.bytes_all >= ret_object.bytes_all(end) - N*1000);
ret_object.bytes = ret_object.bytes_all(ret_object.timestamps_all >= ret_object.timestamps_all(end) - N*1000);
%ret_object.sentBytes = ret_object.sentBytes_all(ret_object.sentBytes_all >= ret_object.sentBytes_all(end) - N*1000);
ret_object.sentBytes = ret_object.sentBytes_all(ret_object.timestamps_all >= ret_object.timestamps_all(end) - N*1000);
%
ret_object.responseDownloadTime = ret_object.elapsed-ret_object.latency;
ret_object.minResponseDownloadTime = min(ret_object.responseDownloadTime);
ret_object.maxResponseDownloadTime = max(ret_object.responseDownloadTime);
ret_object.meanResponseDownloadTime = mean(ret_object.responseDownloadTime);
ret_object.stdResponseDownloadTime = std(ret_object.responseDownloadTime);
ret_object.percentilesResponseDownloadTime = prctile(ret_object.responseDownloadTime, prctls);
%
ret_object.success = ret_object.success_all(ret_object.timestamps_all >= ret_object.timestamps_all(end) - N*1000);
%
ret_object.processTime = ret_object.latency-ret_object.connect;

ret_object.thread_names_all = split(T{:,6});
ret_object.thread_names_all = ret_object.thread_names_all(:,end);
ret_object.thread_names_all = split(ret_object.thread_names_all,'-');
ret_object.thread_names_all = ret_object.thread_names_all(:,end);
ret_object.thread_names_all = str2double(ret_object.thread_names_all);
ret_object.thread_names = unique(ret_object.thread_names_all);

ret_object.min = min(ret_object.elapsed);
ret_object.max = max(ret_object.elapsed);
ret_object.mean = mean(ret_object.elapsed);
ret_object.std = std(ret_object.elapsed);
ret_object.percentiles = prctile(ret_object.elapsed, prctls);
%
[m,n]=size(ret_object.timestamps);
%ret_object.throughtput = ret_object.timestamps/N*1000;
ret_object.throughput = m/N;

%
ret_object.minConnectTime = min(ret_object.connect);
ret_object.maxConnectTime = max(ret_object.connect);
ret_object.meanConnectTime = mean(ret_object.connect);
ret_object.stdConnectTime = std(ret_object.connect);
ret_object.percentilesConnectTime = prctile(ret_object.connect, prctls);
%
ret_object.minLatency = min(ret_object.latency);
ret_object.maxLatency = max(ret_object.latency);
ret_object.meanLatency = mean(ret_object.latency);
ret_object.stdLatency = std(ret_object.latency);
ret_object.percentilesLatency = prctile(ret_object.connect, prctls);
%
ret_object.minProcessTime = min(ret_object.processTime);
ret_object.maxProcessTime = max(ret_object.processTime);
ret_object.meanProcessTime = mean(ret_object.processTime);
ret_object.stdProcessTime = std(ret_object.processTime);
ret_object.percentilesProcessTime = prctile(ret_object.processTime, prctls);
%
ret_object.minSendBytes = min(ret_object.sentBytes);
ret_object.maxSendBytes = max(ret_object.sentBytes);
ret_object.meanSendBytes = mean(ret_object.sentBytes);
ret_object.stdSendBytes = std(ret_object.sentBytes);
ret_object.percentilesSendBytes = prctile(ret_object.sentBytes, prctls);
%
ret_object.minBytes = min(ret_object.bytes);
ret_object.maxBytes = max(ret_object.bytes);
ret_object.meanBytes = mean(ret_object.bytes);
ret_object.stdBytes = std(ret_object.bytes);
ret_object.percentilesBytes = prctile(ret_object.bytes, prctls);

%
%ret_object.successPercentage = (sum(count(ret_object.success,'true'))/m)*100;
ret_object.successPercentage = 100*ret_object.request_numbers.success/ret_object.request_numbers.all;


if(draw == true)
    %% all elapsed times
    fig1 = figure('units','normalized','outerposition',[0 0 1 1]);
    fig1.PaperOrientation = 'portrait';
    
    plot(ret_object.timestamps_all/1000, ret_object.elapsed_all, 'x');
    xlabel('time since test start [s]');
    ylabel('elapsed time [ms]');
    title(['Elapsed time of all ' endpoint_name ' requests sent to ' server_name ' by ' num2str(numel(ret_object.thread_names)) ' concurrent users.'], 'Interpreter', 'none');
    grid on;

    if(save_plots)
        exportgraphics(gcf, [save_filename_prefix '_elapsed_all.png'], 'Resolution', 300);
    end

    %% histogram of all elapsed times
    fig2 = figure('units','normalized','outerposition',[0 0 1 1]);
    fig2.PaperOrientation = 'portrait';

    range_test = max(ret_object.elapsed_all) - min(ret_object.elapsed_all);
    bin_width = range_test/64;
    edges_test = min(ret_object.elapsed_all):bin_width:max(ret_object.elapsed_all) + bin_width;

    histogram(ret_object.elapsed_all, edges_test);
    title(['Histogram of elapsed time of all ' endpoint_name ' requests sent to ' server_name ' by ' num2str(numel(ret_object.thread_names)) ' concurrent users.'], 'Interpreter', 'none');
    ylabel('Counts');
    xlabel('Elapsed time [ms]');

    if(save_plots)
        exportgraphics(gcf, [save_filename_prefix '_elapsed_all_histogram.png'], 'Resolution', 300);
        set(gca, 'YScale', 'log')
        exportgraphics(gcf, [save_filename_prefix '_elapsed_all_histogram_log.png'], 'Resolution', 300);
    end
    
    %% last 60s elapsed times
    fig3 = figure('units','normalized','outerposition',[0 0 1 1]);
    fig3.PaperOrientation = 'portrait';
    
    plot(ret_object.timestamps/1000, ret_object.elapsed, 'x');
    xlabel('time since test start [s]');
    ylabel('elapsed time [ms]');
    title({['Elapsed time of all ' endpoint_name ' requests sent to ' server_name ' by ' num2str(numel(ret_object.thread_names)) ' concurrent users (last ' num2str(N) 's).'], ['Min = ', num2str(ret_object.min), 'ms. Max = ', num2str(ret_object.max), 'ms. Mean = ', num2str(ret_object.mean), 'ms. Std = ', num2str(ret_object.std), 'ms.']}, 'Interpreter', 'none');
    grid on;

    if(save_plots)
        exportgraphics(gcf, [save_filename_prefix '_elapsed.png'], 'Resolution', 300);
    end
    
    %% histogram of all elapsed times
    fig4 = figure('units','normalized','outerposition',[0 0 1 1]);
    fig4.PaperOrientation = 'portrait';

    range_test = ret_object.max - ret_object.min;
    bin_width = range_test/64;
    edges_test = ret_object.min:bin_width:ret_object.max + bin_width;

    histogram(ret_object.elapsed, edges_test);
    ylabel('Counts');
    xlabel(['Elapsed time of [ms]']);
    title(['Histogram of elapsed time of all ' endpoint_name ' requests sent to ' server_name ' by ' num2str(numel(ret_object.thread_names)) ' concurrent users (last ' num2str(N) 's).']);
    
    if(save_plots)
        exportgraphics(gcf, [save_filename_prefix '_elapsed_histogram.png'], 'Resolution', 300);
        set(gca, 'YScale', 'log')
        exportgraphics(gcf, [save_filename_prefix '_elapsed_histogram_log.png'], 'Resolution', 300);
    end

    %% draw data per thread
    %{
    fig5 = figure('units','normalized','outerposition',[0 0 1 1]);
    fig5.PaperOrientation = 'portrait';
    clf(fig5);
    hold on
    
    fig6 = figure('units','normalized','outerposition',[0 0 1 1]);
    fig6.PaperOrientation = 'portrait';
    clf(fig6);
    hold on
    
    fig7 = figure('units','normalized','outerposition',[0 0 1 1]);
    fig7.PaperOrientation = 'portrait';
    clf(fig7);
    hold on
    
    for i = 1:numel(ret_object.thread_names)
        thread_timestamps_all = ret_object.timestamps_all(ret_object.thread_names_all == ret_object.thread_names(i));
        thread_elapsed_all =ret_object. elapsed_all(ret_object.thread_names_all == ret_object.thread_names(i));
        thread_timestamps = thread_timestamps_all(thread_timestamps_all >= ret_object.timestamps_all(end) - N*1000);
        thread_elapsed = thread_elapsed_all(thread_timestamps_all >= ret_object.timestamps_all(end) - N*1000);
        
        plot(fig5.CurrentAxes, thread_timestamps_all/1000, thread_elapsed_all, 'x');
        xlabel('time since test start [s]');
        ylabel('elapsed time [ms]');
        title({filename, 'Elapsed time of requests.'}, 'Interpreter', 'none');
        grid on;
        
        min_val = min(thread_elapsed);
        max_val = max(thread_elapsed);
        mean_val = mean(thread_elapsed);
        std_val = std(thread_elapsed);
        
        plot(fig6.CurrentAxes, thread_timestamps/1000, thread_elapsed, 'x');
        xlabel('time since test start [s]');
        ylabel('elapsed time [ms]');
        title({filename, ['Elapsed time of requests (last 60s) Min = ', num2str(min_val), 'ms. Max = ', num2str(max_val), 'ms. Mean = ', num2str(mean_val), 'ms. Std = ', num2str(std_val), 'ms.']}, 'Interpreter', 'none');
        grid on;
        
        histogram(fig7.CurrentAxes, thread_elapsed);
    end
    %}
end
end