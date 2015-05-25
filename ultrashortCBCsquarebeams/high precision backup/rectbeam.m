function [ output ] = rectbeam( X,Y,w)

%RECTBEAM 此处显示有关此函数的摘要
%   此处显示详细说明
output=(rect(X/w).*rect(Y/w));
end

