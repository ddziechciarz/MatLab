clear all; close all;

syms x real;
f = 1/(1+x^2);

f1 = diff(f),
f2 = diff(f1),
f3 = diff(f2),
f4 = diff(f3),
f5 = diff(f4),
f6 = diff(f5),

mac0 = subs(f, x, 5),
mac1 = subs(f1, x, 5),
mac2 = subs(f2, x, 5),
mac3 = subs(f3, x, 5),
mac4 = subs(f4, x, 5),
mac5 = subs(f5, x, 5),
mac6 = subs(f6, x, 5),

disp(factorial(3))
disp(factorial(4))
disp(factorial(5))
disp(factorial(6))