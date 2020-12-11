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

function Vout = RCfilter(Vin, h)
%resistance values
R1 = 10;
R4 = 16;

% capacitance values based on set resistance values and bounds
C2 = 68*10^-6; %(1/(2*pi*fRight*R1));
C3 = 22*10^-6; %(1/(2*pi*fLeft*R4));

Vout = circuitD(Vin, h, R1, R4, C2, C3);
end