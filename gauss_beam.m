% gaussian_beam propagation example
%
clear all;
L1=7.4; %side length
M=1000; %number of samples
dx1=L1/M; %src sample interval
x1=-L1/2:dx1:L1/2-dx1; %src coords
y1=x1;
lambda=1030*10^-9; %wavelength
k=2*pi/lambda; %wavenumber
w=0.011; %source half width (m)
z=2; %propagation dist (m)
deltad=0.015;%distance between apertures and center (m)
r=0.3/2; %aperture (m)
deltad=r/0.9;
[X1,Y1]=meshgrid(x1,y1);
for i=0
    for j=0
    phi=[0,i*2*pi,i*2*pi,0];%adjust piston
    u1=u1dis(phi,X1,Y1,deltad,r,2,j*20e-6,0);%src field adjust tip/tilt
    u1=u1/max(max(u1));
    I1=abs(u1.^2); %src irradiance

    figure(1),plot(x1,I1(round(size(I1,2)/2),:),'-');
    grid on;
    xlabel('x (m)'); ylabel('Irradiance');
    title('z=0m');

figure(2)
imagesc(x1,y1,I1);
axis square; axis xy;axis([-1,1,-1,1]);
colormap('gray'); xlabel('x (m)'); ylabel('y (m)');
title('z= 0 m');

%
[u2,L2]=propFF(u1,L1,lambda,z);
dx2=L2/M;
x2=-L2/2:dx2:L2/2-dx2; %obs ords
y2=x2;
I2=abs(u2.^2);
I2=I2/max(max(I2));
figure,imagesc(x2,y2,nthroot(I2,3));%stretch image contrast
axis([-100e-6,100e-6,-100e-6,100e-6])

xlabel('x (m)'); ylabel('y (m)');
title(['z=',num2str(z),'m' ,' \phi=',num2str(i*2),'\pi ',' tip=',num2str(j*20),'\murad']);
figure,plot(x2,I2(round(size(I2,2)/2),:),'-');
axis([-100e-6,100e-6,0,1.2])
grid on;
xlabel('x (m)'); ylabel('Irradiance');
title(['z=',num2str(z),'m' ,' \phi=',num2str(i*2),'\pi ',' tip=',num2str(j*20),'\murad']);
    end
end