i=1;
iter=zeros(200,1);
for j=linspace(.5,1.95,200)
    iter(i)=SORreliter(A,Sv,ones(n*m,1),j,.00001);
    i=i+1;
end
plot(linspace(.5,1.95,200),iter)
ylabel('iteration number')
xlabel('omega value')