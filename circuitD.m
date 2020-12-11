%% circuitD solves for Vout of circuit D
%  uses linsolve(A, b) to solve for the output voltage in circuit D

function [Vout] = circuitD(Vin, h, R1, R4, C2, C3)

steps = length(Vin);

% initialize variables
Vc2 = zeros(1, steps);
Vc3 = zeros(1, steps);
i1 = zeros(1, steps);
i2 = zeros(1, steps);
i3 = zeros(1, steps);
V1 = zeros(1, steps);
Vout = zeros(1, steps);

% A matrix
A = [1, -1, -1,  0,  0,   0;  % i1 - i2 - i3 = 0
      0,  0, R4,  0,  0,  -1; % i3R4 - Vout = 0
    -R1,  0,  0,  1, -1,   0; % Vin - v1 - R1i1 = 0
      0,  0,  0,  1,  0,   0; % Vin = Vin,k
      0,  0,  0,  0,  1,   0; % V1 = Vc2,k, the voltage across capacitor 2 in circuit D is "V1"
    -R1,  0,  0,  1,  0, -1]; % Vin - Vout - R1i3 = Vc3,k

% computes model for circuit D
for i = 1:steps 
  b = [0;
       0;
       0;
       Vin(i);
       Vc2(i);
       Vc3(i)];
  
% x = [i1; 12; i3; Vin; V1; Vout];
  x = linsolve(A, b);
  
  i1(i) = x(1);
  i2(i) = x(2);
  i3(i) = x(3);
  V1(i) = x(5);
  Vout(i) = x(6);
  
  % Update equations for Vc2 and Vc3 in circuit D
  Vc2(i+1) = Vc2(i) + (h/C2)*(i2(i));
  Vc3(i+1) = Vc3(i) + (h/C3)*(i3(i));
end
end