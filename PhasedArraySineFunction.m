% Sergio Mendez Vargo
% GitHub: @Serge-Vargo
% Phased array antennas

%% @verbatim 
% In this script, we plot the array factor AF(theta) of an N-element
% phased-array antenna using the simplified "sine-expression" result 
% from Geometric Series Expansion under different conditions:
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
%phi = 0;
N = 32;             %number of elements
freq = 10e9;        %10 GHz
c = 3e8;            %m/sec speed of light
lambda = c/freq;    %wavelength (m)
k = 2*pi/lambda;    %wavenumber (rad/m)
d = lambda/2;       %element spacing (m)

close all           %clear all figures
clc                 %clear command window

%% Part 1.1 -- Array Factor AF(theta) for broadside array (Spherical Coordinates)
%Uniform element excitation (amplitude weights = 1)

gamma = k*d*sin(theta_rad); %gamma = pi.*sin(theta);
AF_normal = ((sin(N/2.*gamma))./(N.*sin(gamma./2))).^2; %Broadside AF normalized
AF_nom_dB = 10*log10(AF_normal); %AF in [dB]

figure
plot(theta, AF_nom_dB);
grid on
xlabel('\theta (\circ)')
ylabel('Normalized Gain [dB]')
axis([-80 80 -60 0])
title(' AF(\theta) for N = 32 ')

figure
polarplot(theta_rad, AF_nom_dB);
thetalim([-90 90])
rlim([-80 0])
ax = gca;
ax.ThetaDir = 'clockwise';
ax.ThetaZeroLocation = 'top';
title(' AF(\theta) for N = 32 ');

%% Part 1.2 -- Array Factor AF(u,v) for broadside array (Sine Space Coordinates)
u = sin(theta_rad);     %1D

gamma_sine = k*d*u; %gamma_sine = pi.u;
AF_normal_sine_field = ((sin(N/2.*gamma_sine))./(N.*sin(gamma_sine./2))).^2; %Broadside Array Factor normalized
AF_nom_sine_dB = 20*log10(AF_normal_sine_field); %AF in [dB]

figure
plot(u, AF_nom_sine_dB);
grid on
xlabel('u')
ylabel('Normalized Gain [dB]')
axis([-1 1 -60 0])
title(['Sine Space','AF(u) for N = 32'])

%% Part 2 -- Array Factor AF(theta) Electronically steered
%A_o = 1;            %Standard Element excitation
%weights = ones(1,N);%element excitation weights
%A_n = A_o.*weights; %Element excitation

theta_o = -45;   %steering angle (deg)
theta_o_rad = deg2rad(theta_o); %convert to radians

gamma = k*d*sin(theta_rad);  %gamma = pi.*sin(theta)
delta = k*d*sin(theta_o_rad);
AF_normal_steer = ((sin(N/2.*(gamma - delta)))./(N.*sin((gamma - delta)./2))).^2; %Broadside Array Factor (normalized)
AF_nom_st_dB = 10*log10(AF_normal_steer); %AF in [dB]

figure 
plot(theta, AF_nom_st_dB);
grid on
xlabel('\theta (\circ)')
ylabel('Normalized Gain [dB]')
axis([-80 80 -60 0])
title('Steered AF(\theta) for N = 32')

figure
polarplot(theta_rad, AF_nom_st_dB);
thetalim([-90 90])
rlim([-80 0])
ax = gca;
ax.ThetaDir = 'clockwise';
ax.ThetaZeroLocation = 'top';
title(' Steered AF(\theta) for N = 32 ');


%% Part 3 -- Animation of Beam Steering
theta_steer = -theta_o:1:theta_o; %steering angle array (deg)
theta_steer_rad = deg2rad(theta_steer); %convert to radians

gamma = k*d*sin(theta_rad); %gamma = pi.*sin(theta)

M1 = struct('cdata', cell(1, length(theta_steer)), 'colormap', length(theta_steer)); %movie object 
M2 = struct('cdata', cell(1, length(theta_steer)), 'colormap', length(theta_steer)); %movie object

figure 

