clear all;
close all;

%% DATA
[x, fpr] = audioread('DontWorryBeHappy.wav');
Q = 100;
x = x(:,);

N = 128;
K = N/2;
[n,k] = meshgrid(0:(N-1), 0:(K-1));
win = sin(pi*(n+0.5)/N);
C = sqrt(2/K)*win.*cos(pi/K*(k+1/2).*(n+1/2+K/2));
D = C';



Nramek = floor(length(x)/N);

%% SYNTEZA I ANALIZA
y = zeros(1, length(x));
for k=1:2*Nramek
    n1st = 1+(k-1)*K; nlast = N+(k-1)*K;
    n = n1st:nlast;
    bx = x(n);
    BX = C*bx;
    
    by= D*BX;
    y(n) = y(n) + by';
end
y = y';

%% POST SCRIPTUM
n=1:length(x);
error = abs(x-y);

figure;
plot(n,x,'b', n,y,'r');
grid;
title('Sygnały WE i WY');

figure;
plot(n,error);
grid;
title('Błąd odtworzenia');