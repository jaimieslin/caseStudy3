% function cascadedRCfilter(Vin,h) receives a time-series voltage sequence
% sampled with interval h, and returns the output voltage sequence produced
% by a circuit
%
% inputs:
% Vin - time-series vector representing the voltage input to a circuit
% h - scalar representing the sampling interval of the time series in
% seconds
%
% outputs:
% Vout - time-series vector representing the output voltage of a circuit

function Vout = RCfilter(Vin,h)
C2 = 1.2434*10^-4;
C3 = 1.2434*10^-4;

R1 = 0.4266;
R4 = 16;

Vout = circuitD(Vin, h, R1, R4, C2, C3);
end