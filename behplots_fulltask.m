% addpath('D:\Kevin\Sequence_tap_analysis')
% addpath(genpath('D:\Kevin\Sequence_tap_analysis\Utilities'))
% addpath('D:\Kevin\Sequence_tap\Matlab')
% setup your matlab path
addpath('D:\Rats_in_Training\');

%this works for rats on flex+OT OR FOR ot ONLY USING CUES (LIKE L5)
% But for OT only (USING TRIAL ERROR), PROTOCOL_USE = 7/8 MAKES NO SENSE. SO CHANGE IT TO 6
%% initial stuff
%addpath('D:\Kevin\Sequence_tap\CameraSync')
% parentpath = 'D:\Kevin\Video\D8\Master';
% output_path = 'D:\Kevin\Sequence_tap\D8_output\Results-D8-Rat18';
% 
% parentpath = 'Z:\Kevin\Video\E8\Master';
% outAput_path = 'D:\Kevin\Sequence_tap\E8_output\Results-E8-Rat25';
ratname = 'T3-Tulip';
box = 'T3';

doplot = 1;
skipvid = 1;

%box = 'D7';
%ratname = 'D7-Rat19';

% lesion animals
%box = 'F3';
%ratname = 'F3(master)-Rat11';

%box = 'D8';
%ratname = 'D8-Rat18';

% parentpath = strcat('Z:\Kevin\Video\',box,'\Master');
% output_path = strcat('D:\Kevin\Sequence_tap\',box,'_output\Results-',ratname);

% * hardware config
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

% for f3
% hdw = containers.Map;
% hdw('GPIOpin')  = 22; % or 21
% hdw('LeverL')   = 18;
% hdw('LeverR')   = 19;
% hdw('LeverC')   = 0;
% hdw('LEDL')     = 20 %12 for e8; % 28 for d8
% hdw('LEDR')     = 17;%28 for e8; % 12 for d8
% hdw('LEDC')     = 0;
% hdw('Speaker')  = 23;
% hdw('Lick')     = 26;

%ratTrajStruct = struct;

% %% batch array
% boxarray = {%'D7','D7-Rat19',[3,11,4,28,12,27];...
%             %'D7','D7-Rat49',[3,11,4,28,12,27];...
%             %'D7','D7-Rat66',[3,11,4,28,12,27];...
%            % 'D7','D7-Rat74',[3,11,4,28,12,27];...
%             %'D8','D8-Rat18',[3,11,4,28,12,27];...
%             %'D8','D8-Rat38',[3,11,4,28,12,27];...
%             %'D8','D8-Rat41',[3,11,4,28,12,27];...
%           %  'D8','D8-Rat90',[3,11,4,28,12,27];...
%             'D8','D8-Rat119',[3,11,4,28,12,27];...
%             %'E1','E1-Rat20',[3,11,4,12,28,27];...
%             %'E1','E1-Rat15',[3,11,4,12,28,27];...
%            % 'E1','E1-Rat54',[3,11,4,12,28,27];...
%           %  'E1','E1-Rat75',[3,11,4,12,28,27];...
%             'E1','E1-Rat110',[3,11,4,12,28,27];...
%             %'E2','E2-Rat21',[3,11,4,12,28,27];...
%             %'E2','E2-Rat84',[3,11,4,12,28,27];...
%             %'E2','E2-Rat111',[3,11,4,12,28,27];...
%             %'E2','E2-Rat121',[3,11,4,12,28,27];...
%             'E2','E2-Rat124',[3,11,4,12,28,27];...
%            % 'E2','E2-Rat51',[3,11,4,12,28,27];...
%             %'E4','E4-Rat39',[3,11,4,12,28,27];...
%             %'E4','E4-Rat102',[3,11,4,12,28,27];...
%             'E4','E4-Rat122',[3,11,4,12,28,27];...
%             %'E4','E4-Rat83',[3,11,4,12,28,27];...
%             %'E4','E4-Rat92',[3,11,4,12,28,47];...
%             %'E5','E5-Rat40',[3,11,4,28,12,27];...
%             %'E5','E5-Rat44',[3,11,4,28,12,27];...
%             %'E5','E5-Rat45',[3,11,4,28,12,27];...
%          %   'E5','E5-Rat69',[3,11,4,28,12,27];...
%            % 'E5','E5-Rat91',[3,11,4,28,12,27];...
%             %'E5','E5-Rat109',[3,11,4,28,12,27];...
%             'E5','E5-Rat123',[3,11,4,28,12,27];...
%             %'E8','E8-Rat25',[3,11,4,12,28,27];...
%             %'E8','E8-Rat14',[3,11,4,12,28,27];...
%             %'F4','F4-Rat22',[3,11,4,28,12,27];...
%          %   'F3','F3-Rat59',[3,11,4,28,12,27];...
%          %   'F3','F3-Rat99',[3,11,4,28,12,27];...
%             'F3','F3-Rat115',[3,11,4,28,12,27];...
%             %'F4','F4-Rat43',[3,11,4,28,12,27];...
%             %'F4','F4-Rat67',[3,11,4,28,12,27];... % OT only rat?
%            % 'F4','F4-Rat85',[3,11,4,28,12,27];...
%             'F4','F4-Rat100',[3,11,4,28,12,27];...
%             %'F5','F5-Rat24',[3,11,4,12,28,27];...
%             %'F5','F5-Rat63',[3,11,4,12,28,27];...
%            % 'F5','F5-Rat61',[3,11,4,28,12,27];... % ?? swapped levers around
%             'F5','F5-Rat86',[3,11,4,28,12,27];...
%         %    'F6','F6-Rat55',[3,11,4,28,12,27];...
%            % 'F6','F6-Rat87',[3,11,4,28,12,27];...
%            % 'F6','F6-Rat101',[3,11,4,28,12,27];...
%             %'J1','J1-Rat28',[3,11,4,28,12,27];...
%           %  'J1','J1-Rat50',[3,11,4,28,12,27];...
%            % 'J1','J1-Rat71',[3,11,4,28,12,27];... % maybe something just broken on this box...
%             %'J2','J2-Rat17',[3,11,4,12,28,27];...
%             'J1','J1-Rat120',[3,11,4,28,12,27];...
%         %    'J2','J2-Rat59',[3,11,4,12,28,27];...
%             %'J2','J2-Rat93',[3,11,4,28,12,27];...
%             'J2','J2-Rat125',[3,11,4,28,12,27];...
%          %   'J3','J3-Rat72',[3,11,4,12,28,27];...
%             %'J3','J3-Rat12',[3,11,4,28,12,27];...
%             %'J3','J3-Rat42',[3,11,4,28,12,27];...
%            % 'J3','J3-Rat88',[3,11,4,28,12,27];...
%             'J3','J3-Rat113',[3,11,4,28,12,27];...
%         %    'J4','J4-Rat23',[3,11,4,28,12,27];...
%           %  'J4','J4-Rat76',[3,11,4,28,12,27];...
%             %'J4','J4-Rat114',[3,11,4,28,12,27];...
%             'J4','J4-Rat126',[3,11,4,28,12,27];...
%             %'J5','J5-Rat31',[3,11,4,28,12,27];...
%            % 'J5','J5-Rat65',[3,11,4,28,12,27];...
%          %   'J6','J6-Rat48',[3,11,4,28,12,27];... % need to redo these, had at 26 for some reason...
%         %    'J6','J6-Rat73',[3,11,4,28,12,27];...
%             %'J6','J6-Rat80',[3,11,4,28,12,27];...
%             %'J6','J6-Rat94',[3,11,4,28,12,27];...
%             'J6','J6-Rat105',[3,11,4,28,12,27];...
%             %'F3','F3(master)-Rat11',[18,19,0,17,20,0];...
%             %'F8','F8(master)-Rat14',[18,19,0,20,17,0];...
%             'L1','L1-Life',[3,11,4,28,12,27];...
%             %'L2','L2-Rat33',[3,11,4,28,12,27];...
%             %'L2','L2-Rat32',[3,11,4,28,12,27];...
%             %'L2','L2-Rat70',[3,11,4,28,12,27];...
%             'L2','L2-Rat116',[3,11,4,28,12,27];...
%            % 'L3','L3-Rat34',[3,11,4,28,12,27];...
%            % 'L3','L3-Rat65',[3,11,4,28,12,27];...
%             'L3','L3-Rat117',[3,11,4,28,12,27];...
%         %    'L4','L4-Rat68',[3,11,4,28,12,27];...
%             %'L4','L4-Rat35',[3,11,4,28,12,27];...
%             %'L4','L4-Rat46',[3,11,4,28,12,27];...
%             %'EphysE6','EphysE6-Rat25',[11,3,4,12,28,27];...
%             %'EphysE6','EphysE6-Rat22',[11,3,4,12,28,27];...
%             %'EphysE6','EphysE6-Rat35',[11,3,4,12,28,27];...
%             %'EphysE7','EphysE7-Rat18',[11,3,4,12,28,27];...
%             %'E8','E8-Rat29',[3,11,4,12,28,27];...
%             %'J7','J7-Rat36',[3,11,4,28,12,27];...
%          %   'J7','J7-Rat45',[3,11,4,28,12,27];...
%          %   'J7','J7-Rat61',[3,11,4,28,12,27];...;
%             'J7','J7-Rat115',[3,11,4,28,12,27];...
%             %'J8','J8-Rat7',[3,11,4,28,12,27];...
%            % 'J8','J8-Rat79',[3,11,4,28,12,27];...
%             % 'L5','L5-Rat95',[3,11,4,28,12,27];...
%              'L5','L5-Rat118',[3,11,4,28,12,27];...
%              'D6','D6-Dahlia',[3,11,4,12,28,27];...
%              'L5','L5-Lily',[3,11,4,12,28,27];...
%              'T6','T6-Titli',[3,11,4,12,28,27];...
%              'T3','T3-Tulip',[3,11,4,12,28,27];...
%               'L1','L1-Life',[3,11,4,28,12,27];...
%             };
%             %'J8','J8-Rat29',[3,11,4,28,12,27];...
%             %'L5','L5-Rat6',[3,11,4,28,12,27];}; % lrc, lrc
%           %  'L5','L5-Rat60',[3,11,4,28,12,27];};
%          
% % what are these?
% % boxarray = {'J5','J5-Rat31',[3,11,4,28,12,27, 25];... % add init box id
% %     'J6','J6-Rat30',[3,11,4,28,12,27, 25];... % lrc lrc cue
% %     'L1','L1-Rat32',[3,11,4,28,12,27, 25];...
% %     'L2','L2-Rat33',[3,11,4,28,12,27, 25];...
% %     'L3','L3-Rat34',[3,11,4,28,12,27, 25];...
% %     'L4','L4-Rat35',[3,11,4,28,12,27, 25];...
% %     'E4','E4-Rat39',[3,11,4,12,28,27, 25];};
% % % %  Ephys boxes
% % boxarray = {%'EphysE6','EphysE6-Rat25',[11,3,4,12,28,27];... % MC - CLC
% %           %'EphysE6','EphysE6-Rat56',[11,3,4,12,28,27];... 
% %            %'EphysE6','EphysE6-Rat35',[11,3,4,12,28,27];...
% %            %'EphysE6','EphysE6-Rat66',[11,3,4,12,28,27];...
% %           % 'EphysE6','EphysE6-Rat67',[11,3,4,12,28,27];... % M2 - LCR
% %           % 'EphysE6','EphysE6-Rat85',[11,3,4,12,28,27];...
% %            'EphysE6','EphysE6-Rat109',[11,3,4,12,28,27];...
% %            %'EphysE7','EphysE7-Rat18',[11,3,4,12,28,27];...
% %            %'EphysE7','EphysE7-Rat33',[11,3,4,12,28,27];...
% %            %'EphysE7','EphysE7-Rat47',[11,3,4,12,28,27];...
% %            %'EphysE7','EPhysE7-Rat63',[11,3,4,12,28,27];... % MC - RCR
% %            %'EphysE7','EPhysE7-Rat72',[11,3,4,12,28,27];... % M2 - RLC
% %            %'EphysE7','EphysE7-Rat97',[11,3,4,12,28,27];... % DLS OT only
% %            'EphysE7','EphysE7-Rat99',[11,3,4,12,28,27];...
% %            %'EphysE8','EphysE8-Rat21',[11,3,4,12,28,27];...
% %            %'EphysE8','EphysE8-Rat46',[11,3,4,12,28,27];... % MC LCR
% %            %'EphysE8','EphysE8-Rat45',[11,3,4,12,28,27];... % MC RLC
% %            %'EphysE8','EphysE8-Rat81',[11,3,4,12,28,27];...%;...
% %            'EphysE8','EphysE8-Rat98',[11,3,4,12,28,27]};
% %            %'EphysE9','EPhysE9-Rat35',[11,3,4,12,28,27]}; % lrc, lrc
% 
%   %protocol_use = 7:8;
%   %protocol_use = 6;
%    
% %    protocol_use = [4:8, 17];
% % 
% % %protocol_use = [4,8, 17]; % for ot only rats
% % 
% %Trial and error boxes
boxarray = {...%'L1','L1-Rat52',[3,11,4,28,12,27]; ...
   % 'L4','L4-Rat53',[3,11,4,28,12,27];...
  %  'L4','L4-Rat68',[3,11,4,28,12,27];...
  %  'L1','L1-Rat77',[3,11,4,28,12,27];...
   % 'L1','L1-Rat107',[3,11,4,28,12,27];...
   'E8','E8-Rat103',[3,11,4,12,28,27];...
   'J8','J8-Rat106',[3,11,4,12,28,27];...
    'J5','J5-Joy',[3,11,4,12,28,27];...
    'T8','T8-Truffle',[3,11,4,12,28,27];...
     'D7','D7-Daisy',[3,11,4,12,28,27];...
   'J3','J3-Jelly',[3,11,4,28,12,27];...
     'T7','T7-Tatte',[3,11,4,28,12,27];...
   'J7','J7-Jasmine',[3,11,4,28,12,27];...%kevin's animal
   'J3','J3-Jelly',[3,11,4,28,12,27];...%kevin's animal
    'T1','T1-Toy',[3,11,4,28,12,27];...%kevin's animal
     'T2','T2-Tia',[3,11,4,28,12,27];...%kevin's animal
       'T4','T4-Trip',[3,11,4,28,12,27];...%kevin's animal
    %'F4','F4-Rat43',[3,11,4,28,12,27];... %kevin's animal
   'D6','D6-Dahlia',[3,11,4,28,12,27];...
   'T3','T3-Tulip',[3,11,4,28,12,27];...
    'T6','T6-Titli',[3,11,4,28,12,27];...
     'T5','T5-Tiffany_2.0',[3,11,4,28,12,27];...
'F4','F4-Fig2',[3,11,4,28,12,27];...
'F3','F3-Fit',[3,11,4,12,28,27];...
    'L1','L1-Life',[3,11,4,28,12,27];
     'L5','L5-lily',[3,11,4,12,28,27];...
 %   'J2','J2-Rat58',[3,11,4,12,28,27];...
 %   'J2','J2-Rat104',[3,11,4,12,28,27];...
  %  'E8','E8-Rat57',[3,11,4,12,28,27];...
 %   'E8','E8-Rat82',[3,11,4,12,28,27];...
 'E8','E8-Elephant',[3,11,4,12,28,27];...
 'J8','J8-Julia',[3,11,4,12,28,27];...
 'E4','E4-Egg',[3,11,4,12,28,27];...
  'F6','F6-Fern',[3,11,4,12,28,27];...
   'J2','J2-Jai',[3,11,4,12,28,27];...
   'E8','E8-Elephant',[3,11,4,12,28,27];...
   'J5','J5-Joy',[3,11,4,12,28,27];...
   'J7','J7-Jasmine',[3,11,4,12,28,27];...
%    'J8','J8-Rat62',[3,11,4,28,12,27];...
  %  'J8','J8-Rat79',[3,11,4,28,12,27];...
    'J8','J8-Julia',[3,11,4,28,12,27]};
 %protocol_use = 5:6;
 % - i'm changing this 
