%% Figure 5B
% Causal language network dynamics play a role in lexical selection: an intracranial EEG study
% Yujing Wang
% Last Modified: 01/29/2019

% Load data and subfolders
load('Figure5B_SourceData.mat');
path('functions',path);
ROInames={'Broca''s', 'Wernicke''s'};

% make figure fullscreen
figure('units','normalized','outerposition',[0 0 1 1]);

% plot subplots for each direction
for ROINo_from = 1:numel(ROIs)
    for ROINo_to = 1:numel(ROIs)
        
        % average ERC values under a certain direction
        ERC_ROI_High_Ave = ERC_ROI_High_All{ROINo_from,ROINo_to};
        ERC_ROI_Low_Ave = ERC_ROI_Low_All{ROINo_from,ROINo_to};
        
        % make a subplot space
        subplot(numel(ROIs),numel(ROIs),(ROINo_from-1)*numel(ROIs)+ROINo_to);
        
        % set x and y limits
        xlim([0 6]); 
        ylim([0 2]); 
        
        % plot word dashlines
        words = [0.5,1,1.5,2,2.5,3];
        for words_loop = words
            plot([words_loop words_loop],get(gca,'ylim'),'k--');
            hold on;
        end
        
        % print ticks and lables
        xticks([0,0.5,1,1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7]);
        xticklabels({'-3','-2.5','-2','-2.5','-1','-1.5','0','0.5','1','1.5','2','2.5','3','3.5','4'});
        xlabel('Time(s)');
        ylabel('Intensity');
        
        % plot averaged ERC flows for high and low CP
        if ~isempty(ERC_ROI_High_Ave)
            % calculate mean, standard deviation, and standard error of mean
            mean_ERC_ROI_High = nanmean(ERC_ROI_High_Ave,1);
            std_ERC_ROI_High = nanstd(ERC_ROI_High_Ave,0,1);
            sem_ERC_ROI_High = std_ERC_ROI_High./sqrt(size(ERC_ROI_High_Ave,1));
            
            mean_ERC_ROI_Low = nanmean(ERC_ROI_Low_Ave,1);
            std_ERC_ROI_Low = nanstd(ERC_ROI_Low_Ave,0,1);
            sem_ERC_ROI_Low = std_ERC_ROI_Low./sqrt(size(ERC_ROI_Low_Ave,1));
            
            % plot data
            time1 = time(11:end);
            boundedline(time1,mean_ERC_ROI_High(11:end),sem_ERC_ROI_High(11:end),'b','alpha');
            hold on;
            boundedline(time1,mean_ERC_ROI_Low(11:end),sem_ERC_ROI_Low(11:end),'r','alpha');
        end
        
        xlim([0 6]);  % all time
        ylim([0 2]); % Norm
        
        % response onset plot
        y_lim = ylim;
        plot(1.5109+3, y_lim(1),'r^');  %low
        hold on;
        plot(1.2951+3, y_lim(1),'b^');  %high
        
        % Statistical analysis - t-test
        stats = 'ttest';
        alpha = 0.05;
        tail1 = 'left'; % Test the alternative hypothesis that the population mean of x is less than the population mean of y.
        tail2 = 'right';
        
        hh_ave = nan(size(ERC_ROI_Low_Ave,2),1);
        pp_ave = nan(size(ERC_ROI_Low_Ave,2),1);
        for sampNo = 1:size(ERC_ROI_Low_Ave,2)
            if contains(stats,'ttest')
                [h1,p1] = ttest2(ERC_ROI_High_Ave(:,sampNo),ERC_ROI_Low_Ave(:,sampNo),'Alpha',alpha,'Tail',tail1);
                [h2,p2] = ttest2(ERC_ROI_High_Ave(:,sampNo),ERC_ROI_Low_Ave(:,sampNo),'Alpha',alpha,'Tail',tail2);
                h11 = fdr_bh(p1);     % fdr correction
                h22 = fdr_bh(p2);
            elseif contains(stats,'Wilcoxon')
                [p1,h1] = signrank(ERC_ROI_High_Ave(:,sampNo),ERC_ROI_Low_Ave(:,sampNo),'Alpha',alpha,'Tail',tail1);
                [p2,h2] = signrank(ERC_ROI_High_Ave(:,sampNo),ERC_ROI_Low_Ave(:,sampNo),'Alpha',alpha,'Tail',tail2);
                h11 = fdr_bh(p1);     % fdr correction
                h22 = fdr_bh(p2);
            end
            hh_ave1(sampNo) = h11;
            hh_ave2(sampNo) = h22;
        end
        
        hh_chanNo1 = hh_ave1;
        hh_chanNo1(hh_chanNo1==0) = NaN;
        hh_chanNo2 = hh_ave2;
        hh_chanNo2(hh_chanNo2==0) = NaN;
        y_lim = ylim;
        
        % plot significance astericks
        if ~isempty(hh_chanNo1)
            plot(time1, hh_chanNo1(11:end)*y_lim(2),'r*');
        end
        
        % Add sub-titles to subplots
        title([ROInames{ROINo_from} ' -> ' ROInames{ROINo_to}],'fontsize',20);
        set(gca,'fontsize',15);
    end
end