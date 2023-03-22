%quantify error modes
%find ratio of CRC to total 3 lever sequences executed
% lcl_note = find(contains(ratBEHstruct(1049).pokeNames(:),'LCL')); %CORRECT SEQ
% crc_note = find(contains(ratBEHstruct(1049).pokeNames(:),'CRC')); %CAN BE DIR ERROR 
% crl_note = find(contains(ratBEHstruct(1049).pokeNames(:),'CRL'));
% cr_note = find(contains(ratBEHstruct(1049).pokeNames(:),'CR')); %CAN BE DIR ERROR 
% r_note = find(contains(ratBEHstruct(1049).pokeNames(:),'R'));
% clc_note = find(contains(ratBEHstruct(1049).pokeNames(:),'CLC'));
% cl_note = find(contains(ratBEHstruct(1049).pokeNames(:),'CL'));
%combine pokes and extra pokes alternatively. 
%presilencing = 1:1080

for g = 1:length(ratBEHstruct)
    dim(g) = size((ratBEHstruct(g).pokeNames),2);
end
exclude = find(dim == 1);
newstruct = ratBEHstruct;
newstruct(:,exclude) = [];
%hardcode surgery dates
%divide presilencing into before ot and after ot
%before ot = 1st 100 sessions, till 2021-03-10 == newstruct's 1:73
%after ot = 101-780 sessions, 2021-3-11 to 2021-08-27 == 74:592
%after surgery = from 11/16/21 to now, == 593:938
%before ot 

%find flex sessions 
for a = 1:73
    total_preot{a} = newstruct(a).pokeNames(:);
    extra_preot{a} = newstruct(a).extraPokesNames(:);
    %joint_preot{a} = [total_preot{a} extra_preot{a}]';
    %jointpokes_preot{a} = joint_preot{a}(:);
    jointpokes_preot{a} = total_preot{a};
    CRC_begin_preot{a} = startsWith(jointpokes_preot{1,a},'CRC'); %find all that start with CRC
    cut_CRC_preot{a} = find(CRC_begin_preot{1,a} == 0);
    LCL_begin_preot{a} = startsWith(jointpokes_preot{1,a},'LCL'); %find all that start with LCL
    cut_LCL_preot{a} = find(LCL_begin_preot{1,a} == 0);
    CLC_begin_preot{a} = startsWith(jointpokes_preot{1,a},'CLC'); %find all that start with CLC
    cut_CLC_preot{a} = find(CLC_begin_preot{1,a} == 0);
    fail_preot{a} = find(newstruct(a).Hit == 0);
    no_fail_preot(a) = length(fail_preot{a});
end
fail_preot = sum(no_fail_preot); 

final_CRC_preot = jointpokes_preot;
final_LCL_preot = jointpokes_preot;
final_CLC_preot = jointpokes_preot;

for k = 1:73
    final_CRC_preot{1,k}(cut_CRC_preot{1,k},:) = [];
    final_LCL_preot{1,k}(cut_LCL_preot{1,k},:) = [];
    final_CLC_preot{1,k}(cut_CLC_preot{1,k},:) = [];
end
%find total no. of errros in first 73 sessions now. Using HIT of 
%find number of times this happens per session.. here 780 are no. of
%sessions 
for l = 1:length(final_CRC_preot)
no_CRC_preot(l) = length(final_CRC_preot{1,l});
no_LCL_preot(l) = length(final_LCL_preot{1,l});
no_CLC_preot(l) = length(final_CLC_preot{1,l});
end
%find fractions
ot_range = 74:592;
post_sur_range = 593:938;
%post OT, before surgery 
 for aa = 1:length(ot_range)
     for p = ot_range(aa)
    total_ot{aa} = newstruct(p).pokeNames(:);
    extra_ot{aa} = newstruct(p).extraPokesNames(:);
    joint_ot{aa} = [total_ot{aa} extra_ot{aa}]';
    jointpokes_ot{aa} = joint_ot{aa}(:);
    CRC_begin_ot{aa} = startsWith(jointpokes_ot{1,aa},'CRC'); %find all that start with CRC
    cut_CRC_ot{aa} = find(CRC_begin_ot{1,aa} == 0);
    LCL_begin_ot{aa} = startsWith(jointpokes_ot{1,aa},'LCL'); %find all that start with LCL
    cut_LCL_ot{aa} = find(LCL_begin_ot{1,aa} == 0);
    CLC_begin_ot{aa} = startsWith(jointpokes_ot{1,aa},'CLC'); %find all that start with CLC
    cut_CLC_ot{aa} = find(CLC_begin_ot{1,aa} == 0);
     end
 end
final_CRC_ot = jointpokes_ot;
final_LCL_ot = jointpokes_ot;
final_CLC_ot = jointpokes_ot;

