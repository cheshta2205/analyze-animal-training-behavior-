%get all BEH structs together (of allcontrols and dmsl)

doplot = 1;
skipvid = 1;

% addpath('D:\Kevin\Sequence_tap_analysis')
% addpath(genpath('D:\Kevin\Sequence_tap_analysis\Utilities'))
% addpath('D:\Kevin\Sequence_tap\Matlab')
% setup your matlab path
addpath('D:\Rats_in_Training\');
hdw = containers.Map;
hdw('GPIOpin')  = 21; % or 36 FOR ALL % 21/22 FOR OT ??
hdw('LeverL')   = 3;
hdw('LeverR')   = 11;
hdw('LeverC')   = 4;
hdw('LEDL')     = 28; %12 for e8; % 28 for d8
hdw('LEDR')     = 12; %28 for e8; % 12 for d8
hdw('LEDC')     = 27;
hdw('Speaker')  = 23;
hdw('Lick')     = 26;% 25 now for the new rats upstairs

boxarray = {'J7','J7-Jasmine',[3,11,4,28,12,27];...%dmsl
    'J7','J7-J7dms',[3,11,4,28,12,27];...%dmsl
  'J5','J5-Joy',[3,11,4,28,12,27];...%dmsl
    'D7','D7-Daisy',[3,11,4,28,12,27];...%dmsl
    'L3','L3-Lychee',[3,11,4,28,12,27];...%dmsl
    'D7','D7-Durga_dms',[3,11,4,28,12,27];...%dmsl
 'T8','T8-Truffle',[3,11,4,28,12,27];...
  'T7','T7-Tapasya',[3,11,4,28,12,27];...%dmsl
'D6','D6-Dahlia',[3,11,4,28,12,27];%dmsl
'F5','F5-Fall',[3,11,4,28,12,27];%dmsl
'J3','J3-Jelly',[3,11,4,28,12,27];%control
'D6','D6-Dahlia',[3,11,4,28,12,27];%control
'B1','B1-Bay',[3,11,4,28,12,27];%control
'F4','F4-Fig2',[3,11,4,28,12,27];%control
'T1','T1-Toy',[3,11,4,28,12,27];%control
'T5','T5-Tiffany_3.0',[3,11,4,28,12,27]};%control

protocol_use = 17;
vidpath = [];

% for ratid = 1:length(boxarray)
for ratid = 5
box = boxarray{ratid,1};
ratname = boxarray{ratid,2};
    
% parentpath = strcat('Z:\Kevin\Video\',box,'\Master');
% parentpath = strcat('Z:\Kevin\Video\',box,'\Master');
output_path = strcat('D:\Rats_in_Training\',box,'_output\Results-',ratname);
%output_path = strcat('D:\Rats_in_Training\DMSL_TP17');
%output_path = strcat('D:\Rats_in_Training\DMSL_TP17');

hdw = containers.Map;
hdw('GPIOpin')  = 22; % or 21
hdw('LeverL')   = boxarray{ratid,3}(1);
hdw('LeverR')   = boxarray{ratid,3}(2);
hdw('LeverC')   = boxarray{ratid,3}(3);
hdw('LEDL')     = boxarray{ratid,3}(4); %12 for e8; % 28 for d8
hdw('LEDR')     = boxarray{ratid,3}(5); %28 for e8; % 12 for d8
hdw('LEDC')     = boxarray{ratid,3}(6);
hdw('Speaker')  = 23;
hdw('Lick')     = 26;
if length(boxarray{ratid,3})>6
    hdw('Init') = boxarray{ratid,3}(7); % check
    if hdw('Init')==26; hdw('Lick')=26; end
end

%% get folders
files = dir(fullfile(output_path,'**','*.dat'));
filenames = {files.name};

ratBEHstruct = struct('name',ratname,...
    'date',[],...
    'session',[],...
    'startTime',[],...
    'Trials',[],...
    'TrialsBlock',[],...
    'VidStartTime',[],...
    'VidEndTime',[],...
    'pokeTimes',[],...
    'pokeNames',[],...
    'cuedTimes',[],...
    'cuedNames',[],...
    'targetNames',[],...
    'Hit',[],...
    'blocknum',[],...
    'wm',[],...
    'WMportstart',[],...
    'accuracy',[],...
    'accuracy2',[],...
    'accuracy_port21',[],...
    'accuracy_port31',[],...
    'accuracy_port32',[],...
    'HitLeverVals',[],...
    'flashLeverVal',[],...
    'vidfile',[],...
    'protocol',[],...
    'frames',[],...
    'vids',[]);
ratBEHstruct.extraPokes = [];
    ratBEHstruct.extraPokesNames = [];

if length(boxarray{ratid,3})>6
    
    ratBEHstruct.InitTimes = [];
end

%%

for protocol = protocol_use %7:8
for j = 1:length(filenames)
    disp(files(j).name);

filename = fullfile(files(j).folder,files(j).name);

% if strcmp(checkfile,filename); 
%     disp('here')
% end

%%
%* looks like only OT things are broken in getting pokenames...
%* target doesn't work since sequence is hard coded...

info = behstruct_tp17(filename,vidpath,protocol, hdw, ratname, skipvid);

%%
if isempty(fieldnames(info)); continue; end
for k = 1:length(info); info(k).protocol = protocol; end

ratBEHstruct = [ratBEHstruct, info];

% remove empty start time that is screwing up everything
if isempty(ratBEHstruct(1).startTime)
    ratBEHstruct(1) = [];
end

%combine structs and delete duplicates
all_startTimes = [ratBEHstruct(:).startTime];
[~,ia,~] = unique(all_startTimes);
ratBEHstruct = ratBEHstruct(ia);
all_startTimes = [ratBEHstruct(:).startTime];
[~,ia] = sort(all_startTimes);
ratBEHstruct = ratBEHstruct(ia);


end
end

%% repair blocknum
for s = 1:length(ratBEHstruct);
    if ratBEHstruct(s).protocol==8; continue; end
    
    blocknum = ratBEHstruct(s).blocknum;
    blockLength = max(blocknum);
    Hit = ratBEHstruct(s).Hit; 
    wm = ratBEHstruct(s).wm;
    
    if length(blocknum) < 5; continue; end
    
    % check if interleaved trial
    if any(diff(blocknum)==-1); continue; end;
    
%     for j = 1:length(blocknum)
%         if Hit(j); continue; end
%         if blocknum(j)==5 & (sum(wm{j})==0)
%             if blocknum(j-1) == 4 
%                 blocknum(j)=5; 
%             else
%                 blocknum(j)=0;
%             end % ok to be 5 if only 5
%             
%         elseif (blocknum(j) ~=5 & sum(wm{j})==0)
%             blocknum(j)=blocknum(j)+1;
%         end
%     end
    
    for j = 2:length(blocknum)
        if Hit(j); continue; end
        if blocknum(j)==blockLength & (sum(wm{j})==0)
            if blocknum(j-1) == blockLength-1 
                blocknum(j)=blockLength; 
            else
                blocknum(j)=0;
            end % ok to be 5 if only 5
            
        elseif (blocknum(j) ~=blockLength & sum(wm{j})==0)
            blocknum(j)=blocknum(j)+1;
        end
    end
    
    ratBEHstruct(s).blocknumRepair = blocknum;
    
end

%% repair blocknum for interleaved
%{
for s = 1:length(ratBEHstruct);
    if ratBEHstruct(s).protocol==8; continue; end
    
    blocknum = ratBEHstruct(s).blocknum;
    blockLength = max(blocknum);
    Hit = ratBEHstruct(s).Hit;
    wm = ratBEHstruct(s).wm;
    
    if length(blocknum) < 5; continue; end
    
    % check for interleaved
    if ~any(diff(blocknum)==-1); continue; end;
    
    for j = 2:length(blocknum)
        if Hit(j); continue; end
        if (sum(wm{j})>0); continue; end;
        
        
        
        if blocknum(j)==blockLength
            if blocknum(j-1) == blockLength-1 
                blocknum(j)=blockLength; 
            else
                blocknum(j)=0;
            end % ok to be 5 if only 5
            
        elseif (blocknum(j)==blocknum(j-1))
            if Hit(j-1)
                blocknum(j)=blocknum(j)+1;
            end
            
            %blocknum(j)=blocknum(j)-1;
        end
    end
    
    ratBEHstruct(s).blocknumRepair = blocknum;
    
end
%}
%% add targetseq for hard coded rats
% - this issue is because printing OT seq comes before hard coding
if strcmp(ratBEHstruct(1).name,'EphysE8-Rat46') % LCR for rat46
    for s = 1:length(ratBEHstruct)
        if ratBEHstruct(s).protocol==8
            ratBEHstruct(s).targetNames(:) = {'LCR'};
        end
    end
end

%% clean targets for blocknum=5
% - issue because new seq is generated before trial end signal
for s = 1:length(ratBEHstruct)
    if ratBEHstruct(s).protocol==7
        HitLever = cellfun(@(v,w) strcmp(v,w), ratBEHstruct(s).pokeNames, ratBEHstruct(s).targetNames);
        Hit = ratBEHstruct(s).Hit;
        HitLever_t1 = [0, cellfun(@(v,w) strcmp(v,w), ratBEHstruct(s).pokeNames(2:end), ratBEHstruct(s).targetNames(1:end-1))];
        % criterion: pokenames~=targetnames, pokenames==targetnames-1, hit==1
        id = find(xor(Hit,HitLever) & Hit & HitLever_t1);
        
        ratBEHstruct(s).targetNames(id) = ratBEHstruct(s).targetNames(id-1);
        blocklength = max(ratBEHstruct(s).blocknum);


        %%%%trying this for now 
% repair targetaNames
         % method 1?
          HitLever = cellfun(@(v,w) strcmp(v,w), ratBEHstruct(s).pokeNames, ratBEHstruct(s).targetNames);
          HitFix = ratBEHstruct(s).Hit;
          HitLever_t1 = [0, cellfun(@(v,w) strcmp(v,w), ratBEHstruct(s).pokeNames(2:end), ratBEHstruct(s).targetNames(1:end-1))];
          % criterion: pokenames~=targetnames, pokenames==targetnames-1, hit==1
          % - animal hit but target does not match up
          id = find(xor(HitFix,HitLever) & HitFix & HitLever_t1);
         % assert(all(ratBEHstruct(s).blocknumRepair(id)==blocklength))
          ratBEHstruct(s).targetNames(id) = ratBEHstruct(s).targetNames(id-1);
          % criterion: pokenames==targetnames, hit==0
          % - animal did not hit but targetnames are incorrect should be block==5?)
          id = find(~HitFix & HitLever); % missed, but target==hit
          id(ratBEHstruct(s).blocknumRepair(id) ~= blocklength) = []; % cheating
        %  assert(all(ratBEHstruct(s).blocknumRepair(id)==blocklength))
   %

          %%%%
    end
end


%% save

%save(strcat('D:\Kevin\Sequence_tap\',box,'_output\ratBEHstruct.mat'),'ratBEHstruct');

% try
% save(fullfile('D:\Kevin\Sequence_tap',[box '_output'],['Results-' ratname], 'ratBEHstruct.mat'),'ratBEHstruct');
% catch
% save(fullfile('F:\Kevin\Sequence_tap',[box '_output'],['Results-' ratname], 'ratBEHstruct.mat'),'ratBEHstruct');
% end
% try
% save(fullfile('D:\Rats_in_Training\',[box '_output'],['Results-' ratname], 'ratBEHstruct.mat'),'ratBEHstruct');
% catch
% save(fullfile('D:\Rats_in_Training\',[box '_output'],['Results-' ratname], 'ratBEHstruct.mat'),'ratBEHstruct');
% end
save(fullfile('D:\DMS_PROJECT\dmsl_cuetapstage\',['Results-' ratname], 'ratBEHstruct.mat'),'ratBEHstruct')

%% make plot

if doplot
dosave=0;
date7 = datetime; date8 = datetime; 
date7WM = datetime;
accCued = []; CIcued = [];
accWM = []; CIWM = [];
accOT = []; CIOT = [];
dateblock = datetime; dateinter = datetime;


accCuedTime = []; CIcuedTime = [];
accWMTime = []; CIWMTime = [];
accOTTime = []; CIOTTime = [];
IOTTime = [];

n = 3; % fraction of dataset to compare session fatigue

for s = 1:length(ratBEHstruct)
    if length(ratBEHstruct(s).Hit) < 15; continue; end
if ratBEHstruct(s).protocol==7
    
    blocklength = max(ratBEHstruct(s).blocknum);
    if ~any(diff(ratBEHstruct(s).blocknumRepair)==-1)
        idx = find(ratBEHstruct(s).blocknumRepair < (blocklength+1)/2);
        dateblock(end+1) = ratBEHstruct(s).startTime;
    else
        idx = find(~mod(ratBEHstruct(s).blocknumRepair,2));
        dateinter(end+1) = ratBEHstruct(s).startTime;
    end
%     if ~interleavedBool
%         idx = find(ratBEHstruct(s).blocknumRepair < 3);
%     else
%         idx = find(ratBEHstruct(s).blocknumRepair==0 | ratBEHstruct(s).blocknumRepair==2 | ratBEHstruct(s).blocknumRepair==4);
%     end
    accCued(end+1) = sum(ratBEHstruct(s).Hit(idx)) / length(idx);
    [phat, CIcued(end+1,:)] = binofit(sum(ratBEHstruct(s).Hit(idx)), length(idx));
    
    % track early vs. late
    cutoff = floor(length(idx) / n);
    %accCuedTime(end+1,1) = sum(ratBEHstruct(s).Hit(idx(1:cutoff))) / length(idx(1:cutoff));
    %accCuedTime(end,2) = sum(ratBEHstruct(s).Hit(idx((cutoff+1):end))) / length(idx((cutoff+1):end));
    
    [accCuedTime(end+1,1), CIcuedTime(end+1,:,1)] = binofit(sum(ratBEHstruct(s).Hit(idx(1:cutoff))), length(idx(1:cutoff)));
    [accCuedTime(end,2), CIcuedTime(end,:,2)] = binofit(sum(ratBEHstruct(s).Hit(idx((end-cutoff+1):end))), length(idx((end-cutoff+1):end)));

    
    if ~any(diff(ratBEHstruct(s).blocknumRepair)==-1)
        idx = find(ratBEHstruct(s).blocknumRepair >= (blocklength+1)/2);
    else
        idx = find(mod(ratBEHstruct(s).blocknumRepair,2));
    end
%     if ~interleavedBool
%         idx = find(ratBEHstruct(s).blocknumRepair >=3);
%     else
%         idx = find(ratBEHstruct(s).blocknumRepair==1 | ratBEHstruct(s).blocknumRepair==3 | ratBEHstruct(s).blocknumRepair==5);
%     end
    accWM(end+1) = sum(ratBEHstruct(s).Hit(idx)) / length(idx);
    [phat, CIWM(end+1,:)] = binofit(sum(ratBEHstruct(s).Hit(idx)), length(idx));
    
    cutoff = floor(length(idx) / n);
    %accWMTime(end+1,1) = sum(ratBEHstruct(s).Hit(idx(1:cutoff))) / length(idx(1:cutoff));
    %accWMTime(end,2) = sum(ratBEHstruct(s).Hit(idx((cutoff+1):end))) / length(idx((cutoff+1):end));
    [accWMTime(end+1,1), CIWMTime(end+1,:,1)] = binofit(sum(ratBEHstruct(s).Hit(idx(1:cutoff))), length(idx(1:cutoff)));
    [accWMTime(end,2), CIWMTime(end,:,2)] = binofit(sum(ratBEHstruct(s).Hit(idx((end-cutoff+1):end))), length(idx((end-cutoff+1):end)));

    
    date7(end+1) = ratBEHstruct(s).startTime;
    date7WM(end+1) = ratBEHstruct(s).startTime;
elseif ratBEHstruct(s).protocol==8
    accOT(end+1) = sum(ratBEHstruct(s).Hit) / length(ratBEHstruct(s).Hit);
    [phat, CIOT(end+1,:)] = binofit(sum(ratBEHstruct(s).Hit), length(ratBEHstruct(s).Hit));
%     accOTTime(end+1,1) = sum(ratBEHstruct(s).Hit(1:midl)) / length(1:midl);
%     accOTTime(end,2) = sum(ratBEHstruct(s).Hit(midu:end)) / length(ratBEHstruct(s).Hit(midu:end));
    cutoff = floor(length(ratBEHstruct(s).Hit)/n);
    [accOTTime(end+1,1), CIOTTime(end+1,:,1)] = binofit(sum(ratBEHstruct(s).Hit(1:cutoff)), length(ratBEHstruct(s).Hit(1:cutoff)));
    [accOTTime(end,2), CIOTTime(end,:,2)] = binofit(sum(ratBEHstruct(s).Hit((end-cutoff+1):end)), length(ratBEHstruct(s).Hit((end-cutoff+1):end)));
    
    date8(end+1) = ratBEHstruct(s).startTime; 
    
elseif ratBEHstruct(s).protocol==6
    accCued(end+1) = sum(ratBEHstruct(s).Hit) / length(ratBEHstruct(s).Hit);
    [phat,CIcued(end+1,:)] = binofit(sum(ratBEHstruct(s).Hit),length(ratBEHstruct(s).Hit));
    date7(end+1) = ratBEHstruct(s).startTime;
    
end
end
%%%%trying this for now 
% repair targetaNames
         % method 1?
          HitLever = cellfun(@(v,w) strcmp(v,w), ratBEHstruct(s).pokeNames, ratBEHstruct(s).targetNames);
          HitFix = ratBEHstruct(s).Hit;
          HitLever_t1 = [0, cellfun(@(v,w) strcmp(v,w), ratBEHstruct(s).pokeNames(2:end), ratBEHstruct(s).targetNames(1:end-1))];
          % criterion: pokenames~=targetnames, pokenames==targetnames-1, hit==1
          % - animal hit but target does not match up
          id = find(xor(HitFix,HitLever) & HitFix & HitLever_t1);
         % assert(all(ratBEHstruct(s).blocknumRepair(id)==blocklength))
          ratBEHstruct(s).targetNames(id) = ratBEHstruct(s).targetNames(id-1);
          % criterion: pokenames==targetnames, hit==0
          % - animal did not hit but targetnames are incorrect should be block==5?)
          id = find(~HitFix & HitLever); % missed, but target==hit
          id(id==1)=[];
          %id(ratBEHstruct(s).blocknumRepair(id)~=blocklength) = []; % cheating
        %  assert(all(ratBEHstruct(s).blocknumRepair(id)==blocklength))
          ratBEHstruct(s).targetNames(id) = ratBEHstruct(s).targetNames(id-1);

          %%%%
date7(1) = []; date8(1) = []; date7WM(1) =  [];
dateblock(1) = []; dateinter(1) = [];

% other figure style
h100=figure; hold on;
if ~isempty(accCued)
h1 = errorbar(datenum(date7),accCued,accCued' - CIcued(:,1),CIcued(:,2)-accCued',...
        'o','Color','r','CapSize',0,'LineWidth',.2,'MarkerFaceColor','r','MarkerSize',2);
end
if ~isempty(accWM)
h1 = errorbar(datenum(date7WM),accWM,accWM' - CIWM(:,1),CIWM(:,2)-accWM',...
        'o','Color','b','CapSize',0,'LineWidth',.2,'MarkerFaceColor','b','MarkerSize',2);
end
if ~isempty(accOT)
h1 = errorbar(datenum(date8),accOT,accOT' - CIOT(:,1),CIOT(:,2)-accOT',...
        'o','Color','g','CapSize',0,'LineWidth',.2,'MarkerFaceColor','g','MarkerSize',2);
end



legend({'Cued','WM','OT'})
if isempty(accWM); legend({'Cued','OT'}); end
if isempty(accCued); legend('OT'); end
datetick('x','dd mmm yyyy','keeplimits','keepticks'); ylabel('accuracy');
title(ratBEHstruct(1).name);

end
end
%then clear wrkspace 
%just run from here 
%%%find time of cues and then hits (so find RT)
%filter out rewarded trials
%% 

cd D:\DMS_PROJECT\dmsl_cuetapstage
dat_dms_lesion = {'Results-J7-Jasmine\ratBEHstruct.mat','Results-J5-Joy\ratBEHstruct.mat','Results-D7-Daisy\ratBEHstruct.mat','Results-T8-Truffle\ratBEHstruct.mat','Results-T7-Tapasya\ratBEHstruct.mat','Results-F5-Fall\ratBEHstruct.mat','Results-J3-Jelly\ratBEHstruct.mat','Results-D6-Dahlia\ratBEHstruct.mat','Results-B1-Bay\ratBEHstruct.mat','Results-T3-Tulip\ratBEHstruct.mat','Results-T1-Toy\ratBEHstruct.mat','Results-T5-Tiffany_3.0\ratBEHstruct.mat'};

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
rt{1,co}{1,n} = hit_final{1,co}{1,n}(1,1) - cue_final{1,co}{1,n}(end);
end 
end

for co = 1:length(dat_dms_lesion)
rtmat{1,co} = cell2mat(rt{1,co});
end

%remove negative values %error
for co = 1:length(dat_dms_lesion)
    remove{co} = find(rtmat{1,co}<0);
end
rt_idx = rtmat;
for co = 1:length(dat_dms_lesion)
rt_idx{1,co}(:,remove{1,co}) = [];
end
count_wt = 7:12;
count_dmsl = 1:6;
rt_wt = rt_idx(1,count_wt);
rt_dmsl = rt_idx(1,count_dmsl);
for n = 1:length(rt_wt)
rt_wt_mean{1,n} = movmean(rt_wt{1,n},400);
rt_dmsl_mean{1,n} = movmean(rt_dmsl{1,n},400);
end

figure(24)
for n = 1:length(count_wt)
    subplot(2,3,n)
plot(rt_wt_mean{1,n},'LineWidth',4)
h2 = gca;
% hold on 
% ylim([0 1])
% hold on 
% ylim([0 1])
hold on 
ylabel('Latency in control rats');
xlabel('Trials');
title('Cue-tap association stage');
h2.XAxis.LineWidth = 5;
h2.YAxis.LineWidth = 5;
h2.XAxis.FontSize = 15;
h2.YAxis.FontSize = 15;
hold off 
end


figure(25)
for n = 1:length(count_wt)
    subplot(2,3,n)
plot(rt_dmsl_mean{1,n},'LineWidth',4)
h2 = gca;
% hold on 
% ylim([0 1])
% hold on 
% ylim([0 1])
hold on 
ylabel('Latency in DMS lesion rats');
xlabel('Trials');
title('Cue-tap association stage');
h2.XAxis.LineWidth = 5;
h2.YAxis.LineWidth = 5;
h2.XAxis.FontSize = 15;
h2.YAxis.FontSize = 15;
hold off 
end



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

%can plot bars show0ing this or just
%lets avg in bins
%like make something like this https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3181000/

figure(1)
%to check how RT chnges with training... 
for n = 1:length(fulldmsfile)
        no_of_sessions{1,n} = length(fulldmsfile{1,n}.ratBEHstruct);
end

%try for 14 sessions?? 
%first filter out only 14 sessions 
sessions_we_need = 1:14;
sessions_count = length(sessions_we_need);
for co = 1:length(dat_dms_lesion)
    for k = 1:length(sessions_we_need)
    selected_cuedtimes{1,co}{1,k} = fulldmsfile{1,co}.ratBEHstruct(k).cuedTimes;
    selected_hittimes{1,co}{1,k} = fulldmsfile{1,co}.ratBEHstruct(k).pokeTimes;
    end
end

% %lets find latency
% for co = 1:length(selected_hittimes)
%     for k = 1:length(sessions_we_need)
%         for v  = 1:
%             hittimings{1,co}{1,k} = cellfun(@(v)v(1),selected_hittimes{1,co}{1,k});
%         end
%     end
% end
% 







%lets make a plot of how many ddays animals are on tp17 and compare dmsl vs
%control 
for co = 1:length(fulldmsfile)
for n = 1:length(fulldmsfile{1,co}.ratBEHstruct)
    data_rats_date{1,co}{1,n} = fulldmsfile{1,co}.ratBEHstruct(n).date;
    unique_dates{1,co} = unique(data_rats_date{1,co});
    dates_on17{1,co} = length(unique_dates{1,co}); 
end
end
dateson17 = cell2mat(dates_on17);
avg_days_dmsl = mean(dateson17(1:4));
avg_days_control = mean(dateson17(5:10));
%plot bar showing days difference
%do significance test as well
h = ttest2(dateson17(1:4),dateson17(5:10)); 
%h=1, so significant
%plot barsfigure(6)
%%plot as bar 
count_dmsl = 1:4;%because 1st 4 are dmsl std
count_wt = 5:10;%f
sd_dmsl = std((dateson17(count_dmsl))); %comes to be 19800
sd_wt = std((dateson17(count_wt))); %comes to be 1746
sem_wt = sd_wt./sqrt(length(count_wt));
sem_dmsl = sd_dmsl./sqrt(length(count_dmsl));

figure(3)
clr_lg = [0.4660, 0.6740, 0.1880];
clr_dg = [0, 0.5, 0];
xaxis_bar = [1,2];
condition = {'DMS lesion (n = 4)';'Control (n = 6)'};
yaxis_days = [avg_days_dmsl,avg_days_control];
ymax = max(yaxis_days);
hBar = bar(xaxis_bar,yaxis_days,'FaceColor','flat');
hold on  
hBar.CData(1,:) = clr_lg;
hBar.CData(2,:) = clr_dg;
hold on
errlow = [sem_dmsl,sem_wt];
errhigh = [sem_dmsl,sem_wt];
er = errorbar(xaxis_bar,yaxis_acc,errlow,errhigh,'k'); 
er.LineStyle = 'none';
axx = gca;
set(axx,'XTick',[1:2],'xticklabel',condition)
hold on
ylim([0 ymax+20]);
xlabel('Condition')
ylabel('Average number of days to learn cue-tap association')
hold on
axx.XAxis.LineWidth = 5;
axx.YAxis.LineWidth = 5;
axx.XAxis.FontSize = 15;
axx.YAxis.FontSize = 15;
hold off
%do significance test


%lets plot avg accuracy to see chance of success in cue tap associations 
%ok so lets plot fraction of correct trials 
%as a ratio of correct to total trials
%literally sum(hit)./length(Hit)
for co = 1:length(fulldmsfile)
for n = 1:length(fulldmsfile{1,co}.ratBEHstruct)
    data_rats_hits{1,co}{1,n} = fulldmsfile{1,co}.ratBEHstruct(n).Hit;
    hit_double{1,co} = cell2mat(data_rats_hits{1,co});
end
end
for co = 1:length(fulldmsfile)
    fraction_correct{1,co} = sum(hit_double{1,co})./length(hit_double{1,co});
end

fraction_hit_mat = cell2mat(fraction_correct);
mean_dms_fractionhit = mean(fraction_hit_mat(count_dmsl));
mean_wt_fractionhit = mean(fraction_hit_mat(count_wt));
h2 = ttest2(fraction_hit_mat(count_dmsl),fraction_hit_mat(count_wt)); %%h2==0,so not significnt
%lets plot 
sd_hit_dmsl = std(fraction_hit_mat(count_dmsl));
sd_hit_wt = std(fraction_hit_mat(count_wt));
sem_hit_dmsl = sd_hit_dmsl./sqrt(length(count_dmsl));
sem_hit_wt = sd_hit_wt./sqrt(length(count_wt));

figure(4)
xaxis_bar = [1,2];
condition = {'DMS lesion (n = 4)';'Control (n = 6)'};
yaxis_hits = [mean_dms_fractionhit,mean_wt_fractionhit];
hBar = bar(xaxis_bar,yaxis_hits,'b')
hold on 
ylim([0 1])
errlow = [sem_hit_dmsl,sem_hit_wt];
errhigh = [sem_hit_dmsl,sem_hit_wt];
er = errorbar(xaxis_bar,yaxis_hits,errlow,errhigh,'k'); 
er.LineStyle = 'none';
set(gca,'XTick',[1:2],'xticklabel',condition)
hold on
xlabel('Condition')
ylabel('Fraction of correct trials when learning cue-tap association')
hold on

