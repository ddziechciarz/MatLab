clear all;
N = 2^13; % ilosc probek (8196, musi byc mniej niz ma nagranie)
[canary, canary_fpr] = audioread('canary.wav', [1, N]);
[elephant, elephant_fpr] = audioread('elephant.wav', [1, N]);
% wykres dzwieku w czasie
figure; plot(canary); title('canary');
figure; plot(elephant); title('elephant');
% nałożone ścieżki dźwiękowe
canele = canary + elephant;
% teraz robie widma czestotliwosciowe
n=0:N-1; k=0:N-1;
A = sqrt(2/N)*cos( pi/N *(k'*n));
canary_freq_spectrum = A * canary;
elephant_freq_spectrum = A * elephant;
figure; plot(canary_freq_spectrum); title('canary freq spec');
figure; plot(elephant_freq_spectrum); title('elephant freq spec');
% widmo czestotliwosciowe laczonej sciezki dzwiekowej
canele_fs = A * canele;
figure; plot(canele_fs); title('canele freq spec');
% odejmuje od laczonego widma, widmo kanarka
back_canary_fs = canele_fs - elephant_freq_spectrum;
% zmieniam widmo spowrotem na sciezke dzwiekową
back_canary    = A^-1 * back_canary_fs;
figure; plot(back_canary); title('back_canary');
