cd D:\DMS_PROJECT\dmsl_cuetapstage
%for all animals dmsl
dat_dms_lesion = {'Results-J7-Jasmine\ratBEHstruct.mat','Results-J5-Joy\ratBEHstruct.mat','Results-T8-Truffle\ratBEHstruct.mat','Results-F5-Fall\ratBEHstruct.mat'};

for co = 1:length(dat_dms_lesion)
fulldmsfile{co} = load(dat_dms_lesion{co});
end

for n = 1:length(fulldmsfile)
fulldmsfile{1,n}.ratBEHstruct(1:2)=[];
fulldmsfile{1,n}.ratBEHstruct(end)=[];
end

for k = 1:length(fulldmsfile)
for n = 1:length(fulldmsfile{1,k}.ratBEHstruct)
allpokes{1,k}{1,n} = fulldmsfile{1,k}.ratBEHstruct(n).pokeNames;
allhits{1,k}{1,n} = fulldmsfile{1,k}.ratBEHstruct(n).Hit;
end
end

for k = 1:length(fulldmsfile)
allpokes_together{1,k} = [allpokes{1,k}{:}];
allhits_together{1,k} = [allhits{1,k}{:}];
end 

for k = 1:length(fulldmsfile)
for n = 1:length(allpokes_together{1,k})
discardpoints{1,k}(1,n)=size(allpokes_together{1,k}{1,n},2);
end
end
totalpoke = allpokes_together;

for k = 1:length(fulldmsfile)
del_col{1,k} = find(discardpoints{1,k}==0);
totalpoke{1,k}(del_col{1,k})=[];
allhits_together{1,k}(del_col{1,k})=[];
rewarded_trial{1,k} = find(allhits_together{1,k}==1);
end

%rewarded_trial(1:6)=[];
for k = 1:length(fulldmsfile)
for n = 1:length(rewarded_trial{k})
    rewarded_poke{1,k}{1,n} = totalpoke{1,k}{1,rewarded_trial{1,k}(1,n)};
end
end

ncount = 3;
nadd = 1:ncount;

for k = 1:length(fulldmsfile)
rewtrialpost{1,k} = rewarded_trial{1,k}+ncount;
rewarded_trial{1,k}(end-ncount:end)=[];
rewarded_poke{1,k}(end-ncount:end)=[];
end

for k = 1:length(rewarded_trial)
    for n = 1:length(rewarded_trial{1,k})
    for nn = 1:length(nadd)
        postpokes{1,k}{1,n}{1,nn} = totalpoke{1,k}{1,rewarded_trial{1,k}(1,n)+nadd(1,nn)};
    end
    end
end
%postpokes has 3 taps post a rewarded tap 

for k = 1:length(fulldmsfile)
rew_L{1,k} = startsWith(rewarded_poke{1,k},'L');
rew_C{1,k} = startsWith(rewarded_poke{1,k},'C');
rew_R{1,k} = startsWith(rewarded_poke{1,k},'R');
end

for k = 1:length(fulldmsfile)
for n = 1:length(postpokes{1,k})
    afterpokesL{1,k}{1,n} =startsWith(postpokes{1,k}{1,n},'L');
    afterpokesC{1,k}{1,n} =startsWith(postpokes{1,k}{1,n},'C');
    afterpokesR{1,k}{1,n} =startsWith(postpokes{1,k}{1,n},'R');
end
end

for k = 1:length(fulldmsfile)
findL{1,k} = find(rew_L{1,k} ==1);
findC{1,k} = find(rew_C{1,k} ==1);
findR{1,k} = find(rew_R{1,k} ==1);
end

%now for findL filer afterpokesL and aSAME 
for k = 1:length(fulldmsfile)
LpostL{1,k} = afterpokesL{1,k}(findL{1,k});
CpostC{1,k} =  afterpokesC{1,k}(findC{1,k});
RpostR{1,k} = afterpokesR{1,k}(findR{1,k});
end

for k = 1:length(fulldmsfile)
for n = 1:length(LpostL{1,k})
meanLpostL{1,k}(1,n) = mean(LpostL{1,k}{1,n});
end
end

for k = 1:length(fulldmsfile)
for n = 1:length(CpostC{1,k})
meanCpostC{1,k}(1,n) = mean(CpostC{1,k}{1,n});
end
end

for k = 1:length(fulldmsfile)
for n = 1:length(RpostR{1,k})
meanRpostR{1,k}(1,n) = mean(RpostR{1,k}{1,n});
end
end

for k = 1:length(fulldmsfile)
ll{1,k} = movmean(meanLpostL{1,k},500);
cc{1,k} = movmean(meanCpostC{1,k},500);
rr{1,k} =  movmean(meanRpostR{1,k},500);
end 

figure(1)
for k = 1:length(fulldmsfile)
subplot(2,2,k)
 plot(ll{1,k},'-o','Color','r')
 hold on 
  plot(cc{1,k},'-o','Color','b')
 hold on 
  plot(rr{1,k},'-o','Color','g')
 hold on
 ylim([0 1])
 hold on
 yline(0.33,'--')
 hold on
 legend({'Left after Left','Center after center','Right after right'})