for k = 1:length(ot_range)
%for k = 74:592
    final_CRC_ot{1,k}(cut_CRC_ot{1,k},:) = [];
    final_LCL_ot{1,k}(cut_LCL_ot{1,k},:) = [];
    final_CLC_ot{1,k}(cut_CLC_ot{1,k},:) = [];
end

%find number of times this happens per session.. here 780 are no. of
%sessions 
for l = 1:length(final_CRC_ot)
no_CRC_ot(l) = length(final_CRC_ot{1,l});
no_LCL_ot(l) = length(final_LCL_ot{1,l});
no_CLC_ot(l) = length(final_CLC_ot{1,l});
end

%after surgery 
 for aaa = 1:length(post_sur_range)
     for pp = post_sur_range(aaa)
    total_postsur{aaa} = newstruct(pp).pokeNames(:);
    extra_postsur{aaa} = newstruct(pp).extraPokesNames(:);
    joint_postsur{aaa} = [total_postsur{aaa} extra_postsur{aaa}]';
    jointpokes_postsur{aaa} = joint_postsur{aaa}(:);
    CRC_begin_postsur{aaa} = startsWith(jointpokes_postsur{1,aaa},'CRC'); %find all that start with CRC
    cut_CRC_postsur{aaa} = find(CRC_begin_postsur{1,aaa} == 0);
    LCL_begin_postsur{aaa} = startsWith(jointpokes_postsur{1,aaa},'LCL'); %find all that start with LCL
    cut_LCL_postsur{aaa} = find(LCL_begin_postsur{1,aaa} == 0);
    CLC_begin_postsur{aaa} = startsWith(jointpokes_postsur{1,aaa},'CLC'); %find all that start with LCL
    cut_CLC_postsur{aaa} = find(CLC_begin_postsur{1,aaa} == 0);
     end
 end
final_CRC_postsur = jointpokes_postsur;
final_LCL_postsur = jointpokes_postsur;
final_CLC_postsur = jointpokes_postsur;

for kk = 1:length(post_sur_range)
    final_CRC_postsur{1,kk}(cut_CRC_postsur{1,kk},:) = [];
    final_LCL_postsur{1,kk}(cut_LCL_postsur{1,kk},:) = [];
    final_CLC_postsur{1,kk}(cut_CLC_postsur{1,kk},:) = [];
end

%find number of times this happens per session.. here 780 are no. of sessions 
for l = 1:length(final_CRC_postsur)
no_CRC_postsur(l) = length(final_CRC_postsur{1,l});
no_LCL_postsur(l) = length(final_LCL_postsur{1,l});
no_CLC_postsur(l) = length(final_CLC_postsur{1,l});
end
mean_CRC_preot = mean(no_CRC_preot);
mean_CRC_ot = mean(no_CRC_ot);
mean_CRC_postsur = mean(no_CRC_postsur);
mean_LCL_preot = mean(no_LCL_preot);
mean_LCL_ot = mean(no_LCL_ot);
mean_LCL_postsur = mean(no_LCL_postsur);
mean_CLC_preot = mean(no_CLC_preot);
mean_CLC_ot = mean(no_CLC_ot);
mean_CLC_postsur = mean(no_CLC_postsur);

mean_comb_CRC = [mean_CRC_preot;mean_CRC_ot;mean_CRC_postsur];
mean_comb_LCL = [mean_LCL_preot;mean_LCL_ot;mean_CRC_postsur];
mean_comb_CLC = [mean_CLC_preot;mean_CLC_ot;mean_CRC_postsur];

figure(1)
subplot(1,3,1)

ymax = max([max(mean_comb_LCL) max(mean_comb_CRC) max(mean_comb_CLC)]);
ymin = min([min(mean_comb_LCL) min(mean_comb_CRC) min(mean_comb_CLC)]);

plot(1:length(mean_comb_LCL),mean_comb_LCL,'g-','LineWidth',4.5)
title('For OT only animal E8, OT sequence = LCL');
ylabel('mean number of LCL executed'); 
names = {'Before overtraining';'Overtrained';'Post thalamostriatal silencing'}
set(gca, 'xtick',[1:3],'xticklabel',names)
hold on
ylim([ymin ymax])
hold off 

subplot(1,3,2)
plot(1:length(mean_comb_CRC),mean_comb_CRC,'g-','LineWidth',4.5)
title('For OT only animal E8, OT sequence = LCL');
ylabel('mean number of CRC executed'); 
names = {'Before overtraining';'Overtrained';'Post thalamostriatal silencing'}
set(gca, 'xtick',[1:3],'xticklabel',names)
hold on
ylim([ymin ymax])
hold off 

subplot(1,3,3)
plot(1:length(mean_comb_CLC),mean_comb_CLC,'g-','LineWidth',4.5)
title('For OT only animal E8, OT sequence = LCL');
ylabel('mean number of CLC executed'); 
names = {'Before overtraining';'Overtrained';'Post thalamostriatal silencing'}
set(gca, 'xtick',[1:3],'xticklabel',names)
hold on
ylim([ymin ymax])
hold off 
