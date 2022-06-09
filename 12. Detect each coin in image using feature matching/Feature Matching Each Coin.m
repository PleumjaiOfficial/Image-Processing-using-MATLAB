% Quiz 4
% 62070501030, Thornthan yasukam

%% Input image

img = imread("p1.jpg")
figure,
imshow(img)
title('Original')

img_gray = rgb2gray(img)
figure,
imshow(img_gray)
title('Gray image')


%% Pre-procssing
% Morphological 
% 1. use Opening to hole
% 2. use Closing to clear noise

B = imbinarize(img_gray, 'adaptive', 'Sensitivity',0.50,'ForegroundPolarity','dark')
% figure, imshow(BW);
B_comp = ~B
%figure, imshow(BW);

struc_img = strel('disk', 8, 0);
se1 = imclose(B_comp, struc_img)
%figure, imshow(se1);

struc_img_2 = strel('disk', 3, 0);
se2 = imopen(se1, struc_img_2)
%figure, imshow(se2);

img_post_process = imfill(se2,'holes')
figure, imshow(img_post_process);

%% get region
% 1. Get region from circle that from  Morphological 
% 2. Use to Classification of each coin
[region, num_pixel_region] = bwlabel(img_post_process);
figure, imshow(label2rgb(region));

region_stat = regionprops(region,'all')

for i=1:num_pixel_region
    text(region_stat(i).Centroid(1),region_stat(i).Centroid(2),...
        sprintf('%04d',region_stat(i).Area), 'Hor','Center','Vert','middle')
end

%% Classification with histogram
% Histogram criterion for classification coin
Area = vertcat(region_stat.Area)
histogram(Area, 10000:1000:50000)
xlabel('Area (pixels) ')
ylabel('Number of Parts')


%% Gobal Policy from Classification Histogram
minArea = [10000 19000 26000 29000 34000 40000]
maxArea = [18000 25000 29000 33000 39000 45000]
name = {'25Stang','50Stang','1Bath','2Bath','5Bath','10Bath'}
color_reg = {'r','m','y','w','g','b'}

%% Target image
% 1. Crop each coin in original image to use as target
% 2. Get information to coin base on histogram and specific color of coin
    % red : '25Stang'
    % margenta: '50Stang'
    % yellow: '1Bath'
    % White: '2Bath'
    % Green:'5Bath'
    % Blue: '10Bath'

output_image = imresize(img,[499 666])
keep_line = 0
n = 20;
M = cell(20, 1);

for k = 1:size(region_stat)

     % Smaller than 25 stang not coin
      if Area(k) > min(minArea) == 1 
            boundingbox = region_stat(k).BoundingBox;
            target = imcrop(img, boundingbox);
            figure
            imshow(target)
            title('taget from segmentation')
            
            % Get target and line for display result
            target = rgb2gray(target)
            keep_line = keep_line + 1

        % Get information to coin
            area_coin = vertcat(region_stat(k).Area)
        
            if area_coin > minArea(1) & area_coin < maxArea(1) == 1
                coin_name = name(1)
                color_coin = color_reg(1)
        
            elseif area_coin > minArea(2) & area_coin < maxArea(2) == 1
                coin_name = name(2)
                color_coin = color_reg(2)
        
            elseif area_coin > minArea(3) & area_coin < maxArea(3) == 1
                coin_name = name(3)
                color_coin = color_reg(3)
            
             elseif area_coin > minArea(4) & area_coin < maxArea(4) == 1
                coin_name = name(4)
                color_coin = color_reg(4)
        
            elseif area_coin > minArea(5) & area_coin < maxArea(5) == 1
                coin_name = name(5)
                color_coin = color_reg(5)
            elseif area_coin > minArea(6) & area_coin < maxArea(6) == 1 
                coin_name = name(6)
                color_coin = color_reg(6)
            else
                    break
            end



        % Detect Feature Target with SURF
        target_point = detectSURFFeatures(target);
%         figure;
%         imshow(target);
%         title('1000 Strongest Feature Points from Box Image');
%         hold on;
%         plot(selectStrongest(target_point, 1000));

        % Detect Feature Overview with SURF
        img_point = detectSURFFeatures(img_gray);
%         figure;
%         imshow(img_gray);
%         title('1000 Strongest Feature Points from Box Image');
%         hold on;
%         plot(selectStrongest(img_point, 1000));

        % from Feature detector get 'Feature' to use Feater Extraction
        
        % Feature Extraction
        [target_descripter, target_point] = extractFeatures(target, target_point);
        [img_descripter, img_point] = extractFeatures(img_gray, img_point);
        % from Feater Extraction get drescripter to matching the target

        % Pairing Object
        Pairs = matchFeatures(target_descripter, img_descripter);
        matched_target = target_point(Pairs(:, 1), :);
        matched_img = img_point(Pairs(:, 2), :);
        
        % Show matching
%         figure;
%         showMatchedFeatures(target, img_gray, matched_target , ...
%             matched_img, 'montage');
        
        % Get Geomrtric of matching
        [tform, inlierIdx] = ...
            estimateGeometricTransform2D(matched_target, matched_img, 'affine');
        
        % Get boundary to spesific position of matching
        boxPolygon = [1, 1;...                         % top-left
                size(target, 2), 1;...                 % top-right
                size(target, 2), size(target, 1);...   % bottom-right
                1, size(target, 1);...                 % bottom-left
                1, 1];                   % top-left again to close the polygon
        
        
        % Get Box polygon from taget
        newBoxPolygon = transformPointsForward(tform, boxPolygon);
        
        % Save Line of block to merge
        M{k} = newBoxPolygon;
        
        % Display each result
        f = figure;
            imshow(img);
            hold on;
            line(newBoxPolygon(:, 1), newBoxPolygon(:, 2), 'Color',  string(color_coin));
            caption = sprintf('Detected %s with %s Box', string(coin_name),string(color_coin));
            title(caption);
%             F = getframe(f)
%             RGB = frame2im(F);
      end
         
end

% Display combine of all line to results 
%          f = figure;
%             imshow(img);
%              hold on;
%              for i=1:length(M)
%               line(i(:, 1), i(:, 2), 'Color',  string(color_coin));
%              end



%% Summary
% 1. I use image segmentation and Feature Drescripter because I try to train
% model but performance is low casuse of data in training set
% 2. This method cannot use with closing coin in Group2 becasuse the
% segmentation is use for non-adjacent objects
% 3. not finish merge the result to one picture yet, so can count from
% color of box the represent each coin
% 4. This method is fast and high accuracy but hard to implement