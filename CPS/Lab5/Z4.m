clc;
% Zadanie 4 - Filtr separujący
clear all; close all;

% Instrukcja do zadania
figure(1);


%% Dane
f  = 90*10^6:100:102*10^6;  % Przedział od 90MHz do 102MHz
f0 = 96*10^6;               % Częstotliwość środkowa 96MHz -+ 100kHz
w  = 2*pi*f;

%% Zaprojektuj testowy filtr  96 MHz ±1   MHz 
% Zafalowania w paśmie przepustowym nie większe niż 3 dB 
% Tłumienie w paśmie zaporowym co najmniej 40 dB.

% [bm, an] = ellip(rząd filtru, zafalowania, tłummenie, [zakres])

N=5;
[bm, an] = ellip(N, 3, 40, [2*pi*(f0-10^6) 2*pi*(f0+10^6)], 's');
H1       = polyval(bm, j*w)./polyval(an, j*w);
H1       = H1/max(H1);
H1log    = 20*log10(abs(H1));

figure('Name','Filtr testowy');
set(figure(2),'units','points');
plot(f,H1log,'b'); 
title('Skala decybelowa 20*log_{10}|H(j\omega)|');
legend('1MHz');
xlabel('Częstotliwość [Hz]');  
ylabel('H [j\omega]');
ylim([-140, 20]);
grid;

%% Zaprojektuj docelowy filtr 96 MHz ±100 kHz. 
% Zafalowania w paśmie przepustowym nie większe niż 3 dB 
% Tłumienie w paśmie zaporowym co najmniej 40 dB.

% [bm, an] = ellip(rząd filtru, zafalowania, tłummenie, [zakres])

N=3;
[bm, an] = ellip(N, 3, 40, [2*pi*(f0-10^5) 2*pi*(f0+10^5)], 's');
H2       = polyval(bm, j*w)./polyval(an, j*w);
H2       = H2/max(H2);
H2log    = 20*log10(abs(H2));

figure('Name','Filtr docelowy');
set(figure(3),'units','points');
plot(f,H2log,'r'); 
title('Skala decybelowa 20*log_{10}|H(j\omega)|');
legend('100kHz');
xlabel('Częstotliwość [Hz]'); 
ylabel('H [j\omega]'); 
ylim([-140, 20]);
grid;

%% Porównanie filtrów 
% Zaznacz punkty charakterystyczne na wykresie 
% (granice pasma zaporowego i przepustowego).

figure('Name','Porównanie filtrów');
set(figure(4),'units','points');
hold on;
plot(f,H1log,'b'); 
plot(f,H2log,'r');
title('Skala decybelowa 20*log_{10}|H(j\omega)|');
legend('1MHz','100kHz');
xlabel('Częstotliwość [Hz]'); 
ylabel('H [j\omega]'); 
ylim([-140, 20]);
grid;
hold off;

%% Zaznacz punkty charakterystyczne na wykresie 
% (granice pasma zaporowego i przepustowego).

figure('Name','Granice pasma zaporowego i przepustowego');
set(figure(5),'units','points');
hold on;
plot(f,H1log,'b'); 
plot(f,H2log,'r');
plot([95.9 95.9]*10^6, [2 -140], 'k'); 
plot([96.1 96.1]*10^6, [2 -140], 'k');
plot([95 95]    *10^6, [2 -140], 'k'); 
plot([97 97]    *10^6, [2 -140], 'k');
plot([90 102]   *10^6, [-3 -3],  'k'); 
plot([90 102]   *10^6, [-40 -40],'k'); 
title('Skala decybelowa 20*log_{10}|H(j\omega)|');
legend('1MHz','100kHz');
xlabel('Częstotliwość [Hz]'); 
ylabel('H [j\omega]'); 
grid;
hold off;
