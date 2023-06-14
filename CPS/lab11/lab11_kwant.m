function y = lab11_kwant(x,b)
      xlewy = x(:,1);   %  rozdzielamy na kanal lewy i prawy
      xprawy = x(:,2);
      xMinLewy = min(xlewy);
      xMaxLewy = max(xlewy);
      xMinPrawy = min(xprawy);
      xMaxPrawy = max(xprawy);
      
      x_zakresLewy=xMaxLewy-xMinLewy; % minimum, maksimum, zakres
      x_zakresPrawy=xMaxPrawy-xMinPrawy;
      
      Nb=b; Nq=2^Nb; % liczba bitów, liczba przedzia³ów kwantowania
      dx=x_zakresLewy/Nq; % szerokoœæ przedzia³u kwantowania
      xqlewy=dx*round(xlewy/dx);
      
      dx=x_zakresPrawy/Nq;
      xqprawy=dx*round(xprawy/dx);
      
      y = horzcat(xqlewy,xqprawy); % funkcja zwraca sygnal stereo
   end