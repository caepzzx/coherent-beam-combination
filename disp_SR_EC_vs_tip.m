vx=linspace(-6,6,600);
SR=zeros(size(parameter));
EC=SR;
for k=1:numel(parameter)
  SR(k)=parameter(k).SR;
end
plot(vx,SR);
xlabel('tip(/murad)')
ylabel('SR');
title('SR vs tip')
 for k=1:numel(parameter)
  EC(k)=parameter(k).EC;
 end
 figure
plot(vx,EC);
xlabel('tip(/murad)');
ylabel('EC');
title('EC vs tip')