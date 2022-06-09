% Assignment7, No.2 
% Thornthan Yasukam 62070501030

% Input image 
img = imread('bag.png');
figure, imshow(img), title('Original image')

% Step 1:  img -> Gray -> binary
% help(im2bw)
B = im2bw(img, graythresh(img))
figure, imshow(B), title('Binary image')

% Step 2: Invert or Complement to switch black and white
B = ~B;
figure, imshow(B), title('imcomplement Binary image')

% Step 3: Clean noise in circle object with opening and closing 

% Step3.1 : Create strucing image
% help(strel)
struc_img = strel('disk', 2, 0);

% Step3.2 : Using Opening and Closing
% Opening use to clear noise
% Closing use to fill hole
B2 = imopen(B, struc_img)
figure, imshow(B2), title('Clear noise with opening')
B3 = imclose(B2, struc_img)
figure, imshow(B3), title('Fill hole with closing')

% Step3.3 : connected component labeling with bwlabel
% help("bwlabel")
 % https://www.mathworks.com/help/images/ref/bwlabel.html 
[label, num] = bwlabel(B3);
% n is number of shape similary sturing image
% print (n)

% Step4 : Convert label that have shape like sturing image to RGB
RGB = label2rgb(label)
figure, imshow(RGB), title('Indicates a different label of a foreground object')

% Output 
subplot(3,3,1), imshow(img), title('Original image')
subplot(3,3,2), imshow(B), title('Binary image')
subplot(3,3,3), imshow(B), title('imcomplement Binary image')
subplot(3,3,4), imshow(B2), title('Clear noise with opening')
subplot(3,3,5), imshow(B3), title('Fill hole with closing')
subplot(3,3,6), imshow(RGB), title('Indicates a different label of a foreground object')








