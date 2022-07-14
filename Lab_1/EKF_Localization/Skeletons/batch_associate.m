% This function performs the maximum likelihood association and outlier detection.
% Note that the bearing error lies in the interval [-pi,pi)
%           mu_bar(t)           3X1
%           sigma_bar(t)        3X3
%           z(t)                2Xn
% Outputs: 
%           c(t)                1Xn
%           outlier             1Xn
%           nu_bar(t)           2nX1
%           H_bar(t)            2nX3
function [c, outlier, nu_bar, H_bar] = batch_associate(mu_bar, sigma_bar, z)
        
        % YOUR IMPLEMENTATION %
        n = size(z, 2)
        c = zeros(1, n);
        outlier = zeros(1, n);
        H_bar = zeros(2, 3, n);
        nu_bar = zeros(2, n);
        for i = 1:n
            [c(i), outlier(i), nu, ~, H] = associate(mu_bar, sigma_bar, z(i));
            H_bar(:, :, i) = H(:, :, c(i));
            nu_bar(:, i) = nu(:, c(i));
        end
end