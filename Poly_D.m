function [ result ] = Poly_D( root , Lege_poly_D , n )
% ����һ������ʽ�����ĺ���ֵ
% root ��ʾ������Ա���
% Lege_poly_D ��ʾ����Ķ���ʽ�������ɵ͵�������
% n ��ʾ����ʽ��ߴ���
result = 0;
for i = 1 : n+1
    result = result + Lege_poly_D(i) * power( root , i-1 );
end

end

