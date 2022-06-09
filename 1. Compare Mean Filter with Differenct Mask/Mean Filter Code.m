% original image
img = imread('picture1.jpg')

% mask 3x3
h1 = ones(3)/9

% mask 5x5
h2 = ones(5)/25

% convolution filter 3x3
out_round1 = imfilter(img,h1,'conv')
out1 = imfilter(out_round1,h1,'conv')

% convolution filter 5x5
out2 = imfilter(img,h2,'conv')

% plot
subplot(1,3,1), imshow(img), title('Original Image')
subplot(1,3,2), imshow(out_round1), title('Image filter 3x3, repeated 1 times')
%subplot(1,3,2), imshow(out1), title('Image filter 3x3, repeated 2 times')
subplot(1,3,3), imshow(out2), title('Image filter 5x5')