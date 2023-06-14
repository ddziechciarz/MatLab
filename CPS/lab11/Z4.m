clear; clc;

x1 = [ 0, 1, 2, 3, 3, 2, 1, 0 ];
x2 = [ 0, 7, 0, 2, 0, 2, 0, 7, 4, 2 ];
x3 = [ 0, 0, 0, 0, 0, 0, 0, 15 ];

H = calcEntropy(x1)
H = calcEntropy(x2)
H = calcEntropy(x3)

function H = calcEntropy(x)
    xu = unique(x);
    p = [];
    for i = 1:length(xu)
        p(end+1) = sum(x == xu(i)) / length(x);
    end

    xu
    p

    H = -1 * sum(p.*log2(p));
end