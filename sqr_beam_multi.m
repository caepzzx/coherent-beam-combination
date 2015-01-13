% sqr_beam propagation example
%
clear all;
L1=0.5; %side length
M=250; %number of samples
dx1=L1/M; %src sample interval
x1=-L1/2:dx1:L1/2-dx1; %src coords
y1=x1;
lambda0=1030*10^-9; %wavelength
deltalambda=90*10^-9;
k=2*pi/lambda0; %wavenumber
w=0.011; %source half width (m)
z=2000; %propagation dist (m)
deltad=0.015;

[X1,Y1]=meshgrid(x1,y1);
u1=rect((X1-deltad)/(2*w)).*rect((Y1-deltad)/(2*w))+rect((X1+deltad)/(2*w)).*rect((Y1+deltad)/(2*w))...
    +rect((X1+deltad)/(2*w)).*rect((Y1-deltad)/(2*w))+rect((X1-deltad)/(2*w)).*rect((Y1+deltad)/(2*w)); %src field
I1=abs(u1.^2); %src irradiance
%
figure(1)
imagesc(x1,y1,I1);
axis square; axis xy;
colormap('gray'); xlabel('x (m)'); ylabel('y (m)');
title('z= 0 m');
u2=zeros(M,M);
for lambda=lambda0-deltalambda/2:deltalambda/500:lambda0+deltalambda/2-deltalambda/500;
[u2t,L2]=propFF(u1,L1,lambda,z);
u2=u2+u2t;
end
dx2=L2/M;
x2=-L2/2:dx2:L2/2-dx2; %obs ords
y2=x2;
I2=abs(u2.^2);
figure,imagesc(x2,y2,nthroot(I2,3));%stretch image contrast