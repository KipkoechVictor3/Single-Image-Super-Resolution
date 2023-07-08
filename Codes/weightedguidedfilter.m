function FilteredImage= weightedguidedfilter(I, p, r, eps)
%   - guidance image: I (should be a gray-scale/single channel image)
%   - filtering input image: p (should be a gray-scale/single channel image)
%   - local window radius: r
%   - regularization parameter: eps

[h, w] = size(I);
M = boxfilter(ones(h, w), r);
MeanI = boxfilter(I, r) ./ M; %%Average of pixel values in a patch 
MeanP = boxfilter(p, r) ./ M;
MeanIp = boxfilter(I.*p, r) ./ M;
CovarianceIp = MeanIp - MeanI .* MeanP; % covariance of (I, p) in each local patch.

mean_II = boxfilter(I.*I, r) ./ M;
var_I = mean_II - MeanI .* MeanI;

a = CovarianceIp ./ (var_I + eps);
b = MeanP - a .* MeanI; 

mean_a = boxfilter(a, r) ./ M;
mean_b = boxfilter(b, r) ./ M;

FilteredImage = mean_a .* I + mean_b;
end