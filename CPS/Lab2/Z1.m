clear all;
clc;

%-----1-----%
%--Dane--%
N = 20;

s = sqrt(1/N);



% petla do generowania wzorca cosinusowego %
for k = 1:N
    for n = 1:N
        A(k,n) = s * cos(pi*(k-1)/N *((n-1)+0.5));
    end
    s = sqrt(2/N);
end

%w1 = A(1,:);
%w2 = A(2,:);
%w12 = w1 .* w2; % Iloczyn odpowiadających sobie próbek
%prod1 = sum(w12) % ,,0'' oznacza że wektory są ortogonalne

%odkomentować żeby sprawdzić kod
%A(5,6) = 1;

%Sprawdzamy czy wiersze sa ortogonalne%
for o = 1:N
    w1 = A(o,:);
    for p = o+1:N-1
        w2 = A(p,:);
        w12 = w1 .* w2;
        if (abs(sum(w12)))>10^(-14) % ,,0'' oznacza że wektory są ortogonalne
            fprintf('Ta para nie jest ortogonalna: %u , %u \n', o,p);
        end
    end
end

%-----2-----%
%tworzenie IDCT%
S = transpose(A);
I = S*A;

% sprawdz czy SA==I (macierz identycznościowa) %
ident = 1; %zmienna pomocnicza do petli sprawdzajacej identycznosc z odchyleniem %
           % jak zmieni się na 0 to macierz nie jest identycznosciowa w ogóle%
tol = 10^(-14); % tolerancja bledu przy sprawdzaniu identycznosci %

for t = 1:N
    for n = 1:N
       if t == n && (abs(I(t,n)) > 1+tol)
            ident = 0;
       end
       if t ~= n && (abs(I(t,n)) > tol)
            ident = 0;
       end
    end
end

%maxA = abs(A'-inv(A)); macierz błędów

maxA = max(max(abs(A'-inv(A)))); % blad DCT macierz A %


if I(1,1) == 1 && isdiag(I)
    disp('Macierz S*A jest identycznościowa');
elseif ident == 1
    fprintf('Macierz S*A jest identycznościowa z bledem oblicz.: %u\n', maxA);
else
    disp('Macierz S*A nie jest identycznościowa');
end


% Analiza sygnału losowego %
slos = randn(20); % nasz sygnal losowy %
X = A*slos; % w x powinny byc wspolczynniki szeregu fouriera%
rekonstr = S*X; % probujemy zrekonstruowac syg. losowy %

% sprawdzamy czy wrocilismy do sygnału losowego %
bmax = max(max(abs(slos-rekonstr)));
if(bmax<10^(-14))
    fprintf('Zrekonstruowano sygnał z błędem: %u\n', bmax);
    disp('xs !== x');
else
    disp('BLAD REKONSTRUKCJI SYGNALU LOSOWEGO')
end
