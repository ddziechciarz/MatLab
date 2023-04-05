clear all;
close all;

%% Dane
fs = 256000; % częstotliwość próbkowania w Hz

figure(1);
%% butterwortha
subplot(2,4,1);
[n, Wn] = buttord(64000/(fs+100/2), 128000/(fs+100/2), 3, 40);
[b,a] = butter(n,Wn);
H=freqz(b,a,fs); %odpowiedz czestotliwosciowa
Hm=abs(H); HmdB=20*log10(Hm);
plot(HmdB,'k'); grid; 
title('Filtr butterwortha'); xlabel('\omega [Hz]');

subplot(2,4,5);
plot(b,'r o');

%% czebyszew 1
subplot(2,4,2);
[n, Wn] = cheb1ord(64000/(fs+100/2), 128000/(fs+100/2), 3, 40);
[b,a] = cheby1(n,3,Wn);
H=freqz(b,a,fs);
Hm=abs(H); HmdB=20*log10(Hm);
plot(HmdB,'k'); grid; 
title('Filtr czebyszewa 1'); xlabel('\omega [Hz]');

subplot(2,4,6);
plot(b,'r o');

%% czebyszew 2
subplot(2,4,3);
[n, Wn] = cheb2ord(64000/(fs+100/2), 128000/(fs+100/2), 3, 40);
[b,a] = cheby2(n,40,Wn);
H=freqz(b,a,fs);
Hm=abs(H); HmdB=20*log10(Hm);
plot(HmdB,'k'); grid; 
title('Filtr czebyszewa 2'); xlabel('\omega [Hz]'); 

subplot(2,4,7);
plot(b,'r o');

%% eliptyczny
subplot(2,4,4);
[n, Wn] = ellipord(64000/(fs+100/2), 128000/(fs+100/2), 3, 40);
[b,a] = ellip(n,3,40,Wn);
H=freqz(b,a,fs);
Hm=abs(H); HmdB=20*log10(Hm);
plot(HmdB,'k'); grid;
title('Filtr eliptyczny'); xlabel('\omega [Hz]'); 

subplot(2,4,8);
plot(b,'r o');