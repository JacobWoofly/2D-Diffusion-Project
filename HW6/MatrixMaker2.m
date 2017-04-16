function [A,F] = MatrixMaker2(D,h,Ea,a,vEf)
%MATRIXMAKER Summary of this function goes here
%   Detailed explanation goes here
n=2*a/h-2;
A=zeros(n);
F=zeros(n);
for i = 1:n;
    F(i,i)=vEf;
    if i == 1;
        A(1,1)=2*D/h^2+Ea;
        A(1,2)=-D/h^2;
    elseif i == n;
        A(n,n-1)=-D/h^2;
        A(n,n)=2*D/h^2+Ea;
    else 
        A(i,i-1)=-D/h^2;
        A(i,i)=2*D/h^2+Ea;
        A(i,i+1)=-D/h^2;
    end
end
end

