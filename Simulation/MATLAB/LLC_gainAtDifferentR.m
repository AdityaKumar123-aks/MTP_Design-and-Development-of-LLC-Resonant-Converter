clear;
clc;

% % Parameters
% Lr = 84.142e-6;     % Resonant inductor (H)
% Cr = 481.67e-9;     % Resonant capacitor (F)
% Lm = 420.71e-6;     % Magnetizing inductance (H)           (Here, Lm/Lr = Ln = 5)
% wr = 1 / sqrt(Lr * Cr);  % Resonant angular frequency

Cr = 10e-9;     % Resonant capacitor (F)
Lr = 150e-6;     % Resonant inductor (H)
Lm = 250e-6;     % Magnetizing inductance (H)           (Here, Lm/Lr = Ln = 4)
wr = 1 / sqrt(Lr * Cr);  % Resonant angular frequency


% Q values to sweep
% R_values = [0.1, 0.2, 0.5, 1, 5, 10, 20, 50, 100];
R_values = [100, 500, 1000];
wx = linspace(0.01, 2, 1000);  % Normalized frequency range
colors = lines(length(R_values));  % For distinct plot colors

% Initialize plot
figure; hold on; grid on;

% Loop over Q values
for idx = 1:length(R_values)
    % Q = R_values(idx);
    R = R_values(idx);
    Re = (8 * R) / (pi^2);
    Q = (wr*Lr)/Re;
    gain = zeros(size(wx));

    for i = 1:length(wx)
        term1 = (1 + (Lr / Lm) * (1 - 1 / wx(i)^2))^2;
        term2 = Q^2 * (wx(i) - 1 / wx(i))^2;
        gain(i) = 1 / sqrt(term1 + term2);
    end

    plot(wx, gain, 'LineWidth', 2, 'Color', colors(idx, :), 'DisplayName', ['Q = ' num2str(Q), ' R = ' num2str(R)]);
end

xlabel('\omega_x = f/f_0');
ylabel('Voltage Gain (V_{o}/V_{in})');
title('LLC Converter Gain vs Normalized Frequency for Different Q');
legend('show');
