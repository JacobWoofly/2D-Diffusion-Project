%bottom-right corner condition
Eaij(n,1)=E(n,2)*V(n,2);
a(n,1,n-1,1)=-D(n,2)*e(2)/(2*d(n));
a(n,1,n,1+1)=-(D(n,2)*d(n))/(2*e(2));
a(n,1,n,1)=Eaij(n,1)-(a(n,1,n-1,1)+a(n,1,n,1+1));

Sij(n,1)=S(n,2)*V(n,2);%bottom right