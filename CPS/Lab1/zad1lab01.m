clear all; close all;
%zad z lab 01, zad 1- próbkowanie sygnałów analogowych
A = 230;               % amplituda sinusoidy w Voltach
f = 50;                % częstotliwość sinusoidy
fs1 = 10000;           % częstotliwość próbkowania PSEUDOANALOG
t1 = 0:1/fs1:0.1;       % wektor czasu od 0 do 0.1 s z krokiem próbkowania 1/fs1
x1 = A*sin(2*pi*f*t1);   % generowanie sinusoidy
figure(1);
plot(t1,x1,'b-'); hold on;
fs2=500;
t2=0:1/fs2:0.1;
x2 = A*sin(2*pi*f*t2);
plot(t2,x2,'r-o'); hold on;
fs3=200;
t3=0:1/fs3:0.3;
x3 = A*sin(2*pi*f*t3); 
plot(t3,x3,'k-x'); hold on;
xlim([0 0.1]);  % ustalenie zakresu osi x od 0 do 0.1
xlabel('t'); ylabel('U');
title("A-sinusoida 0.1s")
legend('fs1=10kHz pseudoanalog', 'fs2=500Hz', 'fs3=200Hz');
%B-generowanie jednej sekundy
figure(2); %stworzenie wykresow w nowym oknie
bt1=0:1/fs1:1;
bx1=A*sin(2*pi*f*bt1);
plot(bt1,bx1,'b-'); hold on;
bfs2=51; %Hz probkowania
%bfs2=26;
bt2=0:1/bfs2:1;
bx2=A*sin(2*pi*f*bt2);
plot(bt2,bx2,'g-o'); hold on;
bfs3=50; %Hz
%bfs3=25;
bt3=0:1/bfs3:1;
bx3=A*sin(2*pi*f*bt3);
plot(bt3,bx3,'r-o'); hold on;
bfs4=49; %Hz
%bfs4=24;
bt4=0:1/bfs4:1;
bx4=A*sin(2*pi*f*bt4);
plot(bt4,bx4,'k-o'); hold on;
xlim([0 1]);  % ustalenie zakresu osi x
xlabel('t');
title("B-sinusoida 1s")
legend('10kHz pseudoanalog', '51Hz', '50Hz','49Hz');
%%%%C
fs=100;
figure(3);
t = 0:1/fs:1; 
for i = 1:61   % 61 obiegów pętli
    f = (i-1)*5;   % wartość częstotliwości
    x = sin(2*pi*f*t);   % sinusoida o zadanej częstotliwoś %%%%SINUSOIDA->KOSINUSOIDA
   % figure(i);
    plot(t,x);   % wyświetlenie sinusoidy
    title(['Częstotliwość: ' num2str(f) ' Hz']);
end
figure(4);
% wyświetlenie sinusoid o wybranych częstotliwościach na jednym wykresie
f_values = [95;195;295]; %imo to te wartosci 5,105,205 hz i 95,195,295 sie nakladaja na siebie dlatego widac tylko jeden wykres dlaczego tak jestjeszcze nie wiem ale sie dowiem
%dla 95 i 105hz już są przeciwne fazy więc essa musze zobaczyc na czym ta zaleznosc polega
for i = 1:size(f_values,1)
    f = f_values(i,:); 
    x = sin(2*pi*f*t); %%%%%SINUSOIDA->KOSINOSUIDA (cos sie zepsulo albo te wyresy sie wygaszaja nawzajem idk jeszcze)
    plot(t, x); hold on;
end

title('Porównanie sinusoid o różnych częstotliwościach')
axis([0 1 -1 1]) % ustalenie zakresów osi
% %%%%D- SFM- sinusoidalna modulacja częstotliwosci
% td=0:1/fs1:1; %1 sek
% fn=50; %czestotliwosc nosna
% fm=1; %czestotlisco moudlujaca 
% df=5; %glebokosc modulacji 
% %% pdpk 1- wyswietl sygnal zmodulowany i modulujacy na jednym wykresie
% figure (5);
% carrier = sin(2*pi*fn*t);% sygnał nośny
% modulator = sin(2*pi*fm*t);% sygnał modulujący
% modulated = sin(2*pi*(fn+df*modulator).*t);% sygnał zmodulowany
% plot(t, modulated, 'b');hold on;
% plot(t, modulator, 'r-');
% title('pdpk D podpunkt 1)');
% legend('Sygnał zmodulowany', 'Sygnał modulujący');
% xlim([0 1]);
% %%pdpkt 2-sprobkuj sygnal zmodulowany i porownaj z sygnalem analogowym na
% %%jdedynym wykresie
% % parametry sygnału
% fs = 10e3;
% fn = 50;
% fm = 1;
% df = 5;
% % osie czasu
% t = linspace(0, 1, 1*fs);
% 
% % sygnał nośny
% noisy_signal = sin(2*pi*fn*t);
% 
% % sygnał modulujący
% modulating_signal = sin(2*pi*fm*t);
% 
% % sygnał zmodulowany
% modulated_signal = sin(2*pi*(fn + df*modulating_signal).*t);
% 
% % próbkowanie sygnału zmodulowanego
% fs_sampled = 25;
% t_sampled = linspace(0, 1, 1*fs_sampled);
% modulated_signal_sampled = sin(2*pi*(fn + df*sin(2*pi*fm*t_sampled)).*t_sampled);
% 
% % wykres sygnałów
% figure;
% subplot(2,1,1);
% plot(t, modulated_signal, 'b');
% hold on;
% plot(t, modulating_signal, 'r');
% title('Sygnał zmodulowany i sygnał modulujący');
% legend('Sygnał zmodulowany', 'Sygnał modulujący');
% subplot(2,1,2);
% plot(t, modulated_signal, 'b');
% hold on;
% stem(t_sampled, modulated_signal_sampled, 'r');
% title('Sygnał zmodulowany i próbkowany sygnał zmodulowany');
% legend('Sygnał zmodulowany', 'Próbkowany sygnał zmodulowany');
% 
% % błędy próbkowania
% figure;
% plot(t, modulated_signal, 'b');
% hold on;
% stem(t_sampled, modulated_signal_sampled, 'r');
% title('Błędy próbkowania sygnału zmodulowanego');
% legend('Sygnał zmodulowany', 'Próbkowany sygnał zmodulowany');
% xlim([0 1]); % musze ogadnac o co tu biega bo to skopiowane z chatgpt ale wyglada mądrze zrobie notatki i oganre
% % Wygenerowanie próbkowanego sygnału zmodulowanego
% y_modulated = sin(2*pi*fn*t + df*sin(2*pi*fm*t)); % sygnał zmodulowany
% y_modulated_sampled = resample(y_modulated, fs_sampled, fs);
% t_sampled = 0:1/fs_sampled:(length(y_modulated_sampled)-1)/fs_sampled;
% 
% % Widmo gęstości mocy sygnału przed próbkowaniem
% [P, f] = pspectrum(y_modulated, fs, 'power');
% figure;
% plot(f, P);
% title('Widmo gęstości mocy sygnału przed próbkowaniem');
% xlabel('Częstotliwość [Hz]');
% ylabel('Moc [dB]');
% xlim([0 12.5]);
% 
% % Widmo gęstości mocy sygnału po próbkowaniu
% [P_sampled, f_sampled] = pspectrum(y_modulated_sampled, fs_sampled, 'power');
% figure;
% plot(f_sampled, P_sampled);
% xlim([0 12.5]);
% title('Widmo gęstości mocy sygnału po próbkowaniu');
