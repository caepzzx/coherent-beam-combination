figure,plot(RMS,SR,'dr');
x=linspace(min(RMS),max(RMS),200);
for i=1:10
[p,S]=polyfit(RMS,SR,i);
[y,delta]=polyval(p,x,S);
sumdelta(1,i)=sum(delta);
end
[mindelta,idx]=min(sumdelta);
p=polyfit(RMS,SR,idx);
y=polyval(p,x);
hold on,plot(x,y,'b')
poly=poly2str(p,'RMS');
text(0.2*max(x), 0.85*max(y), ['SR=',poly], 'horizontalAlignment', 'left'...
    ,'fontsize',8,'fontweight','bold');
title('SR vs RMS');
xlabel('RMS');
ylabel('SR');