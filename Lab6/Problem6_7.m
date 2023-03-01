syms x real;

values = [];
maxN = 10;
C0 = 1;
C1 = x;
C2 = 2*x^2-1;
C3 = 2*x*C2 - C1;
C4 = 2*x*C3 - C2;
C5 = 2*x*C4 - C3;
C6 = 2*x*C5 - C4;
C7 = 2*x*C6 - C5;

fplot(C0, [-1 1]); hold on;
fplot(C1, [-1 1]); hold on;
fplot(C2, [-1 1]); hold on;
fplot(C3, [-1 1]); hold on;
fplot(C4, [-1 1]); hold on;
fplot(C5, [-1 1]); hold on;
fplot(C6, [-1 1]); hold on;
fplot(C7, [-1 1]); hold on;


% for i=0:maxN
%     syms x real;
%     fplot(Cz(i), [-1 1]); hold on;
% end



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