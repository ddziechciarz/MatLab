N=100; x = randn(N,1); V = randn(N,N);
X = V*x; xe = inv(V)*X;
error = max(abs(x - xe)),