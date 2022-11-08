% matrix_transform.m
clear all; close all;

% Dane wejsciowe
[x,fpr]=audioread('mowa.wav',[1,2^14]);
N = length(x);
figure; plot(x); title('x(n)');

% Transformacja liniowa/ortogonalna - ANALIZA
n=0:N-1; k=0:N-1;
A = sqrt(2/N)*cos( pi/N *(k'*n));
%x = A(500,:) + A(1000,:); x = x';
y = A*x;
figure; plot(y); title('y(k)');

% Modyfikacja wyniku
y(N/8+1:N,1) = zeros(7*N/8,1);
%y(1000)=0;
figure; plot(y); title('y(k)');

% Transformacja odwrotna - SYNTEZA
xback = A'*y;
figure; plot(xback); title('xback(n)');

soundsc(x,fpr); pause
soundsc(xback,fpr);


