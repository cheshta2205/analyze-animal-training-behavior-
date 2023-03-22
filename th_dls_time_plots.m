%plots thalamostriatal time taken pre/post surgery to estimate kinematics 
%for both ot only and full task
%i'll try to find trial times.. 
%load ratBHstruct
%OT only 
%load e8_103, then j8_106, then l1_life
%1. E8 - 103
%FIND SURGERY DAY
%WAS 10TH NOVEMBER 
%SO EXCLUDE 1068 TO 1100
% TAKE 150 SESSIONS BEFORE AND AFTER LESION AND COMPUTE TRIAL TIMES 
load('D:\Rats_in_Training\E8_output\Results-E8-Rat103\ratBEHstruct.mat');
surgery_e8 = 1067;
surgery_post_e8 = 1101;%hardcoded for animal
window_ot = 150;
%select prepost surgery
prerange = surgery_e8 - window_ot:surgery_e8;
postrange = surgery_post_e8:surgery_post_e8 + window_ot;

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
end
%find rewarded trials 
for k = 1:length(ratBEHstruct)
    rewards{1,k} = find(combined_hits{1,k} == 1);
end

%filter out all times  
for k =1:length(ratBEHstruct)
all_times{1,k} = ratBEHstruct(k).pokeTimes;
end

%filter out times of rewarded trials 
for k = 1:length(ratBEHstruct)
for g = 1:length(rewards{1,k})
filter_times{1,k}{1,g} = all_times{1,k}{1,rewards{1,k}(1,g)};
end
end

%first filter out sessions we need
trials_pre = filter_times(prerange);
trials_post = filter_times(postrange);
trialtime_pre = trials_pre;
trialtime_post = trials_post;
trialtime_pre = trialtime_pre(~cellfun('isempty',trialtime_pre));
trialtime_post= trialtime_post(~cellfun('isempty',trialtime_post));

for kk = 1:length(trialtime_pre)
time_selected_pre{1,kk} = trialtime_pre{1,kk}(~cellfun('isempty',trialtime_pre{1,kk}));
end

%find trial time pre surgery
for k = 1:length(time_selected_pre)
for g = 1:length(time_selected_pre{1,k})
finaltrialtime_pre{1,k}{1,g} = time_selected_pre{1,k}{1,g}(end,:)-time_selected_pre{1,k}{1,g}(1,1);
end
end

for kk = 1:length(trialtime_post)
time_selected_post{1,kk} = trialtime_post{1,kk}(~cellfun('isempty',trialtime_post{1,kk}));
end

%find trial time post surgery
for kk = 1:length(time_selected_post)
for gg = 1:length(time_selected_post{1,kk})
finaltrialtime_post{1,kk}{1,gg} = time_selected_post{1,kk}{1,gg}(end,:)-time_selected_post{1,kk}{1,gg}(1,1);
end
end

%avg it, pre 
for k = 1:length(finaltrialtime_pre)
    mean_pretimes{1,k} = mean(cell2mat(finaltrialtime_pre{1,k}));
end 

%avg it, post
for kk = 1:length(finaltrialtime_post)
    mean_posttimes{1,kk} = mean(cell2mat(finaltrialtime_post{1,kk}));
end

mean_pre_final = mean(cell2mat(mean_pretimes));
mean_post_final = mean(cell2mat(mean_posttimes));
%significance test 
htest = ttest2(cell2mat(mean_pretimes),cell2mat(mean_posttimes));
%significant 
%plot it 

figure(1)
clr_lg = [0.4660, 0.6740, 0.1880];
clr_dg = [0, 0.5, 0];
condition = {'Pre';'Post'};
%plot avg accuracies in dmsl vs control
sd_pre = std(cell2mat(mean_pretimes));
sd_post = std(cell2mat(mean_posttimes));
sem_pre_3 = sd_pre./sqrt(length(mean_pretimes));
sem_post_3 = sd_post./sqrt(length(mean_posttimes));
xaxis_bar = [0.5,1];
condition = {'Pre';'Post'};
yaxis_time = [mean_pre_final;mean_post_final];
hBar = bar(xaxis_bar,yaxis_time,'FaceColor','flat')
hold on 
hBar.CData(1,:) = clr_lg;
hBar.CData(2,:) = clr_dg;
hold on
errlow = [sem_pre_3,sem_post_3];
errhigh = [sem_pre_3,sem_post_3];
er = errorbar(xaxis_bar,yaxis_time,errlow,errhigh,'k','MarkerSize',100); 
er.LineStyle = 'none';
set(er,'LineWidth',3.5)
axx = gca;
set(axx,'XTick',[0.5,1],'xticklabel',condition)
hold on 
ylabel('Trial Time (ms)','FontSize',30,'FontWeight','bold')
xlabel('Condition','FontSize',30,'FontWeight','bold')
hold on 
ylim([0 max(yaxis_time)+500]);
axx.XAxis.LineWidth = 5;
axx.YAxis.LineWidth = 5;
axx.XAxis.FontSize = 30;
axx.YAxis.FontSize = 30;
hold off 
%% animal2 ot only
%this is j8 
load('D:\Rats_in_Training\J8_output\Results-J8-Rat106\ratBEHstruct.mat');
surgery_j8 = 1185;
surgery_post_j8 = 1214;%hardcoded for animal
window_ot = 150;
%select prepost surgery
prerange = surgery_j8 - window_ot:surgery_j8;
postrange = surgery_post_j8:surgery_post_j8 + window_ot;

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
end
%find rewarded trials 
for k = 1:length(ratBEHstruct)
    rewards{1,k} = find(combined_hits{1,k} == 1);
end

%filter out all times  
for k =1:length(ratBEHstruct)
all_times{1,k} = ratBEHstruct(k).pokeTimes;
end

%filter out times of rewarded trials 
for k = 1:length(ratBEHstruct)
for g = 1:length(rewards{1,k})
filter_times{1,k}{1,g} = all_times{1,k}{1,rewards{1,k}(1,g)};
end
end

%first filter out sessions we need
trials_pre = filter_times(prerange);
trials_post = filter_times(postrange);
trialtime_pre = trials_pre;
trialtime_post = trials_post;
trialtime_pre = trialtime_pre(~cellfun('isempty',trialtime_pre));
trialtime_post= trialtime_post(~cellfun('isempty',trialtime_post));

for kk = 1:length(trialtime_pre)
time_selected_pre{1,kk} = trialtime_pre{1,kk}(~cellfun('isempty',trialtime_pre{1,kk}));
end

%find trial time pre surgery
for k = 1:length(time_selected_pre)
for g = 1:length(time_selected_pre{1,k})
finaltrialtime_pre{1,k}{1,g} = time_selected_pre{1,k}{1,g}(end,:)-time_selected_pre{1,k}{1,g}(1,1);
end
end

for kk = 1:length(trialtime_post)
time_selected_post{1,kk} = trialtime_post{1,kk}(~cellfun('isempty',trialtime_post{1,kk}));
end

%find trial time post surgery
for kk = 1:length(time_selected_post)
for gg = 1:length(time_selected_post{1,kk})
finaltrialtime_post{1,kk}{1,gg} = time_selected_post{1,kk}{1,gg}(end,:)-time_selected_post{1,kk}{1,gg}(1,1);
end
end

%avg it, pre 
for k = 1:length(finaltrialtime_pre)
    mean_pretimes{1,k} = mean(cell2mat(finaltrialtime_pre{1,k}));
end 

%avg it, post
for kk = 1:length(finaltrialtime_post)
    mean_posttimes{1,kk} = mean(cell2mat(finaltrialtime_post{1,kk}));
end

mean_pre_final = mean(cell2mat(mean_pretimes));
mean_post_final = mean(cell2mat(mean_posttimes));
%significance test 
htest = ttest2(cell2mat(mean_pretimes),cell2mat(mean_posttimes));
%significant 
%plot it 

figure(2)
clr_lg = [0.4660, 0.6740, 0.1880];
clr_dg = [0, 0.5, 0];
condition = {'Pre';'Post'};
%plot avg accuracies in dmsl vs control
sd_pre = std(cell2mat(mean_pretimes));
sd_post = std(cell2mat(mean_posttimes));
sem_pre_3 = sd_pre./sqrt(length(mean_pretimes));
sem_post_3 = sd_post./sqrt(length(mean_posttimes));
xaxis_bar = [1,2];
condition = {'Pre';'Post'};
yaxis_time = [mean_pre_final;mean_post_final];
hBar = bar(xaxis_bar,yaxis_time,'FaceColor','flat')
hold on 
hBar.CData(1,:) = clr_lg;
hBar.CData(2,:) = clr_dg;
hold on
errlow = [sem_pre_3,sem_post_3];
errhigh = [sem_pre_3,sem_post_3];
er = errorbar(xaxis_bar,yaxis_time,errlow,errhigh,'k','MarkerSize',100); 
er.LineStyle = 'none';
set(er,'LineWidth',3.5)
axx = gca;
set(axx,'XTick',[1:2],'xticklabel',condition)
hold on 
ylabel('Trial Time (ms)','FontSize',20,'FontWeight','bold')
xlabel('Condition','FontSize',20,'FontWeight','bold')
hold on 
ylim([0 max(yaxis_time)+500]);
axx.XAxis.LineWidth = 5;
axx.YAxis.LineWidth = 5;
axx.XAxis.FontSize = 30;
axx.YAxis.FontSize = 30;
hold off 

%% animal3, ot only 
%L1

%plots thalamostriatal time taken pre/post surgery to estimate kinematics 
%for both ot only and full task
%i'll try to find trial times.. 
%load ratBHstruct
%OT only 
%load e8_103, then j8_106, then l1_life
%1. E8 - 103
%FIND SURGERY DAY
%WAS 10TH NOVEMBER 
%SO EXCLUDE 1068 TO 1100
% TAKE 150 SESSIONS BEFORE AND AFTER LESION AND COMPUTE TRIAL TIMES 
load('D:\Rats_in_Training\L1_output\Results-L1-life\ratBEHstruct.mat');
surgery_l1 = 324;
surgery_post_l1 = 346;%hardcoded for animal
window_ot = 150;
%select prepost surgery
prerange = surgery_l1 - window_ot:surgery_l1;
postrange = surgery_post_l1:surgery_post_l1 + window_ot;

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
end
%find rewarded trials 
for k = 1:length(ratBEHstruct)
    rewards{1,k} = find(combined_hits{1,k} == 1);
end

%filter out all times  
for k =1:length(ratBEHstruct)
all_times{1,k} = ratBEHstruct(k).pokeTimes;
end

%filter out times of rewarded trials 
for k = 1:length(ratBEHstruct)
for g = 1:length(rewards{1,k})
filter_times{1,k}{1,g} = all_times{1,k}{1,rewards{1,k}(1,g)};
end
end

%first filter out sessions we need
trials_pre = filter_times(prerange);
trials_post = filter_times(postrange);
trialtime_pre = trials_pre;
trialtime_post = trials_post;
trialtime_pre = trialtime_pre(~cellfun('isempty',trialtime_pre));
trialtime_post= trialtime_post(~cellfun('isempty',trialtime_post));

for kk = 1:length(trialtime_pre)
time_selected_pre{1,kk} = trialtime_pre{1,kk}(~cellfun('isempty',trialtime_pre{1,kk}));
end

%find trial time pre surgery
for k = 1:length(time_selected_pre)
for g = 1:length(time_selected_pre{1,k})
finaltrialtime_pre{1,k}{1,g} = time_selected_pre{1,k}{1,g}(end,:)-time_selected_pre{1,k}{1,g}(1,1);
end
end

for kk = 1:length(trialtime_post)
time_selected_post{1,kk} = trialtime_post{1,kk}(~cellfun('isempty',trialtime_post{1,kk}));
end

%find trial time post surgery
for kk = 1:length(time_selected_post)
for gg = 1:length(time_selected_post{1,kk})
finaltrialtime_post{1,kk}{1,gg} = time_selected_post{1,kk}{1,gg}(end,:)-time_selected_post{1,kk}{1,gg}(1,1);
end
end

%avg it, pre 
for k = 1:length(finaltrialtime_pre)
    mean_pretimes{1,k} = mean(cell2mat(finaltrialtime_pre{1,k}));
end 

%avg it, post
for kk = 1:length(finaltrialtime_post)
    mean_posttimes{1,kk} = mean(cell2mat(finaltrialtime_post{1,kk}));
end

mean_pre_final = mean(cell2mat(mean_pretimes));
mean_post_final = mean(cell2mat(mean_posttimes));
%significance test 
htest = ttest2(cell2mat(mean_pretimes),cell2mat(mean_posttimes));
%significant 
%plot it 

figure(3)
clr_lg = [0.4660, 0.6740, 0.1880];
clr_dg = [0, 0.5, 0];
condition = {'Pre';'Post'};
%plot avg accuracies in dmsl vs control
sd_pre = std(cell2mat(mean_pretimes));
sd_post = std(cell2mat(mean_posttimes));
sem_pre_3 = sd_pre./sqrt(length(mean_pretimes));
sem_post_3 = sd_post./sqrt(length(mean_posttimes));
xaxis_bar = [1,2];
condition = {'Pre';'Post'};
yaxis_time = [mean_pre_final;mean_post_final];
hBar = bar(xaxis_bar,yaxis_time,'FaceColor','flat')
hold on 
hBar.CData(1,:) = clr_lg;
hBar.CData(2,:) = clr_dg;
hold on
errlow = [sem_pre_3,sem_post_3];
errhigh = [sem_pre_3,sem_post_3];
er = errorbar(xaxis_bar,yaxis_time,errlow,errhigh,'k','MarkerSize',100); 
er.LineStyle = 'none';
set(er,'LineWidth',3.5)
axx = gca;
set(axx,'XTick',[1:2],'xticklabel',condition)
hold on 
ylabel('Trial Time (ms)','FontSize',20,'FontWeight','bold')
xlabel('Condition','FontSize',20,'FontWeight','bold')
hold on 
ylim([0 max(yaxis_time)+500]);
axx.XAxis.LineWidth = 5;
axx.YAxis.LineWidth = 5;
axx.XAxis.FontSize = 30;
axx.YAxis.FontSize = 30;
hold off 
%% do for full task animals!!!!!
% %animal 5 T6, 9april to 19 april
load('D:\Rats_in_Training\T6_output\Results-T6-Titli\ratBEHstruct.mat');
%first have to divide protocol 7 into cued and wm 
%protocol 8 is ot
%filter data from these protocols 

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
current_protocol{1,k} = ratBEHstruct(k).protocol;
end
current_protocol_mat = cell2mat(current_protocol);
%flexible sessions 
flex_sess = find(current_protocol_mat == 7);
for n = 1:length(ratBEHstruct)
dates{n} = ratBEHstruct(n).date;
end
dateflex = dates(flex_sess);
%divide flex into cued and wm
%do only for sessions in flexible 

