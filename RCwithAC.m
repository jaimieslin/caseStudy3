%% Setup and compute model
% constants
R = 1000; %resitance
C = 1*10^-6; %capacitance
f = 50; %frequency in hertz (10 Hz - 10,000 Hz)
h = 1*10^-5; % sampling interval
range = 0.04;

t = 0:h:(range-h);

steps = round(range/h); % number of time points of interest

Vin = sin(2*pi*f*t);
Vc_out = getVoltage(R, C, h, Vin);
Vr_out = Vin - Vc_out;

playSound(Vc_out, (1/h));

freq = 10:10:10000; % vector of 1000 frequency values spanning (10 - 10k) hz

Hc = zeros(1, 1000);
Hr = zeros(1, 1000);

for i = 1:1000
    vin = sin(2*pi*freq(i)*t);
    vc_out = getVoltage(R, C, h, vin);
    vr_out = vin - vc_out;
    
    Hc(i) = max(vc_out)/max(vin);
    Hr(i) = max(vr_out)/max(vin);
end


%% Plot model
figure();
hold on;

plot((0:steps-1)*h, Vin,  'linewidth', 2); 
plot((0:steps-1)*h, Vr_out,  'linewidth', 2); 
plot((0:steps-1)*h, Vc_out,  'linewidth', 2); 

set(gca, 'linewidth', 2);
set(gca, 'fontsize', 14);
xlabel("Time (s)")
ylabel("Voltage (V)");
legend("V_{in}", "VC_{out}", "VR_{out}");
hold off;

%% Plot the transfer functions H(f)

figure();
hold on;

semilogy(freq, Hc, 'linewidth', 2);
semilogy(freq, Hr, 'linewidth', 2);

set(gca, 'linewidth', 2);
set(gca, 'fontsize', 14);
xlabel("Frequency (hz)")
ylabel("H(f)");
legend("H(f)_{c}", "H(f)_{r}");

hold off;
