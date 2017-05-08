for i=2:n-1 %does not include i=1 because that is left boundary i=n because corner
    %bottom boundary condition, j=1
    a(i,1,i-1,1)=-D(i,2)*e(2)/(2*d(2));
    a(i,1,i,1+1)=-(D(i,2)*d(i)+(D(i+1,2)*d(i+1)))/(2*e(2));
    a(i,1,i+1,1)=-D(i+1,2)*e(2)/(2*d(i+1));
    Eaij(i,1)=(E(i,2)*V(i,2)+E(i+1,2)*V(i+1,2));
    a(i,1,i,1)=Eaij(i,1)-(a(i,1,i-1,1)+a(i,1,i,1+1)+a(i,1,i+1,1));
    
    %bottom reflecting excludes left and right boundaries, to be defined later.
    Sij(i,1)=S(i,2)*V(i,2)+S(i+1,2)*V(i+1,2);%bottom reflecting boundary
end