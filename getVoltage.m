function V = getVoltage(R, C, h, Vin)

steps = length(Vin(1, :));
V = zeros(1, steps);
for i = 1:(steps - 1)
    V(i+1) = (1-h/(R*C))*V(i) + (h/(R*C))*Vin(i);
end

end