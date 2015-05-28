figure,plot((tip1(:,1))*1e6,tip1(:,2),'linewidth',2);
axis([-6.65,6.65,0, 1]);
xlabel('tip(\murad)');
ylabel('value');
hold on
plot((tip1(:,1))*1e6,tip1(:,3),'r--','linewidth',2);

plot((tip1(:,1))*1e6,tip1(:,4),'k-.','linewidth',2);
xlabel('tip(\murad)');
legend('SR','SRdl','EC');
print(gcf,'-depsc','E:\³öÍ¼\piston\tip.eps')