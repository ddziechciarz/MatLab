% generates a sine in time domain (seconds) of 
% frequency: freq
% amplitude: amp
% for a period: timeSpan
% with sampling frequency: fs
function [x, t] = generateCosine(freq, amp, timeSpan, fs)
dt = 1/fs;
t = 0:dt:timeSpan;
x = amp * cos(2*pi*freq*t);
end