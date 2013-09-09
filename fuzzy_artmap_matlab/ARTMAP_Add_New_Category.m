function [resizedWeight, resizedMapField] = ARTMAP_Add_New_Category(weight, mapField)

[numFeatures, numCategories] = size(weight);
newCategory = ones(numFeatures, 1);
resizedWeight = [weight, newCategory];

resizedMapField = [mapField, 0];


return