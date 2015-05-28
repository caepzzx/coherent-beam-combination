clear all
close all
%%calculate wavefront

%%initial parameter
lambda0=910e-9;%central wavelength
deltad=10e-3;%spatial interval between two beams
L1=3;%side width of object plane

M=36;
L=150e-3;
z=2;
dx=L/M;
x=-L/2:dx:L/2-dx; 
y=x; 
[X,Y]=meshgrid(x,y);

w=150e-3;%aperture of beams
% E0=100;
% R0=100e-3;
% l=10;6


%% generate random phase screen
%phi(x-coordinate,y-coordinate,index of lambda,index of phase screen)
%sgx,phasescreen parameter;ppp,num of phasescreen per each parameter
minPar=2;
maxPar=12;
numPerP=10;
phi=zeros(M,M,(maxPar-minPar+1)*numPerP);%Initiate phi matrix
k=1;
    for i=minPar:maxPar
        for j=1:numPerP
        a=2.*rand(numel(x),numel(y))-1;
        sgx=i*1e-2;
        sgy=i*1e-2;
        b=exp(-((X/sgx).^2+(Y/sgy).^2));
        phi(:,:,k)=conv2(a,b,'same');
    %     figure,mesh(x,y,phi(:,:,k));
        k=k+1;
        end
    end

%% diffraction limit far-field intensity

%%coherent beam combination
%in-phase mode irridance distribution

x1=-L1/2:dx:L1/2-dx;%src coords
y1=x1;
[X1,Y1]=meshgrid(x1,y1);
u1=zeros(size(X1));
u1=setu1(0,0,u1,w,M,deltad,L1,X,Y);
% 
I1=abs(u1.*2); %src irradiance

% figure
% imagesc(x1,y1,I1);
% axis square; axis xy;
% xlabel('x (m)'); ylabel('y (m)');
% title('z= 0 m');

[u2,L2]=propFF(u1,L1,dx,lambda0,z);


dx2=lambda0*z/L1;
x2=-L2/2:dx2:L2/2-dx2;%obs ords
y2=x2;
[X2,Y2]=meshgrid(x2,y2);
I2=abs(u2.^2);
figure,imagesc(x2,y2,nthroot(I2,3));
%% find x-direction and y-direction diffraction limit
[pks1,locs1]=findpeaks(-I2(round(size(I2,1)/2),:),x2);
plot(x2,I2(round(size(I2,1)/2),:));
hold on
% plot(locs1,-pks1,'*');
rdlx=min(abs(locs1));%radius of diffraction limit

[pks2,locs2]=findpeaks(-I2(:,round(size(I2,2)/2)),y2);
plot(y2,I2(:,round(size(I2,2)/2)));
% hold on
% plot(locs2,-pks2,'*');
rdly=min(abs(locs2));%radius of diffraction limit
legend('x-direction intensity','y-direction intensity');

%% calculate max intensity and energy in diffraction limit 
maxI2=max(max(I2));%maxium of irridiance for in-phase mode
maxdlenergy=dlenergy(I2,rdlx,rdly,X2,Y2);

%% wave error same for two beams
 Numofpoint=50;  %Num of calcultaed point for a scale
 para_same(Numofpoint)=struct('SR',[],'SRdl',[],'ECdl',[],...
    'rof80',[],'PV',[],'RMS',[],'GRMS',[],'GPV',[],'I2',[]);

for scale=0.45:0.01:1.2;%scale factor for different wavefront
for m=1:Numofpoint
    idxphase=floor(rand*size(phi,3))+1;

    u1=setu1(scale*phi(:,:,idxphase),scale*phi(:,:,idxphase)...
   ,u1,w,M,deltad,L1,X,Y);
% 
% I1=abs(u1.*2); %src irradiance
% 
% figure
% imagesc(x1,y1,I1);
% axis square; axis xy;
% xlabel('x (m)'); ylabel('y (m)');
% title('z= 0 m');

[u2,L2]=propFF(u1,L1,dx,lambda0,z);
% dx2=lambda(k)*z/L1;
% x2=-L2/2:dx2:L2/2-dx2;%obs ords
% y2=x2;
% [X2,Y2]=meshgrid(x2,y2);
    I2=abs(sum(u2,3).^2);
