A=imread('4.1.08.tiff');
% B=A;
B=rgb2gray(A);
imshow(A);
imshow(B)
C=double(B);
LR=KipkoechDownSampling(C);
LRimage=uint8(LR);
imshow(LRimage)
%%
function LowResolutionImage= KipkoechDownSampling(HighResolutionImage)
ImaGe=HighResolutionImage;%Assign HighResolutionImage to ImaGe variable
[R,C]=size(ImaGe); %Get size of image
F=0.5; %Downsampling factor
r=F*R;
c=F*C;
%initialize the downsampled images For row & column reduction
EvenReduced=zeros(r,c);
ERows=zeros(r,C); 
EColumns=zeros(r,c);
OddReduced=zeros(r,c);
CRows=zeros(r,C);
CColumns=zeros(r,c);%eliminate odd rows and columns
%%%%%%%%       Eliminating even Rows and Even Columns    %%%%%%%%%%%%%
for i=1:r
 for j=1:c
 ERows(i,:)=ImaGe(2*i-1,:); %eliminate even rows
 EColumns(:,j)=ERows(:,(2*j-1));%eliminate even columns in ERows image
 EvenReduced(i,j)=EColumns(i,j);
 end
end
%%%%%%%%     Eliminating even Rows and Even Columns     %%%%%%%%%%%%%
for i=1:r
 for j=1:c
 CRows(i,:)=ImaGe(2*i,:); %eliminate odd rows
 CColumns(:,j)=CRows(:,2*j);%eliminate odd columns in CRows image
 OddReduced(i,j)=CColumns(i,j);
 end
end
%Average the two images 
LowResolutionImage=(EvenReduced+OddReduced)./2;
end