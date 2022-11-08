%matrix_obwod_dc.m
clear all; close all;
R1 = 10; R2 = 20; R3 = 30; R0 = 40;
E1 = 1; E2 = 2; E3 = 3;
A = [ R1+R2, -R2, 0; 
-R2, R2+R3, -R3; 
0, -R3, R3+R0 ],
b = [ E1-E2; 
E2-E3; 
E3 ],
% x = ?
x1 = inv(A)*b; % A^(-1)<=== !!!
x2 = pinv(A)*b; % (A^T * A)^(-1) * A^T
x3 = A \ b; % minimaliacja bledu sredniokwadratowego
% Metoda Cramera
for k=1:length(b)
Ak = A; Ak(:,k) = b; % (w,k) = (:,k)
x4(k) = det( Ak ) / det(A);
end
x4 = x4.';
[ x1, x2, x3, x4 ], pause