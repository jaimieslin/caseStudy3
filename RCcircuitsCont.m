%% Setup and compute model
% constants
R = 1000; %resitance
C = 1*10^-6; %capacitance
f = 50; %frequency in hertz (10 Hz - 10,000 Hz)
trange = [0 2*1/f];

%% Define functions
syms t;
V_in(t) = sin(2*pi*f*t); %input voltage
i(t) = C*diff(V_in(t)); %function for current
VR_out(t) = i(t)*R; %function for circuit B (resistor)
VC_out(t) = V_in(t) - VR_out(t); %function for circuit A (capacitor)

%% Plot model
close all;
figure();
hold on;
%plot the input voltage
fplot(@(t) V_in(t), trange, 'linewidth', 2); 
%plot the voltage across capacitor in circuit A
fplot(@(t) VC_out(t), trange, 'linewidth', 2); 
%plot the voltage across the resistor in circuit B
fplot(@(t) VR_out(t), trange, 'linewidth', 2); 

set(gca, 'linewidth', 2);
set(gca, 'fontsize', 14);
xlabel("Time (s)")
ylabel("Voltage (V)");
legend("V_{in}", "VC_{out}", "VR_{out}");
hold off;