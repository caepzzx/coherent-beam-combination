%plot 4 different kinds of supergaussian distribution


r0=1;l=2;
x=-3:0.01:3;
y=x;
[X,Y]=meshgrid(x,y);
Z=exp(-((X/r0).^(2*l)+(Y/r0).^(2*l)));
plot3(X,Y,Z)
plot(x,exp(-((x/r0).^(2*1))),'k')
hold on ;
plot(x,exp(-((x/r0).^(2*2))),'b:')
hold on ;
plot(x,exp(-((x/r0).^(2*3))),'c-.')
hold on ;
plot(x,exp(-((x/r0).^(2*4))),'g--')
legend('l=1','l=2','l=3','l=4')