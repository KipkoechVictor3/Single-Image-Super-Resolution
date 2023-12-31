function [ck] = KipkoechCubicBSplinesPrefilter(A)
[M,N]=size(A);
b1=-2+sqrt(3);
b0=-b1/(1-(b1.^2));
CplusKRow=zeros(M,N);% initialize c+[k] forward filter along the rows with zeros;
CMinuskRow=zeros(M,N);% initialize c-[k] backward filter along the rows with zeros;
CpluskColumn=zeros(M,N);% initialize c+[k] forward filter along the columns with zeros;
CminusKColumn=zeros(M,N); %initialize c-[k] backward filter along the columns with zeros;
sa=zeros(12,N);
s=zeros(N,12);
%%
% calculating the B-splines coefficients along the rows

for q=1:N
    for t=1:12
        t1=t-1;
        sa(t,q)=A(t,q).*(b1.^(abs(t1)));
    end 
end 
g=sum(sa);
for l=2:M
    for ee=1:N
        l1=l-1;
        CplusKRow(1,ee)=g(1,ee);
        CplusKRow(l,ee)=A(l,ee)+b1.*CplusKRow(l1,ee);
    end 
end
for z=M-1:-1.0:1
    for k=N:-1:1
        z1=z+1;
        CMinuskRow(M,k)=b0.*(CplusKRow(M,k)+b1.*CplusKRow(M-1,k));
        CMinuskRow(z,k)=b1.*(CMinuskRow(z1,k)-CplusKRow(z,k));
    end
end
ckROW=6.*CMinuskRow;
%%
% calculating the B-spline coefficients along the columns
for y=1:M
    for h=1:12
      a=h-1;
      s(y,h)=ckROW(y,h).*(b1.^(abs(a)));
    end
end
w=sum(s,2);
for r=2:N
    for y1=1:M
      r1=r-1;
      CpluskColumn(y1,1)=w(y1,1);
      CpluskColumn(y1,r)=ckROW(y1,r)+b1.*CpluskColumn(y1,r1);  
    end
end

for zj=N-1:-1:1
    for kj=M:-1:1
        zj1=zj+1;
        CminusKColumn(kj,N)=b0.*(CpluskColumn(kj,N)+b1.*CpluskColumn(kj,N-1));
        CminusKColumn(kj,zj)=b1.*(CminusKColumn(kj,zj1)-CpluskColumn(kj,zj));
    end
end
ckCOLUMN=6.*CminusKColumn;
ck=ckCOLUMN;  %B-Splines coefficients
end