%% circuitC solves for Vout of circuit C
%  uses linsolve(A, b) to solve for the output voltage in circuit C

function [Vout] = circuitC(Vin, h, R2, R4, C1, C3)

steps = length(Vin);

% initialize variables
Vc1 = zeros(1, steps);
Vc3 = zeros(1, steps);
i1 = zeros(1, steps);
i2 = zeros(1, steps);
i3 = zeros(1, steps);
V1 = zeros(1, steps);
Vout = zeros(1, steps);

% A matrix
A = [1, -1, -1,  0,  0,   0; % i1 - i2 - i3 = 0
     0, R2,  0,  0, -1,   0; % R2i2 - V1 = 0;
     0,  0,  R4, 0,  0,  -1; % R4i3 - Vout = 0
     0,  0,  0,  1,  0,   0; % Vin = Vin,k
     0,  0,  0,  1, -1,   0; % Vin - V1 = Vc1,k
     0,  0,  0,  0,  1, -1]; % V1 - Vout = Vc3,k

% computes model for circuit C
for i = 1:steps
  b = [0;
       0;
       0;
       Vin(i);
       Vc1(i);
       Vc3(i)];
  
% x = [i1; 12; i3; Vin; V1; Vout];
  x = linsolve(A, b);
  
  i1(i) = x(1);
  i2(i) = x(2);
  i3(i) = x(3);
  V1(i) = x(5);
  Vout(i) = x(6);
  
  % Update equations for Vc1 and Vc3 in circuit C
  Vc1(i+1) = Vc1(i) + (h/C1)*(i1(i));
  Vc3(i+1) = Vc3(i) + (h/C3)*(i3(i));
end
end