function [ Lege_poly , Lege_poly_D ] = Legendre( n )
%LEGENDRE 构造 n 阶勒让德多项式和其导多项式，次数由低到高
% 输入阶数 n，输出 n 阶勒让德多项式 Lege_poly 和导多项式 Lege_poly_D

P = zeros( n+1 );
P(1,1) = 1;
P(2,2) = 1;
Temp = 1 : n+1;
for i = 3 : 1 : n+1
    for j = n+1 : -1 : 2
        Temp(j) = P(i-1,j-1);     
    end
    Temp(1) = 0;
    P(i,:) = ( ( 2 * ( i - 1 ) - 1 ) * Temp - ( ( i - 1 ) - 1 ) * P(i-2,:) ) / ( i - 1 );
end
Lege_poly = 1 : n+1;
for i = 1 : n+1
    Lege_poly(i) = P(n+1,i);
end
disp( [ num2str(n),'阶勒让德多项式为：' ] );
disp( Lege_poly );

for i = 1 : 1 : n 
    P(n+1,i) = i * P(n+1,i+1);
end
P(n+1,n+1) = 0;
Lege_poly_D = 1 : n+1;
for i = 1 : n+1
    Lege_poly_D(i) = P(n+1,i);
end
disp( [ num2str(n),'阶勒让德多项式的导多项式为：' ] );
disp( Lege_poly_D );

end

