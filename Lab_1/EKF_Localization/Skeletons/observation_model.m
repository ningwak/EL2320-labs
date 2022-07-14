% This function is the implementation of the measurement model.
% The bearing should be in the interval [-pi,pi)
% Inputs:
%           x(t)                           3X1
%           j                              1X1
% Outputs:  
%           h                              2X1
function z_j = observation_model(x, j)

    global map % map | 2Xn for n landmarks

    % YOUR IMPLEMENTATION %
    h = [sqrt((map(j, 1) - x(1))^2 + (map(j, 2) - x(2))^2);
         mod(atan2(map(j, 2) - x(2), map(j, 1) - x(1)) - x(3) + pi, 2 * pi) - pi];
    z_j = h;

end
