for j=1:m
    i=1;%left boundary condition
    a(i,j,:,:)=0;
    a(i,j,i,j)=1;
    if numel(left)>1
        Sij(i,j)=left(j);    
    elseif isa(left,'symfun')
        Sij(i,j)=left(x(i),y(j));
    else
        Sij(i,j)=left; %bottom value boundary
    end
end