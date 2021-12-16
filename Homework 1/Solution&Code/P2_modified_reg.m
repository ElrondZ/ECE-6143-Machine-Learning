function [error, model, errT] = P2_modified_reg(x, y, lambda, xT, yT)
%
%
% x = vector of input scalars for training
% y = vector of output scalars for training
% xT = vector of input scalars for testing
% yT = vector of output scalars for testing
% error = average squared loss on training
% model = vector of polynomial parameter coefficients
% errT = average squared loss on testing
%
% lambda: penalty parameter
%
%
%

fx = x' * x;
msub_formula_1 = x' * y;
msub_formula_2 = x' * x + lambda * eye(size(fx));

model = msub_formula_2 \ msub_formula_1;

error = (1/(2*size(x, 1))) * sum((y-x*model).^2);

errT = (1/(2 * size(xT, 1))) * sum((yT - xT * model).^2);



