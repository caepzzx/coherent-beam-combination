i=0:0.1:1;
numx=numel(i);
j=0:0.4:1;
numy=numel(j);
Strehl=struct('SR',cell(numx,numy),'Name',[]);
idxx=1;
idxy=1;
for i=0
for j=0.4
    
Strehl(idxx,idxy).SR=i+j;

idxy=idxy+1;
end
idxx=idxx+1;
end