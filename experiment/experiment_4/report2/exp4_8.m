clear all;
answer = readmatrix("exp4i_g06_2026.csv");
trial = 20;
margeC = zeros(250, trial+1);
margeC(:, 1) = (-996:4:0); 

figure; 

for i = 1:trial
    csv = readmatrix(['g06_2026.asc_TRIAL_',num2str(i),'.csv']);
    [nrow, ncol] = size(csv);
    ms = (csv(1,1):4:csv(end,1))';
    expos = zeros(size(ms, 1), 5);
    expos(:, 1) = ms - ms(end);     
    
    expos(:, 2:5) = -1;
    ok = ismember(ms, csv(:, 1))';
    
    expos(ok,2) = csv(:,3);
    expos(ok, 5) = csv(:, 4);
    
    center = expos(expos(:,2) == 1, 5);
    ctr = mean(expos(:,5));
    
    left = expos(:, 2) == 2 & expos(:, 5) ~= -1 & expos(:, 5) < ctr;
    right = expos(:, 2) == 2 & expos(:, 5) ~= -1 & expos(:, 5) >= ctr;
    expos(left, 3) = 52;
    expos(right, 3) = 54;

    answ = answer(i, 2);
    expos((expos(:,2) == 2 & expos(:, 5) ~= -1 & expos(:, 3) == answ), 4) = 1;
    expos((expos(:,2) == 2 & expos(:, 5) ~= -1 & expos(:, 3) ~= answ), 4) = 0;

    subplot(5, 4, i);
    plot(expos(:,1), expos(:, 5));
    xlabel('Time [ms]');
    ylabel('X Coordinate');

    plot_x = -996 <= expos(:, 1);
    margeC(:, i+1) = expos(plot_x, 4);
end

saveas(gcf, 'EyeTracking_01_GazePosition_AllTrials.png');

percent = zeros(250, 1); 
margeT = zeros(1, trial); 

for i = 1:250
    margeT=margeC(i, 2:end);
    oktrial=(margeT ~= -1);
    percent(i) = mean(margeT(oktrial));
end

figure
time = margeC(:,1);
plot(time,percent);  
xlabel("選択までの時間 [ms]")
ylabel("選択する顔に対する注視の確率 [%]")

saveas(gcf, 'EyeTracking_02_Cascade_Probability.png');
