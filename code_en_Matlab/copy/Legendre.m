function [ Lege_poly , Lege_poly_D , ROOT , W ] = Legendre( n )
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

pi = 3.14159265358979323846;
ROOT = 1 : n;

% 利用牛顿拉夫逊迭代来计算 n 阶勒让德多项式的 n 个根
for i = 1 : n
    ROOT(i) = cos( pi * ( i - 0.25 ) / ( n + 0.5 ) ) ;
    j = 0;
    while ( j <= 100 )
        root_temp = ROOT(i) - iteration( ROOT(i) , Lege_poly , Lege_poly_D , n ) ;
        if abs( ROOT(i) - root_temp ) > 0.0000001
            ROOT(i) = root_temp;
        else break % 跳出 while 循环
        end
        j = j + 1;
    end
end
disp( ['勒让德多项式的',num2str(n),'个根为：' ] );
disp( ROOT );

% 求积分插值多项式的系数并且计算积分
W = 1 : n;
for i = 1 : n
    W(i) = 2 / ( ( 1 - ROOT(i) * ROOT(i) ) * power( Poly_D( ROOT(i) , Lege_poly_D , n ) , 2 ) );
end

end

