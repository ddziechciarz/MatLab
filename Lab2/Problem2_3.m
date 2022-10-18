clear all; close all;

a=fi( 11.25,0,8,4), a.bin,
b=fi( 4.75,0,8,4), b.bin,
c=fi( 4.75,1,8,4), c.bin,
d=fi(-4.75,1,8,4), d.bin,

x1=fi(pi,0,8,6), x1.bin,
x2=fi(pi,0,16,12), x2.bin,
x3=fi(pi,1,8,6), x3.bin,
x4=fi(pi,1,16,12), x4.bin,

charV = x2.Value;
value=str2double(charV);
stosunek = value/pi,