function [classification, Net] = ARTMAP_Classify(artmap_network, data)

[numFeatures, numSamples] = size(data);

classification = zeros(1, numSamples);

for sampleNumber = 1:numSamples
    
    currentData = data(:, sampleNumber);
    
    bias = artmap_network.bias;
    categoryActivation = ART_Activate_Categories(currentData, artmap_network.weight, bias);
    
    [sortedActivations, sortedCategories] = sort(-categoryActivation);
    
    resonance = 0;
    match = 0;
    numSortedCategories = length(sortedCategories);
    currentSortedIndex = 1;
    while(~resonance)
        
        if(numSortedCategories == 0)
            classification(1, sampleNumber) = -1;
            resonance = 1;
            [resizedWeight, resizedMapField] = ARTMAP_Add_New_Category(artmap_network.weight, artmap_network.mapField);
            artmap_network.numCategories = artmap_network.numCategories + 1;
            [resizedWeight, weightChange] = ART_Update_Weights(currentData, resizedWeight, artmap_network.numCategories, artmap_network.learningRate);
            artmap_network.weight = resizedWeight;
            resizedMapField(1, artmap_network.numCategories) = artmap_network.numCategories;
            artmap_network.mapField = resizedMapField;
            Net = artmap_network;
            break;
        end

        currentCategory = sortedCategories(currentSortedIndex);
        
        currentWeightVector = artmap_network.weight(:, currentCategory);
        
        match = ART_Calculate_Match(currentData, currentWeightVector);
        
        if(match < artmap_network.vigilance)

            if(currentSortedIndex == numSortedCategories)
                classification(1, sampleNumber) = -1;
                resonance = 1;
                [resizedWeight, resizedMapField] = ARTMAP_Add_New_Category(artmap_network.weight, artmap_network.mapField);
                artmap_network.numCategories = artmap_network.numCategories + 1;
                [resizedWeight, weightChange] = ART_Update_Weights(currentData, resizedWeight, artmap_network.numCategories, artmap_network.learningRate);
                artmap_network.weight = resizedWeight;
                resizedMapField(1, artmap_network.numCategories) = artmap_network.numCategories;
                artmap_network.mapField = resizedMapField;
                Net = artmap_network;           
            else
                currentSortedIndex = currentSortedIndex + 1;
            end            
            
        else

            classification(1, sampleNumber) = artmap_network.mapField(1, currentCategory);
            resonance = 1;             
            
            
            [resizedWeight, weightChange] = ART_Update_Weights(currentData, artmap_network.weight, artmap_network.numCategories, artmap_network.learningRate);
            artmap_network.weight = resizedWeight;             
                        
            
        end
    end    
end

Net = artmap_network;

return