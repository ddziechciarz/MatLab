clear all; close all;
echo on

%V=pi*r*r*h
%S=2*pi*r*r + 2*pi*r*h
%h=(S-2*pi*r*r)/(2*pi*r)
%V=(S*r-2*pi*r*r*r)/2
%V`(r)=S/2 - 3*pi*r*r
%V`(r)=0 <=> S/2 - 3*pi*r*r=0
%r=sqrt(S/(6*pi)) v r=-sqrt(S/(6*pi)) <- ujemny promień, nie należy do
%dziedziny

S=210*297, %kartka A4 w mm
r=sqrt(S/(6*pi)),
h=(S-2*pi*r*r)/(2*pi*r),
V=pi*r*r*h,

