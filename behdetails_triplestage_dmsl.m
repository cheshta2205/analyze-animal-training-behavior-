%behdetails_triplestage_dmsl
%merge protocols 6 and 7
%i make beh structs using getBEHstruct3levers.m then just import here
%J5 - TP 6:7
%J7 : TP6
%D7: TP6:7
%T8: TP6


% dat_dms_lesion = {'D:\DMS_PROJECT\BEHstructs_dmslandcontrols\3leverstage\ratBEHstruct3_j7.mat','D:\DMS_PROJECT\BEHstructs_dmslandcontrols\3leverstage\ratBEHstruct3_j5.mat','D:\DMS_PROJECT\BEHstructs_dmslandcontrols\3leverstage\ratBEHstruct3_d7.mat','D:\DMS_PROJECT\BEHstructs_dmslandcontrols\3leverstage\ratBEHstruct3_t8.mat','D:\DMS_PROJECT\BEHstructs_dmslandcontrols\3leverstage\ratBEHstruct3_j3.mat','D:\DMS_PROJECT\BEHstructs_dmslandcontrols\3leverstage\ratBEHstruct3_t4.mat','D:\DMS_PROJECT\BEHstructs_dmslandcontrols\3leverstage\ratBEHstruct3_b1.mat','D:\DMS_PROJECT\BEHstructs_dmslandcontrols\3leverstage\ratBEHstruct3_t3.mat','D:\DMS_PROJECT\BEHstructs_dmslandcontrols\3leverstage\ratBEHstruct3_t1.mat','D:\DMS_PROJECT\BEHstructs_dmslandcontrols\3leverstage\ratBEHstruct3_t6.mat'};
dat_dms_lesion = {'D:\DMS_PROJECT\BEHstructs_dmslandcontrols\3leverstage\ratBEHstruct3_j7.mat','D:\DMS_PROJECT\BEHstructs_dmslandcontrols\3leverstage\ratBEHstruct3_j5.mat','D:\DMS_PROJECT\BEHstructs_dmslandcontrols\3leverstage\ratBEHstruct3_t8.mat','D:\DMS_PROJECT\BEHstructs_dmslandcontrols\3leverstage\ratBEHstruct3_j3.mat','D:\DMS_PROJECT\BEHstructs_dmslandcontrols\3leverstage\ratBEHstruct3_t4.mat','D:\DMS_PROJECT\BEHstructs_dmslandcontrols\3leverstage\ratBEHstruct3_b1.mat','D:\DMS_PROJECT\BEHstructs_dmslandcontrols\3leverstage\ratBEHstruct3_t3.mat','D:\DMS_PROJECT\BEHstructs_dmslandcontrols\3leverstage\ratBEHstruct3_t1.mat'};
count_dmsl = 1:5;
%count_wt = 5:10;
count_wt = 6:11;

for co = 1:length(dat_dms_lesion)
fulldmsfile{co} = load(dat_dms_lesion{co});
end

for  co = 1:length(dat_dms_lesion)
    for n = 1:length(fulldmsfile{1,co}.ratBEHstruct)
    hit_parts{1,co}{1,n} = fulldmsfile{1,co}.ratBEHstruct(n).Hit;
    cuedtimes{1,co}{1,n} = fulldmsfile{1,co}.ratBEHstruct(n).cuedTimes;
    hittimes{1,co}{1,n} = fulldmsfile{1,co}.ratBEHstruct(n).pokeTimes;
    end
end
%1st task 
% just plot accuracies vs session no./trials no. 
% find when avg accuracy>70%
%see if it is late in DMSL
%task2
%
%task3
%find trial time 
%see if dmsl rats get faster like controls or later? 
%TASK1
%plot accuracies
for co=1:length(dat_dms_lesion)
    for n = 1:length(fulldmsfile{1,co}.ratBEHstruct)
        combined_hits{1,co}{1,n} = fulldmsfile{1,co}.ratBEHstruct(n).Hit;
    end
end
for co = 1:length(dat_dms_lesion)
hits_mat{1,co} = cell2mat(combined_hits{1,co});
end

