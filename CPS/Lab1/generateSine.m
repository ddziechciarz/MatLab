% generates a sine in time domain (seconds) of 
% frequency: freq
% amplitude: amp
% for a period: timeSpan
% with sampling frequency: fs
function [x, t] = generateSine(freq, amp, timeSpan, fs)
dt = 1/fs;
t = 0:dt:timeSpan;
x = amp * sin(2*pi*freq*t);
end

