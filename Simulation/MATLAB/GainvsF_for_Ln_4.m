clc; clear;
Lr = 10e-6;     % Resonant inductor (H)
Cr = 481.67e-9; % Resonant capacitor (F)
Lm = 40e-6;     % Magnetizing inductance (H)
w0 = 1 / sqrt(Lr * Cr);  % Resonant angular frequency
B = pi^2;  % From your formula

% Q values to sweep
Q_values = [0, 0.3, 0.4, 0.42, 0.5, 1, 2, 5, 10, 20];
wx = linspace(0.01, 5, 1000);  % Normalized frequency range (extended to 5 like your image)
colors = lines(length(Q_values));  % For distinct plot colors

% Reference values provided
Mg_max = 1.4615;
Mg_min = 0.8781;
fn_max = 1.4999;
fn_min = 0.5554;

% Initialize plot
figure('Color','w'); hold on; grid on;
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

% Draw dotted (dashed) reference lines
h1 = yline(Mg_max, '--', 'LineWidth', 1.6, 'DisplayName', sprintf('Mg,max = %.4f', Mg_max));
h1.Color = [0.1 0.6 0.9];     % bluish like your image (optional)
h2 = yline(Mg_min, '--', 'LineWidth', 1.6, 'DisplayName', sprintf('Mg,min = %.4f', Mg_min));
h2.Color = [0.9 0.2 0.2];     % reddish (optional)

v1 = xline(fn_min, '--', 'LineWidth', 1.6, 'DisplayName', sprintf('fn,min = %.4f', fn_min));
v1.Color = [0.6 0.2 0.7];     % purple (optional)
v2 = xline(fn_max, '--', 'LineWidth', 1.6, 'DisplayName', sprintf('fn,max = %.4f', fn_max));
v2.Color = [0.1 0.6 0.2];     % green (optional)

% Cosmetic settings to match example figure
xlabel('Normalized frequency, f_n = f/f_0', 'FontWeight','bold');
ylabel('Voltage Gain, M_g', 'FontWeight','bold');
title('Gain vs Normalized Frequency for Different Q at L_n = 4');
xlim([0 5]);
ylim([0 2]);
set(gca,'FontSize',12,'LineWidth',1);

% Show legend (put outside to avoid overlapping)
legend('Location','northeastoutside','FontSize',9);

% Optional: annotate the fn,min arrow like the image (uncomment if desired)
text(fn_min-0.20, 0.15, 'f_{n,min}', 'Color', v1.Color, 'FontWeight','bold');
text(fn_max+0.05, 0.15, 'f_{n,max}', 'Color', v2.Color, 'FontWeight','bold');

text(Mg_max+0.3, 1.52, 'M_{g,max}', 'Color', h1.Color, 'FontWeight','bold');
text(Mg_min+0.92, 0.93, 'M_{g,min}', 'Color', h2.Color, 'FontWeight','bold');

hold off;
