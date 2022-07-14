% This function performs the ML data association
%           S_bar(t)                 4XM
%           z(t)                     2Xn
%           association_ground_truth 1Xn | ground truth landmark ID for
%           every measurement  1 (actually not used)
% Outputs: 
%           outlier                  1Xn    (1 means outlier, 0 means not outlier) 
%           Psi(t)                   1XnXM
%           c                        1xnxM (actually not ever used)
function [outlier, Psi, c] = associate(S_bar, z, association_ground_truth)
    if nargin < 3
        association_ground_truth = [];
    end

    global lambda_psi % threshold on average likelihood for outlier detection
    global Q % covariance matrix of the measurement model
    global M % number of particles
    global N % number of landmarks
   
    % YOUR IMPLEMENTATION
    n = size(z, 2);
    zmat = zeros(2, M, N);
    zhat = zeros(N, M);
    nu = zeros(2, n, N, M);
    psi = zeros(n, N, M);
    c = zeros(1, n, M);
    Psi = zeros(1, n, M);
    for k = 1:N
        zmat(:, :, k) = observation_model(S_bar, k);
    end
    for i = 1:n
        for m = 1:M
            for k = 1:N
                nu(:, i, k, m) = z(:, i) - zmat(:, m, k);
                psi(i, k, m) = 1 / (2 * pi * sqrt(det(Q))) * exp(-1/2 * nu(:, i, k, m)' * inv(Q) * nu(:, i, k, m));
            end
            [Psi(1, i, m), c(1, i, m)] = max(psi(i, :, m));
        end
    end
    D_M = mean(Psi, 3);
    outlier = (D_M <= lambda_psi);

end
