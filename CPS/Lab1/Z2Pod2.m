close all; clear all;
A = 230;
f = 50;

fs = 10000;
fs2 = 200;

dt = 1/fs;
dt2 = 1/fs2
t = 0:dt:0.1;
t2 = 0:dt2:0.1;


s = A*sin(2*pi*f*t);
s2 = A*sin(2*pi*f*t2);


rekonstrukcja = zeros(size(t));
for i = 1:length(t2)
    
    splot = s2(i)*sinc(fs2*(t-t2(i)));
    rekonstrukcja = rekonstrukcja + splot;
    
end


hold on
% plot(t2,s2, 'y-');
plot(t,s,'g-')%analogowy
plot(t,rekonstrukcja, 'b-')%rekonstruowany
plot(t,abs(s-rekonstrukcja),'r-');%bład
legend('analogowy', 'rekonstruowany', 'blad');
hold off