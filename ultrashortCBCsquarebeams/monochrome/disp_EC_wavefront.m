
%%
%disp ECdl vs wavefront
    %ECdl vs PV
figure,plot(ECdl,PV,'.k');
x=linspace(min(ECdl),max(ECdl),200);
for i=1:10
[p,S]=polyfit(ECdl,PV,i);
[y,delta]=polyval(p,x,S);
sumdelta(1,i)=sum(delta);
end
[mindelta,idx]=min(sumdelta);
p=polyfit(ECdl,PV,6);
y=polyval(p,x);
hold on,plot(x,y,'r','linewidth',2)
poly=poly2str(p,'EC');
text(0.3*max(x),1.3*max(y), ['PV=',poly], 'horizontalAlignment', 'left'...
    ,'fontsize',8,'fontweight','bold');
title('ECdl vs PV');
xlabel('ECdl');
ylabel('PV(\lambda)');
print('-dmeta','PV_ECdl')

     % ECdl vs RMS
figure,plot(ECdl,RMS,'.k');
x=linspace(min(ECdl),max(ECdl),200);
for i=1:10
[p,S]=polyfit(ECdl,RMS,i);
[y,delta]=polyval(p,x,S);
sumdelta(1,i)=sum(delta);
end
[mindelta,idx]=min(sumdelta);
p=polyfit(ECdl,RMS,idx);
y=polyval(p,x);
hold on,plot(x,y,'r','linewidth',2)
poly=poly2str(p,'EC');
text(0.1*max(x), 1.3*max(y), ['ECdl=',poly], 'horizontalAlignment', 'left'...
    ,'fontsize',8,'fontweight','bold');
title('ECdl vs RMS');
xlabel('ECdl');
ylabel('RMS(\lambda)');
print('-dmeta','RMS_ECdl')
     %ECdl vs GRMS
figure,plot(ECdl,GRMS,'.k');
x=linspace(min(ECdl),max(ECdl),200);
for i=1:10
[p,S]=polyfit(ECdl,GRMS,i);
[y,delta]=polyval(p,x,S);
sumdelta(1,i)=sum(delta);
end
[mindelta,idx]=min(sumdelta);
p=polyfit(ECdl,GRMS,idx);
y=polyval(p,x);
hold on,plot(x,y,'r','linewidth',2)
poly=poly2str(p,'EC');
text(0.15*max(x), 0.8*max(y), ['GRMS=',poly], 'horizontalAlignment', 'left'...
    ,'fontsize',8,'fontweight','bold');
title('ECdl vs GRMS');
xlabel('ECdl');
ylabel('GRMS(\lambda/cm)');
print('-dmeta','GRMS_ECdl')
    %ECdl vs GPV
figure,plot(ECdl,GPV,'.k');
x=linspace(min(ECdl),max(ECdl),200);
for i=1:10
[p,S]=polyfit(ECdl,GPV,i);
[y,delta]=polyval(p,x,S);
sumdelta(1,i)=sum(delta);
end
[mindelta,idx]=min(sumdelta);
p=polyfit(ECdl,GPV,7);
y=polyval(p,x);
hold on,plot(x,y,'r','linewidth',2)
poly=poly2str(p,'EC');
text(0.05*max(x),1.5*max(y), ['GPV=',poly], 'horizontalAlignment', 'left'...
    ,'fontsize',8,'fontweight','bold');
title('ECdl vs GPV');
xlabel('ECdl');
ylabel('GPV(\lambda/cm)');
print('-dmeta','GPV_ECdl')

%EC vs SR
plot(SR,ECdl,'.k')
x=linspace(min(SR),max(SR),200);
for i=1:10
[p,S]=polyfit(SR,ECdl,i);
[y,delta]=polyval(p,x,S);
sumdelta(1,i)=sum(delta);
end
[mindelta,idx]=min(sumdelta);
p=polyfit(SR,ECdl,idx);
y=polyval(p,x);
hold on,plot(x,y,'r','linewidth',2)
poly=poly2str(p,'SR');
text(0.01*max(x),0.95*max(y), ['ECdl=',poly], 'horizontalAlignment', 'left'...
    ,'fontsize',8,'fontweight','bold');
title('SR vs ECdl');
xlabel('SR');
ylabel('ECdl');
print('-dmeta','GPV_ECdl')
