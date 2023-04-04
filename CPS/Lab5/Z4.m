clear all;
close all;

Astop = 40; % tłumienie w paśmie zaporowym
Apass = 3; % zafalowania w paśmie zaporowym

%% ograniczenie filtra z lewej
Fstop1 = (96*10^6)-(120*10^3); 
Fpass1 = (96*10^6)-(100*10^3);

%% ograniczenie filtra z prawej
Fpass2 = (96*10^6)+(100*10^3);
Fstop2 = (96*10^6)+(120*10^3);

%% tworzenie filtra
D = fdesign.bandpass(Fstop1,Fpass1,Fpass2,Fstop2,Astop,Apass,Astop,40e7);
H = design(D,'ellip');

fvtool(H); % Open Filter Visualization Tool