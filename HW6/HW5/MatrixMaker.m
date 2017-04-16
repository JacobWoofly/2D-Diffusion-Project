function [A,b] = MatrixMaker(n)
%MATRIXMAKER Summary of this function goes here
%   Detailed explanation goes here
A=zeros(n);
b=ones(n,1).*100;
for i = 0:n-1;
    if i == 0;
        A(1,1)=3;
        A(1,2)=-1;
    elseif i == n-1;
        A(n,n-1)=-1;
        A(n,n)=3;
    else 
        A(i+1,i)=-1;
        A(i+1,i+1)=3;
        A(i+1,i+2)=-1;
    end
end
end

