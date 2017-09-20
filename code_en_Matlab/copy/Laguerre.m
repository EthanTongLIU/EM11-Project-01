function [ lagu_poly , lagu_poly_D ] = Laguerre( n )
%LAGUERRE ���� n �����Ƕ�����ʽ���䵼����ʽ�������ɵ͵���
% ������� n����� n �����Ƕ�����ʽ lagu_poly �͵�����ʽ lagu_poly_D

P = zeros( n+1 );
P(1,1) = 1;
P(2,1) = 1;
P(2,2) = -1;
Temp = 1 : n+1;
for i = 3 : 1 : n+1
    for j = n+1 : -1 : 2
        Temp(j) = P(i-1,j-1);     
    end
    Temp(1) = 0;
    P(i,:) = ( 1 + 2 * ( i - 2 ) ) * P(i-1,:) - Temp - ( i - 2 )* ( i - 2 ) * P(i-2,:);
end
lagu_poly = 1 : n+1;
for i = 1 : n+1
    lagu_poly(i) = P(n+1,i);
end
disp( [ num2str(n),'�����Ƕ�����ʽΪ��' ] );
disp( lagu_poly );

for i = 1 : 1 : n 
    P(n+1,i) = i * P(n+1,i+1);
end
P(n+1,n+1) = 0;
lagu_poly_D = 1 : n+1;
for i = 1 : n+1
    lagu_poly_D(i) = P(n+1,i);
end
disp( [ num2str(n),'�����Ƕ�����ʽ�ĵ�����ʽΪ��' ] );
disp( lagu_poly_D );

end

