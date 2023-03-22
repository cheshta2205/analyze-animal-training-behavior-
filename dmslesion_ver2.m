%%%loading rats tgether

%DMS lesion
%load all dms lesion rats
boxpath = 'D:\Rats_in_Training';
boxes = {'F1_output','F2_output','F3_output','F4_output','F5_output','F6_output','F7_output','F8_output'};

%hardcoded things 
%b = [7;5;7;8;7;5;3;6;1;3;1;5;6;2]; %1st 4 are DMS lesions, last 6 are control WT rats 
b = [7;5;8;5;7;3;7;3;6;1;4;1;5];
protocol = 17 %protocol which you wanna check in - %the protocol in which you want to
% specifically check accuray of lever taps. 
% rack = ['J';'J';'D';'T';'T';'F';'J';'D';'B';'T';'T';'T';'T';'T']; %1st 6 are DMS lesions, last 8 are control WT rats 
rack = ['J';'J';'T';'F';'J';'L';'D';'J';'D';'B';'F';'T';'T']; %1st 6 are DMS lesions, last 8 are control WT rats 
id = [2;1;1;1;1;2;3;1;1;1;2;2;3];
Hit = cell(1,numel(rack));
Hit2 = cell(1,numel(rack));
Hit3 = cell(1,numel(rack));
Hit_block = cell(1,numel(rack));
AllTime = {datetime};
%Hit = [];
for g = 1:length(rack)
boxname{g} = [rack(g) boxes{b(g)}(2:end)];
end
% * if multiple rats, take only most recent
for g = 1:length(boxname)
d{g} = dir(fullfile(boxpath, boxname{g}));
isub{g} = [d{g}(:).isdir]; %# returns logical vector
nameFolds{g} = {d{g}(isub{g}).name}';
dateFolds{g} = {d{g}(isub{g}).datenum}';
dateFolds{g}(ismember(nameFolds{g},{'.','..'})) = [];
nameFolds{g}(ismember(nameFolds{g},{'.','..'})) = [];
%[val{g},Hit{g}] = max({dateFolds{1,g}});
%[val(g),id(g)] = max(cell2mat(dateFolds{1,g}));
% id(g) = 1;
ratname{g} = nameFolds{g}{id(g)};
end

for k = 1:length(rack)
files{1,k} = dir(fullfile(boxpath,boxname{k},ratname{k},'**','*.dat')); %%shows files of today
filenames{1,k} = {files{1,k}.name}; %%get files of all dates [since you started training animal]
end
count = 1;
% accuracy = [];
% accuracy2 = []; accuracy3 = [];
% accuracy_block = []; Trials_block = []; Hit_block = {};
% accuracy_port3 = []; accuracy_port2 = []; % conditional accuracy
% Trials_cued = []; Trials_wm = [];
Hit_cued = cell(1,numel(rack));
Hit_wm = cell(1,numel(rack));
Hit_interleaved = cell(1,numel(rack)); 
Hit_cond = cell(1,numel(rack)); 
% accuracy_cued = []; accuracy_wm = [];
% Trials = []; Trials2 = []; Trials3 = [];
% %Time = datetime;
% AllTime = datetime;
% Hit = []; Hit2 = []; Hit3 = [];
% fpt = []; spt = [];
% seqLen = [];

for k = 1:length(rack)
for idx = 1:length(filenames{k})

%% Read output file
% Initialize variables.
filename{1,k} = fullfile(files{1,k}(idx).folder,files{1,k}(idx).name);
delimiter = ',';
startRow = 4; % header occupies 3 lines'

% Format string for each line of text:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%f%f%f%f%[^\n\r]';
%if idx==14; continue; end

% Open the text file.
fileID{k} = fopen(filename{1,k},'r');

% Read columns of data according to format string.
%DATA ARRAY reads filename of each date and tells which column in fiename
%is what

