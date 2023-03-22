clear all; close all;
[x, fs] = audioread('mowa.wav');
t = (0:length(x)-1)/fs; % czas w sekundach
plot(t, x);
xlabel('Czas [s]');
ylabel('Amplituda');

M = 8;
N = 256;
n1 = randi(length(x)-N,M,1);
n2 = n1+N-1;
xk = zeros(N,M);
for k = 1:M
    xk(:,k) = x(n1(k):n2(k));
end

A = dct(eye(N));
yk = A*xk;

figure;
for k = 1:M
    subplot(2,M,k);
    plot(x(n1(k):n2(k)));
    axis tight;
    title(['Fragment ', num2str(k)]);
    if k == 1
        ylabel('Amplituda');
    end
    subplot(2,M,k+M);
    f = (0:N-1)*fs/N;
    plot(f, abs(yk(:,k)));
    xlim([0,fs/2]);
    if k == 1
        ylabel('Moc');
    end
    xlabel('Częstotliwość [Hz]');
end