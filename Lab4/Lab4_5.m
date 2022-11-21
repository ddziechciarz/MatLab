A = [ 
        1,2;
        3,4
    ];

B = [
    3,3,3;
    4,5,6;
    7,4,9;
];

[U] = odwrotnosc_rzedu_3(B),
% [U] = odwrotnosc_rzedu_2(A),
%[T] = odwrotnosc_rzedu_2(U),
function [U] = odwrotnosc_rzedu_2(A)
if det(A) == 0
   U = 0;
   disp("wyznacznik ronzy od zera!")
else
   U = 1/(A(1,1)*A(2,2) - A(2,1)*A(1,2)) * [A(2,2) -A(1,2);
                                            -A(2,1) A(1,1)];
end
end

function [U] = odwrotnosc_rzedu_3(A)
if det(A) == 0
    U = 0;
    disp("wyznacznik ronzy od zera!")
else
    N = size(A);
    T = zeros(N(1),N(1)); 
    
    for i=1:N
        for j=1:N
            matrix_dop = A;
            matrix_dop(i,:) = [];
            matrix_dop(:,j) = [];

            T(i,j) = (-1).^(i+j) * det(matrix_dop);
        end
    end

    U = 1/(det(A))*T.';
end    
end