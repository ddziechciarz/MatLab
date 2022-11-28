euqations = [4 -2 1; 8 -1 1; 1 3 -1];
%x = [x; y; z];
resaults = [-4; -2; 6];

variables = inv(transpose(A) * A) * transpose(A) * b;