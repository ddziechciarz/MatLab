clear all; close all;
echo on

a=1;b=5;c=4;

delta = b*b-4*a*c,
if delta < 0
    disp 'brak pierwiastków';
elseif delta == 0
    zero_point = -b/(2*a),
else
    sqrDelta = sqrt(delta),
    zeroPoint_1 = (-b-sqrDelta) / 2*a,
    zeroPoint_2 = (-b+sqrDelta) / 2*a,end