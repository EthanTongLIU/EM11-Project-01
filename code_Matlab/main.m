clear,clc;

format long;

% 输入被积函数，将被积函数转化成可识别的表达式
s = input( '请输入被积函数表达式：y = ','s' ); % 利用函数句柄
f = inline( s );

% 输入勒让德多项式的阶数 n ，积分代数精度为 2n+1
a = input( '请输入积分下限：' );
b = input( '请输入积分上限：' );
disp( ['积分区间是[' , num2str( a ) , ',' , num2str( b ) , ']' ] );
n = input( '选择几点积分？' );
disp( [ num2str( n ),'点高斯积分，理论代数精度为',num2str( 2 * n + 1 ) ] );

% 画函数图像
Interval = linspace( a , b );
plot( Interval , f( Interval ) , 'r' );
hold on;

% 构造 n 阶勒让德多项式
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

% 求第 n 个勒让德多项式的根
% 1. 先求第 n 个多项式的导函数
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

% 2. 利用牛顿拉夫逊迭代来计算 n 阶勒让德多项式的 n 个根
pi = 3.14159265358979323846;
ROOT = 1 : n;
%for i = 1 : 1 : n
%    ROOT(i) = cos( pi * ( i - 0.25 ) / ( n + 0.5 ) ) ; % 首先在第 i 个零点附近选取一个点
%    root_temp = 0;
%    while ( ROOT(i) == root_temp )
%        root_temp = ROOT(i);
%        ROOT(i) = ROOT(i) - iteration( ROOT(i) , Lege_poly , Lege_poly_D , n ) ;
%    end
%end

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

ROOT

% 直接利用matlab自带的求根函数计算根
%ROOT = roots( fliplr( Lege_poly ) );
%ROOT

% 3. 求积分插值多项式的系数并且计算积分
W = 1 : n;
for i = 1 : n
    W(i) = 2 / ( ( 1 - ROOT(i) * ROOT(i) ) * power( Poly_D( ROOT(i) , Lege_poly_D , n ) , 2 ) );
end
W

intgrate = 0;
for i = 1 : n
    intgrate = intgrate + ( b - a ) / 2 * W(i) * f( ( b - a ) / 2 * ROOT(i) + ( a + b ) / 2 );
end

intgrate










