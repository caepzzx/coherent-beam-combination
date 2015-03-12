 for k=1:numel(parameter)
  SR(k)=parameter(k).SR;
end
plot((0:0.01:1.2),SR);
xlabel('piston(2*pi)')
ylabel('SR');
title('SR vs piston')
 for k=1:numel(parameter)
  EC(k)=parameter(k).EC;
 end
 figure
plot((0:0.01:1.2)*2*pi,EC);
xlabel('piston(2*pi)');
ylabel('EC');
title('EC vs piston')