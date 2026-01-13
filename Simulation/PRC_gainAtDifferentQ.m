% Normalized frequency range (fs / fo)
F = linspace(0.1, 2, 1000);

% Define Q values
Qvalues = [0.5, 1, 2, 10, 20];

% Constant term
const = 8 / pi^2;

% Plot
figure;
hold on;
for i = 1:length(Qvalues)
    Q = Qvalues(i);
    M = const ./ sqrt((1 - F.^2).^2 + (F./Q).^2);
    plot(F, M, 'DisplayName', ['Q = ' num2str(Q)]);
end
hold off;
xlabel('Normalized Frequency F = f_s / f_o');
ylabel('Gain M');
title('Gain vs Normalized Frequency for Parallel Resonant Converter');
legend;
grid on;