for s = 1:length(ratBEHstruct)
    blocklength(s) = max(ratBEHstruct(s).blocknum);
end

for s = 1:length(ratBEHstruct)
idx_cued{s} = find(ratBEHstruct(s).blocknumRepair<(blocklength(s)+1)/2);
end

for s = 1:length(ratBEHstruct)
idx_wm{s} = find(ratBEHstruct(s).blocknumRepair>=(blocklength(s)+1)/2);
end
%now divide into cued and wm 
idxcued_flex = idx_cued(flex_sess);
idxwm_flex = idx_wm(flex_sess);
%ot sessions 
ot_sess = find(current_protocol_mat == 8);
dateot = dates(ot_sess);

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
end
%find rewarded trials 
for k = 1:length(ratBEHstruct)
    rewards{1,k} = find(combined_hits{1,k} == 1);
end

%filter out all times  
for k =1:length(ratBEHstruct)
all_times{1,k} = ratBEHstruct(k).pokeTimes;
end

rewarded_ot = rewards(ot_sess);
rewarded_flex = rewards(flex_sess);
%from rewarded flex, select cue and wm 

for n = 1:length(rewarded_flex)
 reward_cued{1,n} =  intersect(idxcued_flex{1,n},rewarded_flex{1,n}); 
end

for n = 1:length(rewarded_flex)
 reward_wm{1,n} =  intersect(idxwm_flex{1,n},rewarded_flex{1,n}); 
end
for n = 1:length(ot_sess)
poke_ot_times{1,n} = ratBEHstruct(ot_sess(1,n)).pokeTimes;
end
for n = 1:length(ot_sess)
  ottimes{1,n} =  poke_ot_times{1,n}(rewarded_ot{1,n});
end

for n = 1:length(flex_sess)
poke_cue_times{1,n} = ratBEHstruct(flex_sess(1,n)).pokeTimes;
end
for n = 1:length(flex_sess)
  cuetimes{1,n} =  poke_cue_times{1,n}(reward_cued{1,n});
end

for n = 1:length(flex_sess)
poke_wm_times{1,n} = ratBEHstruct(flex_sess(1,n)).pokeTimes;
end
for n = 1:length(flex_sess)
  wmtimes{1,n} =  poke_wm_times{1,n}(reward_wm{1,n});
end
%9th to 19th april 
surgery_t6_flex = 483;
surgery_post_t6flex = 515;%hardcoded for animal
window_ot = 50;
surgery_t6otpre = 136;
surgery_6otpost = 146;
%select prepost surgery
prerangeflex = surgery_t6_flex - window_ot: length(dateflex);
postrangeflex =  surgery_post_t6flex - window_ot:length(dateflex);
prerangeot = surgery_t6otpre - window_ot: length(dateot);
postrangeot = surgery_6otpost - window_ot: length(dateot);

%first filter out sessions we need
trials_pre_cue = cuetimes(prerangeflex);
trials_post_cue = cuetimes(postrangeflex);
trials_pre_wm = wmtimes(prerangeflex);
trials_post_wm = wmtimes(postrangeflex);
trials_pre_ot = ottimes(prerangeot);
trials_post_ot = ottimes(postrangeot);

trialtime_precue = trials_pre_cue;
trialtime_postcue = trials_post_cue;
trialtime_precue = trialtime_precue(~cellfun('isempty',trialtime_precue));
trialtime_postcue= trialtime_postcue(~cellfun('isempty',trialtime_postcue));

trialtime_prewm = trials_pre_wm;
trialtime_postwm = trials_post_wm;
trialtime_prewm = trialtime_prewm(~cellfun('isempty',trialtime_prewm));
trialtime_postwm= trialtime_postwm(~cellfun('isempty',trialtime_postwm));

trialtime_preot = trials_pre_ot;
trialtime_postot = trials_post_ot;
trialtime_preot = trialtime_preot(~cellfun('isempty',trialtime_preot));
trialtime_postot= trialtime_postot(~cellfun('isempty',trialtime_postot));

for kk = 1:length(trialtime_precue)
time_selected_precue{1,kk} = trialtime_precue{1,kk}(~cellfun('isempty',trialtime_precue{1,kk}));
end

%find trial time pre surgery
for k = 1:length(time_selected_precue)
for g = 1:length(time_selected_precue{1,k})
finaltrialtime_precue{1,k}{1,g} = time_selected_precue{1,k}{1,g}(end,:)-time_selected_precue{1,k}{1,g}(1,1);
end
end

for kk = 1:length(trialtime_postcue)
time_selected_postcue{1,kk} = trialtime_postcue{1,kk}(~cellfun('isempty',trialtime_postcue{1,kk}));
end

%find trial time post surgery
for kk = 1:length(time_selected_postcue)
for gg = 1:length(time_selected_postcue{1,kk})
finaltrialtime_postcue{1,kk}{1,gg} = time_selected_postcue{1,kk}{1,gg}(end,:)-time_selected_postcue{1,kk}{1,gg}(1,1);
end
end

%avg it, pre 
for k = 1:length(finaltrialtime_precue)
    mean_pretimescue{1,k} = mean(cell2mat(finaltrialtime_precue{1,k}));
end 

%avg it, post
for kk = 1:length(finaltrialtime_postcue)
    mean_posttimescue{1,kk} = mean(cell2mat(finaltrialtime_postcue{1,kk}));
end

mean_pre_finalcue = mean(cell2mat(mean_pretimescue));
mean_post_finalcue = mean(cell2mat(mean_posttimescue));
%significance test 
htestcue = ttest2(cell2mat(mean_pretimescue),cell2mat(mean_posttimescue));

%for wm

for kk = 1:length(trialtime_prewm)
time_selected_prewm{1,kk} = trialtime_prewm{1,kk}(~cellfun('isempty',trialtime_prewm{1,kk}));
end

%find trial time pre surgery
for k = 1:length(time_selected_prewm)
for g = 1:length(time_selected_prewm{1,k})
finaltrialtime_prewm{1,k}{1,g} = time_selected_prewm{1,k}{1,g}(end,:)-time_selected_prewm{1,k}{1,g}(1,1);
end
end

for kk = 1:length(trialtime_postwm)
time_selected_postwm{1,kk} = trialtime_postwm{1,kk}(~cellfun('isempty',trialtime_postwm{1,kk}));
end

%find trial time post surgery
for kk = 1:length(time_selected_postwm)
for gg = 1:length(time_selected_postwm{1,kk})
finaltrialtime_postwm{1,kk}{1,gg} = time_selected_postwm{1,kk}{1,gg}(end,:)-time_selected_postwm{1,kk}{1,gg}(1,1);
end
end

%avg it, pre 
for k = 1:length(finaltrialtime_prewm)
    mean_pretimeswm{1,k} = mean(cell2mat(finaltrialtime_prewm{1,k}));
end 

%avg it, post
for kk = 1:length(finaltrialtime_postwm)
    mean_posttimeswm{1,kk} = mean(cell2mat(finaltrialtime_postwm{1,kk}));
end

mean_pre_finalwm = mean(cell2mat(mean_pretimeswm));
mean_post_finalwm = mean(cell2mat(mean_posttimeswm));
%significance test 
htestwm = ttest2(cell2mat(mean_pretimeswm),cell2mat(mean_posttimeswm));

%for ot 

for kk = 1:length(trialtime_preot)
time_selected_preot{1,kk} = trialtime_preot{1,kk}(~cellfun('isempty',trialtime_preot{1,kk}));
end

%find trial time pre surgery
for k = 1:length(time_selected_preot)
for g = 1:length(time_selected_preot{1,k})
finaltrialtime_preot{1,k}{1,g} = time_selected_preot{1,k}{1,g}(end,:)-time_selected_preot{1,k}{1,g}(1,1);
end
end

for kk = 1:length(trialtime_postot)
time_selected_postot{1,kk} = trialtime_postot{1,kk}(~cellfun('isempty',trialtime_postot{1,kk}));
end

%find trial time post surgery
for kk = 1:length(time_selected_postot)
for gg = 1:length(time_selected_postot{1,kk})
finaltrialtime_postot{1,kk}{1,gg} = time_selected_postot{1,kk}{1,gg}(end,:)-time_selected_postot{1,kk}{1,gg}(1,1);
end
end

%avg it, pre 
for k = 1:length(finaltrialtime_preot)
    mean_pretimesot{1,k} = mean(cell2mat(finaltrialtime_preot{1,k}));
end 

%avg it, post
for kk = 1:length(finaltrialtime_postot)
    mean_posttimesot{1,kk} = mean(cell2mat(finaltrialtime_postot{1,kk}));
end

mean_pre_finalot = mean(cell2mat(mean_pretimesot));
mean_post_finalot = mean(cell2mat(mean_posttimesot));
%significance test 
htestot = ttest2(cell2mat(mean_pretimesot),cell2mat(mean_posttimesot));

%significant 
%plot it, plot multiple bars together 
figure(4)
trial_first_half = [mean_pre_finalcue, mean_pre_finalwm, mean_pre_finalot];
trial_second_half = [mean_post_finalcue, mean_post_finalwm, mean_post_finalot];
bvals = [trial_first_half;trial_second_half];
xlength = 1:length(trial_first_half);
clr = [0.87 0.56 0.65; 0.52 0.61 0.82; 0.4660 0.6740 0.1880];
clr2 = [1 0 0;0 0 1;0 0.5 0];
hold on 
barplot1 = bar(xlength,bvals,'facecolor','flat');
hold on 
barplot1(1,1).CData = clr;
barplot1(1,2).CData = clr2;
hold off
%plot avg accuracies in dmsl vs control
sd_precue = std(cell2mat(mean_pretimescue));
sd_postcue = std(cell2mat(mean_posttimescue));
sem_pre_3cue = sd_precue./sqrt(length(mean_pretimescue));
sem_post_3cue = sd_postcue./sqrt(length(mean_posttimescue));

sd_prewm = std(cell2mat(mean_pretimeswm));
sd_postwm = std(cell2mat(mean_posttimeswm));
sem_pre_3wm = sd_precue./sqrt(length(mean_pretimeswm));
sem_post_3wm = sd_postcue./sqrt(length(mean_posttimeswm));

sd_preot = std(cell2mat(mean_pretimesot));
sd_postot = std(cell2mat(mean_posttimesot));
sem_pre_3ot = sd_preot./sqrt(length(mean_pretimesot));
sem_post_3ot = sd_postot./sqrt(length(mean_posttimesot));
Xlabelval = {'Cued','WM','OT'};
ax = gca
set(ax,'XTick',xlength,'XTickLabel',Xlabelval);
hold on 
ylabel('Trial time (ms)','FontSize',20,'FontWeight','bold')
xlabel('Condition','FontSize',20,'FontWeight','bold')
hold on 
% errlow_all= [sem_pre_3cue,sem_pre_3wm,sem_pre_3ot];
% errhigh_all= [sem_post_3cue,sem_post_3wm,sem_post_3ot];
% errall = [errlow_all;errhigh_all];
% % errlow = [sem_pre_3cue,sem_post_3cue,sem_pre_3wm,sem_post_3wm,sem_pre_3ot,sem_post_3ot];
% % errhigh = [sem_pre_3cue,sem_post_3cue,sem_pre_3wm,sem_post_3wm,sem_pre_3ot,sem_post_3ot];
% hold on
% er = errorbar(xlength,bvals,errall,errall,'k'); 
% er.LineStyle = 'none';
ylim([0 max(max(bvals))+500]);
ax.XAxis.LineWidth = 5;
ax.YAxis.LineWidth = 5;
ax.XAxis.FontSize = 20;
ax.YAxis.FontSize = 20;
hold off 
%% for t6
%% do for full task animals!!!!!
% %animal 4 D6
 load('D:\Rats_in_Training\D6_output\Results-D6-Dahlia\ratBEHstruct.mat');
%first have to divide protocol 7 into cued and wm 
%protocol 8 is ot
%filter data from these protocols 

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
current_protocol{1,k} = ratBEHstruct(k).protocol;
end
current_protocol_mat = cell2mat(current_protocol);
%flexible sessions 
flex_sess = find(current_protocol_mat == 7);
for n = 1:length(ratBEHstruct)
dates{n} = ratBEHstruct(n).date;
end
dateflex = dates(flex_sess);
%divide flex into cued and wm
%do only for sessions in flexible 

for s = 1:length(ratBEHstruct)
    blocklength(s) = max(ratBEHstruct(s).blocknum);
end

for s = 1:length(ratBEHstruct)
idx_cued{s} = find(ratBEHstruct(s).blocknumRepair<(blocklength(s)+1)/2);
end

