function [X] = MatMaker(Xe,x,y)
%DESMAKER Summary of this function goes here
%   Detailed explanation goes here
n=numel(x);
m=numel(y);
X=zeros(n,m);%Xi,1 and X1,j should be undefined, but we do not use them
if isa(Xe,'symfun')
    for i=2:n
        for j=2:m
            X(i,j)=Xe((x(i)+x(i-1))/2,(y(j)+y(j-1))/2);
        end
    end
else
    X=zeros(n,m)+Xe;
end
end