% Quiz 4
% 62070501030, Thornthan yasukam

%% Input image

img = imread("p1.jpg")
img = rgb2gray(img)
figure, imshow(img);

%% Pre-processing state
B = im2bw(img)
B = ~B
figure, imshow(B);

% morphological
struc_img = strel('disk', 8, 0);
C = imclose(B, struc_img)
%C = imfill(B,'holes');
figure, imshow(C);

%% get each coin
label = bwlabel(C);
figure, imshow(label);

% count coin
num_coin = max(max(label))
% display each coin
for k=1:num_coin
    coin = (label == k);
    figure, imshow(coin);
end

%%
% Like region prop but heavy load
for j=1:1
[row, col] = find(label == j)
% Get maximum of row and column
% Can solve problem object is nearly???
len = max(row) - min(row) + 2
breadth = max(col) - min(col) + 2
target = uint8(zeros([len breadth]))
sy = min(col) - 1
sx = min(row) - 1

frist_row = row(1)
for i = 1:size(row, 1)
    x = row(i,1) - sx
    y = col(i,1) - sy
    target(x,y) = img(row(i,1), col(i,1))
end

title = strcat('Object Number:',num2str(i))
figure, imshow(target), title(title);
end







