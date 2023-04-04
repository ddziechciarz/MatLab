close all;
clear all;

%% Bieguny transmitancji - wzmocnienia
p(1) = -0.5 + 1i*9.5;
p(2) = -0.5 - 1i*9.5;
p(3) = -1 + 1i*10;
p(4) = -1 - 1i*10;
p(5) = -0.5 + 1i*10.5;
p(6) = -0.5 - 1i*10.5;

%% Zera transmitancji - zerowanie i tłumienie w pobliżu
z(1) = 1i*5;
z(2) = -1i*5;
z(3) = 1i*15;
z(4) = -1i*15;

%% Transformacja
M = length(z);
N = length(p);

w = 0:0.1:20; % oś x - pulsacja

bm = 1;
for k=1:M
    bm = bm .* (1i*w - z(k));
end

an = 1;
for l = 1:N
    an = an .* (1i*w - p(l));
end

%% Wykresy

% zera i bieguny na płaszczyźnie zespolonej
figure(1);
plot(real(z),imag(z),'or',real(p),imag(p),'*b');
legend('Zera','Bieguny');
xlabel('Real');
ylabel('Imag');
grid;
title('Zera i bieguny');

% ch. a-cz
H = abs(bm./an);
figure(2);
subplot(2,2,1);
plot(w,H);
title('|H(j\omega)|');

subplot(2,2,2);
Hlog = 20*log10(H);
plot(w,Hlog);
%semilogy(w,H);
title('20*log_{10}|H(j\omega)|');


hmax = max(H);
H2 = H./hmax;
Hlog2 = 20*log10(H2);

subplot(2,2,3);
plot(w,H2);
title('|H(j\omega)| poprawione');

subplot(2,2,4);
plot(w,Hlog2);
title('20*log_{10}|H(j\omega)| poprawione');

% ch. f-cz
figure(3);
H3 = bm./an;
Hphase = atan(imag(H3)./real(H3));
plot(w, Hphase) 
title('Charakterystyka fazowo-częstotliwościowa');
xlabel('Częstotliwośc znormalizowana');
ylabel('Faza (radiany)');

figure(4);
plot(phasez(H));


