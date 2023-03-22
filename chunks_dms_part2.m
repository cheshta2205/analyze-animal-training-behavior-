%%j3jelly
%loaded ratbehstruct
%%lets see sess 1 
presstimes = cell2mat(ratBEHstruct(1).pokeTimes(:));
lickontimes = ratBEHstruct(1).LickOn;
cuetimes = cell2mat(ratBEHstruct(1).cuedTimes(:));
%%%plot sequence of events..
minval = min([min(cuetimes),min(presstimes),min(lickontimes)]);
maxval = max([max(cuetimes),max(presstimes),max(lickontimes)]);
timescales = minval:maxval;
for k = 1:length(cuetimes)
cueyes(1,k) = find(timescales==cuetimes(k));
end
cueon = zeros(1,length(timescales));
cueon(cueyes) = 1;

for k = 1:length(presstimes)
pressyes(1,k) = find(timescales==presstimes(k));
end
presson = zeros(1,length(timescales));
presson(pressyes) = 1;

for k = 1:length(presstimes)
lickyes(1,k) = find(timescales==lickontimes(k));
end
lickon = zeros(1,length(timescales));
lickon(lickyes) = 1;
rm = find(timescales == lickyes(end))
rm1= find(timescales == lickyes(1))
lickon(rm:end)=[];
cueon(rm:end)=[];
presson(rm:end)=[];

%if any lick or poke happens pre-cue, remove it as that's before trial
%starts

firstcue = find(cueon==1);
cue1 = firstcue(1,1);
firstpoke = find(presson==1);
poke1 = firstpoke(1,1);
rmlick = find(lickyes<cue1);
lickyes(rmlick) = [];
rmpoke = find(pressyes<cue1);
pressyes(rmpoke) = [];


rm = find(timescales == lickyes(end));
rm1= find(timescales == lickyes(1));
rmlick1 = find(lickyes<poke1);
lickyes(rmlick1) = [];
lickon = zeros(1,length(timescales));
lickon(lickyes) = 1;

rmpoke = find(pressyes<cue1);
rmpoke1= find(pressyes<cue1);
presson = zeros(1,length(timescales));
presson(pressyes) = 1;
cueon(rm:end)=[];
presson(rm:end)=[];
lickon(rm:end)=[];
%% 

% figure(1)
% plot(cueon,'b*');
% hold on 
% plot(presson,'ro');
% hold on 
% plot(lickon,'go');


figure(1)
subplot(3,1,1)
plot(cueon(1:50000),'Color','b')
title('CUE')
grid on
hold on 
set(gca,'YTick',[0 1])
subplot(3,1,2)
plot(presson(1:50000),'Color','r')
title('LEVER-PRESS')
grid on;
hold on 
set(gca,'YTick',[0 1])
subplot(3,1,3)
plot(lickon(1:50000),'Color','g')
title('LICK')
grid on;
hold on 
set(gca,'YTick',[0 1])
%% 

%hardcoding some edits

cueon(:,50000:100000)=[];
lickon(:,50000:100000)=[];
presson(:,50000:100000)=[];
figure(2)
subplot(3,1,1)
plot(cueon,'Color','b')
title('CUE')
grid on
hold on 
set(gca,'YTick',[0 1])
subplot(3,1,2)
plot(presson,'Color','r')
title('LEVER-PRESS')
grid on;
hold on 
set(gca,'YTick',[0 1])
subplot(3,1,3)
plot(lickon,'Color','g')
title('LICK')
grid on;
hold on 
set(gca,'YTick',[0 1])

