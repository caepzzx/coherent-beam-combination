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

mkdir data;%create a folder to save results
directory=[cd,'\data\'];

%% transform between different bandwidth units
t0=20;%fs duration
t0=t0*10^-15;%transform unit
DeltaV=0.5/t0; %frequency difference hz
deltalamda=lambda0^2*DeltaV/(3e8);%wavelength nm
%% main body
[X1,Y1]=meshgrid(x1,y1);
infield=inputfield;

% vx=linspace(-2,2,500);%vector of x-axis of image plane (piston)
vx=0;
vy=0;%vector of x-axis of image plane (tilt)
vy=[0,vy];

%preallocate space of struct parameter
parameter(numel(vx),numel(vy))=struct('idx',[],'SR',[],'EC',[],'maxI',[],'piston',[],'tilt',[]);
%calculate imagine plane field distribution
for i=1:numel(vx)
    for j=1:numel(vy)
    phi=[0,vx(i)*2*pi,vx(i)*2*pi,0];%adjust piston
    u1=u1dis(phi,X1,Y1,deltad,r,2,vy(j)*20e-6,0); %src field adjust tilt
    u1=u1/max(max(u1));
    I1=abs(u1.^2); %src irradiance
%input field
    if i==1 && j==1
    h1=figure(1);
    imagesc(x1,y1,I1);
    axis square; axis xy;
    colormap('gray'); xlabel('x (m)'); ylabel('y (m)');
    title('z= 0 m');
    saveas(gcf,[directory,'input_field','fig']);
    close(h1)
 %calculate output field   
    lambda=infield.lambda;%consider spectrum distribution 
    end
    u2=zeros([size(u1),size(lambda,2)]);
    for k=1:size(infield.lambda,2)
       [u2(:,:,k),L2]=propFF(u1*infield.spectrum(k),L1,infield.lambda(k),z);
    end
    u3=sum(u2,3);
    dx2=L2/M;
    x2=-L2/2:dx2:L2/2-dx2; %obs ords
    y2=x2;
    I2=abs(u3.^2);
    h2=figure;
    imagesc(x2,y2,nthroot(I2,3));%stretch image contrast
    xlabel('x (m)'); ylabel('y (m)');
    title(['z=2m ,',' \phi=',num2str(vx(i)*2),'\pi',' tilt=',num2str(vy(j)*20),'\murad']);
    saveas(gcf,[directory,'output_field_','phi=',num2str(vx(i)*2),'pi',' tilt=',num2str(vy(j)*20),'murad','.fig']);
    close(h2)
    
    h3=figure;
    plot(x2,I2(round(size(I2,2)/2),:),'-');
    xlabel('x (m)'); ylabel('irradiance');
    title(['z=2m ,',' \phi=',num2str(vx(i)*2),'\pi',' tilt=',num2str(vy(j)*20),'\murad']);
    saveas(gcf,[directory,'transverse_irradiance_','phi=',num2str(vx(i)*2),'pi',' tilt=',num2str(vy(j)*20),'murad','.fig']);
    close(h3)
%axis([-0.6 0.6 0 max(I2(round(size(I2,2)/2),:))+0.1])
% grid on;
% xlabel('x (m)'); ylabel('Irradiance');
% title(['z=2m ,',' \phi=',num2str(vx(i)*2),'\pi',' tilt=',num2str(vy(j)*20),'\murad']);

%%Calculate Strehl Ratio
%Strehl=struct('idx',zeros(numel(i),numel(j)),'SR',zeros(numel(i),numel(j)));
    parameter(i,j).idx=['phi=',num2str(vx(i)*2),'pi',' tilt=',num2str(vy(j)*20),'murad'];
    parameter(i,j).piston=vx(i)*2;
    parameter(i,j).tilt=vy(j)*20;
if vx(i)==0 && vy(j)==0
    maxI=max(max(I2));
    parameter(i,j).SR=1;
    parameter(i,j).maxI=maxI;
else
    parameter(i,j).SR=max(max(I2))/maxI;
end
%%Calculate encircled energy ratio
%Calculate diffraction limit
%     [row,col]=find(I2==max(max(I2))); 
%     row=mean(row);
%     col=mean(col);
    radius=4e-6;%radius of circle which is used to calculate encircled energy
    radius=radius/L2*size(I2,1);%unit transform between meter and pixel
    [X2,Y2]=meshgrid(1:size(I2,1),1:size(I2,2));
    mask=(X2-round(size(I2,1)/2)).^2+(Y2-round(size(I2,2)/2)).^2<radius^2;
    mask=double(mask);
    parameter(i,j).EC=sum(sum(mask.*I2))/sum(sum(I2));
    h4=figure;
    imshow(I2);
    viscircles([round(size(I2,1)/2),round(size(I2,2)/2)],radius);
    saveas(gcf,[directory,'fig_EC_','phi=',num2str(vx(i)*2),'pi',' tilt=',num2str(vy(j)*20),'murad','.fig'])
    close(h4)
    end
end
 save([directory,'parameter_',num2str(now),'.mat'],'parameter');%save values of SR and EC of every iteration 
 close all;
%  clear all;
 