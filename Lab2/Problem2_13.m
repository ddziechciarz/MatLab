a = 10;
b = 7*10^150;
c = 3;

delta = b^2 - 4*a*c;
sqrDelta = sqrt(delta);
x1 = (-b-sqrDelta)/(2*a);
x2 = (-b+sqrDelta)/(2*a);

if abs(x1) > abs(x2)
x1,
x2 = 2*c/(-b-sqrDelta),
else
x1 = (2*c)/(-b+sqrDelta),
x2,
end