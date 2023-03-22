function info = processPokeOutput(filename, vidpath, protocol, hdw ,ratname, skipvid)
info = struct;

if nargin < 4
    hdw = containers.Map;
    ratname = '';
    skipvid = 1;
end
if ~isKey(hdw,'GPIOpin');hdw('GPIOpin') = 21; end
if ~isKey(hdw,'LeverL');hdw('LeverL') = 3; end
if ~isKey(hdw,'LeverC');hdw('LeverC') = 4; end
if ~isKey(hdw,'LeverR');hdw('LeverR') = 11; end
if ~isKey(hdw,'LEDL');hdw('LEDL') = 28; end
if ~isKey(hdw,'LEDC');hdw('LEDC') = 27; end
if ~isKey(hdw,'LEDR');hdw('LEDR') = 12; end
if ~isKey(hdw,'Speaker');hdw('Speaker') = 23; end
 if ~isKey(hdw,'Lick');hdw('Lick') = 26; end %for j7, j5
 if ~isKey(hdw,'Lick');hdw('Lick') = 2; end %for t8

if strcmp(ratname(1:5),'Ephys')
    % ephys box? do I do anything?
    1+1;
end

%% Read output file
delimiter = ',';
startRow = 4; % header occupies 3 lines

% Format string for each line of text:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%f%f%f%f%[^\n\r]';

% Open the text file.
fileID = fopen(filename,'r');

% Read columns of data according to format string.
try
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
catch
    dataArray = cell(1,8);
end

% Close the text file.
fclose(fileID);

%% Allocate imported array to column variable names

%fix different lengths
nn = min(cellfun(@length,dataArray));
dataArray = cellfun(@(v) v(1:nn), dataArray, 'UniformOutput',false);

EventType =    dataArray{:, 1};
Value =        dataArray{:, 2};
CurrentProtocol = dataArray{:,3};
CurrentState = dataArray{:, 4};
SessTime =     dataArray{:, 5};
ExptTime =     dataArray{:, 6};
DailyWater =   dataArray{:, 7};
WeeklyWater =  dataArray{:, 8};


% A matrix of all events
allEvents = [EventType, Value, CurrentProtocol, CurrentState, SessTime, ExptTime, DailyWater, WeeklyWater];

WMportstartval = 2; % I forget what this is...

%% Iterate over sessions
sessStartInd = find(EventType == 61 & CurrentProtocol == protocol); 
sessStopInd = find(EventType == 62 & CurrentProtocol == protocol);
% 61 and 62 are session boundaries

%*** this is sketchy, take a look at this...
% if accidentally stopped in middle or session, ignore that session
if ~isempty(sessStopInd) && ~isempty(sessStartInd);
    if sessStopInd(1) < sessStartInd(1); sessStopInd(1) = []; end
end
if length(sessStartInd) > length(sessStopInd)
    sessStartInd = sessStartInd(1:length(sessStopInd));
end

for s = 1 : length(sessStartInd)

%% Setup session information
%* was >=??
sessEventInds = ExptTime >= ExptTime(sessStartInd(s)) & ExptTime < ExptTime(sessStopInd(s));

NPOnLeft     = SessTime(sessEventInds & EventType == hdw('LeverL') & Value == 1); % need to debounce?
NPOffLeft    = SessTime(sessEventInds & EventType == hdw('LeverL') & Value == 0);
NPOnCenter   = SessTime(sessEventInds & EventType == hdw('LeverC') & Value == 1); % need to debounce?
NPOffCenter  = SessTime(sessEventInds & EventType == hdw('LeverC') & Value == 0);
NPOnRight    = SessTime(sessEventInds & EventType == hdw('LeverR') & Value == 1); % need to debounce?
NPOffRight   = SessTime(sessEventInds & EventType == hdw('LeverR') & Value == 0);
LEDOnLeft    = SessTime(sessEventInds & EventType == hdw('LEDL')   & Value == 1);
LEDOffLeft   = SessTime(sessEventInds & EventType == hdw('LEDL')   & Value == 0);
LEDOnRight   = SessTime(sessEventInds & EventType == hdw('LEDR')   & Value == 1);
LEDOffRight  = SessTime(sessEventInds & EventType == hdw('LEDR')   & Value == 0);
LEDOnCenter  = SessTime(sessEventInds & EventType == hdw('LEDC')   & Value == 1);
LEDOffCenter = SessTime(sessEventInds & EventType == hdw('LEDC')   & Value == 0);

