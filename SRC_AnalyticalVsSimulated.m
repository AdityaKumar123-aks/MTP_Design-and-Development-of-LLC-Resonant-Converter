% Given parameters
Lr = 84.142e-6;     % Resonant inductor (H)
Cr = 481.67e-9;     % Resonant capacitor (F)
R_values = [0.2, 20];   % Load resistance values (Ohms)

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


% Simulated data
fs_sim = [5e3 10e3 20e3 40e3 60e3 80e3 100e3 120e3 140e3 160e3 190e3 200e3 220e3 240e3 260e3 280e3 300e3 320e3 340e3 360e3 380e3 400e3];             % Switch frequencies
gain_cal1 = [0.0019 0.0038 0.0076 0.0158 0.0249  0.0360 0.0504 0.0708 0.1033 0.1658 0.3374 1 0.3685 0.2021 0.1412 0.1097 0.0904 0.0774 0.0679 0.0607 0.0550 0.0504];       % Gain at R = 0.2 ohm
gain_sim1 = [0.0374 0.0538 0.0594 0.1996 0.1193 0.0757 0.0594 0.0767 0.1080 0.1702 0.3432 0.9983 0.3624 0.1989 0.1387 0.1075 0.0885 0.0757 0.0663 0.0592 0.0536 0.0491];

% Vin_sim = 400;                                                                          % Input voltage (assumed constant)
gain_cal2 = [0.1861 0.3327 0.6074 0.8445 0.9283 0.9636 0.9809 0.9918 0.9954 0.9982 0.9999 1 0.9997 0.9988 0.9976 0.9959 0.9940 0.9918 0.9894 0.9868 0.9839 0.9809];    % Gain at R = 20 ohm
gain_sim2 = [0.3327 0.5948 1 1 1 1 1 1 1 1 1 1 0.9954 0.9878 0.9789 0.9697 0.9605 0.9514 0.9426 0.9333 0.9243 0.9157]; 

% Normalized frequency
f_norm_sim = fs_sim / fr;

 % Plot on existing figure   (This is the plot which connects the points by straight lines

 plot(f_norm_sim, gain_sim1, 'ko', 'LineWidth', 1.5, 'DisplayName', 'Simulated Gain (R=0.2Ω Q=13.21)');  
 plot(f_norm_sim, gain_sim2, 'kd', 'LineWidth', 1.5, 'DisplayName', 'Simulated Gain (R=20Ω Q=0.13)');

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
