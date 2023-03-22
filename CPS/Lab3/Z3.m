clear all;
clc;

N = 100;
%-- Tworzenie sygnału x z ćw 1 --%

fs = 1000;

f1 = 100;
f2 = 125;

A1 = 1;
A2 = 0.0001;

o1 = (pi/7);
o2 = (pi/11);

% Czas próbkowania %
T = 0.1;

% Jedna próbka %
fs1 = 1/fs;  
fs2 = 1/fs;  

% Próbki %
tfs1 = 0:fs1:T;
tfs2 = 0:fs2:T;
tfs1 = tfs1(1,1:100);
tfs2 = tfs2(1,1:100);

x01 = A1*cos(2*pi*f1*tfs1 + o1);
x02 = A2*cos(2*pi*f2*tfs2 + o2);
x =  x01 + x02; % sygnal x %

figure;
plot(x);

% X = fft(x)./N; % dft sygnału x %


% DtFT %
f = 0:0.1:500; % z polecenia %
X0 = zeros(1,length(f));
for fi = 1:length(f)
    for n = 0:N-1
        X0(fi) = X0(fi) + x(n+1)*exp(-1i*2*pi*f(fi)*n/fs);
    end
end
X0 = X0./N;

fx = (0:50*N)*fs/(100*N); % skalowanie osi do 0:0.1:500 %
figure(1);
plot(fx,abs(X0),'b-');
xlim([0 fs/2]);
title('DtFT x');
xlabel('Częstotliwość [Hz]');

tmax = (N-1)/fs;
t = 0:1/fs:tmax; %zakres próbkowania/próbki

% wymnóż próbki sygnału kolejno z oknami:
o_prostokatne = rectpuls(t,tmax);
o_hamminga = hamming(N)';
o_blackmana = blackman(N)';
o_czebyszewa100 = chebwin(N, 100)';
o_czebyszewa120 = chebwin(N, 120)';

x1 = x .* o_prostokatne;
x2 = x .* o_hamminga;
x3 = x .* o_blackmana;
x4 = x .* o_czebyszewa100;
x5 = x .* o_czebyszewa120;

% DtFT dla powyższych 5ciu sygnałów %
% DtFT x1 okno prostokatne %
X1 = zeros(1,length(f));    % f = 0:0.1:500; %
for fi = 1:length(f)
    for n = 0:N-1
        X1(fi) = X1(fi) + x1(n+1)*exp(-1i*2*pi*f(fi)*n/fs);
    end
end
X1 = X1./N;

% DtFT x2 okno Hamminga %
X2 = zeros(1,length(f));    % f = 0:0.1:500; %
for fi = 1:length(f)
    for n = 0:N-1
        X2(fi) = X2(fi) + x2(n+1)*exp(-1i*2*pi*f(fi)*n/fs);
    end
end
X2 = X2./N;

% DtFT x3 okno Blackmana %
X3 = zeros(1,length(f));    % f = 0:0.1:500; %
for fi = 1:length(f)
    for n = 0:N-1
        X3(fi) = X3(fi) + x3(n+1)*exp(-1i*2*pi*f(fi)*n/fs);
    end
end
X3 = X3./N;

% DtFT x4 okno Okno Czebyszewa 100db %
X4 = zeros(1,length(f));    % f = 0:0.1:500; %
for fi = 1:length(f)
    for n = 0:N-1
        X4(fi) = X4(fi) + x4(n+1)*exp(-1i*2*pi*f(fi)*n/fs);
    end
end
X4 = X4./N;

% DtFT x5 okno Okno Czebyszewa 120dB %
X5 = zeros(1,length(f));    % f = 0:0.1:500; %
for fi = 1:length(f)
    for n = 0:N-1
        X5(fi) = X5(fi) + x5(n+1)*exp(-1i*2*pi*f(fi)*n/fs);
    end
end
X5 = X5./N;


% Wykresy widm %
figure(2);
hold all;
plot(fx,abs(X1),'r-');
xlim([0 fs/2]);
title('DtFT iloczyny z oknami');
xlabel('Częstotliwość [Hz]');
grid;

plot(fx,abs(X2),'k-');
xlim([0 fs/2]);
grid;

plot(fx,abs(X3),'b-');
xlim([0 fs/2]);
grid;

plot(fx,abs(X4),'g-');
xlim([0 fs/2]);
grid;

plot(fx,abs(X5),'c-');
xlim([0 fs/2]);
grid;
legend('x z oknem prost.','x z oknem hamm.','x z oknem black.','x z oknem cz.100','x z oknem cz.120');


% Wykresy okien %
figure(3);
title('Okna');
hold all;
plot(0:N-1,o_prostokatne, 'r-');
plot(0:N-1,o_hamminga, 'k-');
plot(0:N-1,o_blackmana, 'b-');
plot(0:N-1,o_czebyszewa100, 'g-');
plot(0:N-1,o_czebyszewa120, 'c-');
legend('Prostokątne','Hamminga','Blackmana','Czebyszewa 100','Czebyszewa 120');




