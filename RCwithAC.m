
%% Setup, compute, and plot model for varying frequencies
close all;

% constants
R = 1000; %resitance
C = 1*10^-6; %capacitance
h = 2.61*10^-6; % sampling interval

figure('position', [0, 0, 1000, 1000]);

%frequency in hertz (possible range: 10 Hz - 10,000 Hz)
freq = [10 100 1000 10000];

%calculate and plot model for all frequencies in freq
for i = 1:length(freq) 
% define model constants
f = freq(i);
period = 2*1/f;
t = 0:h:(period-h);
steps = fix(period/h);

% define and calculate model functions
Vin = sin(2*pi*f*t);
Vc_out = getVoltage(R, C, h, Vin);
Vr_out = Vin - Vc_out;

% play model
playSound(Vin, (1/h));
playSound(Vc_out, (1/h));
playSound(Vr_out, (1/h));

% plot model
subplot(2, 2, i);
hold on;
plot((0:steps-1)*h, Vin,  'linewidth', 2); 
plot((0:steps-1)*h, Vr_out,  'linewidth', 2); 
plot((0:steps-1)*h, Vc_out,  'linewidth', 2); 

set(gca, 'linewidth', 2);
set(gca, 'fontsize', 14);
xlabel("Time (s)")
ylabel("Voltage (V)");
legend("V_{in}", "VC_{out}", "VR_{out}");
title(['Voltage over time for ' num2str(f) ' Hz input']);
hold off;
end
%% Setup, compute, and plot transfer functions H(f)
freq = 10:10:10000; % vector of 1000 frequency values spanning (10 - 10k) hz

Hc = zeros(1, length(freq));
Hr = zeros(1, length(freq));

% calculate Hc and Hr
for i = 1:length(freq)
    period = 2*1/(freq(i));
    t = 0:h:20*(period-h);
    vin = sin(2*pi*freq(i)*t);
    vc_out = getVoltage(R, C, h, vin);
    vr_out = vin - vc_out;
    
    Hc(i) = max(vc_out)/max(vin);
    Hr(i) = max(vr_out)/max(vin);
end

% plot the transfer functions H(f)
figure();
hold on;

semilogy(freq, Hc, 'linewidth', 2);
semilogy(freq, Hr, 'linewidth', 2);

set(gca, 'linewidth', 2);
set(gca, 'fontsize', 14);
xlabel("Frequency (hz)")
ylabel("H(f)");
legend("H(f)_{c}", "H(f)_{r}");
title ("Transfer function");

hold off;

%% Definition of function getVoltage 
function V = getVoltage(R, C, h, Vin)

steps = length(Vin);
V = zeros(1, steps);
for i = 1:(steps - 1)
    V(i+1) = (1-h/(R*C))*V(i) + (h/(R*C))*Vin(i);
end

end