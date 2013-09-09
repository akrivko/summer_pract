function feature = feature_image(s)

I = imread (s);
ID = im2double(I);
width = 32;
height = 32;

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



num_image = 1;
    for i = 1:1:8        
        for j = 1:1:width/scale
            feature((i-1)*width/scale+j,1) = ISS(i,j);
        end;        
    end;


return