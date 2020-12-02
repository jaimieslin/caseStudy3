%%

h = 1*10^-5;
R = 1000;
C = 1*10^-6;

length = 5.5*10^-3;
steps = length/h;

Vc = zeros(1, steps);
Vin = zeros(1, steps);

for i = 1:550;
    Vin(i) = 1;
end

for i = 1:549;
    Vc(i+1) = (1-h/(R*C))*Vc(i) + (h/(R*C))*Vin(i);
end

figure();
hold on;
plot(Vin);
plot(Vc);
xaxislabel("Time (s)")
yaxislabel("Voltage (V)");
hold off;




