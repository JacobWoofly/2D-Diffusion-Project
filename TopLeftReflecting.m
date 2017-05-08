%top-left corner condition
Eaij(1,m)=E(2,m)*V(2,m);
a(1,m,1+1,m)=-D(2,m)*e(m)/(2*d(2));
a(1,m,1,m-1)=-(D(2,m)*d(2))/(2*e(m));
a(1,m,1,m)=Eaij(1,m)-(a(1,m,1+1,m)+a(1,m,1,m-1));

Sij(1,m)=S(2,m)*V(2,m);%top left