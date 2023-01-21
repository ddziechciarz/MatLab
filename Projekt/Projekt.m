% interp_obiekt3D.m
clear all; close all;
%load(’X.mat’);
method = 'natural';
load('krak_zebrane.dat'); X=krak_zebrane;
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
figure; grid; plot3( X(:,1), X(:,2), X(:,3), 'b.' ); title("przed dodaniem");
X = cat(1, X, extraPoints);


figure; grid; plot3( X(:,1), X(:,2), X(:,3), 'b.' ); pause
x = X(:,1); y = X(:,2); z = X(:,3);                                 % pobranie x,y,z
half_x = X(1:2:121,1); half_y = X(1:2:121,2); half_z = X(1:2:121,3);    %Wzięcie połowy punktów góry. babiagora.dat ma 121 wierszy
Missing_X = X(2:2:120,:);                                           %Macierz zawierająca te punkty, które zabraliśmy powyżej.
xvar = min(x) : (max(x)-min(x))/75 : max(x); % zmiennosc x
yvar = min(y) : (max(y)-min(y))/75 : max(y); % zmiennosc y
[Xi,Yi] = meshgrid( xvar, yvar );                                   % siatka interpolacji xi, yi
out = griddata( x, y, z, Xi,Yi, method );                          % interp: nearest, linear, natural, spline (v4), cubic
out = circlify(out, 30, 45, 23)
figure; surf( out, LineStyle=":", LineWidth=0.1 ); pause  % rysunek
half_x_var = min(x) : (max(x)-min(x))/200 : max(x); % Wychodzi na to samo co xvar
half_y_var = min(y) : (max(y)-min(y))/200 : max(y); % Wychodzi na to samo co yvar
[half_Xi,half_Yi] = meshgrid(half_x_var, half_y_var);
%figure; grid; plot3( x, y, z, 'b.' ); pause

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