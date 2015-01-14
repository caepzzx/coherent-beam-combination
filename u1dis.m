function u1=u1dis(phi,X1,Y1,deltad,r,N)
%describe source electrical field  distribution
%phi phase vector 4*1



if nargin < 3
    error('Requires at least three input argument.');
end

if nargin < 4
    deltad=0.015;
end

if nargin<5
    r=deltad-0.1*deltad;
    N=2;
end

if nargin<6
    N=2;
end

switch N
    case 2
        u1=gauss(X1-deltad,Y1,r)*exp(1i*phi(1))+gauss(X1+deltad,Y1,r)*exp(1i*phi(2));
    case 4
u1=gauss(X1-deltad,Y1+deltad,r)*exp(1i*phi(1))+gauss(X1+deltad,Y1+deltad,r)*exp(1i*phi(2))...
    +gauss(X1-deltad,Y1-deltad,r)*exp(1i*phi(3))+gauss(X1+deltad,Y1-deltad,r)*exp(1i*phi(4)); 
end

