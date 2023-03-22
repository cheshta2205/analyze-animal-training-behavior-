%after running X:\Lab\dms_lesion\code\fit_behav_model_v4.py
%kiah,cheshta - 2 august, 2022

%% clear workspace

clear all; close all; clc

%% load the data from model

% load animal folder - CHANGE FOR DIFF ANIMALS
%for dms lesion 1 - j7_jasmine

%forcontrol2 j3jelly
animal_folder = 'X:\Lab\dms_lesion\data\control rat_j3_jelly\model_output';
session_folder = 'model_output';

%for dms lesion 1 - j5_joy
% animal_folder = 'X:\Lab\dms_lesion\data\dmslrat_j5_joy\model_output';
% session_folder = 'model_output';

% load the model weights
weightleft = readtable([animal_folder,filesep,'lefttapweights.csv']);
weightlefttap = weightleft(2:end,2:end);
weightlefttap = weightlefttap.Variables;

weightright = readtable([animal_folder,filesep,'righttapweights.csv']);
weightrighttap = weightright(2:end,2:end);
weightrighttap = weightrighttap.Variables;

weightcenter = readtable([animal_folder,filesep,'centtapweights.csv']);
weightcentertap = weightcenter(2:end,2:end);
weightcentertap = weightcentertap.Variables;

% weight names
factors = {'CueLeft','CueCenter','CueRight', 'CueLeft_1','CueCenter_1','CueRight_1','Reward_1L','Reward_1C','Reward_1R','noRew_L_1','noRew_C_1','noRew_R_1','bias'};
factor_count = size(factors,2);

% load the score
score= readtable([animal_folder,filesep,'score_full.csv']);
score = score.Variables; score = score(2:end,2);

% load the current cue only score
cue_score = readtable([animal_folder,filesep,'score_cue.csv']);
cue_score = cue_score.Variables; cue_score = cue_score(2:end,2);

% load the previous action only score
act_score = readtable([animal_folder,filesep,'score_act.csv']);
act_score = act_score.Variables; act_score = act_score(2:end,2);

% load the previous cue only score
prevcue_score = readtable([animal_folder,filesep,'score_prevcue_avg.csv']);
prevcue_score = prevcue_score.Variables; prevcue_score = prevcue_score(2:end,2);

% load the null score
null_score= readtable([animal_folder,filesep,'score_null.csv']);
null_score = null_score.Variables; null_score = null_score(2:end,2);

% load the behavioral data

load([animal_folder,filesep,'ratBEHstruct.mat']);

%and columns with factors whose weight we will compute
length_rows = nan(length(ratBEHstruct),1);
for i = 1:length(ratBEHstruct)
    length_rows(i) = length(ratBEHstruct(i).cuedNames);
end
discard_rows = find(length_rows == 1);

%remove these rows from behstruct
ratBEHstruct_updated = ratBEHstruct();
ratBEHstruct_updated(discard_rows) = [];
trial_count = nan(length(ratBEHstruct_updated),1);
for k = 1:length(ratBEHstruct_updated)
    trial_count(k) = length(ratBEHstruct_updated(k).pokeNames);
end
low_trials = find(trial_count<39);
%modification for d6
for k = 1:length(ratBEHstruct_updated)
    allhits{1,k} = ratBEHstruct_updated(k).Hit;
end
allhits_together = cell2mat(allhits);
% divide into 12 sections:
idx_mat = 1:100:5236; 
idx_mat(end) =  size(allhits_together,2);
new_hits = cell(1,length(idx_mat));
for i = 1:length(idx_mat)
    if i ~= length(idx_mat) 
new_hits{:,i} = allhits_together(:,idx_mat(i):idx_mat(i+1)-1);
    else
new_hits{:,i} = allhits_together(:,idx_mat(i):end);
end
end
% 
new_hits(end) = [];
for k = 1:length(new_hits)
mean_hits(1,k) = mean(new_hits{1,k});
end
hitmean_touse = mean_hits;
% hitmean_touse(:,low_trials)=[];

% mean_hits = nan(length(ratBEHstruct_updated),1);
% for k = 1:length(ratBEHstruct_updated)
%     mean_hits(k) = mean(ratBEHstruct_updated(k).Hit);
% en hitmean_touse = mean_hits;
% hitmean_touse(:,low_trials)=[];
% hitmean_touse(:,1) = [];

%% plot

