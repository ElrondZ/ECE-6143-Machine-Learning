clear all
% Load Dataset
load('dataset4.mat');

% Set related constants
tolerence = 0.0001;
stepsize = 0.0001;
iteration_max = 10000;
iteration_num = 0;
theta = rand(size(X,2), 1);
old_theta = theta + 2 * tolerence;

% Arrays for figures drawing
risks = [];
errors = [];

while norm(theta - old_theta) >= tolerence
    if iteration_num > iteration_max
        break;
    end

    f = 1./(1+exp(-X*theta));
    
    % Calculate the risk
    r = (Y-1).*log(1-f)-Y.*log(f);
    n = isnan(r);
    r(n) = 0;
    risk = mean(r);
    
    % Calculate the gradient
    N = length(Y);
    m1 = repmat(Y, 1, size(X,2));
    m2 = repmat(f, 1, size(X,2));
    sub_f1 = X.* repmat(exp(-X * theta), 1, size(X, 2));
    sub_f2 = (1 - m1).*(X-sub_f1.*m2) - m1.*sub_f1.*m2;
    grad_temp = sum(sub_f2);
    gradient = grad_temp / N;
    gradient = gradient';
    
    % Output 1 if f>0.5, Output 0 otherwise
    f(f>=0.5) = 1;
    f(f<0.5) = 0;
    
    error = sum(f~=Y)/length(Y);
    risks = cat(1, risks, risk);
    errors =cat(1, errors, error);
    
    old_theta = theta;
    theta = theta - stepsize * gradient;
    iteration_num = iteration_num + 1;
end
    
% Get the figure about errors&risks with iterations
plot(1:iteration_num, errors, 'b', 1:iteration_num, risks, 'y', 'LineWidth', 3);
title('Errors and Iterations');
legend('Errors', 'Risks');
h = figure();

% Get the figure about the boundary line
plot(X(:,1),X(:,2), 'x');
hold on;
x = 0:0.0001:1;
y = (-theta(3) - theta(1).*x) / theta(2);
plot(x, y, 'b', 'LineWidth', 3);
legend('Sample', 'Boundary Line');
title('About Boundary');
