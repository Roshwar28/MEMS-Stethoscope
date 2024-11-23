% Step 1: Define parameters for the input signal (sine wave from microphone)
Fs = 44100;    % Sampling frequency
t = 0:1/Fs:1;  % Time vector (1 second)
f = 100;       % Frequency of the sine wave (e.g., 100 Hz)
A = 0.01;      % Low amplitude signal (from microphone)
input_signal = A * sin(2 * pi * f * t);  % Simulated microphone output

% Step 2: Amplification - Model the Op-Amp gain
gain = 100;  % Set the Op-Amp gain (e.g., 100x amplification)
amplified_signal = gain * input_signal;  % Amplify the signal

% Step 3: Plot the input and amplified signals
figure;
subplot(2,1,1);
plot(t, input_signal);
title('Original Low-Voltage Input Signal (from MEMS Microphone)');
xlabel('Time (s)');
ylabel('Amplitude (V)');
grid on;

subplot(2,1,2);
plot(t, amplified_signal);
title(['Amplified Signal (Gain = ', num2str(gain), ')']);
xlabel('Time (s)');
ylabel('Amplitude (V)');
grid on;