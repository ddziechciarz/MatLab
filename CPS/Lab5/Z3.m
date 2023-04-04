clear all;
close all;

%% Dane
fs = 256000; % czêstotliwoœæ próbkowania w Hz

figure(1);
%% butterwortha
subplot(2,4,1);
[b,a] = butter(4,0.5);
H=freqz(b,a,fs); %odpowiedz czestotliwosciowa
Hm=abs(H); HmdB=20*log10(Hm);
plot(HmdB,'k'); grid; 
title('Filtr butterwortha'); xlabel('\omega [Hz]');

subplot(2,4,5);
plot(b,'r o');

%% czebyszew 1
subplot(2,4,2);
[b,a] = cheby1(4,3,0.5);
H=freqz(b,a,fs);
Hm=abs(H); HmdB=20*log10(Hm);
plot(HmdB,'k'); grid; 
title('Filtr czebyszewa 1'); xlabel('\omega [Hz]');

subplot(2,4,6);
plot(b,'r o');

%% czebyszew 2
subplot(2,4,3);
[b,a] = cheby2(4,3,0.5);
H=freqz(b,a,fs);
Hm=abs(H); HmdB=20*log10(Hm);
plot(HmdB,'k'); grid; 
title('Filtr czebyszewa 2'); xlabel('\omega [Hz]'); 

subplot(2,4,7);
plot(b,'r o');

%% eliptyczny
subplot(2,4,4);
[b,a] = ellip(4,3,40,0.5);
H=freqz(b,a,fs);
Hm=abs(H); HmdB=20*log10(Hm);
plot(HmdB,'k'); grid;
title('Filtr eliptyczny'); xlabel('\omega [Hz]'); 

subplot(2,4,8);
plot(b,'r o');
