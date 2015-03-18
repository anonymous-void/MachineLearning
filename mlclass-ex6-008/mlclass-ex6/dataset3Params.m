function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%
cc = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
ss = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
cc_temp = C;
ss_temp = sigma;
error_prev = 100; %% a random number
for i=1:length(cc)
	for j=1:length(ss)
		model = svmTrain(X, y, cc(i), @(x1, x2) gaussianKernel(x1, x2, ss(j)));
		predictions = svmPredict(model, Xval);
		error_now = mean(double(predictions ~= yval));
		if (error_now < error_prev)
			cc_temp = cc(i);
			ss_temp = ss(j);
			error_prev = error_now;
		end
	end
end
C = cc_temp
sigma = ss_temp






% =========================================================================

end
