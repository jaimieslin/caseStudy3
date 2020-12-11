%% Set up and constants
% close all;
%constants
%resistance values
R1 = 10;
R4 = 16;

% left and right frequncy bounds
fLeft = 450;
fRight = 150;

% capacitance values based on set resistance values and frequency bounds
C2 = 68*10^-6; %(1/(2*pi*fRight*R1));
C3 = 22*10^-6; %(1/(2*pi*fLeft*R4));

h = 2.61*10^-5; % sampling interval

%% Compute and plot transfer functions H(f)
freq = 10:10:10000; % vector of 1000 frequency values spanning (10 - 10k) hz
% initialize H
H = zeros(1, length(freq)); 

% calculate H(f)
for i = 1:length(freq)
    period = 1/(freq(i));
    t = 0:h:75*period;
    vin = sin(2*pi*freq(i)*t);
    vout_1 = circuitD(vin, h, R1, R4, C2, C3);
    
    H(i) = max(vout_1)/max(vin);
end

% plot the transfer functions H(f)
figure();
semilogx(freq, H, 'linewidth', 2);

set(gca, 'linewidth', 2);
set(gca, 'fontsize', 14);
xlabel("Frequency (hz)")
ylabel("H(f)");
legend("H(f)");
title ("Transfer function for comeptition circuit");