clear;
clc;

% Given parameters
Lr = 84.142e-6;     % Resonant inductor (H)
Cr = 481.67e-9;     % Resonant capacitor (F)
R_values = [0.2 10];   % Load resistance values (Ohms)

% Normalized frequency range: f / fr
f_norm = linspace(0.01, 3, 5000);

% Resonant frequency
fr = 1 / (2*pi*sqrt(Lr*Cr));
wr = 2*pi*fr;

% Prepare figure
figure;
hold on; grid on;

% Loop over each resistance value
for k = 1:length(R_values)
    R = R_values(k);
    Re = (pi^2)*R/8;                   % Effective resistance
    Q = Re / (wr*Lr);                  % Quality factor

    % Gain formula for PRC (normalized frequency)
     gain = (8 / pi^2) ./ sqrt((1 - f_norm.^2).^2 + (f_norm ./ Q).^2);

    plot(f_norm, gain, 'linewidth', 1.5, 'DisplayName', sprintf('R = %.3f Ω, Q = %.2f', R, Q));
     
end

% Customize plot
xlabel('Normalized Frequency (f / f_r)');
ylabel('Voltage Gain (|Vo / Vin|)');
title('PRC: Gain vs Normalized Frequency');
legend('Location', 'best');
xlim([0.5 1.5]);
ylim([0 1.1]);


% Simulated data                 % Gain at R = 0.2 ohm
fs = [5e3 10e3 15e3 20e3 25e3 30e3 35e3 40e3 50e3 60e3 80e3 100e3 120e3 140e3 160e3 180e3 200e3 220e3 240e3 260e3 280e3 300e3];        % Switch frequencies
gain_cal1 = [0.0754 0.0378 0.0252 0.0189 0.0151 0.0126 0.0108 0.0095 0.0076 0.0063 0.0047 0.0038 0.0031 0.0027 0.0023 0.0021 0.0019 0.0017 0.0016 0.0014 0.0013 0.0012];
gain_sim1 = [0.1111 0.0532 0.0341 0.0248 0.0194 0.0159 0.0134 0.0116 0.009 0.0074 0.0054 0.0042 0.0034 0.0028 0.0024 0.0021 0.0019 0.0017 0.0015 0.0014 0.0013 0.0012];

% Vin_sim = 20;                   % Gain at R = 10 ohm                                 % Input voltage (assumed constant)
gain_cal2 = [0.8241 0.8596 0.8936 0.8720 0.7566 0.5965 0.4552 0.3497 0.2199 0.1498 0.0822 0.0520 0.0358 0.0262 0.0200 0.0158 0.0127 0.0105 0.0088 0.0075 0.0065 0.0056]; 
gain_sim2 = [0.8768 0.9978 0.7116 0.9976 0.8186 0.5959 0.444 0.3411 0.2171 0.1494 0.0828 0.0525 0.0363 0.0265 0.0203 0.016 0.0129 0.0107 0.009 0.0076 0.0066 0.0057];

% Normalized frequency
f_norm_sim = fs / fr;

 % Plot on existing figure   (This is the plot which connects the points by straight lines

 plot(f_norm_sim, gain_sim1, 'ko', 'LineWidth', 1.5, 'DisplayName', 'Simulated Gain (R=0.2Ω Q=0.0187)');  
 plot(f_norm_sim, gain_sim2, 'kd', 'LineWidth', 1.5, 'DisplayName', 'Simulated Gain (R=10Ω Q=0.93)');

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
