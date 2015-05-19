function [a] = colorsimilarity(A,B)
h1=A(1);
h2=B(1);
s1=A(2);
s2=B(2);
v1=A(3);
v2=B(3);
a = 1-1/sqrt(5)*((v1-v2)^2+(s1*cos(h1)-s2*cos(h2))^2+(s1*sin(h1)-s2*sin(h2))^2)^0.5;