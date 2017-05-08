for j=2:m-1 %does not include j=1 because that is bottom boundary or j=m because corner.
    %right boundary condition, i=n
    a(n,j,n-1,j)=-(D(n,j)*e(j)+D(n,j+1)*e(j+1))/(2*d(n));
    a(n,j,n,j-1)=-(D(n,j)*d(n))/(2*e(j));
    a(n,j,n,j+1)=-D(n,j+1)*d(n)/(2*e(j+1));
    Eaij(n,j)=(E(n,j)*V(n,j)+E(n,j+1)*V(n,j+1));
    a(n,j,n,j)=Eaij(n,j)-(a(n,j,n-1,j)+a(n,j,n,j-1)+a(n,j,n,j+1));
    
    %excludes bottom and top boundaries, to be defined later
    Sij(n,j)=S(n,j)*V(n,j)+S(n,j+1)*V(n,j+1);%right reflecting boundary
end
