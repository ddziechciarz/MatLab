
clear all;
clc;

%-- Tworzenie macierzy A transformacji DFT --%
N = 100;

for k = 1:N
    for n = 1:N
        %A(k,n) = (1/sqrt(N))*((exp(1i*2*pi/N))^(-(k-1)*(n-1)));
        A(k,n) = (1/N)*((exp(1i*2*pi/N))^(-(k-1)*(n-1)));
    end
end

%-- Tworzenie sygnału x --%
fs = 1000;

f1 = 125;
f2 = 200;

A1 = 100;
A2 = 200;

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

x1 = A1*cos(2*pi*f1*tfs1 + o1);
x2 = A2*cos(2*pi*f2*tfs2 + o2);
x =  x1 + x2; % sygnal x %

% X1 DFT %
X1 = A * x';

% zwiększ rozdzielczość częstotliwości poprzez dołączenie %
% M=100 zer na końcu sygnału x %
M = 100;
xz = x;
xz(1,101:M+N) = 0;

% X2 %
X2 = fft(xz)./(N+M);

% X3 DtFT%
df = 0.25;
f = 0:df:1000;
X3 = zeros(1,length(f));
for f_i = 1:length(f)
    for n = 0:N-1
        X3(f_i) = X3(f_i) + x(n+1)*exp(-1i*2*pi*f(f_i)*n/fs);
    end
end
X3 = X3./N;





fx1 = fs*(0:N-1)/N;
fx2 = (0:2*N-1)*fs/(N+M);
fx3 = (0:40*N)*fs/(40*N);

figure(1);
subplot(1,3,1);
plot(real(X1));
title('real(X1) - DFT');

subplot(1,3,2);
plot(real(X2));
title('real(X2) - 100 zer na końcu');

subplot(1,3,3);
plot(real(X3));
title('real(X3) - DtFT');

figure(2);
plot(fx1,X1,'ro',fx2,X2,'bx',fx3,X3,'k-');
xlim([0 fs/2]);
legend('X1','X2','X3');
title('Widma sygnału gdy X3 f=0:0.25:1000');
xlabel('Częstotliwość [Hz]');

% zmiana f=-2000:0.25:2000 Hz %

f = -2*fs:df:2*fs;
X3 = zeros(1,length(f)); %%%
for f_i = 1:length(f)
    for n = 0:N-1
        X3(f_i) = X3(f_i) + x(n+1)*exp(-1i*2*pi*f(f_i)*n/fs);
    end
end
X3 = X3./N;

fx3 = (0:160*N)*fs/(40*N);

figure(3); 
plot(fx1,X1,'ro',fx2,X2,'bx',fx3,X3,'k-');
xlim([0 fs/2]);
legend('X1','X2','X3');
title('Widma sygnału gdy X3 f=-2000:0.25:2000 Hz');
xlabel('Częstotliwość [Hz]');

figure(4);
subplot(1,3,1);
plot(real(X1));
title('real(X1) - DFT');

subplot(1,3,2);
plot(real(X2));
title('real(X2) - 100 zer na końcu');

subplot(1,3,3);
plot(real(X3));
title('real(X3) - DtFT f=-2000:0.25:2000 Hz');

