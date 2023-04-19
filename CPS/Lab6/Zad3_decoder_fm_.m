function lab6zad3

A=[697 770 852 941];
B=[1209 1336 1477];
C=['1' '2' '3'; '4' '5' '6'; '7' '8' '9'; '*' '0' '#'];
f=[A B];
skok1=0.12e5;
skok2=0.15e5;
Fs=8000;
N=205;
[data,FS,nbits]=wavread('s2.wav');
figure(1)
plot(data)
%{
figure(2)
w=kaiser(255,7);
spectrogram(data,w,100,255,FS,'yaxis');
f = [697 770 852 941 1209 1336 1477];
freq_indices = round(f/Fs*N) + 1;
dft_data = goertzel(data,freq_indices);
figure(3)
stem(f,abs(dft_data))
ax = gca;
ax.XTick = f;
xlabel('Frequency (Hz)')
title('DFT Magnitude')
%}

%figure(3);
PIN='';
l=1;
i=l;
while(i<length(data))
    if(data(i)>0.05)
        %filtr dla 697
        [d,c] = butter(1,[685 710]/Fs, 'bandpass');
        H1=filter(d,c,data(i:i+skok1));
        %plot(abs(H1))
        %filtr dla 770
        [d,c] = butter(1,[760 780]/Fs, 'bandpass');
        H2=filter(d,c,data(i:i+skok1));
        %plot(H2)
        %filtr dla 852
        [d,c] = butter(1,[840 870]/Fs, 'bandpass');
        H3=filter(d,c,data(i:i+skok1));
        %plot(H3)
        %filtr dla 941
        [d,c] = butter(1,[930 955]/Fs, 'bandpass');
        H4=filter(d,c,data(i:i+skok1));
        %plot(H4)
        %filtr dla 1209
        [d,c] = butter(1,[1200 1210]/Fs, 'bandpass');
        H5=filter(d,c,data(i:i+skok1));
        %plot(H5)
        %filtr dla 1336
        [d,c] = butter(1,[1325 1345]/Fs, 'bandpass');
        H6=filter(d,c,data(i:i+skok1));
        %plot(H6)
        %filtr dla 1477
        [d,c] = butter(1,[1466 1488]/Fs, 'bandpass');
        H7=filter(d,c,data(i:i+skok1));
        %plot(H7)
        x=0;
        y=0;
        if(mean(abs(H1))>0.011) x=1;end
        if(mean(abs(H2))>0.011) x=2;end
        if(mean(abs(H3))>0.011) x=3;end
        if(mean(abs(H4))>0.011) x=4;end
        if(mean(abs(H5))>0.011) y=1;end
        if(mean(abs(H6))>0.011) y=2;end
        if(mean(abs(H7))>0.011) y=3;end
        PIN(l)=C(x,y);
        l=l+1;
        i=i+skok2;
    end
    i=i+1;
end
PIN
end