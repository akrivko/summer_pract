function [updatedWeight, weightChange] = ART_Update_Weights(input, weight, categoryNumber, learningRate)

[numFeatures, numCategories] = size(weight);

weightChange = 0;
for i = 1:numFeatures
    if(input(i) < weight(i, categoryNumber))
        weight(i, categoryNumber) = (learningRate * input(i)) + ((1 - learningRate) * weight(i, categoryNumber));
        weightChange = 1;
    end
end
    
updatedWeight = weight;

return