function [ herm_poly , herm_poly_D ] = Hermite( n )
%UNTITLED 构造 n 阶埃尔米特多项式和其导多项式，次数由低到高
% 输入阶数 n，输出 n 阶埃尔米特多项式 herm_poly 和导多项式 herm_poly_D

P = zeros( n+1 );
P(1,1) = 1;
P(2,2) = 2;
Temp = 1 : n+1;
for i = 3 : 1 : n+1
    for j = n+1 : -1 : 2
        Temp(j) = P(i-1,j-1);     
    end
    Temp(1) = 0;
    P(i,:) = 2 * Temp - 2 * ( i - 2 ) * P(i-2,:);
end
herm_poly = 1 : n+1;
for i = 1 : n+1
    herm_poly(i) = P(n+1,i);
end
disp( [ num2str(n),'阶埃尔米特多项式为：' ] );
disp( herm_poly );

for i = 1 : 1 : n 
    P(n+1,i) = i * P(n+1,i+1);
end
P(n+1,n+1) = 0;
herm_poly_D = 1 : n+1;
for i = 1 : n+1
    herm_poly_D(i) = P(n+1,i);
end
disp( [ num2str(n),'阶埃尔米特多项式的导多项式为：' ] );
disp( herm_poly_D );

end