for co = 1:length(dat_dms_lesion)
mean_hits{1,co} = movmean(hits_mat{1,co},500);
fraction_correct_trials{1,co} = mean(hits_mat{1,co});
end
fraction_correct_mat = cell2mat(fraction_correct_trials);
%plot individually for rats and also avg 
avg_acc_dmsl_3 = mean(cell2mat(fraction_correct_trials(count_dmsl)));
avg_acc_wt_3 = mean(cell2mat(fraction_correct_trials(count_wt)));
htest = ttest2(fraction_correct_mat(count_wt),fraction_correct_mat(count_dmsl)); 
%1 so significat diff

figure(1)
clr_lg = [0.4660, 0.6740, 0.1880];
clr_dg = [0, 0.5, 0];
condition = {'DMS lesion (n = 4)';'Control (n = 6)'};
%plot avg accuracies in dmsl vs control
sd_dmsl3 = std(fraction_correct_mat(count_dmsl));
sd_wt3 = std(fraction_correct_mat(count_wt));
sem_dmsl_3 = sd_dmsl3./sqrt(length(count_dmsl));
sem_wt_3 = sd_wt3./sqrt(length(count_wt));
xaxis_bar = [1,2];
condition = {'DMS lesion (n = 4)';'Control (n = 6)'};
yaxis_acc = [avg_acc_dmsl_3;avg_acc_wt_3];
hBar = bar(xaxis_bar,yaxis_acc,'FaceColor','flat')
hold on 
hBar.CData(1,:) = clr_lg;
hBar.CData(2,:) = clr_dg;
hold on
errlow = [sem_dmsl_3,sem_wt_3];
errhigh = [sem_dmsl_3,sem_wt_3];
er = errorbar(xaxis_bar,yaxis_acc,errlow,errhigh,'k'); 
er.LineStyle = 'none';
axx = gca;
set(axx,'XTick',[1:2],'xticklabel',condition)
hold on 
ylabel('Average accuracies in cued 3 lever sequences','FontSize',20,'FontWeight','bold')
xlabel('Condition','FontSize',20,'FontWeight','bold')
hold on 
axx.XAxis.LineWidth = 5;
axx.YAxis.LineWidth = 5;
axx.XAxis.FontSize = 20;
axx.YAxis.FontSize = 20;
hold off 
%do significance test

yaxis_dmsl = mean_hits(count_dmsl);
yaxis_wt = mean_hits(count_wt);
xlimits = 1:1600;
figure (2)
%make accuracy plots
for n = 1:length(count_dmsl)
    subplot(2,2,n)
    plot(yaxis_dmsl{1,n}, 'LineWidth',4)
h1 = gca;
hold on 
ylim([0 1])
hold on 
ylabel('Accuracy in DMS lesioned rats');
xlabel('Trials');
title('3 Lever Cued stage');
h1.XAxis.LineWidth = 5;
h1.YAxis.LineWidth = 5;
h1.XAxis.FontSize = 15;
h1.YAxis.FontSize = 15;
hold off 
hold off
end

figure (3)
%make accuracy plots
for n = 1:length(count_wt)
    subplot(2,3,n)
plot(yaxis_wt{1,n},'LineWidth',4)
h2 = gca;
hold on 
ylim([0 1])
hold on 
ylim([0 1])
hold on 
ylabel('Accuracy in control rats');
xlabel('Trials');
title('3 Lever Cued stage');
h2.XAxis.LineWidth = 5;
h2.YAxis.LineWidth = 5;
h2.XAxis.FontSize = 15;
h2.YAxis.FontSize = 15;
hold off 
end

%PLOT ACCURACIES TOGETHER
figure(4)
plot(1,cell2mat(fraction_correct_trials(count_dmsl)),'o','MarkerEdgeColor','b','MarkerFaceColor',([0 0.7 0.7]),'MarkerSize',22);
hold on 
plot(2,cell2mat(fraction_correct_trials(count_wt)),'o','MarkerEdgeColor','r','MarkerFaceColor',([0.8500 0.3250 0.0980]),'MarkerSize',22);
hold off
big_val_y = max(cell2mat(fraction_correct_trials))
hold on 
xlim([0.5 2.5])
ylim([0 big_val_y+0.1]);
p1 = gca;
set(p1,'XTick',[1:2],'xticklabel',condition)
hold on
xlabel('Condition')
p1.XAxis.LineWidth = 5;
p1.YAxis.LineWidth = 5;
p1.XAxis.FontSize = 15;
p1.YAxis.FontSize = 15;
ylabel('Fraction of correct trials')
title('3 lever cued sequences');
hold off

