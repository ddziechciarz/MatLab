% rekonsturkcja sygnalu pseudoanalogwoego
clear all; close all;
A = 230;               % amplituda sinusoidy w Voltach
f = 50;                % częstotliwość sinusoidy
fs1 = 10000;           % częstotliwość próbkowania PSEUDOANALOG
t1 = 0:1/fs1:1;        % wektor czasu od 0 do 1 s z krokiem próbkowania 1/fs1
x1 = A*sin(2*pi*f*t1); % generowanie sinusoidy

figure(1);
plot(t1,x1,'b-'); hold on;
legend('pseudoanalog');
fs3 = 200;             % częstotliwość próbkowania
t3 = 0:1/fs3:1-1/fs3;  % wektor czasu od 0 do 1 s z krokiem próbkowania 1/fs3
x3 = A*sin(2*pi*f*t3);
%Następnie, należy dokonać rekonstrukcji sygnału za pomocą splotu z funkcją sinc(x):
fs = 10000;            % docelowa częstotliwość próbkowania
t = 0:1/fs:1-1/fs;     % wektor czasu od 0 do 1 s z krokiem próbkowania 1/fs
sinc_fun = sinc((ones(length(t),1)*t3) - (t'*ones(1,length(t3)))); % funkcja sinc(x)
reconstructed_signal = x3(1:200)*sinc_fun'; % rekonstrukcja sygnału
figure(2);
plot(t1,x1,'r-'); hold on;
plot(t,reconstructed_signal,'g-'); hold on;
legend('pseudoanalogowy', 'zrekonstruowany');
reconstruction_error = x1(1:length(reconstructed_signal)) - reconstructed_signal; %trzeba taki wzor bo tablica byla za duza i za mala i nie zgadzaly sie rozmiary- a do reconstruction error dam inny
%reconstructed_signal_toerr = reconstructed_signal(1:length(x1));
figure(3);
plot(t1(1:length(reconstruction_error)), reconstruction_error, 'b-');
legend('błędy rekonstrukcji');