%quantify licks in between taps %%j3jelly
%loaded ratbehstruct
%%lets see session 1 
for k = 1:length(ratBEHstruct)
presstimes{1,k} = cell2mat(ratBEHstruct(k).pokeTimes(:));
lickontimes{1,k} = ratBEHstruct(k).LickOn;
cuetimes{1,k} = cell2mat(ratBEHstruct(k).cuedTimes(:));
%%%plot sequence of events..
minval{1,k} = min([min(cuetimes{1,k}),min(presstimes{1,k}),min(lickontimes{1,k})]);
maxval{1,k} = max([max(cuetimes{1,k}),max(presstimes{1,k}),max(lickontimes{1,k})]);
minpress{1,k} = min(presstimes{1,k});
maxpress{1,k} = max(presstimes{1,k});
timescales{1,k} = minval{1,k}:maxval{1,k};
trialcount(1,k) = length(ratBEHstruct(k).pokeNames);
end
newtrialcount=trialcount;
behnew=ratBEHstruct;

%find empty cell arrays 
emptypress = find(cellfun(@isempty,presstimes));
emptylicks =  find(cellfun(@isempty,lickontimes));
comb = union(emptypress,emptylicks);
behnew(comb)=[];
%delete them 
lickontimes(comb) = [];
presstimes(comb)=[];
minpress(comb)=[];
newtrialcount(comb)=[];
remtrial = find(newtrialcount<15);
trial2=newtrialcount;
trial2(remtrial)=[];

lickontimes(remtrial)=[];
presstimes(remtrial)=[];
minpress(remtrial)=[];
behnew(remtrial)=[];

%% 

% find licks before 1st press and remove them 
for k = 1:length(presstimes)
    discardlicks{1,k} =  find(lickontimes{1,k}<minpress{1,k});
end
for k = 1:length(presstimes)
lickontimes{1,k}(discardlicks{1,k})=[];
end

%find licks after 1and 2 press
for k = 1:length(presstimes)
    for kk = 1:length(presstimes{1,k})
        if kk<length(presstimes{1,k})
        lickbwpress{1,k}{1,kk} = find(lickontimes{1,k}>presstimes{1,k}(kk) & lickontimes{1,k}<presstimes{1,k}(kk+1));
        elseif kk == length(presstimes{1,k})
            lickbwpress{1,k}{1,kk} = find(lickontimes{1,k}>presstimes{1,k}(kk));
        end
    end
end

licknewpress=lickbwpress;
licknew3press=lickbwpress;
for k =1:length(lickbwpress)
delempty{1,k}=find(cellfun(@isempty,licknew3press{1,k}));
licknew3press{1,k}(delempty{1,k})=[];
end

for k=1:length(licknew3press)
lickcount(1,k)=length(licknew3press{1,k});%no of press followed by licks
presscount(1,k)=length(lickbwpress{1,k});%no of press
end

%%what % of presses are followed by licks... ?
lickafterpress_per = lickcount./presscount;

%if i delete those licks which are after 3rd lever press (i.e. after
%finishing sequence..)

lickbwpress_up=lickbwpress;
for k = 1:length(lickbwpress_up)
lickbwpress_up{1,k}(3:3:length(lickbwpress_up{1,k}))=[];
end
% for k = 1:length(lickbwpress_up)
% lickbwpress_up{1,k}(2:2:length(lickbwpress_up{1,k}))=[];
% end
lickbwpress_up2=lickbwpress_up;

for k = 1:length(lickbwpress_up)
delempty2{1,k}=find(cellfun(@isempty,lickbwpress_up{1,k}));
lickbwpress_up2{1,k}(delempty2{1,k})=[];
end

for k =1:length(lickbwpress_up2)
lickcount_without3(1,k)=length(lickbwpress_up2{1,k});
end
lickafterpress_wo3 = lickcount_without3./presscount;
normlick = lickcount_without3./trial2;
normlick2=lickcount./trial2;


% 
% cd X:\Lab\dms_lesion\3stagelicks
% save('j7jasmine_dms_lick.mat','lickafterpress_wo3','lickafterpress_per');
% 











