% evd_jacobi.m
clear all; close all;
A = [ 2 0 1; 0 -2 0; 1 0 2 ], % przyklad z Yang, 2005
% A = hankel( [1 2 3], [3,4,5] ),
[N,N] = size(A),
% Pojedyncza rotacja zerujaca element A(p,q) macierzy A
p=1; q=3;
R1 = makeRi(p, q, A)
R1.' * A * R1,
[R, D] = solve(A)
A = [1 2 3 4;
    2 3 4 5;
    3 4 5 6;
    4 5 6 7;]
[R, D] = solve(A)
function [R, D] = solve(A)
   D = A;
   [N, N] = size(D);
   R = eye(N);
   while (1)
       Dabs = abs(D - tril(D));
       [v, x, y] = mmax(Dabs);
       assert(Dabs(y, x) == v);
      
       if (abs(v) > 0.00000000001)
           Ri = makeRi(y, x, D);
           D = Ri.' * D * Ri;
           R = R * Ri;
       else
           return
       end
   end
end
function [v, x, y] = mmax(A)
   [N, N] = size(A);
   [v, i] = max(A, [], 'all');
   % 'i' to jest numer elementu licząc kolumnami
   x = fix(i / N) + 1;
   y = rem(i, N);
   if (x == 0)
       % this is the last element of a row
       y = N;
       x = x - 1;
       return
   end
end
function [Ri] = makeRi(p, q, A)
   xi = (A(q,q) - A(p,p)) / 2 / A(p,q);
   if( xi > -eps )
       t =  (abs(xi) + sqrt(1 + xi^2));
   else
       t = -(abs(xi) + sqrt(1 + xi^2));
   end
  
   c = 1 / sqrt(1+t^2);
   s = t * c;
   [N, N] = size(A);
   Ri = eye(N);
   Ri(p, p) = c;
   Ri(q, q) = c;
   Ri(p, q) = -s;
   Ri(q, p) = s;
end
