for i=1:n;
    j=m; %tpo value condition
    a(i,j,:,:)=0;
    a(i,j,i,j)=1;
    if numel(top)>1
        Sij(i,j)=top(i);
    elseif isa(top,'symfun')
        Sij(i,j)=top(x(i),y(j));
    else
        Sij(i,j)=top; %bottom value boundary
    end
end