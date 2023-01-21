% interp_obiekt3D.m
clear all; close all;
%load(’X.mat’);
method = 'v4';
load('krak_zebrane.dat'); X=krak_zebrane;
figure; grid; plot3( X(:,1), X(:,2), X(:,3), 'b.' ); pause
x = X(:,1); y = X(:,2); z = X(:,3);                                 % pobranie x,y,z
half_x = X(1:2:121,1); half_y = X(1:2:121,2); half_z = X(1:2:121,3);    %Wzięcie połowy punktów góry. babiagora.dat ma 121 wierszy
Missing_X = X(2:2:120,:);                                           %Macierz zawierająca te punkty, które zabraliśmy powyżej.
xvar = min(x) : (max(x)-min(x))/10 : max(x); % zmiennosc x
yvar = min(y) : (max(y)-min(y))/10 : max(y); % zmiennosc y
[Xi,Yi] = meshgrid( xvar, yvar );                                   % siatka interpolacji xi, yi
out = griddata( x, y, z, Xi,Yi, method );                          % interp: nearest, linear, natural, spline (v4), cubic
figure; surf( out, LineStyle=":", LineWidth=0.1 ); pause  % rysunek
half_x_var = min(half_x) : (max(half_x)-min(half_x))/200 : max(half_x); % Wychodzi na to samo co xvar
half_y_var = min(half_y) : (max(half_y)-min(half_y))/200 : max(half_y); % Wychodzi na to samo co yvar
[half_Xi,half_Yi] = meshgrid(half_x_var, half_y_var);
figure; grid; plot3( half_x, half_y, half_z, 'b.' ); pause