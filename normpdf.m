function y = normpdf(x,mu,sigma)
%NORMPDF Normal probability density function (pdf).
%   Y = NORMPDF(X,MU,SIGMA) Returns the normal pdf with mean, MU, 
%   and standard deviation, SIGMA, at the values in X. 
%
%   The size of Y is the common size of the input arguments. A scalar input  
%   functions as a constant matrix of the same size as the other inputs.     
%
%   Default values for MU and SIGMA are 0 and 1 respectively.

%   References:
%      [1]  M. Abramowitz and I. A. Stegun, "Handbook of Mathematical
%      Functions", Government Printing Office, 1964, 26.1.26.

%   Copyright (c) 1993-98 by The MathWorks, Inc.
%   $Revision: 2.6 $  $Date: 1997/11/29 01:46:16 $

if nargin < 3, 
    sigma = 1;
end

if nargin < 2;
    mu = 0;
end

if nargin < 1, 
    error('Requires at least one input argument.');
end

%   Initialize Y to zero.
y = zeros(size(x));
    xn = (x- mu)./sigma;
    y = exp(-0.5 * xn .^2) ./ (sqrt(2*pi) .* sigma);
end

