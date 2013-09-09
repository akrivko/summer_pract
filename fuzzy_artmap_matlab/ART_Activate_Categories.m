function categoryActivation = ART_Activate_Categories(input, weight, bias)


[numFeatures, numCategories] = size(weight);

categoryActivation = ones(1, numCategories);

% Activation(j) = |Input^Weight(j)| / (bias + |Weight(j)|)
for j = 1:numCategories    
    matchVector = min(input, weight(:, j));
    weightLength = sum(weight(:, j));
    categoryActivation(1, j) = sum(matchVector) / (bias + weightLength);
end


return