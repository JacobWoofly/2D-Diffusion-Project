for j=1:m
    i=n;%right boundary condition
    a(i,j,:,:)=0;
    a(i,j,i,j)=1;
    
    Sij(i,j)=right; %left vacuum boundary, replace 0 with value.
end