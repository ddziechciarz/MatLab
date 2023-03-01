clear all; close all;
P = [
   [0 0];
   [1 1];
   [2 2];
   [3 3];
];

babiaGora = load('babia_gora.dat');
figure; plotPoints(babiaGora); title("Przed"); grid on;
figure; plotPoints(affineTransform(babiaGora, 2, 2, 2, 0, 0, 0, 500, 500, 500)); title("Po"); grid on;

%figure; plotPoints2D(P); title("Przed"); grid on; hold on;
%figure; plotPoints2D(affineTransform2D(P, 1, 1, 90, 1, 1)); title("Po"); grid on;
%figure; plotPoints2D(P*getRotationMatrixDeg2D(90)); title("Po")


function plotPoints(P)
   plot3(P(:, 1), P(:, 2), P(:, 3), '.');
end

function plotPoints2D(P)
    plot(P(:,1), P(:,2), '.');
end

function [A] = affineTransform(DataMatrix, x, y, z, yaw, pitch, roll, a, b, c)
%x,y,z - how much to scale points on each axis, linear transform
% yaw, pitch, roll used for rotation
% a,b,c translation variables
    DataMatrix(length(DataMatrix), 4) = 1;
    for i = 1:1:length(DataMatrix)
        DataMatrix(i, 4) = 1;
    end
    scaleMatrix = [x, 0, 0; 
                   0, y, 0; 
                   0, 0, z];
    traslationMatrix = [1,0,0,0; 
                        0,1,0,0; 
                        0,0,1,0; 
                        a,b,c,1];

    
    rotationMatrix = getRotationMatrixDeg(yaw, pitch, roll);

    matrixAfterTranslation = DataMatrix * traslationMatrix;

    matrixAfterTranslation = matrixAfterTranslation(1:length(DataMatrix),1:3);

    matrixAfterScale = matrixAfterTranslation * scaleMatrix;

    A = matrixAfterScale * rotationMatrix;
end

function [A] = affineTransform2D(DataMatrix, x, y, deg, a, b)
% x, y - scale on each axis
% deg - rotation in degrees
% a, b translation variables
    DataMatrix(length(DataMatrix), 3) = 1;
        for i = 1:1:length(DataMatrix)
            DataMatrix(i, 3) = 1;
        end
    DataMatrix,
  
    scaleMatrix = [x, 0, ; 
                   0, y ]; 

    traslationMatrix = [1,0,0; 
                        0,1,0; 
                        a,b,1],

    rotationMatrix = getRotationMatrixDeg2D(deg);

    matrixAfterTranslation = DataMatrix * traslationMatrix,
    matrixAfterTranslation = matrixAfterTranslation(1:length(DataMatrix),1:2),
    A = matrixAfterTranslation * scaleMatrix * rotationMatrix;
end

function [A] = getRotationMatrix(yaw, pitch, roll)
   % (yaw, pitch, roll) are rotations about: (z, y, x)
   A = [
       [cos(yaw)*cos(pitch)    cos(yaw)*sin(pitch)*sin(roll)-sin(yaw)*cos(roll)    cos(yaw)*sin(pitch)*cos(roll)+sin(yaw)*sin(roll)    ];
       [sin(yaw)*cos(pitch)    sin(yaw)*sin(pitch)*sin(roll)+cos(yaw)*cos(roll)    sin(yaw)*sin(pitch)*cos(roll)-cos(yaw)*sin(roll)    ];
       [-sin(pitch)            cos(pitch)*sin(pitch)                               cos(pitch)*cos(yaw)                                 ];
   ];
end
function [A] = getRotationMatrixDeg(yaw, pitch, roll)
   A = getRotationMatrix(yaw/360*2*pi, pitch/360*2*pi, roll/360*2*pi);
end

function [A] = getRotationMatrix2D(a)
   A = [
       [cos(a)  -sin(a) ];
       [sin(a)  cos(a)  ];
   ];
end
function [A] = getRotationMatrixDeg2D(a)
    A = getRotationMatrix2D(a/360*2*pi);
end


