close all;
clear all;
clc;

for index = 1:6
    imageName = strcat('image',int2str(index),'.jpg');
    img = imread(imageName);       
    [height, width] = size(img);  

    h = floor(height/3);    

    blue = img(1:h,:);                 
    green = img(h+1:2*h,:);     
    red = img(2*h+1:3*h,:);     

    
   
    [alignedCorners, offsetG, offsetR] = RANSAC(red, green, blue);
    imwrite(alignedCorners, strcat('image', int2str(index),'-ransac.jpg'));
end






