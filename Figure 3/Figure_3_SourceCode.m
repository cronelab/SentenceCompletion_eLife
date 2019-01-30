%% Figure 3
% Causal language network dynamics play a role in lexical selection: an intracranial EEG study
% Yujing Wang
% Last Modified: 01/29/2019

%% Figure 3B - blank onset alignment

% Load data and subfolders
load('Figure3B_SourceData.mat');
path('functions',path);

%% Statistical analysis - t-test

alpha = 0.05;
tail = 'left'; % Test the alternative hypothesis that the population mean of x is less than the population mean of y.
hh_ave = nan(size(HG_All_high_blank,1),1);
pp_ave = nan(size(HG_All_high_blank,1),1);
    for sampNo = 1:size(HG_All_high_blank,1)
        [h,p] = ttest2(HG_All_high_blank(sampNo,:),HG_All_low_blank(sampNo,:),'Alpha',alpha,'Tail',tail);
        hh_ave(sampNo) = h;
        pp_ave(sampNo) = p;
    end

%% plot Figure 3B

% calculate mean, standard deviation, and standard error of mean
mean_trials_high = mean(HG_All_high_blank,2);
std_trials_high = std(HG_All_high_blank,0,2);
sem_trials_high = std_trials_high./sqrt(size(HG_All_high_blank,2));

mean_trials_low = mean(HG_All_low_blank,2);
std_trials_low = std(HG_All_low_blank,0,2);
sem_trials_low = std_trials_low./sqrt(size(HG_All_low_blank,2));

% mark baseline and words timings
baselineTime = 450;
words = [50,100,150,200,250,300,350,400,450];

% only plotting post stimulus onset data
startTime = 151;
endTime = 750;

% plot data
figure(1); boundedline(1:1:size(mean_trials_low,1),mean_trials_low,sem_trials_low', 'r', 'alpha');
hold on;
boundedline(1:1:size(mean_trials_high,1),mean_trials_high,sem_trials_high', 'b', 'alpha');

% set up x and y axes + labels
xticks([0,50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800]); %PY17N013 + PY17N018
xticklabels({'-4.5','-4','-3.5','-3','-2.5','-2','-1.5','-1','-0.5','0','0.5','1','1.5','2','2.5','3','3.5'});    %PY17N013 + PY17N018

xlabel('Time(s)');
xlim([startTime endTime]);

ylabel('Activation');
y_lim = ylim;

% plot dashed lines for words
for words_loop = words
    plot([words_loop words_loop],get(gca,'ylim'),'k--');
end

% plot significance astericks
hh_chanNo = hh_ave;
hh_chanNo(hh_chanNo==0) = NaN;
plot(hh_chanNo*y_lim(2),'r*');

% plot mean response onset
plot(resp_onset_low * 100 + baselineTime, y_lim(1),'r^');
hold on;
plot(resp_onset_high * 100 + baselineTime, y_lim(1),'b^');

% add title and legend
title('All Patients, Broca Averaged, Blank Onset');
legend('CP < 0.6','CP >= 0.6','Location','northwest');

%% Figure 3C - response onset alignment

% Load data and subfolders
load('Figure3C_SourceData.mat');
path('functions',path);

%% Statistical analysis - t-test
alpha = 0.05;
tail = 'left'; % Test the alternative hypothesis that the population mean of x is less than the population mean of y.
hh_ave = nan(size(HG_All_high_resp,1),1);
pp_ave = nan(size(HG_All_high_resp,1),1);
    for sampNo = 1:size(HG_All_high_resp,1)
        [h,p] = ttest2(HG_All_high_resp(sampNo,:),HG_All_low_resp(sampNo,:),'Alpha',alpha,'Tail',tail);
        hh_ave(sampNo) = h;
        pp_ave(sampNo) = p;
    end

%% plot Figure 3C

% calculate mean, standard deviation, and standard error of mean
mean_trials_high = mean(HG_All_high_resp,2);
std_trials_high = std(HG_All_high_resp,0,2);
sem_trials_high = std_trials_high./sqrt(size(HG_All_high_resp,2));

mean_trials_low = mean(HG_All_low_resp,2);
std_trials_low = std(HG_All_low_resp,0,2);
sem_trials_low = std_trials_low./sqrt(size(HG_All_low_resp,2));

% mark baseline and words timings
baselineTime = 450;
words = [50,100,150,200,250,300,350,400,450];

% plot data
figure(2); boundedline(1:1:size(mean_trials_low,1),mean_trials_low,sem_trials_low', 'r', 'alpha');
hold on;
boundedline(1:1:size(mean_trials_high,1),mean_trials_high,sem_trials_high', 'b', 'alpha');
      
% set up x and y axes + labels
xticks([0,50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800]); %PY17N013 + PY17N018
xticklabels({'-4.5','-4','-3.5','-3','-2.5','-2','-1.5','-1','-0.5','0','0.5','1','1.5','2','2.5','3','3.5'});    %PY17N013 + PY17N018
    
xlabel('Time(s)');
startTime = 101;
endTime = size(mean_trials_low,1);
xlim([startTime endTime]);

ylabel('Activation');
y_lim = ylim;

% plot dashed lines for words
plot([baselineTime baselineTime],get(gca,'ylim'),'k--');

% plot significance astericks
hh_chanNo = hh_ave;
hh_chanNo(hh_chanNo==0) = NaN;
plot(hh_chanNo*y_lim(2),'r*');

% add title + legend
title('All Patients, Broca Averaged, Response Onset');
legend('CP < 0.6','CP >= 0.6','Location','northwest');
