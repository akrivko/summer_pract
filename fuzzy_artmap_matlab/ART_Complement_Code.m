function complementCodedData = ART_Complement_Code(data)

[numFeatures, numSamples] = size(data);

complementCodedData = ones(2*numFeatures, numSamples);

for j = 1:numSamples
    count = 1;
    for i = 1:2:(2*numFeatures)
        complementCodedData(i, j) = data(count, j);
        complementCodedData(i + 1, j) = 1 - data(count, j);
        count = count + 1;
    end
end

return