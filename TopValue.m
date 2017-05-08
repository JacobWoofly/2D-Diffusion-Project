for i=1:n;
    j=m; %tpo value condition
    a(i,j,:,:)=0;
    a(i,j,i,j)=1;

    Sij(i,j)=top; %bottom vacuum boundary, replace 0 with value
end