for s = 1:length(ratBEHstruct)
idx_wm{s} = find(ratBEHstruct(s).blocknumRepair>=(blocklength(s)+1)/2);
end
%now divide into cued and wm 
idxcued_flex = idx_cued(flex_sess);
idxwm_flex = idx_wm(flex_sess);
%ot sessions 
ot_sess = find(current_protocol_mat == 8);
dateot = dates(ot_sess);

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
end
%find rewarded trials 
for k = 1:length(ratBEHstruct)
    rewards{1,k} = find(combined_hits{1,k} == 1);
end

%filter out all times  
for k =1:length(ratBEHstruct)
all_times{1,k} = ratBEHstruct(k).pokeTimes;
end

rewarded_ot = rewards(ot_sess);
rewarded_flex = rewards(flex_sess);
%from rewarded flex, select cue and wm 

for n = 1:length(rewarded_flex)
 reward_cued{1,n} =  intersect(idxcued_flex{1,n},rewarded_flex{1,n}); 
end

for n = 1:length(rewarded_flex)
 reward_wm{1,n} =  intersect(idxwm_flex{1,n},rewarded_flex{1,n}); 
end
for n = 1:length(ot_sess)
poke_ot_times{1,n} = ratBEHstruct(ot_sess(1,n)).pokeTimes;
end
for n = 1:length(ot_sess)
  ottimes{1,n} =  poke_ot_times{1,n}(rewarded_ot{1,n});
end

for n = 1:length(flex_sess)
poke_cue_times{1,n} = ratBEHstruct(flex_sess(1,n)).pokeTimes;
end
for n = 1:length(flex_sess)
  cuetimes{1,n} =  poke_cue_times{1,n}(reward_cued{1,n});
end

for n = 1:length(flex_sess)
poke_wm_times{1,n} = ratBEHstruct(flex_sess(1,n)).pokeTimes;
end
for n = 1:length(flex_sess)
  wmtimes{1,n} =  poke_wm_times{1,n}(reward_wm{1,n});
end

surgery_d6_flex = 381;
surgery_post_d6flex = 407;%hardcoded for animal
window_ot = 50;
surgery_d6otpre = 115;
surgery_6otpost = 123;
%select prepost surgery
prerangeflex = surgery_d6_flex - window_ot: surgery_d6_flex + window_ot;
postrangeflex =  surgery_post_d6flex - window_ot:surgery_post_d6flex + window_ot;
prerangeot = surgery_d6otpre - window_ot: surgery_d6otpre + window_ot;
postrangeot = surgery_6otpost - window_ot: surgery_6otpost + window_ot;

%first filter out sessions we need
trials_pre_cue = cuetimes(prerangeflex);
trials_post_cue = cuetimes(postrangeflex);
trials_pre_wm = wmtimes(prerangeflex);
trials_post_wm = wmtimes(postrangeflex);
trials_pre_ot = ottimes(prerangeot);
trials_post_ot = ottimes(postrangeot);

trialtime_precue = trials_pre_cue;
trialtime_postcue = trials_post_cue;
trialtime_precue = trialtime_precue(~cellfun('isempty',trialtime_precue));
trialtime_postcue= trialtime_postcue(~cellfun('isempty',trialtime_postcue));

trialtime_prewm = trials_pre_wm;
trialtime_postwm = trials_post_wm;
trialtime_prewm = trialtime_prewm(~cellfun('isempty',trialtime_prewm));
trialtime_postwm= trialtime_postwm(~cellfun('isempty',trialtime_postwm));

trialtime_preot = trials_pre_ot;
trialtime_postot = trials_post_ot;
trialtime_preot = trialtime_preot(~cellfun('isempty',trialtime_preot));
trialtime_postot= trialtime_postot(~cellfun('isempty',trialtime_postot));

for kk = 1:length(trialtime_precue)
time_selected_precue{1,kk} = trialtime_precue{1,kk}(~cellfun('isempty',trialtime_precue{1,kk}));
end

%find trial time pre surgery
for k = 1:length(time_selected_precue)
for g = 1:length(time_selected_precue{1,k})
finaltrialtime_precue{1,k}{1,g} = time_selected_precue{1,k}{1,g}(end,:)-time_selected_precue{1,k}{1,g}(1,1);
end
end

for kk = 1:length(trialtime_postcue)
time_selected_postcue{1,kk} = trialtime_postcue{1,kk}(~cellfun('isempty',trialtime_postcue{1,kk}));
end

%find trial time post surgery
for kk = 1:length(time_selected_postcue)
for gg = 1:length(time_selected_postcue{1,kk})
finaltrialtime_postcue{1,kk}{1,gg} = time_selected_postcue{1,kk}{1,gg}(end,:)-time_selected_postcue{1,kk}{1,gg}(1,1);
end
end

%avg it, pre 
for k = 1:length(finaltrialtime_precue)
    mean_pretimescue{1,k} = mean(cell2mat(finaltrialtime_precue{1,k}));
end 

%avg it, post
for kk = 1:length(finaltrialtime_postcue)
    mean_posttimescue{1,kk} = mean(cell2mat(finaltrialtime_postcue{1,kk}));
end

mean_pre_finalcue = mean(cell2mat(mean_pretimescue));
mean_post_finalcue = mean(cell2mat(mean_posttimescue));
%significance test 
htestcue = ttest2(cell2mat(mean_pretimescue),cell2mat(mean_posttimescue));

%for wm

for kk = 1:length(trialtime_prewm)
time_selected_prewm{1,kk} = trialtime_prewm{1,kk}(~cellfun('isempty',trialtime_prewm{1,kk}));
end

%find trial time pre surgery
for k = 1:length(time_selected_prewm)
for g = 1:length(time_selected_prewm{1,k})
finaltrialtime_prewm{1,k}{1,g} = time_selected_prewm{1,k}{1,g}(end,:)-time_selected_prewm{1,k}{1,g}(1,1);
end
end

for kk = 1:length(trialtime_postwm)
time_selected_postwm{1,kk} = trialtime_postwm{1,kk}(~cellfun('isempty',trialtime_postwm{1,kk}));
end

%find trial time post surgery
for kk = 1:length(time_selected_postwm)
for gg = 1:length(time_selected_postwm{1,kk})
finaltrialtime_postwm{1,kk}{1,gg} = time_selected_postwm{1,kk}{1,gg}(end,:)-time_selected_postwm{1,kk}{1,gg}(1,1);
end
end

%avg it, pre 
for k = 1:length(finaltrialtime_prewm)
    mean_pretimeswm{1,k} = mean(cell2mat(finaltrialtime_prewm{1,k}));
end 

%avg it, post
for kk = 1:length(finaltrialtime_postwm)
    mean_posttimeswm{1,kk} = mean(cell2mat(finaltrialtime_postwm{1,kk}));
end

mean_pre_finalwm = mean(cell2mat(mean_pretimeswm));
mean_post_finalwm = mean(cell2mat(mean_posttimeswm));
%significance test 
htestwm = ttest2(cell2mat(mean_pretimeswm),cell2mat(mean_posttimeswm));

%for ot 

for kk = 1:length(trialtime_preot)
time_selected_preot{1,kk} = trialtime_preot{1,kk}(~cellfun('isempty',trialtime_preot{1,kk}));
end

%find trial time pre surgery
for k = 1:length(time_selected_preot)
for g = 1:length(time_selected_preot{1,k})
finaltrialtime_preot{1,k}{1,g} = time_selected_preot{1,k}{1,g}(end,:)-time_selected_preot{1,k}{1,g}(1,1);
end
end

for kk = 1:length(trialtime_postot)
time_selected_postot{1,kk} = trialtime_postot{1,kk}(~cellfun('isempty',trialtime_postot{1,kk}));
end

%find trial time post surgery
for kk = 1:length(time_selected_postot)
for gg = 1:length(time_selected_postot{1,kk})
finaltrialtime_postot{1,kk}{1,gg} = time_selected_postot{1,kk}{1,gg}(end,:)-time_selected_postot{1,kk}{1,gg}(1,1);
end
end

%avg it, pre 
for k = 1:length(finaltrialtime_preot)
    mean_pretimesot{1,k} = mean(cell2mat(finaltrialtime_preot{1,k}));
end 

%avg it, post
for kk = 1:length(finaltrialtime_postot)
    mean_posttimesot{1,kk} = mean(cell2mat(finaltrialtime_postot{1,kk}));
end

mean_pre_finalot = mean(cell2mat(mean_pretimesot));
mean_post_finalot = mean(cell2mat(mean_posttimesot));
%significance test 
htestot = ttest2(cell2mat(mean_pretimesot),cell2mat(mean_posttimesot));

%significant 
%plot it, plot multiple bars together 
figure(4)
trial_first_half = [mean_pre_finalcue, mean_pre_finalwm, mean_pre_finalot];
trial_second_half = [mean_post_finalcue, mean_post_finalwm, mean_post_finalot];
bvals = [trial_first_half;trial_second_half];
xlength = 1:length(trial_first_half);
clr = [0.87 0.56 0.65; 0.52 0.61 0.82;0.4660 0.6740 0.1880];
clr2 = [1 0 0; 0 0 1;0 0.5 0];
hold on 
barplot1 = bar(xlength,bvals,'facecolor','flat');
hold on 
barplot1(1,1).CData = clr;
barplot1(1,2).CData = clr2;
hold off
Xlabelval = {'Cued','WM','OT'};
ax = gca
set(ax,'XTick',xlength,'XTickLabel',Xlabelval);
hold on 
ylabel('Trial time (ms)','FontSize',20,'FontWeight','bold')
xlabel('Condition','FontSize',20,'FontWeight','bold')
hold on 
ylim([0 max(max(bvals))+500]);
ax.XAxis.LineWidth = 5;
ax.YAxis.LineWidth = 5;
ax.XAxis.FontSize = 20;
ax.YAxis.FontSize = 20;
hold off 
%%%%


%% do for full task animals!!!!!
%but with diff method
%thalamo-striatal 1st
% %animal 5 T6, 9april to 19 april
load('D:\Rats_in_Training\T6_output\Results-T6-Titli\ratBEHstruct.mat');
%first have to divide protocol 7 into cued and wm 
%protocol 8 is ot
%filter data from these protocols 

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
current_protocol{1,k} = ratBEHstruct(k).protocol;
end
current_protocol_mat = cell2mat(current_protocol);
%flexible sessions 

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
end
%find rewarded trials 
for k = 1:length(ratBEHstruct)
    rewards{1,k} = find(combined_hits{1,k} == 1);
end
%ot sequence for t6_titli is CRC
for k = 1:length(ratBEHstruct) 
target_pokes{1,k} = ratBEHstruct(k).targetNames;
size_targetpoke(1,k) = size(target_pokes{1,k},2);
end
empty_cell = find(size_targetpoke == 1);
%discard them 
target_pokes(empty_cell) = [];
rewards(empty_cell) = [];
current_protocol(empty_cell) = []; 
current_protocol_mat(empty_cell) = []; 

for k = 1:length(target_pokes)
poke_seq{1,k} = startsWith(target_pokes{1,k},'CRC');
end

for k = 1:length(target_pokes)
pokes_we_need{1,k} = find(poke_seq{1,k} == 1);
end
empty_pokes_part2 = find(cellfun(@isempty,pokes_we_need));
pokes_we_need(empty_pokes_part2) = [];
rewards(empty_pokes_part2) = [];
current_protocol(empty_pokes_part2) = [];
current_protocol_mat(empty_pokes_part2) = [];

%filter out all times  
for k =1:length(ratBEHstruct)
all_times{1,k} = ratBEHstruct(k).pokeTimes;
end
all_times(empty_cell) = [];
all_times(empty_pokes_part2) = [];
flex_sess = find(current_protocol_mat == 7);
ot_sess = find(current_protocol_mat == 8);

rewarded_ot = rewards(ot_sess);
rewarded_flex = rewards(flex_sess);
ratBEHstruct_updated = ratBEHstruct();
ratBEHstruct_updated(empty_cell) = [];
ratBEHstruct_updated(empty_pokes_part2) = [];


for n = 1:length(ratBEHstruct_updated)
dates{n} = ratBEHstruct_updated(n).date;
end
dateflex = dates(flex_sess);
%divide flex into cued and wm
%do only for sessions in flexible 

for s = 1:length(ratBEHstruct)
    blocklength(s) = max(ratBEHstruct(s).blocknum);
end

for s = 1:length(ratBEHstruct)
idx_cued{s} = find(ratBEHstruct(s).blocknumRepair<(blocklength(s)+1)/2);
end

for s = 1:length(ratBEHstruct)
idx_wm{s} = find(ratBEHstruct(s).blocknumRepair>=(blocklength(s)+1)/2);
end
%now divide into cued and wm 
idxcued_flex = idx_cued(flex_sess);
idxwm_flex = idx_wm(flex_sess);
%ot sessions 
ot_sess = find(current_protocol_mat == 8);
dateot = dates(ot_sess);
%%%%find intersection of idxcued_flex and pokes_we_need
pokes_flex = pokes_we_need(flex_sess);
pokes_ot = pokes_we_need(ot_sess);

for n = 1:length(idxcued_flex)
idxcued1_flex{1,n} =  intersect(idxcued_flex{1,n},pokes_flex{1,n}); 
end

for n = 1:length(idxwm_flex)
 idxwm1_flex{1,n} =  intersect(idxwm_flex{1,n},pokes_flex{1,n}); 
end

%from rewarded flex, select cue and wm 
for n = 1:length(rewarded_flex)
 reward_cued{1,n} =  intersect(idxcued1_flex{1,n},rewarded_flex{1,n}); 
end

for n = 1:length(rewarded_flex)
 reward_wm{1,n} =  intersect(idxwm1_flex{1,n},rewarded_flex{1,n}); 
end

for n = 1:length(ot_sess)
poke_ot_times{1,n} = ratBEHstruct_updated(ot_sess(1,n)).pokeTimes;
end
for n = 1:length(ot_sess)
  ottimes{1,n} =  poke_ot_times{1,n}(rewarded_ot{1,n});
