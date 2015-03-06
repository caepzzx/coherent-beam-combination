function Y=rect(X)
Y=zeros(size(X));
mask=(abs(X)<=0.5);
Y(mask)=1;
end