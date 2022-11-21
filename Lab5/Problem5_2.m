% interp_circle.m
% x(i) = ax0 +ax1*i^1 + ax2*i^2 + ... + axN*i^N
% y(i) = ay0 +ay1*i^1 + ay2*i^2 + ... + ayN*i^N
clear all; close all;
N = 5; % stopien wielomianow
i = (0 : N)'; % zmienna "i" wielomianu w wezlach ("rzadka")
xi = cos( 2*pi/N * i ); % wartosci funkcji x=kosinus w wezlach
yi = sin( 2*pi/N * i ); % wartosci funkcji y=sinus w wezlach
[ i, xi, yi ], pause % sprawdzenie wartosci
X = vander(i), pause % wygenerowanie i pokazanie macierzy Vandermonde’a
ax = inv(X) * xi; % obliczenie wielu wsp. wielomianu dla zmiennej x
ay = inv(X) * yi; % obliczenie wielu wsp. wielomianu dla zmiennej y
id = 0 : 0.01 : N; % zmienna "i" dokladna
xd = cos( 2*pi/N * id ); % dokladne wartosci x
yd = sin( 2*pi/N * id ); % dokladne wartosci y
figure; plot( xi,yi,'ko', xd,yd,'r--', polyval(ax,id), polyval(ay,id),'b.-');
xlabel('x'); ylabel('y'); title('y=f(x)'); axis square; grid; pause
