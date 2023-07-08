function [LR]= bmn_decimation(imagename)
% this function receives an image and reduces the size by a factor of 2
% by elimination of alternate rows and columns
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %
% Author: Boniface M. Ngocho %
% School of Engineering %
% University of Nairobi %
% 10th November 2015 %
% e-mail:bmnngocho@yahoo.co.uk %
% %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
Im=imagename; %Assign image variable name
[M,N]=size(Im); %Get size of image
k=0.5; %Reduction factor
%Eliminate even rows
B=zeros(k*M,k*N); %Initialise reduced image
for i=1:k*M;
 for j=1:k*N;
 B(i,j)=Im((2*(i-1)+1),(2*(j-1)+1));
 end;
end;
%Eliminate odd rows
C=zeros(k*M,k*N); %Initialise reduced image
for i=1:k*M;
 for j=1:k*N;
 C(i,j)=Im((2*i),(2*j));
 end;
end;
%Average the two images
A=(B+C)./2;
LR=A;
end