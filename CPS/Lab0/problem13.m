clear all; close all;
load ECG100.mat; whos;
x = val(1,:);
plot(x); title('unscaled graph'); figure; % 289 probek to 1/72 minuty (1 okres) czyli 346,8 probki/s

fpr = 347;
N = length(x);
dt = 1/fpr;
t = dt * (0:N-1);
plot(t, x); title('scaled graph'); figure;
%soundsc(x);

xup = resample(x,8000,fpr);
fprup = 8000;
Nup = length(xup);
dtup = 1/fprup;
tup = dtup * (0:Nup-1);
plot(tup, xup); title('resampled graph');
soundsc(xup, 8000);