%     figure,imagesc(x2,y2,nthroot(I2,3));
    para_same(m).I2=I2(1:2:end,1:2:end);
    para_same(m).SR=max(max(I2))/maxI2;
    para_same(m).SRdl=dlenergy(I2,rdlx,rdly,X2,Y2)/maxdlenergy;
    para_same(m).ECdl=ECenergySquare(I2,rdlx,rdly,X2,Y2 );
%     %Calculate radius of 80% encircled energy
%     rof80x=rdlx;
%     rof80y=rdly;
%     while ECenergySquare(I2,rof80x,rof80y,X2,Y2 )<0.8
%             rof80x=rof80x+0.01*rdlx;
%             rof80y=rof80y+0.01*rdly;
%     end
%     para_same(m).rof80=[rof80x,rof80y];
%     
    dphi=scale*phi(:,:,idxphase);
    para_same(m).PV=peak2peak(peak2peak(dphi)/(2*pi));   %
    para_same(m).RMS=rms(rms(dphi))/(2*pi);
    [gx,gy] = gradient(dphi/(2*pi),dx*1e2);%transform unit
    grad=sqrt(gx.^2+gy.^2);
    para_same(m).GRMS=rms(rms(grad));
    para_same(m).GPV=peak2peak(peak2peak(grad));
end
save(['E:\Wavefront20150513\mono\monoparsame_',num2str(scale),'.mat'],'para_same');%save result

end
clear para_same
%% second round of wave error same for two beams
Numofpoint=50;  %Num of calcultaed point for a scale
 para_same(Numofpoint)=struct('SR',[],'SRdl',[],'ECdl',[],...
    'rof80',[],'PV',[],'RMS',[],'GRMS',[],'GPV',[],'I2',[]);

for scale=0.6:0.01:1.2;%scale factor for different wavefront
for m=1:Numofpoint
    idxphase=floor(rand*size(phi,3))+1;

    u1=setu1(scale*phi(:,:,idxphase),scale*phi(:,:,idxphase)...
   ,u1,w,M,deltad,L1,X,Y);
% 
% I1=abs(u1.*2); %src irradiance
% 
% figure
% imagesc(x1,y1,I1);
% axis square; axis xy;
% xlabel('x (m)'); ylabel('y (m)');
% title('z= 0 m');

[u2,L2]=propFF(u1,L1,dx,lambda0,z);
% dx2=lambda(k)*z/L1;
% x2=-L2/2:dx2:L2/2-dx2;%obs ords
% y2=x2;
% [X2,Y2]=meshgrid(x2,y2);
    I2=abs(sum(u2,3).^2);
%     figure,imagesc(x2,y2,nthroot(I2,3));
    para_same(m).I2=I2(1:2:end,1:2:end);
    para_same(m).SR=max(max(I2))/maxI2;
    para_same(m).SRdl=dlenergy(I2,rdlx,rdly,X2,Y2)/maxdlenergy;
    para_same(m).ECdl=ECenergySquare(I2,rdlx,rdly,X2,Y2 );
%     %Calculate radius of 80% encircled energy
%     rof80x=rdlx;
%     rof80y=rdly;
%     while ECenergySquare(I2,rof80x,rof80y,X2,Y2 )<0.8
%             rof80x=rof80x+0.01*rdlx;
%             rof80y=rof80y+0.01*rdly;
%     end
%     para_same(m).rof80=[rof80x,rof80y];
    
    dphi=scale*phi(:,:,idxphase);
    para_same(m).PV=peak2peak(peak2peak(dphi)/(2*pi));   %
    para_same(m).RMS=rms(rms(dphi))/(2*pi);
    [gx,gy] = gradient(dphi/(2*pi),dx*1e2);%transform unit
    grad=sqrt(gx.^2+gy.^2);
    para_same(m).GRMS=rms(rms(grad));
    para_same(m).GPV=peak2peak(peak2peak(grad));
