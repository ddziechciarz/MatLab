% ----------------------------------------------------------
% Tabela 19-4 (str. 567)
% Ćwiczenie: Kompresja sygnału mowy według standardu LPC-10
% ----------------------------------------------------------

 clear all; 
 close all;
 
% 
% Hs=spectrum.welch('Hamming',2048);
[x,fpr]=audioread('mowa1.wav');	      % wczytaj sygnał mowy (cały)
oryginalny = x;
bezdzw = 80700:81400; %głoska bezdzwieczna (Przy!ci!sku...)
dzw = 3000:3700; %gloska dzwieczna (!M!aterial kursu...)

%% Wyswietl sygnal i wybrane gloski
figure(1);
subplot(3,1,1);
plot((1:length(x))/fpr, x); title('Sygnał mowy');

subplot(3,1,2);
plot(dzw/fpr, x(dzw)); title('Gloska dzwieczna');

subplot(3,1,3);
plot(bezdzw/fpr, x(bezdzw)); title('Gloska bezdzwieczna');

%% Widma gestosci mocy
figure(2);
subplot(2,1,1);
hpsdd1=dspdata.psd(abs(x(dzw)),'Fs',fpr);
plot(hpsdd1); title('Widmo gestosci mocy - gloska dzwieczna przed preem.');

subplot(2,1,2);
hpsdb1=dspdata.psd(abs(x(bezdzw)),'Fs',fpr);
plot(hpsdb1); title('Widmo gestosci mocy - gloska bezdzwieczna przed preem.');

% soundsc(x,fpr);								% oraz odtwórz na głołnikach (słuchawkach)

%% okno Hamminga
N=length(x);	  % długość sygnału
Mlen=240;		  % długość okna Hamminga (liczba próbek)
Mstep=180;		  % przesunięcie okna w czasie (liczba próbek)
Np=10;			  % rząd filtra predykcji
gdzie=Mstep+1;	  % początkowe polożenie pobudzenia dźwięcznego

lpc=[];								   % tablica na wspóczynniki modelu sygnału mowy
s=[];									   % cała mowa zsyntezowana
ss=[];								   % fragment sygnału mowy zsyntezowany
bs=zeros(1,Np);					   % bufor na fragment sygnału mowy
Nramek=floor((N-Mlen)/Mstep+1);	% ile fragmentów (ramek) jest do przetworzenia

%% Preemfaza - filtracja wstepna
x=filter([1 -0.9735], 1, x);

%% Podpunkt a
figure(3);
subplot(3,1,1);
plot((1:length(x))/fpr, x); title('Sygnał mowy po preemfazie');

subplot(3,1,2);
plot(dzw, oryginalny(dzw), dzw, x(dzw)); title('Gloska dzwieczna przed i po preemfazie');
legend('przed','po');

subplot(3,1,3);
plot(bezdzw, oryginalny(bezdzw), bezdzw, x(bezdzw)); title('Gloska bezdzwieczna przed i po preemfazie');
legend('przed','po');

figure(4);
hpsdd2=dspdata.psd(abs(x(dzw)),'Fs',fpr);
hpsdb2=dspdata.psd(abs(x(bezdzw)),'Fs',fpr);

subplot(2,1,1);
%plot((0:length(hpsdd1.DATA)-1)/(length(hpsdd1.DATA)-1)*fpr, hpsdd1.DATA, (0:length(hpsdd2.DATA)-1)/(length(hpsdd2.DATA)-1)*fpr, hpsdd2.DATA);
plot(hpsdd2); title('Widmo gestosci mocy - gloska dzwieczna po preem.');

subplot(2,1,2);
%plot((0:length(hpsdb1.DATA)-1)/(length(hpsdb1.DATA)-1)*fpr, hpsdb1.DATA, (0:length(hpsdb2.DATA)-1)/(length(hpsdb2.DATA)-1)*fpr, hpsdb2.DATA);
plot(hpsdb2); title('Widmo gestosci mocy - gloska bezdzwieczna po preem.');

