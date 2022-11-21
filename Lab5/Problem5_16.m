% interp_obiekt3D.m
clear all; close all;
%load(’X.mat’);
load('babia_gora.dat'); X=babia_gora;
figure; grid; plot3( X(:,1), X(:,2), X(:,3), 'b.' ); pause
x = X(:,1); y = X(:,2); z = X(:,3);                                 % pobranie x,y,z
half_x = X(1:2:121,1); half_y = X(1:2:121,2); half_z = X(1:2:121,3);    %Wzięcie połowy punktów góry. babiagora.dat ma 121 wierszy
Missing_X = X(2:2:120,:);                                           %Macierz zawierająca te punkty, które zabraliśmy powyżej.
xvar = min(x) : (max(x)-min(x))/200 : max(x); % zmiennosc x
yvar = min(y) : (max(y)-min(y))/200 : max(y); % zmiennosc y
[Xi,Yi] = meshgrid( xvar, yvar );                                   % siatka interpolacji xi, yi
out = griddata( x, y, z, Xi,Yi, 'v4' );                          % interp: nearest, linear, spline (v4), cubic
figure; surf( out, LineStyle=":", LineWidth=0.1 ); pause  % rysunek   do 3D nearest, linear, natural
half_x_var = min(half_x) : (max(half_x)-min(half_x))/200 : max(half_x); % Wychodzi na to samo co xvar
half_y_var = min(half_y) : (max(half_y)-min(half_y))/200 : max(half_y); % Wychodzi na to samo co yvar
[half_Xi,half_Yi] = meshgrid(half_x_var, half_y_var);
figure; grid; plot3( half_x, half_y, half_z, 'b.' ); pause

%Interpolacja ======================================================
half_out = griddata(half_x, half_y, half_z, half_Xi, half_Yi, 'v4');
figure; surf( half_out, LineStyle=":", LineWidth=0.1 );
%Sumowanie wartości błędów bezwzględnych.=================================
l_err_abs_sum = 0;
[M,N] = size(Missing_X);
rounded_xvar = round(xvar,4); % Zaokrąglam, ponieważ dla funkcji find 5.14999998 != 5.15
rounded_yvar = round(yvar,4);
for i = 1:M
   x_var_index = find(rounded_xvar == Missing_X(i,1));
   y_var_index = find(rounded_yvar == Missing_X(i,2));
   l_err_abs_sum = l_err_abs_sum + abs(half_out(y_var_index,x_var_index)-out(y_var_index,x_var_index));
end
l_err_abs_sum,
%Sumowanie błędó =================================
l_err_sum = 0;
for i = 1:M
   x_var_index = find(rounded_xvar == Missing_X(i,1));
   y_var_index = find(rounded_yvar == Missing_X(i,2));
   l_err_sum = l_err_sum + (half_out(y_var_index,x_var_index)-out(y_var_index,x_var_index));
end
l_err_sum,
