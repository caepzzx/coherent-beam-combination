function spc=inputfield()
%consider spectrum phase dismatch 
%lambda: spectrum  range
%lambda0:center wavelength
%deltalambda:linewidth FWHM
%l:order of super gaussian distribution
%phi0: 0 oder spectrum phase
%d1phi:group delay
%d2phi:group delay dispersion
%d3phi:third order dispersion
%super gaussian:exp(-2*((lambda-lambda0)/w).^(2*l)      l>=1
   
    lambda0=1030e-9;
    lambdamin=1000e-9;
    lambdamax=1060e-9;
    deltalambda=0.5e-9;
    lambda=lambdamin:deltalambda:lambdamax;
    w0=15e-9;
    mkdir data;%create a folder to save results
    directory=[cd,'\data\'];

    fluctuation=cos(2*pi*lambda*1e17)+randn(size(lambda))*0.8e-1;%Z=(x-mu)/sigma N(0,1)
    %plot(lambda,fluctuation)

    l=10;%coefficient of supergaussian 
    u=exp(-((lambda-lambda0)/w0).^(2*l)).*fluctuation;
    %plot(lambda,u);
    spc=struct('lambda',lambda,'spectrum',u);
    plot(spc.lambda,spc.spectrum)
    xlabel('\lambda(m)'); ylabel('Irradiance');
    title('Spectrum of input field');
    saveas(gcf,[directory,'spectrum','fig']);