clc;
clear all;

imgs = ['image1.jpg','image2.jpg','image3.jpg','image4.jpg','image5.jpg','image6.jpg'];
for k = 1:6
    img = imgs(k*10-9:k*10);
    img1 = imread(img);
    [r1,c1] = size(img1);
    Red1 = img1(ceil(2*r1/3):r1,:);
    Green1 = img1(ceil(r1/3):ceil(2*r1/3),:);
    Blue1 = img1(1:ceil(r1/3),:);
    [x11,y11] = ssdMatch1(Blue1,Red1);
    [x12,y12] = ssdMatch1(Blue1,Green1);
    shiftedRed = circshift(Red1,[x11,y11]);
    shiftedGreen = circshift(Green1,[x12,y12]);
    FinalImage1 = cat(3,shiftedRed,shiftedGreen,Blue1);
    figure
    imshow(FinalImage1);
    chr = int2str(k);
    str1 = 'image';
    str2 = '-ssd.jpg';
    sname = [str1,chr,str2];
    savename = join(sname);
    imwrite(FinalImage1,savename);
end

function [x,y] = ssdMatch1(Crp1,Crp2)
    [r11,c11] = size(Crp1);
    [r12,c12] = size(Crp2);
    score = inf;
    %Centre part of images
    Part1 = Crp1(ceil(r11/2)-100 : ceil(r11/2) + 100,ceil(c11/2)-100 :ceil(c11/2)+100);
    Part2 = Crp2(ceil(r12/2)-100 : ceil(r12/2) + 100,ceil(c12/2)-100 :ceil(c12/2)+100);
    %moving around the cropped part and calculating score based on ssd
    for i= -15:15
        for j = -15:15
                %diff = Part1-circshift(Part2,[i,j]);
                shift2 = circshift(Part2,[i,j]);
                square = sum(sum((double(Part1)-double(shift2)).^2));                
                if square < score
                    score = square;
                    x = i;
                    y = j;
                end
        end
    end
end

