function showResults(tests, threads, operation_name, save_results, save_filename_prefix)

etykiety = [1 2 5 10 20 50];
for i = 1:numel(tests)
    for j = 1:numel(tests{i})
        test_results{i}.min(j) = tests{i}(j).min;
        test_results{i}.max(j) = tests{i}(j).max;
        test_results{i}.mean(j) = tests{i}(j).mean;
        test_results{i}.std(j) = tests{i}(j).std;
        test_results{i}.throughput(j) = tests{i}(j).throughput;
        test_results{i}.server_name = tests{i}(j).server_name;
        test_results{i}.endpoint_name = tests{i}(j).endpoint_name;

        server_names{i} = tests{i}.server_name;
    end
end

%% Elapsed time
fig = figure('units','normalized','outerposition',[0 0 1 1]);
fig.PaperOrientation = 'portrait';

%subplot(2,1,1);
hold on

for i = 1:numel(test_results)
    plot(threads, test_results{i}.mean, '-x','LineWidth', 1);
end

xlim([1 50]);
set(gca, 'XScale', 'log');
set(gca, 'XTick', etykiety, 'XTickLabel', cellstr(num2str(etykiety(:))));
xlabel('number of threads');
ylabel('time [ms]');
grid on
title(['Mean elapsed time (' operation_name ')']);
legend(server_names);
legend('Location', 'best');

if save_results
    exportgraphics(gcf, [save_filename_prefix '_elapsed_time.png'], 'Resolution', 300);
end

%% Throughput

fig = figure('units','normalized','outerposition',[0 0 1 1]);
fig.PaperOrientation = 'portrait';

%subplot(2,1,2);
hold on;

for i = 1:numel(test_results)
    plot(threads, test_results{i}.throughput,'-x','LineWidth', 1);
end

xlim([1 50]);
set(gca, 'XScale', 'log');
set(gca, 'XTick', etykiety, 'XTickLabel', cellstr(num2str(etykiety(:))));
xlabel('number of threads');
ylabel('number of processed requests');
grid on
title(['Throughput - processed requests per second (' operation_name ')'] );
legend(server_names);
legend('Location', 'best');

if save_results
    exportgraphics(gcf, [save_filename_prefix '_throughput.png'], 'Resolution', 300);
end

%% Elapsed time - more statistics
%{
fig = figure('units','normalized','outerposition',[0 0 1 1]);
fig.PaperOrientation = 'portrait';

semilogx(threads, test1_results.min, '-bo', threads, test2_results.min, '-bx',...
    threads, test1_results.max, '-ro', threads, test2_results.max, '-rx',...
    threads, test1_results.mean, '-go', threads, test2_results.mean, '-gx',...
    threads, test1_results.std, '-ko', threads, test2_results.std, '-kx');

xlabel('number of threads');
ylabel('time [ms]');
grid on
title(['Statistics for elapsed time[ms] - ' test1_results.endpoint_name ' vs ' test2_results.endpoint_name ' (' operation_name ')'] );
legend(['min (' test1_results.server_name ')'], ['min (' test2_results.server_name ')'], ['max (' test1_results.server_name ')'], ['max (' test2_results.server_name ')'], ['mean (' test1_results.server_name ')'], ['mean (' test2_results.server_name ')'], ['std (' test1_results.server_name ')'], ['std (' test2_results.server_name ')']);

if save_results
    saveas(gcf, 'stats.png');
end
%}

%% Histograms
%{
for i = 1:numel(test1)
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    fig.PaperOrientation = 'portrait';
    hold on
    
    range_test1 = test1(i).max - test1(i).min;
    bin_width = range_test1/64;
    edges_test1 = test1(i).min:bin_width:test1(i).max + bin_width;
    edges_test2 = test2(i).min:bin_width:test2(i).max + bin_width;
    
    histogram(test1(i).elapsed, edges_test1);
    histogram(test2(i).elapsed, edges_test2);
    title(['Histogram of elapsed time (' operation_name ' - ' num2str(threads(i)) ' threads)']);
    legend(test1_results.server_name, test2_results.server_name);
    ylabel('Counts');
    xlabel('Elapsed time [ms]');
    if save_results
        saveas(gcf, ['histogram_' num2str(threads(i)) '.png']);
        set(gca, 'YScale', 'log')
        saveas(gcf, ['histogram_log_' num2str(threads(i)) '.png']);
    end
end
%}
end