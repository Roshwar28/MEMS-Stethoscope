# MEMS-Stethoscope
"Design and Implementation of a MEMS-Based Mechanical Stethoscope using MATLAB."

Problem Statement:

Traditional stethoscopes struggle with sensitivity, sound clarity, and
noise filtering, leading to potential misdiagnosis. A more advanced solution is needed to
improve diagnostic accuracy and portability

Objective:
1) Capture sound vibrations produced by the human body and convert them into electrical
signals for further analysis.

2) Improve sound sensitivity and clarity.

3) Use digital signal processing for noise reduction.

Methodology

1)System Design:Design a MEMS based mechanical stethoscope with a diaphragm and
MEMS microphone

2)Signal Acquisition:Simulate microphone output using a low amplitude sine wave in
MATLAB

3)Noise Addition:Add simulated noise to the amplified signal to mimic real-world
conditions

4)Amplification:Model an op-amp to boost the low voltage signals

5)Filtering:Employing filtering techniques to remove high-frequency noise components

6)Final model Development:Integrate diaphragm and MEMS microphone in MATLAB

MEMS Microphone

The MEMS microphone features a diaphragm made of highly-doped polysilicon, 2 μm
thick, with a surface area of approximately 1 mm². It has short supporting beams that
allow rotational movement in response to sound waves. Interdigitated moving
electrodes are positioned on the diaphragm, with fixed electrodes underneath,
separated by a 2 μm air gap.
A levitation-based electrode configuration prevents pull-in failure by generating an
upward electrostatic force. This design enables operation at bias voltages up to 200 V,
enhancing the signal-to-noise ratio and achieving a sensitivity of 16.1 mV/Pa.
The fabrication process uses a 4-inch silicon wafer with Low-Pressure Chemical Vapor
Deposition (LPCVD) for oxide and silicon nitride layers. A polysilicon layer is deposited and
annealed to reduce stress, and air gaps are created using Inductively Coupled Plasma
Reactive Ion Etching (ICP-RIE). Critical point drying is used for device releaseMechanically, the diaphragm vibrates in response to sound, converting motion into
an electrical signal via a charge amplifier, resulting in high sensitivity and a
bandwidth of 100 Hz to 4.9 kHz. This design effectively combines sensitivity, noise
reduction, and reliability for sound detection applications.

Signal Acquisition
In the signal acquisition step of a MEMS-based mechanical stethoscope, the goal is to
simulate the microphone's response to sound waves. Since the MEMS microphone
converts mechanical vibrations (from the diaphragm) into electrical signals, the simulation
uses a low-amplitude sine wave to mimic the sound pressure that the diaphragm would
experience in real-world conditions, such as heartbeats or lung sounds.
The Steps are::
1. Simulate Diaphragm Vibration: The diaphragm vibrates due to sound waves,
which are typically in the range of 20 Hz to 20 kHz (audible range). For this
stethoscope, we are particularly interested in low-frequency sounds like heartbeats
(about 20–200 Hz).
2. Generate a Sine Wave in MATLAB: To replicate the diaphragm's vibration, a sine
wave is generated. The sine wave is a periodic signal that represents sound
pressure over time, with a specific frequency corresponding to the sound being
captured (e.g., heartbeat at 100 Hz).
3. Low-Amplitude Signal: The signal generated must be low in amplitude, as the
microphone will typically capture very small pressure differences. We can adjust the
amplitude to a small value, for example, 0.01, to simulate this.The Parameters are:
Sampling Frequency (Fs = 44100
Hz): Defines how often the signal is
sampled per second, ensuring
accurate sound capture.
Time Vector (t): Ranges from 0 to 1
second, representing the duration of
the sound wave.
Frequency (f = 100 Hz): Simulates a
low-frequency sound, such as a
heartbeat.
Amplitude (A = 0.01): Represents
the low sound pressure typically
captured by a MEMS microphone.
Sine Wave (sound_wave): The
simulated sound wave, generated
using A * sin(2 * pi * f * t)

Noise Addition

Purpose of Noise Addition: In real-world applications, the signals captured by microphones,
including MEMS microphones, are often contaminated with noise from various sources (e.g.,
electrical interference, environmental sounds, etc.). Adding simulated noise to the amplified
signal helps to evaluate how well the system can filter out this noise and enhances the
robustness of the signal processing algorithms.

Steps for Noise Addition
1. Generate Noise:
○ Noise can be generated using MATLAB’s randn() function, which produces
normally distributed random numbers. This simulates Gaussian noise.
○ The noise can be scaled to adjust its amplitude, allowing you to control how
much noise is added relative to the original signal.

2.Combined Noise Signal:The generated noise is added to the amplified signal from the
mems microphone.This simulates how the actual audio signal would appear when mixed
with a background noise in a real world environment1. Original Signal:
○ Let S(t) represent the amplified signal from the MEMS microphone:
S(t)=Amplified Signal

3. Noise Signal:

○ Let N(t) represent the noise added to the signal, which is typically generated
using a Gaussian distribution: N(t)=noise_amplitude×randn(size(S(t)))This
simulates Gaussian noise scaled by the specified noise amplitude.

a)Combined Noisy Signal:
○ The resulting noisy signal Y(t)Y(t)Y(t) can be expressed as: Y(t)=S(t)+N(t)Y(t) =
S(t) + N(t)Y(t)=S(t)+N(t)
○ This equation indicates that the noisy signal is the sum of the amplified signal and
the noise
● S(t): The amplified signal from the MEMS microphone.
● N(t): The noise generated (Gaussian distributed) and scaled by the desired amplitude.
● Y(t): The combined signal, which is the noisy version of the original amplified signal.

Amplification

Signal acquisition captures the weak signal.and Amplification
strengthens the weak signal, ensuring it is at a high enough voltage to be
processed in later stages like noise reduction and filtering.
Weak Signal from MEMS Microphone:
● The MEMS microphone converts sound pressure into a low-voltage electrical signal,
typically in the millivolt range, which is too weak for direct processing.
Operational Amplifier (Op-Amp):
● An Op-Amp is used to amplify these weak signals, often configured as a
non-inverting amplifier. This setup boosts the signal’s amplitude for effective
processing.
Gain Calculation:
● The gain of a non-inverting Op-Amp is calculated as:
Gain=1+Rf/R1
After generating the input signal, the
amplification step boosts it using the gain of
the operational amplifier (Op-Amp).
The formula for amplification is: Amplified
Signal=Gain×Input Signal
Amplified Signal= Gain * input signal
● The boosted signal is easier to process and analyze in
subsequent stages, such as noise filtering and
analysisFiltering and Final Model Development
Filtering:A bandpass filter is applied to the amplified signal to remove unwanted frequencies. The
filter allows frequencies between 20 Hz and 200 Hz (the typical range for heart sounds) to pass
through while blocking others
:A Butterworth low-pass filter is designed using the butter() function, specifying a cutoff
frequency (200 Hz). The filter order (6) controls the steepness of the filter's response.
Butterworth Filter design involves calculating coefficients based on the cutoff frequency
and filter order.
Filter Design Formula (Butterworth Filter)::The normalized cutoff frequency Wc is
calculated as, Wc=2Fc/Fs
Given a desired cutoff frequency Fc, sampling frequency Fs , and filter order NNN, the
normalized cutoff frequency Wc can be calculated as


