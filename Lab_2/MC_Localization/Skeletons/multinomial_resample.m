% This function performs multinomial re-sampling
% Inputs:   
%           S_bar(t):       4XM
% Outputs:
%           S(t):           4XM
function S = multinomial_resample(S_bar)

    global M % number of particles
    
    % YOUR IMPLEMENTATION
    S = zeros(4, M);
    CDF = cumsum(S_bar(4, :));
    rng(1);
    for m = 1:M
        r_m = rand;
        i = find(CDF >= r_m, 1);
        S(1:3, m) = S_bar(1:3, i);
    end
    S(4, :) = 1 / M * ones(1, M); 
end
