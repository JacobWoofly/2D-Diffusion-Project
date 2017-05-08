for j=2:m-1 %does not include j=1 because that is bottom boundary or j=m because corner.
    %right boundary condition, i=n
    a(1,j,1+1,j)=-(D(2,j)*e(j)+D(2,j+1)*e(j+1))/(2*d(2));
    a(1,j,1,j-1)=-(D(2,j)*d(2))/(2*e(j));
    a(1,j,1,j+1)=-D(2,j+1)*d(2)/(2*e(j+1));
    Eaij(1,j)=(E(2,j)*V(2,j)+E(2,j+1)*V(2,j+1));
    a(1,j,1,j)=Eaij(1,j)-(a(1,j,1+1,j)+a(1,j,1,j-1)+a(1,j,1,j+1));
    
    %excludes bottom and top boundaries, to be defined later
    Sij(1,j)=S(2,j)*V(2,j)+S(2,j+1)*V(2,j+1);%left reflecting boundary
end
