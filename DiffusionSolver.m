function [phi] = DiffusionSolver(xmin,xmax,d,ymin,ymax,e,D,E,S)
%DIFFUSIONSOLVER Summary of this function goes here
%   Detailed explanation goes here
n=(xmax-xmin)/d; 
m=(ymax-ymin)/e; %n and m in this case are the number of bins, but n+1 and 
%m+1 are the number of x and y values.
%To simplify confusion between intital i=0 and initial i=1, perhaps use
%k=i+1 where x(k)=xi where i=k-1.
%l=j+1 where y(l)=yj where j=l-1
if numel(D)==1; %Di,1 and D1,j should be undefined, but we do not use them
    D=zeros(n+1,m+1)+D;
elseif numel(D)~=(n+1)*(m+1)
    disp('error')
    return
end
if numel(E)==1;%Si,1 and S1,j should be undefined, but we do not use them
    E=zeros(n+1,m+1)+E;
elseif numel(E)~=(n+1)*(m+1)
    disp('error')
    return
end
if numel(S)==1;%Si,1 and S1,j should be undefined, but we do not use them
    S=zeros(n+1,m+1)+S;
elseif numel(S)~=(n+1)*(m+1)
    disp('error')
    return
end
V=zeros(n+1,m+1)+e*d/4;
Eaij=zeros(n-1,m-1);
Sij=zeros(n+1,m+1); 
a=zeros(n+1,m+1,n+1,m+1);
d=zeros(n+1,1)+d; % d(1) and e(1) should actually be undefined, but they are unused.
e=zeros(m+1,1)+e;
for i=2:n 
    for j=2:m %Equivalent to j=1 through m-1 in zero index E(0,0) does not exist and E(n+1,:) does not exist. 
        %Eaij(i,j)=phi(i,j)*(E(i,j)*V(i,j)+E(i+1,j)*V(i+1,j)+E(i,j+1)*V(i,j+1)+E(i+1,j+1)*V(i+1,j+1)); %PHI?
        Eaij(i,j)=(E(i,j)*V(i,j)+E(i+1,j)*V(i+1,j)+E(i,j+1)*V(i,j+1)+E(i+1,j+1)*V(i+1,j+1));
    end
end
for i=1:n
    for j=1:m
        Sij(i,j)=(S(i,j)*V(i,j)+S(i+1,j)*V(i+1,j)+S(i,j+1)*V(i,j+1)+S(i+1,j+1)*V(i+1,j+1));
    end
end
for i=2:n
    for j=2:m
        a(i,j,i-1,j)=-(D(i,j)*e(j)+D(i,j+1)*e(j+1)/(2*d(i)));
        a(i,j,i+1,j)=-(D(i+1,j)*e(j)+D(i+1,j+1)*e(j+1)/(2*d(i+1)));
        a(i,j,i,j-1)=-(D(i,j)*d(i)+D(i+1,j)*d(i+1)/(2*e(j)));
        a(i,j,i,j+1)=-(D(i,j+1)*d(i)+D(i+1,j+1)*d(j+1)/(2*e(j+1)));
        a(i,j,i,j)=Eaij(1,j)-(a(i,j,i-1,j)+a(i,j,i+1,j)+a(i,j,i,j-1)+a(i,j,i,j+1));
    end
end

%define a(0..) a(n..) a(..0) and a(..m)
A=zeros((m+1)*(n+1),(m+1)*(n+1));
d=zeros(n+1,n+1,m+1);
t=zeros(n+1,n+1,m);
b=zeros(n+1,n+1,m);
for bb=1:m+1
    for dd=1:m+1
        if bb==dd
            for aa=1:n+1
                if aa>2 && aa<n+1
                    for cc=aa-1:aa+1 %cc is always between aa-1 and aa+1
                        d(aa,cc,bb)=a(aa,bb,cc,dd);
                    end
                elseif aa<3
                    for cc=1:aa+1 %cc is always between aa-1 and aa+1
                        d(aa,cc,bb)=a(aa,bb,cc,dd);
                    end
                elseif aa>n
                    for cc=aa-1:aa %cc is always between aa-1 and aa+1
                        d(aa,cc,bb)=a(aa,bb,cc,dd);
                    end        
                end
            end
        elseif dd==bb+1
            for aa=1:n+1 %removed cc because cc always equals aa
                    t(aa,aa,bb)=a(aa,bb,aa,dd);
            end
        elseif bb==dd+1
            for aa=1:n+1 %removed cc because cc always equals aa
                    b(aa,aa,bb-1)=a(aa,bb,aa,dd);
            end
        end
%                  if bb==dd
%                      d(aa,cc,bb)=a(aa,bb,cc,dd);
%                 elseif dd==bb+1
%                     t(aa,cc,bb)=a(aa,bb,cc,dd);
%                 elseif bb==dd+1
%                     b(aa,cc,bb-1)=a(aa,bb,cc,dd);
    end
end
for i=1:m+1
    A((n+1)*i-(n):(n+1)*i,(n+1)*i-(n):(n+1)*i)=d(:,:,i);
end
for i=1:m
    A((n+1)*i-(n)+(n+1):(n+1)*i+(n+1),(n+1)*i-(n):(n+1)*i)=b(:,:,i);
    A((n+1)*i-(n):(n+1)*i,(n+1)*i-(n)+n+1:(n+1)*i+n+1)=t(:,:,i);
end
end