function [X_norm, mu, sigma] = stdNormalize(X)
%stdNORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.

mu = mean(X);
X_norm = double(X)-ones(size(X,1),1)*mu;
sigma = std(double(X))+ones(1,size(X,2))*1e-100;
X_norm = X_norm./(ones(size(X,1),1)*sigma);



% ============================================================

end