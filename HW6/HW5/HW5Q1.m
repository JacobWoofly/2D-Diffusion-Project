n=100;
A=zeros(100);
b=zeros(100,1);
for i = 0:n-1;
    if i == 0;
        A(1,1)=2;
        A(1,2)=-1;
        b(1)=0;
    elseif i == n-1;
        A(100,99)=-1;
        A(100,100)=2;
        b(100)=n-1;
    else 
        A(i+1,i)=-1;
        A(i+1,i+1)=2;
        A(i+1,i+2)=-1;
        b(i+1)=i;
    end
end
Ainv=inv(A);
ConditionNumber=norm(A)*norm(Ainv);
xc=Ainv*b;
xd=A\b;
plot(b,xc,'*',b,xd,'sq')
ylabel('x_i value')
xlabel('x index')
legend('xc','xd')
title('Values of xc and xd')
