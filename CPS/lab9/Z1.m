%% dane do sygnnalu
fs  = 8000;     %czestotliwosc probkowania
t = 0:1/fs:1;
A1 = -0.5;
f1 = 34.2;
A2 = 1;
f2 = 115.5;

%% sygnal czysty do porownania - referencyjny
dref = A1*cos(2*pi*f1*t) + A2*cos(2*pi*f2*t);

%% awgn 10dB
d = awgn(dref, 10, 'measured'); % WE: sygnał odniesienia dla sygnału x
x = [ d(1) d(1:end-1) ]; % WE: sygnał filtrowany, teraz opóźniony d
M = 50; % długość filtru
mi = 0.004; % współczynnik szybkości adaptacji

y = []; e = []; % sygnały wyjściowe z filtra
bx = zeros(M,1); % bufor na próbki wejściowe x
h = zeros(M,1); % początkowe (puste) wagi filtru

for n = 1 : length(x)
    bx = [ x(n); bx(1:M-1) ]; % pobierz nową próbkę x[n] do bufora
    y(n) = h' * bx; % oblicz y[n] = sum( x .* bx) – filtr FIR
    e(n) = d(n) - y(n); % oblicz e[n]
    h = h + mi * e(n) * bx; % LMS
    % h = h + mi * e(n) * bx /(bx'*bx); % NLMS
end

%% awgn 20dB
d2 = awgn(dref, 20, 'measured'); % WE: sygnał odniesienia dla sygnału x
x2 = [ d2(1) d2(1:end-1) ]; % WE: sygnał filtrowany, teraz opóźniony d
M2 = 50; % długość filtru
mi2 = 0.01; % współczynnik szybkości adaptacji

y2 = []; e2 = []; % sygnały wyjściowe z filtra
bx2 = zeros(M2,1); % bufor na próbki wejściowe x
h2 = zeros(M2,1); % początkowe (puste) wagi filtru

for m = 1 : length(x2)
    bx2 = [ x2(m); bx2(1:M2-1) ]; % pobierz nową próbkę x[n] do bufora
    y2(m) = h2' * bx2; % oblicz y[n] = sum( x .* bx) – filtr FIR
    e2(m) = d2(m) - y2(m); % oblicz e[n]
    h2 = h2 + mi2 * e2(m) * bx2; % LMS
    % h2 = h2 + mi2 * e2(m) * bx2 /(bx2'*bx2); % NLMS
end

%% awgn 40dB
d4 = awgn(dref, 40,'measured'); % WE: sygnał odniesienia dla sygnału x
x4 = [ d4(1) d4(1:end-1) ]; % WE: sygnał filtrowany, teraz opóźniony d
M4 = 50; % długość filtru
mi4 = 0.01; % współczynnik szybkości adaptacji

y4 = []; e4 = []; % sygnały wyjściowe z filtra
bx4 = zeros(M4,1); % bufor na próbki wejściowe x
h4 = zeros(M4,1); % początkowe (puste) wagi filtru

for j = 1 : length(x4)
    bx4 = [ x4(j); bx4(1:M4-1) ]; % pobierz nową próbkę x[n] do bufora
    y4(j) = h4' * bx4; % oblicz y[n] = sum( x .* bx) – filtr FIR
    e4(j) = d4(j) - y4(j); % oblicz e[n]
    h4 = h4 + mi4 * e4(j) * bx4; % LMS
    % h4 = h4 + mi4 * e4(j) * bx4 /(bx4'*bx4); % NLMS
end

%% wykresy
figure(1);

subplot(3,1,1);
plot(t,dref,t,d,t,y);
title('AWGN 10dB');
legend('Sygnal czysty','Zaszumiony','Po odszumieniu');

subplot(3,1,2);
plot(t,dref,t,d2,t,y2);
title('AWGN 20dB');
legend('Sygnal czysty','Zaszumiony','Po odszumieniu');

subplot(3,1,3);
plot(t,dref,t,d4,t,y4);
title('AWGN 40dB');
legend('Sygnal czysty','Zaszumiony','Po odszumieniu');

%% SNR
SNR10 = 10*log10((1/fs*sum(dref.^2))/(1/fs*sum((dref-y).^2)));
display(SNR10);

SNR20 = 10*log10((1/fs*sum(dref.^2))/(1/fs*sum((dref-y2).^2)));
display(SNR20);

SNR40 = 10*log10((1/fs*sum(dref.^2))/(1/fs*sum((dref-y4).^2)));
display(SNR40);