figure(5)
for i = 1:length(mean_hits)
    long{i} = length(mean_hits{1,i});
end
%make some data for legends
hleg = gobjects(2,1);
hold on 
xsize =  min(cell2mat(long)); 
for ii = 1:length(yaxis_dmsl)
hleg(1) = plot(yaxis_dmsl{1,ii},'b','LineWidth',4)
end
legend('Control rats')
hold on 
for iii = 1:length(yaxis_wt)
hleg(2) = plot(yaxis_wt{1,iii},'r','LineWidth',4)
end
hold on 
legend('DMS lesion')
hold on 
ylim([0 1])
xlim([0 xsize])
hold on 
p2 = gca;
p2.XAxis.LineWidth = 5;
p2.YAxis.LineWidth = 5;
p2.XAxis.FontSize = 15;
p2.YAxis.FontSize = 15;
ylabel('Accuracy during 3 lever cued sequences');
xlabel('Trials');
legend(hleg,'DMS lesion','Control rats');
hold off

figure(6)
%can take mean accuracy every 100 trial and plot a dot
% val = 1:100;
% for co = 1:length(hits_mat)
% for n = 1:length(hits_mat{1,co})
% acc_every_11{1,co} = mean(hits_mat{1,co}(val));
% 
% end
% end

for  co = 1:length(dat_dms_lesion)
cuetime_mat{1,co} = cat(2,cuedtimes{1,co}{:});
hittime_mat{1,co} = cat(2,hittimes{1,co}{:});
hit_parts_mat{1,co} = cell2mat(hit_parts{1,co});
rewards{1,co} = find(hit_parts_mat{1,co} == 1);
cue_fltered{1,co} = cuetime_mat{1,co}(rewards{1,co});
hit_filtered{1,co} = hittime_mat{1,co}(rewards{1,co});
end


%%%%find when no cue
for  co = 1:length(dat_dms_lesion)
for nn = 1:length(hit_filtered{1,co})
    sizes_discard{1,co}{1,nn}= size(hit_filtered{1,co}{1,nn},1);
end
end

for  co = 1:length(dat_dms_lesion)
   remove{1,co} = find(cell2mat(sizes_discard{1,co})<3);
end

updated_time = hit_filtered;
for co = 1:length(dat_dms_lesion)
updated_time{1,co}(:,remove{1,co}) = [];
end

%find trial time 
for co = 1:length(updated_time)
    for g = 1:length(updated_time{1,co})
        trialtime{1,co}{1,g} = updated_time{1,co}{1,g}(3,1) - updated_time{1,co}{1,g}(1,1);
    end
end

%%plot trial times 
for co = 1:length(trialtime)
avg_trial_time{1,co} = mean(cell2mat(trialtime{1,co}));
end
%lets divide into first half trials and last half trials 

for co = 1:length(trialtime)
     sizenew{co} = length(trialtime{1,co});
end
%split trial times into 1st half [EARLY LEARNING] and LATE Learning [second half] 
for co = 1:length(trialtime)
     sizehalf{co} = 1:((sizenew{co})./2);
     sizesecondhalf{co} = round((sizenew{co})./2): sizenew{co};
end

for co = 1:length(trialtime)
trial_first_time{1,co} = mean(cell2mat(trialtime{1,co}(sizehalf{co})));
trial_second_time{1,co} = mean(cell2mat(trialtime{1,co}(sizesecondhalf{co})));
end
%lets plot how trial time changes for each animal
trial_first_half = cell2mat(trial_first_time);
trial_second_half = cell2mat(trial_second_time);

%then average
mean_trial_times_mat = cell2mat(avg_trial_time);
avg_time_dmsl = mean(mean_trial_times_mat(count_dmsl));
avg_time_control = mean(mean_trial_times_mat(count_wt));
sd_dmsl_time = std(mean_trial_times_mat(count_dmsl));
sd_wt_time = std(mean_trial_times_mat(count_wt));
sem_dmsl_time = sd_dmsl_time./sqrt(length(count_dmsl));
sem_wt_time = sd_wt_time./sqrt(length(count_wt));

