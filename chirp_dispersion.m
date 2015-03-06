%% 啁啾
%%  无啁啾高斯脉冲
clear                    %清除内存
clc                      %清屏
A0=1;                    %振幅归一化
lambda=1030e-9;           %光波长选择800nm
c=3e8;                   %光速
w0=2*pi*c/lambda;        %中心角频率
taup=5*lambda/c;         %脉宽相关量选择为脉冲周期的5倍
t=(-3:0.01:3)*taup;      %选择时间范围
Et=A0*exp(-(t/taup).^2).*exp(i*w0*t);  %无啁啾高斯脉冲
subplot(1,3,1),plot(t,Et);
xlabel('t/s');
ylabel('E的实部');
title('光场实部随时间的变化');
subplot(1,3,2),plot(t,abs(Et).^2);
xlabel('t/s');
ylabel('光场强度');
title('光场强度随时间的变化');
w=w0;
subplot(1,3,3),plot(t,w);
xlabel('t/s');
ylabel('频率');
title('光场频率随时间的变化');
%%  线性上啁啾高斯脉冲
clear                    %清除内存
clc                      %清屏
A0=1;                    %振幅归一化
lambda=800e-9;           %光波长选择800nm
c=3e8;                   %光速
w0=2*pi*c/lambda;        %中心角频率
taup=5*lambda/c;         %脉宽相关量选择为脉冲周期的5倍
t=(-3:0.01:3)*taup;      %选择时间范围
phi2=(w0/10).^2;         %选择二阶相位量的大小
Et=A0*exp(-(t/taup).^2).*exp(i*(w0*t+phi2*t.^2)); %线性上啁啾高斯脉冲
subplot(1,3,1),plot(t,Et);
xlabel('t/s');
ylabel('E的实部');
title('光场实部随时间的变化');
subplot(1,3,2),plot(t,abs(Et).^2);
xlabel('t/s');
ylabel('光场强度');
title('光场强度随时间的变化');
w=w0+2*phi2*t;
subplot(1,3,3),plot(t,w);
xlabel('t/s');
ylabel('频率');
title('光场频率随时间的变化');
%%  线性下啁啾高斯脉冲
clear                    %清除内存
clc                      %清屏
A0=1;                    %振幅归一化
lambda=800e-9;           %光波长选择800nm
c=3e8;                   %光速
w0=2*pi*c/lambda;        %中心角频率
taup=5*lambda/c;         %脉宽相关量选择为脉冲周期的5倍
t=(-3:0.01:3)*taup;      %选择时间范围
phi2=-(w0/10).^2;         %选择二阶相位量的大小
Et=A0*exp(-(t/taup).^2).*exp(i*(w0*t+phi2*t.^2)); %线性下啁啾高斯脉冲
subplot(1,3,1),plot(t,Et);
xlabel('t/s');
ylabel('E的实部');
title('光场实部随时间的变化');
subplot(1,3,2),plot(t,abs(Et).^2);
xlabel('t/s');
ylabel('光场强度');
title('光场强度随时间的变化');
w=w0+2*phi2*t;
subplot(1,3,3),plot(t,w);
xlabel('t/s');
ylabel('频率');
title('光场频率随时间的变化');
 
%% 色散
%% 无啁啾高斯脉冲通过色散介质
clear                    %清除内存
clc                      %清屏
A0=1;                    %振幅归一化
lambda=800e-9;           %光波长选择800nm
c=3e8;                   %光速
w0=2*pi*c/lambda;        %中心角频率
taup=3*lambda/c;         %脉宽相关量选择为脉冲周期的5倍
t=(-3:0.01:3)*taup;      %选择时间范围
%无啁啾高斯脉冲
Et=A0*exp(-2*log(2)*(t/taup).^2).*exp(i*w0*t);  
w=w0;
subplot(3,3,1),plot(t,Et);
xlabel('t/s');
ylabel('E的实部');
title('光场实部随时间的变化');
subplot(3,3,2),plot(t,abs(Et).^2);
xlabel('t/s');
ylabel('光场强度');
title('光场强度随时间的变化');
subplot(3,3,3),plot(t,w);
xlabel('t/s');
ylabel('频率');
title('光场频率随时间的变化');
%无啁啾高斯脉冲通过正色散介质phi2<0
phi0=0;phi1=0;phi2=-(13/w0).^2;      %选择二阶相位量的大小
alpha=(2*sqrt(log(2))/taup).^2/2;
beta=1/(2*phi2);
theta=atan(beta/alpha);
Eout=A0*(2*phi2)^(-0.5)*(alpha^2+beta^2)^(-0.25)*exp(i*(w0*(t-phi1)+phi0-theta/2))...
    .*exp(-alpha*beta^2*(alpha^2+beta^2)^-1*t.^2).*exp(-i*(alpha^2*beta*(alpha^2+beta^2)^-1*t.^2));