% protocol_use = [2,4:6]; % includes tap free in session?
protocol_use = 7:8;
% MC trained lesions get retraining nums?
% boxarray = {'E1','E1-Rat20',[3,11,4,12,28,27];...
%     'D7','D7-Rat19',[3,11,4,28,12,27];...
%     'J2','J2-Rat17',[3,11,4,12,28,27];...
%     'J8','J8-Rat7',[3,11,4,28,12,27];...
%     'E8','E8-Rat14',[3,11,4,12,28,27];...
%     'F4','F4-Rat43',[3,11,4,28,12,27];...
%     'J3','J3-Rat42',[3,11,4,28,12,27];...
%     'E4','E4-Rat39',[3,11,4,12,28,27];...
%     'L3','L3-Rat34',[3,11,4,28,12,27];};

% OT only rats, cued
% boxarray = {'E1','E1-Rat54',[3,11,4,12,28,27];...
%     'F6','F6-Rat55',[3,11,4,28,12,27];};
% protocol_use = [4:8, 17];

% OT only, no cues
% boxarray = {'L1','L1-Rat52',[3,11,4,28,12,27]; ...
%     'L4','L4-Rat53',[3,11,4,28,12,27];};
% protocol_use = [2,4:6];


% OT trained lesions, see if retraining?

