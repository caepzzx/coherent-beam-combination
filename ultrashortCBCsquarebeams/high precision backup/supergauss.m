function out=supergauss(x,y,r,l)
% gaussian distribution in space
%x,y are matrices which represent coordination in plane
%r represents radius
%out field distribution output
%l order of supergaussian distribution
    out=exp(-((x/r).^(2*l)+(y/r).^(2*l)));
end