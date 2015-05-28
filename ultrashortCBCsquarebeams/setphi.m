function phiu1=setfield(phi1,phi2,phiu1,L1,w,deltad,L,c,lambda)
%% set phase for two beams
%phi1,phi2 left and right beam's phasescreen
%phiu1 near-field phase
%L1 near-field side length
%w beam aperture
%deltad distance between two beams

biasinpixel=round(((deltad+w)/2)*(size(phiu1,1)/L1));
phiu1(((size(phiu1,1)-(size(phi1,1)))/2+1):(size(phiu1,1)-...
    ((size(phiu1,1)-(size(phi1,1)))/2)),((size(phiu1,1)-(size(phi1,1)))/2+1-biasinpixel+1)...
    :(size(phiu1,1)-((size(phiu1,1)-(size(phi1,1)))/2)-biasinpixel+1))=phi1;
phiu1(((size(phiu1,1)-(size(phi1,1)))/2+1):(size(phiu1,1)-...
    ((size(phiu1,1)-(size(phi1,1)))/2)),((size(phiu1,1)-(size(phi1,1)))/2+1+biasinpixel+1)...
    :(size(phiu1,1)-((size(phiu1,1)-(size(phi1,1)))/2)+biasinpixel+1))=phi2;
end