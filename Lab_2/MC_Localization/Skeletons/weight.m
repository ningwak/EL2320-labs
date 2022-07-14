% This function calcultes the weights for each particle based on the
% observation likelihood
%           S_bar(t)            4XM
%           outlier             1Xn
%           Psi(t)              1XnXM
% Outputs: 
%           S_bar(t)            4XM
function S_bar = weight(S_bar, Psi, outlier)

    % YOUR IMPLEMENTATION
    w = prod(Psi(1, outlier < 1, :), 2);
    w_sum = sum(w);
    weights = w / w_sum;
    S_bar(4, :) = weights;
end