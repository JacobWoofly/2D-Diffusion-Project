function [phi] = DiffusionSolverClean(xmin,xmax,d,ymin,ymax,e,D,E,S)
%DIFFUSIONSOLVERCLEAN Summary of this function goes here
%   Detailed explanation goes here
n=(xmax-xmin)/d+1; %Adding one so that x is indexed from x1 to xn.
m=(ymax-ymin)/e+1;
n=ceil(n);
m=ceil(m);
if numel(D)==1; 
    D=zeros(n,m)+D;%Di,1 and D1,j should be undefined, but we do not use them
elseif numel(D)~=(n)*(m)
    disp('error')
    return
end
if numel(E)==1;
    E=zeros(n,m)+E;%Si,1 and S1,j should be undefined, but we do not use them
elseif numel(E)~=(n)*(m)
    disp('error')
    return
end
if numel(S)==1;
    S=zeros(n,m)+S;%Si,1 and S1,j should be undefined, but we do not use them
elseif numel(S)~=(n)*(m)
    disp('error')
    return
end
V=zeros(n,m)+e*d/4;%This assumes scalar e and d. Must be redefined to accept non-uniform x and y spacing.
Eaij=zeros(n,m);
Sij=zeros(n,m); 
a=zeros(n,m,n,m);
d=zeros(n,1)+d; % d(1) and e(1) should be undefined, but they are unused.
e=zeros(m,1)+e; %These must be redefined to accept non-uniform spacing.

%define non-boundary values of Eaij and Sij
for i=2:n-1 %2 through n-1 because i=1 and i=j are different due to boundary.
    for j=2:m-1 %Equivalent to j=1 through m-1 in zero index E(0,0) does not exist and E(n+1,:) does not exist.
        Eaij(i,j)=(E(i,j)*V(i,j)+E(i+1,j)*V(i+1,j)+E(i,j+1)*V(i,j+1)+E(i+1,j+1)*V(i+1,j+1));
    end
end
for i=2:n-1
    for j=2:m-1 
        Sij(i,j)=(S(i,j)*V(i,j)+S(i+1,j)*V(i+1,j)+S(i,j+1)*V(i,j+1)+S(i+1,j+1)*V(i+1,j+1));
    end
end

%define non-boundary values of a
for i=2:n-1 %Should this be defined after boundary conditions?
    for j=2:m-1
        a(i,j,i-1,j)=-(D(i,j)*e(j)+D(i,j+1)*e(j+1)/(2*d(i)));
        a(i,j,i+1,j)=-(D(i+1,j)*e(j)+D(i+1,j+1)*e(j+1)/(2*d(i+1)));
        a(i,j,i,j-1)=-(D(i,j)*d(i)+D(i+1,j)*d(i+1)/(2*e(j)));
        a(i,j,i,j+1)=-(D(i,j+1)*d(i)+D(i+1,j+1)*d(j+1)/(2*e(j+1)));
        a(i,j,i,j)=Eaij(i,j)-(a(i,j,i-1,j)+a(i,j,i+1,j)+a(i,j,i,j-1)+a(i,j,i,j+1));
    end
end

%boundary conditions for a, Eaij, and Sij
for i=1:n;
    j=1; %bottom vacuum condition
    a(i,j,:,:)=0;
    a(i,j,i,j)=1;
end
for j=1:m
    i=1;%left vacuum boundary condition
    a(i,j,:,:)=0;
    a(i,j,i,j)=1;
end
for i=2:n-1 %does not include i=1 because that is left boundary i=n because corner
    %top boundary condition, j=m
    a(i,m,i-1,m)=-D(i,m)*e(m)/(2*d(i));
    a(i,m,i,m-1)=-(D(i,m)*d(i)+(D(i+1,m)*d(i+1)))/(2*e(m));
    a(i,m,i+1,m)=-D(i+1,m)*e(m)/(2*d(i+1));
    Eaij(i,m)=(E(i,m)*V(i,m)+E(i+1,m)*V(i+1,m));
    a(i,m,i,m)=Eaij(i,m)-(a(i,m,i-1,m)+a(i,m,i,m-1)+a(i,m,i+1,m));
end
for j=2:m-1 %does not include j=1 because that is bottom boundary or j=m because corner.
    %right boundary condition, i=n
    a(n,j,n-1,j)=-(D(n,j)*e(j)+D(n,j+1)*e(j+1))/(2*d(n));
    a(n,j,n,j-1)=-(D(n,j)*d(n))/(2*e(j));
    a(n,j,n,j+1)=-D(n,j+1)*d(n)/(2*e(j+1));
    Eaij(n,j)=(E(n,j)*V(n,j)+E(n,j+1)*V(n,j+1));
    a(n,j,n,j)=Eaij(n,j)-(a(n,j,n-1,j)+a(n,j,n,j-1)+a(n,j,n,j+1));
end
%top-right corner condition
Eaij(n,m)=E(n,m)*V(n,m);
a(n,m,n-1,m)=-D(n,m)*e(m)/(2*d(n));
a(n,m,n,m-1)=-(D(n,m)*d(n))/(2*e(m));
a(n,m,n,m)=Eaij(n,m)-(a(n,m,n-1,m)+a(n,m,n,m-1));

%Sij
for i=2:n-1 %excludes left and right boundaries, to be defined later.
    Sij(i,m)=S(i,m)*V(i,m)+S(i+1,m)*V(i+1,m);%top reflecting boundary
end
for j=2:m-1; %excludes bottom and top boundaries, to be defined later
    Sij(n,j)=S(n,j)*V(n,j)+S(n,j+1)*V(n,j+1);%right reflecting boundary
end
Sij(n,m)=S(n,m)*V(n,m);%top right
for j=1:m
    Sij(1,j)=0; %left vacuum boundary
end
for i=1:n
    Sij(i,1)=0; %bottom vacuum boundary
end

%End of a definition, now converting from a to A.
A=zeros(m*n,m*n);
c=zeros(n,n,m);   %d is middle three diagonal bands
t=zeros(n,n,m-1); %t is top diagonal band
b=zeros(n,n,m-1); %b is bottom diagonal band

%converting from one 4D array to three 3D arrays.
for j=1:m
    for i=1:n
        c(i,i,j)=a(i,j,i,j);         %define C, always exists
        if i>1
            c(i,i-1,j)=a(i,j,i-1,j); %define L, only exists for i>1
        end
        if i<n
            c(i,i+1,j)=a(i,j,i+1,j); %define R, only exists for i<n
        end
        if j<m
            t(i,i,j)=a(i,j,i,j+1);   %define T
            b(i,i,j)=a(i,j+1,i,j);   %define B
        end
    end
end

%converting from three 3D arrays to one 2D array.
for i=1:m
    A(n*i-n+1:n*i,n*i-n+1:n*i)=c(:,:,i);%Middle diagonal
end
for i=1:m-1
    A(n*i+1:n*i+n,n*i-n+1:n*i)=b(:,:,i);%bottom diagonal
    A(n*i-n+1:n*i,n*i+1:n*i+n)=t(:,:,i);%Top diagonal
end
Sv=reshape(Sij,[n,m]); %convert from 2D array into vector for solving.
% phi=GaussRel(A,Sv,ones(n*m,1),.00001);
% phi=reshape(phi,[n,m]);
phi=SORrel(A,Sv,ones(n*m,1),1.6,10^-8);
phi=reshape(phi,[n,m]);
Verifier
end

