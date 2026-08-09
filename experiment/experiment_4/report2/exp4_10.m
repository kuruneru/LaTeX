idn=1280391;
group=10;
task=0;
taskNo=0;
dataBlocks=open_EMG('g_03_10.txt');

figure;
subplot(4, 1, 1);
plot(dataBlocks{1, 1}(:,1), dataBlocks{1, 1}(:,2));
xlabel('Time [s]');
ylabel('EMG [V]');
subplot(4, 1, 2);
plot(dataBlocks{1, 2}(:,1), dataBlocks{1, 2}(:,2));
xlabel('Time [s]');
ylabel('EMG [V]');
subplot(4, 1, 3);
plot(dataBlocks{1, 3}(:,1), dataBlocks{1, 3}(:,2));
xlabel('Time [s]');
ylabel('EMG [V]');
subplot(4, 1, 4);
plot(dataBlocks{1, 4}(:,1), dataBlocks{1, 4}(:,2));
xlabel('Time [s]');
ylabel('EMG [V]');
saveas(gcf, 'EMG_01_RawData_Overview.png');

results=zeros(4,1);
taskNo=2;
task = checkTask(results,idn,group,taskNo);

bmvcdata=mean(dataBlocks{1, 1}(101:200,2));
bmvcdata=dataBlocks{1, 1}(:,2) - bmvcdata;
taskNo=3;
task = checkTask(bmvcdata,idn,group,taskNo);

rbmvcdata=abs(bmvcdata);
taskNo=4;
task = checkTask(rbmvcdata,idn,group,taskNo);

maxmvc=max(rbmvcdata);
taskNo=5;
task = checkTask(maxmvc,idn,group,taskNo);
results(1,1)=maxmvc;

for i=1:3
    bdata=mean(dataBlocks{1, i+1}(101:200,2));
    bdata=dataBlocks{1, i+1}(:,2) - bdata;
    taskNo=6;
    if i==1, task = checkTask(bdata,idn,group,taskNo); end

    rbdata=abs(bdata);
    taskNo=7;
    if i==1, task = checkTask(rbdata,idn,group,taskNo); end

    fs = 1000;
    fc = 5;
    [b, a]=butter(2,[fc/(fs/2)],'low');
    frbdata=filtfilt(b,a,rbdata);

    hold on;
    plot(rbdata);
    plot(frbdata);
    hold off
    xlabel('Samples');
    ylabel('EMG [V]');
    saveas(gcf, ['EMG_02_Rectified_vs_Filtered_Condition_' num2str(i) '.png']);
    
    figure
    window = 1000;
    [~, maxIdx] = max(frbdata);
    startSearch = maxIdx;
    endSearch = length(frbdata);
    minVar = inf;
    startIndex = startSearch;

    for j = startSearch : endSearch - window + 1
        temp = frbdata(j:j+window-1);
        if var(temp) < minVar
            minVar = var(temp);
            startIndex = j;
        end
    end

    stableData = frbdata(startIndex:startIndex+window-1);
    meanemg = mean(stableData);
    taskNo=9;
    if i==1, task = checkTask(meanemg,idn,group,taskNo); end

    plot(dataBlocks{i+1}(:,1), frbdata, 'b')
    hold on
    plot(dataBlocks{i+1}(startIndex:startIndex+window-1,1), stableData,'r','LineWidth',2)
    xlabel('Time [s]')
    ylabel('EMG [V]')
    title(['Condition ' num2str(i)])
    legend('Filtered EMG','Selected 1000 ms')
    grid on
    saveas(gcf, ['EMG_03_Stable_1000ms_Condition_' num2str(i) '.png']);

    figure
    nmeanemg=meanemg / maxmvc;
    taskNo=11;
    if i==1, task = checkTask(nmeanemg,idn,group,taskNo); end

    results(i+1)=nmeanemg;
    taskNo=12;
    if i==1, task = checkTask(results,idn,group,taskNo); end
end

dumbbell_weights = [5, 10, 15]; 
bar(dumbbell_weights, results(2:4, 1));
xlabel('Dumbbell Weight [kg]');
ylabel('Normalized EMG [%MVC]');
title('Relationship between Dumbbell Weight and Muscle Activity');
grid on;
saveas(gcf, 'EMG_04_Normalized_Activity_BarChart.png');

if ~isempty(task)
    ch_Pr(idn,task,taskNo)
end
