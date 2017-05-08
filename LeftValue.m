for j=1:m
    i=1;%left vacuum boundary condition
    a(i,j,:,:)=0;
    a(i,j,i,j)=1;
    
    Sij(i,j)=left; %left vacuum boundary, replace 0 with value.
end