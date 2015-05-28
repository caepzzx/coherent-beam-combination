function u1=setfield(phi1,phi2,u1,w,deltad,L,M)
%% set phase for two beams
%phi1,phi2 left and right beam's phasescreen
%phiu1 near-field phase
%L1 near-field side length
%w beam aperture
%deltad distance between two beams
%side length of beam
dx=L/M;
x=-L/2:dx:L/2-dx; 
y=x; 
[X,Y]=meshgrid(x,y);
E0=100;
R0=100e-3;
l=10;
E=E0*supergauss(X,Y,R0,l).*rectbeam(X,Y,w);

biasinpixel=round(((deltad+w)/2)*(size(E,1)/L));
u1(((size(u1,1)-(size(phi1,1)))/2+1):(size(u1,1)-...
    ((size(u1,1)-(size(phi1,1)))/2)),((size(u1,1)-(size(phi1,1)))/2+1-biasinpixel+1)...
    :(size(u1,1)-((size(u1,1)-(size(phi1,1)))/2)-biasinpixel+1))=E.*exp(1i*phi1);
u1(((size(u1,1)-(size(phi1,1)))/2+1):(size(u1,1)-...
    ((size(u1,1)-(size(phi1,1)))/2)),((size(u1,1)-(size(phi1,1)))/2+1+biasinpixel+1)...
    :(size(u1,1)-((size(u1,1)-(size(phi1,1)))/2)+biasinpixel+1))=E.*exp(1i*phi2);
end