ToneOn       = SessTime(sessEventInds & EventType == hdw('Speaker') & Value == 1);
ToneOff      = SessTime(sessEventInds & EventType == hdw('Speaker') & Value == 0);
waterTimes   = SessTime(sessEventInds & EventType == 51 );
LickOn       = SessTime(sessEventInds & EventType == hdw('Lick') & Value == 1);
LickOff      = SessTime(sessEventInds & EventType == hdw('Lick') & Value == 0);
Time         = SessTime(sessEventInds);

if strcmp(ratname(1:5),'Ephys') % account for lick port fix
LickOn       = SessTime(sessEventInds & (EventType == 25 | EventType == 26) & Value == 1);
LickOff      = SessTime(sessEventInds & (EventType == 25 | EventType == 26) & Value == 0);
end
% if strcmp(ratname(1:5),'Ephys') % account for lick port fix
% LickOn       = SessTime(sessEventInds & (EventType == 25 | EventType == 2) & Value == 1);
% LickOff      = SessTime(sessEventInds & (EventType == 25 | EventType == 2) & Value == 0);
% end
if hdw.isKey('Init')
    InitOn   = SessTime(sessEventInds & EventType == hdw('Init') & Value == 1);
    InitOff  = SessTime(sessEventInds & EventType == hdw('Init') & Value == 0);
end
 
unix_epoch = datenum(1970,1,1,0,0,0);
MSDNStartTime= ExptTime(sessStartInd(s));
matlab_time  = MSDNStartTime./86400 + unix_epoch; 
t = datetime(matlab_time,'ConvertFrom','datenum');
SecFromMid   = t.Hour*60*60 + t.Minute*60 + t.Second; % in seconds

%% match all frame and video information
if ~skipvid;

vidfolder = 'Z:\Kevin\Video\';
cam = 'Master';

folder = datestr(t,'yyyymmdd');
rat = split(ratname,'-');
box = rat{1}; rat = rat{2};
%offset = 60*60*hour(offset)+60*minute(offset)+second(offset); % yes need seconds offset here!

%vidpath = fullfile(vidfolder, box, cam,folder);
vidpath = fullfile(vidpath, folder);


