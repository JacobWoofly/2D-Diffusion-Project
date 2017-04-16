function [x] = Tomalgo(a,b)
%TOMALGO Summary of this function goes here
%   Detailed explanation goes here
n=numel(b);
u=zeros(n,1);
v=zeros(n,1);
A=zeros(n,1);
B=zeros(n,1);
C=zeros(n-1,1);
for i=1:n
    B(i)=a(i,i);
end
for i=2:n
    A(i)=-a(i,i-1);
end
for i=1:n-1
    C(i)=-a(i,i+1);
end
u(1)=B(1);
v(1)=b(1);
for i=2:n
    u(i)=B(i)-A(i)*C(i-1)/u(i-1);
    v(i)=b(i)+A(i)*v(i-1)/u(i-1);
end
x(n)=v(n)/u(n);
for i=n-1:-1:1
    x(i)=(v(i)+C(i)*x(i+1))/u(i);
end
end