% Parameters
clc; clear;

Cr = 10e-9;     % Resonant capacitor (F)
Lr = 150e-6;     % Resonant inductor (H)
Lm = 250e-6;     % Magnetizing inductance (H)

w0 = 1 / sqrt(Lr * Cr);  % Resonant angular frequency
B = pi^2;  % From your formula

% Q values to sweep
Q_values = [0.1 1 10];
wx = linspace(0.1, 2, 1000);  % Normalized frequency ranget
colors = lines(length(Q_values));  % For distinct plot colors

% Initialize plot
figure; hold on; grid on;

% Loop over Q values
for idx = 1:length(Q_values)
    Q = Q_values(idx);
    gain = zeros(size(wx));

    for i = 1:length(wx)
        term1 = (1 + (Lr / Lm) * (1 - 1 / wx(i)^2))^2;
        term2 = Q^2 * (wx(i) - 1 / wx(i))^2;
        gain(i) = (B / pi^2) / sqrt(term1 + term2);
    end

    plot(wx, gain, 'LineWidth', 2, 'Color', colors(idx, :), ...
        'DisplayName', ['Q = ' num2str(Q)]);
end

xlabel('f_n = f/f_0');
ylabel('Voltage Gain M');
title('Gain vs Normalized Frequency for Different Q');
legend('show');
