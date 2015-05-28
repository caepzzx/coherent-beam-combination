u2=zeros(numel(-L1(1)/2:dx1(1):L1(1)/2-dx1(1)),numel(-L1(1)/2:dx1(1):L1(1)/2-dx1(1)),numel(1:4:61));
figure
for k=4:4:61;
x1=-L1(k)/2:dx1(k):L1(k)/2-dx1(k);%src coords
y1=x1;
[X1,Y1]=meshgrid(x1,y1);
u1=zeros(size(X1));
u1=setu1(0,0,u1,w,deltad,dx1(k),L1(k),M,spectrum(k));
% 
I1=abs(u1.*2); %src irradiance

% figure
% imagesc(x1,y1,I1);
% axis square; axis xy;
% xlabel('x (m)'); ylabel('y (m)');
% title('z= 0 m');

[u2t,L2]=propFF(u1,L1(k),dx1(k),lambda(k),z);
u2(:,:,k)=u2t;
I2t=abs(u2t.^2);
plot(y2,(I2t(:,round(size(I2,2)/2))+I2t(:,round(size(I2,2)/2)+1)/2));
hold on
end
I2=abs(sum(u2,3).^2);
hold off
figure,plot(y2,(I2(:,round(size(I2,2)/2))+I2(:,round(size(I2,2)/2)+1)/2),'-.','linewidth',2);