% model score and rat accuracy (basically plotting scorres to see which
% model can predict behavior best)
figure(1)
plot(score,'-r.','Markersize',15, LineWidth=2);
hold on
plot(cue_score,'-b.','Markersize',15,LineWidth=2);
plot(act_score,'-m.','Markersize',15,LineWidth=2);
plot(null_score,'-k.','Markersize',15,LineWidth=2);
plot(hitmean_touse,'-g.','Markersize',15,LineWidth=2);
ylabel('Accuracy')
xlabel('Session no.')
ylim([0 1])
hold on
legend('full model','cue+bias','action+bias','bias-only','rat')
h2 = gca 
h2.XAxis.LineWidth = 5;
h2.YAxis.LineWidth = 5;
h2.XAxis.FontSize = 15;
h2.YAxis.FontSize = 15;
hold off 

% compare the contribution of previous actions and the cues to the full (by plotting scores of models trained only on cue info vs past history)
figure(10)
plot(smoothdata(1-(score - act_score)./(score-null_score),'gauss',5),'-r.','Markersize',15,LineWidth =3);
hold on
plot(smoothdata(1-(score - cue_score)./(score-null_score),'gauss',5) ,'-b.','Markersize',15,LineWidth =3);
hold off
box off
h2 = gca 
h2.XAxis.LineWidth = 5;
h2.YAxis.LineWidth = 5;
h2.XAxis.FontSize = 15;
h2.YAxis.FontSize = 15;
hold off 
legend('contribution of previous actions','contribution of current cues')
ylabel('Factor contribution')
xlabel('Session no.')

figure(11)
plot(smoothdata(1-(score - act_score)./(score-null_score),'gauss',5),'-r.','Markersize',15, LineWidth =3);
hold on
plot(smoothdata(1-(score - cue_score)./(score-null_score),'gauss',5) ,'-b.','Markersize',15, LineWidth =3);
hold on
plot(smoothdata(1-(score - prevcue_score)./(score-null_score),'gauss',5) ,'-g.','Markersize',15, LineWidth =3);

box off
h2 = gca 
h2.XAxis.LineWidth = 5;
h2.YAxis.LineWidth = 5;
h2.XAxis.FontSize = 15;
h2.YAxis.FontSize = 15;
hold off 
ylabel('Factor contribution')
xlabel('Session no.')
legend('contribution of previous actions','contribution of current cues','contribution of previous cues')

%% plot the weights
groups_cue = 1:6;
groups_rewards = 7:13;
weights_left_cue = weightlefttap(:,groups_cue);
weights_left_reward= weightlefttap(:,groups_rewards);
weights_center_cue = weightcentertap(:,groups_cue);
weights_center_reward= weightcentertap(:,groups_rewards);
weights_right_cue = weightrighttap(:,groups_cue);
weights_right_reward= weightrighttap(:,groups_rewards);
c = distinguishable_colors(25);

%% plot the cue-related weights for all levers
figure(2)

% left tap
subplot(3,1,1)
hold on
for k = 1:length(groups_cue)
    plot(smoothdata(weights_left_cue(:,k),'gauss',5),'MarkerSize',10,'LineWidth',2,'Color',c(k,:));
    hold on
end
legend(factors(groups_cue))
ylabel('Weights')
xlabel('Session')
title('Left tap')
hold off

% center tap
subplot(3,1,2)
for k = 1:length(groups_cue)
    plot(smoothdata(weights_center_cue(:,k),'gauss',5),'MarkerSize',10,'LineWidth',2,'Color',c(k,:));
    hold on
end
legend(factors(groups_cue))
ylabel('Weights')
xlabel('Session')
title('Center tap')
hold off

% right tap
subplot(3,1,3)

for k = 1:length(groups_cue)
    plot(smoothdata(weights_right_cue(:,k),'gauss',5),'MarkerSize',10,'LineWidth',2,'Color',c(k,:));
    hold on
end
legend(factors(groups_cue))
ylabel('Weights')
xlabel('Session')
title('Right tap')
hold on
box off
h2 = gca 
h2.XAxis.LineWidth = 5;
h2.YAxis.LineWidth = 5;
h2.XAxis.FontSize = 15;
h2.YAxis.FontSize = 15;
hold off 

% center tap
subplot(3,1,2)
for k = 1:length(groups_cue)
    plot(smoothdata(weights_center_cue(:,k),'gauss',5),'MarkerSize',10,'LineWidth',2,'Color',c(k,:));
    hold on
end
legend(factors(groups_cue))
ylabel('Weights')
xlabel('Session')
title('Center tap')
hold off
%% plot the cue-related weights for all levers
figure(2)

% left tap
subplot(3,1,1)
hold on
for k = 1:length(groups_cue)
    plot(smoothdata(weights_left_cue(:,k),'gauss',5),'MarkerSize',10,'LineWidth',2,'Color',c(k,:));
    hold on
