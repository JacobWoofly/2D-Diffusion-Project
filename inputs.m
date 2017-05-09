DiffusionSolverClean(0,10,1,0,10,1,0,symfun((x+1)^2, [x y]),symfun((x+1)^3-(x+1)^2, [x y]),0,0,0,0); %D=0, so Phi=S/E: S=x^2+x, E=x+1, so phi=x.
DiffusionSolverClean(0,10,.5,0,10,.5,1,0,0,0,0,0,10);%Laplace solution, boundary condition that bottom=10.

a=4;
D=1;
E=.2;
S=8;
L=sqrt(D/E);
phi=DiffusionSolverClean(-a,a,.1,-1,1,2,D,E,S,0,'reflecting',0,'reflecting');%One-Dimensional Case with analytical solution y=-S*(exp(x/L)+exp(-x/L))./(E*(exp(a/L)+exp(-a/L)))+S/E;
x=linspace(-a,a,(numel(phi))/2);
for i=1:numel(phi)/2
    error(i)=phi(1,i)-(-S*(exp(x(i)/L)+exp(-x(i)/L))./(E*(exp(a/L)+exp(-a/L)))+S/E);
end
disp(max(abs(error)))

syms x y
DiffusionSolverClean(0,10,.5,0,10,.5,1,1,symfun(abs(x-y), [x y]));%Source is absolute value of x-y, i.e. stronger towards top-left and bottom-right.
DiffusionSolverClean(0,10,.5,0,10,.5,1,1,symfun(abs(x-y), [x y]),'reflecting','reflecting','reflecting','reflecting');%No vacuum bounaries. Source is absolute value of x-y, i.e. stronger towards top-left and bottom-right.
