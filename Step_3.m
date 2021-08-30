clear;
data=readtable('demo.csv');
data=table2array(data);
allcrds=readtable('testCoord.csv');
allcrds=table2array(allcrds);
allcrds=allcrds';
fclose all;
fid=fopen('demo.dat','r');
dim=fread(fid,[1 2],'int32');
mzvalue=fread(fid,[1 dim(1)],'double');
fclose(fid);

locs=FindVariablePeaks_func;
Ext=[];

for i=1:length(locs)
   % locs is mz list
   % bin size is +/- 0.5
   % Top 20% (0.2)
   [extractOne] = CompareSpecV2(data,locs(i)+0.5,locs(i)-0.5,0,allcrds,mzvalue);
   Ext=[Ext;extractOne];
end

for i=1:size(Ext,2)
   	poslabel{1,i}=sprintf('(x%d y%d)',allcrds(i,1),allcrds(i,2));
end

prefix='m/z ';
mslist2=num2str(locs');

prefix=repmat(prefix,size(mslist2,1),1);
mslist2=[prefix mslist2];
mslist2=cellstr(mslist2);
writecell(mslist2,'mzlist.txt');
%{
InInd=(allcrds(:,1)>64 & allcrds(:,1)<1146);
poslabel=poslabel(InInd);
Ext=Ext(:,InInd);
%}
% Plot mz127 from datacube
%datacube=readtable('demo_mz_127_slice.csv');
%datacube=table2array(datacube);
%imagesc(datacube);

% allcrds(:,1) is X, allcrds(:,2) is Y

Ext=num2cell(Ext);
dgeconcat=[mslist2 Ext];
head=cellstr('m/z');
poslabel=[head poslabel];
T=cell2table(dgeconcat,'VariableNames',poslabel);
writetable(T,'ExtractedDGE_demo.csv');