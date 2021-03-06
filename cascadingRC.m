%% Set up and constants
close all;
%constants
C1 = 1*10^-6;
C2 = 1*10^-6;
C3 = 1*10^-6;
R1 = 1000;
R2 = 1000;
R4 = 1000;
h = 2.61*10^-5; % sampling interval

f = 50; % input frequency
period = 1/f; %period of the wave
t = 0:h:(2*period-h);
steps = fix(2*period/h); %number of time steps

Vin = sin(2*pi*f*t); %input voltage

%% Circuit C
Vout_C = circuitC(Vin, h, R2, R4, C1, C3);

% plot model for circuit C
figure();
hold on;
plot(t, Vin,  'linewidth', 2); 
plot(t, Vout_C,  'linewidth', 2); 

set(gca, 'linewidth', 2);
set(gca, 'fontsize', 14);
xlabel("Time (s)")
ylabel("Voltage (V)");
legend("V_{in}", "V_{out}");
title({['Voltage over time for ' num2str(f) ' Hz input']; "Circuit C"});
hold off;

exportgraphics(gca, "circuitC.eps", "Resolution", 300);
%% Circuit D
Vout_D = circuitD(Vin, h, R1, R4, C2, C3);

% plot model for circuit D
figure();
hold on;
plot(t, Vin,  'linewidth', 2); 
plot(t, Vout_D,  'linewidth', 2); 

set(gca, 'linewidth', 2);
set(gca, 'fontsize', 14);
xlabel("Time (s)")
ylabel("Voltage (V)");
legend("V_{in}", "V_{out}");
title({['Voltage over time for ' num2str(f) ' Hz input']; "Circuit D"});
hold off;

exportgraphics(gca, "circuitD.eps", "Resolution", 300);
%% Setup, compute, and plot transfer functions H(f)
freq = 10:10:10000; % vector of 1000 frequency values spanning (10 - 10k) hz
% initialize H_C and H_D
H_C = zeros(1, length(freq)); 
H_D = zeros(1, length(freq));

% calculate H_C and H_D
for i = 1:length(freq)
    period = 1/(freq(i));
    t = 0:h:75*period;
    vin = sin(2*pi*freq(i)*t);
    vout_C = circuitC(vin, h, R2, R4, C1, C3);
    vout_D = circuitD(vin, h, R1, R4, C2, C3);
    
    H_C(i) = max(vout_C)/max(vin);
    H_D(i) = max(vout_D)/max(vin);
end

% plot the transfer functions H(f)
figure();
semilogx(freq, H_C, freq, H_D, 'linewidth', 2);

set(gca, 'linewidth', 2);
set(gca, 'fontsize', 14);
xlabel("Frequency (hz)")
ylabel("H(f)");
legend("Circuit C", "Circuit D");
title ("Transfer functions for circuit C and D");

exportgraphics(gca, "transferFuncCD.eps", "Resolution", 300);