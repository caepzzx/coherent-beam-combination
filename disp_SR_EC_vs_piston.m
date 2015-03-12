for k=1:numel(parameter)
  piston(k)=parameter(k).piston;
end
for k=1:numel(parameter)
  SR(k)=parameter(k).SR;
end
plot(piston,SR);
xlabel('piston(pi)')
ylabel('SR');
title('SR vs piston')
 for k=1:numel(parameter)
  EC(k)=parameter(k).EC;
 end
 figure
plot(piston,EC);
xlabel('piston(pi)');
ylabel('EC');
title('EC vs piston')