end
legend(factors(groups_cue))
ylabel('Weights')
xlabel('Session')
title('Left tap')
hold on
%% plot the cue-related weights for all levers
figure(2)

% left tap
subplot(3,1,1)
hold on
for k = 1:length(groups_cue)
    plot(smoothdata(weights_left_cue(:,k),'gauss',5),'MarkerSize',10,'LineWidth',2,'Color',c(k,:));
    hold on
end
legend(factors(groups_cue))
ylabel('Weights')
xlabel('Session')
title('Left tap')
hold on
box off
h2 = gca 
h2.XAxis.LineWidth = 5;
h2.YAxis.LineWidth = 5;
h2.XAxis.FontSize = 15;
h2.YAxis.FontSize = 15;
hold off 


% center tap
subplot(3,1,2)
for k = 1:length(groups_cue)
    plot(smoothdata(weights_center_cue(:,k),'gauss',5),'MarkerSize',10,'LineWidth',2,'Color',c(k,:));
    hold on
end
legend(factors(groups_cue))
ylabel('Weights')
xlabel('Session')
title('Center tap')
hold on
box off
h2 = gca 
h2.XAxis.LineWidth = 5;
h2.YAxis.LineWidth = 5;
h2.XAxis.FontSize = 15;
h2.YAxis.FontSize = 15;
hold off 


% right tap
subplot(3,1,3)

for k = 1:length(groups_cue)
    plot(smoothdata(weights_right_cue(:,k),'gauss',5),'MarkerSize',10,'LineWidth',2,'Color',c(k,:));
    hold on
end
legend(factors(groups_cue))
ylabel('Weights')
xlabel('Session')
title('Right tap')
hold on
box off
h2 = gca 
h2.XAxis.LineWidth = 5;
h2.YAxis.LineWidth = 5;
h2.XAxis.FontSize = 15;
h2.YAxis.FontSize = 15;
hold off 


%% plot reward related cues

figure(3)
subplot(3,1,1)
% left tap
for k = 1:length(groups_rewards)
    plot(smoothdata(weights_left_reward(:,k),'gauss',5),'MarkerSize',10,'LineWidth',2,'Color',c(k,:));
    hold on
end
legend(factors(groups_rewards))
ylabel('Weights')
xlabel('Session')
title('Left tap')
hold on
box off
h2 = gca 
h2.XAxis.LineWidth = 5;
h2.YAxis.LineWidth = 5;
h2.XAxis.FontSize = 15;
h2.YAxis.FontSize = 15;
hold on

% center tap
subplot(3,1,2)

for k = 1:length(groups_rewards)
    plot(smoothdata(weights_center_reward(:,k),'gauss',5),'MarkerSize',10,'LineWidth',2,'Color',c(k,:));
    hold on
end
legend(factors(groups_rewards))
ylabel('Weights')
xlabel('Session')
title('Center tap')
hold on
box off
h2 = gca 
h2.XAxis.LineWidth = 5;
h2.YAxis.LineWidth = 5;
h2.XAxis.FontSize = 15;
h2.YAxis.FontSize = 15;
hold on 


% right tap
subplot(3,1,3)
for k = 1:length(groups_rewards)
    plot(smoothdata(weights_right_reward(:,k),'gauss',5),'MarkerSize',10,'LineWidth',2,'Color',c(k,:));
    hold on
end
legend(factors(groups_rewards))
ylabel('Weights')
xlabel('Session')
title('Right tap')
hold on
box off
h2 = gca 
h2.XAxis.LineWidth = 5;
h2.YAxis.LineWidth = 5;
h2.XAxis.FontSize = 15;
h2.YAxis.FontSize = 15;
hold off 


%% alternate plotting - plot the three levers together, for each weight

figure(4)
for k = 1:13
    subplot(3,5,k)
    plot(smoothdata(weightlefttap(:,k),'gauss',5),'MarkerSize',10,'LineWidth',2,'Color','b');
    hold on
    plot(smoothdata(weightcentertap(:,k),'gauss',5),'MarkerSize',10,'LineWidth',2,'Color','k');
    plot(smoothdata(weightrighttap(:,k),'gauss',5),'MarkerSize',10,'LineWidth',2,'Color','r');
    hold off
    box off
    title(factors{k})
    h2 = gca 
h2.XAxis.LineWidth = 5;
h2.YAxis.LineWidth = 5;
h2.XAxis.FontSize = 15;
h2.YAxis.FontSize = 15;
hold off 
end

