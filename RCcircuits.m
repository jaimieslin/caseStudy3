%% Setup and compute model
% constants
R = 1000; %resitance
C = 1*10^-6; %capacitance
f = 10; %frequency in hertz (10 Hz - 10,000 Hz)
xrange = [0 2*1/f];

%% Plot model
figure();
hold on;
%plot the input voltage
fplot(@(t) sin(2*pi*f*t), xrange, 'linewidth', 2); 
% %plot the voltage across capacitor in circuit A
% fplot(@(t) VC_out(t, R, C, f), xrange, 'linewidth', 2); 
% %plot the voltage across the resistor in circuit B
% fplot(@(t) VR_out(t, R, C, f), xrange, 'linewidth', 2); 

set(gca, 'linewidth', 2);
set(gca, 'fontsize', 14);
xlabel("Time (s)")
ylabel("Voltage (V)");
legend("V_{in}", "VC_{out}", "VR_{out}");
hold off;

sym t;
V_in(t) = sin(2*pi*f*t);

sym t;
i(t) = functionalDerivative(V_in(t), t)*C;

sym t
VR_out(t) = i(t)*R;

sym t;
VC_out(t) = V_in(t) - VR_out(t);


% % function for input voltage
% function voltage = V_in(t, f)
%      voltage = sin(2*pi*f*t);
% end

% % function for current
% function current = i(t, C, f)
%     D = functionalDerivative(V_in(t, f), t);
%     current = C*D(t, f);
% end

% % function for circuit A (capacitor)
% function voltage = VC_out(t, R, C, f)
%      voltage = V_in(t, f) - VR_out(t, R, C, f);
% end

% % function for circuit B (resistor)
% function voltage = VR_out(t, R, C, f)
%      voltage = R*i(t, C, f); 
% end