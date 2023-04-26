clear all; close all;
%%
fs = 3.2e6;         % sampling frequency
N  = 32e6;         % number of samples (IQ)
fc = 0.40e6;        % central frequency of MF station

bwSERV = 80e3;     % bandwidth of an FM service (bandwidth ~= sampling frequency!)
bwAUDIO = 16e3;     % bandwidth of an FM audio (bandwidth == 1/2 * sampling frequency!)

f = fopen('samples_100MHz_fs3200kHz.raw');
s = fread(f, 2*N, 'uint8');
fclose(f);

s = s-127;

%% IQ --> complex
wideband_signal = s(1:2:end) + sqrt(-1)*s(2:2:end); clear s;

%% Extract carrier of selected service, then shift in frequency the selected service to the baseband
wideband_signal_shifted = wideband_signal .* exp(-1i*2*pi*fc/fs*[0:N-1]');

%% Filter out the service from the wide-band signal

Astop = 40; % tłumienie w paśmie zaporowym 
Fstop = 80e3 + 2000; % od tego moemntu tłumie
Fpass = 80e3; %przepuszaczna mx czestotliwość
Apass = 3;

LowPassSpec = fdesign.lowpass(Fpass, Fstop, Apass, Astop,3.2e6);
LowPassFilter1 = design(LowPassSpec,'ellip');

[b, a] = tf(LowPassFilter1);
wideband_signal_filtered = filter( b, a, wideband_signal_shifted );

%% Down-sample to service bandwidth - bwSERV = new sampling rate
x = decimate(wideband_signal_filtered,20);
fs = fs/20;
%% FM demodulation
dx = x(2:end).*conj(x(1:end-1));
y = atan2( imag(dx), real(dx) );
%% Display FM signal
figure(1);
psd(spectrum.welch('Hamming',1024), y,'Fs',fs);
title('Gęstośc widmowa mocy całego sygnału FM');

%% Decimate to audio signal bandwidth bwAUDIO
% filtr składowej mono 30Hz - 15kHz
N=128;
b = fir1(N,[30/80e3 15e3/80e3],blackmanharris(N+1));

y_audio =  filtfilt(b,1,y);
figure(2);
psd(spectrum.welch('Hamming',1024), y_audio,'Fs',fs);
title('Odfiltrowanie 30 Hz do 16 kHz');
ym = decimate(y_audio,5); 

%% 1. ODZYSKAJ PILOT
N=128;
b = fir1(N*4,[(18.990e3)/80e3 (19.010e3)/80e3],blackmanharris(N*4+1));

y_pik =  filtfilt(b,1,y);
%19,062 kHz
figure(3);
psd(spectrum.welch('Hamming',1024), y_pik,'Fs',fs);
title('Pilot');

%% 2. ZAPROJEKTUJ FIR BP - Filtr Stereo
fpl = 19062; % częstotliwość piku
b = fir1(N,[(fpl)/80e3 (3*fpl)/80e3],blackmanharris(N+1));
[h,f] = freqz(b,1,0.1:0.5:80e3,80e3);
figure(4);
plot(2*f,20*log(abs(h)),[0 60e3],[-60 -60],'r-')
xlim([0 60e3]);
title('Filtr stereo fpl - 3fpl');

%% Odfiltrowanie stereo z sygnału
y_stereo = filtfilt(b,1,y);
figure(5);
psd(spectrum.welch('Hamming',1024), y_stereo,'Fs',fs);
title('Odfiltrowany sygnał stereo od 23 kHz do 53 kHz');

%% 3. Przesuniecie stereo
N = 1600000;
c = cos(2*pi*(fpl/bwSERV)*[0:N-2]'); % 
y_stereo = y_stereo.*c;
figure(6);
psd(spectrum.welch('Hamming',1024), y_stereo,'Fs',fs);
title('Przesunięcie do 0 Hz cos 2fpl');

%% 4. Filtrowanie do 30kHz
N = 128;
b = fir1(N,[30/80e3 28e3/80e3],blackmanharris(N+1));
[h,f] = freqz(b,1,0.1:0.5:80e3,80e3);

y_stereo_filtered  = filtfilt(b,1,y_stereo);
%y_stereo_filtered = decimate(y_stereo_filtered,5);
y_stereo_filtered = resample(y_stereo_filtered,16,80);

%% widmo odfiltrowanego stereo do 30khz
figure(7)
psd(spectrum.welch('Hamming',1024), y_stereo_filtered,'Fs',fs/5);
title('Resampled Stereo');

%% yl and yr
ym = ym-mean(ym);
ym = ym/(1.001*max(abs(ym)));


y_stereo_filtered = y_stereo_filtered-mean(y_stereo_filtered);
y_stereo_filtered = y_stereo_filtered./(1.001*max(abs(y_stereo_filtered)));
yl = 0.5*(ym+y_stereo_filtered);
yr = 0.5*(ym-y_stereo_filtered);

y_kek = [yl yr];
%% Listen stereo to the final result 
%soundsc( y_kek, bwAUDIO*2);
%% Listen mono to the final result 
%soundsc(ym,bwAUDIO*2)