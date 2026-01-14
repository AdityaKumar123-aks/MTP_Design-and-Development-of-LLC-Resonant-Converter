% Parameters
Lr = 84.142e-6;     % Resonant inductor (H)
Cr = 481.67e-9;     % Resonant capacitor (F)
Lm = 250e-6;     % Magnetizing inductance (H)
w0 = 1 / sqrt(Lr * Cr);  % Resonant angular frequency
B = pi^2;  % From your formula

% Q values to sweep
Q_values = [0.1, 0.5, 1, 5, 10, 20];
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

xlabel('\omega_x = f/f_0');
ylabel('Voltage Gain (V_{o1}/V_{in1})');
title('LLC Converter Gain vs Normalized Frequency for Different Q');
legend('show');
