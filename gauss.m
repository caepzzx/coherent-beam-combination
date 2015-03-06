function out=gauss(x,y,r)
% gaussian distribution in space
%x,y are matrices which represent coordination in plane
%r represents radius
%out field distribution output
    out=exp(-((x/r).^2+(y/r).^2));
end