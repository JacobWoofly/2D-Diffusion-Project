function [A,b] = MatrixMaker(p,q,r,a,h,bcl,bcr)
%MATRIXMAKER Summary of this function goes here
%   Detailed explanation goes here
n=2*a/h-2;
A=zeros(n);
b=zeros(n,1);
for i = 1:n;
    if i == 1;
        A(1,1)=2+h^2*q;
        A(1,2)=h*p/2-1;
        b(1)=-h^2*r+bcl;
    elseif i == n;
        A(n,n-1)=-h*p/2-1;
        A(n,n)=2+h^2*q;
        b(i)=-h^2*r+bcr;
    else 
        A(i,i-1)=-h/2*p-1;
        A(i,i)=2+h^2*q;
        A(i,i+1)=h*p/2-1;
        b(i)=-h^2*r;
    end
end
end

