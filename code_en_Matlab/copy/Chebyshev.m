function [ cheb_poly , ROOT , W ] = Chebyshev( n )
%CHEBYSHEV 构造 n 阶切比雪夫多项式，次数由低到高
% 输入阶数 n，输出 n 阶切比雪夫多项式 cheb_poly

P = zeros( n+1 );
P(1,1) = 1;
P(2,2) = 1;
Temp = 1 : n+1;
for i = 3 : 1 : n+1
    for j = n+1 : -1 : 2
        Temp(j) = P(i-1,j-1);     
    end
    Temp(1) = 0;
    P(i,:) = 2 * Temp - P(i-2,:);
end
cheb_poly = 1 : n+1;
for i = 1 : n+1
    cheb_poly(i) = P(n+1,i);
end
disp( [ num2str(n),'阶切比雪夫多项式为：' ] );
disp( cheb_poly );

pi = 3.14159265358979323846;
ROOT = 1 : n;
for i = 1 : n
    ROOT(i) = cos( ( 2 * i - 1 ) / ( 2 * n ) * pi );
end
disp( ['切比雪夫多项式的',num2str(n),'个根为：' ] );
disp( ROOT );

W = 1 : n;
for i = 1 : n
    W(i) = pi / n;
end

end

