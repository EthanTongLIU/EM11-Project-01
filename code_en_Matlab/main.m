clear,clc;

format long;

% ���뱻������������������ת���ɿ�ʶ��ı��ʽ
s = input( '�����뱻���������ʽ��y = ','s' ); % ���ú������
f = inline( s );

% �������õ¶���ʽ�Ľ��� n �����ִ�������Ϊ 2n+1
a = input( '������������ޣ�' );
b = input( '������������ޣ�' );
disp( ['����������[' , num2str( a ) , ',' , num2str( b ) , ']' ] );
n = input( 'ѡ�񼸵���֣�' );
disp( [ num2str( n ),'���˹���֣����۴�������Ϊ',num2str( 2 * n + 1 ) ] );

% ������ͼ��
Interval = linspace( a , b );
plot( Interval , f( Interval ) , 'r' );
hold on;

% ���� n �����õ¶���ʽ
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
disp( [ num2str(n),'�����õ¶���ʽΪ��' ] );
disp( Lege_poly );

% ��� n �����õ¶���ʽ�ĸ�
% 1. ����� n ������ʽ�ĵ�����
for i = 1 : 1 : n 
    P(n+1,i) = i * P(n+1,i+1);
end
P(n+1,n+1) = 0;
Lege_poly_D = 1 : n+1;
for i = 1 : n+1
    Lege_poly_D(i) = P(n+1,i);
end
disp( [ num2str(n),'�����õ¶���ʽ�ĵ�����ʽΪ��' ] );
disp( Lege_poly_D );

% 2. ����ţ������ѷ���������� n �����õ¶���ʽ�� n ����
pi = 3.14159265358979323846;
ROOT = 1 : n;
%for i = 1 : 1 : n
%    ROOT(i) = cos( pi * ( i - 0.25 ) / ( n + 0.5 ) ) ; % �����ڵ� i ����㸽��ѡȡһ����
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
        else break % ���� while ѭ��
        end
        j = j + 1;
    end
end

ROOT

% ֱ������matlab�Դ���������������
%ROOT = roots( fliplr( Lege_poly ) );
%ROOT

% 3. ����ֲ�ֵ����ʽ��ϵ�����Ҽ������
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










