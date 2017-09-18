function [ Lege_poly , Lege_poly_D ] = Legendre( n )
%LEGENDRE ���� n �����õ¶���ʽ���䵼����ʽ�������ɵ͵���
% ������� n����� n �����õ¶���ʽ Lege_poly �͵�����ʽ Lege_poly_D

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

end

