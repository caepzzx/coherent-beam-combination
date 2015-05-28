clear all
close all
%%calculate wavefront

L=37.2e-2;%side length of wavefront(m)
M=100;
dx=L/M;
x=-L/2:dx:L/2-dx;
y=x;

sgrmin=2; %min value of sgx
sgrmax=12; %max value of sgx
ppp=10;%number of calculated phi per each parameter

[X,Y]=meshgrid(x,y);
k=1;
phi=zeros(M,M,(sgrmax-sgrmin+1)*ppp);%Initiate phi matrix

    for i=2:sgrmax
        for j=1:ppp
        a=2.*rand(numel(x),numel(y))-1;
        sgx=i*1e-2;
        sgy=i*1e-2;
        b=exp(-((X/sgx).^2+(Y/sgy).^2));
        phi(:,:,k)=conv2(a,b,'same');
    %     figure,mesh(x,y,phi(:,:,k));
        k=k+1;
        end
    end

save('wavefront.mat','phi')
clear i j k
%%irradiance distribution of each beam
E0=10;
R0=17*1e-2;
l=10;
E=E0*exp(-((X/R0).^(2*l)+(Y/R0).^(2*l)));
% figure,imshow(E,[])

%%coherent beam combination
%in-phase mode irridance distribution
L1=7;%side length
x1=-L1/2:dx:L1/2-dx;%src coords
y1=x1;
N=numel(x1);
lambda0=1053e-9;%central wavelength
k=2*pi/lambda0;%wavenumber
z=2;%propagation dist (m)
deltad=2e-3;%source field distance between beam
[X1,Y1]=meshgrid(x1,y1);

u1=zeros(numel(x1),numel(y1));

center=[round(size(u1,1)/2),round(size(u1,2)/2)];
dxc=round(L/(2*L1)*size(u1,1));
dyc=round(L/(2*L1)*size(u1,2));

E(:,round(size(E,2)/2)-round(deltad/(2*L)*size(E,2)):round(size(E,2)/2)+round(deltad/(2*L)*size(E,2)))=0;
u1((center(1)-dyc):(center(1)-dyc+M-1),(center(2)-dxc):(center(2)-dxc+M-1))=E;

%source field
% mesh(atan(imag(u1)./real(u1)))
I1=abs(u1.*2); %src irradiance
%
figure(1)
% imagesc(x1,y1,I1);
% axis square; axis xy;
% xlabel('x (m)'); ylabel('y (m)');
% title('z= 0 m');

[u2,L2]=propFF(u1,L1,lambda0,z);
dx2=lambda0*z/L1;
x2=-L2/2:dx2:L2/2-dx2;%obs ords
y2=x2;
I2=abs(u2.^2);
% figure,imagesc(x2,y2,nthroot(I2,3));
[pks1,locs1]=findpeaks(-I2(round(size(I2,1)/2),:),x2);
% plot(x2,I2(round(size(I2,1)/2),:));
% hold on
% plot(locs1,-pks1,'*');

rdl=min(abs(locs1));%radius of diffraction limit
maxI2=max(max(I2));%maxium of irridiance for in-phase mode

%%Calculate result and wavefront parameter
ophi=phi;
Numofpoint=50;
parameter(Numofpoint)=struct('idx',[],'SR',[],'ECdl',[],...
    'rof80',[],'PV',[],'RMS',[],'GRMS',[],'GPV',[],'I2',[]);
for c=0.3:0.1:0.9
phi=ophi*c;
% phi=cat(3,0.02*phi,0.1*phi,0.15*phi,0.2*phi);

for k=1:Numofpoint
    u1=zeros(numel(x1),numel(y1));
    idxphi=round(rand*size(phi,3));
    parameter(k).idx=k;
    u1((center(1)-dyc):(center(1)-dyc+M-1),(center(2)-dxc):(center(2)-dxc+M-1))=E.*exp(i...
        *phi(:,:,idxphi));
    [u2,L2]=propFF(u1,L1,lambda0,z);
    I2=abs(u2.^2);
    parameter(k).I2=I2(1:4:end,1:4:end);
    parameter(k).SR=max(max(I2))/maxI2;
    parameter(k).ECdl=ECenergy(rdl,I2,L2);
    %%Calculate radius of 80% encircled energy
    rof80=0.78*rdl;
    while ECenergy(rof80,I2,L2)<0.8
            rof80=1.01*rof80;
    end
    parameter(k).rof80=rof80;
    
    %%Calculate wavefront parameter
    
    dphi=phi(:,1:size(phi,2)/2,idxphi)...
        
        -phi(:,size(phi,2)/2+1:end,idxphi);
    
%     h4=figure;
%     imshow(I2);
%     viscircles([round(size(I2,1)/2),round(size(I2,2)/2)],radiusdl);
%     saveas(gcf,[directory,'fig_EC_','phi=',num2str(vx(i)*2),'pi',' tilt=',num2str(vy(j)*20),'murad','.fig'])
%     close(h4)
    
    parameter(k).PV=peak2peak(peak2peak(dphi)/(2*pi));   %
    parameter(k).RMS=rms(rms(dphi))/(2*pi);
    [gx,gy] = gradient(dphi/(2*pi),dx*1e2);%transform unit
    grad=sqrt(gx.^2+gy.^2);
    parameter(k).GRMS=rms(rms(grad));
    parameter(k).GPV=peak2peak(peak2peak(grad));
end
save(['parameter_',num2str(now),'.mat'],'parameter','phi');%save result
% close all;
end
% 
% end