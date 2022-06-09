% Thornthan yasukam
% Assignment 4 , no2

% 1.input
img = imread("Picture_2.gif");
figure, imshow(img), title('Original image')

% 2.mask

% 2.1 Laplacian mask
Wa = [0 1 0; 1 2 1; 0 1 0]
Wa = Wa/6

Wa_test = [0 1 0; 1 10 1; 0 1 0]
Wa_test = Wa_test/6

% 2.2 sobel
Wb = [-1 0 1; -2 0 2; -1 0 1]

% 2.3 Laplacian mask
Wc = [0 1 0; 1 -4 1; 0 1 0]

% 3.output
out_Wa = imfilter(img, Wa, 'conv');
out_Wb = imfilter(img, Wb, 'conv');
out_Wc = imfilter(img, Wc, 'conv');

out_Wa_test = imfilter(img, Wa_test, 'conv');
figure, imshow(out_Wa_test), title('test ouput if middle is 10')

% display result
subplot(1,4,1), imshow(img), title('Original image')
subplot(1,4,2), imshow(out_Wa), title('Output of Wa')
subplot(1,4,3), imshow(out_Wb), title('Output of Wb')
subplot(1,4,4), imshow(out_Wc), title('Output of Wc')





