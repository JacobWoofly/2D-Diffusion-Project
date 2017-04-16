a=4;
D=1;
E=.2;
S=8;
p=0;
q=E/D;
r=-S/D;
bcl=0;
bcr=0;
L=sqrt(D/E);
h=[1,.5,.1,.05,.01];
for i=1:5
    [A,b] = MatrixMaker(p,q,r,a,h(i),bcl,bcr);
    phimid=Tomalgo(A,b);
    x=linspace(-a+h(i),a-h(i),2*a/h(i)-2);
    y=-S*(exp(x/L)+exp(-x/L))./(E*(exp(a/L)+exp(-a/L)))+S/E;
    error(i)=max(abs((phimid-y)./y));
    n(i)=2*a/h(i);
end
loglog(n,error,'-o');
xlabel('number of mesh cells')
ylabel('maximum relative error')
title('error vs number of mesh cell')
figure()
loglog(h,error,'-o');
xlabel('mesh size (cm)')
ylabel('maximum relative error')
title('error vs mesh size')