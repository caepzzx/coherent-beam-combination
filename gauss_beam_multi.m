% gauss_trans_limit_beam_multi_choronic propagation example
%
clear all;
L1=7.4; %side length
M=500; %number of samples
dx1=L1/M; %src sample interval
x1=-L1/2:dx1:L1/2-dx1; %src coords
y1=x1;
lambda0=1030*10^-9; %wavelength
deltalambda=90*10^-9;%linewidth
k=2*pi/lambda0; %wavenumber
z=2; %propagation dist (m)
r=0.3/2;%aperture (m)
deltad=r/0.9;%source field distance between beam
l=2;%super gaussian distribution order
phi0=0;%0 order spectrum phase
d1phi=8.5*(1e-12);%group delay 
d2phi=5.47e4*(1e-12)^2;%group delay dispersion
d3phi=3.76e4*(1e-12)^3;%third order dispersion

[X1,Y1]=meshgrid(x1,y1);
%%phased tilt piston equal zeros
    %near field
	phi=zeros(1,4);
    u1=u1dis(phi,X1,Y1,deltad,r,2,0,0);%src field
    I1=abs(u1.^2); %src irradiance
    I1=I1/max(max(I1));
    figure(1),plot(x1,I1(round(size(I1,2)/2),:),'-');
    grid on;
    xlabel('x (m)'); ylabel('Irradiance');
    title('z=0m(Phased)');
    figure(2)
    imagesc(x1,y1,I1);
    axis square; axis xy;axis([-1,1,-1,1])
    colormap('gray'); xlabel('x (m)'); ylabel('y (m)');
    title('z= 0 m(Phased)');
    %far field
    u2=zeros(M,M);
    lambda=(lambda0-deltalambda/2):deltalambda/M:(lambda0+deltalambda/2-deltalambda/M);
    spectrum=spec(lambda,lambda0,deltalambda,l,phi0,d1phi,d2phi,d3phi);
    u1t=zeros(M,M,length(lambda));
    for k=1:length(lambda)
    u1t(:,:,k)=u1*spectrum(k);%consider spectrum distribution
    end
    [u2t,L2]=propFF(u1t,L1,lambda,z);
    u2=u2+u2t;
   
dx2=L2/M;
x2=-L2/2:dx2:L2/2-dx2; %obs ords
y2=x2;
I2=abs(u2.^2);
I2phased=max(max(I2));%far field max when phased
figure,imagesc(x2,y2,nthroot(I2,3));%stretch image contrast
xlabel('x (m)'); ylabel('y (m)');
title(['z=',num2str(z),'m' ,' \phi=',num2str(0),'\pi',' tip=',num2str(0),'\murad']);

%%
figure,plot(x2,I2(round(size(I2,2)/2),:),'-');
grid on;
xlabel('x (m)'); ylabel('Irradiance');
title(['z=',num2str(z),'m' ,' \phi=',num2str(0),'\pi',' tip=',num2str(0),'\murad']);
 
u2=zeros(M,M);
    
for i=0
    for j=0
phi=[0,i*2*pi,i*2*pi,0];%adjust piston
u1=u1dis(phi,X1,Y1,deltad,r,2,j*20e-6,0)*spec(lambda,lambda0,deltalambda,l,phi0,d1phi,d2phi,d3phi); %src field adjust tip/tilt
u1=u1/max(max(u1));
I1=abs(u1.^2); %src irradiance

%%
u2=zeros(M,M);
for lambda=(lambda0-deltalambda/2):deltalambda/500:(lambda0+deltalambda/2-deltalambda/M);
u1t=u1.*spec(lambda,lambda0,deltalambda);%consider spectrum distribution
[u2t,L2]=propFF(u1t,L1,lambda,z);
u2=u2+u2t;
end
%%
dx2=L2/M;
x2=-L2/2:dx2:L2/2-dx2; %obs ords
y2=x2;
I2=abs(u2.^2);
figure,imagesc(x2,y2,nthroot(I2,3));%stretch image contrast
xlabel('x (m)'); ylabel('y (m)');
title(['z=',num2str(z),'m' ,' \phi=',num2str(i*2),'\pi',' tip=',num2str(j*20),'\murad']);

%%
figure,plot(x2,I2(round(size(I2,2)/2),:),'-');
grid on;
xlabel('x (m)'); ylabel('Irradiance');
title(['z=',num2str(z),'m' ,' \phi=',num2str(i*2),'\pi',' tip=',num2str(j*20),'\murad']);
    end
end