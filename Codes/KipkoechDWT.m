function SRInitial =KipkoechDWT(InterpolatedImage,A)
k=2;
LR=KipkoechDownSampling(A,k);
[~,LH,HL,HH]=dwt2(InterpolatedImage,'db1'); %DWT Decomposition of LR
SRInitial=idwt2(LR.*2,LH,HL,HH,'db1');
end