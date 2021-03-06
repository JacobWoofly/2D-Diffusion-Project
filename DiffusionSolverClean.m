function [phi,x,y] = DiffusionSolverClean(xmin,xmax,d,ymin,ymax,e,D,E,S,right,top,left,bottom)
%DIFFUSIONSOLVERCLEAN Summary of this function goes here
%   Detailed explanation goes here
if mod(xmax-xmin,d)~=0 || mod(ymax-ymin,e)~=0
    warning('Cell size does not match boundaries: reducing boundaries')
end
xmax=xmax-mod(xmax-xmin,d);
ymax=ymax-mod(ymax-ymin,e);
n=(xmax-xmin)/d+1; %Adding one so that x is indexed from x1 to xn instead of x1 to x(n+1)
m=(ymax-ymin)/e+1;
n=ceil(n);
m=ceil(m);
x=linspace(xmin,xmax,n);
y=linspace(ymin,ymax,m);
if numel(D)==1; 
    D=MatMaker(D,x,y);
elseif numel(D)~=(n)*(m)
    disp('error')
    return
end
if numel(E)==1;
    E=MatMaker(E,x,y);
elseif numel(E)~=(n)*(m)
    disp('error')
    return
end
if numel(S)==1;
    S=MatMaker(S,x,y);
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
for i=2:n-1
    for j=2:m-1
        a(i,j,i-1,j)=-(D(i,j)*e(j)+D(i,j+1)*e(j+1)/(2*d(i)));
        a(i,j,i+1,j)=-(D(i+1,j)*e(j)+D(i+1,j+1)*e(j+1)/(2*d(i+1)));
        a(i,j,i,j-1)=-(D(i,j)*d(i)+D(i+1,j)*d(i+1)/(2*e(j)));
        a(i,j,i,j+1)=-(D(i,j+1)*d(i)+D(i+1,j+1)*d(j+1)/(2*e(j+1)));
        a(i,j,i,j)=Eaij(i,j)-(a(i,j,i-1,j)+a(i,j,i+1,j)+a(i,j,i,j-1)+a(i,j,i,j+1));
    end
end

%boundary conditions for a, Eaij, and Sij
if nargin>9
    if isa(right,'double')|| isa(right, 'symfun')
        RightValue
    elseif strcmpi(right,'vacuum')
        right=0;
        RightValue
    else
        RightReflecting
        right='ref';
    end
    if isa(top,'double') || isa(top, 'symfun')
        TopValue
    elseif strcmpi(top,'vacuum')
        top=0;
        TopValue
    else
        TopReflecting
        top='ref';
    end
    if isa(left,'double') || isa(left, 'symfun')
        LeftValue
    elseif strcmpi(left,'vacuum')
        left=0;
        LeftValue
    else
        LeftReflecting
        left='ref';
    end
    if isa(bottom,'double') || isa(bottom, 'symfun')
        BottomValue
    elseif strcmpi(bottom,'vacuum')
        bottom=0;
        BottomValue
    else
        BottomReflecting
        bottom='ref';
    end
    if strcmp(right,'ref')
        if strcmp(top,'ref')
            TopRightReflecting
        end
        if strcmp(bottom,'ref')
            BottomRightReflecting
        end
    end
    if strcmp(left,'ref')
        if strcmp(top,'ref')
            TopLeftReflecting
        end
        if strcmp(bottom,'ref')
            BottomLeftReflecting
        end
    end
else
    bottom=0;%#ok<NASGU>
    BottomValue
    left=0;%#ok<NASGU>
    LeftValue
    TopReflecting
    RightReflecting
    TopRightReflecting
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
Sv=reshape(Sij,[n*m,1]); %convert from 2D array into vector for solving.
% phi=GaussRel(A,Sv,ones(n*m,1),.00001);
% phi=reshape(phi,[n,m]);
phi=SORrel(A,Sv,ones(n*m,1),1.6,10^-8);
phi=transpose(reshape(phi,[n,m]));
surf(x,y,phi)
end

