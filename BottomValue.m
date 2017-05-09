for i=1:n;
    j=1; %bottom value condition
    a(i,j,:,:)=0;
    a(i,j,i,j)=1;
    if isa(bottom,'symfun')
        Sij(i,j)=bottom(x(i),y(j));
    else
        Sij(i,j)=bottom; %bottom value boundary
    end
end