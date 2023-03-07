% load('adsl_x.mat'); % wczytanie sygnału z pliku
% 
% M = 32; % długość prefiksu
% N = 512; % długość bloku
% 
% %prefix1 = x(1:32);
% prefix2 = x(481:512);
% 
% %[c,lags] = xcorr(x, prefix1);
% %stem(lags,c); hold on;
% 
% [c1,lags1] = xcorr(x, prefix2);
% stem(lags1,c1);

load('adsl_x.mat'); % wczytanie sygnału z pliku

M = 32; % długość prefiksu
N = 512; % długość bloku

block = x(1:N); % pierwszy blok sygnału
prefix = block(N-M+1:N); % powtórzenie ostatnich M próbek K razy

[R, lag] = xcorr(prefix, block); % obliczenie korelacji

stem(lag,R);
[~, idx] = max(abs(R)); % znalezienie maksymalnej wartości korelacji i jej indeksu
delay = lag(idx); % przesunięcie między prefixem a blokiem

prefix_starts = 1:M:M*4; % początki prefiksów
signal_starts = prefix_starts - delay; % początki sygnału

disp(signal_starts); % wyświetlenie wyniku 