 a=rand(numel(x),numel(y))-0.5;
 sgx=5e-2;
 sgy=5e-2;
 b=exp(-((X/sgx).^2+(Y/sgy).^2));
 phi=0.001*conv2(a,b,'same');
figure,mesh(x,y,phi(:,:,k));
max(max(phi(:,:,k)))-min(min(phi(:,:,k)))