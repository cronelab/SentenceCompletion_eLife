%% Figure 2 
% Causal language network dynamics play a role in lexical selection: an intracranial EEG study
% Yujing Wang
% Last Modified: 01/29/2019

% Load data and subfolders

load('Figure2_SourceData.mat');
path('functions',path);
PtNo = 1;
channelNames = {'LFPG12','LFPG128'}; % channel names

%% Statistical analysis - t-test

alpha = 0.05;
tail = 'left'; % Test the alternative hypothesis that the population mean of x is less than the population mean of y.

hh = nan(size(HG_High,1),size(HG_High,2));
pp = nan(size(HG_High,1),size(HG_High,2));

for chanNo = 1:size(HG_High,1)
    for sampNo = 1:size(HG_High,2)
        [h,p] = ttest2(HG_High(chanNo,sampNo,:),HG_Low(chanNo,sampNo,:),'Alpha',alpha,'Tail',tail);
        hh(chanNo, sampNo) = h;
        pp(chanNo, sampNo) = p;
    end
end

%% Plot Figures 2B and 2C

% calculate mean, standard deviation, and standard error of mean
mean_trials_high = mean(HG_High(:,:,:),3);
std_trials_high = std(HG_High(:,:,:),0,3);
sem_trials_high = std_trials_high./sqrt(size(HG_High,3));

mean_trials_low = mean(HG_Low(:,:,:),3);
std_trials_low = std(HG_Low(:,:,:),0,3);
sem_trials_low = std_trials_low./sqrt(size(HG_Low,3));

% mark baseline and words timings
baselineTime = 450;
words = [50,100,150,200,250,300,350,400,450]; 

for chanNo = 1:numel(channelNames)
    
    % only plotting post stimulus onset data
    startTime = 151;
    endTime = 750;
    
    % plot data
    figure(chanNo); boundedline(1:1:size(mean_trials_low,2),mean_trials_low(chanNo,:),sem_trials_low(chanNo,:), 'r', 'alpha');
    hold on;
    boundedline(1:1:size(mean_trials_high,2),mean_trials_high(chanNo,:),sem_trials_high(chanNo,:), 'b', 'alpha');
    
    % set up x and y axes + labels
    xticks([0,50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800]);
    xticklabels({'-4.5','-4','-3.5','-3','-2.5','-2','-1.5','-1','-0.5','0','0.5','1','1.5','2','2.5','3','3.5'});
    
    xlabel('Time(s)');
    xlim([startTime endTime]);
    
    ylabel('Activation');
    y_lim = ylim;
        
    % plot dashed lines for words
    for words_loop = words
        plot([words_loop words_loop],get(gca,'ylim'),'k--');
    end
        
    % plot significance astericks
    hh_chanNo = hh(chanNo,:);
    hh_chanNo(hh_chanNo==0) = NaN;
    plot(hh_chanNo*y_lim(2),'r*');
    
    % plot mean response onset
    plot(resp_onset_low * 100 + baselineTime, y_lim(1),'r^');
    hold on;
    plot(resp_onset_high * 100 + baselineTime, y_lim(1),'b^');
    
    % add title and legend
    title(['Patient ' num2str(PtNo) ', ' char(channelNames(chanNo))]);
    legend('CP < 0.6','CP >= 0.6','Location','northwest');
 
end
