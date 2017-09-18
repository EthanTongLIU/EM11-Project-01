clear,clc;

format long;

% 输入被积函数，将被积函数转化成可识别的表达式
s = input( '请输入被积函数表达式：y = ','s' ); % 利用函数句柄
f = inline( s );

% 判断应该用哪种积分来做
p = input( '请输入权函数表达式：y = ','s' );

% 输入勒让德多项式的阶数 n ，积分代数精度为 2n+1
a = input( '请输入积分下限：' );
b = input( '请输入积分上限：' );
disp( ['积分区间是[' , num2str( a ) , ',' , num2str( b ) , ']' ] );
n = input( '选择几点积分？' );
disp( [ num2str( n ),'点高斯积分，理论代数精度为',num2str( 2 * n + 1 ) ] );

if ( p == '1' )
    [ Lege_poly , Lege_poly_D ] = Legendre( n ); 
    disp( '应该使用高斯-勒让德积分' );
elseif ( p == '1/sqrt(1-x^2)' )
    [ poly , poly_D ] = Chebyshev( n );
elseif ( p == 'exp(-x)' )
    [ poly , poly_D ] = Laguerre( n );
elseif ( p == 'exp(-x^2)' )
    [ poly , poly_D ] = Hermite( n );
end

% 画函数图像
Interval = linspace( a , b );
plot( Interval , f( Interval ) , 'r' );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 利用牛顿拉夫逊迭代来计算 n 阶勒让德多项式的 n 个根
pi = 3.14159265358979323846;
ROOT = 1 : n;

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

% 求积分插值多项式的系数并且计算积分
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










