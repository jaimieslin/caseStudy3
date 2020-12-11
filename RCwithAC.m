%% Setup, compute, and plot model for varying frequencies
close all;

% constants
R = 1000; %resitance
C = 1*10^-6; %capacitance
h = 2.61*10^-6; % sampling interval

%frequency in hertz (possible range: 10 Hz - 10,000 Hz)
freq = [50 9000];

%calculate and plot model for all frequencies in freq
for i = 1:length(freq) 
% define model constants
f = freq(i);
period = 1/f;
t = 0:h:(2*period-h);
steps = fix(2*period/h);

% define and calculate model functions
Vin = sin(2*pi*f*t);
Vc_out = circuitA(Vin, h, R, C);
Vr_out = Vin - Vc_out;

% plot model
figure();
hold on;
plot((0:steps-1)*h, Vin,  'linewidth', 2); 
plot((0:steps-1)*h, Vc_out,  'linewidth', 2); 
plot((0:steps-1)*h, Vr_out,  'linewidth', 2); 

set(gca, 'linewidth', 2);
set(gca, 'fontsize', 14);
xlabel("Time (s)")
ylabel("Voltage (V)");
legend("V_{in}", "VC_{out}", "VR_{out}");
title(['Voltage over time for ' num2str(f) ' Hz input']);
hold off;

% play model
% w = waitforbuttonpress;
% playSound(Vin, (1/h));
% w = waitforbuttonpress;
% playSound(Vc_out, (1/h));
% w = waitforbuttonpress;
% playSound(Vr_out, (1/h));
end
%% Setup, compute, and plot transfer functions H(f)
freq = 10:10:10000; % vector of 1000 frequency values spanning (10 - 10k) hz

Hc = zeros(1, length(freq));
Hr = zeros(1, length(freq));

% calculate Hc and Hr
for i = 1:length(freq)
    period = 1/(freq(i));
    t = 0*period:h:25*period;
    vin = sin(2*pi*freq(i)*t);
    vc_out = circuitA(vin, h, R, C);
    vr_out = vin - vc_out;
    
    Hc(i) = max(vc_out)/max(vin);
    Hr(i) = max(vr_out)/max(vin);
end

% plot the transfer functions H(f)
figure();
semilogx(freq, Hc, freq, Hr, 'linewidth', 2);

set(gca, 'linewidth', 2);
set(gca, 'fontsize', 14);
xlabel("Frequency (hz)")
ylabel("H(f)");
legend("H(f)_{c}", "H(f)_{r}");
title ("Transfer function");