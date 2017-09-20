function [ result ] = iteration( root , Lege_poly , Lege_poly_D , n )

temp1 = 0;
for i = 1 : n+1
    temp1 = temp1 + Lege_poly(i) * power( root , i-1 );
end

temp2 = 0;
for i = 1 : n+1
    temp2 = temp2 + Lege_poly_D(i) * power( root , i-1 );
end

result = temp1 / temp2;