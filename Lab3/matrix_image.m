% matrix_image.m - 2D DCT-II obrazu: analiza - synteza
clear all; close all;

% Wczytaj obraz i go wyswietl
[img,map] = imread('lena512.bmp');
figure; imshow(img,map); title('Przetwarzany obraz');
pause

% Przeksztalc na obraz czarno-bialy jesli obraz jest kolorowy 
if( size(img,3)==1 ) img = double( img )/255;
else                 img = double( rgb2gray(img) )/255;
end
colormap(gray);
figure; imshow(img); title('Obraz B&W'); pause

% Transformacja 2D DCT obrazu
wsp = dct( dct( img ).' ).';   % transformacja 1D DCT wszystkich kolumn, potem wierszy
%wsp = dct2( img );            % to samo w jednej funkcji
figure; imshow( abs(wsp) ); title('Wspolczynniki DCT2'); pause

% Pozostaw wspolczynniki o najwiekszych wartosciach
K = 75; w = zeros( size(wsp) ); w(1:K,1:K) = wsp(1:K,1:K);

% Odwrotna transformacja 2D DCT obrazu
img2 = idct( idct( w ).' ).';  % transformacja 1D IDCT wszystkich kolumn, potem wierszy 
%img2 = idct2( w );            % to samo w jednej funkcji
figure;
subplot(121); imshow(w); title('Wybrane wspolczynniki DCT');
subplot(122); imshow(img2); title('Zsyntezowany obraz'); pause

% Pozostaw tylko najwieksze wspolczynniki
maxim = max(max(wsp));              % najwiekszy wspolczynnik
figure;
% subplot(121); imshow(img); title('Input image'); 
for k = -16 : 0
    k                               % wartosc zmieniana w petli
    threshold = 2^k * maxim,        % obliczony prog
    c = wsp;                        % oryginalne wsp. DCT
    c( abs(c) < threshold ) = 0;    % wyzeruj wsp. mniejsze od progu
    before=numel(c), after=nnz(c),  % liczba wsp.: wszystkich, pozostawionych/niezerowych
    img2 = idct2( c );              % odwrotne DCT 2D: rekonstrukcja obrazu
    subplot(121); imshow( c ); title('Wspolczynniki DCT 2D'); 
    subplot(122); imshow( img2 ); title('Obraz z nich zsyntezowany'); pause
end
