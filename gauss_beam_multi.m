% sqr_beam propagation example
%
clear all;
L1=0.5; %side length
M=500; %number of samples
dx1=L1/M; %src sample interval
x1=-L1/2:dx1:L1/2-dx1; %src coords
y1=x1;
lambda0=1030*10^-9; %wavelength
deltalambda=90*10^-9;
k=2*pi/lambda0; %wavenumber
w=0.011; %source half width (m)
z=2000; %propagation dist (m)
deltad=0.015;
r=deltad-0.1*deltad;

[X1,Y1]=meshgrid(x1,y1);

for k=0:0.5:1
    phi=[0,k*2*pi];
u1=u1dis(phi,X1,Y1,deltad,r,2); %src field
u1=u1/max(max(u1));
I1=abs(u1.^2); %src irradiance
%
figure(1)
imagesc(x1,y1,I1);
axis square; axis xy;
colormap('gray'); xlabel('x (m)'); ylabel('y (m)');
title('z= 0 m');
u2=zeros(M,M);
for lambda=(lambda0-deltalambda/2):deltalambda/500:(lambda0+deltalambda/2-deltalambda/M);
u1t=u1*spec(lambda,lambda0,deltalambda);%consider spectrum distribution
[u2t,L2]=propFF(u1t,L1,lambda,z);
u2=u2+u2t;
end
dx2=L2/M;
x2=-L2/2:dx2:L2/2-dx2; %obs ords
y2=x2;
I2=abs(u2.^2);
figure,imagesc(x2,y2,nthroot(I2,3));%stretch image contrast
xlabel('x (m)'); ylabel('y (m)');
title(['z=2000m ,',' \phi=',num2str(k*2),'\pi']);
figure,plot(x2,I2(round(size(I2,2)/2),:),'-');
%axis([-0.6 0.6 0 max(I2(round(size(I2,2)/2),:))+0.1])
grid on;
xlabel('x (m)'); ylabel('Irradiance');
title(['z=2000m ,',' \phi=',num2str(k*2),'\pi']);
end