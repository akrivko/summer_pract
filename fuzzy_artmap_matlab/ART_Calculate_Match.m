function match = ART_Calculate_Match(input, weightVector)

match = 0;
numFeatures = length(input);

%       Match = |Input^WeightVector| / |Input|
matchVector = min(input, weightVector);
inputLength = sum(input);
if(inputLength == 0)
    match = 0;
else
    match = sum(matchVector) / inputLength;
end

   
return