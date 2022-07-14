% This function performs systematic re-sampling
% Inputs:   
%           S_bar(t):       4XM
% Outputs:
%           S(t):           4XM
function S = systematic_resample(S_bar)
	
    global M % number of particles 
    
    % YOUR IMPLEMENTATION
    S = zeros(4, M);
    CDF = cumsum(S_bar(4, :));
    rng(1);
    r_0 = 1 / M * rand;
    for m = 1:M
        i = find(CDF >= r_0 + (m - 1) / M, 1);
        S(1:3, m) = S_bar(1:3, i);
    end
    S(4, :) = 1 / M * ones(1, M); 

end