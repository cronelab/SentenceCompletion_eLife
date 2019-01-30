%% Figure 4
% Causal language network dynamics play a role in lexical selection: an intracranial EEG study
% Yujing Wang
% Last Modified: 01/29/2019

%% Figure 4A - blank onset alignment

% Load data and subfolders
load('Figure4A_SourceData.mat');

% calculate mean, standard deviation, and standard error of mean for each
% bin of Cloze Probability
for n = 2:9
    meanHG_cp(:,n-1) = nanmean(HG_ave(GroupNumber==n & GoodTrials==1));
    stdHG_cp(:,n-1) = nanstd(HG_ave(GroupNumber==n & GoodTrials==1));
    semHG_cp(:,n-1) = stdHG_cp(:,n-1)./sqrt(length(HG_ave(GroupNumber==n & GoodTrials==1)));
end

% plot average high gamma activity and error bars
figure;
CP_bin = 0.2:0.1:0.9;
errorbar(CP_bin,meanHG_cp,semHG_cp,'-k');
hold on;
plot(CP_bin,meanHG_cp,'linewidth',2,'color',[0 0.6 0],'marker','.','markersize',20);

% fit a linear regression model
mdl = fitlm(CP_bin,meanHG_cp);

% r^2 for the model fit
r_square = mdl.Rsquared.Ordinary;
annotation('textbox',[.7 .7 .2 .2], 'String',['R^2 = ' num2str(r_square)],'FitBoxToText','on');

% use the estimated coefficients to plot the dashed line
a = mdl.Coefficients.Estimate(2);
b = mdl.Coefficients.Estimate(1);
x = 0.1:0.1:1;
plot(x, a*x+b,'k--','linewidth',1.5);

% set x and y limits
xlim([0.15 0.95]);
ylim([2 9]);

% add labels and title
xlabel('Cloze Probability');
ylabel('Activation');
title('All Patients, Broca Averaged, Blank Onset');

%% Figure 4B - response onset alignment

% Load data and subfolders
load('Figure4B_SourceData.mat');

% calculate mean, standard deviation, and standard error of mean for each
% bin of Cloze Probability
for n = 2:9
    meanHG_cp(:,n-1) = nanmean(HG_ave(GroupNumber==n & GoodTrials==1));
    stdHG_cp(:,n-1) = nanstd(HG_ave(GroupNumber==n & GoodTrials==1));
    semHG_cp(:,n-1) = stdHG_cp(:,n-1)./sqrt(length(HG_ave(GroupNumber==n & GoodTrials==1)));
end

% plot average high gamma activity and error bars
figure;
CP_bin = 0.2:0.1:0.9;
errorbar(CP_bin,meanHG_cp,semHG_cp,'-k');
hold on;
plot(CP_bin,meanHG_cp,'linewidth',2,'color',[0 0.6 0],'marker','.','markersize',20);

% fit a linear regression model
mdl = fitlm(CP_bin,meanHG_cp);

% r^2 for the model fit
r_square = mdl.Rsquared.Ordinary;
annotation('textbox',[.7 .7 .2 .2], 'String',['R^2 = ' num2str(r_square)],'FitBoxToText','on');

% use the estimated coefficients to plot the dashed line
a = mdl.Coefficients.Estimate(2);
b = mdl.Coefficients.Estimate(1);
x = 0.1:0.1:1;
plot(x, a*x+b,'k--','linewidth',1.5);

% set x and y limits
xlim([0.15 0.95]);
ylim([2 9]);

% add labels and title
xlabel('Cloze Probability');
ylabel('Activation');
title('All Patients, Broca Averaged, Response Onset');
