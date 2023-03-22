
% DtFT - okna i liczby próbek

clear all;
close all;

load('lab_03.mat');
indeks=411766;
a=mod(indeks,16)+1; %a=7
N=512;
M=32;
K=8;
m=0;

for m=0:K-1
    xtemp(m*N+1:(m+1)*N)=x_7(m*(N+M)+1+M:(m+1)*(N+M));
end

fs = 2208000; %%% ADSL SAMPLING FREQUENCY
figure;
for m=0:K-1
    X(m*N+1:(m+1)*N)=fft(xtemp(m*N+1:(m+1)*N));
    text=strcat('Widmo ramki m=', int2str(m));
    plot(xtemp(m*N+1:(m+1)*N));
    title(strcat('Sygnał ramki m=', int2str(m)));
    pause; 
    plot(fs*(0:N-1)/N,abs(X(m*N+1:(m+1)*N)), 'b-');
    title(text);
    xlabel('Czêstotliwość [Hz]');
    xlim([0, fs]);
    pause;
end