a=16*(log(2))^2;
% taupuot=(1+a*phi2^2/(taup)^4)^0.5*taup;
% phiout=-((phi2/2)*(phi2^2+taup^4/a)^-1)*t.^2+w0*phi1+phi0-theta/2;
subplot(3,3,4),plot(t,Eout);
xlabel('t/s');
ylabel('正色散介质Eout的实部');
title('光场实部随时间的变化');
subplot(3,3,5),plot(t,abs(Eout).^2);
xlabel('t/s');
ylabel('光场强度');
title('光场强度随时间的变化');
wout=-2*((phi2/2)*(phi2^2+taup^4/a)^-1)*t+w0;
subplot(3,3,6),plot(t,wout);
xlabel('t/s');
ylabel('频率');
title('光场频率随时间的变化');
%无啁啾高斯脉冲通过负色散介质phi2>0
phi0=0;phi1=0;phi2=(13/w0).^2;      %选择二阶相位量的大小
alpha=(2*sqrt(log(2))/taup).^2/2;
beta=1/(2*phi2);
theta=atan(beta/alpha);
Eout=A0*(2*phi2)^(-0.5)*(alpha^2+beta^2)^(-0.25)*exp(i*(w0*(t-phi1)+phi0-theta/2))...
    .*exp(-alpha*beta^2*(alpha^2+beta^2)^-1*t.^2).*exp(-i*(alpha^2*beta*(alpha^2+beta^2)^-1*t.^2));
a=16*(log(2))^2;
 
subplot(3,3,7),plot(t,Eout);
xlabel('t/s');
ylabel('负色散介质Eout的实部');
title('光场实部随时间的变化');
subplot(3,3,8),plot(t,abs(Eout).^2);
xlabel('t/s');
ylabel('光场强度');
title('光场强度随时间的变化');
wout=-2*((phi2/2)*(phi2^2+taup^4/a)^-1)*t+w0;
subplot(3,3,9),plot(t,wout);
xlabel('t/s');
ylabel('频率');
title('光场频率随时间的变化');
%% 线性啁啾高斯脉冲通过色散介质
clear                    %清除内存
clc                      %清屏
A0=1;                    %振幅归一化
lambda=800e-9;           %光波长选择800nm
c=3e8;                   %光速
w0=2*pi*c/lambda;        %中心角频率
taup=3*lambda/c;         %脉宽相关量选择为脉冲周期的5倍
t=(-3:0.01:3)*taup;      %选择时间范围
% 线性上啁啾高斯脉冲
delta=-w0/5;             %delta为负，上啁啾；delta为正，下啁啾。
Et=A0*exp(-2*log(2)*(t/taup).^2).*exp(-i*(delta/taup)*t.^2).*exp(i*w0*t);  
w=w0-2*(delta/taup)*t;
subplot(3,3,1),plot(t,Et);
xlabel('t/s');
ylabel('上啁啾E的实部');
title('光场实部随时间的变化');
subplot(3,3,2),plot(t,abs(Et).^2);
xlabel('t/s');
ylabel('光场强度');
title('光场强度随时间的变化');
subplot(3,3,3),plot(t,w);
xlabel('t/s');
ylabel('频率');
title('光场频率随时间的变化');
% 线性上啁啾高斯脉冲通过正色散介质phi2<0
phi0=0;phi1=0;phi2=-(5/w0).^2;      %选择二阶相位量的大小
alpha=(2*sqrt(log(2))/taup).^2/2;
beta=1/(2*phi2);
b=delta/taup;
theta=atan(b/alpha);
theta2=atan(((alpha^2+b^2)+b*beta)/(alpha*beta));
Eout=A0*(2*phi2)^(-0.5)*(alpha^2+(b+beta)^2)^(-0.25)*exp(i*(w0*(t-phi1)+phi0+theta2/2-theta/2))...
    .*exp(-alpha*beta^2*(alpha^2+(b+beta)^2)^-1*t.^2).*exp(-i*beta*(alpha^2+b*(b+beta))*(alpha^2+(b+beta)^2)^-1*t.^2);
a=16*(log(2))^2;
subplot(3,3,4),plot(t,Eout);
xlabel('t/s');
ylabel('正色散介质Eout的实部');
title('光场实部随时间的变化');
subplot(3,3,5),plot(t,abs(Eout).^2);
xlabel('t/s');
ylabel('光场强度');
title('光场强度随时间的变化');
wout=-2*(((1+2*phi2*delta/taup)*(delta/taup)+a*phi2^2/(2*taup^4))/((1+2*phi2*delta/taup)^2+...
    a*phi2^2/taup^4))*t+w0;
subplot(3,3,6),plot(t,wout);
xlabel('t/s');
ylabel('频率');
title('光场频率随时间的变化');
% 线性上啁啾高斯脉冲通过负色散介质phi2>0
phi0=0;phi1=0;phi2=(4/w0).^2;      %选择二阶相位量的大小
alpha=(2*sqrt(log(2))/taup).^2/2;
beta=1/(2*phi2);
theta=atan(beta/alpha);
Eout=A0*(2*phi2)^(-0.5)*(alpha^2+(b+beta)^2)^(-0.25)*exp(i*(w0*(t-phi1)+phi0+theta2/2-theta/2))...
    .*exp(-alpha*beta^2*(alpha^2+(b+beta)^2)^-1*t.^2).*exp(-i*beta*(alpha^2+b*(b+beta))*(alpha^2+(b+beta)^2)^-1*t.^2);
