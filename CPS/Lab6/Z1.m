
% Zadanie 1 - Filtr cyfrowy IIR
clear all; close all;

% Instrukcja do zadani

%%
% W pliku butter.mat znajdują się z-zera, p-bieguny 
% i k-współczynnik wzmocnienia analogowego filtru Butterwortha typu BP 
% o częstotliwościach granicznych odpowiednio dolna 1189 i górna 1229 Hz
load('butter.mat');

%% Dane do sygnałów
N  = 16*10^3;           % liczba probek
fs = 16*10^3;           % czestotliwosc probkowania

f1 = 1209;              % częstotliwości sygnałów              
f2 = 1272;

dt = 1/fs;              % krok próbkowania
T  = N/fs;              % czas trwania probkowania (1s)

sample = 0:dt:T-dt;     % przedział czasowy próbkowania

%% Dane do filtrów
df = fs/N;
f  = 0:df:fs-df;
w  = 2*pi*f;

%% Tworzenie sygnału z sumy sinusów
% Wygeneruj sygnał cyfrowy o czasie trwania 1s, 
% częstotliwości próbkowania fs=16 kHz, 
% złożony z sumy dwóch harmonicznych o częstotliwościach 
% odpowiednio: 1209 i 1272 Hz.

s1 = @(t) sin(2*pi*f1*t);
s2 = @(t) sin(2*pi*f2*t);

% Sygnał x z sumy sinusów 
x = s1(sample) + s2(sample);

% Fast Fourier Transform
X    = fft(x)/max(fft(x));
Xlog = 20*log10(abs(X));

%% Sygnał i jego charakterystyka

t = dt*(0:N-1);
figure('Name', 'Sygnał');
set(figure(1),'units','points');
plot(t, x,'b');
title('Sygnał wejściowy x');
xlabel('Czas [s]');
ylabel('Amplituda [V]');
grid;

figure('Name', 'Charakterystyka amplitudowo-częstotliwościowa sygnału wejściowego');
set(figure(2),'units','points');

subplot(1,2,1);
plot(f, abs(X),'b');
title('Charakterystyka X w skali liniowej');
xlabel('Częstotliwość [Hz]');
ylabel('Amplituda [V/V]');
%xlim([0 8000]);
xlim([1100 1300]);
ylim([0 1.2]);
grid;

subplot(1,2,2);
plot(f, Xlog,'b');
title('Charakterystyka X w skali decybelowej');
xlabel('Częstotliwość [Hz]');
ylabel('Amplituda [dB]');
%xlim([0 8000]);
xlim([1100 1300]);
ylim([-350 20]);
grid;

%% Tworzenie filtru analogowego 

bm = poly(z);          
an = poly(p);          

Ha    = polyval(bm, j*w)./polyval(an, j*w);
Ha    = Ha./max(Ha);
Halog = 20*log10(abs(Ha));

%% Tworzenie filtru cyfrowego
% Używając transformaty biliniowej wykonaj konwersję analogowego filtru 
% H(s) do postaci cyfrowej H(z). 
% Załóż, że częstotliwość próbkowania to fs=16 kHz.

[zd,pd,kd] = bilinear(z,p,k,fs);

z  = exp(j*w/fs);
bm = poly(zd);          
an = poly(pd);

Hd    = kd * polyval(bm, z)./polyval(an, z);
Hd    = Hd./max(Hd);
Hdlog = 20*log10(abs(Hd));

%% Porównanie filtrów

figure('Name', 'Filtry analogowy i cyfrowy');
set(figure(3),'units','points');
hold on;
plot(f, Halog,'b');
plot(f, Hdlog,'r');
plot([1189 1189], [-70 20], 'k');
plot([1229 1229], [-70 20], 'k');
title('Filtr analogowy i cyfrowy (Ha, Hd)');
legend('Analogowy','Cyfrowy');
xlabel('Częstotliwość [Hz]');
ylabel('H [j\omega]');
xlim([1100 1300]);
%ylim([-900 200]);
ylim([-70 20]);
grid;
hold off;

%% Filtracja cyfrowa

y1 = filter(bm,an,x);

% Własna implementacja algorytmu filtracji
% https://www.mathworks.com/help/matlab/ref/filter.html#buagwwg-2

N = length(an);
ak = an(2:N); 
N = N-1;

M = length(bm);
xnm = zeros(1, M);
ynk = zeros(1, N);

for n = 1:16e3
    xnm    = [x(n)  xnm(1:M-1)];
    y2(n) = sum(xnm.*bm) - sum(ynk.*ak);
    ynk    = [y2(n) ynk(1:N-1)];
end


%%
Y1    = fft(y1)/max(fft(y1));
Y1log = 20*log10(abs(Y1));

Y2    = fft(y2)/max(fft(y2));
Y2log = 20*log10(abs(Y2));

figure('Name', 'Charakterystyka amplitudowo-częstotliwościowa sygnału wyjściowego');
set(figure(4),'units','points');

subplot(1,2,1);
hold on;
plot(f, abs(Y1),'b');
plot(f, abs(Y2),'r');
title('Charakterystyka Y w skali liniowej');
xlabel('Częstotliwość [Hz]');
ylabel('Amplituda [V/V]');
legend('matlab','własny');
%xlim([0 8000]);
xlim([1100 1300]);
ylim([0 1.2]);
grid;
hold off;

subplot(1,2,2);
hold on;
plot(f, Y1log,'b');
plot(f, Y2log,'ro');
title('Charakterystyka Y w skali decybelowej');
xlabel('Częstotliwość [Hz]');
ylabel('Amplituda [dB]');
legend('matlab','własny');
%xlim([0 8000]);
xlim([1100 1300]);
ylim([-70 10]);
grid;
hold off;

