function u1=setu1(phi1,phi2,u1,w,M,deltad,L1,X,Y)
%% set phase for two beams
%phi1,phi2 left and right beam's phasescreen
%phiu1 near-field phase
%L1 near-field side length
%w beam aperture
%deltad distance between two beams
%L side length of beam
%L1 side length of u1
%X coordinate of  x-axis
%Y
%X1 coordinate of x-axis
%Y1 coordinate of y-axis

E0=10;
R0=100e-3;
l=10;
E=E0*supergauss(X,Y,R0,l).*rectbeam(X,Y,w);

% biasinpixel=round(((deltad+w)/2)*(size(E,1)/L));
center=[round(size(u1,1)/2),round(size(u1,2)/2)];
dxc=round(deltad/(2*L1)*size(u1,1));
dyc=round(w/(2*L1)*size(u1,2));
u1=zeros(size(u1));
u1((center(1)-dyc):(center(1)-dyc+M-1),(center(2)+dxc):(center(2)+dxc+M-1))=E.*exp(1j.*phi1);
u1((center(1)-dyc):(center(1)-dyc+M-1),(center(2)-dxc):-1:(center(2)-dxc-(M-1)))=E.*exp(1j.*phi2);
% u1(((size(u1,1)-M)/2+1):(size(u1,1)-...
%     ((size(u1,1)-M)/2)),((size(u1,1)-M)/2+1-biasinpixel+1)...
%     :(size(u1,1)-((size(u1,1)-M)/2)-biasinpixel+1))=E.*exp(1i*phi1);
% u1(((size(u1,1)-M)/2+1):(size(u1,1)-...
%     ((size(u1,1)-M)/2)),((size(u1,1)-M)/2+1+biasinpixel+1)...
%     :(size(u1,1)-((size(u1,1)-M)/2)+biasinpixel+1))=E.*exp(1i*phi2);
% u1=u1.*(rectbeam(X1-(w+deltad)/2,Y1,w)+rectbeam(X1+(w+deltad)/2,Y1,w));%make sure that different 
% %                                                 wavelength have same beam
% %                                                 aperture
end