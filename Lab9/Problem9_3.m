% equnonlin_solve.m
clear all; close all;

it = 12;
a = pi-pi/5; b=pi+pi/5; % znajdz zero funkcji y=sin(x) dla x=pi
%f = @(x) sin(x); % definicja funkcji
%fp = @(x) cos(x); % definicja pochodnej funkcji
a = 1/2; b = -2; c = -0.1;
f = @(x) a*x.^2+b*x+c; 
fp = @(x) 2*a*x+b; 
%x = 0 : 0.01 : 2*pi;
x = -4 : 0.01 : 4;
plot( x, f(x), 'b-', x, fp(x),'r-'); grid; xlabel('x'); title('f(x), fp(x)');
legend('Funkcja','Jej pochodna'); pause
cb = nonlinsolvers( f, fp, -4, 4, 'bisection', it );
cr = nonlinsolvers( f, fp, -4, 4, 'regula-falsi', it);
cn = nonlinsolvers( f, fp, -4, 4, 'newton-raphson', it);
plot( 1:it,cb,'o-', 1:it,cr,'*', 1:it,cn,'^-'); xlabel('iter'); title('c(iter)')
grid on, legend('Bisection','Regula-Falsi','Newton-Raphson');

function C = nonlinsolvers(f, fp, a, b, solver, iter)
C = zeros(1,iter); % kolejne oszacowania miejsca zerowego
c = a; % pierwsze oszacowanie
for i = 1 : iter
fa = feval(f,a); fb=feval(f,b); fc=feval(f,c); fpc=feval(fp,c); % oblicz
switch(solver)
case 'bisection',
if( fa*fc<0 ) b=c; else a=c; end
c = (a+b)/2;
case 'regula-falsi',
if( fa*fc<0 ) b=c; else a=c; end
c = b-fb*(b-a)/(fb-fa);
case 'newton-raphson',
c = c-fc/fpc;
otherwise,
error('Brak metody');
end
C(i)=c; % zapamietaj
end
end