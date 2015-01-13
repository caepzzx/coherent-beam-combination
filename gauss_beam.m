% sqr_beam propagation example
%
clear all;
L1=0.5; %side length
M=500; %number of samples
dx1=L1/M; %src sample interval
x1=-L1/2:dx1:L1/2-dx1; %src coords
y1=x1;
lambda=1030*10^-9; %wavelength
k=2*pi/lambda; %wavenumber
w=0.011; %source half width (m)
z=2000; %propagation dist (m)
deltad=0.015;
r=deltad-0.1*deltad;

[X1,Y1]=meshgrid(x1,y1);
u1=gauss(X1-deltad,Y1-deltad,r)+gauss(X1+deltad,Y1-deltad,r)+gauss(X1+deltad,Y1+deltad,r)+gauss(X1-deltad,Y1+deltad,r);
u1=u1/max(max(u1));
I1=abs(u1.^2); %src irradiance
%
figure(1)
imagesc(x1,y1,I1);
axis square; axis xy;
colormap('gray'); xlabel('x (m)'); ylabel('y (m)');
title('z= 0 m');
%
[u2,L2]=propFF(u1,L1,lambda,z);
dx2=L2/M;
x2=-L2/2:dx2:L2/2-dx2; %obs ords
y2=x2;
I2=abs(u2.^2);
figure,imagesc(x2,y2,nthroot(I2,3));%stretch image contrast
xlabel('x (m)'); ylabel('y (m)');
title('z= 2000 m');
figure,plot(x2,I2(round(size(I2,2)/2),:),'-');
axis([-0.6 0.6 0 max(I2(round(size(I2,2)/2),:))+0.1])
grid on;
xlabel('x (m)'); ylabel('Irradiance');
title('z= 2000 m');