clear all
load('prodata.mat');
%%
%disp SR vs wavefront
    %SR vs PV
plot(PV,SR,'dr');
x=linspace(min(PV),max(PV),200);
for i=1:10
[p,S]=polyfit(PV,SR,i);
[y,delta]=polyval(p,x,S);
sumdelta(1,i)=sum(delta);
end
[mindelta,idx]=min(sumdelta);
p=polyfit(PV,SR,idx);
y=polyval(p,x);
hold on,plot(x,y,'b')
poly=poly2str(p,'PV');
text(0.2*max(x), 0.85*max(y), ['SR=',poly], 'horizontalAlignment', 'left'...
    ,'fontsize',8,'fontweight','bold');
title('SR vs PV');
xlabel('PV');
ylabel('SR');
print('-dmeta','E:\\WavefrontData\\PV_SR')
     % SR vs RMS
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
print('-dmeta','E:\\WavefrontData\\RMS_SR')
     %SR vs GRMS
figure,plot(GRMS,SR,'dr');
x=linspace(min(GRMS),max(GRMS),200);
for i=1:10
[p,S]=polyfit(GRMS,SR,i);
[y,delta]=polyval(p,x,S);
sumdelta(1,i)=sum(delta);
end
[mindelta,idx]=min(sumdelta);
p=polyfit(GRMS,SR,idx);
y=polyval(p,x);
hold on,plot(x,y,'b')
poly=poly2str(p,'GRMS');
text(0.2*max(x), 0.85*max(y), ['SR=',poly], 'horizontalAlignment', 'left'...
    ,'fontsize',8,'fontweight','bold');
title('SR vs GRMS');
xlabel('GRMS');
ylabel('SR');
print('-dmeta','E:\\WavefrontData\\GRMS_SR')
    %SR vs GPV
figure,plot(GPV,SR,'dr');
x=linspace(min(GPV),max(GPV),200);
for i=1:10
[p,S]=polyfit(GPV,SR,i);
[y,delta]=polyval(p,x,S);
sumdelta(1,i)=sum(delta);
end
[mindelta,idx]=min(sumdelta);
p=polyfit(GPV,SR,idx);
y=polyval(p,x);
hold on,plot(x,y,'b')
poly=poly2str(p,'GPV');
text(0.2*max(x), 0.85*max(y), ['SR=',poly], 'horizontalAlignment', 'left'...
    ,'fontsize',8,'fontweight','bold');
title('SR vs GPV');
xlabel('GPV');
ylabel('SR');
print('-dmeta','E:\\WavefrontData\\GPV_SR')
