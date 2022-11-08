% matrix_obiekt3D.m
clear all; close all;

load('X.mat');
size(X)
figure; grid; plot3( X(:,1), X(:,2), X(:,3), 'b.' ); pause

x = X(:,1); y = X(:,2); z = X(:,3);
vmin = min( min(x), min(y) );                        % min
vmax = max( max(x), max(y) );                        % max
[xi,yi] = meshgrid( vmin : (vmax-vmin)/200 : vmax ); % dopasowanie zakresu
zi = griddata( x, y, z, xi, yi, 'linear' );          % interp: nearest, linear, spline, cubic
figure; surf( xi,yi,zi ); pause                      % rysunek

ax = -45/180*pi; ay = -90/180*pi; az = 135/180*pi;
Rx = [ 1, 0, 0; 0, cos(ax), -sin(ax); 0, sin(ax), cos(ax) ]; % macierz rotacji wzg. x
Ry = [ cos(ay), 0, -sin(ay); 0, 1, 0; sin(ay), 0, cos(ay) ]; % macierz rotacji wzg. y
Rz = [ cos(az), -sin(az), 0; sin(az), cos(az), 0; 0, 0, 1 ]; % macierz rotacji wzg. z
XR = Rz * Ry * Rx * X',                                      % 3 rotacje po kolei
figure; grid; plot3( XR(1,:), XR(2,:), XR(3,:), 'b.' );      % wynik obrotu