end

for n = 1:length(flex_sess)
poke_cue_times{1,n} = ratBEHstruct_updated(flex_sess(1,n)).pokeTimes;
end
for n = 1:length(flex_sess)
  cuetimes{1,n} =  poke_cue_times{1,n}(reward_cued{1,n});
end

for n = 1:length(flex_sess)
poke_wm_times{1,n} = ratBEHstruct_updated(flex_sess(1,n)).pokeTimes;
end
for n = 1:length(flex_sess)
  wmtimes{1,n} =  poke_wm_times{1,n}(reward_wm{1,n});
end

%9th to 19th april 
surgery_t6_flex = 461;
surgery_post_t6flex = 462;%hardcoded for animal
window_ot = 60;
surgery_t6otpre = 130; %(using dateot)
surgery_6otpost = 131;
%select prepost surgery
prerangeflex = surgery_t6_flex - window_ot: length(dateflex);
postrangeflex =  surgery_post_t6flex - window_ot:length(dateflex);
prerangeot = surgery_t6otpre - window_ot: length(dateot);
postrangeot = surgery_6otpost - window_ot: length(dateot);

%first filter out sessions we need
trials_pre_cue = cuetimes(prerangeflex);
trials_post_cue = cuetimes(postrangeflex);
trials_pre_wm = wmtimes(prerangeflex);
trials_post_wm = wmtimes(postrangeflex);
trials_pre_ot = ottimes(prerangeot);
trials_post_ot = ottimes(postrangeot);

trialtime_precue = trials_pre_cue;
trialtime_postcue = trials_post_cue;
trialtime_precue = trialtime_precue(~cellfun('isempty',trialtime_precue));
trialtime_postcue= trialtime_postcue(~cellfun('isempty',trialtime_postcue));

trialtime_prewm = trials_pre_wm;
trialtime_postwm = trials_post_wm;
trialtime_prewm = trialtime_prewm(~cellfun('isempty',trialtime_prewm));
trialtime_postwm= trialtime_postwm(~cellfun('isempty',trialtime_postwm));

trialtime_preot = trials_pre_ot;
trialtime_postot = trials_post_ot;
trialtime_preot = trialtime_preot(~cellfun('isempty',trialtime_preot));
trialtime_postot= trialtime_postot(~cellfun('isempty',trialtime_postot));

for kk = 1:length(trialtime_precue)
time_selected_precue{1,kk} = trialtime_precue{1,kk}(~cellfun('isempty',trialtime_precue{1,kk}));
end

%find trial time pre surgery
for k = 1:length(time_selected_precue)
for g = 1:length(time_selected_precue{1,k})
finaltrialtime_precue{1,k}{1,g} = time_selected_precue{1,k}{1,g}(end,:)-time_selected_precue{1,k}{1,g}(1,1);
end
end

for kk = 1:length(trialtime_postcue)
time_selected_postcue{1,kk} = trialtime_postcue{1,kk}(~cellfun('isempty',trialtime_postcue{1,kk}));
end

%find trial time post surgery
for kk = 1:length(time_selected_postcue)
for gg = 1:length(time_selected_postcue{1,kk})
finaltrialtime_postcue{1,kk}{1,gg} = time_selected_postcue{1,kk}{1,gg}(end,:)-time_selected_postcue{1,kk}{1,gg}(1,1);
end
end

%avg it, pre  
for k = 1:length(finaltrialtime_precue)
    mean_pretimescue{1,k} = mean(cell2mat(finaltrialtime_precue{1,k}));
end 

%avg it, post
for kk = 1:length(finaltrialtime_postcue)
    mean_posttimescue{1,kk} = mean(cell2mat(finaltrialtime_postcue{1,kk}));
end

mean_pre_finalcue = mean(cell2mat(mean_pretimescue));
mean_post_finalcue = mean(cell2mat(mean_posttimescue));
%significance test 
htestcue = ttest2(cell2mat(mean_pretimescue),cell2mat(mean_posttimescue));

%for wm

for kk = 1:length(trialtime_prewm)
time_selected_prewm{1,kk} = trialtime_prewm{1,kk}(~cellfun('isempty',trialtime_prewm{1,kk}));
end

%find trial time pre surgery
for k = 1:length(time_selected_prewm)
for g = 1:length(time_selected_prewm{1,k})
finaltrialtime_prewm{1,k}{1,g} = time_selected_prewm{1,k}{1,g}(end,:)-time_selected_prewm{1,k}{1,g}(1,1);
end
end

for kk = 1:length(trialtime_postwm)
time_selected_postwm{1,kk} = trialtime_postwm{1,kk}(~cellfun('isempty',trialtime_postwm{1,kk}));
end

%find trial time post surgery
for kk = 1:length(time_selected_postwm)
for gg = 1:length(time_selected_postwm{1,kk})
finaltrialtime_postwm{1,kk}{1,gg} = time_selected_postwm{1,kk}{1,gg}(end,:)-time_selected_postwm{1,kk}{1,gg}(1,1);
end
end

%avg it, pre 
for k = 1:length(finaltrialtime_prewm)
    mean_pretimeswm{1,k} = mean(cell2mat(finaltrialtime_prewm{1,k}));
end 

%avg it, post
for kk = 1:length(finaltrialtime_postwm)
    mean_posttimeswm{1,kk} = mean(cell2mat(finaltrialtime_postwm{1,kk}));
end

mean_pre_finalwm = mean(cell2mat(mean_pretimeswm));
mean_post_finalwm = mean(cell2mat(mean_posttimeswm));
%significance test 
htestwm = ttest2(cell2mat(mean_pretimeswm),cell2mat(mean_posttimeswm));

%for ot 

for kk = 1:length(trialtime_preot)
time_selected_preot{1,kk} = trialtime_preot{1,kk}(~cellfun('isempty',trialtime_preot{1,kk}));
end

%find trial time pre surgery
for k = 1:length(time_selected_preot)
for g = 1:length(time_selected_preot{1,k})
finaltrialtime_preot{1,k}{1,g} = time_selected_preot{1,k}{1,g}(end,:)-time_selected_preot{1,k}{1,g}(1,1);
end
end

for kk = 1:length(trialtime_postot)
time_selected_postot{1,kk} = trialtime_postot{1,kk}(~cellfun('isempty',trialtime_postot{1,kk}));
end

%find trial time post surgery
for kk = 1:length(time_selected_postot)
for gg = 1:length(time_selected_postot{1,kk})
finaltrialtime_postot{1,kk}{1,gg} = time_selected_postot{1,kk}{1,gg}(end,:)-time_selected_postot{1,kk}{1,gg}(1,1);
end
end

%avg it, pre 
for k = 1:length(finaltrialtime_preot)
    mean_pretimesot{1,k} = mean(cell2mat(finaltrialtime_preot{1,k}));
end 

%avg it, post
for kk = 1:length(finaltrialtime_postot)
    mean_posttimesot{1,kk} = mean(cell2mat(finaltrialtime_postot{1,kk}));
end

mean_pre_finalot = mean(cell2mat(mean_pretimesot));
mean_post_finalot = mean(cell2mat(mean_posttimesot));
%significance test 
htestot = ttest2(cell2mat(mean_pretimesot),cell2mat(mean_posttimesot));

%significant 
%plot it, plot multiple bars together 
figure(4)
trial_first_half = [mean_pre_finalcue, mean_pre_finalwm, mean_pre_finalot];
trial_second_half = [mean_post_finalcue, mean_post_finalwm, mean_post_finalot];
bvals = [trial_first_half;trial_second_half];
xlength = 1:length(trial_first_half);
clr = [0.87 0.56 0.65; 0.52 0.61 0.82; 0.4660 0.6740 0.1880];
clr2 = [1 0 0;0 0 1;0 0.5 0];
hold on 
barplot1 = bar(xlength,bvals,'facecolor','flat');
hold on 
barplot1(1,1).CData = clr;
barplot1(1,2).CData = clr2;
hold off
%plot avg accuracies in dmsl vs control
sd_precue = std(cell2mat(mean_pretimescue));
sd_postcue = std(cell2mat(mean_posttimescue));
sem_pre_3cue = sd_precue./sqrt(length(mean_pretimescue));
sem_post_3cue = sd_postcue./sqrt(length(mean_posttimescue));

sd_prewm = std(cell2mat(mean_pretimeswm));
sd_postwm = std(cell2mat(mean_posttimeswm));
sem_pre_3wm = sd_precue./sqrt(length(mean_pretimeswm));
sem_post_3wm = sd_postcue./sqrt(length(mean_posttimeswm));

sd_preot = std(cell2mat(mean_pretimesot));
sd_postot = std(cell2mat(mean_posttimesot));
sem_pre_3ot = sd_preot./sqrt(length(mean_pretimesot));
sem_post_3ot = sd_postot./sqrt(length(mean_posttimesot));
Xlabelval = {'Cued','WM','OT'};
ax = gca
set(ax,'XTick',xlength,'XTickLabel',Xlabelval);
hold on 
ylabel('Trial time (ms)','FontSize',20,'FontWeight','bold')
xlabel('Condition','FontSize',20,'FontWeight','bold')
hold on 
% errlow_all= [sem_pre_3cue,sem_pre_3wm,sem_pre_3ot];
% errhigh_all= [sem_post_3cue,sem_post_3wm,sem_post_3ot];
% errall = [errlow_all;errhigh_all];
% % errlow = [sem_pre_3cue,sem_post_3cue,sem_pre_3wm,sem_post_3wm,sem_pre_3ot,sem_post_3ot];
% % errhigh = [sem_pre_3cue,sem_post_3cue,sem_pre_3wm,sem_post_3wm,sem_pre_3ot,sem_post_3ot];
% hold on
% er = errorbar(xlength,bvals,errall,errall,'k'); 
% er.LineStyle = 'none';
ylim([0 max(max(bvals))+500]);
ax.XAxis.LineWidth = 5;
ax.YAxis.LineWidth = 5;
ax.XAxis.FontSize = 30;
ax.YAxis.FontSize = 30;
hold off 
%% for t6


