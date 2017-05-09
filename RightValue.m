for j=1:m
    i=n;%right boundary condition
    a(i,j,:,:)=0;
    a(i,j,i,j)=1;
    if isa(right,'symfun')
        Sij(i,j)=right(x(i),y(j));
    else
        Sij(i,j)=right; %bottom value boundary
    end
end