end
save(['E:\Wavefront20150513\mono\monoparsame2_',num2str(scale),'.mat'],'para_same');%save result
end
clear para_same
save initialdata

% system('shutdown -s');
%% wave error for two beams is different
Numofpoint=50;%Num of calcultaed point for a scale
filepath='E:\Wavefront20150513\mono\diffwave\';

para_diff(Numofpoint)=struct('SR',[],'SRdl',[],'ECdl',[],...
    'rof80',[],'PV',[],'RMS',[],'GRMS',[],'GPV',[],'I2',[]);
for scale=0.05:0.01:1.2;%scale factor for different wavefront
for m=1:Numofpoint
    idxphase1=floor(rand*size(phi,3))+1;
    idxphase2=floor(rand*size(phi,3))+1;
    while idxphase1==idxphase2
        idxphase2=floor(rand*size(phi,4))+1;
    end


x1=-L1/2:dx:L1/2-dx;
y1=x1;
[X1,Y1]=meshgrid(x1,y1);
u1=zeros(size(X1));


u1=setu1(scale*phi(:,:,idxphase1),scale*phi(:,:,idxphase2)...
     ,u1,w,M,deltad,L1,X,Y);
% 
% I1=abs(u1.*2); %src irradiance
% 
% figure
% imagesc(x1,y1,I1);
% axis square; axis xy;
% xlabel('x (m)'); ylabel('y (m)');
% title('z= 0 m');
   [u2,L2]=propFF(u1,L1,dx,lambda0,z);
% dx2=lambda(k)*z/L1;
% x2=-L2/2:dx2:L2/2-dx2;%obs ords
% y2=x2;
% [X2,Y2]=meshgrid(x2,y2);
    I2=abs(u2.^2);
%     figure,imagesc(x2,y2,nthroot(I2,3));
    para_diff(m).I2=I2(1:2:end,1:2:end);
    para_diff(m).SR=max(max(I2))/maxI2;
    para_diff(m).SRdl=dlenergy(I2,rdlx,rdly,X2,Y2)/maxdlenergy;
    para_diff(m).ECdl=ECenergySquare(I2,rdlx,rdly,X2,Y2 );
%     %Calculate radius of 80% encircled energy
%     rof80x=rdlx;
%     rof80y=rdly;
%     while ECenergySquare(I2,rof80x,rof80y,X2,Y2 )<0.8
%             rof80x=rof80x+0.15*rof80x;
%             rof80y=rof80y+0.15*rof80y;
%     end
%     para_diff(m).rof80=[rof80x,rof80y];
    
    dphi=scale*phi(:,:,idxphase1)-scale*phi(:,:,idxphase2);
    para_diff(m).PV=peak2peak(peak2peak(dphi)/(2*pi));   %
    para_diff(m).RMS=rms(rms(dphi))/(2*pi);
    [gx,gy] = gradient(dphi/(2*pi),dx*1e2);%transform unit
    grad=sqrt(gx.^2+gy.^2);
    para_diff(m).GRMS=rms(rms(grad));
    para_diff(m).GPV=peak2peak(peak2peak(grad));
end
save([filepath,'pardiff_',num2str(scale),'.mat'],'para_diff');%save result

end
for scale=0.6:0.02:1.2;%scale factor for different wavefront
for m=1:Numofpoint
    idxphase1=floor(rand*size(phi,3))+1;
    idxphase2=floor(rand*size(phi,3))+1;
    while idxphase1==idxphase2
        idxphase2=floor(rand*size(phi,4))+1;
    end


x1=-L1/2:dx:L1/2-dx;
y1=x1;
[X1,Y1]=meshgrid(x1,y1);
u1=zeros(size(X1));


u1=setu1(scale*phi(:,:,idxphase1),scale*phi(:,:,idxphase2)...
     ,u1,w,M,deltad,L1,X,Y);
% 
% I1=abs(u1.*2); %src irradiance
% 
% figure
% imagesc(x1,y1,I1);
% axis square; axis xy;
% xlabel('x (m)'); ylabel('y (m)');
% title('z= 0 m');
   [u2,L2]=propFF(u1,L1,dx,lambda0,z);
