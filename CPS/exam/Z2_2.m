close all; clear all;
fs = 250; % sampling frequency
t = 0:1/fs:4;
data = zeros(6,7);

%sinusoid with integer number of periods
f1 = 3;
x1 = sin(2*pi*f1*t);
figure(1)
plot(t,x1);
x1Mean = mean(x1);
x1Var = var(x1);
x1Dev = std(x1);
x1Eng = 1/fs*sum(x1.^2);
x1Pow = sum(x1.^2)/length(x1);
x1Rms = sqrt(sum(x1.^2)/length(x1));
x1Corr = xcorr(x1);

data(1, :) = [x1Mean x1Var x1Dev x1Eng x1Pow x1Rms "-"]

%sinusoid with fractional number of periods
f2 = 1.4;
x2 = sin(2*pi*f2*t);
figure(2)
plot(t,x2);
x2Mean = mean(x2);
x2Var = var(x2);
x2Dev = std(x2);
x2Eng = 1/fs*sum(x2.^2);
x2Pow = sum(x2.^2)/length(x2);
x2Rms = sqrt(sum(x2.^2)/length(x2));
x2Corr = xcorr(x2);

data(2,:) = [x2Mean x2Var x2Dev x2Eng x2Pow x2Rms "-"]

%mixture of sinusoids
f3 = 17.2
x3 = sin(2*pi*f3*t);
xsum = x1 + x2 + x3
figure(3)
plot(t, xsum);
xsumMean = mean(xsum);
xsumVar = var(xsum);
xsumDev = std(xsum);
xsumEng = 1/fs*sum(xsum.^2);
xsumPow = sum(xsum.^2)/length(xsum);
xsumRms = sqrt(sum(xsum.^2)/length(xsum));
xsumCorr = xcorr(x1);

data(3,:) = [xsumMean xsumVar xsumDev xsumEng xsumPow xsumRms "-"]


%speech signal
[xSignal,Fs] = audioread( 'speechSample.wav', 'native' );
xSignal = double(xSignal);
xNoise = xSignal(220500:end,1).';
xSp = xSignal(25000:200000,1).';
xSpMean = mean(xSp);
xSpVar = var(xSp);
xSpDev = std(xSp);
xSpEng = 1/Fs * sum(xSp.^2);
xSpPow = sum(xSp.^2)/length(xSp);
xNPow = sum(xNoise.^2)/length(xNoise);
xSNR = 10*log10(xSpPow/xNPow);
xSpRms = sqrt(sum(xSp.^2)/length(xSp));
xSpCorr = xcorr(xSp);

data(4,:) = [xSpMean xSpVar xSpDev xSpEng xSpPow xSpRms xSNR]


%white Gaussian noise
%length of 1000 samples
xG1 = zeros(1000,1);
xG1 = awgn(xG1, 2);
xG1Mean = mean(xG1);
xG1Var = var(xG1);
xG1Dev = std(xG1);
xG1Eng = 1/1000*sum(xG1.^2);
xG1Pow = sum(xG1.^2)/length(xG1);
xG1Rms = sqrt(sum(xG1.^2)/length(xG1));
xG1Corr = xcorr(xG1);

data(5,:) = [xG1Mean xG1Var xG1Dev xG1Eng xG1Pow xG1Rms "-"]

%length of 750 samples
xG2 = zeros(750,1);
xG2 = awgn(xG2, 2);
xG2Mean = mean(xG2);
xG2Var = var(xG2);
xG2Dev = std(xG2);
xG2Eng = 1/750*sum(xG2.^2);
xG2Pow = sum(xG2.^2)/length(xG2);
xG2Rms = sqrt(sum(xG2.^2)/length(xG2));
xG2Corr = xcorr(xG2);

data(6,:) = [xG2Mean xG2Var xG2Dev xG2Eng xG2Pow xG2Rms "-"]

%creating table to display data
headers = ["Mean","Variance","Deviation","Energy","Power","RMS Value","SNR"]
rowNames = ["Int sin", "Fract sin", "Mixt sin","Speech","Gauss1000","Gauss750"]

figure(4)
uitable('Data', data, 'ColumnName', headers,'RowName',rowNames, 'Position',[20 20 800 400]);






