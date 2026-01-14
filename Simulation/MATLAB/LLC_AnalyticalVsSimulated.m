clear;
clc;


Lr = 800e-6;     % Resonant inductor (H)
Cr = 90e-9;     % Resonant capacitor (F)
Lm = 3.78e-3;     % Magnetizing inductance (H)           (Here, Lm/Lr = Ln = 4)
wr = 1 / sqrt(Lr * Cr);  % Resonant angular frequency
fr = wr/(2*pi);


% Q values to sweep
R_values = [2 100];

wx = linspace(0.01, 3, 1000);  % Normalized frequency range
colors = lines(length(R_values));  % For distinct plot colors

% Initialize plot
figure; hold on; grid on;

% Loop over Q values
for idx = 1:length(R_values)
    % Q = R_values(idx);
    R = R_values(idx);
    Re = (8 * 25 * R) / (pi^2);
    % Q = (wr*Lr)/Re;
    Q = 1/(Cr * 2 * pi * fr * Re);
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

% Calculated and Simulated data              % Gain at R = 0.2 ohm
fs = [6e3 8e3 10e3 12e3 14e3 16e3 18e3 20e3 22e3 24e3 26e3 28e3 30e3 32e3 34e3 36e3 38e3 40e3]; 
gain_sim1 = [0.0160 0.0248 0.0351 0.0487 0.0625 0.0681 0.0621 0.0545 0.0442 0.0363 0.0307 0.0266 0.0236 0.0213 0.0194 0.0178 0.0165 0.0155];

% Vin_sim = 20;                        % Gain at R = 10 ohm
fs = [6e3 8e3 10e3 12e3 14e3 16e3 18e3 20e3 22e3 24e3 26e3 28e3 30e3 32e3 34e3 36e3 38e3 40e3]; 
gain_sim2 = [0.1210 0.9809 0.2017 0.1144 0.0853 0.0712 0.0631 0.0579 0.0544 0.0519 0.0501 0.0486 0.0474 0.0465 0.0457 0.0451 0.0445 0.0441]; 


% Normalized frequency
f_norm_sim = fs/fr;

 % Plot on existing figure   (This is the plot which connects the points by straight lines

 plot(f_norm_sim, gain_sim1, 'bo', 'LineWidth', 1.5, 'DisplayName', 'Simulated Gain (R=2Ω Q=58.1572)');  
 plot(f_norm_sim, gain_sim2, 'rd', 'LineWidth', 1.5, 'DisplayName', 'Simulated Gain (R=100Ω Q=1.631)');

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
