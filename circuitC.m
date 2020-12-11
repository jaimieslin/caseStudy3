function [Vout] = circuitC(Vin, h, R2, R4, C1, C3)
%% Set up and constants
%constants
steps = length(Vin);

% initialize varibles
Vc1 = zeros(1, steps);
Vc3 = zeros(1, steps);
i1 = zeros(1, steps);
i2 = zeros(1, steps);
i3 = zeros(1, steps);
V1 = zeros(1, steps);
Vout = zeros(1, steps);

% A matrix
A = [1, -1, -1,  0,  0,   0;
     0, R2,  0,  0, -1,   0;
     0,  0,  R4, 0,  0,  -1;
     0,  0,  0,  1,  0,   0;
     0,  0,  0,  1, -1,   0;
     0,  0,  0,  0,  1, -1];

for i = 1:steps %compute model for circuit C
  b = [0;
       0;
       0;
       Vin(i);
       Vc1(i);
       Vc3(i)];
  
  x = linsolve(A, b);
  i1(i) = x(1);
  i2(i) = x(2);
  i3(i) = x(3);
  V1(i) = x(5);
  Vout(i) = x(6);
  
  Vc1(i+1) = Vc1(i) + (h/C1)*(i1(i));
  Vc3(i+1) = Vc3(i) + (h/C3)*(i3(i));
end
end

