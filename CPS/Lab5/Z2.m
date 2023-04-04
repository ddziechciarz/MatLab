clear all;
close all;

%% Dane
w3dB = 2*pi*100; %rd/s
N1 = 2; 
N2 = 4;
N3 = 6;
N4 = 8;
omega = 0:0.1:2000;

%% Tworzenie filtrów Butterwortha

%% 2
for k = 1:N1
    p1(k) = w3dB * exp(1i*((pi/2) + (1/2)*(pi/N1)+(k-1)*(pi/N1)));
end

b = 1;
for i = 1:N1
    b = b .* (1i*omega - p1(i));
end

a = 1;
for j = 1:N1
    a = a.*-p1(j);
end

H2 = a./b;
H2abs = abs(H2);

valmax = max(H2abs);
H2abs = H2abs./valmax;

%% 4
for k = 1:N2
    p2(k) = w3dB * exp(1i*((pi/2) + (1/2)*(pi/N2)+(k-1)*(pi/N2)));
end

b = 1;
for i = 1:N2
    b = b .* (1i*omega - p2(i));
end
a = 1;
for j = 1:N2
    a = a.*-p2(j);
end

H4 = a./b;
H4abs = abs(H4);

valmax = max(H4abs);
H4abs = H4abs./valmax;

%% 6
for k = 1:N3
    p3(k) = w3dB * exp(1i*((pi/2) + (1/2)*(pi/N3)+(k-1)*(pi/N3)));
end

b = 1;
for i = 1:N3
    b = b .* (1i*omega - p3(i));
end
a = 1;
for j = 1:N3
    a = a.*-p3(j);
end

H6 = a./b;
H6abs = abs(H6);

valmax = max(H6abs);
H6abs = H6abs./valmax;

%% 8
for k = 1:N4
    p4(k) = w3dB * exp(1i*((pi/2) + (1/2)*(pi/N4)+(k-1)*(pi/N4)));
end

b = 1;
for i = 1:N4
    b = b .* (1i*omega - p4(i));
end
a = 1;
for j = 1:N4
    a = a.*-p4(j);
end

H8 = a./b;
H8abs = abs(H8);

valmax = max(H8abs);
H8abs = H8abs./valmax;

%% Wykresy biegunów
figure(1);
subplot(1,4,1);
plot(real(p1),imag(p1),'b x');
title('Butterworth LP N=2');
xlim(max(abs(xlim)).*[-1.2 1.2]);

subplot(1,4,2);
plot(real(p2),imag(p2),'b x');
title('Butterworth LP N=4');
xlim(max(abs(xlim)).*[-1 1])

subplot(1,4,3);
plot(real(p3),imag(p3),'b x');
title('Butterworth LP N=6');
xlim(max(abs(xlim)).*[-1 1])

subplot(1,4,4);
plot(real(p4),imag(p4),'b x');
title('Butterworth LP N=8');
xlim(max(abs(xlim)).*[-1 1])

%% Wykresy charakterystyk
f = omega./2*pi;
figure(2); %liniowo
hold all;
plot(f,H2abs,'r');
plot(f, H4abs,'b');
plot(f, H6abs,'g');
plot(f,H8abs,'k');
title('H(j\omega) liniowo');
xlabel('Hz');
legend('N=2','N=4','N=6','N=8');

figure(3);
hold all; %logarytmicznie
plot(f,20*log10(H2abs),'r');
plot(f,20*log10(H4abs),'b');
plot(f,20*log10(H6abs),'g');
plot(f,20*log10(H8abs),'k');
title('20log_{10}H(jw)');
xlabel('Hz');
legend('N=2','N=4','N=6','N=8');


[a,b] = zp2tf([],p2',1); % Konwertuje parametry filtra zerowego wzmocnienia z biegunów do wielomianów jw
sys = tf(a,b); %transmitancja
printsys(a,b,'s') %'s' bo analog

figure(4);
impulse(sys);

figure(5);
step(sys);


