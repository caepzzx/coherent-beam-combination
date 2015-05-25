% sqr_beam propagation example
 %
L1=0.5; %side length
M=1000; %number of samples
dx1=L1/M; %src sample interval
x1=-L1/2:dx1:L1/2-dx1; %src coords
y1=x1;
lambda=0.5*10^-6; %wavelength
k=2*pi/lambda; %wavenumber
w=0.051; %source half width (m)
z=2000; %propagation dist (m)

[X1,Y1]=meshgrid(x1,y1);
u1=rect(X1/(2*w)).*rect(Y1/(2*w)); %src field
u1t=rect(X1/(2*w)).*rect(Y1/(2*w))*exp(i*pi/3); %src field
I1=abs(u1.^2); %src irradiance

figure(1)
imagesc(x1,y1,I1);
axis square; axis xy;
colormap('gray'); xlabel('x (m)'); ylabel('y (m)');
title('z= 0 m');
u2=propFF2(u1,L1,lambda,z); %propagation
u2t=propFF2(u1t,L1,lambda,z);

x2=x1; %obs coords
y2=y1;
I2=abs(u2.^2); %obs irrad
I2t=abs(u2t.^2); %obs irrad

% figure(2) %display obs irrad
% imagesc(x2,y2,I2);
% axis square; axis xy;
% colormap('gray'); xlabel('x (m)'); ylabel('y (m)');
% title(['z= ',num2str(z),' m']);

 figure(3) %irradiance profile
 plot(x2,I2(M/2+1,:),'--r',x2,I2t(M/2+1,:),'-.b',x2,I2(M/2+1,:)+I2t(M/2+1,:),'-k');
 xlabel('x (m)'); ylabel('Irradiance');
 title(['z= ',num2str(z),' m']);
%
%  figure(4) %plot obs field mag
% plot(x2,abs(u2(M/2+1,:)));
% xlabel('x (m)'); ylabel('Magnitude');
%  title(['z= ',num2str(z),' m']);
% %
%  figure(5) %plot obs field phase
% plot(x2,unwrap(angle(u2(M/2+1,:))));
% xlabel('x (m)'); ylabel('Phase (rad)');
% title(['z= ',num2str(z),' m']);