%% Setup and compute model
% constants
R = 1000; %resitance
C = 1*10^-6; %capacitance
tEnd = 5.5*10^-3;

%interval of discrete time steps
h = 3*10^-4; 
h_ = 8*10^-4; 

steps = fix(tEnd/h);
steps_ = fix(tEnd/h_);

Vin = ones(1, steps);

% calculate perdiction with time steps of h
Vc = zeros(1, steps);
for i = [1:(steps-1)]
    Vc(i+1) = (1-h/(R*C))*Vc(i) + (h/(R*C))*Vin(i);
end

% calculate perdiction with time steps of h_
Vc_ = zeros(1, steps_);
for i =[1:(steps_-1)]
    Vc_(i+1) = (1-h_/(R*C))*Vc_(i) + (h_/(R*C))*Vin(i);
end

%% Plot model
figure();
hold on;
%plot the input voltage
plot([0:steps-1]*h, Vin,  'linewidth', 2); 
%plot the voltage across the capacitor with time steps of h
plot([0:steps-1]*h, Vc, 'linewidth', 2); 
%plot the voltage across the capacitor with time steps of h'
plot([0:steps_-1]*h_, Vc_, 'linewidth', 2); 
%plot the voltage across capacitor with the continous function

syms t;
V_out(t) = (1-exp(-t/(R*C)));
fplot(@(t) V_out(t), [0 tEnd], 'linewidth', 2); 

set(gca, 'linewidth', 2);
set(gca, 'fontsize', 14);
xlabel("Time (s)")
ylabel("Voltage (V)");
legend("V_{in}", "V_{out}", "V'_{out}", "V_c(t)");
hold off;