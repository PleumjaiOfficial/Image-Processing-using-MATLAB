% Quiz 4
% 62070501030, Thornthan yasukam

%% Input image

img = imread("p2.jpg")
img_gray = rgb2gray(img)
figure, imshow(img_gray);

%% Pre-procssing
B = imbinarize(img_gray, 'adaptive', 'Sensitivity',0.50,'ForegroundPolarity','dark')
% figure, imshow(BW);
B_comp = ~B
%figure, imshow(BW);

struc_img = strel('disk', 8, 0);
se1 = imclose(B_comp, struc_img)
%figure, imshow(se1);

struc_img_2 = strel('disk', 3, 0);
se2 = imclose(se1, struc_img_2)
%figure, imshow(se2);

img_post_process = imfill(se2,'holes')
figure, imshow(img_post_process);


%% get region
[region, num_pixel_region] = bwlabel(img_post_process);
figure, imshow(label2rgb(region));

% % Like region prop but heavy load
% for j=1:1
% [row, col] = find(label == j)
% % Get maximum of row and column
% % Can solve problem object is nearly???
% len = max(row) - min(row) + 2
% breadth = max(col) - min(col) + 2
% target = uint8(zeros([len breadth]))
% sy = min(col) - 1
% sx = min(row) - 1
% 
% frist_row = row(1)
% for i = 1:size(row, 1)
%     x = row(i,1) - sx
%     y = col(i,1) - sy
%     target(x,y) = img(row(i,1), col(i,1))
% end
% 
% title = strcat('Object Number:',num2str(i))
% figure, imshow(target), title(title);
% end

region_stat = regionprops(region,'all')

for i=1:num_pixel_region
    text(region_stat(i).Centroid(1),region_stat(i).Centroid(2),...
        sprintf('%04d',region_stat(i).Area), 'Hor','Center','Vert','middle')
end


%% Classification with stat
Area = vertcat(region_stat.Area)
histogram(Area, 10000:1000:50000)
xlabel('Area (pixels) ')
ylabel('Number of Parts')

%%
minArea = [10000 19000 26000 29000 34000 40000]
maxArea = [18000 25000 29000 33000 39000 45000]
name = {'25Stang','50Stang','1Bath','2Bath','5Bath','10Bath'}
color_reg = {'r','m','y','w','g','b'}

% Can not use this function
%  I = insertObjectAnnotation(I,...
%         'rectangle',vertcat(region_stat(idx).BoundingBox),... 
%         name{k}, 'Color', color_reg{k})


%% Clop image
% for k = 1:size(region_stat)
% 
%     idx = Area > minArea(k) & Area < maxArea(k)
%     area_coin = vertcat(region_stat(idx).Area)
% 
%     if area_coin > minArea(1) & area_coin < maxArea(1) == 1
%         coin_name = name(1)
%         color_col = color(1)
% 
%     elseif area_coin > minArea(2) & area_coin < maxArea(2) == 1
%         coin_name = name(2)
%         color_col = color(2)
% 
%     elseif area_coin > minArea(3) & area_coin < maxArea(3) == 1
%         coin_name = name(3)
%         color_col = color(3)
%     
%      elseif area_coin > minArea(4) & area_coin < maxArea(4) == 1
%         coin_name = name(4)
%         color_col = color(4)
% 
%     elseif area_coin > minArea(5) & area_coin < maxArea(5) == 1
%         coin_name = name(5)
%         color_col = color(5)
% 
%     else 
%         coin_name = name(6)
%         color_col = color(6)
%     end



%%
for k = 1:size(region_stat)

   % Smaller than 25 stang not coin
   if Area(k) < min(minArea) 
       break 
   else
        boundingbox = region_stat(k).BoundingBox;
        target = imcrop(img, boundingbox);
        figure
        imshow(target)
        name = 'hehe'
        col = 'sfs'
        title(namecol)
   end
end


