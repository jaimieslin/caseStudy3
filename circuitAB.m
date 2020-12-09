%% Computes the voltage across a capacitor over time in a simple RC circuit 
% "Simple RC Circuit" meaning one voltage source connected to a capacitor 
% and a resistor in series, as in circuits A and B of the case study

% R = resistance, C = capacitance, h = sampling interval, Vin = vector of
% source voltage over time
function Vout = circuitAB(R, C, h, Vin)

steps = length(Vin(1, :)); % number of time points of interest
Vout = zeros(1, steps); % A vector of the same size as Vin

for i = 1:(steps - 1)
    Vout(i+1) = (1-(h/(R*C)))*Vout(i) + (h/(R*C))*Vin(i); % Expression for Vc at time step i+1 in a simple RC circuit
end

end