% for MC lesions trained: 7, 11, 20
% need traj struct to link to vidpath?
%vidpath = ['Z:\Kevin\Video\J2\Slave1'];
vidpath = [];

%%

%boxarray = {'J8','J8-Rat106',[3,11,4,12,28,27]};
%boxarray = {'T3','T3-Tulip',[3,11,4,28,12,27]};
%  boxarray = {'E8','E8-Rat103',[3,11,4,28,12,27]};

    %'D7','D7-Rat19',[3,11,4,28,12,27];...
%    protocol_use = 7:8;
%   protocol_use = [4:8, 17];



%%
% check e154, e251, f6, l1,  
%(e8,j2) naive lesions trial and error)
%(e4,l3) trained lesions

for ratid = 13

box = boxarray{ratid,1};
ratname = boxarray{ratid,2};
    
% parentpath = strcat('Z:\Kevin\Video\',box,'\Master');
output_path = strcat('D:\Rats_in_Training\',box,'_output\Results-',ratname);
%output_path = strcat('F:\Kevin\Sequence_tap\',box,'_output\Results-',ratname);

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

info = processPokeOutput3Levers(filename,vidpath,protocol, hdw, ratname, skipvid);

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
         % id(ratBEHstruct(s).blocknumRepair(id) ~= blocklength) = []; % cheating
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
try
save(fullfile('D:\Rats_in_Training\',[box '_output'],['Results-' ratname], 'ratBEHstruct.mat'),'ratBEHstruct');
catch
save(fullfile('D:\Rats_in_Training\',[box '_output'],['Results-' ratname], 'ratBEHstruct.mat'),'ratBEHstruct');
end

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
 errcue = accCued' - CIcued(:,1);
  errwm = accWM' - CIWM(:,1);
   errot = accOT' - CIOT(:,1);
h100=figure; hold on;
if ~isempty(accCued)
h1 = shadedErrorBar(datenum(date7),accCued,errcue,'LineWidth',10,'MarkerFaceColor','r','MarkerSize',2);
end
if ~isempty(accWM)
h1 = shadedErrorBar(datenum(date7WM),accWM,errwm,...
        'o','Color','b','CapSize',0,'LineWidth',10,'MarkerFaceColor','b','MarkerSize',2);
end
if ~isempty(accOT)
h1 = shadedErrorBar(datenum(date8),accOT,errot,...
        'o','Color','g','CapSize',0,'LineWidth',10,'MarkerFaceColor','g','MarkerSize',2);
end
%shadedErrorBar(datenum(updated_dates_l1),updated_plot_l1,errbar)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% other figure style
%i'll try to filter the data..
%lets filter:
surgery7 = 282;
date7window = 182:382;%chsooe this coz want 100 sess pre and post lesion
date8window = 52:119; %chose this by selcting same start and end dates from date8 as in date7 window 
date7f = date7(date7window);
date8f = date8(date8window);
acccuedf = accCued(date7window);
accwmf = accWM(date7window);
accotf = accOT(date8window);
cicuedf = CIcued(date7window,:);
ciwmf = CIWM(date7window,:);
ciotf = CIOT(date8window,:);

figure(1)
plot(datenum(date7f),acccuedf,'-r','LineWidth',2)
hold on 
errorbar(datenum(date7f),acccuedf,acccuedf' - cicuedf(:,1),cicuedf(:,2)-acccuedf',...
        'o','Color','r','CapSize',0,'LineWidth',.2,'MarkerFaceColor','r','MarkerSize',0.5);
hold on 
plot(datenum(date7f),accwmf,'-b','LineWidth',2)
hold on 
errorbar(datenum(date7f),accwmf,accwmf' - ciwmf(:,1),ciwmf(:,2)-accwmf',...
        'o','Color','b','CapSize',0,'LineWidth',.2,'MarkerFaceColor','b','MarkerSize',0.5);
hold on
plot(datenum(date8f),accotf,'-g','LineWidth',2)
errorbar(datenum(date8f),accotf,accotf' - ciotf(:,1),ciotf(:,2)-accotf',...
        'o','Color','g','CapSize',0,'LineWidth',.2,'MarkerFaceColor','g','MarkerSize',0.5);
hold on 
datetick('x','mmm','keeplimits','keepticks'); ylabel('Accuracy');
hold on
ylim([0 1])


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%
figure(2)
plot(datenum(date7),accCued,'-r','LineWidth',3)
hold on 
shadedErrorBar(datenum(date7),accCued,errcue)
hold on
plot(datenum(date7),accWM,'-b','LineWidth',3)
hold on 
shadedErrorBar(datenum(date7),accWM,errwm)
hold on 
plot(datenum(date8),accOT,'-g','LineWidth',3)
hold on 
shadedErrorBar(datenum(date8),accOT,errot)
hold on 
xline(datenum(date7(282)),'--k');
datetick('x','mmm','keeplimits','keepticks'); ylabel('Accuracy');
hold on
ylim([0 1])






%%%%
%%%%
plot(datenum(date7),accCued,'-k','LineWidth',2)
% hold on 
% shadedErrorBar(datenum(date7),accCued,errcue)
hold on
plot(datenum(date7),accWM,'-b','LineWidth',2)
% hold on 
% shadedErrorBar(datenum(date7),accWM,errwm)
hold on 
plot(datenum(date8),accOT,'-g','LineWidth',2)
% hold on 
% shadedErrorBar(datenum(date8),accOT,errot)
% hold on 
xline(datenum(date7(282)),'--k');
datetick('x','mmm','keeplimits','keepticks'); ylabel('Accuracy');
hold on
ylim([0 1])


legend({'Cued','WM','OT'})
if isempty(accWM); legend({'Cued','OT'}); end
if isempty(accCued); legend('OT'); end
datetick('x','mmm','keeplimits','keepticks'); ylabel('Accuracy');
title(ratBEHstruct(1).name);

endcsvwrite('FileName.csv', FileData.M);


end

%%%%for poster
% plot all metrics smooth itnow - for j8

%for lab meeting 
%%%%plot for e8
 
%j8
z1 = movmean(accCued(:,1:1084),50);
z2 = movmean(accCued(:,1085:1282),50); %should get 1x911
z = [z1 z2];
z_plot_j8 = z(:,739:1282)
date7_plot= date7(1,739:1282)
accCued_plot = accCued(1,739:1282);
CIcued_plot = CIcued(739:1282,:);

%j8 updated
% z_plot_j8 = z(:,739:1282)
date7_plot= date7(1,739:1282)
accCued_plot = accCued(1,739:1282);
CIcued_plot = CIcued(739:1282,:);

%for e8
%look at date7
%figureout the date of surgery and divide accCued accordingly
%surgery_e8 = 730;
z1 = movmean(accCued(:,1:730),50);
z2 = movmean(accCued(:,731:911),50); %should get 1x911
z = [z1 z2];
date7_plot_e8= date7(1,467:907);
z_plot_e8 = z(:,467:907);
accCued_plot_e8 = accCued(1,467:907);
CIcued_plot_e8 = CIcued(467:907,:);

%plot for j8 from sep-dc and dec-feb

%L1
surgery_l1 = 267;
z1 = movmean(accCued(:,1:267),50);
z2 = movmean(accCued(:,267:413),50); %should get 1x911
z = [z1 z2];
date7_plot_l1 = date7(1,267:413);
z_plot_l1 = z(:,267:413);
accCued_plot_l1 = accCued(1,267:413);
CIcued_plot_l1 = CIcued(267:413,:);

figure(4)
%for l1 
window = 145;
pre_sur_l1 = surgery_l1-window;
post_sur_l1 = surgery_l1+window;
updated_dates_l1 = date7(1,pre_sur_l1:post_sur_l1);
updated_plot_l1 = z(:,pre_sur_l1:post_sur_l1);
accuracy_l1_updated = accCued(1,pre_sur_l1:post_sur_l1);
CIcued_updated_l1 = CIcued(pre_sur_l1:post_sur_l1,:);
errbar = accuracy_l1_updated'-CIcued_updated_l1(:,1);

plot(datenum(updated_dates_l1),updated_plot_l1,'-go','LineWidth',10)
hold on
shadedErrorBar(datenum(updated_dates_l1),updated_plot_l1,errbar)
hold on 
datetick('x','mmm','keeplimits','keepticks'); ylabel('Accuracy');
hold on
ylim([0 1])
p2 = gca;
p2.XAxis.LineWidth = 5;
p2.YAxis.LineWidth = 5;
p2.XAxis.FontSize = 15;
p2.YAxis.FontSize = 15;
hold on
title('OT ONLY - Rat 3 L1')

%%%d6
surgery_d6 = 282;
surgery_d6_ot = 88;
z1 = movmean(accCued(:,1:282),50);
z2 = movmean(accCued(:,282:482),50); %should get 1x911
z = [z1 z2];
z1wm = movmean(accWM(:,1:282),50);
z2wm = movmean(accWM(:,282:482),50); %should get 1x911
zwm = [z1wm z2wm];

z1ot = movmean(accOT(:,1:88),25);
z2ot = movmean(accOT(:,88:154),25); %should get 1x911
zot = [z1ot z2ot];

date7_plot_d6 = date7(1,282:482);
z_plot_d6 = z(:,282:482);
zwm_plot_d6 = zwm(:,282:482);
accCued_plot_d6 = accCued(1,282:482);
CIcued_plot_d6 = CIcued(282:482,:);
figure(4)
window = 150;
windowot= 50;
pre_sur_d6 = surgery_d6-window;
post_sur_d6 = surgery_d6+window;
pre_ot_d6 = surgery_d6_ot - windowot;
post_ot_d6 = surgery_d6_ot + windowot;
updated_dates_d6 = date7(1,pre_sur_d6:post_sur_d6);
updated_dates_d6ot = date7(1,pre_ot_d6:post_ot_d6);

updated_plot_d6 = z(:,pre_sur_d6:post_sur_d6);
updated_plot_d6wm = zwm(:,pre_sur_d6:post_sur_d6);
updated_plot_d6ot = zot(:,pre_ot_d6:post_ot_d6);

accuracy_d6_updated = accCued(1,pre_sur_d6:post_sur_d6);
CIcued_updated_d6 = CIcued(pre_sur_d6:post_sur_d6,:);

accuracy_d6_wm = accWM(1,pre_sur_d6:post_sur_d6);
CIwm_updated_d6 = CIWM(pre_sur_d6:post_sur_d6,:);

accuracy_d6_ot = accOT(1,pre_ot_d6:post_ot_d6);
CIot_updated_d6 = CIOT(pre_ot_d6:post_ot_d6,:);

errbar = accuracy_d6_updated'-CIcued_updated_d6(:,1);
errbarwm = accuracy_d6_wm'-CIwm_updated_d6(:,1);
errbarot = accuracy_d6_ot'-CIot_updated_d6(:,1);

plot(datenum(updated_dates_d6),updated_plot_d6,'-ro','LineWidth',10)
hold on
shadedErrorBar(datenum(updated_dates_d6),updated_plot_d6,errbar)
hold on 
plot(datenum(updated_dates_d6),updated_plot_d6wm,'-bo','LineWidth',10)
hold on
shadedErrorBar(datenum(updated_dates_d6),updated_plot_d6wm,errbarwm)
hold on 
plot(datenum(updated_dates_d6ot),updated_plot_d6ot,'-bo','LineWidth',10)
hold on
shadedErrorBar(datenum(updated_dates_d6ot),updated_plot_d6ot,errbarot)




datetick('x','mmm','keeplimits','keepticks'); ylabel('Accuracy');
hold on
ylim([0 1])
p2 = gca;
p2.XAxis.LineWidth = 5;
p2.YAxis.LineWidth = 5;
p2.XAxis.FontSize = 15;
p2.YAxis.FontSize = 15;
hold on
title('FULL TASK ONLY - Rat 1 D6')



figure(3)
%coming up with a fixed time frame before and after silencing 
%150 sessions before, 150 sesons after lesion 
window = 150;
surgery_j8 = 1084;
pre_sur_e8 = surgery_j8-window;
post_sur_e8 = surgery_j8+window;
updated_dates_e8 = date7(1,pre_sur_e8:post_sur_e8);
updated_plot_e8 = z(:,pre_sur_e8:post_sur_e8);
accuracy_e8_updated = accCued(1,pre_sur_e8:post_sur_e8);
CIcued_updated_e8 = CIcued(pre_sur_e8:post_sur_e8,:);
errbar = accuracy_e8_updated'-CIcued_updated_e8(:,1);

plot(datenum(updated_dates_e8),updated_plot_e8,'-go','LineWidth',10)
hold on
shadedErrorBar(datenum(updated_dates_e8),updated_plot_e8,errbar)
hold on 
datetick('x','mmm','keeplimits','keepticks'); ylabel('Accuracy');
hold on
ylim([0 1])
p2 = gca;
p2.XAxis.LineWidth = 5;
p2.YAxis.LineWidth = 5;
p2.XAxis.FontSize = 15;
p2.YAxis.FontSize = 15;
hold on
title('OT ONLY - Rat 2 J8')








figure(1)
plot(datenum(date7),z,'-go','LineWidth',15)
hold on
errorbar(datenum(date7),z,accCued'-CIcued(:,1),CIcued(:,2)-accCued','color',[.5 .5 .5],'linewidth',0.5);
hold on 
datetick('x','mmm','keeplimits','keepticks'); ylabel('accuracy');
p2 = gca;
p2.XAxis.LineWidth = 5;
p2.YAxis.LineWidth = 5;
p2.XAxis.FontSize = 15;
p2.YAxis.FontSize = 15;
hold off

figure(2)%use for j8
errbar = accCued_plot'-CIcued_plot(:,1);
plot(datenum(date7_plot),z_plot_j8,'-go')
hold on
shadedErrorBar(datenum(date7_plot),z_plot_j8,errbar)
hold on 
datetick('x','dd mmm yyyy','keeplimits','keepticks'); ylabel('accuracy');
hold on
p2 = gca;
p2.XAxis.LineWidth = 5;
p2.YAxis.LineWidth = 5;
p2.XAxis.FontSize = 15;
p2.YAxis.FontSize = 15;
hold off

ylim([0 1])

figure(2)%use for e8
errbar = accCued_plot_e8'-CIcued_plot_e8(:,1);
plot(datenum(date7_plot_e8),z_plot_e8,'-go','LineWidth',10)
hold on
shadedErrorBar(datenum(date7_plot_e8),z_plot_e8,errbar)
hold on 
datetick('x','dd mmm yyyy','keeplimits','keepticks'); ylabel('Accuracy');
hold on
ylim([0 1])
p2 = gca;
p2.XAxis.LineWidth = 5;
p2.YAxis.LineWidth = 5;
p2.XAxis.FontSize = 15;
p2.YAxis.FontSize = 15;
hold on
title('Rat 1_E8')

figure(3)
%coming up with a fixed time frame before and after silencing 
%150 sessions before, 150 sesons after lesion 
window = 150;
surgery_e8 = 730;
pre_sur_e8 = surgery_e8-window;
post_sur_e8 = surgery_e8+window;
updated_dates_e8 = date7(1,pre_sur_e8:post_sur_e8);
updated_plot_e8 = z(:,pre_sur_e8:post_sur_e8);
accuracy_e8_updated = accCued(1,pre_sur_e8:post_sur_e8);
CIcued_updated_e8 = CIcued(pre_sur_e8:post_sur_e8,:);
errbar = accuracy_e8_updated'-CIcued_updated_e8(:,1);

plot(datenum(updated_dates_e8),updated_plot_e8,'-go','LineWidth',10)
hold on
shadedErrorBar(datenum(updated_dates_e8),updated_plot_e8,errbar)
hold on 
datetick('x','mmm','keeplimits','keepticks'); ylabel('Accuracy');
hold on
ylim([0 1])
p2 = gca;
p2.XAxis.LineWidth = 5;
p2.YAxis.LineWidth = 5;
p2.XAxis.FontSize = 15;
p2.YAxis.FontSize = 15;
hold on
title('OT ONLY - Rat 1 E8')










figure(2)
errorbar(datenum(date7),z,z'-CIcued(:,1),CIcued(:,2)-z','.r','CapSize',0)
end

%[phat_z, CI_z] = binofit(sum(ratBEHstruct(s).Hit(idx)), length(idx));
    
% % [~,acc_err] = binofit(sum(z,length(z));
% figure(5)
% hold on;
% 
% xlim([1,length(z)])
% if ~isempty(sessbreaks);for b = 1:length(sessbreaks); plot([sessbreaks(b), sessbreaks(b)],ylim,'k--','linewidth',2); end; end
% ylabel('Fraction'); title('accuracy')
% if ~isempty(fixed);plot([fixed, fixed],ylim,'r--','linewidth',2); end
% % add number of trials??? (length(Hit))
% %%
% 
% 
% h100=figure; hold on;
% if ~isempty(accCued)
% h1 = errorbar(datenum(date7),accCued,accCued' - CIcued(:,1),CIcued(:,2)-accCued',...
%         'o','Color','r','CapSize',0,'LineWidth',.2,'MarkerFaceColor','r','MarkerSize',2);
% end