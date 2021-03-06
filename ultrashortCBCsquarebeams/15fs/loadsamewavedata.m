%%adjust parameter
%obtain data in matrix form from struct generated by wavefront.m file
clear all;
cbcpar='15fs';
inputpath=['D:\CBC\Wavefront20150513\',cbcpar,'\'];
outputpath='D:\CBC\Wavefront20150513\PROCESSED\';
outputfilename1=['cellformat_',cbcpar,'.mat'];
outputfilename2=['matrixformat',cbcpar,'.mat'];

%%
dirs=dir([inputpath,'*.mat']);   % 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
dircell=struct2cell(dirs)' ;    % 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
filenames=dircell(:,1);   % 第一列是文件名
NumPar=numel(filenames);%Number of para_same set
NumPoint=50;%Number of data point per each set
NumData=NumPar*NumPoint;%Total number of Data
SR=zeros(NumData,1);
SRdl=SR;
ECdl=SR;
% rof80x=SR;
% rof80y=SR;
EC=zeros(NumData,1);
PV=zeros(NumData,1);
RMS=zeros(NumData,1);
GRMS=zeros(NumData,1);
GPV=zeros(NumData,1);
for i=1:NumPar
load([inputpath,char(filenames(i))]);
    for j=1:numel(para_same)
        idx=(i-1)*50+j;
        SR(idx)=para_same(j).SR;
        SRdl(idx)=para_same(j).SRdl;
        ECdl(idx)=para_same(j).ECdl;
%         rof80x(idx)=para_same(j).rof80(1);
%         rof80y(idx)=para_same(j).rof80(2);
        PV(idx)=para_same(j).PV;
        RMS(idx)=para_same(j).RMS;
        GRMS(idx)=para_same(j).GRMS;
        GPV(idx)=para_same(j).GPV;
    end
        clear para_same 
end
%% valid data
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
%         rof80xt(k)=rof80x(i);
%         rof80yt(k)=rof80y(i);
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
%         rof80x=rof80xt;
%         rof80y=rof80yt;
%% format convert
samewav=zeros(numel(SR),7);
samewav(:,1)=ECdl';
samewav(:,2)=SR';
samewav(:,3)=SRdl';
samewav(:,4)=PV';
samewav(:,5)=RMS';
samewav(:,6)=GPV';
samewav(:,7)=GRMS';
save([outputpath,outputfilename1],'ECdl','SR','SRdl','PV','RMS','GPV','GRMS');
save([outputpath,outputfilename2],'samewav')