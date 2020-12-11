%% Setup and compute model
close all;
% constants
R = 1000; %resitance
C = 1*10^-6; %capacitance
endT = 5.5*10^-3;
tao = R*C; 

%interval of discrete time steps
h = tao*0.1; %time steps must be <= tao to produce an acurrate model
h_ = 8*10^-4; 

steps = fix(endT/h);
steps_ = fix(endT/h_);

% calculate perdiction with time steps of h
Vin = ones(1, steps);
Vc = circuitA(Vin, h, R, C);

% calculate perdiction with time steps of h_
Vin = ones(1, steps_);
Vc_ = circuitA(Vin, h_, R, C);

%% Plot model
figure();
hold on;
%plot the input voltage
yline(Vin(1), 'b', 'linewidth', 2); 
%plot the voltage across the capacitor with time steps of h
plot([0:steps-1]*h, Vc, 'linewidth', 2); 
%plot the voltage across the capacitor with time steps of h'
plot([0:steps_-1]*h_, Vc_, 'linewidth', 2); 

%plot theoretical charging curve
syms t;
V_out(t) = (1-exp(-t/(R*C)));
fplot(@(t) V_out(t), [0 endT], 'linewidth', 2); 

%plot tao
xline(tao, 'linewidth', 2); 

set(gca, 'linewidth', 2);
set(gca, 'fontsize', 14);
xlabel("Time (s)")
ylabel("Voltage (V)");
legend("V_{in}", "V_{out}", "V'_{out}", "V_c(t)", "RC time constant",...
    'Location','southeast');
hold off;