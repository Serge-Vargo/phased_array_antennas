% Sergio Mendez Vargo
% ECE-300 Electromagnetism
% Final Project
% Phased array antennas

%% @verbatim 
% In this script, we plot the array factor AF(theta) of an N-element
% phased-array antenna using the Series expression under different 
% conditions:
%       Part 1.1 - Boresight Direction Beam (Sperical Coordinates)
%       Part 1.2 - Boresight Direction Beam (Sine Space Coordinates)
%       Part 2 - Beam steered 45 deg of boresight
%       Part 3 - Electronically Beam Steering Animation
%       Part 4 - Grating Lobes: d_max calculations and visualization 
% @endverbatim

%% Wrokspace variables
% range of azimuth angle (phi) and elevation (theta)
dtheta = 0.1;   %1 degree (in rad)
theta = -90:dtheta:90;      %range of theta (-90 to 90 degrees)
theta_rad = deg2rad(theta); %theta in rads
dphi = 2*dtheta;
phi = -180:dphi:180;        %range of phi (-180 degrees)
phi_rad = deg2rad(phi);     %phi in rads

N = 32;             %number of elements
freq = 10e9;        %10 GHz
c = 3e8;            %m/sec speed of light
lambda = c/freq;    %wavelength (m)
k = 2*pi/lambda;    %wavenumber (rad/m)
d = lambda/2;       %element spacing (m)

close all           %clear all figures
clc                 %clear command window

%% Part 1 -- Array Factor AF(theta) with Uniform Weighting Functions
A_o = 1;               %Standard element excitation
A_n_uni = A_o.*ones(1,N);  %element excitation weights

gamma = k*d*sin(theta_rad); %phase difference between adjacent elements @ boresight

EF_sum_uni = A_n_uni(1).*exp( 1j*(1).* gamma);   %Element Field Factor @ n = 1

for n = 2:length(A_n_uni)
    el_factor = A_n_uni(n).*exp( 1j*n.* gamma);  %Element Field Factor @ n
    EF_sum_uni = EF_sum_uni + el_factor;         %Total Field Factor @ n
end

AF_uni = abs(EF_sum_uni).^2;          %Array Factor (AF)
AF_uni_nor = AF_uni./max(AF_uni);     %AF normalized 
AF_uni_nor_dB = 10*log10(AF_uni_nor); %AF normalized in [dB] 

figure
plot(theta, AF_uni_nor_dB);
grid on
xlabel('\theta (\circ)')
ylabel('Normalized Gain [dB]')
axis([-80 80 -60 0])
title(' AF(\theta) for N = 32 ')

figure
polarplot(theta_rad, AF_uni_nor_dB);
thetalim([-90 90])
rlim([-80 0])
ax = gca;
ax.ThetaDir = 'clockwise';
ax.ThetaZeroLocation = 'top';
title(' AF(\theta) for N = 32 ');

figure
plot(1:N, A_n_uni, "b-o");
grid on
xlabel(' Element Number')
ylabel('Normalized Amplitude Weight (V/V_{max})')
axis([0 33 0 1.2])
title(' Uniform Weight Distribution ')

%% Part 2 -- AF(theta) w/ Non-uniform weighting functions

% 2.1 Hanning Weights
elem = 1:N;     %individual elements
A_n_hann = 0.5.*(1 - cos(2*pi.*((elem)./(N - 1))));  %Weights

gamma = k*d*sin(theta_rad); %gamma = pi.*sin(theta);

EF_sum_hann = A_n_hann(1).*exp( 1j*(1).* gamma); %Element Field Factor @ n = 1

for n = 2:length(A_n_hann)
    el_factor = A_n_hann(n).*exp( 1j*n.* gamma);  %Element Field Factor @ n
    EF_sum_hann = EF_sum_hann + el_factor;             %Total Field Factor @ n
end

