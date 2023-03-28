clear all;
close all;

N = 1024;
x = randn( 1, N );

X0 = fft(x); % zwykłe dft dla porownania z N/2

for n = 1:(N/2)
    y(n) = x(2*n-1) + 1i*x(2*n);
end

Y = fft(y);


for k = 2:(N/2)
    X(k) = 0.5*(Y(k)+conj(Y((N/2) - k+2))) + 0.5*1i*exp(-1i*2*pi*k/N)*(conj(Y((N/2)-k+2))-Y(k));
end


X(1) = real(Y(1)) + imag(Y(1));
S = fliplr(X);
%załoz ze Y(513)=Re(Y(0))-Im(Y(0))
%Y(513) to X(1)
%X(N/2+1) = 0.5*(X(1)+conj(Y(1))) + 0.5*1i*exp(-1i*2*pi*k/N)*(conj(Y(1))-X(1));
X((N/2+2):(N+1)) = S(1:(N/2)); % łaczenie symetrycznego widma w calosc

figure(1)
subplot(2,1,1);
stem(abs(X0));
xlim([1 N])
title('Zwykłe DFT');

subplot(2,1,2);
stem(abs(X));
xlim([1 N])
title('DFT z N/2 zespolonej');

err = mean(abs(X(2:end) - X0))
err2 = mean(abs(X(1:end-1) - X0))

