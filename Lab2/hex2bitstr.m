function bits = hex2bitstr( hex )
bits='';
for i=1:length(hex)
    if     hex(i)=='f', bits = strcat( bits, '1111');
    elseif hex(i)=='e', bits = strcat( bits, '1110');
    elseif hex(i)=='d', bits = strcat( bits, '1101');
    elseif hex(i)=='c', bits = strcat( bits, '1100');
    elseif hex(i)=='b', bits = strcat( bits, '1011');
    elseif hex(i)=='a', bits = strcat( bits, '1010');
    elseif hex(i)=='9', bits = strcat( bits, '1001');
    elseif hex(i)=='8', bits = strcat( bits, '1000');
    elseif hex(i)=='7', bits = strcat( bits, '0111');
    elseif hex(i)=='6', bits = strcat( bits, '0110');
    elseif hex(i)=='5', bits = strcat( bits, '0101');
    elseif hex(i)=='4', bits = strcat( bits, '0100');
    elseif hex(i)=='3', bits = strcat( bits, '0011');
    elseif hex(i)=='2', bits = strcat( bits, '0010');
    elseif hex(i)=='1', bits = strcat( bits, '0001');
    elseif hex(i)=='0', bits = strcat( bits, '0000');
    else
    end
end
if( length(bits)==64 )
    wynik = [ bits(1) '_' bits(2 : 2+(11-1)) '_' bits(2+11 : 2+11+(52-1)) ],
elseif( length(bits)==32 )
    wynik = [ bits(1) '_' bits(2 : 2+(8-1)) '_'  bits(2+8 : 2+8+(23-1)) ],
else    
end
    