end

%% 

for k = 1:length(fulldmsfile)
l_tofilter{1,k} = min(length(ll{1,k}),length(cc{1,k}));
l_filter{1,k} = min(l_tofilter{1,k},length(rr{1,k}));
end

for k = 1:length(fulldmsfile)
llf{1,k} = meanLpostL{1,k}(1:l_filter{1,k});
ccf{1,k} = meanCpostC{1,k}(1:l_filter{1,k});
rrf{1,k} = meanRpostR{1,k}(1:l_filter{1,k});
allprob{1,k} = [llf{1,k}; ccf{1,k}; rrf{1,k}];
mean_prob_per{1,k} = mean(allprob{1,k},1);
movmean_prob_per{1,k} = movmean(mean_prob_per{1,k},500);
meanprobLL{1,k}=mean(llf{1,k});%0.3133
meanprobCC{1,k}=mean(ccf{1,k});%0.4839
meanprobRR{1,k}=mean(rrf{1,k});%0.355
end

for k = 1:length(fulldmsfile)
llfs{1,k} = movmean(llf{1,k},500);
ccfs{1,k} = movmean(ccf{1,k},500);
rrfs{1,k} =  movmean(rrf{1,k},500);
end 

figure(2)
for k = 1:length(fulldmsfile)
subplot(2,2,k)
 plot(llfs{1,k},'-o','Color','r')
 hold on 
  plot(ccfs{1,k},'-o','Color','b')
 hold on 
  plot(rrfs{1,k},'-o','Color','g')
 hold on
 ylim([0 1])
 hold on
yline(0.33,'--')
 hold on
 legend({'Left after Left','Center after center','Right after right'})
end

figure(3)
for k = 1:length(fulldmsfile)
subplot(2,2,k)
 plot(movmean_prob_per{1,k},'-o','Color','r')
 ylim([0 1])
 hold on
 title('Probability of pressing the same lever')
end

%do overall means and plot as bars 
%then for 3 bars for L,C,R 
%then these 3 bars for 1st half and later half 
for k = 1:length(fulldmsfile)
allmean_prob{1,k} = mean(mean_prob_per{1,k});
end

for k = 1:length(fulldmsfile)
llfirst{1,k} = llf{1,k}(1:length(llf{1,k})./2);
lllater{1,k} = llf{1,k}(length(llf{1,k})./2 +1:length(llf{1,k}));
ll1{1,k}=mean(llfirst{1,k});
ll2{1,k}=mean(lllater{1,k});
ccfirst{1,k}= ccf{1,k}(1:length(ccf{1,k})./2);
cclater{1,k}=ccf{1,k}(length(ccf{1,k})./2 +1:length(ccf{1,k}));
cc1{1,k}=mean(ccfirst{1,k});
cc2{1,k}=mean(cclater{1,k});
rrfirst{1,k}= rrf{1,k}(1:length(rrf{1,k})./2);
rrlater{1,k}=rrf{1,k}(length(rrf{1,k})./2 +1:length(rrf{1,k}));
rr1{1,k}=mean(rrfirst{1,k});
rr2{1,k}=mean(rrlater{1,k});
end

for k = 1:length(fulldmsfile)
half1{1,k} = [ll1{1,k};cc1{1,k};rr1{1,k}];
half2{1,k} = [ll2{1,k};cc2{1,k};rr2{1,k}];
mean1half{1,k} = mean(half1{1,k});
mean2half{1,k} = mean(half2{1,k});
end
%%%
mean_initial = mean(cell2mat(mean1half));
mean_final = mean(cell2mat(mean2half));
%plot mean_initial and mean_final 
%also plot for 3 levers separately

%make bars?? 

figure(4)
pre_post_avg_animalscues = [mean_initial, mean_final];
xlength = 1:2;
hold on 
barplot1 = bar(xlength,pre_post_avg_animalscues,'facecolor','flat');
hold on 
%plot avg accuracies in dmsl vs control
Xlabelval = {'First 50% trials','Last 50% trials'};
ax = gca
set(ax,'XTick',xlength,'XTickLabel',Xlabelval);
hold on 
ylabel('Chance of pressing the same lever again','FontSize',20,'FontWeight','bold')
xlabel('Condition','FontSize',20,'FontWeight','bold')
hold on 
ax.XAxis.LineWidth = 5;
ax.YAxis.LineWidth = 5;
ax.XAxis.FontSize = 30;
ax.YAxis.FontSize = 30;
hold off 

meanll_1 = mean(cell2mat(ll1));
meanll_2 = mean(cell2mat(ll2));
meancc_1 = mean(cell2mat(cc1));
meancc_2 = mean(cell2mat(cc2));
meanrr_1 = mean(cell2mat(rr1));
meanrr_2 = mean(cell2mat(rr2));
%for fig2 divide into bins and find avg? compare to controls 


%%try controls

