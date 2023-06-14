fs = 8000; T = 0.5;
dt = 1/fs; N = round(T/dt); t = dt*(0:N-1);
damp = exp(-t/(T/2));
frequencies = [fkm(3,10) fkm(3,7) fkm(3,7) fkm(3,8) fkm(3,5) fkm(3,5) fkm(3,3) fkm(3,7) fkm(3,10) ...
    fkm(3,10) fkm(3,7) fkm(3,7) fkm(3,8) fkm(3,5) fkm(3,5) fkm(3,3) fkm(3,7) fkm(3,3)];  % częstotliwości sinusoid

gama = [];
for k = 1 : length(frequencies)
    x = damp .* sin(2*pi*frequencies(k)*t);
    gama = [gama x];
end

% Odtworzenie dźwięku
sound(gama, fs);

function fk=fk(k);
    fk = 2^k * 27,5;
end

function fkm=fkm(k,m);
    fkm = fk(k) * 2^(m/12);
end

% A Bb B C C# D D# E F F# G  Ab
% 0 1  2 3 4  5 6  7 8 9  10 11