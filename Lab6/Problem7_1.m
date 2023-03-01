syms x;
y = @(x) sin(x);

h = pi/8;
x0 = pi/8;

xs = [x0-h, x0, x0+h],
ys = [y(x0-h), y(x0), y(x0+h)],

a=1/2; b=1; c=1/2;
A = h*(a*ys(1) + b*ys(2) + c*ys(3)),