for  nr = 1 : Nramek
    
    % pobierz kolejny fragment sygnału
    n = 1+(nr-1)*Mstep : Mlen + (nr-1)*Mstep;
    bx = x(n);
    
    %Progowanie - str. 554 (570 z PDF'a)
    P = 0.3 * max (bx);
    for iii=1:length(bx)
       if(bx(iii) >= P)
           bx(iii) = bx(iii) - P;
       elseif bx(iii) <= -P
           bx(iii) = bx(iii) + P;
       else
           bx(iii) = 0;
       end
    end
    
    % ANALIZA - wyznacz parametry modelu ---------------------------------------------------
    bx = bx - mean(bx);  % usuń wartość średnią
    for k = 0 : Mlen-1
        r(k+1) = sum( bx(1 : Mlen-k) .* bx(1+k : Mlen) ); % funkcja autokorelacji
    end
    % subplot(411); plot(n,bx); title('fragment sygnału mowy');
    % subplot(412); plot(r); title('jego funkcja autokorelacji');
    
    offset=20; rmax=max( r(offset : Mlen) );	   % znajdź maksimum funkcji autokorelacji
    imax=find(r==rmax);								   % znajdź indeks tego maksimum
    if ( rmax > 0.35*r(1) ) T=imax; else T=0; end % głoska dźwięczna/bezdźwięczna?
    % if (T>80) T=round(T/2); end							% znaleziono
    % drugą podharmoniczną
%     if(T>0)
%         [T, rmax]
%     else
%         T
%     end
    rr(1:Np,1)=(r(2:Np+1))';
    for m=1:Np
        R(m,1:Np)=[r(m:-1:2) r(1:Np-(m-1))];			% zbuduj macierz autokorelacji
    end
    a=-inv(R)*rr;											% oblicz wspóczynniki filtra predykcji
    wzm=r(1)+r(2:Np+1)*a;									% oblicz wzmocnienie
    H=freqz(1,[1;a]);										% oblicz jego odp. częstotliwościową
%     plot(abs(H)); title('widmo filtra traktu głosowego');
%     pause(0.1);
    % lpc=[lpc; T; wzm; a; ];								% zapamiętaj wartości parametrów
    
    % SYNTEZA - odtwórz na podstawie parametrów ----------------------------------------------------------------------
    % T = 0;                                        % usuń pierwszy znak '%' i ustaw: T = 80, 50, 30, 0 (w celach testowych)
%     aa(1, 1) = quant(quantiz(a(1), quant));
%     aa(2, 1) = quant(quantiz(a(2), quant));
%     aa(3, 1) = quant6(quantiz(a(3), quant6));
%     aa(4, 1) = quant6(quantiz(a(4), quant6));
%     aa(5, 1) = quant6(quantiz(a(5), quant6));
%     aa(6, 1) = quant6(quantiz(a(6), quant6));
%     aa(7, 1) = quant4(quantiz(a(7), quant4));
%     aa(8, 1) = quant4(quantiz(a(8), quant4));
%     aa(9, 1) = quant4(quantiz(a(9), quant4));
%     aa(10, 1) = quant4(quantiz(a(10), quant4));
    
%     plot(aa-a), pause
    if (T~=0) gdzie=gdzie-Mstep; end					% 'przenieś' pobudzenie dxwięczne
    for n=1:Mstep
        % T = 70; % 0 lub > 25 - w celach testowych
        if( T==0)
            pob=2*(rand(1,1)-0.5); gdzie=(3/2)*Mstep+1;			% pobudzenie szumowe
        else
            if (n==gdzie) pob=1; gdzie=gdzie+T;	   % pobudzenie dźwięczne
            else pob=0; end
        end
        ss(n)=wzm*pob-bs*a;		% filtracja 'syntetycznego' pobudzenia
        
        bs=[ss(n) bs(1:Np-1) ];	% przesunięcie bufora wyjściowego
    end
    % subplot(414); plot(ss); title('zsyntezowany fragment sygnału mowy'); pause
    s = [s ss];						% zapamiętanie zsyntezowanego fragmentu mowy
end

s=filter(1,[1 -0.9735],s); % filtracja (deemfaza) - filtr odwrotny - opcjonalny

plot(s); title('mowa zsyntezowana'); %pause
soundsc(s, fpr)

