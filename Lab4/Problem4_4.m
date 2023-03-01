% equnonlin_invmat.m
% A*x = b, x=?
clear all; close all;
A = [ 1 2; ...
      3 5 ];
b = [  5; ...
       11  ];
disp(det(A));
x1 = inv(A)*b,          % x=A^(-1)*b
x2 = A\b,               % optymalne rozwiazywanie rown. Ax=b
%x3 = pinv(A)*b,        % x = inv( A'*A ) * A' * b , sprawdzisz?
bhat = A*x1,            % sprawdzenie
err = max(abs(x1-x2)),% blad
%err2 = max(abs(x1-x3)),
%Oryginalnie wszystko ok.

%Przy zmianie wyznacznika z -2 na 1 nadal wszystko ok
%Przy zmianie wyznacznika z -2 na 0.5 (A(1,2) == 7/6) err wynosi 1,7764e-15
%Przy zmianie wyznacnzika z -2 na -0.02 bład (A(1,2) == 1.34) wynosi 5.6843e-14
A = A+0.01*randn(size(A)),
x3 = inv(A)*b,
x4 = A\b,
bhat = A*x2,
err = max(abs(x3-x4)),



%W tym przypadku b różni się nieznacznie od oryginalnego a err wynosi 4.4409e-16
%Wektor x również się różni
C = [1 52 43; ...
    101 51 633;
    79 1123 9],
d = [1; ...
    2;
    3],
disp(det(C));
x5 = inv(C)*d,
x6 = C\d,
x7 = pinv(C)*d,
dhat = C*x5,
err = max(abs(x5-x6)),
%W tym przypadku dhat nie różni się od d(w użytej precyzji) a err wynosi 3.4694e-18
%Tutaj właściwie wystarczy wszystko przepisywać jak w oryginalnym przykladzie tylko dobranie macierzy C jest irytujące XD
