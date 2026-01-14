% Parameters
clc; clear;
Lr = 10e-6;     % Resonant inductor (H)
Cr = 481.67e-9;     % Resonant capacitor (F)
Lm = 10e-6;     % Magnetizing inductance (H)
w0 = 1 / sqrt(Lr * Cr);  % Resonant angular frequency
B = pi^2;  % From your formula
% Q values to sweep
Q_values = [0.1, 0.2, 0.5, 0.8, 1, 2, 5, 10, 20];
wx = linspace(0.01, 2, 10000);  % Normalized frequency range
colors = lines(length(Q_values));  % For distinct plot colors

% Initialize plot
figure; hold on; grid on;

% Loop over Q values
for idx = 1:length(Q_values)
    Q = Q_values(idx);
    gain = zeros(size(wx));
    
    % --- Vectorized calculation (more efficient MATLAB) ---
    % You can replace your inner loop with this for speed:
    term1 = (1 + (Lr / Lm) * (1 - 1 ./ wx.^2)).^2;
    term2 = Q^2 * (wx - 1 ./ wx).^2;
    gain = (B / pi^2) ./ sqrt(term1 + term2);
    % --------------------------------------------------------
    
    plot(wx, gain, 'LineWidth', 2.5, 'Color', colors(idx, :), ...
        'DisplayName', ['Q = ' num2str(Q)]);
end

xlabel('f_n = f/f_0');
ylabel('Voltage Gain M');
title('Gain vs Normalized Frequency for Different Q at L_n = 1');

% --- START OF MODIFICATION ---
% Set the y-axis limits to be [0, 2]
ylim([0 2]);
% Set the y-axis ticks to go from 0 to 2 in steps of 0.2
yticks(0:0.2:2);
% --- END OF MODIFICATION ---

legend('show');