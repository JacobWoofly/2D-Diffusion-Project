derX=zeros(n,m);
derY=zeros(n,m);
der2X=zeros(n,m);
der2Y=zeros(n,m);
error=zeros(n,m);
error2=zeros(n,m);
for i=2:n-1
    for j=2:m-1
%         der2X(i,j)=(phi(i-1,j)-2*phi(i,j)+phi(i+1,j))/(d(i))^2;
%         der2Y(i,j)=(phi(i,j-1)-2*phi(i,j)+phi(i,j+1))/(e(i))^2;
        Dy=(D(i,j)+D(i,j+1))/2;
        Dx=(D(i,j)+D(i+1,j))/2;        
        error(i,j)=-Dy*der2Y(i,j)-Dx*der2X(i,j)+E(i,j)*phi(i,j)-S(i,j);
        if j>2 && i>2 && j<m-1 && i<n-1
            der2X(i,j)=(-phi(i+2,j)+16*phi(i+1,j)-30*phi(i,j)+16*phi(i-1,j)-phi(i-2,j))/(12*d(i)^2);
            der2Y(i,j)=(-phi(i,j+2)+16*phi(i,j+1)-30*phi(i,j)+16*phi(i,j-1)-phi(i,j-2))/(12*d(i)^2);
            error2(i,j)=-Dy*der2Y(i,j)-Dx*der2X(i,j)+E(i,j)*phi(i,j)-S(i,j);
%           derX=(phi(i+1,j)-phi(i,j))/(2*d(i+1));   
        end
    end
end
disp('done')