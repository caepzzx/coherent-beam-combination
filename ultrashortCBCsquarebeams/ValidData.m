k=1;
for i=1:numel(SR)
    if(SR(i)<=1 && SR(i)>0 && ECdl(i)>0 && ECdl(i)<1)
        SRt(k)=SR(i);
        SRdlt(k)=SRdl(i);
        ECdlt(k)=ECdl(i);
        PVt(k)=PV(i);
        RMSt(k)=RMS(i);
        GPVt(k)=GPV(i);
        GRMSt(k)=GRMS(i);
        rof80xt(k)=rof80x(i);
        rof80yt(k)=rof80y(i);
        k=k+1;
    end
end
        SR=SRt;
        SRdl=SRdlt;
        ECdl=ECdlt;
        PV=PVt;
        RMS=RMSt;
        GPV=GPVt;
        GRMS=GRMSt;
        rof80x=rof80xt;
        rof80y=rof80yt;
%         save ('E:\Wavefront20150513\parsamedatavalid.mat','SR','SRdl','ECdl','rof80x','rof80y','PV','RMS','GRMS','GPV');
        save ('E:\Wavefront20150513\diffwave\parsamedatavalid.mat','SR','SRdl','ECdl','rof80x','rof80y','PV','RMS','GRMS','GPV');