% dx2=lambda(k)*z/L1;
% x2=-L2/2:dx2:L2/2-dx2;%obs ords
% y2=x2;
% [X2,Y2]=meshgrid(x2,y2);
    I2=abs(u2.^2);
%     figure,imagesc(x2,y2,nthroot(I2,3));
    para_diff(m).I2=I2(1:2:end,1:2:end);
    para_diff(m).SR=max(max(I2))/maxI2;
    para_diff(m).SRdl=dlenergy(I2,rdlx,rdly,X2,Y2)/maxdlenergy;
    para_diff(m).ECdl=ECenergySquare(I2,rdlx,rdly,X2,Y2 );
%     %Calculate radius of 80% encircled energy
%     rof80x=rdlx;
%     rof80y=rdly;
%     while ECenergySquare(I2,rof80x,rof80y,X2,Y2 )<0.8
%             rof80x=rof80x+0.15*rof80x;
%             rof80y=rof80y+0.15*rof80y;
%     end
%     para_diff(m).rof80=[rof80x,rof80y];
    
    dphi=scale*phi(:,:,idxphase1)-scale*phi(:,:,idxphase2);
    para_diff(m).PV=peak2peak(peak2peak(dphi)/(2*pi));   %
    para_diff(m).RMS=rms(rms(dphi))/(2*pi);
    [gx,gy] = gradient(dphi/(2*pi),dx*1e2);%transform unit
    grad=sqrt(gx.^2+gy.^2);
    para_diff(m).GRMS=rms(rms(grad));
    para_diff(m).GPV=peak2peak(peak2peak(grad));
end
save([filepath,'pardiff2_',num2str(scale),'.mat'],'para_diff');%save result

end
% clear u2 para_diff;
save monoinitialdata2
system('shutdown -s');

% %% piston error for two beams 
% filepath='E:\Wavefront20150513\mono\piston\';
% Numofpoint=120;%Num of calcultaed point for a scale
% piston=linspace(-2*pi,2*pi,Numofpoint);
% para_piston(Numofpoint)=struct('SR',[],'SRdl',[],'ECdl',[],...
%     'rof80',[],'piston',[],'I2',[]);
% 
% for m=1:Numofpoint
% 
% 
% u1=zeros(size(X1));
% 
% 
% u1=setu1(0,piston(m)...
%        ,u1,w,M,deltad,L1,X,Y);
% % I1=abs(u1.*2); %src irradiance
% % 
% % figure
% % imagesc(x1,y1,I1);
% % axis square; axis xy;
% % xlabel('x (m)'); ylabel('y (m)');
% % title('z= 0 m');
%  [u2,L2]=propFF(u1,L1,dx,lambda0,z);
% % dx2=lambda(k)*z/L1;
% x2=-L2/2:dx2:L2/2-dx2;%obs ords
% y2=x2;
% [X2,Y2]=meshgrid(x2,y2);
    I2=abs(u2.^2);
%     figure,imagesc(x2,y2,nthroot(I2,3));
    para_piston(m).I2=I2(1:2:end,1:2:end);
    para_piston(m).SR=max(max(I2))/maxI2;
    para_piston(m).SRdl=dlenergy(I2,rdlx,rdly,X2,Y2)/maxdlenergy;
    para_piston(m).ECdl=ECenergySquare(I2,rdlx,rdly,X2,Y2 );
%     %Calculate radius of 80% encircled energy
%     rof80x=rdlx;
%     rof80y=rdly;
%     while ECenergySquare(I2,rof80x,rof80y,X2,Y2 )<0.8
%             rof80x=rof80x+0.15*rof80x;
%             rof80y=rof80y+0.15*rof80y;
%     end
%     para_piston(m).rof80=[rof80x,rof80y];
    para_piston(m).piston=piston(m);
