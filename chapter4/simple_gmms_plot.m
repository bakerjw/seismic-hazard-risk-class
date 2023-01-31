% Example plot of two GMMs versus distance
% Jack Baker
% 1/30/2023

addpath('../utils/') % add path with GMM functions

T=1; %SA period to consider (s)

%% specify rupture scenarios to consider
M = 6.5; % moment magnitude
Rrup = 1:1:250; % vector of source-to-site distances (km)
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
    [median_bjf(i), sigma_bjf(i)] = gmm_bjf97(M, Rrup(i), T, Fault_Type, Vs30);
    [median_cy(i), sigma_cy(i)] = gmm_cy2014(M, T, Rrup(i), Rrup(i), Rrup(i), Ztor, delta, lambda, Z10, Vs30, Fhw, FVS30, region);

end

%% plot Figure

figure('Name','Active Figure 1')
loglog(Rrup, median_bjf,'Linewidth',1)
hold on
loglog(Rrup, median_cy,'Linewidth',1)
grid on 
axis([1 250 0.001 1])
legend('BJF97', 'CY14')
xlabel('R_{rup} [km]')
ylabel('SA(1s) [g]')

saveas(gcf,'figures/Active Figure 1.pdf') % Save Figure