% pull all concatenated events, video index, and frames???
eventfiles = dir(fullfile(vidpath,'*.events'));
cameraEvents = [];
absoluteCamEvents = [];
vidFile = {}; vidframes = [];
for f = 1:length(eventfiles)
    efile = eventfiles(f);  
    % skip if not from same session (within an hour)
    % if abs(t - efile.date)>hours(2); continue; end
    % - cant use this, since this is when file was modified!!!
    efileDate = strsplit(efile.folder,'\'); efileDate = efileDate{end};
    efileTime = strsplit(efile.name,{'-','.'}); efileTime = str2num(efileTime{2});
    efileDT = datetime(efileDate,'InputFormat','yyyyMMdd') + seconds(efileTime);
    if abs(t - efileDT) > hours(2); continue; end
    
    % read data
    events = csvread(fullfile(efile.folder,efile.name));
    frames = csvread(fullfile(efile.folder,[efile.name(1:9) '.frames']));
    % match to frames (taps on?)
    camtimes = events(find(events(2:end,1)==1)+1,2)-frames(1);
    match = camtimes' - frames(2:end);
    [val,id]=min(abs(match)); % id is the video frames of tap!!!!!    
    
    
    %vidframes{end+1} = id;
    %vidFile{end+1} = efile.name(1:9);
    vidframes = cat(2,vidframes, id);
    vidFile = cat(2,vidFile, repmat({efile.name(1:9)},1,length(id)));
    % save times from absolute time without offset...
    cameraEvents = cat(1,cameraEvents, events(find(events(2:end,1)==1)+1,2)/1e3);
    absoluteCamEvents = cat(1,absoluteCamEvents, events(find(events(2:end,1)==1)+1,3));
end

%* teensy on events...
teensyEvents = cat(1,NPOnLeft,NPOnRight,NPOnCenter);
absoluteTeensyEvents = [ExptTime(sessEventInds & EventType == hdw('LeverL') & Value == 1);...
    ExptTime(sessEventInds & EventType == hdw('LeverR') & Value == 1);...
    ExptTime(sessEventInds & EventType == hdw('LeverC') & Value == 1)];
leverpokeID = repelem(1:3,[length(NPOnLeft),length(NPOnRight),length(NPOnCenter)]);

[teensyEvents,id] = sort(teensyEvents);
absoluteTeensyEvents = absoluteTeensyEvents(id); %assert(issorted(absoluteTeensyEvents))
if ~issorted(absoluteTeensyEvents)
    disp('something messed up in experiment time...')
end
leverpokeID = leverpokeID(id);

%* match!!!
% offset everything to start of trial??? how do know absolute time?
matchEvents = [];
for tt = 1:size(teensyEvents,1)
    % find Pi times within 30s 
    timediff = absoluteTeensyEvents(tt) - absoluteCamEvents(:);  % DLS
    candidates = find(abs(timediff)<=30); % was too small????
    
    for c = 1:length(candidates)
        try 
            %t1 = teensyOn(tt:tt+3,2);
            t1 = teensyEvents(tt:tt+3);
            %t2 = cameraOn(candidates(c)+(0:3),2);
            t2 = cameraEvents(candidates(c)+(0:3));
            
            % match 3 interpress intervals (within 1 ms)
            % * this is less accurate for bigger differences...
            if mean(abs(diff(t1)-diff(t2)))<10 % sliding scale for bigger differences?
                % store camera time
                matchEvents(end+1,:) = [tt, candidates(c)];
                matchEvents(end+1,:) = [tt+1, candidates(c)+1];
                matchEvents(end+1,:) = [tt+2, candidates(c)+2];
                matchEvents(end+1,:) = [tt+3, candidates(c)+3];
                break
            end
        end
    end
end

% set up variables
frameMatches = NaN(size(teensyEvents));
vidMatches = cell(size(teensyEvents));

% take unique matches...
if ~isempty(matchEvents)
[C,ia,ib] = unique(matchEvents(:,1));
matchEvents = matchEvents(ia,:); % 1 is teensy point, 2 is cam point
% is anything ever missing? can always just match exactly?
%* looks like almost always a 1-1 matching (except for end)...
%* case if everything matches but the last few...
if (length(teensyEvents)==length(cameraEvents)) && isequal(matchEvents(:,1),matchEvents(:,2)) ...
        && isequal(matchEvents(:,1)',1:matchEvents(end,1)) && (length(teensyEvents)~=length(matchEvents)) ...
        && (length(teensyEvents)-matchEvents(end,1) < 3);
    % just add on the missed match events
    matchEvents((matchEvents(end,1)+1) : length(teensyEvents),:) = [(matchEvents(end,1)+1) : length(teensyEvents);(matchEvents(end,1)+1) : length(teensyEvents)]';
    
end

% match frames
frameMatches(matchEvents(:,1)) = vidframes(matchEvents(:,2));
vidMatches(matchEvents(:,1)) = vidFile(matchEvents(:,2));

if any(isnan(frameMatches))
    if isequal(matchEvents(:,1),matchEvents(:,2)) && isequal(matchEvents(:,1)',1:matchEvents(end,1)) && ...
           ( length(teensyEvents)>length(cameraEvents))
        disp('missed frames at end due to missing camera events')
    else
        disp('missed a frame for unknown reason')
    end
end

end



% put back into left center right levers (LRC)
frameL = frameMatches(leverpokeID==1);
frameR = frameMatches(leverpokeID==2);
frameC = frameMatches(leverpokeID==3);
vidL = vidMatches(leverpokeID==1);
vidR = vidMatches(leverpokeID==2);
vidC = vidMatches(leverpokeID==3);

else
    % just fill in everything with nans...
    teensyEvents = cat(1,NPOnLeft,NPOnRight,NPOnCenter);
    frameMatches = NaN(size(teensyEvents));
    vidMatches = cell(size(teensyEvents));
    leverpokeID = repelem(1:3,[length(NPOnLeft),length(NPOnRight),length(NPOnCenter)]);
    frameL = frameMatches(leverpokeID==1);
    frameR = frameMatches(leverpokeID==2);
    frameC = frameMatches(leverpokeID==3);
    vidL = vidMatches(leverpokeID==1);
    vidR = vidMatches(leverpokeID==2);
    vidC = vidMatches(leverpokeID==3);
end

%% Create trial blocked data
TrialStartTimes = SessTime(sessEventInds & EventType == 90 & Value == 1);
TrialEndTimes   = SessTime(sessEventInds & EventType == 90 & Value == 0);
if protocol==4; %*** didn't code in end time explicitly...
    % take everything 100 ms before trial start time (since this is the
    % delay period...
    TrialEndTimes = TrialStartTimes(2:end)-100;
    TrialEndTimes(end+1) = max(SessTime(sessEventInds));% last possible time?
end

for fixstuff = 1:2
% deal with mismatched trial time inds
if length(TrialStartTimes)~=length(TrialEndTimes)
    % method 2?
%     tempstart=[];tempend = [];
%     tempstart = TrialStartTimes(1);
%     for f = 2:min(length(TrialStartTimes) , length(TrialEndTimes))
%         [minValue,closestIndex] = min(abs(TrialStartTimes(f)-TrialEndTimes));
%         if minValue > 0 & ~ismember(TrialEndTimes(closestIndex),tempend)
%             tempend(f-1) = TrialEndTimes(closestIndex);
%             tempstart(f) = TrialStartTimes(f);
%         end
%     end
%     id = find(TrialEndTimes>tempstart(end));
%     tempend(f) = TrialEndTimes(id(1));
    
    % method 3, better?
    T = [TrialStartTimes; TrialEndTimes];
    S = [zeros(length(TrialStartTimes),1); ones(length(TrialEndTimes),1)];
    [~,id] = sort(T,'ascend');
    %333 is problem in trial start...
    badid = id( find(abs(diff(S(id)))==0) );
    T(badid) = []; S(badid) = [];
    TrialStartTimes = T(S==0);
    TrialEndTimes = T(S==1);
        
    % method 1 still use to check corners
    if length(TrialStartTimes) > length(TrialEndTimes)
        TrialStartTimes(end)=[];
    elseif length(TrialStartTimes) < length(TrialEndTimes)
        TrialEndTimes(1)=[];
    end
end
% fix miss in the middle? - no idea what this is doing...
TrialEndTimes(find(abs(diff((TrialStartTimes < TrialEndTimes))))) = [];
end

% make sure all aligned
try
assert(all((TrialStartTimes < TrialEndTimes)==1));
assert(all((TrialStartTimes(2:end) > TrialEndTimes(1:end-1))==1))
catch
    disp('can''t align trial times...need to toss this session...');
    continue
end

Time            = SessTime(sessEventInds);
Events          = EventType(sessEventInds);
Val             = Value(sessEventInds);
T = length(TrialStartTimes);
TrialEdgeTimes = [TrialStartTimes; max(Time)];

%*** shoudl I get poke off as well? or just poke on ok?
if ~hdw.isKey('Init')
%[pokeTimes, pokeNames, cuedTimes, cuedNames, Hit, blocknum, wm, WMportstart, WMportstartval, HitLeverVals, flashLeverVal] = ...
%    getTrialAlignedPokes(Time, NPOnLeft, NPOnCenter, NPOnRight, TrialStartTimes,...
%    waterTimes,LEDOnLeft,LEDOnCenter,LEDOnRight, Events, Val, SecFromMid, WMportstartval);
%*** debugging rat 46: targetnames are wrong, rat doing LCR... sequence
% [pokeTimes, pokeNames, cuedTimes, cuedNames, Hit, blocknum, wm, WMportstart, WMportstartval, HitLeverVals, flashLeverVal,...
%     extraPokes, extraPokesNames, targetNames] = ...
%     getTrialAlignedPokesExtra(Time, NPOnLeft, NPOnCenter, NPOnRight, TrialStartTimes, TrialEndTimes, ...
%     waterTimes,LEDOnLeft,LEDOnCenter,LEDOnRight, Events, Val, SecFromMid, WMportstartval);

[pokeTimes, pokeNames, cuedTimes, cuedNames, Hit, blocknum, wm, WMportstart, WMportstartval, HitLeverVals, flashLeverVal,...
    extraPokes, extraPokesNames, targetNames, frames, vids] = ...
    getTrialAlignedPokesExtraFrames(Time, NPOnLeft, NPOnCenter, NPOnRight, TrialStartTimes, TrialEndTimes, ...
    waterTimes,LEDOnLeft,LEDOnCenter,LEDOnRight, Events, Val, SecFromMid, WMportstartval,...
    frameL,frameC,frameR,vidL,vidR,vidC, protocol);


else
[pokeTimes, pokeNames, cuedTimes, cuedNames, Hit, blocknum, wm, WMportstart, WMportstartval, HitLeverVals, flashLeverVal,...
    extraPokes, extraPokesNames, InitTimes, targetNames] = ...
    getTrialAlignedPokesInit(Time, NPOnLeft, NPOnCenter, NPOnRight, TrialStartTimes, TrialEndTimes,...
    waterTimes,LEDOnLeft,LEDOnCenter,LEDOnRight, Events, Val, SecFromMid, WMportstartval,...
    InitOn, InitOff);
end




%% try something
%{
sessEventInds = ExptTime >= ExptTime(sessStartInd(s)) & ExptTime <= ExptTime(sessStopInd(s));
ExptEventTimes = ExptTime(sessEventInds);

matlab_time = ExptEventTimes(1)./86400 + unix_epoch; 
t = datetime(matlab_time,'ConvertFrom','datenum');
t_start = t.Hour*60*60 + t.Minute*60 + t.Second;
y_start = datestr(t,'yyyymmdd');
matlab_time = ExptEventTimes(end)./86400 + unix_epoch;
t = datetime(matlab_time,'ConvertFrom','datenum');
t_end = t.Hour*60*60 + t.Minute*60 + t.Second;
y_end = datestr(t,'yyyymmdd');

D(D>t_start & D<t_end)
%}

%% Get accuracy data
blockLength = max(Value(EventType==95)); 
blockChangeInds = [1; find(EventType==95)];
blockChangeVal  = [-1; Value(find(EventType==95))];

accuracy = zeros(blockLength,1);
accuracy2 = zeros(blockLength,1);
Trials = zeros(blockLength,1);
accuracy_port32 = zeros(blockLength,1);
accuracy_port21 = zeros(blockLength,1);
accuracy_port31 = zeros(blockLength,1);

for block = 0:blockLength
    % get session indices for during particular block\
    idx = find(blockChangeVal==block);
    blockEventInds = zeros(length(sessEventInds),1);
    for j = 1:length(idx)
        %blockEventInds(blockEventIdxs(j):blockEventIdxs(j+1)) = 1;
        blockEventInds(blockChangeInds(idx(j)-1):blockChangeInds(idx(j)))=1;
    end

    % extract  values
    numSuccess = SessTime(sessEventInds & blockEventInds & EventType == 91 & Value == 1);
    numSuccessDouble = SessTime(sessEventInds & blockEventInds & EventType == 91 & Value == 2);
    numSuccessTriple = SessTime(sessEventInds & blockEventInds & EventType == 91 & Value == 3);
    numMiss = SessTime(sessEventInds & blockEventInds & EventType == 91 & Value == 0);
    waterTimes   = SessTime(sessEventInds & blockEventInds & EventType == 51);


    accuracy(block+1,1) = length(numSuccessTriple) / (length(numSuccess) + length(numMiss));
    accuracy(block+1,1) = length(waterTimes) / (length(numSuccess) + length(numMiss));
    accuracy2(block+1,1) = length(waterTimes) / length(numSuccess);
    Trials(block+1,1) = length(numSuccess) + length(numMiss);

    accuracy_port32(block+1,1) = length(numSuccessTriple) / length(numSuccessDouble);
    accuracy_port21(block+1,1) = length(numSuccessDouble) / length(numSuccess);
    accuracy_port31(block+1,1) = length(numSuccessTriple) / length(numSuccess);
end
accuracy(isinf(accuracy))=NaN; accuracy2(isinf(accuracy2))=NaN;

if protocol == 8
    numSuccess = SessTime(sessEventInds & EventType == 91 & Value == 1);
    numSuccessDouble = SessTime(sessEventInds & EventType == 91 & Value == 2);
    numSuccessTriple = SessTime(sessEventInds & EventType == 91 & Value == 3);
    numMiss = SessTime(sessEventInds & EventType == 91 & Value == 0);
    waterTimes   = SessTime(sessEventInds & EventType == 51);


    accuracy = length(numSuccessTriple) / (length(numSuccess) + length(numMiss));
    accuracy = length(waterTimes) / (length(numSuccess) + length(numMiss));
    accuracy2 = length(waterTimes) / length(numSuccess);
    Trials = length(numSuccess) + length(numMiss);

    accuracy_port32 = length(numSuccessTriple) / length(numSuccessDouble);
    accuracy_port21 = length(numSuccessDouble) / length(numSuccess);
    accuracy_port31 = length(numSuccessTriple) / length(numSuccess);
end


%% get info from checkLearningRates
% don't need to, since have blocked info
% but can get that from info that already exists

%% Translate expt time to time before midnight?
%**** issue is that videos overlap... only 107 videos, but found 367 trials

%*** same issue, want to double count. maybe just put in
%getTrialAlignedPokes file...
unix_epoch = datenum(1970,1,1,0,0,0);
%matlab_time = unix_time./86400 + unix_epoch; 

trial_vidfile = {};
vid_starttime = [];
vid_endtime = [];

% get video indices
% currentdate = regexp(filename,'[0-9]{8}','match','once');
% vidnames = dir([vidpath currentdate '\*.mp4']);
% vidnamesList = cellfun(@(x){x(5:9)}, {vidnames.name});
% S = sprintf('%s ', vidnamesList{:});
% D = sscanf(S, '%f');
currentdate = '';

% match video times
TrialStartTimes = SessTime(sessEventInds & EventType == 90 & Value == 1);
TrialEndTimes   = SessTime(sessEventInds & EventType == 90 & Value == 0);

for fixstuff=1:2
    
     % method 3, better?
    T = [TrialStartTimes; TrialEndTimes];
    S = [zeros(length(TrialStartTimes),1); ones(length(TrialEndTimes),1)];
    [~,id] = sort(T,'ascend');
    %333 is problem in trial start...
    badid = id( find(abs(diff(S(id)))==0) );
    T(badid) = []; S(badid) = [];
    TrialStartTimes = T(S==0);
    TrialEndTimes = T(S==1);
    
% deal with mismatched trial time inds
if length(TrialStartTimes)~=length(TrialEndTimes);
    if length(TrialStartTimes) > length(TrialEndTimes)
        TrialStartTimes(end)=[];
    else
        TrialEndTimes(1)=[];
    end
end
% fix miss in the middle?
TrialEndTimes(find(abs(diff((TrialStartTimes < TrialEndTimes))))) = [];
end

trialcount = 1;
T = length(TrialStartTimes);
for j = 1:T
    % skip trial criteria (if no pokes)
    Lpoke = NPOnLeft(NPOnLeft > TrialEdgeTimes(j) & NPOnLeft < TrialEdgeTimes(j+1));
    Cpoke = NPOnCenter(NPOnCenter > TrialEdgeTimes(j) & NPOnCenter < TrialEdgeTimes(j+1));
    Rpoke = NPOnRight(NPOnRight > TrialEdgeTimes(j) & NPOnRight < TrialEdgeTimes(j+1));
    if isempty(Lpoke) && isempty(Cpoke) && isempty(Rpoke); continue; end
    
    % get date-time range
    matlab_time = TrialStartTimes(j)./86400 + unix_epoch; 
    t = datetime(matlab_time,'ConvertFrom','datenum');
    t_start = t.Hour*60*60 + t.Minute*60 + t.Second;
    matlab_time = TrialEndTimes(j)./86400 + unix_epoch;
    t = datetime(matlab_time,'ConvertFrom','datenum');
    t_end = t.Hour*60*60 + t.Minute*60 + t.Second;
    % make sure have the right date;
    y = datestr(t,'yyyymmdd');
    
    % fix!!!**** align to first poke, not to trial start signal...
    
    if exist([vidpath y])
    
        if ~strcmp(y,currentdate)
            currentdate = y;
            vidnames = dir([vidpath currentdate '\*.mp4']);
            vidnamesList = cellfun(@(x){x(5:9)}, {vidnames.name});
            S = sprintf('%s ', vidnamesList{:});
            D = sscanf(S, '%f');
        end

        % video in trial range, or video within another video
        vidind = find(D>=t_start & D<t_end);
        if isempty(vidind)vidind = find(D<t_start);end

        if ~isempty(vidind)
            vidfile = [currentdate '\v40-' vidnamesList{vidind(end)} '.mp4'];
            vid_starttime(trialcount) = t_start;% - D(vidind(end));
            vid_endtime(trialcount) = t_end;% - D(vidind(end));
        else
            vidfile = '';
        end
        trial_vidfile{trialcount} = vidfile;
        
    else
        vid_starttime(trialcount) = NaN;
        vid_endtime(trialcount) = NaN;
        trial_vidfile{trialcount} = '';
    end
    
    trialcount = trialcount + 1;
end

matlab_time = ExptTime(sessStartInd(s))./86400 + unix_epoch; 
startTime = datetime(matlab_time,'ConvertFrom','datenum');
currentdate = regexp(filename,'[0-9]{8}','match','once');
currentdate = regexp(filename,'([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))','match','once');


%% Align data to videos
TrialStartTimes = SessTime(sessEventInds & EventType == 90 & Value == 1);
TrialEndTimes   = SessTime(sessEventInds & EventType == 90 & Value == 0);
Time            = SessTime(sessEventInds);
Events          = EventType(sessEventInds);
Val             = Value(sessEventInds);
T = length(TrialStartTimes);
TrialEdgeTimes = [TrialStartTimes; max(Time)];

VideoStartTimes = (vid_starttime - SecFromMid)*1000; % use coarse video time to crop led times
VideoEndTimes   = (vid_endtime - SecFromMid)*1000; 

if length(TrialStartTimes)~=length(TrialEndTimes)
    TrialStartTimes(end)=[];
end

%[pokeFrames] = getEventCamFrames(Time, TrialStartTimes, TrialEndTimes, pokeTimes,...
%    LEDOnLeft, LEDOffLeft,LEDOnCenter,LEDOffCenter,LEDOnRight,LEDOffRight,...
%    SecFromMid, trial_vidfile, vidpath);



%% Save structure info
info(s).name = ratname;
info(s).date = currentdate;%regexp(filename,'[0-9]{8}','match','once');
info(s).session = s;
info(s).startTime = startTime;%ExptTime(sessStartInd(s));
%info(s).Trials = T;
info(s).Trials = sum(Trials);
info(s).TrialsBlock = Trials;
info(s).VidStartTime = vid_starttime;
info(s).VidEndTime = vid_endtime;
info(s).trialstart = TrialStartTimes;
info(s).trialend = TrialEndTimes;

info(s).pokeTimes = pokeTimes;
info(s).pokeNames = pokeNames;
info(s).cuedTimes = cuedTimes;
info(s).cuedNames = cuedNames;
info(s).targetNames = targetNames;
%come back
info(s).LickOn = LickOn;
info(s).LickOff = LickOff;

%if hdw.isKey('Init')
if exist('extraPokes')
    info(s).extraPokes = extraPokes;
    info(s).extraPokesNames = extraPokesNames;
    if exist('InitTimes');
    info(s).InitTimes = InitTimes;
    end
end
info(s).Hit = Hit;
info(s).blocknum = blocknum;
info(s).wm = wm;
info(s).WMportstart = WMportstart;

info(s).accuracy = accuracy;
info(s).accuracy2 = accuracy2;
info(s).accuracy_port21 = accuracy_port21;
info(s).accuracy_port31 = accuracy_port31;
info(s).accuracy_port32 = accuracy_port32;

info(s).HitLeverVals = HitLeverVals;
info(s).flashLeverVal = flashLeverVal;

info(s).vidfile = trial_vidfile;

if exist('frames')
    info(s).frames = frames;
    info(s).vids = vids;
end

end

end