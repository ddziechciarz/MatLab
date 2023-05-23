close all; 
clear all;

%% wczytanie sygnalow mowy
[SA,FS1]=audioread('mowa_1.wav');   %glos osoby A
[SB,FS2]=audioread('mowa_2.wav');   %glos osoby B
[SAG,FS3]=audioread('mowa_3.wav');  %glos osoby A zaszumiony G(Sb)
d=SAG';
x=SB';
previous = 0;

%% tworzenie filtru adaptacyjnego i filtracja
for c = 0.001:0.005:1
    M=15;
    mi=c;
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
    noise = e - SA';
    snr_db = 10*log10(  (1/FS1 * (sum(SA.^2))) / (1/FS1 * (sum(noise.^2))));
    if snr_db < previous;
        break
    end
    previous = snr_db;
end
display(snr_db)
display(c)

%% odsluch po przejsciu przez filtr
soundsc(e,FS1) %e - sygnal odszumiony a
