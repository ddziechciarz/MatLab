syms f(x)

%points = [0 pi/4 pi/2];
points = [1 2 3];
h = points(2) - points(1),
values = zeros(3,2);
%f(x) = sin(x);
f(x) = 2*x^2 + x + 0.5;
testDerivatives = [0 0 0];
py=diff(f(x));
trueDerivatives = [0 0 0];

for i=1:3
    values(i,1) = points(i);
    values(i,2) = f(points(i));
    trueDerivatives(i) = subs(py, x, points(i));
end

testDerivatives(1) = 1/(2*h) * (-3*values(1,2) + 4*values(2,2) - values(3,2));
testDerivatives(2) = 1/(2*h) * (values(3,2) - values(1,2));
testDerivatives(3) = 1/(2*h) * (values(1,2) - 4*values(2,2) + 3*values(3,2));

testDerivatives,
trueDerivatives,
error = testDerivatives - trueDerivatives,