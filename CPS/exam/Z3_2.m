tries = 50          %specify how many times calculate error of matrix inverse
errors = zeros(tries,1) %array to hold error for each try

for i = 1:tries
    N=randi([2 60],1,1); x = randn(N,1); V = randn(N,N);    %choose random number N, generate vector Nx1 nad matrix NxN
    X = V*x; xe = inv(V)*X;                                 %perform vector transformation and inverse vector transformation
    error = max(abs(x - xe));                               %calculate error 
    errors(i,1) = error;                                    %add error to an array
end
errors,