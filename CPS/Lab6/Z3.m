clc;
clear all; close all;


%%
fs = 3.2e6;         % sampling frequency
N  = 32e6;          % number of samples (IQ)
fc = 2.79375e6;           % central frequency of MF station (0, 0.2, 0.4, 0.9)

bwSERV  = 80e3;     % bandwidth of an FM service (bandwidth ~= sampling frequency!)
bwAUDIO = 16e3;     % bandwidth of an FM audio (bandwidth == 1/2 * sampling frequency!)

f = fopen('samples_100MHz_fs3200kHz.raw');
s = fread(f, 2*N, 'uint8');
fclose(f);

s = s-127;


%% IQ --> complex
wideband_signal = s(1:2:end) + sqrt(-1)*s(2:2:end); clear s;


%% Extract carrier of selected service, then shift in frequency the selected service to the baseband
wideband_signal_shifted = wideband_signal .* exp(-sqrt(-1)*2*pi*fc/fs*[0:N-1]');


%% Filter out the service from the wide-band signal
[bm,an] = butter(4, bwSERV/fs, 'low');
wideband_signal_filtered = filter(bm, an, wideband_signal_shifted);


%% Down-sample to service bandwidth - bwSERV = new sampling rate
x = wideband_signal_filtered(1:fs/(bwSERV*2):end);
%x = decimate(wideband_signal_filtered,20);


%% FM demodulation
dx = x(2:end).*conj(x(1:end-1));
y  = atan2(imag(dx), real(dx));


%% Decimate to audio signal bandwidth bwAUDIO
f_norm  = bwAUDIO/bwSERV;     % decimate (1/5) % normalized cut off frequency
[ba,aa] = butter(4,f_norm);   % nth-order lowpass digital Butterworth filter 
ym = filter(ba, aa, y);       % antyaliasing filter
ym = decimate(ym,5);


%% De-emfaza
% (...) de-emfaza (słabe stłumienie wyższych częstotliwości)
f_norm  = 2.1e3/16e3;
[bd,ad] = butter(1,f_norm);
yde = filter(bd,ad,ym);


%% Listen to the final result
yde = yde-mean(yde);
yde = yde./(1.001*max(abs(yde)));
%soundsc(yde, bwAUDIO*2);


%% Plots
psd(spectrum.welch('Hamming',1024), wideband_signal(1:N),'Fs',fs);
figure;
psd(spectrum.welch('Hamming',1024), wideband_signal_shifted(1:N),'Fs',fs);
figure;
psd(spectrum.welch('Hamming',1024), wideband_signal_filtered(1:N),'Fs',fs);
figure;
psd(spectrum.welch('Hamming',1024), x,'Fs',fs/(fs/(bwSERV*2)));
figure;
psd(spectrum.welch('Hamming',1024), y,'Fs',fs/(fs/(bwSERV*2)));
figure;
psd(spectrum.welch('Hamming',1024), yde,'Fs',bwAUDIO);
figure;
plot(yde);

spectrogram(wideband_signal_filtered,4096, 512, [0:20000:3200000], fs);