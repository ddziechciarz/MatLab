% LICZBY Z PRZYKLADOW Z WYKLADU
% bity_testowanie_vshort.m
  clear all; close all;

% Integer U2 8 bitow: 01000110
  disp('########## U2 8b INTEGER: 70=64+4+2, -70=-128+32+16+8+2');
  dec2bin(  70, 8) %  70 na 8 bitach
  dec2bin( -70, 8) % -70 na 8 bitach
  disp(' '); 

% Fractional U2 8 bitow:  0.546875 =      1/2 + 1/32 + 1/64        = +35/64  
%                        -0.546875 = -1 + 1/4 + 1/8  + 1/16 + 1/64 = -35/64
  disp('########## U2 8b FRACTIONAL: +0.546875, -0.546875');
  fp = fi( 0.546875,1,8,7), fp.bin,
  fm = fi(-0.546875,1,8,7), fm.bin,
  disp(' '); 

% Single precision 32 bity: -0.009765625
  disp('########## Single 32b: -0.009765625');
     num2hex( single( -0.009765625 ) ),
  num2bitstr( single( -0.009765625 ) ),
  disp(' '); 

% Double precision 64 bity: -0.009765625
  disp('########## DOUBLE 64b: -0.009765625');
     num2hex( -0.009765625 ),
  num2bitstr( -0.009765625 ),
  disp(' '); 

% Fractional U2 8 bitow: 1.625 oraz +/- 1.546875
  disp('########## SINGLE: 1.625 = 1+1/2+1/8, +/-(1.546875) = +/-(1+1/2+1/32+1/64)');
  num2bitstr( single(  1 + 1/2 + 1/8  ) ),
  num2bitstr( single( +( 1 + 1/2 + 1/32 + 1/64 ) ) ),
  num2bitstr( single( -( 1 + 1/2 + 1/32 + 1/64 ) ) ),
  disp(' '); 

% Dokladnosc obliczen
  disp('########## SINGLE: Dokladnosc obliczen');
  disp('1 + 2^(-24)'); num2bitstr( single( 1 + 2^(-24) ));
  disp('1 + 2^(-23)'); num2bitstr( single( 1 + 2^(-23) ));
  disp('1 + 2^(-22)'); num2bitstr( single( 1 + 2^(-22) ));
  disp('1 + 2^(-21)'); num2bitstr( single( 1 + 2^(-21) ));
  disp('1 + 2^(-21) + 2^(-23)'); num2bitstr( single( 1 + 2^(-21) + 2^(-23) ));

  disp('1 + 2^(-24) + 2^(-24)'); num2bitstr( single(1)+single(2^(-24)) + single(2^(-24)) );
  disp('2^(-24) + 2^(-24) + 1'); num2bitstr( single(2^(-24)) + single(2^(-24)) + single(1) );
  disp(' '); 

% Blad dla 64 bitow +/-0.5*eps
  disp('########## DOUBLE: Blad obliczen');
  eps_system = eps,
  eps_oblicz = 2^(-52),
  disp('1 + 2^(-53) + 2^(-53)    '); hex2bitstr( num2hex( 1 + 2^(-53) + 2^(-53) ));
  disp('    2^(-53) + 2^(-53) + 1'); hex2bitstr( num2hex( 2^(-53) + 2^(-53) + 1 ));
  disp(' '); 
