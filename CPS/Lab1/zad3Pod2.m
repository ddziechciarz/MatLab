%Lab 1 - Zadanie 3, Korelacja sygnałów
close all; clear all;

load("adsl_x.mat")%Plik ładuje się jako x, wykorzystujemy póżniej tę zmienną
a = x(1+495:32+495); %prefix adsl
% a = x(1+1040:32+1040);
% a = x(1+1803:32+1803); %Something is no yes
%a = x(1+551:32+551);
%Wykonujemy funkcję korelacji sygnału, żeby znaleźć koniec ramki
corr_vect = xcorr(a,x);
%Rysujemy wykres korelacji
figure;
stem(abs(corr_vect));
%Szukamy indeksu, w którym korelacja ma peak 
[p, i] = max(corr_vect)