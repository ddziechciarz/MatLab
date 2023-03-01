x = [];

%t = 1/44100:1/44100:10; % czas trwania 10 s, częstotliwość próbkowania fs=44100 Hz

for t =0:1/44100:10
    x(end+1) = sin(2*pi*(1000 + 5000*t)*t);

end

audiowrite('sygnal.wav', x, 44100); % zapis sygnału do pliku audio
