%top-right corner condition
Eaij(n,m)=E(n,m)*V(n,m);
a(n,m,n-1,m)=-D(n,m)*e(m)/(2*d(n));
a(n,m,n,m-1)=-(D(n,m)*d(n))/(2*e(m));
a(n,m,n,m)=Eaij(n,m)-(a(n,m,n-1,m)+a(n,m,n,m-1));

Sij(n,m)=S(n,m)*V(n,m);%top right