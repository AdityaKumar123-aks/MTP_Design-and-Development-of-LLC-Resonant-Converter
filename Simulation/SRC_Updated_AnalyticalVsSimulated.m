% Given parameters
Lr = 84.142e-6;     % Resonant inductor (H)
Cr = 481.67e-9;     % Resonant capacitor (F)
R_values = [10];   % Load resistance values (Ohms)

% Normalized frequency range: f / fr
f_norm = linspace(0.01, 5, 5000);

% Resonant frequency
fr = 1 / (2*pi*sqrt(Lr*Cr));
wr = 2*pi*fr;

figure;
hold on; grid on;

% Loop over each resistance value
for k = 1:length(R_values)
    R = R_values(k);
    Re = (8 * R) / (pi^2);                   % Effective resistance
    Q = (wr*Lr)/Re;                          % Quality factor

    % Gain formula for SRC (normalized frequency)
    gain = 1 ./ sqrt(1 + Q^2 * (f_norm - 1 ./ f_norm).^2);

    plot(f_norm, gain, 'linewidth', 1.5, 'DisplayName', sprintf('R = %d Ω, Q = %.2f', R, Q));
end

% Customize plot
xlabel('Normalized Frequency (f / f_r)');
ylabel('Voltage Gain (|Vo / Vin|)');
title('SRC: Gain vs Normalized Frequency');
legend('Location', 'best');
xlim([0.5 1.5]);
ylim([0 1.1]);


% Calculated and Simulated data              % Gain at R = 0.2 ohm
fs = [2e3 5e3 10e3 15e3 20e3 25e3 30e3 35e3 40e3 50e3 60e3 80e3 100e3 120e3 140e3 160e3 180e3 200e3 220e3 240e3 260e3 280e3 300e3];           % Switch frequencies
gain_cal1 = [0.00098 0.0026 0.0058 0.0115 0.0272 1.0000 0.0334 0.0179 0.0126 0.0082 0.0062 0.0042 0.0033 0.0027 0.0023 0.0020 0.0017 0.0016 0.0014 0.0013 0.0012 0.0011 0.0010];
gain_sim1 = [0.0133 0.1932 0.0125 0.0125 0.0278 0.9986 0.0331 0.0176 0.0123 0.008 0.006 0.0041 0.0032 0.0026 0.0022 0.0019 0.0017 0.0015 0.0014 0.0013 0.0012 0.0011 0.001];

% Vin_sim = 20;                        % Gain at R = 10 ohm                                      % Input voltage (assumed constant)
gain_cal2 = [0.0493 0.1267 0.2803 0.4984 0.8062 1.0000 0.8583 0.6666 0.5324 0.3784 0.2954 0.2078 0.1614 0.1324 0.1124 0.0978 0.0865 0.0776 0.0704 0.0644 0.0594 0.0551 0.0514];
gain_sim2 = [0.1989 0.333 0.3854 0.6069 0.9182 1 0.8099 0.617 0.4939 0.3551 0.2797 0.1987 0.1551 0.1275 0.1084 0.0944 0.0836 0.0751 0.0681 0.0624 0.0575 0.0533 0.0498]; 

% Normalized frequency
f_norm_sim = fs / fr;

 % Plot on existing figure   (This is the plot which connects the points by straight lines

 % plot(f_norm_sim, gain_sim1, 'ko', 'LineWidth', 1.5, 'DisplayName', 'Simulated Gain (R=0.2Ω Q=81.529)');  
 plot(f_norm_sim, gain_sim2, 'kd', 'LineWidth', 1.5, 'DisplayName', 'Simulated Gain (R=10Ω Q=1.631)');

% Interpolate simulated data to smooth the curve
% f_norm_fine = linspace(min(f_norm_sim), max(f_norm_sim), 5000);         % Fine grid
% gain_smooth = interp1(f_norm_sim, gain_sim1, f_norm_fine, 'pchip');     % Smooth interpolation
% gain_smooth2 = interp1(f_norm_sim, gain_sim2, f_norm_fine, 'pchip');    % Smooth interpolation
% 
% % Plot smooth simulated gain
% plot(f_norm_fine, gain_smooth, 'k--', 'LineWidth', 2, 'DisplayName', 'Simulated Gain (R=0.2Ω, Q=13.21)');
% hold on;
% plot(f_norm_fine, gain_smooth2, 'b--', 'LineWidth', 2, 'DisplayName', 'Simulated Gain (R=20Ω, Q=0.13)');
% legend show;
