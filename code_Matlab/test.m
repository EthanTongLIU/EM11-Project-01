clear,clc;
format long;
s = input( '请输入函数表达式：y = ','s');
f = inline( s );

f(1)