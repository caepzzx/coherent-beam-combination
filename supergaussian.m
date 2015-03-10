syms x y w v l r0
l=1;
f=exp(-((x/r0)^2+(y/r0)^2));
g=fourier(f,x,w);
F=fourier(g,y,v)