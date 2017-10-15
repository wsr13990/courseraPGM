function factors = ComputeAllSimilarityFactors (images, K)
% This function computes all of the similarity factors for the images in
% one word.
%
% Input:
%   images: An array of structs containing the 'img' value for each
%     character in the word.
%   K: The alphabet size (accessible in imageModel.K for the provided
%     imageModel).
%
% Output:
%   factors: Every similarity factor in the word. You should use
%     ComputeSimilarityFactor to compute these.
%
% Copyright (C) Daphne Koller, Stanford University, 2012

n = length(images);
nFactors = nchoosek (n, 2);

factors = repmat(struct('var', [], 'card', [], 'val', []), nFactors, 1);

% Your code here:
assignments = nchoosek(1:n,2);
for i=1:nFactors
  factors(i).var = assignments(i,:);
  factors(i).card = K.*ones(1,2);
  factors(i).val = ComputeSimilarityFactor(images,K,factors(i).var(1),factors(i).var(2)).val;
endfor
end

