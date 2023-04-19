

clc;
% Zadanie 2 - Dekodowanie DTMF
clear all; close all;

% Instrukcja do zadania

%%
% Wybierz plik odpowiadający przedostatniej cyfrze Twojego numeru 
% legitymacjistudenckiej i rozkoduj go. 
% Sygnał s.wav to sygnał wzorcowy składający się z sekwencji
% [1,2,3,4,5,6,7,8,9,*,0,#].

[s6,fs] = audioread('s6.wav');

%%
% Rozkoduj sekwencje ,,ręcznie'' patrząc na wykres czasowo-częstotliwościowy 
% tego sygnału (funkcjaspectrogram

figure('Name', 'wykres czasowo-częstotliwościowy sygnału s6');
set(figure(2),'units','points');
spectrogram(s6, 4096, 4096-512, [0:5:2000], fs);
title('wykres czasowo-częstotliwościowy sygnału s6');
% Wyszło 39335

%% Dane z Zad1
N  = length(s6);        % liczba probek
dt = 1/fs;              % krok próbkowania

df = fs/N;
f  = 0:df:fs-df;
w  = 2*pi*f;

load('butter.mat');

%% Tworzenie filtru cyfrowego

[zd,pd,kd] = bilinear(z,p,k,fs);

z  = exp(j*w/fs);
bm = poly(zd);          
an = poly(pd);

%%
% Przefiltruj sygnał s6 cyfrowym filtrem BP z ćwiczenia 1. 
% Porównaj spektrogramy przed i po filtracji.
% Narysuj na jednym rysunku oba sygnały w dziedzinie czasu. 
% Skompensuj opóźnienie sygnału wprowadzone przez filtrację.

y6 = filter(bm,an,s6);

figure('Name', 'wykres czasowo-częstotliwościowy sygnału y6 (po filtracji BP)');
set(figure(3),'units','points');
spectrogram(y6, 4096, 4096-512, [0:5:2000], fs);
title('wykres czasowo-częstotliwościowy sygnału y6');

%%
% Porównaj spektrogramy przed i po filtracji.
% Narysuj na jednym rysunku oba sygnały w dziedzinie czasu.

t = dt*(0:N-1);
figure('Name', 'Porównanie sygnałów w dziedzinie czasu');
set(figure(4),'units','points');

subplot(2,1,1);
plot(t, s6,'b');
title('Sygnał wejściowy s6');
xlabel('Czas [s]');
ylabel('Amplituda [V]');
grid;

subplot(2,1,2);
plot(t, y6,'b');
title('Sygnał wyjściowy y6');
xlabel('Czas [s]');
ylabel('Amplituda [V]');
grid;
