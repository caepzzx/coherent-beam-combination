figure,plot((tilt1(:,1))*1e6,tilt1(:,2),'linewidth',2);
axis([-6,6,0, 1]);
xlabel('tip(\murad)');
ylabel('value');
hold on
plot((tilt1(:,1))*1e6,tilt1(:,3),'r--','linewidth',2);

plot((tilt1(:,1))*1e6,tilt1(:,4),'k-.','linewidth',2);
xlabel('tilt(\murad)');
legend('SR','SRdl','EC');
print(gcf,'-depsc','E:\³öÍ¼\piston\tilt.eps')