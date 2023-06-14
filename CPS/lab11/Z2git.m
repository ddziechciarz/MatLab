clear all;
[s,fs] = audioread( 'DontWorryBeHappy.wav');      % wczytanie próbki dźwiękowej
s = s(:,1);                                       % wybór kanału stereo

N = 32;
n = 1:N;

%% Obliczanie Q dla C = 64 kbps
C = 64 * 10^3;
(C*length(s)/(fs *(2*length(s)-N)))
Q = 2^(C*length(s)/(fs *(2*length(s)-N)))

%% Definiowanie okna, macierzy syntezy oraz analizy
h = sin(pi*(n+0.5)/N);

for n = 1:N
    for k = 1:N/2
        A_MDCT(n,k) = sqrt(4/N) .* cos((2*pi/N) .* (k+0.5) .* (n+0.5+N/4));
    end
end

S_MDCT = A_MDCT';

%% Kodowanie

AACencoded = zeros(0,0);

for i = 1:N/2:length(s)-N/2
    w = s(i:i+N-1) .* h';
    w = w';
    w_MDCT = w * A_MDCT;
    AACencoded(end+1, :) =  w_MDCT;
end

%% Kwantyzacja

for i = 1:size(AACencoded,1)
    AACencoded(i,:) = quantizeAAC(AACencoded(i,:),256);
end

%% Dekodowanie

sig = zeros(1,size(AACencoded,1) * N/2);

for i = 1:size(AACencoded,1)-1
    w = AACencoded(i,:) * S_MDCT .*h;
    sig(i*N/2 - N/2 + 1 : i*N/2 + N/2) = sig(i*N/2 - N/2 + 1 : i*N/2 + N/2) + w;
end

sig = [ sig zeros(1, length(s) - length(sig))];

figure;
p = 1:length(s);
plot(s, 'b'); hold on;
plot(sig, 'rx');
%plot(s-sig','y');

%soundsc(sig, fs)

%% Funkcja kwantyzacji

function xq = quantizeAAC(x,N)
M = maxk(x,1);
m = mink(x,1);
R = M - m;                      % Długość przedziału wartości (range = max - min)
x = x - m;                      % Definiowanie próbek jako odległość od wartości minimalnej
x_norm = x ./ R;                % Normalizacja wartości próbek, wartości d_norm należą do <0,1>
x_norm_N = x_norm .* (N-1);     % Przeskalowanie znormalizowanych próbek przez ilość poziomów
xq_N = round(x_norm_N);         % Zaokrąglanie do najbliższej wartości
xq = (xq_N ./(N-1) .* R) + m;   % Skalowanie i przesuwanie wartości minimalnej
end