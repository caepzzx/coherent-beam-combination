figure,plot((piston1(:,1))/pi,piston1(:,2),'linewidth',2);
axis([-2,2,0.5,1]);
xlabel('piston(*\pi rad)');
ylabel('value');
hold on
plot((piston1(:,1))/pi,piston1(:,3),'r--','linewidth',2);

plot((piston1(:,1))/pi,piston1(:,4),'k-.','linewidth',2);

legend('SR','SRdl','EC');
print(gcf,'-depsc','E:\³öÍ¼\piston\piston.eps')