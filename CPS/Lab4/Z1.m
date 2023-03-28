% Idea FFT

N = 2^10; % 4, 8, 16, 32, 64, ... 2^P

% Sygnał
x = randn(1,N);

% Jeden podział
X = fft( x );
x1 = x(1:2:end);
x2 = x(2:2:end);
X1 = fft( x1 );
X2 = fft( x2 );
X1rec = [ X1, X1 ] + exp(-j*2*pi/N*(0:N-1)) .* [ X2, X2 ];
error1 = max(abs( X - X1rec )),

% Dwa podziały
x11 = x1(1:2:end);
x12 = x1(2:2:end);
X11 = fft( x11 );
X12 = fft( x12 );
X1r = [ X11, X11 ] + exp(-j*2*pi/(N/2)*(0:N/2-1)) .* [ X12, X12 ];

x21 = x2(1:2:end);
x22 = x2(2:2:end);
X21 = fft( x21 );
X22 = fft( x22 );
X2r = [ X21, X21 ] + exp(-j*2*pi/(N/2)*(0:N/2-1)) .* [ X22, X22 ];

X2rec = [ X1r, X1r ] + exp(-j*2*pi/N*(0:N-1)) .* [ X2r, X2r ];
error2 = max(abs( X - X2rec )),
