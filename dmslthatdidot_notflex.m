%dmsl who could do ot but not flexible.. 
%animal 1 : j5_joy for flexible and then j5_new (j5ot) for ot only 
%trained her on flex.. was quitting. 
%plot that 1st.. 
%behdetails_triple stage_dms lesion vs control 
%get all BEH structs together

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

boxarray = {'J5','J5-Joyot',[3,11,4,28,12,27];...%dmsl
    'T8','T8-Truffle_ot',[3,11,4,28,12,27]}; %dmsl 

protocol_use = 6;
vidpath = [];

for ratid = 1:length(boxarray)

box = boxarray{ratid,1};
ratname = boxarray{ratid,2};
    
% parentpath = strcat('Z:\Kevin\Video\',box,'\Master');
output_path = strcat('D:\Rats_in_Training\',box,'_output\Results-',ratname);
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
save(fullfile('D:\DMS_PROJECT\dmsl_ot_data\',['Results-' ratname], 'ratBEHstruct.mat'),'ratBEHstruct')
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

%% 

%then clear wosrkspace 
%just run from here 
%%%find time of cues and then hits (so find RT)
%filter out rewarded trials
cd D:\DMS_PROJECT\dmsl_ot_data
flex_ot_j5 = {'D:\DMS_PROJECT\dmsl_triplestagedata\Results-J5-Joy\ratBEHstruct.mat','D:\DMS_PROJECT\dmsl_ot_data\Results-J5-Joyot\ratBEHstruct.mat'};
flex_ot_t8 = {'D:\DMS_PROJECT\dmsl_triplestagedata\Results-T8-Truffle\ratBEHstruct.mat','D:\DMS_PROJECT\dmsl_ot_data\Results-T8-Truffle_ot\ratBEHstruct.mat'};
for co = 1:length(flex_ot_j5)
fulldmsfile_j5{co} = load(flex_ot_j5{co});
end

for co = 1:length(flex_ot_t8)
fulldmsfile_t8{co} = load(flex_ot_t8{co});
end
new_fulldmsfile_j5 = fulldmsfile_j5;
new_fulldmsfile_j5{1,1}.ratBEHstruct = new_fulldmsfile_j5{1,1}.ratBEHstruct(1:312);

for n = 1:length(new_fulldmsfile_j5{1,1}.ratBEHstruct)
hit_flex_j5{1,n} = new_fulldmsfile_j5{1,1}.ratBEHstruct(n).Hit;
end

for n = 1:length(new_fulldmsfile_j5{1,2}.ratBEHstruct)
hit_ot_j5{1,n} = new_fulldmsfile_j5{1,2}.ratBEHstruct(n).Hit;
end

for n = 1:length(fulldmsfile_t8{1,1}.ratBEHstruct)
hit_flex_t8{1,n} = fulldmsfile_t8{1,1}.ratBEHstruct(n).Hit;
end

for n = 1:length(fulldmsfile_t8{1,2}.ratBEHstruct)
hit_ot_t8{1,n} = fulldmsfile_t8{1,2}.ratBEHstruct(n).Hit;
end

for n = 1:length(hit_flex_j5)
mean_flex_j5{1,n} =  mean(hit_flex_j5{1,n});      
end

for n = 1:length(hit_ot_j5)
mean_ot_j5{1,n} =  mean(hit_ot_j5{1,n});      
end

for n = 1:length(hit_flex_t8)
mean_flex_t8{1,n} =  mean(hit_flex_t8{1,n});      
end

for n = 1:length(hit_ot_t8)
mean_ot_t8{1,n} =  mean(hit_ot_t8{1,n});      
end
meanflex_j5 = movmean(cell2mat(mean_flex_j5),50);
meanflex_t8 = movmean(cell2mat(mean_flex_t8),50);
meanot_t8 = cell2mat(mean_ot_t8);
meanot_t8(meanot_t8 == 0) = [];
ott8 = movmean(meanot_t8,20);
meanot_j5 = cell2mat(mean_ot_j5);
meanot_j5(meanot_j5 == 0) = [];
otj5 = movmean(meanot_j5,20);

%lets go
figure(21)
set(gcf,'position',[500 200 1000 600])
subplot(1,2,1)
plot(meanflex_j5,'LineWidth',4,'Color',[1 0 0])
%no 1st plot accuracy curves on 2 cohorts 
hold on 
ylim([0 1])
title('Cued sequences');
%plot(xlim,[.90,.90],'k--');
hold on
ylabel('Accuracy per session');
xlabel('Session no.');
hold on
subplot(1,2,2)
plot(otj5,'LineWidth',4,'Color',[0 1 0])
hold on 
ylim([0 1])
title('Overtrained sequence (Through trial and error)');
%xline(z_dms{1,i},'k--',z_dms{1,i});
hold on 
set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',15, ...
'FontWeight','Bold', 'LineWidth', 5);
ylabel('Accuracy per session');
xlabel('Session no.');
sgt = sgtitle('Rat J5 - Joy');
sgt.FontSize = 20;


%lets go
figure(22)
set(gcf,'position',[500 200 1000 600])
subplot(1,2,1)
plot(meanflex_t8,'-r','LineWidth',4)
%no 1st plot accuracy curves on 2 cohorts 
hold on 
ylim([0 1])
title('Cued sequences');
%plot(xlim,[.90,.90],'k--');
hold on
ylabel('Accuracy per session');
xlabel('Session no.');
hold on
subplot(1,2,2)
plot(ott8,'-g','LineWidth',4)
hold on 
ylim([0 1])
title('Overtrained sequence (Through trial and error)');
%xline(z_dms{1,i},'k--',z_dms{1,i});
hold on 
set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',15, ...
'FontWeight','Bold', 'LineWidth', 5);
ylabel('Accuracy per session');
xlabel('Session no.');
sgt = sgtitle('Rat T8 - Truffle');
sgt.FontSize = 20;

%lets plot for f5 fall now
%load..
load('D:\Rats_in_Training\F5_output\Results-F5-Fall\ratBEHstruct.mat');
for n = 1:length(ratBEHstruct)
    protocols(n) = ratBEHstruct(n).protocol;
end
protocol7 = find(protocols == 7);
protocol8 = find(protocols == 8);
for nn = 1:length(protocol7)
hit_7{nn} = ratBEHstruct(protocol7(1,nn)).Hit;
end
for nn = 1:length(protocol8)
hit_8{nn} = ratBEHstruct(protocol8(1,nn)).Hit;
end
%lets plot
for n = 1:length(hit_7)
hit7_mean{1,n} = mean(hit_7{1,n});
end

for n = 1:length(hit_8)
hit8_mean{1,n} = mean(hit_8{1,n});
end
hit8_mat = cell2mat(hit8_mean);
zerohit = find(hit8_mat == 0);
hit8_mat(hit8_mat == 0) = []; 
protocol8new = protocol8;
protocol8new(zerohit) = [];

hit7_mat = movmean(cell2mat(hit7_mean),25);
hit8_mat = movmean(hit8_mat,5);
maxlength = max(length(protocol7),length(protocol8));
totallength = length(protocol8)+length(protocol7);
M = nan(maxlength,2);
M(protocol7,1) = hit7_mat;
M(protocol8new,2) = hit8_mat;






