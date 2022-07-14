% This function is the implementation of the jacobian measurement model
% required for the update of the covariance function after incorporating
% the measurements
% Inputs:
%           x(t)        3X1
%           j           1X1 which landmark (map column)
%           z_j         2X1
% Outputs:  
%           H           2X3
function H = jacobian_observation_model(x, j, z_j)

    global map % map | 2Xn for n landmarks

    % YOUR IMPLEMENTATION %
    H = [(map(j, 1) - x(1)) / z_j(1), (map(j, 2) - x(2)) / z_j(1), 0;
         (-map(j, 2) - x(2)) / z_j(2)^2, (map(j, 1) - x(1)) / z_j(1)^2, -1];

end
