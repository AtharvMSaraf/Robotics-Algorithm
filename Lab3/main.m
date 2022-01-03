clc;
clear all;
close all;
imgs = ['image1.jpg','image2.jpg','image3.jpg','image4.jpg','image5.jpg','image6.jpg'];
for k = 1:6
    img = imgs(k*10-9:k*10);
    img1 = imread(img);
    [r1,c1] = size(img1);
    Red = img1(ceil(2*r1/3):r1,:);
    Green = img1(ceil(r1/3):ceil(2*r1/3),:);
    Blue = img1(1:ceil(r1/3),:);
    FinalImage1 = cat(3,Red,Green,Blue); 
end
im_align1;
im_align2;
im_align3;