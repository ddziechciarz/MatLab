clear all; close all;

% główna funkcja 2.:
A = [1 21 3; ...
    4 51 6;
    7 8 9];
disp(det(A));
U = odwrot_rzad3(A),
if U == 0
    disp(" ");
else
    disp(det(U));
    A_corr = odwrot_rzad3(U),
    if A_corr == 0
        disp(" ")
    else
        if A_corr == A
            disp("Odwrócenie prawidłowe")
        end
    end
end
err = max(abs(A - A_corr)),

% 2)Macierz rzędu 3 wykorzystująca minory macierzy
function [U] = odwrot_rzad3(A)
    if det(A) == 0
        U = 0;
        disp("Wyznacznik musi być różny od zera")
    else
        N = size(A);
        Z = zeros(N(1),N(1));
        for i=1:N
            for j=1:N
                Matrix_dop = A;
                Matrix_dop(i,:) = [];
                Matrix_dop(:,j) = [];
                Z(i,j) = (-1).^(i+j) * det(Matrix_dop);
            end
        end
        U = (1/(det(A))) * Z.';
    end
end