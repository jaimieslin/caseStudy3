%% Solve the first circuit

C1 = 1*10^-6;
C2 = 1*10^-6;
C3 = 1*10^-6;
R1 = 1000;
R2 = 1000;
R4 = 1000;
h = 2.61*10^-6; % sampling interval

f = 500;
period = 2*1/f;
t = 0:h:(period-h);
steps = fix(period/h); % number of time points of interest

Vin = sin(2*pi*f*t);
Vc1 = zeros(1, steps);
Vc3 = zeros(1, steps);
i1 = zeros(1, steps);
i2 = zeros(1, steps);
i3 = zeros(1, steps);
V1 = zeros(1, steps);
Vout = zeros(1, steps);

for i = 1:steps

A1 = [1, -1, -1, 0, 0, 0;
      0, R2, 0, 0, -1, 0;
      0, 0, R4, 0, 0, -1;
      0, 0, 0, 1, 0, 0;
      0, 0, 0, 1, -1, 0;
      0, 0, 0, 0, 1, -1];
  
  b = [0;
       0;
       0;
       Vin(i);
       Vc1(i);
       Vc3(i)];
  
  x = linsolve(A1, b);
  x(1) = i1(i);
  x(2) = i2(i);
  x(3) = i3(i);
  x(5) = V1(i);
  x(6) = Vout(i);
  
 Vc1(i+1) = Vc1(i) + (h/C1)*(i1(i));
 Vc3(i+1) = Vc3(i) + (h/C3)*(i3(i));
  
  
end


  

  