try
    dataArray{k} = textscan(fileID{k}, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
catch
    continue;
end

% Close the text file
fclose(fileID{k});
%

EventType{1,k} =    dataArray{1,k}{:, 1};
Value{1,k} =     dataArray{1,k}{:, 2}; %0 = no tap, 1 = taps once, 2 = taps 2 levers, 3 = taps 3 levers
CurrentProtocol{1,k} = dataArray{1,k}{:,3};
CurrentState{1,k} = dataArray{1,k}{:, 4};
SessTime{1,k} =     dataArray{1,k}{:, 5};
ExptTime{1,k} =     dataArray{1,k}{:, 6};
DailyWater{1,k} =   dataArray{1,k}{:, 7};
WeeklyWater{1,k} =  dataArray{1,k}{:, 8};


%% get accuracy for loaded session

%you have specified protocol above - the protocol in which you want to
%specifically want to check accuracy of lever taps. 
%ask Kevin meaning of 61/62..? what do other Value{1,k}s mean? 

sessStartInd{1,k}= find(EventType{1,k} == 61 & CurrentProtocol{1,k} == protocol); % cued poke
sessStopInd{1,k} = find(EventType{1,k} == 62 & CurrentProtocol{1,k} == protocol);

% fix inconsistent lengths (toss trial) - just to make sure there are equal
% numbers of session starts and ends 

if length(sessStartInd{1,k}) > length(sessStopInd{1,k})
    sessStopInd{1,k}(end+1) = length(EventType{1,k});
elseif length(sessStartInd{1,k}) < length(sessStopInd{1,k})
    sessStopInd{1,k}(1) = [];
end

% need to do in for loop...
%[firstPokeTimes, secondPokeTimes] = getIPITimes(filename, protocol, ports, lights, tone,water,lick);
%fpt = cat(2,fpt,firstPokeTimes);
%spt = cat(2,spt,secondPokeTimes);
for s = 1 : length(sessStartInd{1,k})
    sessEventInds{1,k} = ExptTime{1,k} >= ExptTime{1,k}(sessStartInd{1,k}(s)) & ExptTime{1,k} <= ExptTime{1,k}(sessStopInd{1,k}(s));
    numTrials{1,k} = SessTime{1,k}(sessEventInds{1,k} & EventType{1,k} == 90 & Value{1,k} == 1); %this is number of trials where it taps once (even without cue)
    % seems 90 = trials, 91 = cued, so when rat shouldve tapped the lever, 51 = when rat gets water 
    numSuccess{1,k} = SessTime{k}(sessEventInds{k} & EventType{k} == 91 & Value{1,k} == 1); %includes all: single, double, triple tap  
    numMiss{1,k} = SessTime{1,k}(sessEventInds{1,k} & EventType{1,k} == 91 & Value{1,k} == 0);
    waterTimes{1,k} = SessTime{1,k}(sessEventInds{1,k} & EventType{1,k} == 51 );
    
    if length(Value{1,k}(sessEventInds{1,k} & EventType{1,k} == 89) == 1)
        seqLen{1,k}(count) = Value{1,k}(sessEventInds{1,k} & EventType{1,k} == 89);
    end
    
    numSuccessDouble{1,k} = SessTime{1,k}(sessEventInds{1,k} & EventType{1,k} == 91 & Value{1,k} == 2); %91, so cued. if press twice (Value{1,k} == 2), then success double 
    numSuccessTriple{1,k} = SessTime{1,k}(sessEventInds{1,k} & EventType{1,k} == 91 & Value{1,k} == 3);%91, so cued. if press thrice (Value{1,k} == 3), then success triple  

    % get accuracy
    accuracy{1,k}(count) = length(numSuccess{1,k}) / ((length(numSuccess{1,k}) + length(numMiss{1,k})));
    Trials{1,k}(count) = length(numSuccess{1,k}) + length(numMiss{1,k});
    accuracy2{1,k}(count) = length(numSuccessDouble{1,k}) / (length(numSuccess{1,k})+length(numMiss{1,k}));
    accuracy3{1,k}(count) = length(numSuccessTriple{1,k}) / (length(numSuccess{1,k})+length(numMiss{1,k}));
    Trials2{1,k}(count) = length(numSuccessDouble{1,k}) + length(numMiss{1,k});
    Trials3{1,k}(count) = length(numSuccessTriple{1,k}) + length(numMiss{1,k});
    
    % get times
    unix_epoch = datenum(1970,1,1,0,0,0);
    MSDNTime{1,k} = ExptTime{1,k}(sessStartInd{1,k}(s));
    matlab_time{1,k} = MSDNTime{1,k}./86400 + unix_epoch; 
    Time{1,k}(count) = datetime(matlab_time{1,k},'ConvertFrom','datenum');
    %works till this point 
   %%%%converting doubles to cells 
   
    % get Hits
    Hitvec{1,k} = [ones(1,length(numSuccess{1,k})), zeros(1,length(numMiss{1,k}))];
    [~,idx] = sort([numSuccess{1,k}; numMiss{1,k}]);
    Hit{1,k} = cat(1,Hit{1,k},Hitvec{1,k}(idx)');

    % get Hits for multi?
    Hitvec{1,k} = [ones(1,length(numSuccessDouble{1,k})), zeros(1,length(numMiss{1,k}))]; %hits for two taps 
    [~,idx] = sort([numSuccessDouble{1,k}; numMiss{1,k}]);
    Hit2{1,k} = cat(1,Hit2{1,k},Hitvec{1,k}(idx)');
    Hitvec{1,k} = [ones(1,length(numSuccessTriple{1,k})), zeros(1,length(numMiss{1,k}))];  %hits for three taps 
    [~,idx] = sort([numSuccessTriple{1,k}; numMiss{1,k}]);
    Hit3{1,k} = cat(1,Hit3{1,k},Hitvec{1,k}(idx)');
    
    % if block trial, get blocked accuracy...
    blockEventIdxs{1,k} = find(EventType{1,k} == 95);
    blocklength{1,k} = length(unique(Value{1,k}(blockEventIdxs{1,k})));
    if isempty(Hit_block{1,k}); Hit_block{1,k} = cell(blocklength{1,k},1); end
    if size(Hit_block{1,k},1) < blocklength{1,k}; Hit_block{1,k}{blocklength{1,k}} = []; end
    for block = 1:blocklength{1,k}
        % find when got water and what block thing was
        % * this is only true if blocks never reset! always increment
        %* yeah this definitely doesn't work...
%         blockEventInds = zeros(length(sessEventInds),1);
%         for j = block:blocklength:(length(blockEventIdxs)-1)
%             blockEventInds(blockEventIdxs(j):blockEventIdxs(j+1)) = 1;
%         end
        
        blockEventInds{1,k} = zeros(length(sessEventInds{1,k}),1);
        idn{1,k} = find(Value{1,k}(blockEventIdxs{1,k})==block-1); % -1 since index from 0
        if idn{1,k}(end)==length(blockEventIdxs{1,k}); idn{1,k}(end) = []; end
        for j = 1:length(idn{1,k})
            blockEventInds{1,k}(blockEventIdxs{1,k}(idn{1,k}(j)):blockEventIdxs{1,k}(idn{1,k}(j)+1)) = 1;
        end
        
        numSuccess{1,k} = SessTime{1,k}(sessEventInds{1,k} & blockEventInds{1,k} & EventType{1,k} == 91 & Value{1,k} == 1);
        numSuccessDouble{1,k} = SessTime{1,k}(sessEventInds{1,k} & blockEventInds{1,k} & EventType{1,k} == 91 & Value{1,k} == 2);
        numSuccessTriple{1,k} = SessTime{1,k}(sessEventInds{1,k} & blockEventInds{1,k} & EventType{1,k} == 91 & Value{1,k} == 3);
        numMiss{1,k} = SessTime{1,k}(sessEventInds{1,k} & blockEventInds{1,k} & EventType{1,k} == 91 & Value{1,k} == 0);
        waterTimes{1,k}   = SessTime{1,k}(sessEventInds{1,k} & blockEventInds{1,k} & EventType{1,k} == 51 & Value{1,k} == 1 );
        accuracy_block{1,k}(block,count) = length(numSuccessTriple{1,k}) / (length(numSuccess{1,k}) + length(numMiss{1,k}));
        %accuracy(block,s) = length(waterTimes) / (length(numSuccess) + length(numMiss));
        Trials_block{1,k}(block,count) = length(numSuccessTriple{1,k}) + length(numMiss{1,k});
        
        Hitvec{1,k} = [ones(1,length(numSuccessTriple{1,k})), zeros(1,length(numMiss{1,k}))];
        [~,idx] = sort([numSuccessTriple{1,k}; numMiss{1,k}]);
        Hit_block{1,k}{block} = cat(1,Hit_block{1,k}{block},Hitvec{1,k}(idx)');
        
        % get conditional accuracy
        accuracy_port3{1,k}(block,count) = length(numSuccessTriple{1,k}) / length(numSuccessDouble{1,k});
        accuracy_port2{1,k}(block,count) = length(numSuccessDouble{1,k}) / length(numSuccess{1,k});
        
    end
    
    % get Hits for contexts
    if ~isempty(blockEventIdxs{1,k})
    blockEventInds{1,k} = zeros(length(sessEventInds{1,k}),1);
    idn{1,k} = find(Value{1,k}(blockEventIdxs{1,k})==0); % -1 since index from 0
    idn{1,k} = union(idn{1,k}, find(Value{1,k}(blockEventIdxs{1,k})==1));
    idn{1,k} = union(idn{1,k}, find(Value{1,k}(blockEventIdxs{1,k})==2));
    if idn{1,k}(end)==length(blockEventIdxs{1,k}); idn{1,k}(end) = []; end
    for j = 1:length(idn{1,k})
        blockEventInds{1,k}(blockEventIdxs{1,k}(idn{1,k}(j)):blockEventIdxs{1,k}(idn{1,k}(j)+1)) = 1;
    end
    numSuccess{1,k} = SessTime{1,k}(sessEventInds{1,k} & blockEventInds{1,k} & EventType{1,k} == 91 & Value{1,k} == 1);
    numSuccessDouble{1,k} = SessTime{1,k}(sessEventInds{1,k} & blockEventInds{1,k} & EventType{1,k} == 91 & Value{1,k} == 2);
    numSuccessTriple{1,k} = SessTime{1,k}(sessEventInds{1,k} & blockEventInds{1,k} & EventType{1,k} == 91 & Value{1,k} == 3);
    numMiss{1,k} = SessTime{1,k}(sessEventInds{1,k} & blockEventInds{1,k} & EventType{1,k} == 91 & Value{1,k} == 0);
    waterTimes{1,k}   = SessTime{1,k}(sessEventInds{1,k} & blockEventInds{1,k} & EventType{1,k} == 51 & Value{1,k} == 1 );
    accuracy_cued{1,k}(count) = length(numSuccessTriple{1,k}) / (length(numSuccess{1,k}) + length(numMiss{1,k}));
    numSuccessTripleCued{1,k} = numSuccessTriple{1,k};
    numMissCued{1,k} = numMiss{1,k};

    Hitvec{1,k} = [ones(1,length(numSuccessTriple{1,k})), zeros(1,length(numMiss{1,k}))];
    [~,idx] = sort([numSuccessTriple{1,k}; numMiss{1,k}]);
    Hit_cued{1,k} = cat(1,Hit_cued{1,k},Hitvec{1,k}(idx)');
    
    Trials_cued{1,k}(count) = length(numSuccessTriple{1,k}) + length(numMiss{1,k});
    
    blockEventInds{1,k} = zeros(length(sessEventInds{1,k}),1);
    idn{1,k} = find(Value{1,k}(blockEventIdxs{1,k})==3); % -1 since index from 0
    idn{1,k} = union(idn{1,k}, find(Value{1,k}(blockEventIdxs{1,k})==4));
    idn{1,k} = union(idn{1,k}, find(Value{1,k}(blockEventIdxs{1,k})==5));
    if ~isempty(idn{1,k}); if idn{1,k}(end)==length(blockEventIdxs{1,k}); idn{1,k}(end) = []; end; end
    for j = 1:length(idn{1,k})
        blockEventInds{1,k}(blockEventIdxs{1,k}(idn{1,k}(j)):blockEventIdxs{1,k}(idn{1,k}(j)+1)) = 1;
    end
    numSuccess{1,k} = SessTime{1,k}(sessEventInds{1,k} & blockEventInds{1,k} & EventType{1,k} == 91 & Value{1,k} == 1);
    numSuccessDouble{1,k} = SessTime{1,k}(sessEventInds{1,k} & blockEventInds{1,k} & EventType{1,k} == 91 & Value{1,k} == 2);
    numSuccessTriple{1,k} = SessTime{1,k}(sessEventInds{1,k} & blockEventInds{1,k} & EventType{1,k} == 91 & Value{1,k} == 3);
    numMiss{1,k} = SessTime{1,k}(sessEventInds{1,k} & blockEventInds{1,k} & EventType{1,k} == 91 & Value{1,k} == 0);
    waterTimes{1,k}   = SessTime{1,k}(sessEventInds{1,k} & blockEventInds{1,k} & EventType{1,k} == 51 & Value{1,k} == 1 );
    accuracy_wm{1,k}(count) = length(numSuccessTriple{1,k}) / (length(numSuccess{1,k}) + length(numMiss{1,k}));
    numSuccessTripleWM{1,k} = numSuccessTriple{1,k};
    numMissWM{1,k} = numMiss{1,k};

    Hitvec{1,k} = [ones(1,length(numSuccessTriple{1,k})), zeros(1,length(numMiss{1,k}))];
    [~,idx] = sort([numSuccessTriple{1,k}; numMiss{1,k}]);
    Hit_wm{1,k} = cat(1,Hit_wm{1,k},Hitvec{1,k}(idx)');
    
    Trials_wm{1,k}(count) = length(numSuccessTriple{1,k}) + length(numMiss{1,k});
    
    
    Hitvec{1,k} = [ones(1,length(numSuccessTripleCued{1,k})), zeros(1,length(numMissCued{1,k})),...
    ones(1,length(numSuccessTripleWM{1,k})), zeros(1,length(numMissWM{1,k}))];
    Hitcondvec{1,k} = [zeros(1,length(numSuccessTripleCued{1,k})+length(numMissCued{1,k})),...
    ones(1,length(numSuccessTripleWM{1,k})+length(numMissWM{1,k}))];
    [~,idx] = sort([numSuccessTripleCued{1,k}; numMissCued{1,k}; numSuccessTripleWM{1,k}; numMissWM{1,k}]);
    Hit_interleaved{1,k} = cat(1,Hit_interleaved{1,k},Hitvec{1,k}(idx)');
    Hit_cond{1,k} = cat(1,Hit_cond{1,k}, Hitcondvec{1,k}(idx)');
    end 
    count = count+1;
    end
end
end
%% 

% %% check timing issue
% for kk = 1:length(rack)
% unix_epoch = datenum(1970,1,1,0,0,0);
% MSDNTime{1,kk} = ExptTime{1,kk}(intersect(find(EventType{1,kk}==97),find(Value{1,kk}==97)));
% matlab_time{1,kk}  = MSDNTime{1,kk}./86400 + unix_epoch; 
% t{1,kk} = datetime(matlab_time{1,kk},'ConvertFrom','datenum');
% AllTime{1,kk} = cat(1,AllTime,t{1,kk});
% end
%exception for j3jelly

dat = load('D:\DMS_PROJECT\dmsl_cuetapstage\Results-J3-Jelly\ratBEHstruct.mat');
for k = 1:length(dat.ratBEHstruct)
        hitj3{1,k} = dat.ratBEHstruct(k).Hit;
end
hitsj3 = cell2mat(hitj3);

Hit{1,9} = hitsj3;
for kk = 1:length(rack)
yaxis1{1,kk} = movmean(Hit{1,kk},550);
yaxis2{1,kk} = movmean(Hit{1,kk},100);
end
for kk = 1:length(rack)
z1{1,kk} = find(yaxis2{1,kk}>0.90);
z2{1,kk} = z1{1,kk}(1,1);
end
%% 

%plot trial no. as dots - make 2 plots
%one showing total no. of trials in this protocol and the other showing when
%it crosses 85%
%lets go

cd D:\DMS_PROJECT\dmsl_cuetapstage
dat_dms_lesion = {'Results-j7-jasmine-woretraining\ratBEHstruct.mat','Results-J5-Joy\ratBEHstruct.mat','Results-T8-Truffle\ratBEHstruct.mat','Results-L3-Lychee\ratBEHstruct.mat','Results-J3-Jelly\ratBEHstruct.mat','Results-D6-Dahlia\ratBEHstruct.mat','Results-B1-Bay\ratBEHstruct.mat','Results-F4-Fig2\ratBEHstruct.mat','Results-T1-Toy\ratBEHstruct.mat','Results-T5-Tiffany_3.0\ratBEHstruct.mat'};
%say crietrion is to cross x% in trials o
% cd W:\Lab\dms_lesion\dls_lesion
% dat_dls_lesion = {'Results-D8-Rat90\ratBEHstruct.mat','Results-E4-Rat92\ratBEHstruct.mat','Results-E5-Rat91\ratBEHstruct.mat','Results-J2-Rat93\ratBEHstruct.mat','Results-J6-Rat94\ratBEHstruct.mat'};

condition = {'DMS lesion (n = 4)';'Control (n = 6)'};
condition_dls = {'DLS lesion (n = 5)'};
count_dmsl = 1:4;%because 1st 4 are dmsl std
count_wt = 5:10;%following 6 are controls 
count_dls = 1:5;

addpath D:\DMS_PROJECT\dmsl_cuetapstage

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

for k = 1:length(hit_parts)
for kk = 1:length(hit_parts{1,k})
hit_mean{1,k}(1,kk)  = mean(hit_parts{1,k}{1,kk});
trial_count{1,k}(1,kk) = length(hit_parts{1,k}{1,kk});
end
end

for k = 1:length(hit_parts)
allhits{1,k} = cell2mat(hit_parts{1,k});
end

yaxis_dms = allhits(count_dmsl);
yaxis_wt = allhits(count_wt);

for i = 1:length(yaxis_dms)
yaxis_dmshit{1,i} = movmean(yaxis_dms{1,i},550);
end
for i = 1:length(yaxis_wt)
yaxis_wthit{1,i} = movmean(yaxis_wt{1,i},550);
end

%for together plot 
for i = 1:length(yaxis_dms)
yaxis_dmsmov{1,i} = movmean(yaxis_dms{1,i},650);
end
for i = 1:length(yaxis_wt)
yaxis_wthit{1,i} = movmean(yaxis_wt{1,i},550);
end


figure(1)
plot(1,cell2mat(z2(count_dmsl)),'o','MarkerEdgeColor','b','MarkerFaceColor',([0 0.7 0.7]),'MarkerSize',22);
hold on 
plot(2,cell2mat(z2(count_wt)),'o','MarkerEdgeColor','r','MarkerFaceColor',([0.8500 0.3250 0.0980]),'MarkerSize',22);
hold off
hold on 
xlim([0.5 2.5])
hold on 
p2 = gca;
p2.XAxis.LineWidth = 5;
p2.YAxis.LineWidth = 5;
p2.XAxis.FontSize = 15;
p2.YAxis.FontSize = 15;
ylabel('Accuracy during 3 lever cued sequences');
xlabel('Trials');
legend('DMS lesion','Control rats');
hold off
set(p2,'XTick',[1:2],'xticklabel',condition)
hold on
xlabel('Condition')
ylabel('Number of Trials')
title('Learning cue-tap association');

yaxis_dms = yaxis1(count_dmsl);
yaxis_dms{1,6}(1:200,:) = yaxis2{1,6}(1:200,:);
yaxis_wt = yaxis1(count_wt);
% z_dms = z2(count_dmsl);
% z_wt = z2(count_wt);
%% 

%plot accuracy curves averaged accross animals of each cohort 
%no 1st plot accuracy curves on 2 cohorts 
for i = 1:length(yflexible_persess_wt)
y3{1,i} = cell2mat(yflexible_persess_wt{1,i});
end
for i = 1:length(yflexible_persess_wt)
y4{1,i} = movmean(y3{1,i},20);
y4_1{1,i} = movmean(y3{1,i},8);
end

figure(2)
for i = 1:length(yaxis_dmshit)
    subplot(2,3,i)
plot(yaxis_dmshit{1,i},'LineWidth',4)
hold on 
ylim([0 1])
hold on 
yline([0.85],'k--');
plot(xlim,[0.85,0.85],'k--');
hold on 
% xline(z_dms{1,i},'k--',z_dms{1,i});
ylabel('Accuracy');
xlabel('Trials');
title('Cue-tap association stage for DMS lesion animals');
p2 = gca;
p2.XAxis.LineWidth = 5;
p2.YAxis.LineWidth = 5;
p2.XAxis.FontSize = 15;
p2.YAxis.FontSize = 15;
end


%%
figure(3)
for i = 1:length(yaxis_dmshit)
    subplot(2,2,i)
ff{1,i} = yaxis_dmshit{1,i};
fx{1,i} = 1:length(ff{1,i});
[param] = sigm_fit(fx{1,i},ff{1,i});%plots sigmcurve 
hold on 
ylim([0 1])
ylabel('Accuracy');
xlabel('Trial no.');
title('Cue-tap association stage for DMS-Lesion animals (n=4)');
p2 = gca;
p2.XAxis.LineWidth = 5;
p2.YAxis.LineWidth = 5;
p2.XAxis.FontSize = 15;
p2.YAxis.FontSize = 15;
end
%%
figure(4)
%plot accuracy curves averaged accross animals of each cohort 
%no 1st plot accuracy curves on 2 cohorts 
for i = 1:length(yaxis_wthit)
    subplot(2,3,i)
plot(yaxis_wthit{1,i},'LineWidth',4)
hold on 
ylim([0 1])
yline(0.85,'k--');
hold on 
ylabel('Accuracy');
xlabel('Trials');
title('Cue-tap association stage for control animals');
hold on
p2 = gca;
p2.XAxis.LineWidth = 5;
p2.YAxis.LineWidth = 5;
p2.XAxis.FontSize = 15;
p2.YAxis.FontSize = 15;
hold off
end

%wanna quantify time 
for k = 1:length(yaxis_dmshit)
count_dmstrials(1,k) = size(yaxis_dmshit{1,k},2);
end

%wanna quantify time 
for k = 1:length(yaxis_wthit)
count_controlstrials(1,k) = size(yaxis_wthit{1,k},2);
end
meancount_dms = mean(count_dmstrials);
meancount_control = mean(count_controlstrials);

cd W:\Lab\dms_lesion\dls_lesion
dat_dls_lesion = {'Results-D8-Rat90\ratBEHstruct.mat','Results-E4-Rat92\ratBEHstruct.mat','Results-E5-Rat91\ratBEHstruct.mat','Results-J2-Rat93\ratBEHstruct.mat','Results-J6-Rat94\ratBEHstruct.mat'};
for co = 1:length(dat_dls_lesion)
fulldlsfile{co} = load(dat_dls_lesion{co});
end

for  co = 1:length(dat_dls_lesion)
    for n = 1:length(fulldlsfile{1,co}.ratBEHstruct)
    hit_partsdls{1,co}{1,n} = fulldlsfile{1,co}.ratBEHstruct(n).Hit;
    cuedtimesdls{1,co}{1,n} = fulldlsfile{1,co}.ratBEHstruct(n).cuedTimes;
    hittimesdls{1,co}{1,n} = fulldlsfile{1,co}.ratBEHstruct(n).pokeTimes;
    end
end

for k = 1:length(hit_partsdls)
for kk = 1:length(hit_partsdls{1,k})
hit_meandls{1,k}(1,kk)  = mean(hit_partsdls{1,k}{1,kk});
trial_countdls{1,k}(1,kk) = length(hit_partsdls{1,k}{1,kk});
end
end

for k = 1:length(hit_partsdls)
allhitsdls{1,k} = cell2mat(hit_partsdls{1,k});
end

yaxis_dls = allhitsdls

for i = 1:length(yaxis_dls)
yaxis_dlshit{1,i} = movmean(yaxis_dls{1,i},550);
end
for k = 1:length(yaxis_dlshit)
count_dlstrials(1,k) = size(yaxis_dlshit{1,k},2);
end

meancount_dms = mean(count_dmstrials);
meancount_control = mean(count_controlstrials);
meancount_dls = mean(count_dlstrials);
meancountsbar = [meancount_control;meancount_dms;meancount_dls];

%%
figure(5)
%plot accuracy curves averaged accross animals of each cohort 
%no 1st plot accuracy curves on 2 cohorts 
for i = 1:length(yaxis_wthit)
    subplot(2,3,i)
ff{1,i} = yaxis_wthit{1,i};
fx{1,i} = 1:length(ff{1,i});
[param] = sigm_fit(fx{1,i},ff{1,i});%plots sigmcurve 
hold on 
hold on 
ylim([0 1])
yline(0.85,'k--');
hold on 
ylabel('Accuracy');
xlabel('Trials');
title('Cue-tap association stage for control animals (n=6)');
hold on
p2 = gca;
p2.XAxis.LineWidth = 5;
p2.YAxis.LineWidth = 5;
p2.XAxis.FontSize = 15;
p2.YAxis.FontSize = 15;
hold off
end
%% 
figure(6)
%learning curves for dls 
for i = 1:length(yaxis_dlshit)
    subplot(2,3,i)
ff{1,i} = yaxis_dlshit{1,i};
fx{1,i} = 1:length(ff{1,i});
[param] = sigm_fit(fx{1,i},ff{1,i});%plots sigmcurve 
hold on 
hold on 
ylim([0 1])
yline(0.85,'k--');
hold on 
ylabel('Accuracy');
xlabel('Trials');
title('Cue-tap association stage for DLS lesion animals (n=5)');
hold on
p2 = gca;
p2.XAxis.LineWidth = 5;
p2.YAxis.LineWidth = 5;
p2.XAxis.FontSize = 15;
p2.YAxis.FontSize = 15;
hold off
end
%%
figure(7)
%get error bars

meancountsbar = [meancount_control;meancount_dms;meancount_dls];
     barplot = bar(meancountsbar,'FaceColor','flat');
     barplot.CData(1,:) = [0 0.5 0];
     barplot.CData(2,:) = [0.4660, 0.6740, 0.1880];
     barplot.CData(3,:) = [0.5, 0, 0.5]	;
     hold on
     scatter(1,count_controlstrials,60,'MarkerFaceColor','r','MarkerEdgeColor','k');
     hold on 
     scatter(2,count_dmstrials,60,'MarkerFaceColor','r','MarkerEdgeColor','k');
     hold on 
      scatter(3,count_dlstrials,60,'MarkerFaceColor','r','MarkerEdgeColor','k');
      hold on 
      er = errorbar(1,meancountsbar(1,1),std(count_controlstrials));
     er2 = errorbar(2,meancountsbar(2,1),std(count_dmstrials));
     er3 = errorbar(3,meancountsbar(3,1),std(count_dlstrials));

     er.Color = [0 0 0];                            
er.LineStyle = 'none';
er.LineWidth = 2

er2.Color = [0 0 0];                            
er2.LineStyle = 'none';
er2.LineWidth = 2

er3.Color = [0 0 0];                            
er3.LineStyle = 'none';
er3.LineWidth = 2

    p2 = gca;
p2.XAxis.LineWidth = 5;
p2.YAxis.LineWidth = 5;
p2.XAxis.FontSize = 20;
p2.YAxis.FontSize = 20;
hold on 
xticklabels({'Control (n=6)','DMS-lesion (n=4)','DLS-lesion (n=5)'})
hold on 
ylim([0 70000])
ylabel('Number of trials')
hold on 
title('Number of trials on cue-tap association stage')


figure(8)
meancountsbar_wodls = [meancount_control;meancount_dms];
     barplot = bar(meancountsbar_wodls,'FaceColor','flat');
     barplot.CData(1,:) = [0 0.5 0];
     barplot.CData(2,:) = [0.4660, 0.6740, 0.1880];
 
     hold on
     scatter(1,count_controlstrials,60,'MarkerFaceColor','r','MarkerEdgeColor','k');
     hold on 
     scatter(2,count_dmstrials,60,'MarkerFaceColor','r','MarkerEdgeColor','k');
     hold on 
      er = errorbar(1,meancountsbar(1,1),std(count_controlstrials));
     er2 = errorbar(2,meancountsbar(2,1),std(count_dmstrials));
      er.Color = [0 0 0];                            
er.LineStyle = 'none';
er.LineWidth = 2

er2.Color = [0 0 0];                            
er2.LineStyle = 'none';
er2.LineWidth = 2


    p2 = gca;
p2.XAxis.LineWidth = 5;
p2.YAxis.LineWidth = 5;
p2.XAxis.FontSize = 20;
p2.YAxis.FontSize = 20;
hold on 
xticklabels({'Control (n=6)','DMS-lesion (n=4)'})
hold on 
ylim([0 70000])
ylabel('Number of trials')
hold on 
title('Number of trials on cue-tap association stage')



%% 

%figure(4)
%plot all 10 together
%such that 4 are of dms l (make red), 6 are control (make blue)
%make x axis maximum
figure(8)
for i = 1:length(yaxis_dmshit)
    long{i} = length(yaxis_dmshit{1,i});
end
%make some data for legends
hleg = gobjects(2,1);
hold on 
xsize =  max(cell2mat(long)); 
for ii = 1:length(yaxis_dmsmov)
hleg(1) = plot(yaxis_dmsmov{1,ii},'b','LineWidth',2.5)
end
legend('Control rats (n=6)')
hold on 
for iii = 1:length(yaxis_wthit)
hleg(2) = plot(yaxis_wthit{1,iii},'r','LineWidth',2.5)
end
hold on 
plot(xlim,[.85,.85],'k--');
legend('DMS lesion (n=6)','FontSize',15)
hold on 
ylim([0 1])
xlim([0 xsize])
hold on 
p2 = gca;
p2.XAxis.LineWidth = 5;
p2.YAxis.LineWidth = 5;
p2.XAxis.FontSize = 15;
p2.YAxis.FontSize = 15;
ylabel('Accuracy during learning cue-tap associations');
xlabel('Trials');
legend(hleg,'DMS lesion','Control rats');
hold off
%% 
figure(9)
yaxis_dmsmov1 = yaxis_dmsmov;
for k = 1:length(yaxis_dmsmov1)
yaxis_dmsmov2{1,k}=movmean(yaxis_dmsmov1{1,k},500);
end

for k = 1:length(yaxis_wthit)
yaxis_wthit2{1,k}=movmean(yaxis_wthit{1,k},200);
end

for k = 1:length(yaxis_dlshit)
yaxis_dlshit2{1,k}=movmean(yaxis_dlshit{1,k},200);
end

for i = 1:length(yaxis_dmshit)
    long{i} = length(yaxis_dmshit{1,i});
end
%make some data for legends
hleg = gobjects(2,1);
hold on 
xsize =  max(cell2mat(long)); 
for ii = 1:length(yaxis_dmsmov2)
hleg(1) = plot(yaxis_dmsmov2{1,ii},'b','LineWidth',2.5)
end
legend('Control rats (n=6)')
hold on 
for iii = 1:length(yaxis_wthit)
hleg(2) = plot(yaxis_wthit2{1,iii},'r','LineWidth',2.5)
end
hold on 
for iii = 1:length(yaxis_dlshit)
hleg(2) = plot(yaxis_dlshit2{1,iii},'g','LineWidth',2.5)
end
plot(xlim,[.85,.85],'k--');
legend('DMS lesion (n=6)','FontSize',15)
hold on 
ylim([0 1])
xlim([0 xsize])
hold on 
p2 = gca;
p2.XAxis.LineWidth = 5;
p2.YAxis.LineWidth = 5;
p2.XAxis.FontSize = 15;
p2.YAxis.FontSize = 15;
ylabel('Accuracy during learning cue-tap associations');
xlabel('Trials');
legend(hleg,'DMS lesion','Control rats');
hold off

%TOTAL TRIAL COUNT ON TP 17 (SO TO BE CONSISITENT??)
for n = 1:length(yaxis2)
    trials_on_17{1,n} = length(yaxis2{1,n});
end
trialcount_on17 = cell2mat(trials_on_17);
trialcount_dmsl_17 = trialcount_on17(count_dmsl);
trialcount_wt_17 = trialcount_on17(count_wt);
lengthmat = max(length(trialcount_wt_17),length(trialcount_dmsl_17));
matrix = nan(lengthmat,2);
matrix(1:length(trialcount_dmsl_17),1) = trialcount_dmsl_17;
matrix(1:length(trialcount_wt_17),2) = trialcount_wt_17;

figure(7)
plotmatrix = matrix';
%%plot as bar 
% clr_lg = [0.4660, 0.6740, 0.1880];
% clr_dg = [0, 0.5, 0];
% clrs = [[0.4660, 0.6740, 0.1880];[0.4660, 0.6740, 0.1880];[0.4660, 0.6740, 0.1880];[0.4660, 0.6740, 0.1880];[0.4660, 0.6740, 0.1880];[0.4660, 0.6740, 0.1880];[0, 0.5, 0];[0, 0.5, 0];[0, 0.5, 0];[0, 0.5, 0];[0, 0.5, 0];[0, 0.5, 0];[0, 0.5, 0];[0, 0.5, 0];];
xaxis_bar = [1,2];
hold on 
xlim([0.5 2.5])
hold on 
%yaxis_trials = [matrix(:,1)];
ylim([0  max(max(matrix))+2000])
hBar1 = bar(xaxis_bar(1),plotmatrix(1,:),'FaceColor',[0.4660, 0.6740, 0.1880]);
hBar2 = bar(xaxis_bar(2),plotmatrix(2,:),'FaceColor',[0, 0.5, 0]);
hold on 
set(gca,'XTick',[1:2],'xticklabel',condition)
hold on
p2 = gca;
p2.XAxis.LineWidth = 5;
p2.YAxis.LineWidth = 5;
p2.XAxis.FontSize = 15;
p2.YAxis.FontSize = 15;
colormap(gray)
xlabel('Condition')
ylabel('Trials on cue-tap association stage')
hold off
%do significance test
% h = ttest2(cell2mat(z_dms),cell2mat(z_wt)); %so at 5%significance level 
%if h =1 it is significant 
%ended to flag levels of s

%%%%%for fig3 but with error bars
%can have eror bars when there are multiple data points at 1 trial (one x
%axis point)
%so if you plt acc vs session por if you avg accrss animals  
% for p = 1:length(yaxis1)
% [phat(i), CIcued(i)] = binofit(sum(ratBEHstruct(s).Hit(idx)), length(idx));
% % figure(2)%use for j8
% % errbar = accCued_plot'-CIcued_plot(:,1);
% % plot(datenum(date7_plot),z_plot_j8,'-go')
% % hold on
% % shadedErrorBar(datenum(date7_plot),z_plot_j8,errbar)
% hold on 
% datetick('x','dd mmm yyyy','keeplimits','keepticks'); ylabel('accuracy');
% hold on
% ylim([0 1])
% [phat, CIcued] = binofit(sum(Hit{1,1}), length(yaxis1{1,1}));
% [phat2, CIcued2] = binofit(sum(Hit{1,1}), length(Hit{1,1}));



% %plot 1 control and 1 DMS lesion together 
% plot(yaxis_dms{1,2})
% hold on 
% plot(yaxis_wt{1,2})
% hold on 
% ylim([0 1])
for n = 1:length(yaxis1)
trialcounts(1,n) = length(yaxis1{1,n});
end

%%%find mean and SD needed for learning cue-tap associations 
mean_dmsl = mean(trialcounts(count_dmsl)); %comes to be 23263
mean_wt = mean(trialcounts(count_wt));  %comes to be 4084
sd_dmsl = std(trialcounts(count_dmsl)); %comes to be 19800
sd_wt = std(trialcounts(count_wt)); %comes to be 1746
sem_wt = sd_wt./sqrt(length(count_wt));
sem_dmsl = sd_dmsl./sqrt(length(count_dmsl));

figure(6)
%%plot as bar 
clr_lg = [0.4660, 0.6740, 0.1880];
clr_dg = [0, 0.5, 0];
xaxis_bar = [1,2];
hold on 
xlim([0.5 2.5])
hold on 
yaxis_trials = [mean_dmsl,mean_wt];
ylim([0  max(yaxis_acc)+20000])
hold on 
hBar = bar(xaxis_bar,yaxis_trials,'FaceColor','flat');
hold on 
hBar.CData(1,:) = clr_lg;
hBar.CData(2,:) = clr_dg;
hold on
errlow = [sem_dmsl,sem_wt];
errhigh = [sem_dmsl,sem_wt];
er = errorbar(xaxis_bar,yaxis_trials,errlow,errhigh,'k','MarkerSize',100); 
er.LineStyle = 'none';
set(er,'LineWidth',3.5)
set(gca,'XTick',[1:2],'xticklabel',condition)
hold on
p2 = gca;
p2.XAxis.LineWidth = 5;
p2.YAxis.LineWidth = 5;
p2.XAxis.FontSize = 15;
p2.YAxis.FontSize = 15;
colormap(gray)
xlabel('Condition')
ylabel('Average number of trials to learn cue-tap association')
hold off
%do significance test
h = ttest2(trialcounts(count_dmsl),trialcounts(count_wt)); %so at 5%significance level 
%if h =1 it is significant 
%ended to flag levels of significance for 3 of the most commonly used levels. If a p-value is less than 0.05, it is flagged with one star (*). If a p-value is less than 0.01, it is flagged with 2 stars (**). If a p-value is less than 0.001, it is flagged with three stars (***)

% wanna compare trial times during cue-tap associations 
%to see if kinematics/ speed affected?







% figure(11)
% yaxis1 = movmean(Hit,450);
% yaxis2 = movmean(Hit,450);
% yline = find(yaxis1>0.85);
% z1 = find(yaxis1>0.85);
% z2 = z1(1,1);
% plot(yaxis1);
% hold on 
% plot(xlim,[.85,.85],'k--');
% hold on 
% xline(z2,'k--',z2);
% ylabel('Accuracy during learning cue-tap association');
% xlabel('Trials');
% 
% figure(12)
% z3 = z2+4000;
% yax = yaxis1(1:z3,:);
% plot(yax)
% hold on
% plot(xlim,[.85,.85],'k--');
% hold on 
% xline(z2,'k--',z2);
% hold off 
% ylabel('Accuracy during learning cue-tap association');
% xlabel('Trials');

