a=4;
D=1;
Ea=.7;
vEf=.6;
S=8;
h=.1;
%-D*f''+Ea*f=vEf*f/k
[A,F]=MatrixMaker2(D,h,Ea,a,vEf);
x=linspace(-a,a,2*a/h);