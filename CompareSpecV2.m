function [pos169] = CompareSpecV2(data,peak2up,peak2low,isnorm,allcrds,mzvalue)

index=mzvalue<=peak2up & mzvalue>=peak2low;
data169=data(index,:);

data169=sum(data169,1); 


%block normalization
posind=1:10:100;
posind=reshape(posind,1,10);
poscells=cell(1,10);
for i=1:1    
    for j=1:10
        poscells{i,j}=allcrds(posind(i,j),:);
    end
end

posblanks=zeros(1,10);
crdXY=allcrds;
for i=1:1
    for j=1:10
        %disp(i);
        %disp(j);
        crdtmp=poscells{i,j};
        indtmp=find(crdXY(:,1)==crdtmp(1) & crdXY(:,2)==crdtmp(2));
        if ~isempty(indtmp)
            posblanks(i,j)=data169(indtmp);
        else
            posblanks(i,j)=0;
        end
    end
end





blankmean=zeros(1,1);
for i=1:1
   rowtmp=posblanks(i,:);
   rowtmp=sort(rowtmp,'descend');
   rowtmp=rowtmp(1:10);
   %rowtmp=rowtmp(rowtmp>0);
   blankmean(i,1)=mean(rowtmp);
end



posind=1:1:100;
posind=reshape(posind,10,10);
poscells=cell(10,10);
for i=1:10    
    for j=1:10
        poscells{i,j}=allcrds(posind(i,j),:);
    end
end

pos169=zeros(10,10);

for i=1:10
    for j=1:10
        crdtmp=poscells{i,j};
        indtmp=find(crdXY(:,1)==crdtmp(1) & crdXY(:,2)==crdtmp(2));
        if ~isempty(indtmp)
            pos169(i,j)=data169(indtmp);
        else
            pos169(i,j)=0;
        end
    end
end

blankmean=repmat(blankmean,1,10);

blankmeanexp=zeros(10,10);
for i=1:1
    blankmeanexp((i-1)*10+1:(i-1)*10+10,:)=repmat(blankmean(i,:),10,1);
end

%image169=zeros(300,1206);
pos169=pos169./blankmeanexp;
pos169=pos169(:);
pos169=pos169';
if isnorm==1
    pos169=pos169-min(pos169);
    pos169=pos169/max(pos169);
end








end

