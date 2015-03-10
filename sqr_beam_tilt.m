% sqr_beam propagation example
%Try to describe the tilt wavefront in near field
L1=0.5; %side length
M=5000; %number of samples
dx1=L1/M; %src sample interval
x1=-L1/2:dx1:L1/2-dx1; %src coords
y1=x1;
lambda=0.5*10^-6; %wavelength
k=2*pi/lambda; %wavenumber
w=0.051; %source half width (m)
z=2000; %propagation dist (m)

[X1,Y1]=meshgrid(x1,y1);
u1=rect(X1/(2*w)).*rect(Y1/(2*w)); %src field
I1=abs(u1.^2); %src irradiance
%
figure(1)
imagesc(x1,y1,I1);
axis square; axis xy;
colormap('gray'); xlabel('x (m)'); ylabel('y (m)');
title('z= 0 m');
deg=pi/180;
alpha=5.0e-5; %rad
theta=45*deg;
[u1]=tilt(u1,L1,lambda,alpha,theta);
I1=abs(u1.^2); %tilt irradiance
figure(2)
mesh(X1,Y1,imag(u1));
