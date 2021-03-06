function [alignedCorners, offset_g, offset_r] = imalign3(Red, Green, Blue)


[b_corn, b_pos] = HarrisCorner(Blue, 1);
[g_corn, g_pos] = HarrisCorner(Green, 2);
[r_corn, r_pos] = HarrisCorner(Red, 3);


in = cat(3, Red, Green, Blue);
[alignedCorners, disps] = alignCorners(in);
offset_g = disps(1,:); disp(offset_g);
offset_r = disps(2,:); disp(offset_r);

for i = 1:200               
     
     b = randsample(1:length(b_pos), 1);
     rand_b = b_pos(b,:);
     
     g = randsample(1:length(g_pos), 1);
     rand_g = g_pos(g,:);
     
     r = randsample(1:length(r_pos), 1);
     rand_r = r_pos(r,:);
     offset_bg = rand_b - rand_g;
     offset_br = rand_b - rand_r;
   
     new_g = imtranslate(Green, fliplr(offset_bg));
     new_r = imtranslate(Red, fliplr(offset_br));
     
     inliers = 0;
   
     for j = 1:length(g_pos)
         if (new_g - Blue == 0)
             inliers = inliers + 1;
         else
             continue;
         end
         
         
         [aC_g, best_alignment_g] = alignCorners(new_g);
         [aC_r, best_alignment_r] = alignCornerns (new_r);
     end
end
end

function [corners, pos] = HarrisCorner(ch, no)

[h, w] = size(ch); 

k = 0.08;          
threshold = 2e+9;  

sigma = 1;         
[xmask, ymask] = meshgrid(-3:3, -3:3); 

Gxy = exp(-(xmask.^2 + ymask.^2)/(2*sigma^2)); 
Gx = xmask.*exp(-(xmask.^2 + ymask.^2)/(2*sigma^2));   
Gy = ymask.*exp(-(xmask.^2 + ymask.^2)/(2*sigma^2));   


Ix = conv2(Gx, ch);    
Iy = conv2(Gy, ch);    


Ix2 = Ix.^2;           
Iy2 = Iy.^2;           
Ixy = Ix.*Iy;          

Ix2c = conv2(Gxy, Ix2);    
Iy2c = conv2(Gxy, Iy2);    
Ixyc = conv2(Gxy, Ixy);    

corners = zeros(h, w);      

for i = 1:h
    for j = 1:w
        M = [Ix2c(i,j), Ixyc(i,j); Ixyc(i,j) Iy2c(i,j)];
        
        C = det(M) - k*(trace(M)^2);
                if (C > threshold)
            corners(i,j) = C;
        end
    end
end

%Using non-max suppression to detect every feature only once
positions = corners > imdilate(corners, [1 1 1; 1 0 1; 1 1 1]);
[xpos, ypos] = find(positions);    
pos = [xpos ypos];


if (no == 1)
    channel = 'Blue';
elseif (no == 2)
    channel = 'Green';
else
    channel = 'Red';
end
     
figure; imshow(ch, []); hold on;
plot(ypos, xpos, 'b.'); title(strcat('Corners ','  ', channel));
saveas(gcf, strcat(channel, '-corners.jpg'));
end

function [new, move] = alignCorners(input)
rows = size(input, 1);
cols = size(input, 2);


R = double(edge(input(1:rows, 1:cols, 1),'canny'));
G = double(edge(input(1:rows, 1:cols, 2), 'canny'));
B = double(edge(input(1+15:rows-15, 1+15:cols-15, 3), 'canny'));


all_Corners = cat(3,R, G);

scoreRed = 0;
scoreGreen = 0;

move = zeros(2,2);


for i = -15:1:15
    for j = -15:1:15
        tempR = all_Corners(i+16:end-15+i, j+16:end-15+j, 1);
        tempG = all_Corners(i+16:end-15+i, j+16:end-15+j, 2);
        
        % Calculate the NCC values for Red and Green channels without
        % normxcorr2
        calc_R = sum(tempR(:).*B(:))/(norm(tempR(:))*norm(B(:)));
        calc_G = sum(tempG(:).*B(:))/(norm(tempG(:))*norm(B(:)));
     
        if (calc_R > scoreRed)
            move(2,:) = [i-1 j+1];
            scoreRed = calc_R;
        end
   
        if (calc_G > scoreGreen)
            move(1,:) = [i-1 j+1];
            scoreGreen = calc_G;
        end
    end
end

input(16:end-move(2,1), 15+1:end-move(2,2), 1) = input(16+move(2,1):end, 16+move(2,2):end, 1);
input(16:end-move(1,1), 15+1:end-move(1,2), 2) = input(16+move(1,1):end, 16+move(1,2):end, 2);
new = uint8(input);

end