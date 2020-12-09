
%% Setup and compute model
% constants
R = 1000; % resistance
C = 1*10^-6; % capacitance
range = 5.5*10^-3;

% interval of discrete time steps
h = 3*10^-4; 
h_ = 8*10^-4; 

% time points of interest
steps = round(range/h);
steps_ = round(range/h_);

Vin = ones(1, steps);
Vin_ = ones(1, steps_);

% calculate prediction with time steps of h
Vc = getVoltage(R, C, h, Vin);


% calculate prediction with time steps of h_
Vc_ = getVoltage(R, C, h_, Vin_);

%% Plot model
figure();
hold on;
% plot the input voltage
plot((0:steps-1)*h, Vin,  'linewidth', 2); 
% plot the voltage across the capacitor with time steps of h
plot((0:steps-1)*h, Vc, 'linewidth', 2); 
% plot the voltage across the capacitor with time steps of h'
plot((0:steps_-1)*h_, Vc_, 'linewidth', 2); 
% plot the voltage across capacitor with the continous function
fplot(@(t) (1-exp(-t/(R*C))),[0 range]); 

set(gca, 'linewidth', 2);
set(gca, 'fontsize', 14);
xlabel("Time (s)")
ylabel("Voltage (V)");
legend("V_{in}", "V_{out}", "V'_{out}", "V_c(t)");
hold off;