clear all; close all;
load('adsl_x.mat'); %kolumna z wartościami
M = 32;%M oznacza liczbę próbek, które tworzą tzw. prefiks, czyli sekwencję bitów umieszczoną na początku każdego bloku sygnału. W tym konkretnym przypadku M wynosi 32 próbki, co oznacza, że pierwsze 32 próbki każdego bloku sygnału będą powtórzeniem ostatnich 32 próbek poprzedniego bloku. 
% Prefiks taki jest dodawany w celu ułatwienia wykrycia początku bloku i umożliwienia synchronizacji z sygnałem.
N = 512;%N natomiast oznacza liczbę próbek, które tworzą sam blok sygnału. 
% W tym przypadku każdy blok składa się z 512 próbek. 
% W praktyce wartość N jest zwykle znacznie większa niż M,
% ponieważ im większa liczba próbek w bloku, tym większa możliwość przesyłania informacji.
K=4;%K oznacza liczbę bloków sygnału, czyli w tym przypadku sygnał składa się z 4 bloków, z których każdy zawiera M+N próbek. 
% Cały sygnał składa się z powtórzenia 4 takich bloków.
prefix = repmat(x(end-M+1:end), K, 1); %próbkę prefiksu, która będzie używana do wyznaczania korelacji krzyżowej.
correlation = xcorr(x, prefix); %wyznaczenie korelacji krzyzowej
start_indices = zeros(K, 1);
for i = 1:K
    block_start = (i-1)*(M+N)+1;
    block_end = i*(M+N);
    [~, max_index] = max(correlation(block_start:block_start+M-1));
    start_indices(i) = block_start + max_index - 1, %Wartości start_indices powinny być wektorem o długości cztery,co odpowiada strukturze sygnału ADSL opisanej w zadaniu.
    
end
%Początki pierwszych próbek każdego prefiksu wynoszą 4, ponieważ w zadaniu jest opisany format sygnału ADSL,
% który składa się z powtórzeń ostatnich 32 próbek każdego bloku N=512 próbek. 
% Zgodnie z opisem, sygnał ma strukturę K=4 razy po (M+N)-próbek, 
% co oznacza, że każdy z K bloków składa się z M+N=544 próbek. 
% Początkowe M=32 próbek każdego bloku stanowi prefiks, który jest powtórzeniem ostatnich 32 próbek poprzedniego bloku.
function correlation = mycorrelation(signal1, signal2)
% obliczenie korelacji wzajemnej dwóch sygnałów
% signal1, signal2 - wektory sygnałów

n1 = length(signal1);
n2 = length(signal2);

% zerowanie sygnału
correlation = zeros(1, n1+n2-1);

% obliczenie korelacji
for i = 1:n1
    correlation(i:i+n2-1) = correlation(i:i+n2-1) + signal1(i)*signal2;
end

end