end
save([filepath,'parpiston','.mat'],'para_piston');%save 
% clear u2 para_piston;
% system('shutdown -s');
% %% tip/tilt error for two beams 
% filepath='E:\Wavefront20150513\tip\';
% Numofpoint=140;%Num of calcultaed point for a scale
% tip=linspace(-7e-6,7e-6,Numofpoint);
% para_tip(Numofpoint)=struct('SR',[],'SRdl',[],'ECdl',[],...
%     'rof80',[],'tip',[],'I2',[]);
% 
% for m=1:Numofpoint
%     
% x1=-L1/2:dx:L1/2-dx;
% y1=x1;
% [X1,Y1]=meshgrid(x1,y1);
% u1=zeros(size(X1));
% 
% 
% u1=setu1tilt(tip(m),0,u1,w,deltad,dx1(k),L1(k),M,spectrum(k),lambda(k));
% % 
% % I1=abs(u1.*2); %src irradiance
% % 
% % figure
% % imagesc(x1,y1,I1);
% % axis square; axis xy;
% % xlabel('x (m)'); ylabel('y (m)');
% % title('z= 0 m');
% [u2t,L2]=propFF(u1,L1(k),dx1(k),lambda(k),z);
% u2(:,:,k)=u2t;
% end
%     I2=abs(sum(u2,3).^2);
% %     figure,imagesc(x2,y2,nthroot(I2,3));
%     para_tip(m).I2=I2;
%     para_tip(m).SR=max(max(I2))/maxI2;
%     para_tip(m).SRdl=dlenergy(I2,rdlx,rdly,X2,Y2)/maxdlenergy;
%     para_tip(m).ECdl=ECenergySquare(I2,rdlx,rdly,X2,Y2 );
%     %Calculate radius of 80% encircled energy
% %     rof80x=rdlx;
% %     rof80y=rdly;
% %     while ECenergySquare(I2,rof80x,rof80y,X2,Y2 )<0.8
% %             rof80x=rof80x+0.15*rof80x;
% %             rof80y=rof80y+0.15*rof80y;
% %     end
% %     para_tip(m).rof80=[rof80x,rof80y];
%     para_tip(m).tip=tip(m);
% end
% save([filepath,'partip','.mat'],'para_tip');%save 
% clear u2 para_tip;
% %% tip/tilt error for two beams 
% Numofpoint=140;%Num of calcultaed point for a scale
% tilt=tip;
% para_tilt(Numofpoint)=struct('SR',[],'SRdl',[],'ECdl',[],...
%     'rof80',[],'tilt',[],'I2',[]);
% 
% for m=1:Numofpoint
% for k=1:didx:numel(lambda)
% %%coherent beam combination
% x1=-L1(k)/2:dx1(k):L1(k)/2-dx1(k);
% y1=x1;
% [X1,Y1]=meshgrid(x1,y1);
% u1=zeros(size(X1));
% 
% 
% u1=setu1tilt(0,tilt(m),u1,w,deltad,dx1(k),L1(k),M,spectrum(k),lambda(k));
% % 
% % I1=abs(u1.*2); %src irradiance
% % 
% % figure
% % imagesc(x1,y1,I1);
% % axis square; axis xy;
% % xlabel('x (m)'); ylabel('y (m)');
% % title('z= 0 m');
% [u2t,L2]=propFF(u1,L1(k),dx1(k),lambda(k),z);
% u2(:,:,k)=u2t;
% end
%     I2=abs(sum(u2,3).^2);
% %     figure,imagesc(x2,y2,nthroot(I2,3));
%     para_tilt(m).I2=I2;
%     para_tilt(m).SR=max(max(I2))/maxI2;
%     para_tilt(m).SRdl=dlenergy(I2,rdlx,rdly,X2,Y2)/maxdlenergy;
%     para_tilt(m).ECdl=ECenergySquare(I2,rdlx,rdly,X2,Y2 );
%     %Calculate radius of 80% encircled energy
%     rof80x=rdlx;
%     rof80y=rdly;
%     while ECenergySquare(I2,rof80x,rof80y,X2,Y2 )<0.8
%             rof80x=rof80x+0.15*rof80x;
%             rof80y=rof80y+0.15*rof80y;
%     end
%     para_tilt(m).rof80=[rof80x,rof80y];
%     para_tilt(m).tilt=tilt(m);
% end
% save([filepath,'partilt','.mat'],'para_tilt');%save 
% clear u2 para_tilt;





