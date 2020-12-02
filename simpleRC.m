%%

h = 1*10^-5;
R = 1000;
C = 1*10^-6;

length = 5.5*10^-3;
steps = length/h;

Vc = zeros(1, steps);
Vin = ones(1, steps);

for i = 1:549;
    Vc(i+1) = (1-h/(R*C))*Vc(i) + (h/(R*C))*Vin(i);
end



h_ = 8*10^-4;

steps_ = length/h_;

Vc_ = zeros(1, steps);

for i = 1:549
    Vc_(i+1) = (1-h_/(R*C))*Vc_(i) + (h_/(R*C))*Vin(i);
end

x = 0:h:(length-h);




figure();
hold on;
plot(x, Vin);
plot(x, Vc);
plot(x, Vc_);
xlabel("Time (s)")
ylabel("Voltage (V)");
legend("V_{in}", "V_c", "V_{c}adj");
hold off;


