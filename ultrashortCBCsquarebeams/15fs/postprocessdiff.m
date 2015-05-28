diffwav=zeros(numel(SR),7);
diffwav(:,1)=ECdl';
diffwav(:,2)=SR';
diffwav(:,3)=SRdl';
diffwav(:,4)=PV';
diffwav(:,5)=RMS';
diffwav(:,6)=GPV';
diffwav(:,7)=GRMS';
save('D:\diffwave.mat', 'diffwav')