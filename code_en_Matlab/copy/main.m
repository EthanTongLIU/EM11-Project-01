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
    disp( '应该使用高斯-勒让德积分' );
    [ Lege_poly , Lege_poly_D , ROOT , W ] = Legendre( n );
elseif ( p == '1/sqrt(1-power(x,2))' )
    disp( '应该使用高斯-切比雪夫积分' );
    [ cheb_poly , ROOT , W ] = Chebyshev( n );
elseif ( p == 'exp(-x)' )
    disp( '应该使用高斯-拉盖尔积分' );
    [ lagu_poly , lagu_poly_D , ROOT , W ] = Laguerre( n );
elseif ( p == 'exp(-power(x,2))' )
    disp( '应该使用高斯-埃尔米特积分' );
    [ herm_poly , herm_poly_D , ROOT , W ] = Hermite( n );
end

% 画函数图像
Interval = linspace( a , b );
plot( Interval , f( Interval ) , 'r' );

% 求积分值
intgrate = 0;
for i = 1 : n
    intgrate = intgrate + ( b - a ) / 2 * W(i) * f( ( b - a ) / 2 * ROOT(i) + ( a + b ) / 2 );
end
disp( '积分值为：' );
disp( intgrate );










