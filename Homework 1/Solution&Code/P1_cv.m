clear all

% Load dataset
load('problem1.mat')

% Cross Validation Values
cv_trainErrors = [];
cv_testErrors = [];
 
% Kfold Method, 500 of grouping information , divided into two
indices = crossvalind('Kfold', 500, 2) % 

% Point out the training set and testing set of dataset-x
training_x = x(indices == 1);
testing_x = x(indices == 2);

% Point out the training set and testing set of dataset-y
training_y = y(indices == 1);
testing_y = y(indices == 2);

% Set training iteration to 100
for d = 1:100
    [train_error, models, test_error] = polyreg(training_x, training_y, d, testing_x, testing_y);
    
    % Save related values
    cv_trainErrors(d) = train_error;
    cv_testErrors(d) = test_error;
end
 
clf;
hold on;

% Set figure title
title('Problem1: Cross Validation Results');

% Draw curves and signs
plot(cv_testErrors, 'b', 'LineWidth', 3);
plot(cv_trainErrors, 'y', 'LineWidth', 3);
legend('test', 'train');

% Get the minimum of test_error
[~, i] = min(cv_testErrors);

% Print the minimum value
fprintf('The minimum is: %d', i )

