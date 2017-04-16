function [x] = SOR(A,b,x0,w,solution,tolerance)
%JACOBI Summary of this function goes here
%   Detailed explanation goes here
squaretest=size(A);
if squaretest(1)~=squaretest(2)
    disp('A must be square')
    return
elseif squaretest(1)~=numel(b)
    disp('Size of A must match b')
    return
elseif numel(x0)~=numel(b)
    disp('Size of intital guess must match')
end
n=sqrt(numel(A));
x=x0;
iternumber=0;
while any(abs(x-solution)>tolerance);
    xprev=x;
    x=zeros(n,1);
    for i=1:n
        if i-1>=1
            for j=1:(i-1);
                x(i)=x(i)-w/A(i,i)*A(i,j)*x(j);
            end
        end
        if n>=i+1
            for j=i+1:n;
                x(i)=x(i)-w/A(i,i)*A(i,j)*xprev(j);
            end
        end
        x(i)=x(i)+w/A(i,i)*b(i)+(1-w)*xprev(i);
    end
    iternumber=iternumber+1;
end
disp(iternumber)
disp(x)
end