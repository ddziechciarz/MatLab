

clear all;
clc;

%-----1-----%
%-- Tworzenie macierzy A transformacji DFT --%
N = 100;

for k = 1:N
    for n = 1:N
        A(k,n) = (1/sqrt(N))*((exp(1i*2*pi/N))^(-(k-1)*(n-1)));
    end
end


%-- Tworzenie sygnału x --%

fs = 1000;

f1 = 100;
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

figure(1);
subplot(3,1,1);
plot(x1, 'r-o');
title('Cosinus 100Hz, amplituda 100');

subplot(3,1,2);
plot(x2, 'g-o');
title('Cosinus 200Hz, amplituda 200');

subplot(3,1,3);
plot(x, 'b-o');
title('Sygnał x(t) - suma cosinusów');

% DFT %
%X = A * x';
X = fft(x);


%-- rysowanie widma itd. --%
rX = real(X); %część rzeczywista
imX = imag(X); %część urojona
zX = abs(X); %moduł
phX = angle(X); %faza

f = fs*(0:N-1)/N;

figure(2);
subplot(4,1,1);
stem(f,rX, 'b o');
title('Część rzeczywista Re(X)');

subplot(4,1,2);
stem(f,imX, 'r o');
title('Część urojona Im(X)');

subplot(4,1,3);
stem(f,zX, 'g o');
title('Moduł');

subplot(4,1,4);
stem(f,phX, 'k o');
title('Faza');

%-- wyznaczanie macierzy B rekonstrukcji --%
%B = (conj(A))'; %dwuznaczna treść polecenia
B = A';
%xr = B*X;
xr = ifft(X);

figure(3);
subplot(2,1,1);
plot(x, 'k');
title('Sygnal oryginalny x(t))');
subplot(2,1,2);
plot(real(xr), 'b');
title('Sygnał zrekonstruowany xr(t)');

blad1 = max(max(abs(x - xr'))); % blad rekonstrukcji %
fprintf('Zrekonstruowano sygnał x do xr z błędem: %u\n', blad1);

X = fft(x);
xr = ifft(X);

blad2 = max(max(abs(x - xr))); % blad rekonstrukcji %
fprintf('Zrekonstruowano sygnał metodami fft/ifft z błędem: %u\n', blad2);

roznica = (blad2/blad1);
fprintf('Różnica w rekonstrukcjach = %u ---> Podobieństwo do 1/N\n', roznica);



%-- Zmiana f1 na 125Hz --%
f1 = 125;
x1 = A1*cos(2*pi*f1*tfs1 + o1);
x2 = A2*cos(2*pi*f2*tfs2 + o2);
x =  x1 + x2; % sygnal x %

figure(4);
subplot(3,1,1);
plot(x1, 'r-o');
title('Cosinus 125Hz, amplituda 100');

subplot(3,1,2);
plot(x2, 'g-o');
title('Cosinus 200Hz, amplituda 200');

subplot(3,1,3);
plot(x, 'b-o');
title('Sygnał x(t) - suma cosinusów');

% DFT %
X = A * x';


%-- rysowanie widma itd. --%
rX = real(X); %część rzeczywista
imX = imag(X); %część urojona
zX = abs(X); %moduł
phX = angle(X); %faza

%f =(0:N-1)*fs/N;

figure(5);
subplot(4,1,1);
stem(f,rX, 'b o');
title('Część rzeczywista Re(X) (f1 = 125Hz)');

subplot(4,1,2);
stem(f,imX, 'r o');
title('Część urojona Im(X) (f1 = 125Hz)');

subplot(4,1,3);
stem(f,zX, 'g o');
title('Moduł (f1 = 125Hz)');

subplot(4,1,4);
stem(f,phX, 'k o');
title('Faza (f1 = 125Hz)');
