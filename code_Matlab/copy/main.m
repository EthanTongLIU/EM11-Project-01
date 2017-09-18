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
    [ Lege_poly , Lege_poly_D ] = Legendre( n ); 
    disp( 'Ӧ��ʹ�ø�˹-���õ»���' );
elseif ( p == '1/sqrt(1-x^2)' )
    [ poly , poly_D ] = Chebyshev( n );
elseif ( p == 'exp(-x)' )
    [ poly , poly_D ] = Laguerre( n );
elseif ( p == 'exp(-x^2)' )
    [ poly , poly_D ] = Hermite( n );
end

% ������ͼ��
Interval = linspace( a , b );
plot( Interval , f( Interval ) , 'r' );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ����ţ������ѷ���������� n �����õ¶���ʽ�� n ����
pi = 3.14159265358979323846;
ROOT = 1 : n;

for i = 1 : n
    ROOT(i) = cos( pi * ( i - 0.25 ) / ( n + 0.5 ) ) ;
    j = 0;
    while ( j <= 100 )
        root_temp = ROOT(i) - iteration( ROOT(i) , Lege_poly , Lege_poly_D , n ) ;
        if abs( ROOT(i) - root_temp ) > 0.0000001
            ROOT(i) = root_temp;
        else break % ���� while ѭ��
        end
        j = j + 1;
    end
end

ROOT

% ����ֲ�ֵ����ʽ��ϵ�����Ҽ������
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










