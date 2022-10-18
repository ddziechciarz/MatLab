import f1.*;
import f2.*;

%fileid=fopen("wynik.txt", "w");
%fprintf(fileid, 'to jest pierwsa linijka \n');
%fclose(fileid);
format long;
for i=0:15
value = 10^i;
wyn1 = f1(value);
wyn2 = f2(value);

formatSpec = " f2(x)=%25.1\n";
fprintf(formatSpec,wyn2);
end
