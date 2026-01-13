clear;
clc;

% Given parameters
Lr = 84.142e-6;     % Resonant inductor (H)
Cr = 481.67e-9;     % Resonant capacitor (F)
R_values = [0.2, 0.5, 1, 2, 5, 10, 20];   % Load resistance values (Ohms)

% Normalized frequency range: f / fr
f_norm = linspace(0.01, 5, 10000);

% Resonant frequency
fr = 1 / (2*pi*sqrt(Lr*Cr));
wr = 2*pi*fr;

% Prepare figure
figure;
hold on; grid on;

% Loop over each resistance value
for k = 1:length(R_values)
    R = R_values(k);
    Re = (R * pi^2) / 8;                  % Effective resistance for PRC
    Qe = Re / (wr * Lr);                  % Quality factor for PRC
    
    % Gain formula for PRC using the given image expression
    gain = (8 / pi^2) ./ sqrt((1 - f_norm.^2).^2 + (f_norm ./ Qe).^2);

    % Plot
    plot(f_norm, gain, 'LineWidth', 1, 'DisplayName', sprintf('R = %d Ω, Q = %.2f', R, Qe));
end

% Customize plot
xlabel('Normalized Frequency (f / f_r)');
ylabel('Voltage Gain (|Vo / Vin|)');
title('PRC: Gain vs Normalized Frequency for Different R');
legend('Location', 'best');
xlim([0.5 1.5]);
ylim([0 1.1]);
