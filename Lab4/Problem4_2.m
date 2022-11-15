clear all; close all;

A = [4 12 -16;
    12 37 -43;
    -16 -43 98];

U = chol(A),
[U, L] = myLu(A),

function [L,U] = myLu(A) %dekompozycja cholskiego
[N,N] = size(A);
   L = eye(N);
   for j=1:N
       value=0;
       for k=1:j-1
           value = value + L(j,k)^2;
       end
       L(j,j) = sqrt(A(j,j) - value);
       for i=j+1:N
           value = 0;
           for k=1:j-1
               value = value + L(i,k)*L(j,k);
           end
           L(i,j) = (1/L(j,j)) * (A(i,j) - value);
       end
   end
   U = L.';
end
