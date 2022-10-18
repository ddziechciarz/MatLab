import num2bitstr.*;
import hex2bitstr.*;

disp('FLOAT: Dokladnosc');
disp('1 + 2^(-24)'); num2bitstr( single( 1 + 2^(-24) )),
disp('1 + 2^(-23)'); num2bitstr( single( 1 + 2^(-23) )),
disp('1 + 2^(-22)'); num2bitstr( single( 1 + 2^(-22) )),
disp('1 + 2^(-21)'); num2bitstr( single( 1 + 2^(-21) )),
disp('1 + 2^(-21) + 2^(-23)');
num2bitstr( single( 1 + 2^(-21) + 2^(-23) )),
disp('1 + 2^(-53) + 2^(-53)');
hex2bitstr( num2hex( 1 + 2^(-53) + 2^(-53) )),
disp(' 2^(-53) + 2^(-53) + 1');
hex2bitstr( num2hex( 2^(-53) + 2^(-53) + 1 )),
disp(' ');