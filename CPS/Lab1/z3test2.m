%Lab 1 - Zadanie 3, Korelacja sygnałów
close all; clear all;

load("adsl_x.mat")%Plik ładuje się jako x, wykorzystujemy póżniej tę zmienną
output = [];

for j = 3:32
    a=x(1:j);
    corr_vect = xcorr(a,x);
    B = maxk(corr_vect, 2);
    if abs(B(1) - B(2)) < 1
        output(end+1) = i;

    end

end

for i = 1:2017
    a = x(i: i+31);
    corr_vect = xcorr(a,x(i:end));
    B = maxk(corr_vect, 2);
    if abs(B(1) - B(2)) < 1
        output(end+1) = i;

    end

end

function x = myXcorr(A,B)
    if length(A) < length(B)
        A = cat(2,A, zeros(1, length(B)-length(A)));
    elseif length(B) < length(A)
        B = cat(2,zeros(1, length(A)-length(B)), B);
    end
    N = length(A);
    x = [];
    for n = 0:N-1
        a = A(1 : n+1);
        b = B(end-n : end);
        x(end+1) = sum(a.*conj(b));
    end

    for n = 1:N-1
        a = A(n+1 : end);
        b = B(1 : end-n);
        x(end+1) = sum(a.*conj(b));
    end
    
end