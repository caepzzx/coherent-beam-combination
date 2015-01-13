function u=spec(lambda,lambda0,deltalambda)
%describe Gauss spectrum irradiation distribution
sigma=sqrt(1/(8*log(2)))*deltalambda;
u=normpdf(lambda,lambda0,sigma);
end