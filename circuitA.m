function [Vout] = circuitA(Vin, h, R, C)
% constants
steps = length(Vin);

% initialize varibles
Vout = zeros(1, steps);

% compute model
for i = [1:(steps-1)]
    Vout(i+1) = (1-h/(R*C))*Vout(i) + (h/(R*C))*Vin(i);
end
end

