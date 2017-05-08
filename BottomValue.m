for i=1:n;
    j=1; %bottom value condition
    a(i,j,:,:)=0;
    a(i,j,i,j)=1;

    Sij(i,j)=bottom; %bottom vacuum boundary, replace 0 with value
end