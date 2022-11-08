% rowlin_splot.m
clear all; close all;

% Parametry
M = 3;           % liczba wag systemu/ukladu/kanalu
w = 1:M;         % wagi
N = M+(M-1);     % dlugosc sygnalu niezbedna do identyfikacji wag
p = rand(1,N);   % wejscie - probki pilota
y = conv(p,w);   % wejscie p(n) --> wyjscie y(n): splot wejscia z wagami ukladu

% Estymacja wag ukladu
for m = 0:M-1
    P(1+m,1:M) = p( M+m : -1 : 1+m);
end  
y = y( M : M+M-1 );
west = inv(P)*y'

% Estymacja liczb nadanych
x = rand(1,M);   % wejscie - probki nieznane
y = conv(x,w);   % wyjscie - splot wejscia z wagami ukladu
W = zeros(M,M);  % inicjalizacja
for m = 0:M-1
    W(1+m,1:1+m) = w( 1+m : -1 : 1);
end
y = y(1:M);
xest = inv(W)*y';
xerr = x' - xest, 
