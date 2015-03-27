clear all
close all
%%calculate wavefront

L=150e-3;%side length of wavefront(m)
M=50;
dx=L/M;
x=-L/2:dx:L/2-dx;
y=x;

sgrmin=2; %min value of sgx
sgrmax=12; %max value of sgx
ppp=10;%number of calculated phi per each parameter

[X,Y]=meshgrid(x,y);
k=1;
phi=zeros(M,M,(sgrmax-sgrmin+1)*ppp);%Initiate phi matrix
for c=[0.06,0.08,1.2,2,3]
    for i=2:sgrmax
        for j=1:ppp
        a=2.*rand(numel(x),numel(y))-1;
        sgx=i*1e-2;
        sgy=i*1e-2;
        b=exp(-((X/sgx).^2+(Y/sgy).^2));
        phi(:,:,k)=c*conv2(a,b,'same');
    %     figure,mesh(x,y,phi(:,:,k));
        k=k+1;
        end
    end

save('wavefront.mat','phi')

clear i j k
%%irradiance distribution of each beam
E0=1000;
R0=130*1e-3;
E=E0*exp(-((X.^2+Y.^2))./R0^2);
% figure,imshow(E,[])

%%coherent beam combination
%in-phase mode irridance distribution
L1=8;%side length
x1=-L1/2:dx:L1/2-dx;%src coords
y1=x1;
N=numel(x1);
lambda0=1053e-9;%central wavelength
k=2*pi/lambda0;%wavenumber
z=2;%propagation dist (m)
deltad=10e-3;%source field distance between beam
[X1,Y1]=meshgrid(x1,y1);

u1=zeros(numel(x1),numel(y1));

center=[round(size(u1,1)/2),round(size(u1,2)/2)];
dxc=round(deltad/(2*L1)*size(u1,1));
dyc=round(L/(2*L1)*size(u1,2));
u1((center(1)-dyc):(center(1)-dyc+M-1),(center(2)+dxc):(center(2)+dxc+M-1))=E.*exp(1j.*0);
u1((center(1)-dyc):(center(1)-dyc+M-1),(center(2)-dxc):-1:(center(2)-dxc-(M-1)))=E.*exp(1j.*0);
%source field
% mesh(atan(imag(u1)./real(u1)))
I1=abs(u1.*2); %src irradiance
%
% figure(1)
% imagesc(x1,y1,I1);
% axis square; axis xy;
% xlabel('x (m)'); ylabel('y (m)');
% title('z= 0 m');

% [u2,L2]=propFF2(u1,L1,lambda0,z);
% dx2=lambda0*z/L1;
% x2=-L2/2:dx2:L2/2-dx2;%obs ords
% y2=x2;
% I2=abs(u2.^2);
% figure,imagesc(x2,y2,nthroot(I2,3));
maxI2=max(max(I2));%maxium of irridiance for in-phase mode

radius=2e-6;%radius of circle which is used to calculate encircled energy
radius=radius/L2*size(I2,1);%unit transform between meter and pixel
[X2,Y2]=meshgrid(1:size(I2,1),1:size(I2,2));
mask=(X2-round(size(I2,1)/2)).^2+(Y2-round(size(I2,2)/2)).^2<radius^2;
mask=double(mask);
   

Numofpoint=50;
parameter(Numofpoint)=struct('idx',[],'idxbeam1phi',[],'idxbeam2phi',[],'SR',[],'EC',[],...
    'PV',[],'RMS',[],'GRMS',[],'GPV',[],'I2',[]);
for k=1:Numofpoint
    u1=zeros(numel(x1),numel(y1));
    idxphi1=round(rand*size(phi,3));
%     idxphi1=250;
    idxphi2=round(rand*size(phi,3));
%     idxphi2=k;
    parameter(k).idx=k;
    parameter(k).idxbeam1phi=idxphi1;
    parameter(k).idxbeam2phi=idxphi2;
    u1((center(1)-dyc):(center(1)-dyc+M-1),(center(2)+dxc):(center(2)+dxc+M-1))=E.*exp(1j.*phi(:,:,idxphi1));
    u1((center(1)-dyc):(center(1)-dyc+M-1),(center(2)-dxc):-1:(center(2)-dxc-(M-1)))=E.*exp(1j.*phi(:,:,idxphi2));
    [u2,L2]=propFF2(u1,L1,lambda0,z);
    I2=abs(u2.^2);
    parameter(k).I2=I2(1:4:end,1:4:end);
    parameter(k).SR=max(max(I2))/maxI2;
    parameter(k).EC=sum(sum(mask.*I2))/sum(sum(I2));
    
    dphi=phi(:,:,idxphi1)-phi(:,:,idxphi2);
    
%     h4=figure;
%     imshow(I2);
%     viscircles([round(size(I2,1)/2),round(size(I2,2)/2)],radius);
%     saveas(gcf,[directory,'fig_EC_','phi=',num2str(vx(i)*2),'pi',' tilt=',num2str(vy(j)*20),'murad','.fig'])
%     close(h4)
    
    parameter(k).PV=(max(max(dphi))-min(min(dphi)))/(2*pi);   %
    parameter(k).RMS=sqrt(trapz(y,trapz(x,dphi.^2,2))/L^2)/(2*pi);
    [gx,gy] = gradient(dphi,dx);
    grad=sqrt(gx.^2+gy.^2);
    parameter(k).GRMS=trapz(y,trapz(x,grad.^2,2))/L^2;
    parameter(k).GPV=max(max(grad))-min(min(grad));
end
save(['parameter_',num2str(now),'.mat'],'parameter','phi');%save result
close all;
clear phi parameter;
end