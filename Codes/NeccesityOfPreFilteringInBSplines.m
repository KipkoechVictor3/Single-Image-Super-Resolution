clc;
addpath 'E:'\MATLAB\'RESEARCH'\CODES
addpath 'E:'\MATLAB\'RESEARCH'\IMAGES
ImageNames={'aerial1.tiff';'aerial2.tiff';'aerial3.tiff';'aerial4.tiff';'aerial5.tiff';'aerial6.tiff';'aerial7.tiff';'aerial8.tiff';'baby.png';'bird.png';'woman.png';'zebra.png';'kodim03.png';'kodim10.png';'kodim15.png';'airplane.png';'arctichare.png';'girl.png';'lena.png';'monarch.png';'peppers1.tiff';'peppers2.png';'tulips.png'};
PSNRwith=zeros(size(ImageNames,1),1);
PSNRwithout=zeros(size(ImageNames,1),1);
SSIMwith=zeros(size(ImageNames,1),1);
SSIMwithout=zeros(size(ImageNames,1),1);
PSNRimprovement=zeros(size(ImageNames,1),1);
SSIMimprovement=zeros(size(ImageNames,1),1);
tic
for i=1:size(ImageNames,1)
    string=char(ImageNames(i));
    A=imread(string);
    B=im2double(rgb2gray(A));
    [w,witho]=KipkoechSuperResolution(B);
    PSNRwith(i)=psnr(w,B);
    PSNRwithout(i)=psnr(witho,B);
    SSIMwith(i)=ssim(w,B);
    SSIMwithout(i)=ssim(witho,B);
    PSNRimprovement(i)=PSNRwith(i)-PSNRwithout(i);
    SSIMimprovement(i)=SSIMwith(i)-SSIMwithout(i);
end
toc
T=table(ImageNames,PSNRwith,PSNRwithout,PSNRimprovement,SSIMwith,SSIMwithout,SSIMimprovement)
Table_location='E:\MATLAB\Results';
path_format = [Table_location '\PSNRImprovementWithPreFiltering.xlsx'];
writetable(T,path_format)
n=1:size(ImageNames,1);
N=size(ImageNames,1);
figure;
plot(n,PSNRwith,'-.b*',n,PSNRwithout,'-.r*')
xlim([0 N+1]);
grid minor
ylabel 'PSNR in dB'
xlabel 'Image number'
title ('PSNR improvement by prefiltering','FontWeight','bold');
legend('PSNR with PreFiltering','PSNR without Prefiltering',"Location","northwest")
figure;
plot(n,SSIMwith,'-.b*',n,SSIMwithout,'-.r*')
xlim([0 N+1]);
grid minor
ylabel 'SSIM'
xlabel 'Image number'
title ('SSIM improvement by Prefiltering','FontWeight','bold');
legend('SSIM with PreFiltering','SSIM without Prefiltering',"Location",'northwest')

%%
function [IR,IRW]= KipkoechSuperResolution (R)
k=2;
LR=KipkoechDownSampling(R,k);
LRPrefiltered=KipkoechCubicBSplinesPrefilter(LR);
IR=KipkoechBSplinesInterpolation(LRPrefiltered,k);
IRW=KipkoechBSplinesInterpolation(LR,k);
end