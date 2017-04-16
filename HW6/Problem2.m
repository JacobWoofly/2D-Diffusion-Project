a=4;
D=1;
E=.2;
S=8;
h=.1;
%-D*f''+E*f=S
%f''=(E/D)*f-S/D
p=0;
q=E/D;
r=-S/D;
%f''(xi)=[f(xi+h)-2*f(xi)+F(xi-h)]/h^2
bcl=0;
bcr=0;
[A,b]=MatrixMaker(p,q,r,a,h,bcl,bcr);
x=linspace(-a,a,2*a/h);
phimid=Tomalgo(A,b);
phi=[0,phimid,0];
L=sqrt(D/E);
y=-S*(exp(x/L)+exp(-x/L))./(E*(exp(a/L)+exp(-a/L)))+S/E;
plot(x,y,'k',x,phi,'xr')
legend('Analytical Solution','Numerical Solution','location','South')
xlabel('x');
ylabel('phi(x)');
title('Solutions to -D*f"+E*f=S')