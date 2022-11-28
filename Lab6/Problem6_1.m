A = [4 -2 1; 8 -1 1; 1 3 -1; 2 5 4];
%x = [x; y; z];
b = [-4; -2; 6; 4];

variables = inv(transpose(A) * A) * transpose(A) * b,