a=16*(log(2))^2;
taupuot=(1+a*phi2^2/(taup)^4)^0.5*taup;
phiout=-((phi2/2)*(phi2^2+taup^4/a)^-1)*t.^2+w0*phi1+phi0-theta/2;
subplot(3,3,7),plot(t,Eout);
xlabel('t/s');
ylabel('负色散介质Eout的实部');
title('光场实部随时间的变化');
subplot(3,3,8),plot(t,abs(Eout).^2);
xlabel('t/s');
ylabel('光场强度');
title('光场强度随时间的变化');
wout=-2*(((1+2*phi2*delta/taup)*(delta/taup)+a*phi2^2/(2*taup^4))/((1+2*phi2*delta/taup)^2+...
    a*phi2^2/taup^4))*t+w0;
subplot(3,3,9),plot(t,wout);
xlabel('t/s');
ylabel('频率');
title('光场频率随时间的变化');
%% 线性下啁啾高斯脉冲
clear                    %清除内存
clc                      %清屏
A0=1;                    %振幅归一化
lambda=800e-9;           %光波长选择800nm
c=3e8;                   %光速
w0=2*pi*c/lambda;        %中心角频率
taup=3*lambda/c;         %脉宽相关量选择为脉冲周期的5倍
t=(-3:0.01:3)*taup;      %选择时间范围
delta=w0/5;             %delta为负，上啁啾；delta为正，下啁啾。
Et=A0*exp(-2*log(2)*(t/taup).^2).*exp(-i*(delta/taup)*t.^2).*exp(i*w0*t);  
w=w0-2*(delta/taup)*t;
subplot(3,3,1),plot(t,Et);
xlabel('t/s');
ylabel('上啁啾E的实部');
title('光场实部随时间的变化');
subplot(3,3,2),plot(t,abs(Et).^2);
xlabel('t/s');
ylabel('光场强度');
title('光场强度随时间的变化');
subplot(3,3,3),plot(t,w);
xlabel('t/s');
ylabel('频率');
title('光场频率随时间的变化');
%线性下啁啾高斯脉冲通过正色散介质phi2<0
phi0=0;phi1=0;phi2=-(5/w0).^2;      %选择二阶相位量的大小
alpha=(2*sqrt(log(2))/taup).^2/2;
beta=1/(2*phi2);
b=delta/taup;
theta=atan(b/alpha);
theta2=atan(((alpha^2+b^2)+b*beta)/(alpha*beta));
Eout=A0*(2*phi2)^(-0.5)*(alpha^2+(b+beta)^2)^(-0.25)*exp(i*(w0*(t-phi1)+phi0+theta2/2-theta/2))...
    .*exp(-alpha*beta^2*(alpha^2+(b+beta)^2)^-1*t.^2).*exp(-i*beta*(alpha^2+b*(b+beta))*(alpha^2+(b+beta)^2)^-1*t.^2);
a=16*(log(2))^2;
subplot(3,3,4),plot(t,Eout);
xlabel('t/s');
ylabel('正色散介质Eout的实部');
title('光场实部随时间的变化');
subplot(3,3,5),plot(t,abs(Eout).^2);
xlabel('t/s');
ylabel('光场强度');
title('光场强度随时间的变化');
wout=-2*(((1+2*phi2*delta/taup)*(delta/taup)+a*phi2^2/(2*taup^4))/((1+2*phi2*delta/taup)^2+...
    a*phi2^2/taup^4))*t+w0;
subplot(3,3,6),plot(t,wout);
xlabel('t/s');
ylabel('频率');
title('光场频率随时间的变化');
%线性下啁啾高斯脉冲通过负色散介质phi2>0
phi0=0;phi1=0;phi2=(4/w0).^2;      %选择二阶相位量的大小
alpha=(2*sqrt(log(2))/taup).^2/2;
beta=1/(2*phi2);
theta=atan(beta/alpha);
Eout=A0*(2*phi2)^(-0.5)*(alpha^2+(b+beta)^2)^(-0.25)*exp(i*(w0*(t-phi1)+phi0+theta2/2-theta/2))...
    .*exp(-alpha*beta^2*(alpha^2+(b+beta)^2)^-1*t.^2).*exp(-i*beta*(alpha^2+b*(b+beta))*(alpha^2+(b+beta)^2)^-1*t.^2);
a=16*(log(2))^2;
subplot(3,3,7),plot(t,Eout);
xlabel('t/s');
ylabel('负色散介质Eout的实部');
title('光场实部随时间的变化');
subplot(3,3,8),plot(t,abs(Eout).^2);
xlabel('t/s');
ylabel('光场强度');
title('光场强度随时间的变化');
wout=-2*(((1+2*phi2*delta/taup)*(delta/taup)+a*phi2^2/(2*taup^4))/((1+2*phi2*delta/taup)^2+...
    a*phi2^2/taup^4))*t+w0;
subplot(3,3,9),plot(t,wout);
xlabel('t/s');
ylabel('频率');
title('光场频率随时间的变化');
