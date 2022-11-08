close all; clear all;
P = [
   [0 0];
   [1 1];
   [2 2];
   [3 3];
];
figure; myPlot2D(P); title("Przed");
figure; myPlot2D(P * rotationMatrixDeg2D(180)); title("Po");
%babiaGora = load('babia_gora.dat');
%myPlot(babiaGora); title("Przed");
%figure; myPlot(babiaGora * rotationMatrixDeg(180, 0, 0)); title("Po");

% Functions
function myPlot(P)
   plot3(P(:, 1), P(:, 2), P(:, 3), '.');
end
function myPlot2D(P)
    plot(P(:,1), P(:,2), '.');
end
function [A] = rotationMatrix(yaw, pitch, roll)
   % (yaw, pitch, roll) are rotations about: (z, y, x)
   A = [
       [cos(yaw)*cos(pitch)    cos(yaw)*sin(pitch)*sin(roll)-sin(yaw)*cos(roll)    cos(yaw)*sin(pitch)*cos(roll)+sin(yaw)*sin(roll)    ];
       [sin(yaw)*cos(pitch)    sin(yaw)*sin(pitch)*sin(roll)+cos(yaw)*cos(roll)    sin(yaw)*sin(pitch)*cos(roll)-cos(yaw)*sin(roll)    ];
       [-sin(pitch)            cos(pitch)*sin(pitch)                               cos(pitch)*cos(yaw)                                 ];
   ];
end
function [A] = rotationMatrix2D(a)
   A = [
       [cos(a)  -sin(a) ];
       [sin(a)  cos(a)  ];
   ];
end
function [A] = rotationMatrixDeg2D(a)
    A = rotationMatrix2D(a/360*2*pi);
end
function [A] = rotationMatrixDeg(yaw, pitch, roll)
   A = rotationMatrix(yaw/360*2*pi, pitch/360*2*pi, roll/360*2*pi);
end