AF_hann = abs(EF_sum_hann).^2;          %Array Factor (AF)
AF_hann_nor = AF_hann./max(AF_hann);    %AF normalized 
AF_hann_nor_dB = 10*log10(AF_hann_nor); %AF normalized in [dB] 

figure
plot(theta, AF_hann_nor_dB, "r");
grid on
xlabel('\theta (\circ)')
ylabel('Normalized Gain [dB]')
axis([-80 80 -60 0])
title(' AF(\theta) for N = 32 ')

figure
polarplot(theta_rad, AF_hann_nor_dB, "r");
thetalim([-90 90])
rlim([-80 0])
ax = gca;
ax.ThetaDir = 'clockwise';
ax.ThetaZeroLocation = 'top';
title(' AF(\theta) for N = 32 ');

figure
plot(1:N, A_n_hann, "r-o");
grid on
xlabel(' Element Number')
ylabel('Normalized Amplitude Weight (V/V_{max})')
axis([0 33 0 1.2])
title(' Hanning Weight Distribution ')

% 2.2 Taylor Weights
elem = 1:N;     %individual elements
A_n_tay = taylorwin(N, 6, -40); %Side Lobe (SL) 

gamma = k*d*sin(theta_rad); %gamma = pi.*sin(theta);

EF_sum_tay = A_n_tay(1).*exp( 1j*(1).* gamma); %Element Field Factor @ n = 1

for n = 2:length(A_n_hann)
    el_factor = A_n_tay(n).*exp( 1j*n.* gamma);  %Element Field Factor @ n
    EF_sum_tay = EF_sum_tay + el_factor;             %Total Field Factor @ n
end

AF_tay = abs(EF_sum_tay).^2;          %Array Factor (AF)
AF_tay_nor = AF_tay./max(AF_tay);     %AF normalized 
AF_tay_nor_dB = 10*log10(AF_tay_nor); %AF normalized in [dB] 

figure
plot(theta, AF_tay_nor_dB, "k");
grid on
xlabel('\theta (\circ)')
ylabel('Normalized Gain [dB]')
axis([-80 80 -60 0])
title(' AF(\theta) for N = 32 ')

figure
polarplot(theta_rad, AF_tay_nor_dB, "k");
thetalim([-90 90])
rlim([-80 0])
ax = gca;
ax.ThetaDir = 'clockwise';
ax.ThetaZeroLocation = 'top';
title(' AF(\theta) for N = 32 ');

figure
plot(1:N, A_n_tay./max(A_n_tay), "k-o");
grid on
xlabel(' Element Number')
ylabel('Normalized Amplitude Weight (V/V_{max})')
axis([0 33 0 1.2])
title(' Taylor Weight Distribution ')

figure
hold on
plot(theta, AF_uni_nor_dB, "b")
plot(theta, AF_hann_nor_dB, "r")
plot(theta, AF_tay_nor_dB, "k");
hold off
grid on
xlabel('\theta (\circ)')
ylabel('Normalized Gain [dB]')
axis([-5 5 -5 0])
legend('Uniform', 'Hanning', 'Taylor')
title(' Beamwidth Comparison ')

figure
hold on
plot(theta, AF_uni_nor_dB, "b")
plot(theta, AF_hann_nor_dB, "r")
plot(theta, AF_tay_nor_dB, "k");
hold off
grid on
xlabel('\theta (\circ)')
ylabel('Normalized Gain [dB]')
axis([-80 80 -60 0])
legend('Uniform', 'Hanning', 'Taylor')
title(' Pattern Comparison ')

figure
hold on
plot(1:N, A_n_uni, "b-o");
plot(1:N, A_n_hann, "r-o");
plot(1:N, A_n_tay./max(A_n_tay), "k-o");
grid on
xlabel(' Element Number')
ylabel('Normalized Amplitude Weight (V/V_{max})')
axis([0 33 0 1.2])
legend('Uniform', 'Hanning', 'Taylor')
title(' Weight Distributions ')




