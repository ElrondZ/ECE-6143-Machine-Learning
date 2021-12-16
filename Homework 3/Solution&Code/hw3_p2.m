load('dataset.mat');

generate_data_number = size(X, 1);
trainset_selection = randsample(generate_data_number, generate_data_number/2);
testset_selection = setdiff(1:generate_data_number, trainset_selection);

trainX = X(trainset_selection, :);
testX = X(testset_selection, :);

trainY = Y(trainset_selection, :);
testY = Y(testset_selection, :);

iterations = 5;
erros = zeros(1, iterations);

% ------------------------------------------------------------------------------------------
for iter = 1:iterations
    
    [nsv, alpha, bias] = svc(trainX, trainY, 'linear',-4);
    
    predictedY = svcoutput(trainX, trainY, testX, 'linear', alpha, bias);
    
    erros(iter) = svcerror(trainX, trainY, testX, testY, 'linear', alpha, bias);
end

f = figure();
clf(f);
plot(1:iterations, erros);
% ------------------------------------------------------------------------------------------


% ------------------------------------------------------------------------------------------
% p1 = 6;
% for iter = 1:iterations
%     
%     fprintf("slfjlsdjfllsldfldfj: %d", p1);
%     
%     
%     [nsv, alpha, bias] = svc(trainX, trainY, 'poly', inf);
%     
%     predictedY = svcoutput(trainX, trainY, testX, 'poly', alpha, bias);
%     
%     erros(iter) = svcerror(trainX, trainY, testX, testY, 'poly', alpha, bias);
% end
% 
% f = figure();
% clf(f);
% plot(1:iterations, erros);
% ------------------------------------------------------------------------------------------


% ------------------------------------------------------------------------------------------
% global p1;
% p1 = 5;
% 
% errors = zeros(1, numel(p1));
% for iters = 1:numel(p1)
%     [nsv, alpha, bias] = svc(trainX, trainY, 'rbf', -5);
%     predictedY = svcoutput(trainX, trainY, testX, 'rbf', alpha, bias);
%     errors(iters) = svcerror(trainX, trainY, testX, testY, 'rbf', alpha, bias);
% end
% 
% f = figure();
% clf(f);
% plot(p1, errors);
% ------------------------------------------------------------------------------------------
    