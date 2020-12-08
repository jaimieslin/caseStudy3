function [Vout] = circuitD(Vin, h, R1, R4, C2, C3)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%% Set up and constants
%constants
steps = length(Vin);

% initialize varibles
Vc2 = zeros(1, steps);
Vc3 = zeros(1, steps);
i1 = zeros(1, steps);
i2 = zeros(1, steps);
i3 = zeros(1, steps);
V1 = zeros(1, steps);
Vout = zeros(1, steps);

% A matrix
A = [1, -1, -1,  0,  0,   0;
      0,  0, R4,  0,  0,  -1;
    -R1,  0,  0,  1, -1,   0;
      0,  0,  0,  1,  0,   0;
      0,  0,  0,  0,  1,   0;
    -R1,  0,  0,  1,  0, -1];


for i = 1:steps %compute model
  b = [0;
       0;
       0;
       Vin(i);
       Vc2(i);
       Vc3(i)];
  
  x = linsolve(A, b);
  i1(i) = x(1);
  i2(i) = x(2);
  i3(i) = x(3);
  V1(i) = x(5);
  Vout(i) = x(6);
  
  Vc2(i+1) = Vc2(i) + (h/C2)*(i2(i));
  Vc3(i+1) = Vc3(i) + (h/C3)*(i3(i));
end
end

