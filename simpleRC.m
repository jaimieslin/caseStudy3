
%%

h = 3*10^-4; %interval of discrete time steps
R = 1000; %resitance
C = 1*10^-6; %capacitance
h_ = 8*10^-4;

length = 5.5*10^-3;
steps = fix(length/h);
steps_ = fix(length/h_);

Vin = ones(1, steps);

Vc = zeros(1, steps);

for i = [1:(steps-1)]
    Vc(i+1) = (1-h/(R*C))*Vc(i) + (h/(R*C))*Vin(i);
end

Vc_ = zeros(1, steps_);

for i =[1:(steps_-1)]
    Vc_(i+1) = (1-h_/(R*C))*Vc_(i) + (h_/(R*C))*Vin(i);
end


figure();
hold on;
%plot the input voltage
plot([0:steps-1]*h, Vin); 
%plot the voltage across the capacitor with time steps of h
plot([0:steps-1]*h, Vc); 
%plot the voltage across the capacitor with time steps of h'
plot([0:steps_-1]*h_, Vc_); 
%plot the voltage across capacitor with the continous function
fplot(@(x) (1-exp(-x/(R*C))),[0 length]); 

set(gca, 'linewidth', 2);
set(gca, 'fontsize', 14);
xlabel("Time (s)")
ylabel("Voltage (V)");
legend("V_{in}", "V_{out}", "V'_{out}", "V_c(t)");
hold off;