for ang_steer = 1:length(theta_steer)
    delta = k*d*sin(theta_steer_rad(ang_steer));
    AF_norm_steer = ((sin(N/2.*(gamma - delta)))./(N.*sin((gamma - delta)./2))).^2; %Broadside Array Factor
    AF_norm_st_dB = 10*log10(AF_norm_steer); %AF in [dB]
    
    plot(theta, AF_norm_st_dB)
    grid on
    xlabel('\theta (\circ)')
    ylabel('Normalized Gain [dB]')
    axis([-80 80 -60 0])
    title({"Steered AF(\theta) for N = 32"; strcat("\theta_0 = ", string(theta_steer(ang_steer)))})
    M1(ang_steer) = getframe(gcf); %Store the frame (leaving gcf out crops the frame in the movie)
    pause(0.02)
    
end
% %Save the Movie
% myWriter = VideoWriter('Steering Beam', 'MPEG-4');
% myWriter.FrameRate = 20;
% 
% %Open the VideoWriter object, write the movie and close the file
% open(myWriter);
% writeVideo(myWriter, M1);
% close(myWriter);

figure 

for ang_steer = 1:length(theta_steer)
    delta = k*d*sin(theta_steer_rad(ang_steer));
    AF_norm_steer = ((sin(N/2.*(gamma - delta)))./(N.*sin((gamma - delta)./2))).^2; %Broadside Array Factor
    AF_norm_st_dB = 10*log10(AF_norm_steer); %AF in [dB]
    
    polarplot(theta_rad, AF_norm_st_dB)
    thetalim([-90 90])
    rlim([-60 0])
    ax = gca;
    ax.ThetaDir = 'clockwise';
    ax.ThetaZeroLocation = 'top';
    title({"Steered AF(\theta) for N = 32"; strcat("\theta_0 = ", string(theta_steer(ang_steer)))})
    
    M2(ang_steer) = getframe(gcf); %Store the frame (leaving gcf out crops the frame in the movie)
    pause(0.02)
    
end
% %Save the Movie
% myWriter = VideoWriter('Steering Beam Polar', 'MPEG-4');
% myWriter.FrameRate = 20;
% 
% %Open the VideoWriter object, write the movie and close the file
% open(myWriter);
% writeVideo(myWriter, M2);
% close(myWriter);

%% Part 4 -- Grating Lobe Moves into Real Space animation
theta_steer_max = 60;       %maximum scan angle (deg)
theta_steer_max_rad = deg2rad(theta_steer_max); %convert to radians

d_max = (lambda - 2*lambda/N) / (1 + sin(theta_steer_max_rad));
message_d_max = strcat("For max scan angle, ", string(theta_steer_max), "(deg), lambda/2 < d_max < lambda");
disp(message_d_max)
disp(strcat("d_max = ", string(d_max)))

d_weights_gr = 0.5:0.01:1;
d_grat_lobes = d_weights_gr * lambda;

M3 = struct('cdata', cell(1, length(theta_steer)), 'colormap', length(theta_steer)); %movie object

figure

for d_ch = 1:length(d_grat_lobes)
    gamma = k*d_grat_lobes(d_ch)*sin(theta_rad);    %gamma = k.d_gr_lb.*sin(theta)
%     delta_phi = k*d_grat_lobes(d)ch)*sin(theta_steer_max_rad);
    delta_phi = k*d_grat_lobes(d_ch)*sin(0);
    AF_norm_grating = ((sin(N/2.*gamma - delta_phi))./(N.*sin((gamma - delta_phi)./2))).^2;  
    AF_norm_grt_dB = 10*log10(AF_norm_grating); %AF in [dB]
    
    plot(theta, AF_norm_grt_dB)
    grid on
    xlabel('\theta (\circ)')
    ylabel('Normalized Gain [dB]')
    axis([-90 90 -60 0])
    title("Grating Lobe Moving into Real Space");
    M3(ang_steer) = getframe(gcf); %Store the frame (leaving gcf out crops the frame in the movie)
    pause(0.05)

end

% %Save the Movie
% myWriter = VideoWriter('Grating Lobes', 'MPEG-4');
% myWriter.FrameRate = 20;
% 
% %Open the VideoWriter object, write the movie and close the file
% open(myWriter);
% writeVideo(myWriter, M3);
% close(myWriter);



