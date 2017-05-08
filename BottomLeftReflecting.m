%bottom-right corner condition
Eaij(1,1)=E(2,2)*V(2,2);
a(1,1,1+1,1)=-D(2,2)*e(2)/(2*d(2));
a(1,1,1,1+1)=-(D(2,2)*d(2))/(2*e(2));
a(1,1,1,1)=Eaij(1,1)-(a(1,1,1+1,1)+a(1,1,1,1+1));

Sij(1,1)=S(2,2)*V(2,2);%bottom right