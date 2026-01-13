% Frequency range (normalized)
F = linspace(0.1, 2.5, 1000);  % Normalized frequency fs/fo

% Define Q values
Qvalues = [0.01, 0.1, 0.5, 1, 2, 10, 20];

% Plot
figure;
hold on;
for i = 1:length(Qvalues)
    Q = Qvalues(i);
    G = 1 ./ sqrt(1 + Q^2 .* (1./F - F).^2);
    plot(F, G, 'DisplayName', ['Q = ' num2str(Q)]);
end
hold off;
xlabel('Normalized Frequency F = f_s / f_o');
ylabel('Gain G');
title('Gain vs Normalized Frequency for Series Resonant Converter');
legend;
grid on;
