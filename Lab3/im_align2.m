clc;
clear all;

imgs = ['image1.jpg','image2.jpg','image3.jpg','image4.jpg','image5.jpg','image6.jpg'];
for k = 1:6
    img = imgs(k*10-9:k*10);
    img1 = imread(img);
    [r1,c1] = size(img1);
    Red1 = img1((2*r1/3):r1,:);
    Green1 = img1((r1/3):(2*r1/3),:);
    Blue1 = img1(1:(r1/3)+1,:);
    [x11,y11] = NccMatch(Blue1,Red1);
    [x12,y12] = NccMatch(Blue1,Green1);
    shiftedRed = circshift(Red1,[x11,y11]);
    shiftedGreen = circshift(Green1,[x12,y12]);
    FinalImage1 = cat(3,shiftedRed,shiftedGreen,Blue1);
    figure
    imshow(FinalImage1)
    chr = int2str(k);
    str1 = 'image';
    str2 = '-ncc.jpg';
    sname = [str1,chr,str2];
    savename = join(sname);
    imwrite(FinalImage1,savename);
end

function [x1,y1] = NccMatch(Crp1,Crp2)
    x = 15;
    score = -inf;
    trans_x = 0;
    trans_y = 0;
    [r11,c11] = size(Crp1);
    [r12,c12] = size(Crp2);
    for j = -x:x
        for k = -x:x
            Part1 = Crp1(ceil(r11/2)-45 : ceil(r11/2) +45 ,ceil(c11/2)-45 :ceil(c11/2)+45);
            Part2 = Crp2(ceil(r12/2)-45 : ceil(r12/2) + 45,ceil(c12/2)-45 :ceil(c12/2)+45); 
            Part1=im2double(Part1);
            size(Part1)
            Part2=im2double(Part2);
            size(Part2)
            Part2 = circshift(Part2,[j,k]);
            m1 = mean(Part1);
            m2 = mean(Part2);
            Part1 = Part1 - m1;
            Part2 = Part2 - m2;
            nrm = dot(Part1,Part2)/sqrt(dot(Part1.^2,Part2.^2));
            if nrm > score
                score = nrm;
                trans_x = j;
                trans_y = k;
            end
        end
    end
    x1 = trans_x;
    y1 =trans_y;
end

