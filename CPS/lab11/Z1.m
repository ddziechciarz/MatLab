clear all;
close all;

%% Wczytanie próbki dźwiękowej
[x,Fs] = audioread( 'DontWorryBeHappy.wav', 'native' );
x = double( x );

%% KODER
a = 0.9545; % parametr a kodera
d = x - a*[[0,0]; x(1:end-1,:)]; % KODER

%% KWANTYZACJA
ile_bitow = 32; % rozdzielczosc sygnalu w bitach - ilosc stanow 2^n
dq = lab11_kwant(d,ile_bitow); % kwantyzator

n=1:length(x); % os x do wykresow

% wykres porownujacy sygnal przed i po kwantyzacji
%{
figure;
n=1:length(x);
subplot(1,2,1);
hold all;
plot( n, d(:,1), 'b');
plot( n, dq(:,1), 'r-o');
title('Kwantyzacja kanal lewy'); legend('Org. zakodowany','Kwant.');
subplot(1,2,2);
hold all;
plot( n, d(:,2), 'b');
plot( n, dq(:,2), 'r-o');
title('Kwantyzacja kanał prawy'); legend('Org. zakodowany','Kwant.');
%}

%% DEKODER
% dekodowanie sygnalu nieskwantyzowanego
y1(1) = d(1,1); % kanal lewy
for k=2:length(dq)
    y1(k) = d(k,1) + a*y1(k-1);
end

y2(1) = d(1,2); % kanal prawy
for k=2:length(dq)
    y2(k) = d(k,2) + a*y2(k-1);
end


% dekodowanie sygnalu z kwantyzacja 
ydl(1) = dq(1,1); %kanal lewy
for k=2:length(dq)
    ydl(k) = dq(k,1) + a*ydl(k-1);
end


ydp(1) = dq(1,2); %kanal prawy
for k=2:length(dq)
    ydp(k) = dq(k,2) + a*ydp(k-1);
end

%% Wykresy (po dekodowaniu)
figure;
subplot(1,2,1);
hold all;
plot( n, x(:,1), 'b');
plot( n, y1, 'r');
title('Zdekodowany kanal lewy'); legend('Org.','Zdekod.');
subplot(1,2,2);
hold all;
plot( n, x(:,2), 'b');
plot( n, y2, 'r');
title('Zdekodowany kanal prawy'); legend('Org.','Zdekod.');


figure;
subplot(1,2,1);
hold all;
plot( n, x(:,1), 'b');
plot( n, ydl, 'r');
title('Zdekodowany kanal lewy (z kwantyzacja)'); legend('Org.','Zdekod.');
subplot(1,2,2);
hold all;
plot( n, x(:,2), 'b');
plot( n, ydp, 'r');
title('Zdekodowany kanal prawy (z kwantyzacja)'); legend('Org.','Zdekod.');

display('Roznica miedzy oryginalem a odtworzonym:');
display(abs(max(x(:,1)-y1')));
display(abs(max(x(:,2)-y2')));
display('Roznica miedzy oryginalem skwantowanym a odtworzonym:');
display(abs(max(x(:,1)-ydl')));
display(abs(max(x(:,2)-ydp')));

y_kwant = vertcat(ydl,ydp); % laczymy zdekodowanysygnal prawy z lewym
soundsc(y_kwant,Fs); % odtwarzamy stereo


