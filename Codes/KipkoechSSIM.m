function [SSIM]=KipkoechSSIM(image1,image2)
A=uint8(image1);
B=uint8(image2);
SSIM=ssim(A,B);
end