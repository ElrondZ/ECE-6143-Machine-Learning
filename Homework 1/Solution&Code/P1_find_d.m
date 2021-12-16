clear all

% Load Dataset
load('problem1.mat')

% Let d from 1 to 20, get different values to evaluate
for d = 1:20
    
    polyreg(x,y,d)
    
    % Display all the figures
    title(sprintf('Problem1 -- find d: d = %d', d))
    h = figure();
    
end
