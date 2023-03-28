function X = myfftrec( x )
% Rekurencyjne FFT

N = length(x);

if( N == 2 )
    X(1) = x(1) + x(2);
    X(2) = x(1) - x(2);
else
    X1 = myfftrec( x(1:2:end) );
    X2 = myfftrec( x(2:2:end) );
    X = [ X1, X1 ] + exp(-j*2*pi/N*(0:N-1)) .* [ X2, X2 ];
end    