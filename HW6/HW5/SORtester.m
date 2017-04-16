w=linspace(.1,1.9,1000);
iterations=zeros(1000,1);
for i=1:1000;
    iterations(i)=SORiterations(A,b,x0,w(i),solution,10^-6);
end
plot(w,iterations);