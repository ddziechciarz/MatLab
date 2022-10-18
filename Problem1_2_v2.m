clear all; close all;
echo on

a=1;b=12;c=7;

delta = b*b-4*a*c,
sqrDelta = sqrt(delta),
zeroPoint_1 = (-b-sqrDelta) / 2*a,
zeroPoint_2 = (-b+sqrDelta) / 2*a,

test1 = a*zeroPoint_1^2 + b*zeroPoint_1 + c,
test2 = a*zeroPoint_2^2 + b*zeroPoint_2 + c,

