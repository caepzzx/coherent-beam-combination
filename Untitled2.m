 clear
 vx=0:0.5:1;
 vy=0:0.4:1;
  department(numel(vx),numel(vy))=struct('number',[],'name',[]);
 for k=1:numel(vx)
     for j=1:numel(vy)
     department(k,j).number=vx(k)+vy(j);
     end
 end