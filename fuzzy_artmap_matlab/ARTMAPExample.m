I = imread ('C:\Users\ART\Documents\GitHub\summer_pract\fuzzy_artmap_matlab\image\sample_5.bmp');
ID = im2double(I);
width = 32;
height = 320;

scale=4;

for i = 1:1:height/scale
    for j = 1:1:width        
        IS(i,j) = ID((i-1)*scale+1,j) + ID((i-1)*scale+2,j) + ID((i-1)*scale+3,j) + ID((i-1)*scale+4,j); 
        IS(i,j) = IS(i,j)/scale;
    end;
end;

for j = 1:1:width/scale
    for i = 1:1:height/scale        
        ISS(i,j) = IS(i,(j-1)*scale+1) + IS(i,(j-1)*scale+2) + IS(i,(j-1)*scale+3) + IS(i,(j-1)*scale+4); ; 
        ISS(i,j) = ISS(i,j)/scale;
    end;
end;

imshow(ISS);


input = zeros(64,10);
for num_image = 1:1:10
    for i = 1:1:8        
        for j = 1:1:width/scale
            input( (i-1)*width/scale+j, num_image) = ISS((num_image-1)*8+i,j);
        end;        
    end;
end;


sup = [1, 1, 2, 3, 3, 2, 4, 4, 5, 5];

ccInput = ART_Complement_Code(input);

net = ARTMAP_Create_Network(128, 5);

newNet = ARTMAP_Learn(net, ccInput, sup);

old = newNet;


newInput = feature_image('C:\Users\ART\Documents\GitHub\summer_pract\fuzzy_artmap_matlab\image\sample_b.bmp');

ccNewInput = ART_Complement_Code(newInput);

[class, newNet] = ARTMAP_Classify(newNet, ccNewInput);
class


