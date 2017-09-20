function [ herm_poly , herm_poly_D ] = Hermite( n )
%UNTITLED ���� n �װ������ض���ʽ���䵼����ʽ�������ɵ͵���
% ������� n����� n �װ������ض���ʽ herm_poly �͵�����ʽ herm_poly_D

P = zeros( n+1 );
P(1,1) = 1;
P(2,2) = 2;
Temp = 1 : n+1;
for i = 3 : 1 : n+1
    for j = n+1 : -1 : 2
        Temp(j) = P(i-1,j-1);     
    end
    Temp(1) = 0;
    P(i,:) = 2 * Temp - 2 * ( i - 2 ) * P(i-2,:);
end
herm_poly = 1 : n+1;
for i = 1 : n+1
    herm_poly(i) = P(n+1,i);
end
disp( [ num2str(n),'�װ������ض���ʽΪ��' ] );
disp( herm_poly );

for i = 1 : 1 : n 
    P(n+1,i) = i * P(n+1,i+1);
end
P(n+1,n+1) = 0;
herm_poly_D = 1 : n+1;
for i = 1 : n+1
    herm_poly_D(i) = P(n+1,i);
end
disp( [ num2str(n),'�װ������ض���ʽ�ĵ�����ʽΪ��' ] );
disp( herm_poly_D );

end

