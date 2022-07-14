% This function performs the maximum likelihood association and outlier detection given a single measurement.
% Note that the bearing error lies in the interval [-pi,pi)
%           mu_bar(t)           3X1
%           sigma_bar(t)        3X3
%           z_i(t)              2X1
% Outputs: 
%           c(t)                1X1
%           outlier             1X1
%           nu^i(t)             2XN
%           S^i(t)              2X2XN
%           H^i(t)              2X3XN
function [c, outlier, nu, S, H] = associate(mu_bar, sigma_bar, z_i)

    % Import global variables
    global Q % measurement covariance matrix | 1X1
    global lambda_m % outlier detection threshold on mahalanobis distance | 1X1
    global map % map | 2Xn
    
    % YOUR IMPLEMENTATION %
    n = size(map, 2);
    H = zeros(2, 3, n);
    S = zeros(2, 2, n);
    nu = zeros(2, n);
    psi = zeros(1, n);
    for j = 1: n
        zhat = observation_model(mu_bar, j);
        H(:, :, j) = jacobian_observation_model(mu_bar, j, zhat);
        S(:, :, j) = H(:, :, j) * sigma_bar * H(:, :, j)' + Q;
        nu(:, j) = z_i - zhat;
        psi(j) = det(2 * pi * S(:, :, j))^(-0.5) * exp(-0.5 * nu(:, j)' * inv(S(:, :, j)) * nu(:, j));
    end
    [~, c] = max(psi);
    D_M = nu(:, c)' * inv(S(:, :, c)) * nu(:, c);
    outlier = (D_M >= lambda_m);
end