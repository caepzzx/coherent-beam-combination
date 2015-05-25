clear all
load('prodata.mat');
%%
%disp EC vs wavefront
    %EC vs PV
figure,plot(PV,EC,'dr');
x=linspace(min(PV),max(PV),200);
for i=1:10
[p,S]=polyfit(PV,EC,i);
[y,delta]=polyval(p,x,S);
sumdelta(1,i)=sum(delta);
end
[mindelta,idx]=min(sumdelta);
p=polyfit(PV,EC,idx);
y=polyval(p,x);
hold on,plot(x,y,'b')
poly=poly2str(p,'PV');
text(0.2*max(x), 0.85*max(y), ['EC=',poly], 'horizontalAlignment', 'left'...
    ,'fontsize',8,'fontweight','bold');
title('EC vs PV');
xlabel('PV');
ylabel('EC');
print('-dmeta','PV_EC')
     % EC vs RMS
figure,plot(RMS,EC,'dr');
x=linspace(min(RMS),max(RMS),200);
for i=1:10
[p,S]=polyfit(RMS,EC,i);
[y,delta]=polyval(p,x,S);
sumdelta(1,i)=sum(delta);
end
[mindelta,idx]=min(sumdelta);
p=polyfit(RMS,EC,idx);
y=polyval(p,x);
hold on,plot(x,y,'b')
poly=poly2str(p,'RMS');
text(0.2*max(x), 0.85*max(y), ['EC=',poly], 'horizontalAlignment', 'left'...
    ,'fontsize',8,'fontweight','bold');
title('EC vs RMS');
xlabel('RMS');
ylabel('EC');
print('-dmeta','RMS_EC')
     %EC vs GRMS
figure,plot(GRMS,EC,'dr');
x=linspace(min(GRMS),max(GRMS),200);
for i=1:10
[p,S]=polyfit(GRMS,EC,i);
[y,delta]=polyval(p,x,S);
sumdelta(1,i)=sum(delta);
end
[mindelta,idx]=min(sumdelta);
p=polyfit(GRMS,EC,idx);
y=polyval(p,x);
hold on,plot(x,y,'b')
poly=poly2str(p,'GRMS');
text(0.2*max(x), 0.85*max(y), ['EC=',poly], 'horizontalAlignment', 'left'...
    ,'fontsize',8,'fontweight','bold');
title('EC vs GRMS');
xlabel('GRMS');
ylabel('EC');
print('-dmeta','GRMS_EC')
    %EC vs GPV
figure,plot(GPV,EC,'dr');
x=linspace(min(GPV),max(GPV),200);
for i=1:10
[p,S]=polyfit(GPV,EC,i);
[y,delta]=polyval(p,x,S);
sumdelta(1,i)=sum(delta);
end
[mindelta,idx]=min(sumdelta);
p=polyfit(GPV,EC,idx);
y=polyval(p,x);
hold on,plot(x,y,'b')
poly=poly2str(p,'GPV');
text(0.2*max(x), 0.85*max(y), ['EC=',poly], 'horizontalAlignment', 'left'...
    ,'fontsize',8,'fontweight','bold');
title('EC vs GPV');
xlabel('GPV');
ylabel('EC');
print('-dmeta','GPV_EC')