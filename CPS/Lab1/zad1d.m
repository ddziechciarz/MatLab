clear all; close all;
timeSpan = 1;
amp = 1;
fs = 10000;

fc = 50;
wc = 2 * pi * fc;

fm = 1;
wm = 2 * pi * fm;

df = 5;

[c, t] = generateCosine(fc,amp,timeSpan, fs);
[m, t] = generateCosine(fm,amp,timeSpan, fs);

n = amp * cos(wc*t + df*sin(t*wm)/(fm));

figure;
plot(t,c, 'r-', 'LineWidth', 3); hold on;
plot(t,m, 'b-', 'LineWidth', 3); hold on;
plot(t,n, 'k-', 'LineWidth', 3);
axis([0 timeSpan amp*-3 amp*3])

fs25 = 25;
dt25 = 1/fs25;
t25 = 0:dt25:timeSpan;

n25 = amp * cos(wc*t25 + df*sin(t25*wm)/(fm));
%
figure;
%plot(t, n, 'k-'); hold on;
plot(t25, n25, 'b-');

err = [];

%plot(t25, err, 'r-');


figure;
pspectrum(n,fs, 'FrequencyLimits',[0 100]);
figure
pspectrum(n25,fs25);