function [ result ] = Poly_D( root , Lege_poly_D , n )
% 计算一个多项式函数的函数值
% root 表示传入的自变量
% Lege_poly_D 表示传入的多项式，次数由低到高排列
% n 表示多项式最高次数
result = 0;
for i = 1 : n+1
    result = result + Lege_poly_D(i) * power( root , i-1 );
end

end