figure(7)
%just avg and plot trial times  
clr_lg = [0.4660, 0.6740, 0.1880];
clr_dg = [0, 0.5, 0];
xaxis_bar = [1,2];
condition = {'DMS lesion (n = 4)';'Control (n = 6)'};
yaxis_time = [avg_time_dmsl;avg_time_control];
hBar = bar(xaxis_bar,yaxis_time,'facecolor','flat');
hold on
hBar.CData(1,:) = clr_lg;
hBar.CData(2,:) = clr_dg;
hold on


errlow = [sem_dmsl_time,sem_wt_time];
errhigh = [sem_dmsl_time,sem_wt_time];
er = errorbar(xaxis_bar,yaxis_time,errlow,errhigh,'k'); 
er.LineStyle = 'none';
axx = gca;
set(axx,'XTick',[1:2],'xticklabel',condition)
hold on 
ylabel('Trial time (ms)','FontSize',20,'FontWeight','bold')
xlabel('Condition','FontSize',20,'FontWeight','bold')
hold on 
axx.XAxis.LineWidth = 5;
axx.YAxis.LineWidth = 5;
axx.XAxis.FontSize = 20;
axx.YAxis.FontSize = 20;
hold off 
%do significance test
htime = ttest2(mean_trial_times_mat(count_dmsl),mean_trial_times_mat(count_wt)); %seems significant 

%now plot early and late stages 
%plot with different colors (light early and dark late)
figure(8)
bvals = [trial_first_half;trial_second_half];
xlength = 1:length(trial_first_half);
clr = [223 145 167; 223 145 167; 223 145 167; 223 145 167;134 156 211;134 156 211;134 156 211;134 156 211;134 156 211;134 156 211] / 255;
clr2 = [0.4 0 0.2;0.4 0 0.2;0.4 0 0.2;0.4 0 0.2;0 0 1;0 0 1;0 0 1;0 0 1;0 0 1;0 0 1];
hold on 
barplot1 = bar(xlength,bvals,'facecolor','flat');
hold on 
barplot1(1,1).CData = clr;
barplot1(1,2).CData = clr2;
hold off
Xlabelval = {'DMS LESION','DMS LESION','DMS LESION','DMS LESION','CONTROL','CONTROL','CONTROL','CONTROL','CONTROL','CONTROL'};
ax = gca
set(ax,'XTick',xlength,'XTickLabel',Xlabelval);
hold on 
ylabel('Trial time (ms)','FontSize',20,'FontWeight','bold')
xlabel('Condition','FontSize',20,'FontWeight','bold')
hold on 
ax.XAxis.LineWidth = 5;
ax.YAxis.LineWidth = 5;
ax.XAxis.FontSize = 20;
ax.YAxis.FontSize = 20;
hold off 

figure(9)
%take avg of trial tikes acorss animals
sd_t_early_dmsl = std(trial_first_half(count_dmsl));
sd_t_late_dmsl = std(trial_second_half(count_dmsl));
sd_t_early_wt = std(trial_first_half(count_wt));
sd_t_late_wt = std(trial_second_half(count_wt));
sem_dmsl_early = sd_t_early_dmsl./sqrt(length(count_dmsl))
sem_dmsl_late =  sd_t_late_dmsl./sqrt(length(count_dmsl))
sem_wt_early = sd_t_early_wt./sqrt(length(count_wt))
sem_wt_late = sd_t_late_wt./sqrt(length(count_wt))

