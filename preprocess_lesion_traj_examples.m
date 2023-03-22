%% this script pulls traj examples of a single sequence, around lesion
% - for cued, OT, and WM
% - from script in analyze_traj_basic

%** need to make anothe rversion that pulls across rats
% - want to show use species typical movements
% - look at single presses? look early vs. late? look across different
% sequences?
%   - need to match by tapping paw? 

loadFlag = 1;
useMissAlso = 0;
useallmove = 0;
usesubmove = 0;

for userat = 57%[-1, 1, 3, -4, 5, 7, 8, 9, % [5:10,30:32]%[-4:4] %[21:26,5:10]% 21:26%5:9%[5,6,7,8,10,9]%1:26%21:26%18:20%1:17
%% set up path and rats
if userat==-30
cam = 'Master';
 joint = 'pawR';
move = {'CLC'};
loadFlag = 1;
% srange = 3:1350; %specify using ratBEHstruct..see the session
% correspnding to tracking dates and write here 
srange = 236:494;
% loadpath = 'V:\Users\cbhatia\E8_Rat103\Results-E8-Rat103\ratBehTrajSess\';
loadpath = 'Y:\Users\cbhatia\L1_Life\Results-L1-Life\ratBehTrajSess\';


elseif userat==0
%  J8 rat 7 % - done - might need to rerun for cam Slave2
%- done single levers
%cam = 'Slave2'; %  - not this one
%joint = 'pawL'; % which one is it?
 cam = 'Master';
 joint = 'pawL';
move = {'LRC'};
% datechunks = {'20190120','20190425','20190604'};
% move = {'L','C','R'};
loadFlag = 1;
srange = 90:1335;
loadpath = 'F:\Kevin\Sequence_tap\J8_output\Results-J8-Rat7\ratBehTrajSess\';

% F4 43 - done
% - done levers
elseif userat==-1
loadpath = 'F:\Kevin\Sequence_tap\F4_output\Results-F4-Rat43\ratBehTrajSess\';
load('F:\Kevin\Sequence_tap\F4_output\Results-F4-Rat43\ratBEHstruct.mat');
box_joints = {'pawL','nose'};
box_cams = {'Slave2','Slave1'};
joint = 'pawL'; cam = 'Slave2';
srange = 86:603; % this pulls from start up to pre unilateral lesion
srange = 86:1126;
move = {'CLR'};

% J3 Rat 42 % - done 
% - done levers
elseif userat==-2
loadpath = 'D:\Kevin\Sequence_tap\J3_output\Results-J3-Rat42\ratBehTrajSess\';
%load('D:\Kevin\Sequence_tap\J3_output\Results-J3-Rat42\ratBEHstruct.mat');
% box_joints = {'pawL','nose'};
% box_cams = {'Slave1','Slave2'};
joint = 'pawL'; cam = 'Slave1';
srange = 140:1194;
move = {'CRL'};

% % E8 rat 14 %  - done
elseif userat==-3
loadpath = 'D:\Kevin\Sequence_tap\E8_output\Results-E8-Rat14\ratBehTrajSess\';
%load('D:\Kevin\Sequence_tap\E8_output\Results-E8-Rat14\ratBEHstruct.mat');
%box_joints = {'pawR'};
%box_cams = {'Master'};
joint = 'pawR'; cam = 'Master';
srange = 219:928;
move = {'RCL'};

elseif userat == 1
% L3 rat 34 (could only track left) % - done 
loadpath = 'D:\Kevin\Sequence_tap\L3_output\Results-L3-Rat34\ratBehTrajSess\';
%load('D:\Kevin\Sequence_tap\L3_output\Results-L3-Rat34\ratBEHstruct.mat');
%box_joints = {'pawR'};box_cams = {'Slave1'};
joint = 'pawR'; cam = 'Slave1';
move = {'LCR'};
srange = 929:1950;

elseif userat == 2
% D7 rat 19 - done
loadpath = 'F:\Kevin\Sequence_tap\D7_output\Results-D7-Rat19\ratBehTrajSess\';
%load('F:\Kevin\Sequence_tap\D7_output\Results-D7-Rat19\ratBEHstruct.mat');
box_joints = {'pawL'};box_cams = {'Master'};
joint = 'pawL'; cam = 'Master';
move = {'CRL'};
srange = 264:1090;

elseif userat == 3
% j2 rat 17 - done
loadpath = 'F:\Kevin\Sequence_tap\J2_output\Results-J2-Rat17\ratBehTrajSess\';
%load('F:\Kevin\Sequence_tap\J2_output\Results-J2-Rat17\ratBEHstruct.mat');
%box_joints = {'pawL','nose'};% box_cams = {'Master','Slave1'};
%joint = 'pawL'; cam = 'Master';
joint = 'pawR'; cam = 'Slave2';
move = {'RLR'};
srange = 534:1759;

elseif userat == 4
% e1 rat 20 % - done
loadpath = 'F:\Kevin\Sequence_tap\E1_output\Results-E1-Rat20\ratBehTrajSess\';
load('F:\Kevin\Sequence_tap\E1_output\Results-E1-Rat20\ratBEHstruct.mat');
%box_joints = {'pawL'};% box_cams = {'Master'};
joint = 'pawL'; cam = 'Slave2';
move = {'RCR'};
srange = 48:1075; % isnt tracked that well...esp post lesion

% e4 rat 39 - done %** somethings wrong with this data, it should be
% higher...
% - done single levers also
elseif userat==-4
loadpath = 'D:\Kevin\Sequence_tap\E4_output\Results-E4-Rat39\ratBehTrajSess\';
%load('D:\Kevin\Sequence_tap\E4_output\Results-E4-Rat39\ratBEHstruct.mat');
%box_joints = {'pawL'};% box_cams = {'Master'};
joint = 'pawR'; cam = 'Master';
move = {'RLC'};
srange = 888:1676;

% DLS rats

% D7 74 % - done
elseif userat==5
cam = 'Master';
joint = 'pawR';
move = {'CLR'};
datechunks = {'20200727','20200907','20201028'};
loadFlag = 1;
srange = 320:1337; % to end
%srange = 44:792; % early to prelesion (look at single taps early late learning!)
loadpath = 'F:\Kevin\Sequence_tap\D7_output\Results-D7-Rat74\ratBehTrajSess\';
srange = 1:1337;

elseif userat==6
% j7 rat 78 - done
loadpath = 'D:\Kevin\Sequence_tap\J7_output\Results-J7-Rat78\ratBehTrajSess\';
%load('D:\Kevin\Sequence_tap\J7_output\Results-J7-Rat78\ratBEHstruct.mat');
%box_joints = {'pawR','nose'};% box_cams = {'Master','Slave2'};
joint = 'pawR'; cam = 'Master';
move = {'LRC'};
srange = 149:1306; % 149 arbitrary
srange = 1:1306;

elseif userat==7
% e1 75 - done
loadpath = 'F:\Kevin\Sequence_tap\E1_output\Results-E1-Rat75\ratBehTrajSess\';
%load('D:\Kevin\Sequence_tap\E1_output\Results-E1-Rat75\ratBEHstruct.mat');
box_joints = {'pawR','nose'};% box_cams = {'Master','Slave1'};
joint = 'pawR'; cam = 'Master';
move = {'CRL'};
srange = 190:1320;
srange = 1:1320;

elseif userat==8
% l2 rat 70 - done
loadpath = 'D:\Kevin\Sequence_tap\L2_output\Results-L2-Rat70\ratBehTrajSess\';
%load('D:\Kevin\Sequence_tap\L2_output\Results-L2-Rat70\ratBEHstruct.mat');
box_joints = {'pawL','nose'};
box_cams = {'Master','Slave2'};
joint = 'pawL'; cam = 'Master';
move = {'CLC'};
srange = 339:1640;
srange = 1:1640;

elseif userat == 9
% j1 rat 71 - done
loadpath = 'D:\Kevin\Sequence_tap\J1_output\Results-J1-Rat71\ratBehTrajSess\';
%load('D:\Kevin\Sequence_tap\J1_output\Results-J1-Rat71\ratBEHstruct.mat');
%box_joints = {'pawR','nose'};
%box_cams = {'Slave1','Slave2'};
joint = 'pawR'; cam = 'Slave1';
move = {'RCR'};
srange = 176:1524;
srange = 1:1524;

elseif userat==10
% l3 rat 65 - DONE
% slave1 paw L
loadpath = 'D:\Kevin\Sequence_tap\L3_output\Results-L3-Rat65\ratBehTrajSess\';
joint = 'pawL'; cam = 'Slave1';
move = {'LRC'};
srange = 1098: 1564;


% MC OT only rats

elseif userat==11
% E8 82 % - done 
cam = 'Master';
joint = 'pawR';
move = {'LCL'};
%datechunks = {'20200727','20200927','20201106'};
loadFlag = 1;
srange = 21:700;
loadpath = 'D:\Kevin\Sequence_tap\E8_output\Results-E8-Rat82\ratBehTrajSess\';


elseif userat==12
% % rat f655 - done
cam = 'Master';
joint  ='pawL';
move = {'CLR'};
loadpath =  'D:\Kevin\Sequence_tap\F6_output\Results-F6-Rat55\ratBehTrajSess\';
loadFlag = 1;
srange = 192:642; % post mock to end

elseif userat==13
% l4 53 - done
% ** some bug in getting the frames, lots of duplicates, skipping first
% % poke? need to go to getTrajStruct to debug?
%cam = 'Master'; joint = 'pawR';
cam = 'Slave2'; paw = 'pawL';
move = {'LCR'};
loadpath = 'D:\Kevin\Sequence_tap\L4_output\Results-L4-Rat53\ratBehTrajSess\';
srange = 258:575; % 27 oct is post mock

elseif userat==14
% l1 52 - done
cam = 'Master';
joint = 'pawR';
move = {'CRC'};
loadpath =  'D:\Kevin\Sequence_tap\L1_output\Results-L1-Rat52\ratBehTrajSess\';
srange = 1:761;

elseif userat == 15
% e1 rat 54 - done 
cam = 'Master';
joint = 'pawR'; % also uses pawL?
move = {'LCR'}; % only does OT...? how look at this?
loadpath = 'D:\Kevin\Sequence_tap\E1_output\Results-E1-Rat54\ratBehTrajSess\';
srange = 1:487;

elseif userat==16
% l5 95 - done
cam = 'Master';
joint = 'pawL'; % also uses pawL?
move = {'LRC'}; % only does OT...? how look at this?
loadpath = 'F:\Kevin\Sequence_tap\L5_output\Results-L5-Rat95\ratBehTrajSess\';
srange = 29:561;

elseif userat==17
% J3 - Rat 88 - done
cam = 'Slave1';
joint = 'pawR'; % also uses pawL?
move = {'CLC'}; % only does OT...? how look at this?
loadpath = 'D:\Kevin\Sequence_tap\J3_output\Results-J3-Rat88\ratBehTrajSess\';
srange = 41:572;

% more
elseif userat==18
    
% J8 - Rat79 
% - not working because tracked incorrectly
% - didnt track paw actually, retracking..
% - or juts use master
joint = 'pawL'; cam = 'Slave2';
move = {'RCR'};
loadpath = 'F:\Kevin\Sequence_tap\J8_output\Results-J8-Rat79\ratBehTrajSess\';
srange = 54: 1275;

elseif userat==19
% L1-Rat77
% - i think this one is fixed...
joint = 'pawL'; cam = 'Slave2';
move = {'CLC'};
loadpath = 'F:\Kevin\Sequence_tap\L1_output\Results-L1-Rat77\ratBehTrajSess\';
srange=  92 : 1182;

elseif userat==20
% L4-Rat68 - uses both paws 
joint = 'pawL'; cam = 'Slave2';
move = {'LCL'};
loadpath = 'F:\Kevin\Sequence_tap\L4_output\Results-L4-Rat68\ratBehTrajSess\';
srange = 25:1294;


% DMS rats
elseif userat==21
    %L2 rat 116: 
    joint = 'pawR'; cam = 'Slave1'; % maybe slave1? master may not track as well...
    move = {'LRC'};
    loadpath = 'F:\Kevin\Sequence_tap\L2_output\Results-L2-Rat116\ratBehTrajSess\';
    srange = 135:1045;% is this anything meaningful? iforgot..
    
elseif userat==22
    %J3-rat113
    joint = 'pawL'; cam = 'Slave1'; % also uses pawR
    move = {'LRC'}; 
    loadpath = 'F:\Kevin\Sequence_tap\J3_output\Results-J3-Rat113\ratBehTrajSess\';
    srange = 34:1105;
    
elseif userat==23
    % D8-rat119
    joint = 'pawL'; cam = 'Master'; 
    move = {'RCR'}; 
    loadpath = 'F:\Kevin\Sequence_tap\D8_output\Results-D8-Rat119\ratBehTrajSess\';
    srange = 33:881;
    
elseif userat==24
    % J6-Rat105
    joint = 'pawL'; cam = 'Slave1'; move = {'CRC'};
    loadpath = 'F:\Kevin\Sequence_tap\J6_output\Results-J6-Rat105\ratBehTrajSess\';
    srange=  39:1145;
elseif userat==25
    % E4-Rat122
    joint = 'pawL'; cam = 'Slave1'; move = {'CRC'}; 
    loadpath = 'F:\Kevin\Sequence_tap\E4_output\Results-E4-Rat122\ratBehTrajSess\';
    srange = 31:703;
    
elseif userat==26
    % F3-rat115 - she started in box J7 fyi, should track that too?
    joint = 'pawL'; cam = 'Slave2'; move = {'RLC'};
    loadpath = 'F:\Kevin\Sequence_tap\F3_output\Results-F3-Rat115\ratBehTrajSess\';
    disp('rat not fully tracked yet');
    srange = 10:836;
    
% new DMS rats
elseif userat==27 %* doing
    % D8-Rat128
    joint = 'pawL'; cam = 'Master'; move = {'LRL'}; % maybe use pawR?
    joint = 'pawR'; 
    loadpath = 'F:\Kevin\Sequence_tap\D8_output\Results-D8-Rat128\ratBehTrajSess\';
    srange = 10:942;
elseif userat == 28
    % E5-Rat123
    joint = 'pawR'; cam = 'Master'; move = {'CRL'};
    loadpath = 'F:\Kevin\Sequence_tap\E5_output\Results-E5-Rat123\ratBehTrajSess\';
    srange = 10:1617;
elseif userat == 29
    % L2-Rat132
    joint = 'pawR'; cam = 'Master'; move = {'LCL'};
    loadpath = 'F:\Kevin\Sequence_tap\L2_output\Results-L2-Rat132\ratBehTrajSess\';
    srange = 10:1045;
% new DLS rats
elseif userat == 30
    % L3-Rat117
    joint = 'pawR'; cam = 'Master'; move = {'RCL'};
    loadpath = 'F:\Kevin\Sequence_tap\L3_output\Results-L3-Rat117\ratBehTrajSess\';
    srange = 23:926;
elseif userat == 31
    % l5 -rat 118
    joint = 'pawL'; cam = 'Slave1'; move = {'RLC'};
    loadpath = 'F:\Kevin\Sequence_tap\L5_output\Results-L5-Rat118\ratBehTrajSess\';
    srange = 21:923;
elseif userat == 32
    % F5 rat 86
    joint = 'pawR'; cam = 'Slave1'; move = {'CRL'};
    loadpath = 'F:\Kevin\Sequence_tap\F5_output\Results-F5-Rat86\ratBehTrajSess\';
    srange = 54:1927; % need to finish racking
% new MC lesion rat
elseif userat == 33
    % J4 Rat 126
    joint = 'pawL'; cam = 'Slave2'; move = {'LRC'};
    loadpath = 'F:\Kevin\Sequence_tap\J4_output\Results-J4-Rat126\ratBehTrajSess\';
    srange = [29:1789];


elseif userat==50

    cam = 'Slave1';
    joint  ='pawL';
    move = {'LCR'};
    loadpath =  'V:\Users\cbhatia\T5_3\Results-T5-Tiffany_3.0\ratBehTrajSess\';
    loadFlag = 1;
    srange = 1:671; % post mock to end

    elseif userat==51

    cam = 'Master';
    joint  ='pawR';
    move = {'LCL'};
    loadpath =  'V:\Users\cbhatia\E8_Rat103\Results-E8-Rat103\ratBehTrajSess\';
    loadFlag = 1;
    srange = 1:1350; % post mock to end

     elseif userat==52

    cam = 'Master';
    joint  ='pawR';
    move = {'RCL'};
    loadpath =  'V:\Users\cbhatia\J2_Jay\Results-J2-Jay\ratBehTrajSess\';
    loadFlag = 1;
    srange = 1:467; % post mock to end
   
elseif userat==53

    cam = 'Master';
    joint  ='pawR';
    move = {'CLC'};
    loadpath =  'V:\Users\cbhatia\L1_Life\Results-L1-life\ratBehTrajSess\';
    loadFlag = 1;
    srange = 1:505; % post mock to end
elseif userat==54

    cam = 'Slave2';
    joint  ='pawR';
    move = {'CLC'};
    loadpath =  'Y:\Users\cbhatia\L1_Life\Results-L1-life\ratBehTrajSess\';
    loadFlag = 1;
    srange = 237:495; % post mock to end
elseif userat==55

    cam = 'Slave2';
    joint  ='pawR';
    move = {'RCR'};
    loadpath =  'V:\Users\cbhatia\d6_dahlia\Results-D6-DAHLIA\ratBehTrajSess\';
    loadFlag = 1;
    srange = 1:834; % post mock to end

elseif userat==56

    cam = 'Slave2';
    joint  ='pawR';
    move = {'CRC'};
    loadpath =  'Y:\Users\cbhatia\t6_titli\Results-T6-Titli\ratBehTrajSess\';
    loadFlag = 1;
    srange = 42:893; % post mock to end

    elseif userat==57

    cam = 'Master';
    joint  ='pawR';
    move = {'CRC'};
    loadpath =  'Y:\Users\cbhatia\T4\Results-T4-Trip\ratBehTrajSess\';
    loadFlag = 1;
    srange = 559:990; % post mock to end
else
    disp('rat not found')
end

%% same, but now for individual lever presses?


%% initialize for cued, WM , or OT

% set one of these to 1
onlyWM = 1;
onlyCued = 0;
onlyOT = 0;

curContext = {'OT','Cued','WM'};
%move = {'L','C','R'};

off = 25; % frames before after lever press
% - this is from other folder, should use this value?

%move = {'LC','LR','CL','CR','RL','RC'};
if useallmove
    move = {'LCL','LRL','LCR','LRC','CLC','CLR','CRC','CRL','RLC','RLR','RCR','RCL'};
end

if usesubmove
    move = {'LC','LR','CL','CR','RL','RC'};
end
%% 

% 1 for submove...
for c = 1:2% temp for OT only rat, 2:3 temp for allmove

    if c == 1
        onlyOT = 1; onlyCued = 0; onlyWM = 0;
    elseif c==2
        onlyOT = 0; onlyCued = 1; onlyWM = 0;
    else
        onlyOT = 0; onlyCued = 0; onlyWM = 1;
    end
    disp(loadpath);

%% pull data


traj = {}; traj_prob = {};

seqchange = [];

sessID = []; trialID = [];
order = eye(3);

ordinal = [];
protocol = [];
tSess = datetime.empty;
Hit = [];
lever = {}; target = {};
prevLever = {};
WM = [];
condition_tapafter = 0;
condition_tapbefore = 0;
tapon = []; tapoff = [];
colors = 'rbg';
if useMissAlso
    tapon = {}; tapoff = {};
end
prevHit = [];
prevTarget = {};



%     onlyWM = m-1;
%     onlyOT = 1-onlyWM;

    % to get different contexts
%     onlyOT = order(m,1);
%     onlyWM = order(m,2);
%     onlyCued = order(m,3);
%     
%     % if looking at all seq?
%     if length(move) > 3; onlyCued = 1; onlyWM = 0; onlyOT = 0; end
%     
%     % looking at L,R,C
%     if length(move)==3 && length(seq)==1;  onlyCued = 1; onlyWM = 0; onlyOT = 0; end
      % looking at submoves
%     
%     %* uncomment to do lesion analysis!!!
%     %onlyOT = 1; onlyWM=0; onlyCued= 0;
%     if length(move)==1; onlyOT = 1; onlyWM = 0; onlyCued = 0; end 
%    
%     
%     %onlyOT = 0; % for sequence comparison...
%     % temp for e1 rat 75 look at learning
%     onlyCued = 1; onlyOT = 0; onlyWM = 0; % for dls rats 
%    % onlyOT = 0; onlyWM = 0; onlyCued = 1; % temp d774 
%    % onlyCued = 0; onlyWM = 0; onlyOT = 0;
   % if length(move)==6; onlyCued=0; onlyWM=0; onlyOT=0; end % this defaults to cued and WM?

for ss = srange%1:length(ratBehTrajStruct)%0:203%40:64
    disp(ss)
    for m = 1:length(move)%1:3
    
    seq = move{m}; 
    %disp(seq);
    
    if loadFlag
        s = 1;% disp('loading from separate files')
        if ~exist([loadpath, num2str(ss), '.mat']); continue; end
        %disp('here')
        load([loadpath, num2str(ss), '.mat']);
        %ratBehTrajStruct = ratBehUnitTrajStructSess; % for ephyse8 45
        ratBehTrajStruct = ratBehTrajStructSess;
    else
        s = ss; % track like normal
        disp('normal')
    end
    
    % code for normal boxes
    % - which skips OT sequences
%     for full task animals to turn off ot seq plotting
    if onlyOT==1 %##for ot of full task
        if ratBehTrajStruct(s).protocol ~= 8; continue ; end
    else
        if ratBehTrajStruct(s).protocol == 8; continue ; end
        if isempty(ratBehTrajStruct(s).blocknumRepair); continue; end%Fseq
    end
    % temp for ephys submove stuff
%     if ratBehTrajStruct(s).protocol==8; continue; end

% %     
    % for rat l1 on trial and error for ot only rats on 6
%     if ratBehTrajStruct(s).protocol~=6 && ratBehTrajStruct(s).protocol~=5; continue; end
%    disp('this is set up for trial and error')
    
    
    %if isempty(ratBehTrajStruct(s).pokeTimes{1}); continue; end

for j = 1:length(ratBehTrajStruct(s).pokeNames)
    ports = ratBehTrajStruct(s).pokeNames{j};
    if strcmp(ratBehTrajStruct(1).name, 'L1-Rat77'); ports = ports(1:3); end
    ind = strfind(ports,seq) + condition_tapbefore;
    if j>1; prevports = ratBehTrajStruct(s).pokeNames{j-1}; else; prevports = 'X'; end
    
    % match more specific seq, but take only one ind
    %if length(ports)~=3; continue; end % new 20191109 % - need for individual taps? remove for early leraning 
    if ~useMissAlso
    if ratBehTrajStruct(s).Hit(j)==0; continue; end % add misses?
    end
    if onlyWM; if ratBehTrajStruct(s).blocknumRepair(j) < 3; continue; end ; end
    if onlyCued; if ratBehTrajStruct(s).blocknumRepair(j) >= 3; continue; end; end
    
    % filter by targetnames instead...so only take when suppsed todo the OT
    % sequence?
    
    % if doesn't have traj, skip
    if isempty(ratBehTrajStruct(s).(['pokeFrames' cam])); continue; end
    
    % need to edit so that useMissAlso sets it so it doesnt get just that
    % sequence and it gets all length 3 sequences???
    
    if useMissAlso && length(ports)>1; ind = 1; end
    
    for tap = 1:length(ind)
    
    if ~isempty(ind(tap))
        uselen = length(seq) - 1 - condition_tapafter - condition_tapbefore;
        if useMissAlso; uselen = length(ports)-1; end
        framesstart = ratBehTrajStruct(s).(['pokeFrames' cam]){j}(ind(tap):ind(tap)+uselen);
        framesstop = ratBehTrajStruct(s).(['pokeOutFrames' cam]){j}(ind(tap):ind(tap)+uselen);
    else
        continue;
    end
    
    if length(unique(framesstart))~= length(framesstart); continue ; end
    if any(isnan(framesstart)) | any(isnan(framesstop)); continue ; end
    
    
    if ~isfield(ratBehTrajStruct(s).(['traj' cam]),(joint)); continue; end
    if any(framesstart - off < 1) | any(framesstop + off > length(ratBehTrajStruct(s).(['traj' cam])((j)).(joint){1}))
        continue; 
    end
    if any(find(diff(framesstart)<0)) & length(ratBehTrajStruct(s).(['traj' cam])((j)).(joint)) > 1
        if any(framesstop + off > length(ratBehTrajStruct(s).(['traj' cam])((j)).(joint){2}))
            continue;
        end
    end
    
    if isempty(ratBehTrajStruct(s).(['traj' cam])((j)).(joint){1}); continue; end
    
    if any(find(diff(framesstart)<0)) & length(ratBehTrajStruct(s).(['traj' cam])((j)).(joint)) > 1
        if isempty(ratBehTrajStruct(s).(['traj' cam])((j)).(joint){2}); continue; end
        vid1 = ratBehTrajStruct(s).(['traj' cam])((j)).(joint){1};
        vid2 = ratBehTrajStruct(s).(['traj' cam])((j)).(joint){2};
        traj{end+1} = [vid1((framesstart(1)-off):end,:) ; vid2(1:(framesstop(end)+off),:)];
        vid1prob = ratBehTrajStruct(s).(['traj_prob' cam])((j)).(joint){1};
        vid2prob = ratBehTrajStruct(s).(['traj_prob' cam])((j)).(joint){2};
        traj_prob{end+1} = [vid1prob((framesstart(1)-off):end) , vid2prob(1:(framesstop(end)+off))];
        
        stitchind = find(diff(framesstart)<0);
        framesstart((stitchind+1):end) = framesstart((stitchind+1):end) + length(vid1);
        stitchind = find(diff(framesstop)<0);
        framesstop((stitchind+1):end) = framesstop((stitchind+1):end) + length(vid1);
        %tapon(:,end+1) = [framesstart - framesstart(1)+off];
        %tapoff(:,end+1) = [framesstop - framesstop(1)+off];
        
        if ~useMissAlso
        tapon(:,end+1) = [framesstart - framesstart(1)+off];
        tapoff(:,end+1) = [framesstop - framesstop(1)+off];
        else
            tapon{end+1} = [framesstart - framesstart(1)+off];
            tapoff{end+1} = [framesstop - framesstop(1)+off];
        end
        
        if onlyWM || onlyCued; sessID(end+1) = ss; trialID(end+1) = j; end
        
    elseif any(find(diff(framesstart)<0)) & length(ratBehTrajStruct(s).(['traj' cam])((j)).(joint)) == 1
        1+1;
    else
        vid1 = ratBehTrajStruct(s).(['traj' cam])((j)).(joint){1};
        traj{end+1} = vid1((framesstart(1)-off):(framesstop(end)+off),:);
        vid1prob = ratBehTrajStruct(s).(['traj_prob' cam])((j)).(joint){1};
        traj_prob{end+1} = vid1prob((framesstart(1)-off):(framesstop(end)+off));
        
        if ~useMissAlso
        tapon(:,end+1) = [framesstart - framesstart(1)+off];
        tapoff(:,end+1) = [framesstop - framesstop(1)+off];
        else
            tapon{end+1} = [framesstart - framesstart(1)+off];
            tapoff{end+1} = [framesstop - framesstop(1)+off];
        end
        
        if onlyWM || onlyCued; sessID(end+1) = ss; trialID(end+1) = j; end
    end
    
    %*** edit here for submoves
    % - do version with submoves (allsubmoves)
    % - basically just crop from OT, cued, WM?
    % - OT only seq? or all submoves and look at all of them?
    if j>1; prevHitTemp = ratBehTrajStruct(s).Hit(j-1); else; prevHitTemp = -1; end %???
    
    ordinal(end+1) = ind(tap);
    protocol(end+1) = ratBehTrajStruct(s).protocol;
    Hit(end+1) = ratBehTrajStruct(s).Hit(j);
    prevHit(end+1) = prevHitTemp;
  %  lever{end+1} = ports; % well this could be ok, and to get lever do lever(ordinal)
    % lever{end+1} = ports(ind(tap));
    lever{end+1} = seq;
    target{end+1} = ports;
    prevTarget{end+1} = prevports;
    tSess(end+1) = ratBehTrajStruct(s).startTime;
    if onlyOT; sessID(end+1) = ss; trialID(end+1) = j; end % is this right?
    if ratBehTrajStruct(s).protocol==7
        WM(end+1) = ratBehTrajStruct(s).blocknumRepair(j) >= 3;
    elseif ratBehTrajStruct(s).protocol==8
        WM(end+1) = -1;
    elseif ratBehTrajStruct(s).protocol==6
        WM(end+1) = 0;
    else
        WM(end+1) = -2;
        
    end
    
    end % tap
    
    
end %end pokenames

end %end move 

seqchange(m) = length(traj);

end % end srange

%% find seqchange of lesion

tmppath = strsplit(loadpath, 'ratBehTrajSess');
load(fullfile(tmppath{1}, 'ratBEHstruct.mat'));

% Hit = []; for s = 1:length(ratBEHstruct); Hit(s) = length(ratBEHstruct(s).Hit); end
% dt = [ratBEHstruct(:).startTime];

%hardcode seqchange -- check what it gives you, the output will be based on
%when it misses > 20 sessions -- check if its right or wrong

seqchange = find(diff(sessID)>20);
seqchange=  find(days(diff(tSess))>6);
tSess(seqchange);%type tsess(eqchange) and check if dates that come out are correct ?? if not hardcode seqchange such that it spits 



% % J8 Rat 7
% seqchange = [1060, 3905]; % OT 
% seqchange = [65, 111]; % cued
% seqchange = [19, 39]; % wm
% datechunks;
% 
% % D7 rat 74
% seqchange = [1320, 3128, 4773]; % OT
% seqchange = [1221,1593,1956]; % Cued
% seqchange = [591,792,1040]; % WM

%% save

% pull ratname
ratname = strsplit(loadpath, 'Results-'); ratname = strsplit(ratname{2},'\');
ratname = ratname{1};

%savepath = 'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\F4-Rat43\lesion_data_WM.mat';
%savepath = ['D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\E4-Rat39\lesion_data_allmoves' curContext{c} '.mat'];
%savepath = ['D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\' ratname '\lesion_data_allmoves' curContext{c} '.mat'];
%savepath = ['D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\' ratname '\lesion_data_' curContext{c} '.mat'];
savepath = ['D:\RESULTS\Tracking_trajectories\' ratname '\lesion_data_' curContext{c} '.mat'];
%savepath = ['D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\' ratname '\lesion_data_submoves' '.mat'];
%savepath = ['D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\' ratname '\lesion_data_submoves' curContext{c} '.mat'];

%savepath = ['D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\' ratname '\lesion_data_withearly_' curContext{c} '.mat'];



if useallmove
savepath = ['D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\' ratname '\lesion_data_allmoves_' curContext{c} '.mat'];
end

if useMissAlso
savepath = ['D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\' ratname '\lesion_data_hitmiss_withprev_' curContext{c} '.mat'];
end

if usesubmove
    savepath = ['D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\' ratname '\lesion_data_submoves' curContext{c} '.mat'];
end


disp(savepath);
%assert(~exist(savepath));
if ~exist(savepath)
disp('saving')
save(savepath, 'seqchange','traj','WM','traj_prob','lever','sessID','tSess',...
    'Hit','ordinal','protocol','tapon','onlyWM','onlyCued','onlyOT','loadpath',...
    'joint','cam','move','target',...
    'prevHit','prevTarget');

else
    disp('file already exists!')
    disp(savepath)
end


end % end context

end % end rat userat
%% plotting functions cleaned
% - pulled from analyze_traj_basic
% - cleaned up for grant?
%   - for example, interp nans and include a smoothing

%% datapaths

% - retrack l4-rat68
%  - traj prob is consistently bad (though maybe when drinking, or maybe
%  because this is a double pawed rat)
%  - unusable
%  - yeah when paws do the double tap thing it doesnt work, so need to
%  retrack
% * new removing f655, e154 for small lesions

% - oh l468 might not ever be good...

% OT only
fpath_rat = {'Z:\Cheshta\Behav_structs\E8_Rat103_thdls_otonly';...
    'Z:\Cheshta\Behav_structs\j2jay_thdls_otonly\Results-J2-Jay';...
   'Z:\Cheshta\Behav_structs\l1_laila_thdls_otonly\Results-L1-Laila';...
%    Z:\Cheshta\Behav_structs\l1_life_thdls_otonly\Results-L1-life
    'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\L4-Rat68';... 
    };

% add J879, L177, L468
% - slave2pawL, slave2pawL, slave2pawL

% - F655 traj is low? why?


datechunk_rat = {{'20201025','20201120','20201221'};...
     {'20200924','20201029','20201125'};...
 %    {'20191012','20191114','20191205'};...
%     {'20190919','20191014','20191108'};...
     {'20190920','20191011','20191107'};...
%     {'20201025','20201119','20201221'};...
     {'20200615','20200730','20201104'};...% j8 79 no mock
     {'20200908','20200926','20201105'};... % l177, no mock
     {'20200615','20200730','20200927'};... % l468, no mock
     };
 
 
 
 
%% MC lesions%
% - cut some rats
% - need to fix e439. earlier plots look fine idk why traj corr is so low!
fpath_rat = {'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\F4-Rat43';...
  %  'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\J3-Rat42';...
%    'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\E8-Rat14';...
%    % might need to cut - not 725
    'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\L3-Rat34';...
    'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\J8-Rat7';...
   % 'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\D7-Rat19';...
    'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\J2-Rat17';... % bad tracking cut rat - might be looking at wrong paw
    'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\E1-Rat20';...
    'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\E4-Rat39'}; % 
datechunk_rat = {{'20190614','20190802','20190908'};...
 %   {'20190613','20190802','20190920'};...
 %   {'20200523','20190524','20190625'};... % e8 14 no mock break
    {'20190926','20191105','20200103'};... % - not a ton of trials..why?
    {'20190111','20190425','20190604'};... % j8 7 no trajectories pre mock break
   % {'20181119','20181120','20181219'};... % d719 tracking bad?
    {'20181204','20190412','20190610'};... % j217 bad tracking? wrong paw maybe...
    {'20181010','20181114','20181215'};... e1 rat 20, have no tracking between uni and bi
    {'20190926','20191107','20200103'}};


%% DLS lesions
% - no j476 since problem with tracking..
fpath_rat = {'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\D7-Rat74';...
    'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\J7-Rat78';... % missing a lot of pre mock stuff
   % 'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\E1-Rat75';...
    'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\L2-Rat70';... % missing prelesion stuff..?
    'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\J1-Rat71';... % also missing some prelesion stuff
    'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\L3-Rat65'}; % missing pre mock
datechunk_rat = {{'20200727','20200907','20201028'};...
    {'20200727','20200927','20201106'};...
  %  {'20200906','20200928','20201106'};...
    {'20200727','20200909', '20201105'};...
    {'20200728','20200908','20201029'};...
    {'20200727','20200927','20201121'}};

% DLS lesions new rats
fpath_rat = {'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\D7-Rat74';...
    'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\J7-Rat78';... % missing a lot of pre mock stuff
    'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\L2-Rat70';... % missing prelesion stuff..?
    'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\J1-Rat71';... % also missing some prelesion stuff
    'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\L3-Rat65';... % missing pre mock
    'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\F5-Rat86';...
    'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\L3-Rat117';...
    'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\L5-Rat118';...
    };

datechunk_rat = {{'20200727','20200907','20201028'};...
    {'20200727','20200927','20201106'};...
    {'20200727','20200909', '20201105'};...
    {'20200728','20200908','20201029'};...
    {'20200727','20200927','20201121'};...
    {'20210329','20210715','20210816'};... F586
    {'20210317','20210719','20210816'};... L3117
    {'20210518','20210719','20210816'};... L586
    };

%% DMS lesions
fpath_rat = {'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\L2-Rat116';...
   'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\J3-Rat113';...
   'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\J6-Rat105';...
   'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\D8-Rat119';...
   'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\E4-Rat122';...
   'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\F3-Rat115\';};%...
 %  'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\J2-Rat125'};

datechunk_rat = {{'20210515','20210815', '20210912'};...
    {'20210515','20210815','20210912'};...
    {'20210515','20210815','20210912'};...
    {'20210515','20210815','20210912'};... 
    {'20210816','20210922','20211017'};... % e4
    {'20210816','20210922','20211019'}};%...
   % {'20210816','20210922','20211020'}};
   
   % using only certain rats that meet criteria: I think L2 didn't reach
   % accuracy
fpath_rat = {'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\J3-Rat113';...
   'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\J6-Rat105';...
   'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\D8-Rat119';...
   'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\E4-Rat122';};%...
  % 'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\F3-Rat115\';};%...
 %  'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\J2-Rat125'};

datechunk_rat = {{'20210515','20210815','20210912'};...
    {'20210515','20210815','20210912'};...
    {'20210515','20210815','20210912'};... 
    {'20210816','20210922','20211017'}};%... % e4
  %  {'20210816','20210922','20211019'}};%...
   % {'20210816','20210922','20211020'}};
   
   
%DMS rats new
fpath_rat = {'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\J3-Rat113';...
   'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\J6-Rat105';...
   'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\D8-Rat119';...
   'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\E4-Rat122';...
   'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\D8-Rat128';...
   'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\L2-Rat132';...
   'D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\E5-Rat123';};%...


datechunk_rat = {{'20210515','20210815','20210912'};...
    {'20210515','20210815','20210912'};...
    {'20210515','20210815','20210912'};... 
    {'20210816','20210922','20211017'};...
    {'20220514','20220620','20220718'};...
    {'20220514','20220620','20220718'};...
    {'20220514','20220620','20220718'};};

%hardcode 
%%TO MAKE PLOTS.. speed/correlations/pre-post lesion traj compaisons etc..
fpath_rat = {'D:\RESULTS\Tracking_trajectories\L1-Life';...
};%...

%right dates: moc,uni,bilateral 

%%hardcode dates
datechunk_rat = {{'20210515','20210831','20211114'}};


%% filepaths for ths-dls full task
fpath_rat = {'D:\RESULTS\Tracking_trajectories\D6-Dahlia';...
    'D:\RESULTS\Tracking_trajectories\T5-Tiffany_3.0';...
   'D:\RESULTS\Tracking_trajectories\T6-Titli'};
%     'D:\RESULTS\Tracking_trajectories\T4-Trip'};


datechunk_rat = {{'20211205','20220114','20220214'};...%order needs to be madeup date then  mock then lesion 
    {'20210715','20210804','20220924'};...
    {'20211225','20220115','20220223'}}
%     {'20220522','2022',''}};
 

%% filepaths for th-dls ot only
   fpath_rat ={'D:\RESULTS\Tracking_trajectories\E8-Rat103';...
    'D:\RESULTS\Tracking_trajectories\J2-Jay';...
   'D:\RESULTS\Tracking_trajectories\L1-Life'};
%     'D:\RESULTS\Tracking_trajectories\T4-Trip'};


datechunk_rat ={{'20210711','20210831','20211116'};....%order needs to be madeup date then  mock then lesion 
{'20220813','20220826','20221004'};...
    {'20220216','20220304','20220321'}};
%% 

%% check seq change manual for all sequences
% this is for extent analysis??
% need to fix l365??
curContext = {'OT','Cued','WM'};

c = 1;
f = 1;
filepath = fpath_rat{f};
datechunks = datechunk_rat{f};

load(fullfile(filepath, ['lesion_data_allmoves_' curContext{c} '.mat']));
disp(fullfile(filepath, ['lesion_data_allmoves_' curContext{c} '.mat']));

%diff([0,seqchange,length(traj)])
disp(tSess(seqchange))
disp(datechunks)
disp(tSess(seqchange+1))

% if changing
% save(fullfile(filepath, ['lesion_data_allmoves_' curContext{c} '.mat']),'seqchange','-append')


%% DLS all?
% load from beginning
% - make seqedge so not at mock, but at some earlier time?

%% go through each rat and get seqchange manually
% - check that tSess(seqchange) is close to dateChunks
curContext = {'OT','Cued','WM'};

c = 2;
f = 3;
filepath = fpath_rat{f};
datechunks = datechunk_rat{f};

load(fullfile(filepath, ['lesion_data_' curContext{c} '.mat']));
disp(fullfile(filepath, ['lesion_data_' curContext{c} '.mat']));

%diff([0,seqchange,length(traj)])..check that the range of dates is before
%and after your specified date and add a fake unilateral date 1st at pplace
%1 
disp(tSess(seqchange)) %ok now, make sure tses(seqchange) and tsess(seqchange+1) produce diff dates - this one should produce pre lesion date
disp(datechunks)
disp(tSess(seqchange+1))%this post lesion
%can check using  figure;plot(tSess)

%to know exact rang, see google sheet named surgerydates/trajectory info
%and make sure pre is bfore pre date and post after postdate 

%%seqchange in kvins code is written to assume 3 numbers... either fix code
%%to expect only blateral number or makeup 1st 2 numbers for seqchange....

%

%   save(fullfile(filepath, ['lesion_data_' curContext{c} '.mat']),'seqchange','-append')

%% plots

%% loop over rats
%%%%%%%%%combine traj from here....
corrDist_rat = {};
corrDist_across = {};
corrDist_mean = {}; % correlation to mean movement prelesion

dotrajplots = 0;
toss_lever_taps = 1;

% whats this do
doallmove = 0;
dosubmove=0;

% -currently plots for OT only and MC lesions are local
dolocal = 1; % local warping for correlation or global warping

% - use l334 traj samples
% - f343 might be good for traj averages before and after, or e439?
%  - yes use e439, show just theo horizontal part

% DLS
 % - try d774 for example trajs?
 
% tap IPI use
IPIval = [25, 50,50]; %  L334
%IPIval = [50, 90, 90]; % L365
% - maybe use E1?

% curContext = {'OT','Cued','WM'};
curContext = {'OT','Cued'};

mean_speed_all = {}; % condition x context x rat
mean_speed_all_earlylate = {}; % first 1/3 and last 1/3? or no, too many for OT?
mean_speed_all_earlylate;
frac_stop_all_earlylate = {};
peak_speed_all = {};
peak_speed_all_earlylate = {};

LDJ_all = []; speed_metric_all = []; SARCL_all = [];
nsampsave = [];
traj_speed_all_earlylate = {}; traj_speed_all = {};

extent_all = {}; extent_all_earlylate = {}; % take all data for now... 
cam_rat = {}; lever_rat = {};
% for condition = 1
% :3
%% 
 for condition = 1:2
%   for rat = 1:2

for rat = 1:length(fpath_rat)
    filepath = fpath_rat{rat};
    if doallmove
         load(fullfile(filepath, ['lesion_data_allmoves_' curContext{condition} '.mat']))
    elseif dosubmove
        load(fullfilde(filepath, ['lesion_data_submoves' curContext{condition} '.mat']))
    else
    load(fullfile(filepath, ['lesion_data_' curContext{condition} '.mat']))
    end
    disp(filepath);
    assert(length(seqchange)==3,'Not right number of breaks found');
    
%% 0) prep data

all_titles = {'Pre','Mock','Bilateral'};

cam_rat{rat} = cam;
lever_rat{rat} = unique(lever);

% load data

% smooth trajectories + fill nans + remove bad trajs
badtrackfrac = []; trajvar = [];
for count = 1:length(traj)
    % smooth and filter...
    traj{count}(traj_prob{count}<.9 , :) = nan;
    badtrackfrac(count) = sum(traj_prob{count}<.9)/length(traj_prob{count});
    traj{count} = fillmissing(traj{count}, 'linear','EndValues','nearest');
    traj{count} = imgaussfilt(traj{count}, [.6, eps]);
    % bad if traj didn't do anything
    % - if all flat?
    trajvar(:,count) = var(traj{count});
end
 badid = find(badtrackfrac > .1); %
% this rat is missing at end when licking lever so im bumping it up...
if contains(fpath_rat{rat}, 'L4-Rat68'); badid = find(badtrackfrac>.2); end
 if contains(fpath_rat{rat}, 'L1-Life'); badid = find(badtrackfrac>.3); end
badid = unique([badid, find(trajvar(1,:)<10), find(trajvar(2,:)<10)]);
% if the third tap is too close to the end of trial, cut!
a = cellfun(@length, traj); b = tapon(end,:)+8;
badid = unique([badid, find(b>a)]);
badid = unique([badid, find(tapon(2,:) > tapon(end,:))]);

% remove bad stuff
for j = 1:length(seqchange)
    seqchange(j) = seqchange(j) - sum(badid<seqchange(j));
end
sessID(badid) = [];
tSess(badid) = [];
tapon(:,badid) = [];
traj(badid) = [];
traj_prob(badid) = [];


% pull data
seqedge = [0 seqchange, length(traj)];
numsamp = min(diff(seqedge))-1; % pull from each seqchange

% put data into structure by context
% - excluding extremem trial times
trajtemp = {};
for dim_use = 1:2
for j = 1:(length(seqedge)-1)
    rr = (seqedge(j)+1) : (seqedge(j+1));

    tap_range = round(quantile(tapon(end,rr),[.05,.5,.75]));
    % can i take all of them?
    tap_range = round(quantile(tapon(end,rr),[0,.5,.9])); % want to toss slowest trials?
    
    % 2) crop from similar tap times,warp around tap timing.. 
    [ttt,idx] = sort(tapon(end,rr));
    [~,id1] = min(abs(ttt-tap_range(1))); id1 = id1(1);
    %id1 = find(ttt==tap_range(1)); id1 = id1(1);
    %id2 = find(ttt==tap_range(end)); id2 = id2(end);
    [~,id2]=min(abs(ttt-tap_range(end))); id2 = id2(end);
    
    trajsamp = traj(rr(idx(id1:round((id2-id1)/numsamp):id2)));
    tapstemp{j} = tapon(:,rr(idx(id1:round((id2-id1)/numsamp):id2)));
    
    sessIDtemp{j} = sessID(rr(idx(id1:round((id2-id1)/numsamp):id2)));        
    
    % take only 1 dim?
    trajsamp = cellfun(@(v) v(:,dim_use),trajsamp,'un',0);
    [~,sortid] = sort(cellfun(@length,trajsamp));
    % zero pad to same length...
    maxN = max(cellfun(@length,trajsamp));
    padfun = @(v) [v; zeros( maxN - numel(v),1)] ;
    trajsamp = cellfun(padfun, trajsamp , 'un', 0);
    % plot?
    trajsamp = cell2mat(trajsamp);
    trajsamp(trajsamp==0)=nan;
   
    trajtemp{j,dim_use} = trajsamp';

end
end
if length(trajtemp)==4
    trajtemp_mock = trajtemp; trajtemp(1,:) = []; 
    tapstemp_mock = tapstemp; tapstemp(1) = []; 
end

%% pull out speed between lever taps
% - look pre / post lesion
% - make plot of:
%   - mean, median, distribution?
% - address if there's more swipes or more pauses

traj_speed = {};
mean_speed = []; peak_speed = [];
frac_stop = []; thresh_stop = .006; % emperical
for count = 1:length(traj)
    % smooth and oversample
    val = traj{count};
    valx = csaps(1:size(val,1), val(:,1), .5, linspace(1,size(val,1),4*size(val,1)));
    valy = csaps(1:size(val,1), val(:,2), .5, linspace(1,size(val,1),4*size(val,1)));
    
    dt = 1/(40*4);
    traj_speed{count} = sqrt(diff(valx).^2 + diff(valy).^2)./dt; % 40 hz * 4 upsample to get pixels/second 
    % - i think the scale factor is wrong...
    
    % - need to account for shift in tap time with upsampling...
    % - or just do for each tap
    [~,newtaps] = min( abs( tapon(:,count) - linspace(1,size(val,1),4*size(val,1)) )' );
    
    % dumbest, just look at change in average velocities pre post?
    mean_speed(count) = mean(traj_speed{count}(newtaps(1):newtaps(end)));
    % 
    peak_speed(count) = max(traj_speed{count}(newtaps(1):newtaps(end)));
    
    % slightly smarter, look at fraction of speed under some value?
    frac_stop(count) = sum(traj_speed{count}<thresh_stop)/length(traj_speed{count});
end


mean_speed_all; % condition x context x rat
for j = 1:(length(seqedge)-1)
    rr = (seqedge(j)+1) : (seqedge(j+1));
    mean_speed_all{j, condition, rat} = mean_speed(rr);
    peak_speed_all{j, condition, rat} = peak_speed(rr);
end
% pull early late examples
% - want between taps?

% want to look early late...
mean_speed_all_earlylate;
nsamp = min([300, round(diff(seqedge)/3)]);
nsampsave(condition,rat) = nsamp;
for j = 1:(length(seqedge)-1)
    rr = (seqedge(j)+1) : (seqedge(j+1));
    jj = 2*(j-1)+1;
    mean_speed_all_earlylate{jj, condition, rat} = mean_speed(rr(1:nsamp));
    mean_speed_all_earlylate{jj+1, condition, rat} = mean_speed(rr( (end-nsamp+1) : end));
    peak_speed_all_earlylate{jj, condition, rat} = peak_speed(rr(1:nsamp));
    peak_speed_all_earlylate{jj+1, condition, rat} = peak_speed(rr( (end-nsamp+1) : end));
end

frac_stop_all_earlylate;
for j = 1:(length(seqedge)-1)
    rr = (seqedge(j)+1) : (seqedge(j+1));
    jj = 2*(j-1)+1;
    frac_stop_all_earlylate{jj, condition, rat} = frac_stop(rr(1:nsamp));
    frac_stop_all_earlylate{jj+1, condition, rat} = frac_stop(rr( (end-nsamp+1) : end));

    traj_speed_all{condition,rat} = [traj_speed{:}];
    traj_speed_all_earlylate{jj,condition,rat} = [traj_speed{rr(1:nsamp)}]; % 1,3,5,7 is early (early, mock, early uni, early bi)
    traj_speed_all_earlylate{jj+1,condition,rat} = [traj_speed{rr((end-nsamp+1):end)}]; % 2,4,6,8 is premock, preuni, prebi, late)
end
% measure of smoothness
% - look at speed metric
% - look at log dimensionless jerk
speed_metric = []; LDJ = []; SAL = [];
for count = 1:length(traj)
    % speed metric
    speed_metric(count) = peak_speed(count) / mean_speed(count);
    % LDJ
    jerk = diff(diff(traj_speed{count}*100));
    t = (1:length(traj_speed{count}))/((40*4)); t = t(2:end-1); % diff 
    LDJ(count) = -log( trapz(t,jerk.^2) * (t(end)-t(1))^3/(peak_speed(count)^2));
    % spectral arc length
    SAL(count) = SpectralArcLength(traj_speed{count}', 40*4);
end
for j = 1:(length(seqedge)-1)
    rr = (seqedge(j)+1) : (seqedge(j+1));
    jj = 2*(j-1)+1;
    speed_metric_all(jj,condition,rat) = mean(speed_metric(rr(1:nsamp)));
    speed_metric_all(jj+1,condition,rat) = mean(speed_metric(rr((end-nsamp+1):end)));
    LDJ_all(jj,condition,rat) = mean(LDJ(rr(1:nsamp)));
    LDJ_all(jj+1,condition,rat) = mean(LDJ(rr((end-nsamp+1):end)));
    SARCL_all(jj,condition,rat) = mean(SAL(rr(1:nsamp)));
    SARCL_all(jj+1,condition,rat) = mean(SAL(rr((end-nsamp+1):end)));
end

%% new 20220901
% -look at extents
% - this does not require any sorting, but do by lever order
% - i think the plot might be averaged over all extents in x and y

tapwin = -8:8; % 200 ms window at 40 hz
L1x=[]; L2x=[]; L3x=[];
L1y=[]; L2y=[]; L3y=[];
for count = 1:length(traj)
    val = traj{count};
    % pull out extent
    tap1 = val(tapon(1,count)+tapwin,:);
    tap2 = val(tapon(2,count)+tapwin,:);
    tap3 = val(tapon(3,count)+tapwin,:);
    % max extent in x direction (towards the levers)
    if strcmp(cam,'Master')
    L1x(count) = max(tap1(:,1)); L2x(count) = max(tap2(:,1)); L3x(count) = max(tap3(:,1));
    else
    L1x(count) = min(tap1(:,1)); L2x(count) = min(tap2(:,1)); L3x(count) = min(tap3(:,1));  
    end
    % min extent in y directino (towards top of box)
    L1y(count) = min(tap1(:,2)); L2y(count) = min(tap2(:,2)); L3y(count) = min(tap3(:,2));
end
extent_all{condition, rat} = [L1x; L1y; L2x; L2y; L3x; L3y];

% pull early and late extents
for j = 1:(length(seqedge)-1)
    rr = (seqedge(j)+1) : (seqedge(j+1));
    jj = 2*(j-1)+1;
    
    % dim is 3,2 (lever x dimension)
    extent_all_earlylate{jj, condition, rat} = [mean(L1x(rr(1:nsamp))), mean(L1y(rr(1:nsamp)));...
        mean(L2x(rr(1:nsamp))), mean(L2y(rr(1:nsamp))); mean(L3x(rr(1:nsamp))), mean(L3y(rr(1:nsamp)))];
    extent_all_earlylate{jj+1,condition,rat} = [mean(L1x(rr((end-nsamp+1):end))), mean(L1y(rr((end-nsamp+1):end)));...
        mean(L2x(rr((end-nsamp+1):end))), mean(L2y(rr((end-nsamp+1):end))); mean(L3x(rr((end-nsamp+1):end))), mean(L3y(rr((end-nsamp+1):end)))];
end

%% 1) trajectory examples...like kevin's paper..
 dotrajplots=1;
if dotrajplots
% FIGURES!!!
% figure out IPI to use?
% - across cued and WM?
% - need to do outside of this
    
N = 12; %8example trials 
c = linspace(.2,.8,N);
figure; ax1=[];
cbehuse = [.1,1,.1; 1,.1,.1; .1,.1,1];
cbehuse = [.3,.9157,.7784; 1,.1,.1; .1,.1,1];
for dim_use = 1:2
for j = 1:length(trajtemp)
ax1(j) = subplot(1,3,j); hold on;
    taxis = ((1:size(trajtemp{j,dim_use},2))-25)*1/40;
    k = round(size(trajtemp{j,dim_use},1)*1/4);
    ii = (1:N)+k;
    for i = 1:N
        % sample from distribution
        k = round(size(trajtemp{j,dim_use},1)*1/3);
        %k = round(size(trajtemp{j,dim_use},1)*1/2);
        %k = 150;
        % sample from particular time in the distribution
%         tapIPIuse = tapstemp{j}(3,:) - tapstemp{j}(1,:); 
%         assert(issorted(tapIPIuse));
%         [~,k] = min(abs(tapIPIuse - IPIval(j)));
        %k = 35;
       % k = size(trajtemp{j,dim_use},1)-N-2;
    %*    ki = ii(i);
        val = trajtemp{j,dim_use}(k+i,:);
    %*    val = trajtemp{j,dim_use}(ki,:);
        if dim_use==2; val = val + 300; end
       % if j == 1; val=trajtemp{j}(10+i,:); end
       % val = (val - nanmean(val))/nanstd(val);
       % plot(taxis(1:length(val)),val, 'Color',cbehuse(j,:)*c(i),'linewidth',2);
        plot(taxis(1:length(val)),val, 'Color',cbehuse(condition,:)*c(i),'linewidth',2);
    end
    xlim([taxis(1),taxis(sum(~isnan(val)))])
    xlim([-.6, 3]);
    xlabel('Time (seconds)'); ylabel('Position')
    title(all_titles{j});%ylim([-3,3])
    set(gca, 'YDir','reverse')

end
end
linkaxes(ax1,'xy');
%%%own script...





%%%
% - plot at lesion boundaries
% _ this isnt working..?
trajsamp_lastsess = {}; taptimes_lastsess = {}; % save for warping and plotting?
figure; hold on;
N = 8; c = linspace(.2,.8,N);
%N = 50;c = linspace(.2,.8,N);
%N = round(min(diff(seqedge))*1/10); c = linspace(.2,.8,N);

for j = 1:length(seqchange)
    % before
    subplot(3,2,(j-1)*2+1); hold on;
    % sample from the last session with > 20 trials?
    suse = [];  val = 10;
    while isempty(suse)
        try
            % pull random
           % suse = randsample(find(sessID==sessID(seqchange(j)-val)),N);
            % pull similar trial times?
            suse = find(sessID==sessID(seqchange(j)-val)); 
            % pull similar trial times over multiple sessions
            suse = find(ismember(sessID, sessID(seqchange(j)-10):-1:sessID(seqchange(j)-val)));
            trajsamp_lastsess{(j-1)*2+1} = traj(suse); taptimes_lastsess{(j-1)*2+1} = tapon(:,suse);
            ttt  = tapon(3,suse) - tapon(1,suse);
            [~,id] = sort(ttt); suse = suse(id(round(length(ttt)/2) + (1:N) - (round(N/2))));
        catch
            val = val+1;
        end
        if length(suse)<(N-1); val = val+1; suse = []; end
    end
    %suse = randsample(find(sessID==sessID(seqchange(j)-1)),N);
    tempxval = [inf,-inf];
    for s = 1:length(suse)
        val = traj{suse(s)};
        val = medfilt1(val,5); val = imgaussfilt(val,[1,eps]);
        % normalize val so not on same axis?
        val(:,1) = (val(:,1)-mean(val(:,1)))/(std(val(:,1)));
        val(:,2) = (val(:,2)-mean(val(:,2)))/(std(val(:,2))) + (max(val(:,1))+2);
        taxis = ((1:size(val,1))-25)*1/40;
        plot(taxis,val, 'Color',[1,1,1]*c(s),'linewidth',2);
        tempxval(1) = min(tempxval(1), taxis(1));
        tempxval(2) = max(tempxval(2), taxis(end));
    end
    xlim(tempxval);
    title('Pre');
    % after 
    subplot(3,2,(j-1)*2+2); hold on;
    %suse = randsample(find(sessID==sessID(seqchange(j)+1)),N);
    %suse = randsample(sessID((seqchange(j)+1):(seqchange(j)+1+50)),N);
    suse = [];  val = 1;
    while isempty(suse)
        try
            % - rewrite below line to include sessions from 1:val
            %suse = randsample(find(sessID==sessID(seqchange(j)+val)),N);
            %suse = randsample(find(ismember(sessID, sessID(seqchange(j)+1):sessID(seqchange(j)+val))),N);
            % pull similar trial times?
            %suse = find(sessID==sessID(seqchange(j)+val)); 
            suse = find(ismember(sessID, sessID(seqchange(j)+1):sessID(seqchange(j)+val)));
            trajsamp_lastsess{(j-1)*2+2} = traj(suse); taptimes_lastsess{(j-1)*2+2} = tapon(:,suse);
            ttt  = tapon(3,suse) - tapon(1,suse);
            [~,id] = sort(ttt); suse = suse(id(round(length(ttt)/2) + (1:N) - (round(N/2))));
        catch
            val = val+1;
        end
         if length(suse)<(N-1); val = val+1; suse = []; end
    end
    
    tempxval = [inf,-inf];
    for s = 1:length(suse)
        val = traj{suse(s)};
        val = medfilt1(val,5); val = imgaussfilt(val,[1,eps]);
        % normalize val so not on same axis?
        val(:,1) = (val(:,1)-mean(val(:,1)))/(std(val(:,1)));
        val(:,2) = (val(:,2)-mean(val(:,2)))/(std(val(:,2))) + (max(val(:,1))+2);
        taxis = ((1:size(val,1))-25)*1/40;
        plot(taxis,val, 'Color',[1,1,1]*c(s),'linewidth',2);
        tempxval(1) = min(tempxval(1), taxis(1));
        tempxval(2) = max(tempxval(2), taxis(end));
    end
    xlim(tempxval); title('Post')
end


% - plot means?
%   - risa took correlation of means...

%% - for before and after? or for 
% - need to get this cell
% - need to rerun above for a larger N?
trajsamp_lastsess_warp_x = {};trajsamp_lastsess_warp_y = {};
for t = 1:length(taptimes_lastsess)
    % get warplens?
    endlen = 10; uselen = round(median(diff(taptimes_lastsess{t})'));
    for trial = 1:size(trajsamp_lastsess{t},2)
        a = trajsamp_lastsess{t}{trial};
        a(isnan(a)) = [];
        % filter
        a = medfilt1(a,5); a = imgaussfilt(a,[1,eps]);
        % local linear warp
        tt = taptimes_lastsess{t}(:,trial);
        if (tt(3)-tt(2) < 3); tt(3) = tt(3) + 3; continue; end
        b = a(1:tt(1),:);
        b = [b; interp1(linspace(1,uselen(1),tt(2)-tt(1)), a(tt(1):(tt(2)-1),:), 1:uselen(1))];
        b = [b; interp1(linspace(1,uselen(2),tt(3)-tt(2)), a(tt(2):(tt(3)-1),:), 1:uselen(2))];
        b = [b; a(tt(3): (tt(3)+endlen),:)];
        a = b;
        
        trajsamp_lastsess_warp_x{t}(:,trial) = a(:,1);
        trajsamp_lastsess_warp_y{t}(:,trial) = a(:,2);
    end
    
end

curColor = 'grb'; curColor = curColor(condition);
trajsamp_lastsess_warp_x; trajsamp_lastsess_warp_y;
% figure; hold on;
% ax1=subplot(1,3,1); hold on; legendid = [];
% h = shadedErrorBar(((1:size(trajsamp_lastsess_warp_x{1},1))-25)*1/40,...
%     trajsamp_lastsess_warp_x{1}', {@mean, @(x) std(x)}, 'lineprops',{'k-','markerfacecolor','k'});
% h = shadedErrorBar(((1:size(trajsamp_lastsess_warp_y{1},1))-25)*1/40,...
%     trajsamp_lastsess_warp_y{1}', {@mean, @(x) std(x)}, 'lineprops',{'k-','markerfacecolor','k'});
% legendid(1) = h.patch;
% h = shadedErrorBar(((1:size(trajsamp_lastsess_warp_x{2},1))-25)*1/40,...
%     trajsamp_lastsess_warp_x{2}', {@mean, @(x) std(x)}, 'lineprops',{curColor,'markerfacecolor','k'});
% h = shadedErrorBar(((1:size(trajsamp_lastsess_warp_y{2},1))-25)*1/40,...
%     trajsamp_lastsess_warp_y{2}', {@mean, @(x) std(x)}, 'lineprops',{curColor,'markerfacecolor','k'});
% legendid(2) = h.patch;
% legend(legendid,{'Pre','Post'});
% ax2=subplot(1,3,2); hold on; legendid = [];
% h = shadedErrorBar(((1:size(trajsamp_lastsess_warp_x{3},1))-25)*1/40,...
%     trajsamp_lastsess_warp_x{3}', {@mean, @(x) std(x)}, 'lineprops',{'k-','markerfacecolor','k'});
% h = shadedErrorBar(((1:size(trajsamp_lastsess_warp_y{3},1))-25)*1/40,...
%     trajsamp_lastsess_warp_y{3}', {@mean, @(x) std(x)}, 'lineprops',{'k-','markerfacecolor','k'});
% legendid(1) = h.patch;
% h = shadedErrorBar(((1:size(trajsamp_lastsess_warp_x{4},1))-25)*1/40,...
%     trajsamp_lastsess_warp_x{4}', {@mean, @(x) std(x)}, 'lineprops',{curColor,'markerfacecolor','k'});
% h = shadedErrorBar(((1:size(trajsamp_lastsess_warp_y{4},1))-25)*1/40,...
%     trajsamp_lastsess_warp_y{4}', {@mean, @(x) std(x)}, 'lineprops',{curColor,'markerfacecolor','k'});
% ax3=subplot(1,3,3); hold on; legendid = [];
% h = shadedErrorBar(((1:size(trajsamp_lastsess_warp_x{5},1))-25)*1/40,...
%     trajsamp_lastsess_warp_x{5}', {@mean, @(x) std(x)}, 'lineprops',{'k-','markerfacecolor','k'});
% h = shadedErrorBar(((1:size(trajsamp_lastsess_warp_y{5},1))-25)*1/40,...
%     trajsamp_lastsess_warp_y{5}', {@mean, @(x) std(x)}, 'lineprops',{'k-','markerfacecolor','k'});
% legendid(1) = h.patch;
% h = shadedErrorBar(((1:size(trajsamp_lastsess_warp_x{6},1))-25)*1/40,...
%     trajsamp_lastsess_warp_x{6}', {@mean, @(x) std(x)}, 'lineprops',{curColor,'markerfacecolor','k'});
% h = shadedErrorBar(((1:size(trajsamp_lastsess_warp_y{6},1))-25)*1/40,...
%     trajsamp_lastsess_warp_y{6}', {@mean, @(x) std(x)}, 'lineprops',{curColor,'markerfacecolor','k'});
% 
% linkaxes([ax1,ax2,ax3],'xy')
% xlim([-.6,2.5])




end

%% 2) traj correlation coefficient
%  - save to do over rats?

% interpolate
trajtemp = trajtemp_mock;
tapstemp = tapstemp_mock;
%dolocal = 1;

% plot mean correlation
% warp 
interplen = 100;
interplen = round(median(tapon(3,:) - tapon(1,:))) + 2*round(median(tapon(1,:)));

uselen = round(median(diff(tapon)'))*2;
%uselen = [30, 54]; % rat j342
endlen = min(cellfun(@length, traj) - tapon(3,:));
endlen = 10;

% template tap times to warp to?
tap_interplen = [];
trajsamp = {};
for dim_use = 1:2
for t = 1:length(trajtemp)
    shuffid = randperm(size(trajtemp{t},1));
    %count = 1;
    for trial = 1:size(trajtemp{t},1)
        a = trajtemp{t,dim_use}(trial,:);
        a(isnan(a)) = [];
       
        % local linear warp
        if dolocal %contains(filepaths{f}, 'L3-Rat34') % what is this
        tt = tapstemp{t}(:,trial);
        % temp really bad fix...
        if length(a)-tt(3) < endlen
            tt(3) = length(a)-endlen-1;
        end
            
        % tt = tapstemp{t}(:,shuffid(trial)); % shuffled version?
        if (tt(3)-tt(2) < 3); tt(3) = tt(3) + 3; continue; end
        if (tt(2)-tt(1) < 3); continue; end
        b = a(1:tt(1));
        b = [b, interp1(linspace(1,uselen(1),tt(2)-tt(1)), a(tt(1):(tt(2)-1)), 1:uselen(1))];
        b = [b, interp1(linspace(1,uselen(2),tt(3)-tt(2)), a(tt(2):(tt(3)-1)), 1:uselen(2))];
        b = [b, a(tt(3): (tt(3)+endlen))];
        a = b;
        
        if toss_lever_taps
            a = trajtemp{t,dim_use}(trial,:);
            a(isnan(a)) = [];
            b = [interp1(linspace(1,uselen(1),tt(2)-tt(1)), a(tt(1):(tt(2)-1)), 1:uselen(1)),...
                interp1(linspace(1,uselen(2),tt(3)-tt(2)), a(tt(2):(tt(3)-1)), 1:uselen(2))];
            b = b(10:end-10); % 10 frames toss
            a = b;
        end
        
        else
        % global warp (is this right?)
        % - want to redo it to crop closer to lever? or to get a more
        % dynamic interplen?
        a = interp1(linspace(1,interplen,length(a)),a,1:interplen);
        
        end
        
        trajsamp{t,dim_use}(:,trial) = zeros(size(a));
        
        if any(isnan(a)); continue; end;
        if var(a)<1; continue; end
        
        trajsamp{t,dim_use}(:,trial) = a;
        %count = count+1;
    end
    trajsamp{t,dim_use} = trajsamp{t,dim_use}';
end % seqchange segment
end % dim use



% calculate correlations
% - need to do within? or across?
% lets try just within first
corrDist = {};
for j = 1:length(trajsamp)
% mean normalize
a1 = trajsamp{j,1}'; a2 = trajsamp{j,2}';
badid = find(sum(a1)<=10 | sum(a2)<=10); % ah if all zeros...
a1(:,badid) = []; a2(:,badid) = [];
a1 = (a1 - mean(a1))./std(a1);
a2 = (a2 - mean(a2))./std(a2);
C = corrcoef([a1;a2]);
corrDist{j} = squareform(C - eye(size(C)),'tovector');
end
%C=correlations (trial by trial between trajectories..)... how stereotyped
%movements are 
%%%5corrdist=euclidean distance vector between  C(corrcoef) -  (distance
%%%between) how correlated are trial by trial traj

corrDist_rat(:,rat,condition) = corrDist; %per rat correlations... 

% ok time to calculate correlations across...
%corrDist_across = {};
nedge = cellfun(@(v) size(v,1), trajsamp(:,1)); nedge = [0; cumsum(nedge)];
% mean normalize
a1 = vertcat(trajsamp{:,1})'; a2 = vertcat(trajsamp{:,2})';
badid = find(sum(a1)<=10 | sum(a2)<=10); 
a1(:,badid) = []; a2(:,badid) = [];
for jjj=length(badid):-1:1; nedge(nedge>=badid(jjj)) = nedge(nedge>=badid(jjj))-1; end
a1 = (a1 - mean(a1))./std(a1);
a2 = (a2 - mean(a2))./std(a2);
C = corrcoef([a1;a2]);
% which comparison to make?
% - say pre-lesion to post-bilateral lesion
c1 = C((nedge(2)+1):(nedge(2+1)),(nedge(4)+1):(nedge(4+1))); c1 = c1(:);
corrDist_across{rat,condition} = c1;


% ok correlations to means
a_mean = mean([a1(:,(nedge(2)+1):(nedge(2+1))); a2(:,(nedge(2)+1):(nedge(2+1)))],2);
C = corrcoef([a_mean, [a1;a2]]);
for jjj = 1:length(trajsamp)
    corrDist_mean{jjj,rat} = C(1,(nedge(jjj)+1):(nedge(jjj+1)));
end


%% plot warped samples
% if dotrajplots
%     
% if length(trajsamp)==4
% trajtemp_mock = trajsamp; trajsamp(1,:) = []; 
% tapstemp_mock = tapstemp; tapstemp(1) = []; 
% end
%     
%     N = 8;
% c = linspace(.3,.8,N);
% figure; ax1=[];
% cbehuse = [.1,1,.1; 1,.1,.1; .1,.1,1];
% cbehuse = ([58,117,175]+30)./255;% blue and orange
% %cbehuse = ([156,186,215])./255
% % orange
% cbehuse = ([239,134,54]+30)./255;
% %cbehuse = [247,194,154]./255;
% 
% for dim_use = 1:2
% for j = 1:length(trajsamp)
%     ax1(j) = subplot(1,3,j); hold on;
%     taxis = ((1:size(trajsamp{j,dim_use},2))-25)*1/40;
%     for i = 1:N
%         % sample from distribution
%         k = round(size(trajsamp{j,dim_use},1)*1/3.9);
%         % sample from particular time in the distribution
%        % tapIPIuse = tapstemp{j}(3,:) - tapstemp{j}(1,:); 
%        % assert(issorted(tapIPIuse));
%        % [~,k] = min(abs(tapIPIuse - IPIval(j)));
%         
%        % k = size(trajtemp{j,dim_use},1)-N-2;
%         val = trajsamp{j,dim_use}(k+i,:);
%         if dim_use==2; val = val + 300; end
%        % if j == 1; val=trajtemp{j}(10+i,:); end
%        % val = (val - nanmean(val))/nanstd(val);
%        % plot(taxis(1:length(val)),val, 'Color',cbehuse(j,:)*c(i),'linewidth',2);
%         plot(taxis(1:length(val)),val, 'Color',cbehuse(condition,:)*c(i),'linewidth',2);
%     end
%     xlim([taxis(1),taxis(sum(~isnan(val)))])
%     xlim([-.6, 3]);
%     xlabel('Time (seconds)'); ylabel('Position')
%     title(all_titles{j});%ylim([-3,3])
%     set(gca, 'YDir','reverse')
% 
% end
% end
% linkaxes(ax1,'xy');
% 
% end

end % over rats
end % over context

%% plot without prelesion, on one figure, with significance values
% DMS e4-122 has a drop in correlatoni
 % this is due to some weird timing issue and very very few trials tracked
 % post lesion. not sure how I will fix this timing issue
 % - still happening post trying to scan for larger range?
 % - by eye, she definitely recalls the sequence and is definitely
 % perfomrning it similarly following the DMS lesion. so idk what exactly
 % is going on with the syncing code that won't let me look at this super
 % cleanly

%tossrats = [1,5]; %?
%tossrats = [3,5]; % DLS, E1 and J1
%tossrats = [4, 6,10,11,12]; % MC OT only
%tossrats = [1,2]; % MC use, f4, j3
%tossrats = [3]; % OT only
%tossrats = [5,6];
%tossrats=  [];%
tossrats = [7];% dls new 
%tossrats = [5]; % dms new
tossrats=  [];

val = cellfun(@median, corrDist_rat); %val is correlation matrix computed in contexts..  (condition) x rat x context (curContext)
%so in 3-d, val  matrix 1 =ot and val matrix2=cued 
%then in each matrix, rows=4 conditions which i dont know what are!!
%the columns are rats... here 3 rat so 3 columns..


%1) with across (which is pre to post bilateral
val = cellfun(@median, corrDist_rat); %this val is correlation matrix computed in contexts..  (condition) x rat x context (curContext)
val2 = cellfun(@median, corrDist_across); %ratx2 condition (ot, cue)
val(3,:,:) = val(4,:,:); % replace unilateral with bilateral
val(4,:,:) = val2; % replace bilateral with across


%2) just plot pre uni bi
val = cellfun(@median, corrDist_rat); % (condition) x rat x context (curContext)
% for full task
%3) try mock, uni, bi
% % val(3,:,:) = val(2,:,:);
% % val(2,:,:) = val(1,:,:);
figure; hold on;
%context2
%cued
bar(1, mean(val(1,:,1)),'FaceColor',[1,.2,.2]);
bar(2, mean(val(4,:,1)),'FaceColor',[1,.4,.4]);
bar(4, mean(val(1,:,2)),'FaceColor',[.2,.2,1]);
bar(5, mean(val(4,:,2)),'FaceColor',[.4,.4,1]);
hold on 
ylim ([0 1])
hold on 
for rat = 1:(length(fpath_rat))
       plot(1:2, val([1,4],rat,1),'Color',[.4,.4,.4]);
          plot(4:5, val([1,4],rat,2),'Color',[.4,.4,.4]);
%     plot(9:11, val(2:4,rat,1),'Color',[0,0,0,.4]);
end


%%compare correlaions pre annd post
% for ot only...
figure;
hold on
bar(1,mean(val(3,:),2),'FaceColor',[1,.2,.2]);
bar(2,mean(val(4,:),2),'FaceColor',[1,.4,.4]);
hold on 
ylim([0 1])
hold on 
for rat = 1:(length(fpath_rat))
       plot(1:2, val([2,4],rat),'Color',[.4,.4,.4]);        
end

% bar(9, mean(val(2,:,1),2),'FaceColor',[.2,1,.2]);
% bar(10, mean(val(3,:,1),2),'FaceColor',[.4,1,.4]);
% bar(11, mean(val(4,:,1),2),'FaceColor',[.7,1,.7]);
% 
% n = size(val,2);
% errorbar(1:3, mean(val(2:4,:,2),2),...
%     std(val(2:4,:,2),[],2)./sqrt(n),'k.','linewidth',2);
% errorbar(5:7, mean(val(2:4,:,3),2),...
%     std(val(2:4,:,3),[],2)./sqrt(n),'k.','linewidth',2);
% errorbar(9:11, mean(val(2:4,:,1),2),...
%     std(val(2:4,:,1),[],2)./sqrt(n),'k.','linewidth',2);
hold on 
% plot individual rats
for rat = 1:(length(fpath_rat))
       plot(1:2, val([2,4],rat,1),'Color',[.4,.4,.4]);
          plot(4:5, val([2,4],rat,2),'Color',[.4,.4,.4]);
%     plot(9:11, val(2:4,rat,1),'Color',[0,0,0,.4]);
end


[~,ppreunicued] = ttest(val(2,:,2), val(3,:,2));
[~,pprebicued] =  ttest(val(2,:,2), val(4,:,2));
[~,ppreuniwm] = ttest(val(2,:,3), val(3,:,3));
[~,pprebiwm] =  ttest(val(2,:,3), val(4,:,3));
[~,ppreuniot] = ttest(val(2,:,1), val(3,:,1));
[~,pprebiot] =  ttest(val(2,:,1), val(4,:,1));


ppreunicued = signrank(val(2,:,2), val(3,:,2));
pprebicued =  signrank(val(2,:,2), val(4,:,2));
ppreuniwm = signrank(val(2,:,3), val(3,:,3));
pprebiwm =  signrank(val(2,:,3), val(4,:,3));
ppreuniot = signrank(val(2,:,1), val(3,:,1));
pprebiot =  signrank(val(2,:,1), val(4,:,1));

sigstar({[1,2],[1,3],[5,6],[5,7],[9,10],[9,11]},...
    [ppreunicued,pprebicued,ppreuniwm,pprebiwm,ppreuniot,pprebiot],0,1);
% only ot
% sigstar({[9,10],[9,11]},...
%     [ppreuniot,pprebiot]);

% im not testing the thign i want to be testing
[~,p23] = ttest(val(3,:,2), val(4,:,2));
[~,p67] = ttest(val(3,:,3), val(4,:,3));
[~,p1011] = ttest(val(3,:,1), val(4,:,1));
% 
[p23] = signrank(val(3,:,2), val(4,:,2));
[p67] = signrank(val(3,:,3), val(4,:,3));
[p1011] = signrank(val(3,:,1), val(4,:,1));
sigstar({[2,3],[6,7],[10,11]},[p23,p67,p1011],0,1);

xticks([2,6,10]); ylim([0,1])
xticklabels({'Cued','WM','OT'});

%% make speed plot
figure; hold on;

tossrats = 8; % l5
%tossrats = [];
tossrats=  5;

val = cellfun(@mean, mean_speed_all_earlylate([4,7],:,:));

% mock?
val = cellfun(@mean, mean_speed_all_earlylate([2,4],:,:));


% val = cellfun(@mean, mean_speed_all_earlylate_MC([4,7],:,:));
%val = cellfun(@mean, frac_stop_all_earlylate_DLS([4,7],:,:));
% 
%val = cellfun(@mean, frac_stop_all_earlylate([4,7],:,:));

% val = cellfun(@mean, peak_speed_all_earlylate([4,7],:,:));

val(:,:,tossrats) = [];


val_ot = squeeze(val(:,1,:));
val_cued = squeeze(val(:,2,:));
% val_wm = squeeze(val(:,3,:));
figure(1)
bar(1, mean(val_cued(1,:)),'FaceColor',[1,.2,.2]);
bar(2, mean(val_cued(2,:)),'FaceColor',[1,.7,.7]);

% bar(4, mean(val_wm(1,:)),'FaceColor',[.2,.2,1]);
% bar(5, mean(val_wm(2,:)),'FaceColor',[.7,.7,1]);

bar(4, mean(val_ot(1,:)),'FaceColor',[.2,1,.2]);
bar(5, mean(val_ot(2,:)),'FaceColor',[.7,1,.7]);

% plot individual rats and p-values
for rat = 1:size(val_ot,2)
    plot(1:2, val_cued(:,rat),'Color',[.4,.4,.4]);
%     plot(4:5, val_wm(:,rat),'Color',[.4,.4,.4]);
    plot(4:5, val_ot(:,rat),'Color',[.4,.4,.4]);
end

% sig test
[~,pcue] = ttest(val_cued(1,:), val_cued(2,:));
[~,pwm] = ttest(val_wm(1,:), val_wm(2,:));
[~,pot] = ttest(val_ot(1,:), val_ot(2,:));

[pcue] = signrank(val_cued(1,:), val_cued(2,:));
[pwm] = signrank(val_wm(1,:), val_wm(2,:));
[pot] = signrank(val_ot(1,:), val_ot(2,:));
sigstar({[1,2],[4,5],[7,8]},[pcue,pwm,pot],0,1);

%% a better fraction stop plots

condition = 1; rat = 1;
figure;histogram(traj_speed_all{condition,rat});

val = traj_speed_all_earlylate([4,7],:,:);
thresh = 0.005; % super arbitrary??

val = cellfun(@(v) sum(v<thresh)/length(v),val);


%% plot of smoothness metric and log dimensionless jerk
%https://jneuroengrehab.biomedcentral.com/articles/10.1186/s12984-015-0090-9
%https://www.frontiersin.org/articles/10.3389/fneur.2018.00615/full#B8

tossrats = [8];
tossrats = [];
%LDJ_all = []; speed_metric_all = []; SARCL_all = [];
% (early, premock, post mock, preuni, post uni, prebi, postbi, late) x (OT,
% cued, WM) x rat
val = LDJ_all([4,7],:,:); % pre uni, post bi
%val = speed_metric_all([4,7],:,:);
%val = SARCL_all([4,7],:,:);
dosave = 1;

% frac stop
% val = traj_speed_all_earlylate([4,7],:,:);

% thresh = 0.02; % super arbitrary??
% val = cellfun(@(v) sum(v<thresh)/length(v),val);
% dosave = 1;

val(:,:,tossrats) = [];

val_ot = squeeze(val(:,1,:));
val_cued = squeeze(val(:,2,:));
% val_wm = squeeze(val(:,3,r:));


figure; hold on;

b1=bar(1, mean(val_cued(1,:)),'FaceColor',[1,.2,.2]);
bar(2, mean(val_cued(2,:)),'FaceColor',[1,.4,.4]);
% b2=bar(3, mean(val_wm(1,:)),'FaceColor',[.2,.2,1]);
% bar(4, mean(val_wm(2,:)),'FaceColor',[.4,.4,1]);
b3=bar(5, mean(val_ot(1,:)),'FaceColor',[.2,1,.2]);
bar(6, mean(val_ot(2,:)),'FaceColor',[.4,1,.4]);
for rat = 1:length(val_cued)
    plot(1:2, val_cued(:,rat),'Color',[0,0,0,.3]);
%     plot(3:4, val_wm(:,rat),'Color',[0,0,0,.3]);
    plot(5:6, val_ot(:,rat),'Color',[0,0,0,.3]);
end
% [~,pcued] = ttest(val_cued(1,:), val_cued(2,:),'tail','right');
% [~,pwm] = ttest(val_wm(1,:), val_wm(2,:),'tail','right');
% [~,pot] = ttest(val_ot(1,:), val_ot(2,:),'tail','right');
% [~,pcuedwm] = ttest(val_cued(1,:), val_wm(1,:),'tail','right');
% [~,pcuedot] = ttest(val_cued(1,:), val_ot(1,:),'tail','right');
% [~,pwmot] = ttest(val_wm(1,:), val_ot(1,:),'tail','right');
% [~,pcued] = ttest(val_cued(1,:), val_cued(2,:));
% [~,pwm] = ttest(val_wm(1,:), val_wm(2,:));
% [~,pot] = ttest(val_ot(1,:), val_ot(2,:));
% [~,pcuedwm] = ttest(val_cued(1,:), val_wm(1,:));
% [~,pcuedot] = ttest(val_cued(1,:), val_ot(1,:));
% [~,pwmot] = ttest(val_wm(1,:), val_ot(1,:));
% [~,pcued] = ttest(val_cued(1,:), val_cued(2,:),'tail','left');
% [~,pwm] = ttest(val_wm(1,:), val_wm(2,:),'tail','left');
% [~,pot] = ttest(val_ot(1,:), val_ot(2,:),'tail','left');

[~,pcued] = ttest(val_cued(1,:), val_cued(2,:));
% [~,pwm] = ttest(val_wm(1,:), val_wm(2,:));
[~,pot] = ttest(val_ot(1,:), val_ot(2,:));

[pcued] = signrank(val_cued(1,:), val_cued(2,:));
% [pwm] = signrank(val_wm(1,:), val_wm(2,:));
[pot] = signrank(val_ot(1,:), val_ot(2,:));

% sigstar({[1,2],[5,6]},...
%     [pcued,pot],0,1);
% sigstar({[1,3],[3,5],[1,5]},...
%     [pcuedwm,pwmot,pcuedot],0,1);
ylabel('NLDJ');
%ylabel('SARCL');
%ylabel('Speed metric');
%ylabel(['Fraction stopped' ' thresh: ' num2str(thresh)]);
title('Trajectory smoothness')
xticks(1:6); xticklabels({'Pre','Post','Pre','Post','Pre','Post'});
legend([b1,b3],{'Cued','OT'});
%savepath = 'D:\Kevin\Sequence_tap_analysis\basic_beh_analysis_new\trained_dls_lesion\accuracy_725_newrats_F5\metrics_wilcoxon\';
% savepath = 'D:\Kevin\Sequence_tap_analysis\basic_beh_analysis_new\trained_dms_lesions\6rats_new_noe5\';
if dosave
    saveas(gcf,fullfile(savepath, ['NLDJ.png']));
    saveas(gcf,fullfile(savepath, ['NLDJ.svg']));
    saveas(gcf,fullfile(savepath, ['NLDJ.fig']));
end

%% smoothness OT only
val = LDJ_all([4,7],:,:); % pre uni, post bi
%val = speed_metric_all([4,7],:,:);
%val = SARCL_all([4,7],:,:);

val_ot = squeeze(val(:,1,:));


figure; hold on;

b3=bar(5, mean(val_ot(1,:)),'FaceColor',[.2,1,.2]);
bar(6, mean(val_ot(2,:)),'FaceColor',[.4,1,.4]);
for rat = 1:length(fpath_rat)
    plot(5:6, val_ot(:,rat),'Color',[0,0,0,.3]);
end
[~,pot] = ttest(val_ot(1,:), val_ot(2,:),'tail','right');
sigstar({[5,6]},[pot],0,1);
ylabel('NLDJ');
%ylabel('SARCL');
%ylabel('Speed metric');
title('Trajectory smoothness')
xticks(1:6); xticklabels({'Pre','Post','Pre','Post','Pre','Post'});
legend([b3],{'OT'});


%% speed plot with recovery?

val = cellfun(@mean, mean_speed_all_earlylate([4,7,8],:,:));
%val = cellfun(@mean, peak_speed_all_earlylate([4,7,8],:,:));
%val = cellfun(@mean, frac_stop_all_earlylate([4,7,8],:,:));

% plot speed but for early
% [early mock, late mock, postmock, preuni, postuni, prebi, postbi, late]
%val = cellfun(@mean, mean_speed_all_earlylate([2,3,4],:,:));
%val = cellfun(@mean, peak_speed_all_earlylate([2,3,4],:,:));

%tossrats = 3; val(:,:,tossrats) = [];



val_ot = squeeze(val(:,1,:));
val_cued = squeeze(val(:,2,:));
val_wm = squeeze(val(:,3,:));

figure; hold on;

bar(1, mean(val_cued(1,:)),'FaceColor',[1,.2,.2]);
bar(2, mean(val_cued(2,:)),'FaceColor',[1,.4,.4]);
bar(3, mean(val_cued(3,:)),'FaceColor',[1,.7,.7]);

bar(5, mean(val_wm(1,:)),'FaceColor',[.2,.2,1]);
bar(6, mean(val_wm(2,:)),'FaceColor',[.4,.4,1]);
bar(7, mean(val_wm(3,:)),'FaceColor',[.7,.7,1]);

bar(9, mean(val_ot(1,:)),'FaceColor',[.2,1,.2]);
bar(10, mean(val_ot(2,:)),'FaceColor',[.4,1,.4]);
bar(11, mean(val_ot(3,:)),'FaceColor',[.7,1,.7]);

for rat = 1:length(fpath_rat)
    plot(1:3, val_cued(:,rat),'Color',[0,0,0,.3]);
    plot(5:7, val_wm(:,rat),'Color',[0,0,0,.3]);
    plot(9:11, val_ot(:,rat),'Color',[0,0,0,.3]);
end

% pvals
[~,ppreunicued] = ttest(val_cued(1,:), val_cued(2,:),'tail','right');
[~,pprebicued] =  ttest(val_cued(1,:), val_cued(3,:),'tail','right');
[~,ppreuniwm] = ttest(val_wm(1,:), val_wm(2,:),'tail','right');
[~,pprebiwm] =  ttest(val_wm(1,:), val_wm(3,:),'tail','right');
[~,ppreuniot] = ttest(val_ot(1,:), val_ot(2,:),'tail','right');
[~,pprebiot] =  ttest(val_ot(1,:), val_ot(3,:),'tail','right');

sigstar({[1,2],[1,3],[5,6],[5,7],[9,10],[9,11]},...
    [ppreunicued,pprebicued,ppreuniwm,pprebiwm,ppreuniot,pprebiot],0,1);

%% ot only speed plot
val = cellfun(@mean, mean_speed_all_earlylate([4,7,8],:,:));
val_ot = squeeze(val(:,1,:));
figure; hold on;
bar(9, mean(val_ot(1,:)),'FaceColor',[.2,1,.2]);
bar(10, mean(val_ot(2,:)),'FaceColor',[.4,1,.4]);
bar(11, mean(val_ot(3,:)),'FaceColor',[.7,1,.7]);

for rat = 1:length(fpath_rat)
    if contains(ratPath{rat},'J3-Rat88') || contains(ratPath{rat},'L5-Rat95')
    plot(9:11, val_ot(:,rat),'Color',[1,0,0,.3]);
    else
    plot(9:11, val_ot(:,rat),'Color',[0,0,0,.3]);
    end
end
[~,ppreuniot] = ttest(val_ot(1,:), val_ot(2,:),'tail','right');
[~,pprebiot] =  ttest(val_ot(1,:), val_ot(3,:),'tail','right');
sigstar({[9,10],[9,11]},...
    [ppreuniot,pprebiot],0,1);

%% save

val = [cellfun(@median, corrDist_rat(2,:));cellfun(@median, corrDist_rat(4,:));  cellfun(@median, corrDist_across)' ]; 

val_OT = val;
corrDist_rat_OT = corrDist_rat;
corrDist_across_OT = corrDist_across;

val_MC = val;
corrDist_rat_MC = corrDist_rat;
corrDist_across_MC = corrDist_across;



%% correlation plot, OT only, pre-post-across
val = [cellfun(@median, corrDist_rat(2,:));cellfun(@median, corrDist_rat(4,:));  cellfun(@median, corrDist_across)' ]; 

figure; hold on;
bar([1:3],[mean(val(1,:)), mean(val(2,:)),mean(val(3,:))],'FaceColor',[.4,.8,.4]);
for rat = 1:size(val,2)
    if contains(ratPath{rat},'J3-Rat88') || contains(ratPath{rat},'L5-Rat95')
    plot(1:3, val(1:3,rat),'Color',[1,0,0,.5]);
    else
        plot(1:3, val(1:3,rat),'Color',[0,0,0,.5]);
    end
end
[~,pprepost] = ttest(val(1,:), val(2,:));
[~,ppreacross] = ttest(val(1,:), val(3,:));
[~,ppostacross] = ttest(val(2,:), val(3,:));
sigstar({[1,2],[1,3],[2,3]},[pprepost,ppreacross,ppostacross]);


%% OT and full

figure; hold on;


val = [cellfun(@median, corrDist_rat_MC(2,:));cellfun(@median, corrDist_rat_MC(4,:));  cellfun(@median, corrDist_across_MC)' ]; 

bar([1:3],[mean(val(1,:)), mean(val(2,:)),mean(val(3,:))],'FaceColor',[.4,.8,.4]);
for rat = 1:size(val,2)
    plot(1:3, val(1:3,rat),'Color',[.6,.6,.6]);
end

[~,pprepost] = ttest(val(1,:), val(2,:));
[~,ppreacross] = ttest(val(1,:), val(3,:));
[~,ppostacross] = ttest(val(2,:), val(3,:));
sigstar({[1,2],[1,3],[2,3]},[pprepost,ppreacross,ppostacross]);

valMC = val;

val = [cellfun(@median, corrDist_rat_OT(2,:));cellfun(@median, corrDist_rat_OT(4,:));  cellfun(@median, corrDist_across_OT)' ]; 

bar([4:6],[mean(val(1,:)), mean(val(2,:)),mean(val(3,:))],'FaceColor',[.4,.8,.4]);
for rat = 1:size(val,2)
    plot(4:6, val(1:3,rat),'Color',[.6,.6,.6]);
end

[~,pprepost] = ttest(val(1,:), val(2,:));
[~,ppreacross] = ttest(val(1,:), val(3,:));
[~,ppostacross] = ttest(val(2,:), val(3,:));
sigstar({[4,5],[4,6],[5,6]},[pprepost,ppreacross,ppostacross]);
valOT = val;

xlim([0,7]);

% more sigtests
[~,ppre] = ttest2(valMC(1,:), valOT(1,:));
[~,ppost] = ttest2(valMC(2,:), valOT(2,:));
[~,pcross] = ttest2(valMC(3,:), valOT(3,:));
sigstar({[1,4],[2,5],[3,6]},[ppre,ppost,pcross]);
%% steffen just made histogram plots
figure; hold on;

cpre = [corrDist_rat_MC{2,:}];
cpost = [corrDist_rat_MC{4,:}];
subplot(1,2,1); hold on;
histogram(cpre, -1:.01:1, 'Normalization','probability');
histogram(cpost, -1:.01:1, 'Normalization','probability');
cpre = [corrDist_rat_OT{2,:}];
cpost = [corrDist_rat_OT{4,:}];
subplot(1,2,2); hold on;
histogram(cpre, -1:.01:1, 'Normalization','probability');
histogram(cpost, -1:.01:1, 'Normalization','probability');

%% plot OT to full

val_MC = [cellfun(@median, corrDist_rat_MC(2,:));cellfun(@median, corrDist_rat_MC(4,:));  cellfun(@median, corrDist_across_MC)' ]; 
val_OT = [cellfun(@median, corrDist_rat_OT(2,:));cellfun(@median, corrDist_rat_OT(4,:));  cellfun(@median, corrDist_across_OT)' ]; 



% val_MC = [cellfun(@median, corrDist_mean_MC(2,:));cellfun(@median, corrDist_mean_MC(4,:));  cellfun(@median, corrDist_mean_MC(4,:));]; 
% val_OT = [cellfun(@median, corrDist_mean_OT(2,:));cellfun(@median, corrDist_mean_OT(4,:));  cellfun(@median, corrDist_mean_OT(4,:));  ]; 


figure; hold on;

% full
bar([1,2],[mean(val_MC(1,:)), mean(val_MC(2,:))],'FaceColor',[.4,.8,.4]);
for rat = 1:size(val_MC,2)
    plot(1:2, val_MC(1:2,rat),'Color',[.6,.6,.6]);
end
bar([3,4],[mean(val_OT(1,:)), mean(val_OT(2,:))],'FaceColor',[.4,.8,.4]);
for rat = 1:size(val_OT,2)
    plot(3:4, val_OT(1:2,rat),'Color',[.6,.6,.6]);
end

[~,pprepostMC] = ttest(val_MC(1,:), val_MC(2,:));
[~,pprepostOT] = ttest(val_OT(1,:), val_OT(2,:));
[~,ppreMCOT] = ttest2(val_MC(1,:), val_OT(1,:));
[~,ppostMCOT] = ttest2(val_MC(2,:), val_OT(2,:));
sigstar({[1,2],[3,4],[1,3],[2,4]},[pprepostMC,pprepostOT,ppreMCOT,ppostMCOT]);

%% make plot all

val = cellfun(@median, corrDist_rat);

figure; hold on;
% cued
bar(1:4, mean(val(:,:,2),2),'FaceColor',[1,.4,.4]);
for rat = 1:length(fpath_rat)
    plot(1:4, val(:,rat,2),'Color',[0,0,0,.3]);
end
% wm
bar(6:9, mean(val(:,:,3),2),'FaceColor',[.4,.4,1]);
for rat = 1:length(fpath_rat)
    plot(6:9, val(:,rat,3),'Color',[0,0,0,.3]);
end
% ot
bar(11:14, mean(val(:,:,1),2),'FaceColor',[.4,1,.4]);
for rat = 1:length(fpath_rat)
    plot(11:14, val(:,rat,1),'Color',[0,0,0,.3]);
end

%% better to just show as histogram of trial-trial correlations?
% - also want to show accross?? not just within?



%% plot trajectories only after 

tossrats = [3,5]; % DLS, E1 and J1
%tossrats = [4, 6,10,11,12]; % MC OT only
tossrats = [1,2]; % MC use, f4, j3
%tossrats = [3]; % OT only
tossrats = [];
%tossrats = [3,6];


val = cellfun(@median, corrDist_rat); % (condition) x rat x context (curContext)
val(:,tossrats,:) = [];

figure; hold on;

bar(1, mean(val(2,:,2),2),'FaceColor',[1,.2,.2]);
bar(2, mean(val(4,:,2),2),'FaceColor',[1,.7,.7]);

bar(4, mean(val(2,:,3),2),'FaceColor',[.2,.2,1]);
bar(5, mean(val(4,:,3),2),'FaceColor',[.7,.7,1]);

bar(7, mean(val(2,:,1),2),'FaceColor',[.2,1,.2]);
bar(8, mean(val(4,:,1),2),'FaceColor',[.7,1,.7]);

n = size(val,2);
errorbar(1:2, mean(val([2,4],:,2),2),...
    std(val([2,4],:,2),[],2)./sqrt(n),'k.','linewidth',2);
errorbar(4:5, mean(val([2,4],:,3),2),...
    std(val([2,4],:,3),[],2)./sqrt(n),'k.','linewidth',2);
errorbar(7:8, mean(val([2,4],:,1),2),...
    std(val([2,4],:,1),[],2)./sqrt(n),'k.','linewidth',2);


[~,pprebicued] =  ttest(val(2,:,2), val(4,:,2));
[~,pprebiwm] =  ttest(val(2,:,3), val(4,:,3));
[~,pprebiot] =  ttest(val(2,:,1), val(4,:,1));


% ppreunicued = signrank(val(2,:,2), val(3,:,2));
% pprebicued =  signrank(val(2,:,2), val(4,:,2));
% ppreuniwm = signrank(val(2,:,3), val(3,:,3));
% pprebiwm =  signrank(val(2,:,3), val(4,:,3));
% ppreuniot = signrank(val(2,:,1), val(3,:,1));
% pprebiot =  signrank(val(2,:,1), val(4,:,1));

sigstar({[1,2],[4,5],[7,8]},...
    [pprebicued,pprebiwm,pprebiot]);

xticks([2,6,10]); ylim([0,1])
xticklabels({'Cued','WM','OT'});

%% OT only only right after, with signficance values

tossrats = [3];
val = cellfun(@median, corrDist_rat); % (condition) x rat x context (curContext)
val(:,tossrats,:) = [];

figure; hold on;
bar(7, mean(val(2,:),2),'FaceColor',[.2,1,.2]);
bar(8, mean(val(4,:),2),'FaceColor',[.7,1,.7]);
n = size(val,2);
errorbar(7:8, mean(val([2,4],:),2),...
    std(val([2,4],:),[],2)./sqrt(n),'k.','linewidth',2);
bar(1, 1,'FaceColor',[1,.2,.2]);
[~,pprebi] =  ttest(val(2,:), val(4,:));


sigstar({[7,8]},...
    [pprebi]);


%% make plot OT rat one context
% - do I need to do this early vs. late??
%  - that'll be a pain, but probably since I did it with the other ones...

val = cellfun(@median, corrDist_rat);

figure; hold on;
bar(1:4, mean(val,2), 'FaceColor',[.4,1,.4]);
for rat = 1:length(fpath_rat)
    plot(1:4, val(:,rat), 'Color',[0,0,0,.3]);
end
xticks(1:4);
xticklabels({'Pre','Mock','Uni','Bi'});
ylim([0,1])

%% make OT only plot significance and errorbars SEM

%% save

corrDist_rat_OT = corrDist_rat;
corrDist_rat_MC = corrDist_rat;

%% plot change in extent real
% - need to use camera to get x-direction
% - if change is positive or negative
% - also need to get mapping from pixels to mm for each box each lever
% - so use lever, use box to map to mm
% - with just pixels, change in extent looks not significantly different

% to convert to cm

% load('D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\lever_2_cm_left.mat');
% pix_2_mm_scaled

for rat = 1:size(extent_all_earlylate,3)
    % compute mean distance in pixels between endpoint locations
    val_preuni = extent_all_earlylate{4, 2, rat}; % 2 = cued
    val_postbi = extent_all_earlylate{7, 2, rat};
    delx = []; dely = [];
    for luse = 1:3
        % the sign of delx should depend on the camera angle!!
        if strcmp(cam_rat{rat},'Master')
        delx(luse) = -(val_preuni(luse,1) - val_postbi(luse,1));
        else
        delx(luse) = (val_preuni(luse,1) - val_postbi(luse,1));
        end
        dely(luse) = (val_preuni(luse,2) - val_postbi(luse,2));
    end
    % scale delx and del y to cm
    
    valCuedx(rat) = mean(delx); valCuedy(rat) = mean(dely);
    
end

%% plot change in extent
% * one rat camera got bumpd, so exclude

% - will have be in pixels, but potentially could calibrate each box and
% each lever...

%extent_all{condition, rat} = [L1x; L1y; L2x; L2y; L3x; L3y];

% look at single levers? for one rat

rat = 3; luse = 3; dim = 1;
figure; hold on;
jj = 2*(luse-1)+dim;
histogram(extent_all{1,rat}(jj,:),'Normalization','probability'); % l1x
histogram(extent_all{2,rat}(jj,:),'Normalization','probability');
histogram(extent_all{3,rat}(jj,:),'Normalization','probability');

% just look at mean vals
a = cellfun(@(v) mean(v,2), extent_all, 'un', 0);
a{1,rat};
a{3,rat};

% look for early vs. late

% calculate change in extent per lever, then average over all levers!
% - yeah this way can account for difference in camera position
% - count as the euclidean distance in the mean?
for rat = 1:length(extent_all)
    
end

% - could use mahalanobis distance...but will go with euclidean for now...


% plot extent_all_earlylate (early late condition x mode x rat)
% - 4 is pre uni, 7 is post bi
% dim is 3,2 (lever 1, lever 2, lever 3  X  dimension x, dimension y)
% - to compare across rats fairly, need to convert to mm
rat = 1; 
valCuedx = []; valWMx = []; valOTx = [];
valCuedy = []; valWMy = []; valOTy = [];
for rat = 1:size(extent_all_earlylate,3)
    % CUE
    val_preuni = extent_all_earlylate{4, 2, rat}; % 2 = cued
    val_postbi = extent_all_earlylate{7, 2, rat};
    delx = []; dely = [];
    scale_temp = [];
    for luse = 1:3
        % the sign of delx should depend on the camera angle!!
        if strcmp(cam_rat{rat},'Master')
        delx(luse) = -(val_preuni(luse,1) - val_postbi(luse,1));
        load('D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\lever_2_cm_right.mat');
        else
        delx(luse) = (val_preuni(luse,1) - val_postbi(luse,1));
        load('D:\Kevin\Sequence_tap_analysis\basic_beh_traj_analysis\lever_2_cm_left.mat');
        end
        dely(luse) = (val_preuni(luse,2) - val_postbi(luse,2));
        % get scale setup
        vid_label_scaled = cellfun(@(v) v(1), vid_label_scaled,'un',0);
        scale_temp(luse) = pix_2_mm_scaled(contains(vid_label_scaled, lever_rat{rat}{1}(luse)));
    end
    % scale
    delx = delx .* (1./scale_temp); dely = dely .* (1./scale_temp);
    valCuedx(rat) = mean(delx); valCuedy(rat) = mean(dely);
    % WM
    val_preuni = extent_all_earlylate{4, 3, rat}; % 3 = WM
    val_postbi = extent_all_earlylate{7, 3, rat};
    delx = []; dely = [];
    scale_temp = [];
    for luse = 1:3
        % the sign of delx should depend on the camera angle!!
        if strcmp(cam_rat{rat},'Master')
        delx(luse) = -(val_preuni(luse,1) - val_postbi(luse,1));
        else
        delx(luse) = (val_preuni(luse,1) - val_postbi(luse,1));
        end
        dely(luse) = (val_preuni(luse,2) - val_postbi(luse,2));
        % get scale setup
        vid_label_scaled = cellfun(@(v) v(1), vid_label_scaled,'un',0);
        scale_temp(luse) = pix_2_mm_scaled(contains(vid_label_scaled, lever_rat{rat}{1}(luse)));
    end
    % scale
    delx = delx .* (1./scale_temp); dely = dely .* (1./scale_temp);
    valWMx(rat) = mean(delx); valWMy(rat) = mean(dely);
    % OT
    val_preuni = extent_all_earlylate{4, 1, rat}; % 1 = OT
    val_postbi = extent_all_earlylate{7, 1, rat};
    delx = []; dely = [];
    scale_temp = [];
    for luse = 1:3
        % the sign of delx should depend on the camera angle!!
        if strcmp(cam_rat{rat},'Master')
        delx(luse) = -(val_preuni(luse,1) - val_postbi(luse,1));
        else
        delx(luse) = (val_preuni(luse,1) - val_postbi(luse,1));
        end
        dely(luse) = (val_preuni(luse,2) - val_postbi(luse,2));
        % get scale setup
        vid_label_scaled = cellfun(@(v) v(1), vid_label_scaled,'un',0);
        scale_temp(luse) = pix_2_mm_scaled(contains(vid_label_scaled, lever_rat{rat}{1}(luse)));
    end
    % scale
    delx = delx .* (1./scale_temp); dely = dely .* (1./scale_temp);
    valOTx(rat) = mean(delx); valOTy(rat) = mean(dely);
end
% just average over everything
% just X

figure;hold on;
plot(valCuedx, valCuedy, 'ro');
plot(valWMx, valWMy, 'bo');
plot(valOTx, valOTy, 'go');
% - these vals are in cm?
%% final DLS plot, remove camera bump at plot error bars??
tossrats = [6,8]; % DLS, 1 for bump, 1 for lesion
tossrats = [7]; % DMS e5 not large enough lesion
goodid = setdiff(1:length(valCuedx), tossrats);

figure; hold on;
plot(valCuedx(goodid), valCuedy(goodid), 'ro');
plot(valWMx(goodid), valWMy(goodid), 'bo');
plot(valOTx(goodid), valOTy(goodid), 'go');
errorbar(mean(valCuedx(goodid)), mean(valCuedy(goodid)),...
    std(valCuedy(goodid)),  std(valCuedy(goodid)),...
    std(valCuedx(goodid)),std(valCuedx(goodid)),'r');
errorbar(mean(valWMx(goodid)), mean(valWMy(goodid)),...
    std(valWMy(goodid)),  std(valWMy(goodid)),...
    std(valWMx(goodid)),std(valWMx(goodid)),'b');
errorbar(mean(valOTx(goodid)), mean(valOTy(goodid)),...
    std(valOTy(goodid)),  std(valOTy(goodid)),...
    std(valOTx(goodid)),std(valOTx(goodid)),'g');

% test?
[~,pcuedx] = ttest(valCuedx(goodid));
[~,pcuedy] = ttest(valCuedy(goodid));
[~,pwmx] = ttest(valWMx(goodid));
[~,pwmy] = ttest(valWMy(goodid));
[~,potx] = ttest(valOTx(goodid));
[~,poty] = ttest(valOTy(goodid));

[pcuedx] = signrank(valCuedx(goodid));
[pcuedy] = signrank(valCuedy(goodid));
[pwmx] = signrank(valWMx(goodid));
[pwmy] = signrank(valWMy(goodid));
[potx] = signrank(valOTx(goodid));
[poty] = signrank(valOTy(goodid));

title( [pcuedx, pcuedy, pwmx, pwmy, potx, poty])

% plot as bar plot
figure; hold on;
bar(1,mean(valCuedx(goodid)),'FaceColor','r');
bar(2,mean(valCuedy(goodid)),'FaceColor','r');
bar(3,mean(valWMx(goodid)),'FaceColor','b');
bar(4,mean(valWMy(goodid)),'FaceColor','b');
bar(5,mean(valOTx(goodid)),'FaceColor','g');
bar(6,mean(valOTy(goodid)),'FaceColor','g');
xticks(1:6); xticklabels({'Cued-x','Cued-y','WM-x','WM-y','OT-x','OT-y'});
plot(1*ones(1,length(goodid)), valCuedx(goodid), 'ko');
plot(2*ones(1,length(goodid)), valCuedy(goodid), 'ko');
plot(3*ones(1,length(goodid)), valWMx(goodid), 'ko');
plot(4*ones(1,length(goodid)), valWMy(goodid), 'ko');
plot(5*ones(1,length(goodid)), valOTx(goodid), 'ko');
plot(6*ones(1,length(goodid)), valOTy(goodid), 'ko');

title( [pcuedx, pcuedy, pwmx, pwmy, potx, poty])

