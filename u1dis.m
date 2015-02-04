function u1=u1dis(phi,X1,Y1,deltad,r,N,alphax,alphay,lambda)
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
end

if nargin<6
    N=2;
end

if nargin<7
    alphax=1e-6;
end

if nargin<8
    alphay=1e-6;
end

if nargin<9
   lambda=1030*10^-9; %wavelength
end

switch N
    case 2
        u1=gauss(X1-deltad,Y1,r).*exp(1i.*phi(1)).*exp(2i*pi./lambda.*(tan(alphax).*(X1-deltad)+tan(alphay).*(Y1)))...
       +gauss(X1+deltad,Y1,r).*exp(1i.*phi(2)).*exp(2i*pi./lambda.*(tan(alphax).*(X1+deltad)+tan(alphay).*(Y1)));
    case 4
    u1=gauss(X1-deltad,Y1+deltad,r)*exp(1i*phi(1))*exp(1i*2*pi/lambda*(tan(alphax)*(X1-deltad)+tan(alphay)*(Y1+deltad)))...
        +gauss(X1+deltad,Y1+deltad,r)*exp(1i*phi(2))*exp(1i*2*pi/lambda*(tan(alphax)*(X1+deltad)+tan(alphay)*(Y1+deltad)))...
    +gauss(X1-deltad,Y1-deltad,r)*exp(1i*phi(3))*exp(1i*2*pi/lambda*(tan(alphax)*(X1-deltad)+tan(alphay)*(Y1-deltad)))
+gauss(X1+deltad,Y1-deltad,r)*exp(1i*phi(4))*exp(1i*2*pi/lambda*(tan(alphax)*(X1+deltad)+tan(alphay)*(Y1-deltad))); 
end

