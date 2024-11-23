% MEMS-Based Heart Sound Simulation
clear all;
close all;
clc;

% Simulation parameters
Fs = 44100;          % Sampling frequency (Hz)
T = 2;               % Duration (seconds)
t = 0:1/Fs:T-1/Fs;  % Time vector

% 1. Generate original heart sound signal
% Parameters for S1 and S2 heart sounds
f1 = 50;            % First heart sound (S1) frequency
f2 = 100;           % Second heart sound (S2) frequency
heart_rate = 75;    % Heart rate in beats per minute
beat_interval = 60/heart_rate;

% Initialize heart sound signal
heart_sound = zeros(size(t));

% Create S1 and S2 sounds with proper timing
for i = 0:floor(T/beat_interval)
    % S1 sound
    t1 = i * beat_interval;
    if t1 < T
        s1 = 0.5 * sin(2*pi*f1*(t-t1)) .* exp(-10*(t-t1)) .* (t >= t1);
        heart_sound = heart_sound + s1;
    end
    
    % S2 sound (occurs after S1)
    t2 = t1 + 0.3;  % S2 occurs 0.3 seconds after S1
    if t2 < T
        s2 = 0.3 * sin(2*pi*f2*(t-t2)) .* exp(-10*(t-t2)) .* (t >= t2);
        heart_sound = heart_sound + s2;
    end
end

% 2. Add noise to simulate MEMS microphone output
noise_level = 0.1;
noisy_signal = heart_sound + noise_level * randn(size(t));

% 3. Amplification stage
gain = 10;
amplified_signal = gain * noisy_signal;

% 4. Filtering stage
% Design a bandpass filter (20-200 Hz for heart sounds)
low_cutoff = 20;
high_cutoff = 200;
[b, a] = butter(4, [low_cutoff high_cutoff]/(Fs/2), 'bandpass');
filtered_signal = filtfilt(b, a, amplified_signal);

% 5. Plotting
figure('Position', [100 100 800 600]);

% Original heart sound
subplot(4,1,1);
plot(t, heart_sound);
title('Original Heart Sound');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-1 1]);

% Noisy signal
subplot(4,1,2);
plot(t, noisy_signal);
title('Noisy Signal (MEMS Microphone Output)');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-2 2]);

% Amplified signal
subplot(4,1,3);
plot(t, amplified_signal);
title('Amplified Signal');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-20 20]);

% Filtered signal
subplot(4,1,4);
plot(t, filtered_signal);
title('Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Adjust overall plot appearance
sgtitle('MEMS-Based Heart Sound Signal Processing');

% 6. Calculate and display SNR
function snr = calculate_snr(signal, noisy_signal)
    noise = noisy_signal - signal;
    signal_power = sum(signal.^2);
    noise_power = sum(noise.^2);
    snr = 10 * log10(signal_power/noise_power);
end

% Calculate SNR for different stages
snr_original = calculate_snr(heart_sound, noisy_signal);
snr_amplified = calculate_snr(gain*heart_sound, amplified_signal);
snr_filtered = calculate_snr(gain*heart_sound, filtered_signal);

fprintf('SNR Results:\n');
fprintf('Original Signal SNR: %.2f dB\n', snr_original);
fprintf('Amplified Signal SNR: %.2f dB\n', snr_amplified);
fprintf('Filtered Signal SNR: %.2f dB\n', snr_filtered)