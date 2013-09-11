function artmap_network = ARTMAP_Create_Network(numFeatures, numClasses)

numFeatures = round(numFeatures);

numClasses = round(numClasses);

weight = ones(numFeatures, 0);

mapField = zeros(0);

artmap_network = struct('numFeatures', {numFeatures}, 'numCategories', {0}, 'maxNumCategories', {100}, ...
                        'numClasses', {numClasses}, 'weight', {weight}, 'mapField', {mapField}, ...
                        'vigilance', {0.7}, 'bias', {0.000001}, 'numEpochs', {100}, 'learningRate', {1.0});
    
                 
return

