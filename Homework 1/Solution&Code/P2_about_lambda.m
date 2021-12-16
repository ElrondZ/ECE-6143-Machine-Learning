clear all

% Load dataset
load('problem2.mat')
 
% Kfold Method, 500 of grouping information , divided into two
indices = crossvalind('Kfold', 400, 2) % 
cv_trainErrors = [];
cv_testErrors = [];

% Point out the training set and testing set of dataset-x
training_x = x(indices == 1, :);
testing_x = x(indices == 2, :);

% Point out the training set and testing set of dataset-y
training_y = y(indices == 1);
testing_y = y(indices == 2);

flag = 1;
lambdas = 0:1:1000;

for lambda = lambdas
    [train_error, models, test_error] = P2_modified_reg(training_x, training_y, lambda, testing_x, testing_y);
    % Save related values
    cv_trainErrors(flag) = train_error;
    cv_testErrors(flag) = test_error;
    flag = flag + 1;
end

close all;
hold on;

% Set figure title
title('Problem2: Cross Validation Results');

% Draw curves and signs
plot(lambdas, cv_trainErrors, 'b', 'LineWidth', 3);
plot(lambdas, cv_testErrors, 'y', 'LineWidth', 3);
legend('train error', 'test error');

% Get the minimum of test_error
[~, i] = min(cv_testErrors);
plot(lambdas(i), cv_testErrors(i), 'rx')

% Print the minimum value
fprintf('The minimum is: %d', lambdas(i) )


