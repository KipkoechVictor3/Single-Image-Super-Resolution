function [PSNR]=KipkoechPSNR(image1,image2)
%  KIPKOECHPSNR This function calculates mean square error (MSE) and Peak Signal to Noise 
% Ratio (PSNR) Between two grayscale images.The two images must be of same dimensions.
A=double(image1);
B=double(image2);
[M,N]=size(A);
MSE=(sum(sum((A-B).^2)))./(M*N);
PSNR=10*log10(255.^2/MSE);
end