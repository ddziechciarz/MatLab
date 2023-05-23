%% wczytanie sygnału wejściowego
[dref,fs]=audioread('mowa8000.wav');

%% sygnał z szumem białym zamiast mowy
X=zeros(length(dref),1);
drefAWGN=awgn(X,30);

%% tworzenie filtru
hr=zeros(1,255);
hr(30) = 0.1;
hr(120) = -0.5;
hr(255) = 0.8;

%% przejscie probek przez obiekt
d=conv(dref,hr)'; %sygnal mowa
x=dref';

d2 = conv(drefAWGN,hr)'; %sygnal awgn
x2 = drefAWGN';

%% filtr adaptacyjny ANC - sygnal mowa
M=256;
mi=0.04;
y=[];
e=[];
bx=zeros(M,1);
h=zeros(M,1);
for n=1:length(x)
    bx=[x(n); bx(1:M-1)];
    y(n)=h'*bx;
    e(n)=d(n)-y(n);
    h=h+mi*e(n)*bx;
    %h=h+mi*e(n)*bx/(bx'*bx);
end

%% filtr adaptacyjny ANC - sygnal awgn
M2=256;
mi2=0.04;
y2=[];
e2=[];
bx2=zeros(M2,1);
h2=zeros(M2,1);
for i=1:length(x2)
    bx2=[x2(i); bx2(1:M2-1)];
    y2(i)=h2'*bx2;
    e2(i)=d2(i)-y2(i);
    h2=h2+mi2*e2(i)*bx2;
    %h2=h2+mi2*e2(i)*bx2/(bx2'*bx2);
end


%% wykresy
figure(1);
subplot(1,2,1);
hold all;
plot(abs(h),'b');
plot(abs(hr),'r');
title('Porównanie odpowiedzi');
legend('Estymacja odpowiedzi','Odpowiedz imp.');

subplot(1,2,2);
hold all;
plot(abs(h2),'b');
plot(abs(hr),'r');
title('Porównanie odpowiedzi - sygnal awgn');
legend('Estymacja odpowiedzi','Odpowiedz imp.');
