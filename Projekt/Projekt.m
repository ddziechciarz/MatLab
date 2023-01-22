% interp_obiekt3D.m
clear all; close all;
%load(’X.mat’);
method = 'natural';
load('krak_zebrane.dat'); X=krak_zebrane;
load("pobrane.txt"); A=pobrane;
[val, idx] = max(X(:,3));
extraPoints = zeros(1, 3);

for i = 1:length(X)
    if X(i,3) >= 253
        x1 = (X(i,1) + X(idx,1))/2;
        y1 = (X(i,2) + X(idx,2))/2;
        z1 = (X(i,3) + X(idx,3))/2;
        extraPoints = cat(1,extraPoints, [x1, y1, z1]);
    end
end

extraPoints = extraPoints(2:end, :);
Y = cat(1, X, extraPoints);

figure; grid; plot3( X(:,1), X(:,2), X(:,3), 'b.' ); title("przed dodaniem");
figure; grid; plot3( Y(:,1), Y(:,2), Y(:,3), 'b.' ); title("po dodaniu");
figure; grid; plot3( A(:,1), A(:,2), A(:,3), 'b.' ); title("pobrane dane");

% x = X(:,1); y = X(:,2); z = X(:,3);                                 % pobranie x,y,z                                       %Macierz zawierająca te punkty, które zabraliśmy powyżej.
% xvar = min(x) : (max(x)-min(x))/75 : max(x); % zmiennosc x
% yvar = min(y) : (max(y)-min(y))/75 : max(y); % zmiennosc y
% [Xi,Yi] = meshgrid( xvar, yvar );                                   % siatka interpolacji xi, yi
% out = griddata( x, y, z, Xi,Yi, method );                          % interp: nearest, linear, natural, spline (v4), cubic
% out = circlify(out, 30, 45, 23)
% figure; surf( out, LineStyle=":", LineWidth=0.1 ); title("interolacja bez dodanych punktów") % rysunek

interpolate(X, 75, "przed dodaniem punktów", method, 23);
interpolate(Y, 75, "po dodaniu punktów", method, 23);
interpolate(A, 75, "pobrane dane", method, 200);

% x1 = Y(:,1); y1 = Y(:,2); z1 = Y(:,3);                                 % pobranie x,y,z                                         %Macierz zawierająca te punkty, które zabraliśmy powyżej.
% xvar1 = min(x1) : (max(x1)-min(x1))/75 : max(x1); % zmiennosc x
% yvar1 = min(y1) : (max(y1)-min(y1))/75 : max(y1); % zmiennosc y
% [Xi1,Yi1] = meshgrid( xvar1, yvar1 );                                   % siatka interpolacji xi, yi
% out1 = griddata( x1, y1, z1, Xi1,Yi1, method );                          % interp: nearest, linear, natural, spline (v4), cubic
% out1 = circlify(out1, 30, 45, 23)
% figure; surf( out1, LineStyle=":", LineWidth=0.1 ); title("interpolacja z dodanymi punktami")  % rysunek


function back = interpolate(Z, zmiennosc, tytul, method, radius)
x1 = Z(:,1); y1 = Z(:,2); z1 = Z(:,3);                                 % pobranie x,y,z                                         %Macierz zawierająca te punkty, które zabraliśmy powyżej.
xvar1 = min(x1) : (max(x1)-min(x1))/zmiennosc : max(x1); % zmiennosc x
yvar1 = min(y1) : (max(y1)-min(y1))/zmiennosc : max(y1); % zmiennosc y
[Xi1,Yi1] = meshgrid( xvar1, yvar1 );                                   % siatka interpolacji xi, yi
out1 = griddata( x1, y1, z1, Xi1,Yi1, method );
out1 = circlify(out1, 30, 45, radius)
figure; surf( out1, LineStyle=":", LineWidth=0.1 ); title(tytul)  % rysunek


end

function out = circlify(meshdata, centerX, centerY, radius)
    out = meshdata
    for x = 1:size(meshdata, 1)
        for y = 1:size(meshdata,2)
            if sqrt((centerX - x)^2 + (centerY - y)^2) > radius
                out(x,y) = NaN;
            end
        end
    end
end