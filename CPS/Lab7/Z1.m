close all;
clear all;

%% dane
fpr=1200;           %czestotliwosc probkowania
df=200;             %szerokosc pasma przepustowego
fc=300;             %srodek pasma przepustowego
N=128;              %długość filtru
fup=fc+(df/2);      %gorna granica filtru
fdown=fc-(df/2);    %dolna granica filtru

%% okno hamminga
figure(1);
hold all;
b1 = fir1(N,[fdown/fpr*2 fup/fpr*2],hamming(N+1));
[h1,f1] = freqz(b1,1,N,fpr); %odpowiedz impulsowa
plot(f1,20*log10(abs(h1)));


%% okno hanninga
b2 = fir1(N,[fdown/fpr*2 fup/fpr*2],hanning(N+1));
[h2,f2] = freqz(b2,1,N,fpr);
plot(f2,20*log10(abs(h2)));


%% okno prostokatne
b3 = fir1(N,[fdown/fpr*2 fup/fpr*2],boxcar(N+1));
[h3,f3] = freqz(b3,1,N,fpr);
plot(f3,20*log10(abs(h3)));


%% okno blackmana
b4 = fir1(N,[fdown/fpr*2 fup/fpr*2],blackman(N+1));
[h4,f4] = freqz(b4,1,N,fpr);
plot(f4,20*log10(abs(h4)));


%% okno blackmana-harrisa
b5 = fir1(N,[fdown/fpr*2 fup/fpr*2],blackmanharris(N+1));
[h5,f5] = freqz(b5,1,N,fpr);
plot(f5,20*log10(abs(h5)));

%% charakterystyki amplitudowo-czestotliwosciowe
ylim([-100 0]);
xlim([0 600]);
legend('Hamming', 'Hanning', 'Prostokątne', 'Blackman', 'Blackman-Harris');
title('H(\omega) filtrów FIR')

%% charakterystyki fazowo-częstotliwościowe
figure(2);
subplot(5,1,1)
plot(f1,angle(h1));
title('FIR angle - Hamming');
subplot(5,1,2)
plot(f2,angle(h2));
title('FIR angle - Hanning');
subplot(5,1,3)
plot(f3,angle(h3));
title('FIR angle - Prostokątne okno');
subplot(5,1,4)
plot(f4,angle(h4));
title('FIR angle - Blackman');
subplot(5,1,5)
plot(f5,angle(h5));
title('FIR angle - Blackman-Harris');

%% projektowanie sygnału x
t=0:1/fpr:1-1/fpr;
fprig1=200; fprig2=400; fprig3=600;
x=sin(2*pi*fprig1*t)+sin(2*pi*fprig2*t)+sin(2*pi*fprig3*t); % sygnal x
f=(0:length(t)-1)*fpr/length(t);
X=20*log10(abs(fft(x)/length(t)*2));

%% widmo gęstości mocy sygnału x
figure(3);
hold all;
% filtrujemy przez b1 a potem z powrotem filtrujemy przez jedynke
% filtfilt - A filter transfer function equal to the squared magnitude of the original filter transfer function
y1=filtfilt(b1,1,x); 
plot(f,X,f,20*log10(abs(fft(y1)/length(t)*2)));

y2=filtfilt(b2,1,x);
plot(f,20*log10(abs(fft(y2)/length(t)*2)));

y3=filtfilt(b3,1,x);
plot(f,20*log10(abs(fft(y3)/length(t)*2)));

y4=filtfilt(b4,1,x);
plot(f,20*log10(abs(fft(y4)/length(t)*2)));

y5=filtfilt(b5,1,x);
plot(f,20*log10(abs(fft(y5)/length(t)*2)));
xlim([300 600]);
legend('Sygnał oryginalny','Hamming', 'Hanning', 'Prostokątne', 'Blackman', 'Blackman-Harris');
title('Filtracja');

