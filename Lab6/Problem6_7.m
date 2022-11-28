syms x real;

values = [];
maxN = 35;

for i=0:maxN
    syms x real;
    fplot(Cz(i), [-1 1]); hold on;
end



function eq = Cz(n)
    syms x real;
    if (n == 0)
        eq = 1;
        return
    end
    if (n == 1)
        eq = x;
        return
    end
    eq = 2*x*Cz(n-1) - Cz(n-2);
    return

end