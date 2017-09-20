clear,clc;

format long;

% ���뱻������������������ת���ɿ�ʶ��ı��ʽ
s = input( '�����뱻���������ʽ��y = ','s' ); % ���ú������
f = inline( s );

% �ж�Ӧ�������ֻ�������
p = input( '������Ȩ�������ʽ��y = ','s' );

% �������õ¶���ʽ�Ľ��� n �����ִ�������Ϊ 2n+1
a = input( '������������ޣ�' );
b = input( '������������ޣ�' );
disp( ['����������[' , num2str( a ) , ',' , num2str( b ) , ']' ] );
n = input( 'ѡ�񼸵���֣�' );
disp( [ num2str( n ),'���˹���֣����۴�������Ϊ',num2str( 2 * n + 1 ) ] );

if ( p == '1' )
    disp( 'Ӧ��ʹ�ø�˹-���õ»���' );
    [ Lege_poly , Lege_poly_D , ROOT , W ] = Legendre( n );
elseif ( p == '1/sqrt(1-power(x,2))' )
    disp( 'Ӧ��ʹ�ø�˹-�б�ѩ�����' );
    [ cheb_poly , ROOT , W ] = Chebyshev( n );
elseif ( p == 'exp(-x)' )
    disp( 'Ӧ��ʹ�ø�˹-���Ƕ�����' );
    [ lagu_poly , lagu_poly_D , ROOT , W ] = Laguerre( n );
elseif ( p == 'exp(-power(x,2))' )
    disp( 'Ӧ��ʹ�ø�˹-�������ػ���' );
    [ herm_poly , herm_poly_D , ROOT , W ] = Hermite( n );
end

% ������ͼ��
Interval = linspace( a , b );
plot( Interval , f( Interval ) , 'r' );

% �����ֵ
intgrate = 0;
for i = 1 : n
    intgrate = intgrate + ( b - a ) / 2 * W(i) * f( ( b - a ) / 2 * ROOT(i) + ( a + b ) / 2 );
end
disp( '����ֵΪ��' );
disp( intgrate );










