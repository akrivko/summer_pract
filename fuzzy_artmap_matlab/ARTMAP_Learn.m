function new_artmap_network = ARTMAP_Learn(artmap_network, data, supervisor)



[numFeatures, numSamples] = size(data);

new_artmap_network = {};



for epochNumber = 1:artmap_network.numEpochs
 
    numChanges = 0;
    
    for sampleNumber = 1:numSamples
             
        currentData = data(:, sampleNumber);
      
        currentSupervisor = supervisor(1, sampleNumber);
           
        if(isempty(artmap_network.mapField) | isempty(find(artmap_network.mapField == currentSupervisor)))
            
            [resizedWeight, resizedMapField] = ARTMAP_Add_New_Category(artmap_network.weight, artmap_network.mapField);
            resizedWeight = ART_Update_Weights(currentData, resizedWeight, length(resizedMapField), artmap_network.learningRate);
            artmap_network.weight = resizedWeight;
            artmap_network.numCategories = artmap_network.numCategories + 1;
            resizedMapField(1, length(resizedMapField)) = currentSupervisor;
            artmap_network.mapField = resizedMapField;
            numChanges = numChanges + 1;
            continue;    
            
        else
        
            bias = artmap_network.bias;
            categoryActivation = ART_Activate_Categories(currentData, artmap_network.weight, bias);
            
            [sortedActivations, sortedCategories] = sort(-categoryActivation);
            
            matchTracking = 1;
            vigilance = artmap_network.vigilance;
	           
            resonance = 0;
            match = 0;
            numSortedCategories = length(sortedCategories);
            currentSortedIndex = 1;
            while(~resonance)
                
                currentCategory = sortedCategories(currentSortedIndex);
                
                currentWeightVector = artmap_network.weight(:, currentCategory);
                
                match = ART_Calculate_Match(currentData, currentWeightVector);
                
                if(match < vigilance)
                    
                    if(currentSortedIndex == numSortedCategories)
                        if(currentSortedIndex == artmap_network.maxNumCategories)
                            fprintf('WARNING: The maximum number of categories has been reached.\n');
                            resonance = 1;
                        else
                            [resizedWeight, resizedMapField] = ARTMAP_Add_New_Category(artmap_network.weight, artmap_network.mapField);
                            [resizedWeight, weightChange] = ART_Update_Weights(currentData, resizedWeight, currentSortedIndex + 1, artmap_network.learningRate);
                            artmap_network.weight = resizedWeight;
                            artmap_network.numCategories = artmap_network.numCategories + 1;
                            resizedMapField(1, currentSortedIndex + 1) = currentSupervisor;
                            artmap_network.mapField = resizedMapField;

                            numChanges = numChanges + 1;
                            
                            resonance = 1;
                        end
                    else
                        currentSortedIndex = currentSortedIndex + 1;
                    end 
                    
                else 
                    
                  
                    if(artmap_network.mapField(1, currentCategory) == currentSupervisor)
                      
                        [artmap_network.weight, weightChange] = ART_Update_Weights(currentData, artmap_network.weight, currentCategory, artmap_network.learningRate);

                        if(weightChange == 1)
                            numChanges = numChanges + 1;
                        end

                        resonance = 1;
                    else
                       
                        vigilance = match + 0.000001;
                        if(currentSortedIndex == numSortedCategories)
                            if(currentSortedIndex == artmap_network.maxNumCategories)
                                fprintf('WARNING: The maximum number of categories has been reached.\n');
                                resonance = 1;
                            else
                                [resizedWeight, resizedMapField] = ARTMAP_Add_New_Category(artmap_network.weight, artmap_network.mapField);
                                [resizedWeight, weightChange] = ART_Update_Weights(currentData, resizedWeight, currentSortedIndex + 1, artmap_network.learningRate);
                                artmap_network.weight = resizedWeight;
                                artmap_network.numCategories = artmap_network.numCategories + 1;
                                resizedMapField(1, currentSortedIndex + 1) = currentSupervisor;
                                artmap_network.mapField = resizedMapField;
                                
                             
                                numChanges = numChanges + 1;
                                
                                resonance = 1;
                            end
                        else
                            currentSortedIndex = currentSortedIndex + 1;
                            resonance = 0;
                        end
                    end      
                end    
            end     
        end     
    end      
    if(numChanges == 0)
        break;
    end

end     


fprintf('The number of epochs needed was %d\n', epochNumber);

new_artmap_network = artmap_network;

return