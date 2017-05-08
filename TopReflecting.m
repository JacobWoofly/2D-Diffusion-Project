for i=2:n-1 %does not include i=1 because that is left boundary i=n because corner
    %top boundary condition, j=m
    a(i,m,i-1,m)=-D(i,m)*e(m)/(2*d(i));
    a(i,m,i,m-1)=-(D(i,m)*d(i)+(D(i+1,m)*d(i+1)))/(2*e(m));
    a(i,m,i+1,m)=-D(i+1,m)*e(m)/(2*d(i+1));
    Eaij(i,m)=(E(i,m)*V(i,m)+E(i+1,m)*V(i+1,m));
    a(i,m,i,m)=Eaij(i,m)-(a(i,m,i-1,m)+a(i,m,i,m-1)+a(i,m,i+1,m));
    
    %top reflecting excludes left and right boundaries, to be defined later.
    Sij(i,m)=S(i,m)*V(i,m)+S(i+1,m)*V(i+1,m);%top reflecting boundary
end