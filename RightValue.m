for j=1:m
    i=n;%right boundary condition
    a(i,j,:,:)=0;
    a(i,j,i,j)=1;
    if numel(right)>1
        Sij(i,j)=right(j);  
    elseif isa(right,'symfun')
        Sij(i,j)=right(x(i),y(j));
    else
        Sij(i,j)=right; %bottom value boundary
    end
end