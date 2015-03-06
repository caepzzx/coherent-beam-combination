% gauss_chirped_beam_multi_chromic propagation example
%
clear all;
L1=7.4; %side length
M=500; %number of samples
dx1=L1/M; %src sample interval
x1=-L1/2:dx1:L1/2-dx1; %src coords
y1=x1;
lambda0=1030*10^-9; %wavelength
deltalambda=90*10^-9;
k=2*pi/lambda0; %wavenumber
z=2; %propagation dist (m)
r=0.3/2;%aperture (m) source field radius
deltad=r/0.9;%source field distance between beam

%% transform between different bandwidth units
t0=20;%fs duration
t0=t0*10^-15;%transform unit
DeltaV=0.5/t0; %frequency difference hz
deltalamda=lambda0^2*DeltaV/(3e8);%wavelength nm
%% main body
[X1,Y1]=meshgrid(x1,y1);
infield=inputfield;
for i=0
    for j=0
    phi=[0,i*2*pi,i*2*pi,0];%adjust piston
    u1=u1dis(phi,X1,Y1,deltad,r,2,j*20e-6,0); %src field adjust tip/tilt
    u1=u1/max(max(u1));
    I1=abs(u1.^2); %src irradiance
%
    figure(1)
    imagesc(x1,y1,I1);
    axis square; axis xy;
    colormap('gray'); xlabel('x (m)'); ylabel('y (m)');
    title('z= 0 m');
    lambda=infield.lambda;%consider spectrum distribution
    
   u2=zeros([size(u1),size(lambda,2)]);
    for k=1:size(infield.lambda,2)
       [u2(:,:,k),L2]=propFF(u1*infield.spectrum(k),L1,infield.lambda(k),z);
    end
    u3=sum(u2,3);
dx2=L2/M;
x2=-L2/2:dx2:L2/2-dx2; %obs ords
y2=x2;
I2=abs(u3.^2);
figure,imagesc(x2,y2,nthroot(I2,3));%stretch image contrast
xlabel('x (m)'); ylabel('y (m)');
title(['z=2m ,',' \phi=',num2str(i*2),'\pi',' tip=',num2str(j*20),'\murad']);
figure,plot(x2,I2(round(size(I2,2)/2),:),'-');
%axis([-0.6 0.6 0 max(I2(round(size(I2,2)/2),:))+0.1])
grid on;
xlabel('x (m)'); ylabel('Irradiance');
title(['z=2m ,',' \phi=',num2str(i*2),'\pi',' tip=',num2str(j*20),'\murad']);
if i=0
    end
end