avg_t_early_dmsl = mean(trial_first_half(count_dmsl));
avg_t_late_dmsl = mean(trial_second_half(count_dmsl));
avg_t_early_wt = mean(trial_first_half(count_wt));
avg_t_late_wt = mean(trial_second_half(count_wt));
early_mean = [avg_t_early_dmsl;avg_t_early_wt];
late_mean = [avg_t_late_dmsl;avg_t_late_wt];
combined_times = [early_mean, late_mean];
xlength2 = 1:2;
barplot2 = bar(xlength2,combined_times,'FaceColor','flat');
hold on 
clr3 = [223 145 167; 134 156 211] / 255;
clr4 = [0.4 0 0.2; 0 0 1];
hold on
barplot2(1,1).CData = clr3;
barplot2(1,2).CData = clr4;
hold on 
[ngroups,nbars] = size(combined_times);
gg = nan(nbars, ngroups);
for i = 1:nbars
gg(i,:) = barplot2(i).XEndPoints;
end
errlow = [sem_dmsl_early,sem_dmsl_late;sem_wt_early,sem_wt_late];
total_error = 2*errlow;
heb = errorbar(gg',combined_times,total_error,'k','linestyle','none');
hold off
% er = errorbar(xlength2,combined_times,errlow,errhigh,'k'); 
% er.LineStyle = 'none';
ylim([0 max(max(combined_times))+2000])
hold off
Xlabelval = {'DMS LESION','CONTROL'};
ax1 = gca
set(ax1,'XTick',xlength2,'XTickLabel',Xlabelval);
hold on 
ylabel('Trial time (ms)','FontSize',20,'FontWeight','bold')
xlabel('Condition','FontSize',20,'FontWeight','bold')
hold on 
ax1.XAxis.LineWidth = 5;
ax1.YAxis.LineWidth = 5;
ax1.XAxis.FontSize = 20;
ax1.YAxis.FontSize = 20;
hold off 

%do sign test
hdmsl = ttest2(trial_first_half(count_dmsl),trial_second_half(count_dmsl));
hwt = ttest2(trial_second_half(count_wt),trial_second_half(count_wt));



%%%%find when no cue
for  co = 1:length(dat_dms_lesion)
for nn = 1:length(cue_fltered{1,co})
    sizes_discard{1,co}{1,nn}= size(cue_fltered{1,co}{1,nn},1);
end
end


for co = 1:length(dat_dms_lesion)
size_mat{1,co} = cell2mat(sizes_discard{1,co});
trash_size{1,co} = find(size_mat{1,co}==0); 
new_rewards{1,co} = rewards{1,co};
new_rewards{1,co}(:,trash_size{1,co}) = [];
cue_updated{1,co} = cuetime_mat{1,co};
cue_final{1,co} = cue_updated{1,co}(new_rewards{1,co});
hit_updated{1,co} = hittime_mat{1,co};
hit_final{1,co} = hit_updated{1,co}(new_rewards{1,co});
end

for co = 1:length(dat_dms_lesion)
for n = 1:length(hit_final{1,co})
rt{1,co}{1,n} = hit_final{1,co}{1,n}(1,1) - cue_final{1,co}{1,n}(1,1);
end 
end

for co = 1:length(dat_dms_lesion)
rtmat{1,co} = cell2mat(rt{1,co});
end
%remove negative values %error

rt_idx = rtmat;

for n = 1:length(rt_idx)
sizes{1,n} = length(rt_idx{1,n});
end
min_size = min(cell2mat(sizes));
%lets bin things in bins of 100trials over min size
%lets filter all till min size
for n = 1:length(rtmat)
    filter_rtidx{1,n} = rt_idx{1,n}(1:min_size);
end
x_plot = 1:min_size;

for n = 1:length(rtmat)
    figure(n)
    plot(x_plot,filter_rtidx{1,n},'o')
end
%this will tell us the latency for trials that animal does in 17


%lets take a blind average over all times
for co = 1:length(dat_dms_lesion)
rtmat_avgstep1{1,co} = mean(rt_idx{1,co});
end 
avg_rt_dmsl = mean(cell2mat(rtmat_avgstep1(1:4)));
avg_rt_control = mean(cell2mat(rtmat_avgstep1(5:10)));

%can plot bars showing this or just
%lets avg in bins
%like make something like this https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3181000/

% figure(1)
% %to check how RT chnges with training... 
% for n = 1:length(fulldmsfile)
%         no_of_sessions{1,n} = length(fulldmsfile{1,n}.ratBEHstruct);
% end
% 
% %try for 14 sessions?? 
% %first filter out only 14 sessions 
% sessions_we_need = 1:14;
% sessions_count = length(sessions_we_need);
% for co = 1:length(dat_dms_lesion)
%     for k = 1:length(sessions_we_need)
%     selected_cuedtimes{1,co}{1,k} = fulldmsfile{1,co}.ratBEHstruct(k).cuedTimes;
%     selected_hittimes{1,co}{1,k} = fulldmsfile{1,co}.ratBEHstruct(k).pokeTimes;
%     end
% end
% 
% 
% 
% 
% 
% 
% 
% 
% 
% %lets make a plot of how many ddays animals are on tp17 and compare dmsl vs
% %control 
% for co = 1:length(fulldmsfile)
% for n = 1:length(fulldmsfile{1,co}.ratBEHstruct)
%     data_rats_date{1,co}{1,n} = fulldmsfile{1,co}.ratBEHstruct(n).date;
%     unique_dates{1,co} = unique(data_rats_date{1,co});
%     dates_on17{1,co} = length(unique_dates{1,co}); 
% end
% end
% dateson17 = cell2mat(dates_on17);
% avg_days_dmsl = mean(dateson17(1:4));
% avg_days_control = mean(dateson17(5:10));
% %plot bar showing days difference
% %do significance test as well
% h = ttest2(dateson17(1:4),dateson17(5:10)); 
% %h=1, so significant
% %plot barsfigure(6)
% %%plot as bar 
% count_dmsl = 1:4;%because 1st 4 are dmsl std
% count_wt = 5:10;%f
% sd_dmsl = std((dateson17(count_dmsl))); %comes to be 19800
% sd_wt = std((dateson17(count_wt))); %comes to be 1746
% sem_wt = sd_wt./sqrt(length(count_wt));
% sem_dmsl = sd_dmsl./sqrt(length(count_dmsl));
% 
% figure(3)
% xaxis_bar = [1,2];
% condition = {'DMS lesion (n = 4)';'Control (n = 6)'};
% yaxis_acc = [avg_days_dmsl,avg_days_control];
% hBar = bar(xaxis_bar,yaxis_acc,'b')
% hold on 
% errlow = [sem_dmsl,sem_wt];
% errhigh = [sem_dmsl,sem_wt];
% er = errorbar(xaxis_bar,yaxis_acc,errlow,errhigh,'k'); 
% er.LineStyle = 'none';
% set(gca,'XTick',[1:2],'xticklabel',condition)
% hold on
% xlabel('Condition')
% ylabel('Average number of days to learn cue-tap association')
% hold on
% %do significance test
% 
% 
% %lets plot avg accuracy to see chance of success in cue tap associations 
% %ok so lets plot fraction of correct trials 
% %as a ratio of correct to total trials
% %literally sum(hit)./length(Hit)
% for co = 1:length(fulldmsfile)
% for n = 1:length(fulldmsfile{1,co}.ratBEHstruct)
%     data_rats_hits{1,co}{1,n} = fulldmsfile{1,co}.ratBEHstruct(n).Hit;
%     hit_double{1,co} = cell2mat(data_rats_hits{1,co});
% end
% end
% for co = 1:length(fulldmsfile)
%     fraction_correct{1,co} = sum(hit_double{1,co})./length(hit_double{1,co});
% end
% 
% fraction_hit_mat = cell2mat(fraction_correct);
% mean_dms_fractionhit = mean(fraction_hit_mat(count_dmsl));
% mean_wt_fractionhit = mean(fraction_hit_mat(count_wt));
% h2 = ttest2(fraction_hit_mat(count_dmsl),fraction_hit_mat(count_wt)); %%h2==0,so not significnt
% %lets plot 
% sd_hit_dmsl = std(fraction_hit_mat(count_dmsl));
% sd_hit_wt = std(fraction_hit_mat(count_wt));
% sem_hit_dmsl = sd_hit_dmsl./sqrt(length(count_dmsl));
% sem_hit_wt = sd_hit_wt./sqrt(length(count_wt));
% 
% figure(4)
% xaxis_bar = [1,2];
% condition = {'DMS lesion (n = 4)';'Control (n = 6)'};
% yaxis_hits = [mean_dms_fractionhit,mean_wt_fractionhit];
% hBar = bar(xaxis_bar,yaxis_hits,'b')
% hold on 
% ylim([0 1])
% errlow = [sem_hit_dmsl,sem_hit_wt];
% errhigh = [sem_hit_dmsl,sem_hit_wt];
% er = errorbar(xaxis_bar,yaxis_hits,errlow,errhigh,'k'); 
% er.LineStyle = 'none';
% set(gca,'XTick',[1:2],'xticklabel',condition)
% hold on
% xlabel('Condition')
% ylabel('Fraction of correct trials when learning cue-tap association')
% hold on
% 