bvals_new = bvals;
bvals_new(:,2) = [];
%significant 
%plot it, plot multiple bars together 
figure(5) %without wm 
trial_first_half = [mean_pre_finalcue, mean_pre_finalot];
trial_second_half = [mean_post_finalcue, mean_post_finalot];
%bvals = [trial_first_half;trial_second_half];
xlength = 1:length(trial_first_half);
clr = [0.87 0.56 0.65; 0.4660 0.6740 0.1880];
clr2 = [1 0 0;0 0.5 0];
hold on 
barplot1 = bar(xlength,bvals_new','facecolor','flat');
hold on 
barplot1(1,1).CData = clr;
barplot1(1,2).CData = clr2;
hold off
%plot avg accuracies in dmsl vs control
sd_precue = std(cell2mat(mean_pretimescue));
sd_postcue = std(cell2mat(mean_posttimescue));
sem_pre_3cue = sd_precue./sqrt(length(mean_pretimescue));
sem_post_3cue = sd_postcue./sqrt(length(mean_posttimescue));

sd_prewm = std(cell2mat(mean_pretimeswm));
sd_postwm = std(cell2mat(mean_posttimeswm));
sem_pre_3wm = sd_precue./sqrt(length(mean_pretimeswm));
sem_post_3wm = sd_postcue./sqrt(length(mean_posttimeswm));

sd_preot = std(cell2mat(mean_pretimesot));
sd_postot = std(cell2mat(mean_posttimesot));
sem_pre_3ot = sd_preot./sqrt(length(mean_pretimesot));
sem_post_3ot = sd_postot./sqrt(length(mean_posttimesot));
Xlabelval = {'Cued','OT'};
ax = gca
set(ax,'XTick',xlength,'XTickLabel',Xlabelval);
hold on 
ylabel('Trial time (ms)','FontSize',20,'FontWeight','bold')
xlabel('Condition','FontSize',20,'FontWeight','bold')
hold on 
% errlow_all= [sem_pre_3cue,sem_pre_3wm,sem_pre_3ot];
% errhigh_all= [sem_post_3cue,sem_post_3wm,sem_post_3ot];
% errall = [errlow_all;errhigh_all];
% % errlow = [sem_pre_3cue,sem_post_3cue,sem_pre_3wm,sem_post_3wm,sem_pre_3ot,sem_post_3ot];
% % errhigh = [sem_pre_3cue,sem_post_3cue,sem_pre_3wm,sem_post_3wm,sem_pre_3ot,sem_post_3ot];
% hold on
% er = errorbar(xlength,bvals,errall,errall,'k'); 
% er.LineStyle = 'none';
ylim([0 max(max(bvals_new))+500]);
ax.XAxis.LineWidth = 5;
ax.YAxis.LineWidth = 5;
ax.XAxis.FontSize = 30;
ax.YAxis.FontSize = 30;
hold off 


%% do for full task animals!!!!!
%but with diff method
%thalamo-striatal 1st
% %animal 5 T6, 9april to 19 april
load('D:\Rats_in_Training\D6_output\Results-D6-Dahlia\ratBEHstruct.mat');
%first have to divide protocol 7 into cued and wm 
%protocol 8 is ot
%filter data from these protocols 

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
current_protocol{1,k} = ratBEHstruct(k).protocol;
end
current_protocol_mat = cell2mat(current_protocol);
%flexible sessions 

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
end
%find rewarded trials 
for k = 1:length(ratBEHstruct)
    rewards{1,k} = find(combined_hits{1,k} == 1);
end
%ot sequence for t6_titli is CRC
for k = 1:length(ratBEHstruct) 
target_pokes{1,k} = ratBEHstruct(k).targetNames;
size_targetpoke(1,k) = size(target_pokes{1,k},2);
end
empty_cell = find(size_targetpoke == 1);
%discard them 
target_pokes(empty_cell) = [];
rewards(empty_cell) = [];
current_protocol(empty_cell) = []; 
current_protocol_mat(empty_cell) = []; 

for k = 1:length(target_pokes)
poke_seq{1,k} = startsWith(target_pokes{1,k},'RCR');
end

for k = 1:length(target_pokes)
pokes_we_need{1,k} = find(poke_seq{1,k} == 1);
end
empty_pokes_part2 = find(cellfun(@isempty,pokes_we_need));
pokes_we_need(empty_pokes_part2) = [];
rewards(empty_pokes_part2) = [];
current_protocol(empty_pokes_part2) = [];
current_protocol_mat(empty_pokes_part2) = [];

%filter out all times  
for k =1:length(ratBEHstruct)
all_times{1,k} = ratBEHstruct(k).pokeTimes;
end
all_times(empty_cell) = [];
all_times(empty_pokes_part2) = [];
flex_sess = find(current_protocol_mat == 7);
ot_sess = find(current_protocol_mat == 8);

rewarded_ot = rewards(ot_sess);
rewarded_flex = rewards(flex_sess);
ratBEHstruct_updated = ratBEHstruct();
ratBEHstruct_updated(empty_cell) = [];
ratBEHstruct_updated(empty_pokes_part2) = [];

for n = 1:length(ratBEHstruct_updated)
dates{n} = ratBEHstruct_updated(n).date;
end
dateflex = dates(flex_sess);
%divide flex into cued and wm
%do only for sessions in flexible 

for s = 1:length(ratBEHstruct)
    blocklength(s) = max(ratBEHstruct(s).blocknum);
end

for s = 1:length(ratBEHstruct)
idx_cued{s} = find(ratBEHstruct(s).blocknumRepair<(blocklength(s)+1)/2);
end

for s = 1:length(ratBEHstruct)
idx_wm{s} = find(ratBEHstruct(s).blocknumRepair>=(blocklength(s)+1)/2);
end
%now divide into cued and wm 
idxcued_flex = idx_cued(flex_sess);
idxwm_flex = idx_wm(flex_sess);
%ot sessions 
ot_sess = find(current_protocol_mat == 8);
dateot = dates(ot_sess);
%%%%find intersection of idxcued_flex and pokes_we_need
pokes_flex = pokes_we_need(flex_sess);
pokes_ot = pokes_we_need(ot_sess);

for n = 1:length(idxcued_flex)
idxcued1_flex{1,n} =  intersect(idxcued_flex{1,n},pokes_flex{1,n}); 
end

for n = 1:length(idxwm_flex)
 idxwm1_flex{1,n} =  intersect(idxwm_flex{1,n},pokes_flex{1,n}); 
end

%from rewarded flex, select cue and wm 
for n = 1:length(rewarded_flex)
 reward_cued{1,n} =  intersect(idxcued1_flex{1,n},rewarded_flex{1,n}); 
end

for n = 1:length(rewarded_flex)
 reward_wm{1,n} =  intersect(idxwm1_flex{1,n},rewarded_flex{1,n}); 
end

for n = 1:length(ot_sess)
poke_ot_times{1,n} = ratBEHstruct_updated(ot_sess(1,n)).pokeTimes;
end
for n = 1:length(ot_sess)
  ottimes{1,n} =  poke_ot_times{1,n}(rewarded_ot{1,n});
end

for n = 1:length(flex_sess)
poke_cue_times{1,n} = ratBEHstruct_updated(flex_sess(1,n)).pokeTimes;
end
for n = 1:length(flex_sess)
  cuetimes{1,n} =  poke_cue_times{1,n}(reward_cued{1,n});
end

for n = 1:length(flex_sess)
poke_wm_times{1,n} = ratBEHstruct_updated(flex_sess(1,n)).pokeTimes;
end
for n = 1:length(flex_sess)
  wmtimes{1,n} =  poke_wm_times{1,n}(reward_wm{1,n});
end

%
surgery_d6_flex = 257; %14feb 
surgery_post_d6flex = 258;%hardcoded for animal
window_ot = 60;
surgery_d6otpre = 94; %(using dateot)
surgery_d6otpost = 95;
%select prepost surgery
prerangeflex = surgery_d6_flex - window_ot: length(dateflex);
postrangeflex =  surgery_post_d6flex - window_ot:length(dateflex);
prerangeot = surgery_d6otpre - window_ot: length(dateot);
postrangeot = surgery_d6otpost - window_ot: length(dateot);

%first filter out sessions we need
trials_pre_cue = cuetimes(prerangeflex);
trials_post_cue = cuetimes(postrangeflex);
trials_pre_wm = wmtimes(prerangeflex);
trials_post_wm = wmtimes(postrangeflex);
trials_pre_ot = ottimes(prerangeot);
trials_post_ot = ottimes(postrangeot);

trialtime_precue = trials_pre_cue;
trialtime_postcue = trials_post_cue;
trialtime_precue = trialtime_precue(~cellfun('isempty',trialtime_precue));
trialtime_postcue= trialtime_postcue(~cellfun('isempty',trialtime_postcue));

trialtime_prewm = trials_pre_wm;
trialtime_postwm = trials_post_wm;
trialtime_prewm = trialtime_prewm(~cellfun('isempty',trialtime_prewm));
trialtime_postwm= trialtime_postwm(~cellfun('isempty',trialtime_postwm));

trialtime_preot = trials_pre_ot;
trialtime_postot = trials_post_ot;
trialtime_preot = trialtime_preot(~cellfun('isempty',trialtime_preot));
trialtime_postot= trialtime_postot(~cellfun('isempty',trialtime_postot));

for kk = 1:length(trialtime_precue)
time_selected_precue{1,kk} = trialtime_precue{1,kk}(~cellfun('isempty',trialtime_precue{1,kk}));
end

%find trial time pre surgery
for k = 1:length(time_selected_precue)
for g = 1:length(time_selected_precue{1,k})
finaltrialtime_precue{1,k}{1,g} = time_selected_precue{1,k}{1,g}(end,:)-time_selected_precue{1,k}{1,g}(1,1);
end
end

for kk = 1:length(trialtime_postcue)
time_selected_postcue{1,kk} = trialtime_postcue{1,kk}(~cellfun('isempty',trialtime_postcue{1,kk}));
end

%find trial time post surgery
for kk = 1:length(time_selected_postcue)
for gg = 1:length(time_selected_postcue{1,kk})
finaltrialtime_postcue{1,kk}{1,gg} = time_selected_postcue{1,kk}{1,gg}(end,:)-time_selected_postcue{1,kk}{1,gg}(1,1);
end
end

%avg it, pre  
for k = 1:length(finaltrialtime_precue)
    mean_pretimescue{1,k} = mean(cell2mat(finaltrialtime_precue{1,k}));
end 

%avg it, post
for kk = 1:length(finaltrialtime_postcue)
    mean_posttimescue{1,kk} = mean(cell2mat(finaltrialtime_postcue{1,kk}));
end

mean_pre_finalcue = mean(cell2mat(mean_pretimescue));
mean_post_finalcue = mean(cell2mat(mean_posttimescue));
%significance test 
htestcue = ttest2(cell2mat(mean_pretimescue),cell2mat(mean_posttimescue));

%for wm

for kk = 1:length(trialtime_prewm)
time_selected_prewm{1,kk} = trialtime_prewm{1,kk}(~cellfun('isempty',trialtime_prewm{1,kk}));
end

%find trial time pre surgery
for k = 1:length(time_selected_prewm)
for g = 1:length(time_selected_prewm{1,k})
finaltrialtime_prewm{1,k}{1,g} = time_selected_prewm{1,k}{1,g}(end,:)-time_selected_prewm{1,k}{1,g}(1,1);
end
end

for kk = 1:length(trialtime_postwm)
time_selected_postwm{1,kk} = trialtime_postwm{1,kk}(~cellfun('isempty',trialtime_postwm{1,kk}));
end

%find trial time post surgery
for kk = 1:length(time_selected_postwm)
for gg = 1:length(time_selected_postwm{1,kk})
finaltrialtime_postwm{1,kk}{1,gg} = time_selected_postwm{1,kk}{1,gg}(end,:)-time_selected_postwm{1,kk}{1,gg}(1,1);
end
end

%avg it, pre 
for k = 1:length(finaltrialtime_prewm)
    mean_pretimeswm{1,k} = mean(cell2mat(finaltrialtime_prewm{1,k}));
end 

%avg it, post
for kk = 1:length(finaltrialtime_postwm)
    mean_posttimeswm{1,kk} = mean(cell2mat(finaltrialtime_postwm{1,kk}));
end

mean_pre_finalwm = mean(cell2mat(mean_pretimeswm));
mean_post_finalwm = mean(cell2mat(mean_posttimeswm));
%significance test 
htestwm = ttest2(cell2mat(mean_pretimeswm),cell2mat(mean_posttimeswm));

%for ot 

for kk = 1:length(trialtime_preot)
time_selected_preot{1,kk} = trialtime_preot{1,kk}(~cellfun('isempty',trialtime_preot{1,kk}));
end

%find trial time pre surgery
for k = 1:length(time_selected_preot)
for g = 1:length(time_selected_preot{1,k})
finaltrialtime_preot{1,k}{1,g} = time_selected_preot{1,k}{1,g}(end,:)-time_selected_preot{1,k}{1,g}(1,1);
end
end

for kk = 1:length(trialtime_postot)
time_selected_postot{1,kk} = trialtime_postot{1,kk}(~cellfun('isempty',trialtime_postot{1,kk}));
end

%find trial time post surgery
for kk = 1:length(time_selected_postot)
for gg = 1:length(time_selected_postot{1,kk})
finaltrialtime_postot{1,kk}{1,gg} = time_selected_postot{1,kk}{1,gg}(end,:)-time_selected_postot{1,kk}{1,gg}(1,1);
end
end

%avg it, pre 
for k = 1:length(finaltrialtime_preot)
    mean_pretimesot{1,k} = mean(cell2mat(finaltrialtime_preot{1,k}));
end 

%avg it, post
for kk = 1:length(finaltrialtime_postot)
    mean_posttimesot{1,kk} = mean(cell2mat(finaltrialtime_postot{1,kk}));
end

mean_pre_finalot = mean(cell2mat(mean_pretimesot));
mean_post_finalot = mean(cell2mat(mean_posttimesot));
%significance test 
htestot = ttest2(cell2mat(mean_pretimesot),cell2mat(mean_posttimesot));

%significant 
%plot it, plot multiple bars together 
figure(4)
trial_first_half = [mean_pre_finalcue, mean_pre_finalwm, mean_pre_finalot];
trial_second_half = [mean_post_finalcue, mean_post_finalwm, mean_post_finalot];
bvals = [trial_first_half;trial_second_half];
xlength = 1:length(trial_first_half);
clr = [0.87 0.56 0.65; 0.52 0.61 0.82; 0.4660 0.6740 0.1880];
clr2 = [1 0 0;0 0 1;0 0.5 0];
hold on 
barplot1 = bar(xlength,bvals,'facecolor','flat');
hold on 
barplot1(1,1).CData = clr;
barplot1(1,2).CData = clr2;
hold off
%plot avg accuracies in dmsl vs control
sd_precue = std(cell2mat(mean_pretimescue));
sd_postcue = std(cell2mat(mean_posttimescue));
sem_pre_3cue = sd_precue./sqrt(length(mean_pretimescue));
sem_post_3cue = sd_postcue./sqrt(length(mean_posttimescue));

sd_prewm = std(cell2mat(mean_pretimeswm));
sd_postwm = std(cell2mat(mean_posttimeswm));
sem_pre_3wm = sd_precue./sqrt(length(mean_pretimeswm));
sem_post_3wm = sd_postcue./sqrt(length(mean_posttimeswm));

sd_preot = std(cell2mat(mean_pretimesot));
sd_postot = std(cell2mat(mean_posttimesot));
sem_pre_3ot = sd_preot./sqrt(length(mean_pretimesot));
sem_post_3ot = sd_postot./sqrt(length(mean_posttimesot));
Xlabelval = {'Cued','WM','OT'};
ax = gca
set(ax,'XTick',xlength,'XTickLabel',Xlabelval);
hold on 
ylabel('Trial time (ms)','FontSize',20,'FontWeight','bold')
xlabel('Condition','FontSize',20,'FontWeight','bold')
hold on 
% errlow_all= [sem_pre_3cue,sem_pre_3wm,sem_pre_3ot];
% errhigh_all= [sem_post_3cue,sem_post_3wm,sem_post_3ot];
% errall = [errlow_all;errhigh_all];
% % errlow = [sem_pre_3cue,sem_post_3cue,sem_pre_3wm,sem_post_3wm,sem_pre_3ot,sem_post_3ot];
% % errhigh = [sem_pre_3cue,sem_post_3cue,sem_pre_3wm,sem_post_3wm,sem_pre_3ot,sem_post_3ot];
% hold on
% er = errorbar(xlength,bvals,errall,errall,'k'); 
% er.LineStyle = 'none';
ylim([0 max(max(bvals))+500]);
ax.XAxis.LineWidth = 5;
ax.YAxis.LineWidth = 5;
ax.XAxis.FontSize = 30;
ax.YAxis.FontSize = 30;
hold off 
%% for t6


bvals_new = bvals;
bvals_new(:,2) = [];
%significant 
%plot it, plot multiple bars together 
figure(5) %without wm 
trial_first_half = [mean_pre_finalcue, mean_pre_finalot];
trial_second_half = [mean_post_finalcue, mean_post_finalot];
%bvals = [trial_first_half;trial_second_half];
xlength = 1:length(trial_first_half);
clr = [0.87 0.56 0.65; 0.4660 0.6740 0.1880];
clr2 = [1 0 0;0 0.5 0];
hold on 
barplot1 = bar(xlength,bvals_new','facecolor','flat');
hold on 
barplot1(1,1).CData = clr;
barplot1(1,2).CData = clr2;
hold off
%plot avg accuracies in dmsl vs control
sd_precue = std(cell2mat(mean_pretimescue));
sd_postcue = std(cell2mat(mean_posttimescue));
sem_pre_3cue = sd_precue./sqrt(length(mean_pretimescue));
sem_post_3cue = sd_postcue./sqrt(length(mean_posttimescue));

sd_prewm = std(cell2mat(mean_pretimeswm));
sd_postwm = std(cell2mat(mean_posttimeswm));
sem_pre_3wm = sd_precue./sqrt(length(mean_pretimeswm));
sem_post_3wm = sd_postcue./sqrt(length(mean_posttimeswm));

sd_preot = std(cell2mat(mean_pretimesot));
sd_postot = std(cell2mat(mean_posttimesot));
sem_pre_3ot = sd_preot./sqrt(length(mean_pretimesot));
sem_post_3ot = sd_postot./sqrt(length(mean_posttimesot));
Xlabelval = {'Cued','OT'};
ax = gca
set(ax,'XTick',xlength,'XTickLabel',Xlabelval);
hold on 
ylabel('Trial time (ms)','FontSize',20,'FontWeight','bold')
xlabel('Condition','FontSize',20,'FontWeight','bold')
hold on 
% errlow_all= [sem_pre_3cue,sem_pre_3wm,sem_pre_3ot];
% errhigh_all= [sem_post_3cue,sem_post_3wm,sem_post_3ot];
% errall = [errlow_all;errhigh_all];
% % errlow = [sem_pre_3cue,sem_post_3cue,sem_pre_3wm,sem_post_3wm,sem_pre_3ot,sem_post_3ot];
% % errhigh = [sem_pre_3cue,sem_post_3cue,sem_pre_3wm,sem_post_3wm,sem_pre_3ot,sem_post_3ot];
% hold on
% er = errorbar(xlength,bvals,errall,errall,'k'); 
% er.LineStyle = 'none';
ylim([0 max(max(bvals_new))+500]);
ax.XAxis.LineWidth = 5;
ax.YAxis.LineWidth = 5;
ax.XAxis.FontSize = 30;
ax.YAxis.FontSize = 30;
hold off 
%% for t6

%% %% do for full task animals!!!!!
%for f3
%but with diff method
%thalamo-striatal 1st
% %animal 5 T6, 9april to 19 april
load('D:\Rats_in_Training\F3_output\Results-F3-Fit\ratBEHstruct.mat');
%first have to divide protocol 7 into cued and wm 
%protocol 8 is ot
%filter data from these protocols 

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
current_protocol{1,k} = ratBEHstruct(k).protocol;
end
current_protocol_mat = cell2mat(current_protocol);
%flexible sessions 

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
end
%find rewarded trials 
for k = 1:length(ratBEHstruct)
    rewards{1,k} = find(combined_hits{1,k} == 1);
end

%filter out all times  
for k =1:length(ratBEHstruct)
all_times{1,k} = ratBEHstruct(k).pokeTimes;
end

flex_sess = find(current_protocol_mat == 7);
ot_sess = find(current_protocol_mat == 8);

rewarded_ot = rewards(ot_sess);
rewarded_flex = rewards(flex_sess);

for n = 1:length(ratBEHstruct)
dates{n} = ratBEHstruct(n).date;
end
dateflex = dates(flex_sess);
dateot =  dates(ot_sess);

%filter out all times  
for k =1:length(ratBEHstruct)
cue_times{1,k} = ratBEHstruct(k).cuedTimes;
end
times_ot= all_times(ot_sess);
times_flex= all_times(flex_sess);
cueflex = cue_times(flex_sess);

for n = 1:length(rewarded_ot)
rewarded_poke_ot{1,n} = times_ot{1,n}(rewarded_ot{1,n});
end

for n = 1:length(rewarded_flex)
rewarded_poke_flex{1,n} = times_flex{1,n}(rewarded_flex{1,n});
end

for p = 1:length(rewarded_flex)
cue_flex{1,p} = cueflex{1,p}(rewarded_flex{1,p});
end
empty_ot = find(cellfun(@isempty,rewarded_poke_ot));
empty_flex = find(cellfun(@isempty,rewarded_poke_flex));
dateflex(empty_flex) = [];
dateot(empty_ot) = [];
rewarded_poke_flex(empty_flex) = [];
cue_flex(empty_flex) =[];
rewarded_poke_ot(empty_ot) = [];

for n = 1:length(rewarded_poke_ot)
size_ot(1,n) = size(rewarded_poke_ot{1,n},2);
end

for n = 1:length(rewarded_poke_flex)
size_flex(1,n) = size(rewarded_poke_flex{1,n},2);
end

emptyot_2 = find(size_ot == 1);
emptyflex_2 = find(size_flex == 1);
%%%%further removal 
rewarded_poke_ot(emptyot_2) = [];
rewarded_poke_flex(emptyflex_2) = [];
dateflex(emptyflex_2) = [];
dateot(emptyot_2) = [];

for n = 1:length(rewarded_poke_flex)
    rewarded_poke_flex{1,n} = rewarded_poke_flex{1,n}(~cellfun('isempty',rewarded_poke_flex{1,n}));
end

for n = 1:length(rewarded_poke_ot)
    rewarded_poke_ot{1,n} = rewarded_poke_ot{1,n}(~cellfun('isempty',rewarded_poke_ot{1,n}));
end

for n = 1:length(rewarded_poke_ot)
    for nn = 1:length(rewarded_poke_ot{1,n})
        duration_ot{1,n}(1,nn) = rewarded_poke_ot{1,n}{1,nn}(end)-rewarded_poke_ot{1,n}{1,nn}(1); 
    end
end

for n = 1:length(rewarded_poke_flex)
    for nn = 1:length(rewarded_poke_flex{1,n})
        duration_flex{1,n}(1,nn) = rewarded_poke_flex{1,n}{1,nn}(end)-rewarded_poke_flex{1,n}{1,nn}(1); 
    end
end
%date range
%surgery was on date: 5june or so
%flexrange =  25 april to 5 june 15days? 
% flexrangepre  = 315:398; %from dateflex
% flexrangepost = 435:476;%from dateot % 28julyto 15 august
% otrangepre = 94:127;
% otrangepost = 143:159;

flexrangepre  = 358:398; %from dateflex %20 may to 5 june 
flexrangepost = 399:433;%from dateot % 28june to 21july
otrangepre = 113:127;
otrangepost = 128:142;


duration_flex_pre = duration_flex(flexrangepre);
duration_flex_post = duration_flex(flexrangepost);
duration_ot_post = duration_ot(otrangepost);
duration_ot_pre = duration_ot(otrangepre);
for n = 1:length(duration_flex_pre)
mean_preflextimes(1,n) = mean(duration_flex_pre{1,n});
end

for n = 1:length(duration_flex_post)
mean_postflextimes(1,n) = mean(duration_flex_post{1,n});
end

for n = 1:length(duration_ot_pre)
mean_preottimes(1,n) = mean(duration_ot_pre{1,n});
end

for n = 1:length(duration_ot_post)
mean_postottimes(1,n) = mean(duration_ot_post{1,n});
end

flexpre = mean(mean_preflextimes);
flexpost = mean(mean_postflextimes);
otpre = mean(mean_preottimes);
otpost = mean(mean_postottimes);
htestot = ttest2(mean_preottimes,mean_postottimes);
htestflex = ttest2(mean_preflextimes,mean_postflextimes);

%significant 
%plot it, plot multiple bars together 
figure(5) %without wm 
trial_first_half = [flexpre, flexpost];
trial_second_half = [otpre, otpost];
bvals = [trial_first_half;trial_second_half];
xlength = 1:length(trial_first_half);
clr = [0.87 0.56 0.65; 0.4660 0.6740 0.1880];
clr2 = [1 0 0;0 0.5 0];
hold on 
barplot1 = bar(xlength,bvals,'facecolor','flat');
hold on 
barplot1(1,1).CData = clr;
barplot1(1,2).CData = clr2;
hold off
%plot avg accuracies in dmsl vs control
Xlabelval = {'Cued','OT'};
ax = gca
set(ax,'XTick',xlength,'XTickLabel',Xlabelval);
hold on 
ylabel('Trial time (ms)','FontSize',20,'FontWeight','bold')
xlabel('Condition','FontSize',20,'FontWeight','bold')
hold on 
ylim([0 max(max(bvals))+500]);
ax.XAxis.LineWidth = 5;
ax.YAxis.LineWidth = 5;
ax.XAxis.FontSize = 30;
ax.YAxis.FontSize = 30;
hold off 
%% for f3



%% %% %% do for full task animals!!!!!
%for T1
%but with diff method
%thalamo-striatal 1st
% %animal 5 T6, 9april to 19 april
load('D:\Rats_in_Training\T1_output\Results-T1-Toy\ratBEHstruct.mat');
%first have to divide protocol 7 into cued and wm 
%protocol 8 is ot
%filter data from these protocols 

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
current_protocol{1,k} = ratBEHstruct(k).protocol;
end
current_protocol_mat = cell2mat(current_protocol);
%flexible sessions 

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
end
%find rewarded trials 
for k = 1:length(ratBEHstruct)
    rewards{1,k} = find(combined_hits{1,k} == 1);
end

%filter out all times  
for k =1:length(ratBEHstruct)
all_times{1,k} = ratBEHstruct(k).pokeTimes;
end

flex_sess = find(current_protocol_mat == 7);
ot_sess = find(current_protocol_mat == 8);

rewarded_ot = rewards(ot_sess);
rewarded_flex = rewards(flex_sess);

for n = 1:length(ratBEHstruct)
dates{n} = ratBEHstruct(n).date;
end
dateflex = dates(flex_sess);
dateot =  dates(ot_sess);

%filter out all times  
for k =1:length(ratBEHstruct)
cue_times{1,k} = ratBEHstruct(k).cuedTimes;
end
times_ot= all_times(ot_sess);
times_flex= all_times(flex_sess);
cueflex = cue_times(flex_sess);

for n = 1:length(rewarded_ot)
rewarded_poke_ot{1,n} = times_ot{1,n}(rewarded_ot{1,n});
end

for n = 1:length(rewarded_flex)
rewarded_poke_flex{1,n} = times_flex{1,n}(rewarded_flex{1,n});
end

for p = 1:length(rewarded_flex)
cue_flex{1,p} = cueflex{1,p}(rewarded_flex{1,p});
end
empty_ot = find(cellfun(@isempty,rewarded_poke_ot));
empty_flex = find(cellfun(@isempty,rewarded_poke_flex));
dateflex(empty_flex) = [];
dateot(empty_ot) = [];
rewarded_poke_flex(empty_flex) = [];
cue_flex(empty_flex) =[];
rewarded_poke_ot(empty_ot) = [];

for n = 1:length(rewarded_poke_ot)
size_ot(1,n) = size(rewarded_poke_ot{1,n},2);
end

for n = 1:length(rewarded_poke_flex)
size_flex(1,n) = size(rewarded_poke_flex{1,n},2);
end

emptyot_2 = find(size_ot == 1);
emptyflex_2 = find(size_flex == 1);
%%%%further removal 
rewarded_poke_ot(emptyot_2) = [];
rewarded_poke_flex(emptyflex_2) = [];
dateflex(emptyflex_2) = [];
dateot(emptyot_2) = [];

for n = 1:length(rewarded_poke_flex)
    rewarded_poke_flex{1,n} = rewarded_poke_flex{1,n}(~cellfun('isempty',rewarded_poke_flex{1,n}));
end

for n = 1:length(rewarded_poke_ot)
    rewarded_poke_ot{1,n} = rewarded_poke_ot{1,n}(~cellfun('isempty',rewarded_poke_ot{1,n}));
end

for n = 1:length(rewarded_poke_ot)
    for nn = 1:length(rewarded_poke_ot{1,n})
        duration_ot{1,n}(1,nn) = rewarded_poke_ot{1,n}{1,nn}(end)-rewarded_poke_ot{1,n}{1,nn}(1); 
    end
end

for n = 1:length(rewarded_poke_flex)
    for nn = 1:length(rewarded_poke_flex{1,n})
        duration_flex{1,n}(1,nn) = rewarded_poke_flex{1,n}{1,nn}(end)-rewarded_poke_flex{1,n}{1,nn}(1); 
    end
end

flexrangepre  = 231:266; %from dateflex %19 may to 1 june 
flexrangepost = 268:283;%from dateot % 30june to 12july
otrangepre = 68:80;
otrangepost = 81:93;


duration_flex_pre = duration_flex(flexrangepre);
duration_flex_post = duration_flex(flexrangepost);
duration_ot_post = duration_ot(otrangepost);
duration_ot_pre = duration_ot(otrangepre);
for n = 1:length(duration_flex_pre)
mean_preflextimes(1,n) = mean(duration_flex_pre{1,n});
end

for n = 1:length(duration_flex_post)
mean_postflextimes(1,n) = mean(duration_flex_post{1,n});
end

for n = 1:length(duration_ot_pre)
mean_preottimes(1,n) = mean(duration_ot_pre{1,n});
end

for n = 1:length(duration_ot_post)
mean_postottimes(1,n) = mean(duration_ot_post{1,n});
end

flexpre = mean(mean_preflextimes);
flexpost = mean(mean_postflextimes);
otpre = mean(mean_preottimes);
otpost = mean(mean_postottimes);
htestot = ttest2(mean_preottimes,mean_postottimes);
htestflex = ttest2(mean_preflextimes,mean_postflextimes);

%significant 
%plot it, plot multiple bars together 
figure(5) %without wm 
trial_first_half = [flexpre, flexpost];
trial_second_half = [otpre, otpost];
bvals = [trial_first_half;trial_second_half];
xlength = 1:length(trial_first_half);
clr = [0.87 0.56 0.65; 0.4660 0.6740 0.1880];
clr2 = [1 0 0;0 0.5 0];
hold on 
barplot1 = bar(xlength,bvals,'facecolor','flat');
hold on 
barplot1(1,1).CData = clr;
barplot1(1,2).CData = clr2;
hold off
%plot avg accuracies in dmsl vs control
Xlabelval = {'Cued','OT'};
ax = gca
set(ax,'XTick',xlength,'XTickLabel',Xlabelval);
hold on 
ylabel('Trial time (ms)','FontSize',20,'FontWeight','bold')
xlabel('Condition','FontSize',20,'FontWeight','bold')
hold on 
ylim([0 max(max(bvals))+500]);
ax.XAxis.LineWidth = 5;
ax.YAxis.LineWidth = 5;
ax.XAxis.FontSize = 30;
ax.YAxis.FontSize = 30;
hold off 
%% for f3


%% %% %% %% do for full task animals!!!!!
%for T1
%but with diff method
%thalamo-striatal 1st
% %animal 5 T6, 9april to 19 april
load('D:\Rats_in_Training\E1_output\Results-E1-Rat129\ratBEHstruct.mat');
%first have to divide protocol 7 into cued and wm 
%protocol 8 is ot
%filter data from these protocols 

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
current_protocol{1,k} = ratBEHstruct(k).protocol;
end
current_protocol_mat = cell2mat(current_protocol);
%flexible sessions 

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
end
%find rewarded trials 
for k = 1:length(ratBEHstruct)
    rewards{1,k} = find(combined_hits{1,k} == 1);
end

%filter out all times  
for k =1:length(ratBEHstruct)
all_times{1,k} = ratBEHstruct(k).pokeTimes;
end

flex_sess = find(current_protocol_mat == 7);
ot_sess = find(current_protocol_mat == 8);

rewarded_ot = rewards(ot_sess);
rewarded_flex = rewards(flex_sess);

for n = 1:length(ratBEHstruct)
dates{n} = ratBEHstruct(n).date;
end
dateflex = dates(flex_sess);
dateot =  dates(ot_sess);

%filter out all times  
for k =1:length(ratBEHstruct)
cue_times{1,k} = ratBEHstruct(k).cuedTimes;
end
times_ot= all_times(ot_sess);
times_flex= all_times(flex_sess);
cueflex = cue_times(flex_sess);

for n = 1:length(rewarded_ot)
rewarded_poke_ot{1,n} = times_ot{1,n}(rewarded_ot{1,n});
end

for n = 1:length(rewarded_flex)
rewarded_poke_flex{1,n} = times_flex{1,n}(rewarded_flex{1,n});
end

for p = 1:length(rewarded_flex)
cue_flex{1,p} = cueflex{1,p}(rewarded_flex{1,p});
end
empty_ot = find(cellfun(@isempty,rewarded_poke_ot));
empty_flex = find(cellfun(@isempty,rewarded_poke_flex));
dateflex(empty_flex) = [];
dateot(empty_ot) = [];
rewarded_poke_flex(empty_flex) = [];
cue_flex(empty_flex) =[];
rewarded_poke_ot(empty_ot) = [];

for n = 1:length(rewarded_poke_ot)
size_ot(1,n) = size(rewarded_poke_ot{1,n},2);
end

for n = 1:length(rewarded_poke_flex)
size_flex(1,n) = size(rewarded_poke_flex{1,n},2);
end

emptyot_2 = find(size_ot == 1);
emptyflex_2 = find(size_flex == 1);
%%%%further removal 
rewarded_poke_ot(emptyot_2) = [];
rewarded_poke_flex(emptyflex_2) = [];
dateflex(emptyflex_2) = [];
dateot(emptyot_2) = [];

for n = 1:length(rewarded_poke_flex)
    rewarded_poke_flex{1,n} = rewarded_poke_flex{1,n}(~cellfun('isempty',rewarded_poke_flex{1,n}));
end

for n = 1:length(rewarded_poke_ot)
    rewarded_poke_ot{1,n} = rewarded_poke_ot{1,n}(~cellfun('isempty',rewarded_poke_ot{1,n}));
end

for n = 1:length(rewarded_poke_ot)
    for nn = 1:length(rewarded_poke_ot{1,n})
        duration_ot{1,n}(1,nn) = rewarded_poke_ot{1,n}{1,nn}(end)-rewarded_poke_ot{1,n}{1,nn}(1); 
    end
end

for n = 1:length(rewarded_poke_flex)
    for nn = 1:length(rewarded_poke_flex{1,n})
        duration_flex{1,n}(1,nn) = rewarded_poke_flex{1,n}{1,nn}(end)-rewarded_poke_flex{1,n}{1,nn}(1); 
    end
end

flexrangepre  = 537:582; %from dateflex %5 june to 20 june
flexrangepost = 583:623;%from dateot % 3july to 18july
otrangepre = 118:131;
otrangepost = 132:146;


duration_flex_pre = duration_flex(flexrangepre);
duration_flex_post = duration_flex(flexrangepost);
duration_ot_post = duration_ot(otrangepost);
duration_ot_pre = duration_ot(otrangepre);
for n = 1:length(duration_flex_pre)
mean_preflextimes(1,n) = mean(duration_flex_pre{1,n});
end

for n = 1:length(duration_flex_post)
mean_postflextimes(1,n) = mean(duration_flex_post{1,n});
end

for n = 1:length(duration_ot_pre)
mean_preottimes(1,n) = mean(duration_ot_pre{1,n});
end

for n = 1:length(duration_ot_post)
mean_postottimes(1,n) = mean(duration_ot_post{1,n});
end

flexpre = mean(mean_preflextimes);
flexpost = mean(mean_postflextimes);
otpre = mean(mean_preottimes);
otpost = mean(mean_postottimes);
htestot = ttest2(mean_preottimes,mean_postottimes);
htestflex = ttest2(mean_preflextimes,mean_postflextimes);

%significant 
%plot it, plot multiple bars together 
figure(5) %without wm 
trial_first_half = [flexpre, flexpost];
trial_second_half = [otpre, otpost];
bvals = [trial_first_half;trial_second_half];
xlength = 1:length(trial_first_half);
clr = [0.87 0.56 0.65; 0.4660 0.6740 0.1880];
clr2 = [1 0 0;0 0.5 0];
hold on 
barplot1 = bar(xlength,bvals,'facecolor','flat');
hold on 
barplot1(1,1).CData = clr;
barplot1(1,2).CData = clr2;
hold off
%plot avg accuracies in dmsl vs control
Xlabelval = {'Cued','OT'};
ax = gca
set(ax,'XTick',xlength,'XTickLabel',Xlabelval);
hold on 
ylabel('Trial time (ms)','FontSize',20,'FontWeight','bold')
xlabel('Condition','FontSize',20,'FontWeight','bold')
hold on 
ylim([0 max(max(bvals))+500]);
ax.XAxis.LineWidth = 5;
ax.YAxis.LineWidth = 5;
ax.XAxis.FontSize = 30;
ax.YAxis.FontSize = 30;
hold off 
%% for f3



%% %% %% %% %% do for full task animals!!!!!
%for t6_tITLI
%but with diff method
%thalamo-striatal 1st
% %animal 5 T6, 9april to 19 april
load('D:\Rats_in_Training\T6_output\Results-T6-Titli\ratBEHstruct.mat');
%first have to divide protocol 7 into cued and wm 
%protocol 8 is ot
%filter data from these protocols 

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
current_protocol{1,k} = ratBEHstruct(k).protocol;
end
current_protocol_mat = cell2mat(current_protocol);
%flexible sessions 

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
end
%find rewarded trials 
for k = 1:length(ratBEHstruct)
    rewards{1,k} = find(combined_hits{1,k} == 1);
end

%filter out all times  
for k =1:length(ratBEHstruct)
all_times{1,k} = ratBEHstruct(k).pokeTimes;
end

flex_sess = find(current_protocol_mat == 7);
ot_sess = find(current_protocol_mat == 8);

for s = 1:length(ratBEHstruct)
    blocklength(s) = max(ratBEHstruct(s).blocknum);
end

for s = 1:length(ratBEHstruct)
idx_cued{s} = find(ratBEHstruct(s).blocknumRepair<(blocklength(s)+1)/2);
end

% for s = 1:length(ratBEHstruct)
% idx_wm{s} = find(ratBEHstruct(s).blocknumRepair>=(blocklength(s)+1)/2);
% end
%now divide into cued and wm 
idxcued_flex = idx_cued(flex_sess);
% idxwm_flex = idx_wm(flex_sess);
%ot sessions 
rewarded_ot = rewards(ot_sess);
rewarded_flex = rewards(flex_sess);

for n = 1:length(ratBEHstruct)
dates{n} = ratBEHstruct(n).date;
end
dateflex = dates(flex_sess);
dateot =  dates(ot_sess);

%filter out all times  
for k =1:length(ratBEHstruct)
cue_times{1,k} = ratBEHstruct(k).cuedTimes;
end
times_ot= all_times(ot_sess);
times_flex= all_times(flex_sess);
cueflex = cue_times(flex_sess);

for n = 1:length(rewarded_ot)
rewarded_poke_ot{1,n} = times_ot{1,n}(rewarded_ot{1,n});
end

for n = 1:length(rewarded_flex)
rewarded_poke_flex{1,n} = times_flex{1,n}(rewarded_flex{1,n});
end

for p = 1:length(rewarded_flex)
cue_flex{1,p} = cueflex{1,p}(rewarded_flex{1,p});
end
empty_ot = find(cellfun(@isempty,rewarded_poke_ot));
empty_flex = find(cellfun(@isempty,rewarded_poke_flex));
dateflex(empty_flex) = [];
dateot(empty_ot) = [];
rewarded_poke_flex(empty_flex) = [];
cue_flex(empty_flex) =[];
rewarded_poke_ot(empty_ot) = [];

for n = 1:length(rewarded_poke_ot)
size_ot(1,n) = size(rewarded_poke_ot{1,n},2);
end

for n = 1:length(rewarded_poke_flex)
size_flex(1,n) = size(rewarded_poke_flex{1,n},2);
end

emptyot_2 = find(size_ot == 1);
emptyflex_2 = find(size_flex == 1);
%%%%further removal 
rewarded_poke_ot(emptyot_2) = [];
rewarded_poke_flex(emptyflex_2) = [];
dateflex(emptyflex_2) = [];
dateot(emptyot_2) = [];

for n = 1:length(rewarded_poke_flex)
    rewarded_poke_flex{1,n} = rewarded_poke_flex{1,n}(~cellfun('isempty',rewarded_poke_flex{1,n}));
end

for n = 1:length(rewarded_poke_ot)
    rewarded_poke_ot{1,n} = rewarded_poke_ot{1,n}(~cellfun('isempty',rewarded_poke_ot{1,n}));
end

for n = 1:length(rewarded_poke_ot)
    for nn = 1:length(rewarded_poke_ot{1,n})
        duration_ot{1,n}(1,nn) = rewarded_poke_ot{1,n}{1,nn}(end)-rewarded_poke_ot{1,n}{1,nn}(1); 
    end
end

for n = 1:length(rewarded_poke_flex)
    for nn = 1:length(rewarded_poke_flex{1,n})
        duration_flex{1,n}(1,nn) = rewarded_poke_flex{1,n}{1,nn}(end)-rewarded_poke_flex{1,n}{1,nn}(1); 
    end
end

flexrangepre  = 393:440; %from dateflex %24 march to 9 april
flexrangepost = 441:507;%from dateot % 19 april to 14 may
otrangepre = 112:128;
otrangepost = 129:154;


duration_flex_pre = duration_flex(flexrangepre);
duration_flex_post = duration_flex(flexrangepost);
duration_ot_post = duration_ot(otrangepost);
duration_ot_pre = duration_ot(otrangepre);
for n = 1:length(duration_flex_pre)
mean_preflextimes(1,n) = mean(duration_flex_pre{1,n});
end

for n = 1:length(duration_flex_post)
mean_postflextimes(1,n) = mean(duration_flex_post{1,n});
end

for n = 1:length(duration_ot_pre)
mean_preottimes(1,n) = mean(duration_ot_pre{1,n});
end

for n = 1:length(duration_ot_post)
mean_postottimes(1,n) = mean(duration_ot_post{1,n});
end

flexpre = mean(mean_preflextimes);
flexpost = mean(mean_postflextimes);
otpre = mean(mean_preottimes);
otpost = mean(mean_postottimes);
htestot = ttest2(mean_preottimes,mean_postottimes);
htestflex = ttest2(mean_preflextimes,mean_postflextimes);

%significant 
%plot it, plot multiple bars together 
figure(5) %without wm 
trial_first_half = [flexpre, flexpost];
trial_second_half = [otpre, otpost];
bvals = [trial_first_half;trial_second_half];
xlength = 1:length(trial_first_half);
clr = [0.87 0.56 0.65; 0.4660 0.6740 0.1880];
clr2 = [1 0 0;0 0.5 0];
hold on 
barplot1 = bar(xlength,bvals,'facecolor','flat');
hold on 
barplot1(1,1).CData = clr;
barplot1(1,2).CData = clr2;
hold off
%plot avg accuracies in dmsl vs control
Xlabelval = {'Cued','OT'};
ax = gca
set(ax,'XTick',xlength,'XTickLabel',Xlabelval);
hold on 
ylabel('Trial time (ms)','FontSize',20,'FontWeight','bold')
xlabel('Condition','FontSize',20,'FontWeight','bold')
hold on 
ylim([0 max(max(bvals))+500]);
ax.XAxis.LineWidth = 5;
ax.YAxis.LineWidth = 5;
ax.XAxis.FontSize = 30;
ax.YAxis.FontSize = 30;
hold off 
%% for f3




%% %% %% %% %% %% do for full task animals!!!!!
%for t6_tITLI
%but with diff method
%thalamo-striatal 1st
% %animal 5 T6, 9april to 19 april
load('D:\Rats_in_Training\T6_output\Results-T6-Titli\ratBEHstruct.mat');
%first have to divide protocol 7 into cued and wm 
%protocol 8 is ot
%filter data from these protocols 

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
current_protocol{1,k} = ratBEHstruct(k).protocol;
end
current_protocol_mat = cell2mat(current_protocol);
%flexible sessions 

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
end
%find rewarded trials 
for k = 1:length(ratBEHstruct)
    rewards{1,k} = find(combined_hits{1,k} == 1);
end

%filter out all times  
for k =1:length(ratBEHstruct)
all_times{1,k} = ratBEHstruct(k).pokeTimes;
end

flex_sess = find(current_protocol_mat == 7);
ot_sess = find(current_protocol_mat == 8);

for s = 1:length(ratBEHstruct)
    blocklength(s) = max(ratBEHstruct(s).blocknum);
end

for s = 1:length(ratBEHstruct)
idx_cued{s} = find(ratBEHstruct(s).blocknumRepair<(blocklength(s)+1)/2);
end

%now divide into cued and wm 
idxcued_flex = idx_cued(flex_sess);
% idxwm_flex = idx_wm(flex_sess);
%ot sessions 
rewarded_ot = rewards(ot_sess);
rewarded_flex = rewards(flex_sess);
for n = 1:length(rewarded_flex)
rewarded_cueflex{1,n} = intersect(idxcued_flex{1,n},rewarded_flex{1,n});
end

for n = 1:length(ratBEHstruct)
dates{n} = ratBEHstruct(n).date;
end
dateflex = dates(flex_sess);
dateot =  dates(ot_sess);

%filter out all times  
for k =1:length(ratBEHstruct)
cue_times{1,k} = ratBEHstruct(k).cuedTimes;
end
times_ot= all_times(ot_sess);
times_flex= all_times(flex_sess);
cueflex = cue_times(flex_sess);
% 
% for n = 1:length(times_flex)
%     for nn = 1:length(idxcued_flex{1,n})
%         times_flex_cued{1,n}{1,nn} = times_flex{1,n}{1,idxcued_flex{1,n}(1,nn)};
%     end
% end

for n = 1:length(rewarded_ot)
rewarded_poke_ot{1,n} = times_ot{1,n}(rewarded_ot{1,n});
end

for n = 1:length(rewarded_flex)
rewarded_poke_flex{1,n} = times_flex{1,n}(rewarded_cueflex{1,n});
end

empty_ot = find(cellfun(@isempty,rewarded_poke_ot));
empty_flex = find(cellfun(@isempty,rewarded_poke_flex));
dateflex(empty_flex) = [];
dateot(empty_ot) = [];
rewarded_poke_flex(empty_flex) = [];
rewarded_poke_ot(empty_ot) = [];
times_flex(empty_flex) = [];
idxcued_flex(empty_flex)=[];

for n = 1:length(rewarded_poke_ot)
size_ot(1,n) = size(rewarded_poke_ot{1,n},2);
end

for n = 1:length(rewarded_poke_flex)
size_flex(1,n) = size(rewarded_poke_flex{1,n},2);
end

emptyot_2 = find(size_ot == 1);
emptyflex_2 = find(size_flex == 1);
%%%%further removal 
rewarded_poke_ot(emptyot_2) = [];
rewarded_poke_flex(emptyflex_2) = [];
dateflex(emptyflex_2) = [];
dateot(emptyot_2) = [];

for n = 1:length(rewarded_poke_flex)
    rewarded_poke_flex{1,n} = rewarded_poke_flex{1,n}(~cellfun('isempty',rewarded_poke_flex{1,n}));
end

for n = 1:length(rewarded_poke_ot)
    rewarded_poke_ot{1,n} = rewarded_poke_ot{1,n}(~cellfun('isempty',rewarded_poke_ot{1,n}));
end

for n = 1:length(rewarded_poke_ot)
    for nn = 1:length(rewarded_poke_ot{1,n})
        duration_ot{1,n}(1,nn) = rewarded_poke_ot{1,n}{1,nn}(end)-rewarded_poke_ot{1,n}{1,nn}(1); 
    end
end

for n = 1:length(rewarded_poke_flex)
    for nn = 1:length(rewarded_poke_flex{1,n})
        duration_flex{1,n}(1,nn) = rewarded_poke_flex{1,n}{1,nn}(end)-rewarded_poke_flex{1,n}{1,nn}(1); 
    end
end

flexrangepre  = 393:440; %from dateflex %24 march to 9 april
flexrangepost = 441:507;%from dateot % 19 april to 14 may
otrangepre = 112:128;
otrangepost = 129:154;


duration_flex_pre = duration_flex(flexrangepre);
duration_flex_post = duration_flex(flexrangepost);
duration_ot_post = duration_ot(otrangepost);
duration_ot_pre = duration_ot(otrangepre);
for n = 1:length(duration_flex_pre)
mean_preflextimes(1,n) = mean(duration_flex_pre{1,n});
end

for n = 1:length(duration_flex_post)
mean_postflextimes(1,n) = mean(duration_flex_post{1,n});
end

for n = 1:length(duration_ot_pre)
mean_preottimes(1,n) = mean(duration_ot_pre{1,n});
end

for n = 1:length(duration_ot_post)
mean_postottimes(1,n) = mean(duration_ot_post{1,n});
end

flexpre = mean(mean_preflextimes);
flexpost = mean(mean_postflextimes);
otpre = mean(mean_preottimes);
otpost = mean(mean_postottimes);
htestot = ttest2(mean_preottimes,mean_postottimes);
htestflex = ttest2(mean_preflextimes,mean_postflextimes);

%significant 
%plot it, plot multiple bars together 
figure(4) %without wm 
trial_first_half = [flexpre, flexpost];
trial_second_half = [otpre, otpost];
bvals = [trial_first_half;trial_second_half];
xlength = 1:length(trial_first_half);
clr = [0.87 0.56 0.65; 0.4660 0.6740 0.1880];
clr2 = [1 0 0;0 0.5 0];
hold on 
barplot1 = bar(xlength,bvals,'facecolor','flat');
hold on 
barplot1(1,1).CData = clr;
barplot1(1,2).CData = clr2;
hold off
%plot avg accuracies in dmsl vs control
Xlabelval = {'Cued','OT'};
ax = gca
set(ax,'XTick',xlength,'XTickLabel',Xlabelval);
hold on 
ylabel('Trial time (ms)','FontSize',20,'FontWeight','bold')
xlabel('Condition','FontSize',20,'FontWeight','bold')
hold on 
ylim([0 max(max(bvals))+500]);
ax.XAxis.LineWidth = 5;
ax.YAxis.LineWidth = 5;
ax.XAxis.FontSize = 30;
ax.YAxis.FontSize = 30;
hold off 
%% for f3



%% %% %% %% %% %% %% do for full task animals!!!!!
%but with diff method
%thalamo-striatal 1st
% %animal 5 T6, 9april to 19 april
load('D:\Rats_in_Training\D6_output\Results-D6-Dahlia\ratBEHstruct.mat');
%first have to divide protocol 7 into cued and wm 
%protocol 8 is ot
%filter data from these protocols 

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
current_protocol{1,k} = ratBEHstruct(k).protocol;
end
current_protocol_mat = cell2mat(current_protocol);
%flexible sessions 

for k = 1:length(ratBEHstruct) 
combined_hits{1,k} = ratBEHstruct(k).Hit;
end
%find rewarded trials 
for k = 1:length(ratBEHstruct)
    rewards{1,k} = find(combined_hits{1,k} == 1);
end

%filter out all times  
for k =1:length(ratBEHstruct)
all_times{1,k} = ratBEHstruct(k).pokeTimes;
end

flex_sess = find(current_protocol_mat == 7);
ot_sess = find(current_protocol_mat == 8);

for s = 1:length(ratBEHstruct)
    blocklength(s) = max(ratBEHstruct(s).blocknum);
end

for s = 1:length(ratBEHstruct)
idx_cued{s} = find(ratBEHstruct(s).blocknumRepair<(blocklength(s)+1)/2);
end

%now divide into cued and wm 
idxcued_flex = idx_cued(flex_sess);
% idxwm_flex = idx_wm(flex_sess);
%ot sessions 
rewarded_ot = rewards(ot_sess);
rewarded_flex = rewards(flex_sess);
for n = 1:length(rewarded_flex)
rewarded_cueflex{1,n} = intersect(idxcued_flex{1,n},rewarded_flex{1,n});
end

for n = 1:length(ratBEHstruct)
dates{n} = ratBEHstruct(n).date;
end
dateflex = dates(flex_sess);
dateot =  dates(ot_sess);

%filter out all times  
for k =1:length(ratBEHstruct)
cue_times{1,k} = ratBEHstruct(k).cuedTimes;
end
times_ot= all_times(ot_sess);
times_flex= all_times(flex_sess);
cueflex = cue_times(flex_sess);
% 
% for n = 1:length(times_flex)
%     for nn = 1:length(idxcued_flex{1,n})
%         times_flex_cued{1,n}{1,nn} = times_flex{1,n}{1,idxcued_flex{1,n}(1,nn)};
%     end
% end

for n = 1:length(rewarded_ot)
rewarded_poke_ot{1,n} = times_ot{1,n}(rewarded_ot{1,n});
end

for n = 1:length(rewarded_flex)
rewarded_poke_flex{1,n} = times_flex{1,n}(rewarded_cueflex{1,n});
end

empty_ot = find(cellfun(@isempty,rewarded_poke_ot));
empty_flex = find(cellfun(@isempty,rewarded_poke_flex));
dateflex(empty_flex) = [];
dateot(empty_ot) = [];
rewarded_poke_flex(empty_flex) = [];
rewarded_poke_ot(empty_ot) = [];
times_flex(empty_flex) = [];
idxcued_flex(empty_flex)=[];

for n = 1:length(rewarded_poke_ot)
size_ot(1,n) = size(rewarded_poke_ot{1,n},2);
end

for n = 1:length(rewarded_poke_flex)
size_flex(1,n) = size(rewarded_poke_flex{1,n},2);
end

emptyot_2 = find(size_ot == 1);
emptyflex_2 = find(size_flex == 1);
%%%%further removal 
rewarded_poke_ot(emptyot_2) = [];
rewarded_poke_flex(emptyflex_2) = [];
dateflex(emptyflex_2) = [];
dateot(emptyot_2) = [];

for n = 1:length(rewarded_poke_flex)
    rewarded_poke_flex{1,n} = rewarded_poke_flex{1,n}(~cellfun('isempty',rewarded_poke_flex{1,n}));
end

for n = 1:length(rewarded_poke_ot)
    rewarded_poke_ot{1,n} = rewarded_poke_ot{1,n}(~cellfun('isempty',rewarded_poke_ot{1,n}));
end

for n = 1:length(rewarded_poke_ot)
    for nn = 1:length(rewarded_poke_ot{1,n})
        duration_ot{1,n}(1,nn) = rewarded_poke_ot{1,n}{1,nn}(end)-rewarded_poke_ot{1,n}{1,nn}(1); 
    end
end

for n = 1:length(rewarded_poke_flex)
    for nn = 1:length(rewarded_poke_flex{1,n})
        duration_flex{1,n}(1,nn) = rewarded_poke_flex{1,n}{1,nn}(end)-rewarded_poke_flex{1,n}{1,nn}(1); 
    end
end

flexrangepre  = 230:286; %from dateflex % jan 25 to 14 feb 
flexrangepost = 287:350;%from dateot % 22 feb to march15
otrangepre = 70:89;
otrangepost = 90:110;


duration_flex_pre = duration_flex(flexrangepre);
duration_flex_post = duration_flex(flexrangepost);
duration_ot_post = duration_ot(otrangepost);
duration_ot_pre = duration_ot(otrangepre);
for n = 1:length(duration_flex_pre)
mean_preflextimes(1,n) = mean(duration_flex_pre{1,n});
end

for n = 1:length(duration_flex_post)
mean_postflextimes(1,n) = mean(duration_flex_post{1,n});
end

for n = 1:length(duration_ot_pre)
mean_preottimes(1,n) = mean(duration_ot_pre{1,n});
end

for n = 1:length(duration_ot_post)
mean_postottimes(1,n) = mean(duration_ot_post{1,n});
end

flexpre = mean(mean_preflextimes);
flexpost = mean(mean_postflextimes);
otpre = mean(mean_preottimes);
otpost = mean(mean_postottimes);
htestot = ttest2(mean_preottimes,mean_postottimes);
htestflex = ttest2(mean_preflextimes,mean_postflextimes);

%significant 
%plot it, plot multiple bars together 
figure(4) %without wm 
trial_first_half = [flexpre, flexpost];
trial_second_half = [otpre, otpost];
bvals = [trial_first_half;trial_second_half];
xlength = 1:length(trial_first_half);
clr = [0.87 0.56 0.65; 0.4660 0.6740 0.1880];
clr2 = [1 0 0;0 0.5 0];
hold on 
barplot1 = bar(xlength,bvals,'facecolor','flat');
hold on 
barplot1(1,1).CData = clr;
barplot1(1,2).CData = clr2;
hold off
%plot avg accuracies in dmsl vs control
Xlabelval = {'Cued','OT'};
ax = gca
set(ax,'XTick',xlength,'XTickLabel',Xlabelval);
hold on 
ylabel('Trial time (ms)','FontSize',20,'FontWeight','bold')
xlabel('Condition','FontSize',20,'FontWeight','bold')
hold on 
ylim([0 max(max(bvals))+500]);
ax.XAxis.LineWidth = 5;
ax.YAxis.LineWidth = 5;
ax.XAxis.FontSize = 30;
ax.YAxis.FontSize = 30;
hold off 
%% for f3








