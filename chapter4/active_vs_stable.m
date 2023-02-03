% Example plot of two GMMs versus distance
% Jack Baker
% 1/30/2023

clear; close all; clc;
addpath('../utils/') % add path with GMM functions

T=1; %SA period to consider (s)

%% specify rupture scenarios to consider
M = 6.5; % moment magnitude
Rrup = 10:1:600; % vector of source-to-site distances (km)
Vs30 = 500;

% parameters for a vertical strike-slip fault that reaches the surface
Fault_Type = 1; % strike slip fault
Ztor = 0;
delta = 90;
lambda = 0;

% extra CY2014 parameters 
Z10 = 999; % unknown basin depth
Fhw = 0; % not on hanging wall
FVS30 = 0; % Vs30 is inferred
region = 1; % California location

%% function calls
for i=1:length(Rrup) % for each distance value in the vector
    [median_cy(i), sigma_cy(i)] = gmm_cy2014(M, T, Rrup(i), Rrup(i), Rrup(i), Ztor, delta, lambda, Z10, Vs30, Fhw, FVS30, region);
    [median_ab(i), sigma_ab(i)] = gmm_ab2006_stable(T, M, Rrup(i), Vs30);
end

%% plot Figure

figure('Name','Active Figure 1')
loglog(Rrup, median_cy,'Linewidth',1)
hold on
loglog(Rrup, median_ab,'Linewidth',1)
grid on 
% axis([1 250 0.001 1])
legend('CY14 (Western US)', 'AB2006 (Central Eastern US)')
xlabel('R_{rup} [km]')
ylabel('SA(1s) [g]')

saveas(gcf,'figures/Active Figure 1.pdf') % Save Figure


