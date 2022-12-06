% diff_image.m
clear all; close all;
[im1,map] = imread('lena512.bmp'); % wczytaj obraz
figure; imshow(im1,map); title('Wejsciowy obraz');
if(0) % Sobel, krawędzie pionowe
    w = [1 2 1;
        0 0 0;
        -1 -2 -1];
end
if(0) % Sobel, poziomy
    w = [1 0 -1;
        2 0 -2;
        1 0 -1];
end
if(0) % Prewitt, pionowy
    w = [1 1 1;
        0 0 0;
        -1 -1 -1];
end
if(0) % Prewitt, poziomy
    w = [1 0 -1;
        1 0 -1;
        1 0 -1;];
end
if(0) % Roberts (Roberts i Skew to filtry ukośne)
    w = [1 0;
        0 -1];
end
if(0) 
    w = [0 1;
        -1 0];
end
if(0) % Skew
    w = [1 1 1;
        1 -2 -1;
        1 -1 -1];
end
if(0)
    w = [1 1 1;
        -1 -2 1;
        -1 -1 1];
end
if(0) % Podwójne różniczkowanie, nie ma podzialu na kierunki
    w = [ 0, 1, 0; 
        1, -4, 1; 
        0, 1, 0 ]; % uzyta maska/filtr
end
if(0)
    w = [1 -2 1;
        -2 4 -2;
        1 -2 1];
end
if(0)
        w = [ -1, -1, -1; ... %
            -1, 8, -1; ... %
            -1, 1, -1 ]; % uzyta maska/filtr
end
if(0)
    w = [-1 -1 -1 -1 -1;
        -1 -1 -1 -1 -1;
        -1 -1 24 -1 -1;
        -1 -1 -1 -1 -1;
        -1 -1 -1 -1 -1];
end
if(1)
    w = [0 0 1 0 0;
        0 1 2 1 0;
        1 2 -16 2 1;
        0 1 2 1 0;
        0 0 1 0 0];
end
if(0)
    w = [0 1 1 2 2 2 1 1 0;
        1 2 3 5 5 5 4 2 1;
        1 4 5 3 0 3 5 4 1;
        2 5 3 -12 -24 -12 3 5 2;
        2 5 0 -24 -40 -24 0 5 2;
        2 5 3 -12 -24 -12 3 5 2;
        1 4 5 3 0 3 5 4 1;
        1 2 3 5 5 5 4 2 1;
        0 1 1 2 2 2 1 1 0];
end
im2 = conv2( im1, w); % splot, filtracja, suma wazona
figure; imshow(im2,map); title('Przetwarzony obraz');
% Skalowanie jasności obrazu
im3 = imadjust(im1, [], [], 0.35);
figure; imshow(im3,map); title('Przeskalowany obraz');
im4 = conv2( im3, w);
figure; imshow(im4,map); title('Przetwarzony przeskalowany obraz');
