function [locs] = FindVariablePeaks_func()
data=readtable('demo.csv');
data=table2array(data);
allcrds=readtable('testCoord.csv');
allcrds=table2array(allcrds);
allinds=sub2ind([55,51],allcrds(:,2),allcrds(:,1));
allcrds=allcrds';
fid=fopen('demo.dat','r');
dim=fread(fid,[1 2],'int32');
mzvalue=fread(fid,[1 dim(1)],'double');

%pixelcrd=fread(fid,[dim(2) 2],'int32');
%offset=[65 110];
%offset=repmat(offset,dim(2),1);
%crdXY=pixelcrd-offset;

fclose(fid);
%pixelcrd=readtable('ExtractedCoordsFromR.csv');
%pixelcrd=table2array(pixelcrd);
crdXY=allcrds;

posind=1:10:100;
posind=reshape(posind,1,10);
poscells=cell(1,10);
for i=1:1    
    for j=1:10
        poscells{i,j}=allcrds(posind(i,j),:);
    end
end

halspec=[];
indlist=[];
for i=1:1
    for j=1:10
        crdtmp=poscells{i,j};
        indtmp=find(crdXY(:,1)==crdtmp(1) & crdXY(:,2)==crdtmp(2));
        if ~isempty(indtmp)
            indlist=[indlist indtmp];
            halspec=[halspec data(:,indtmp)];
        end
    end
end

libinds=zeros(1,size(data,2));
libinds(indlist)=1;
libinds=logical(libinds);
libspec=data(:,~libinds);
halspec=sort(halspec,2,'descend');
libspec=sort(libspec,2,'descend');
halspec=mean(halspec(:,1:10),2);
libspec=mean(libspec(:,1:90),2);
diff=(libspec-halspec);


% Change findpeaks parameters here
% MinPeakDistance is in mz unit
% locs is mz list
[pks,locs]=findpeaks(diff,mzvalue,'MinPeakDistance',1,'MinPeakHeight',0.07,'MinPeakProminence',0);
%plot(mzvalue,diff,locs,pks,'o');
locs=floor(locs);
locs=[locs 127];
locs=sort(locs,'ascend');
end

