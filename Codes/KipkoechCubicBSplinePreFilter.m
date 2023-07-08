function [ck] = KipkoechCubicBSplinePreFilter(A)
[M,N]=size(A);
b1=-0.26794919243112281;    %-2+sqrt(3)
b0=(-6*b1)/(1-(b1.^2));
cplusk=zeros(M,N);% initialize c+[k] forward filter with zeros;
cminusk=zeros(M,N);% initialize c-[k] backward filter with zeros;
sa=zeros(100,N);
for l=2:M
    for j=1:N
        for i=1:100
        sa(i,j)=A(i,j).*(b1.^abs(i-1));
        end
         g=sum(sa);
         cplusk(1,j)=g(1,j);
         cplusk(l,j)=A(l,j)+b1.*cplusk(l-1,j);
    end
end
for z=M-1:-1.0:1
    for k=N:-1:1
         cminusk(M,k)=cplusk(M,k);
         cminusk(z,k)=A(z,k)+b1*cminusk(z+1,k);
    end
end
% calculating the B-spline coefficients
ck=b0.*((cplusk+cminusk)-A);
end