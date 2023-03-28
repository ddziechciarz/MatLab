function y = myfft(x)

% x = 0:7;

N = length(x);
Lb = log2(N);
Le = Lb;

% Przestawianie
for n = 0 : N-1
    ncopy = n;
    m = 0;
    for b = 1 : Lb
        if( rem(n,2)==1 )
            m = m + 2^(Lb-b);
            n = n-1;
        end
        n = n/2;
    end
    y(m+1) = x(ncopy+1);
end
y,

% Motylki
for e = 1 : Le
    Lmb = 2^(e-1);
    Lb = N/2^e;
    sm = 2^(e-1);
    odm = 2^e;
    W = exp(-j*2*pi/(2^e));
    for m = 1 : Lmb
        Wm = W^(m-1);
        for b = 1 : Lb
            up   = 1    + (m-1) + (b-1)*odm;
            down = 1+sm + (m-1) + (b-1)*odm;
            temp = y(down) * Wm;
            y(down) = y(up) - temp;
            y(up)   = y(up) + temp;
        end    
    end    
end    