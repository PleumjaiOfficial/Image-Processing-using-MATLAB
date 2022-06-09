% original image
img = imread('picture2.png')
img = rgb2gray(img)

% create mask 3x3 
%Ref : https://www.imageeprocessing.com/2014/04/gaussian-filter-without-using-matlab.html

%{ 
    all contants should to 3x3 matrix before use operation 
    mask = [ 1 1 1
             1 1 1
             1 1 1 ]

    power_exp = [ ? ? ?
                  ? ? ?
                  ? ? ? ]

     two_pi_sigma = [ ? ? ?
                      ? ? ?
                      ? ? ? ]

%}    

% constants
sigma = 0.6
two_pi_sigmal_formula = 1/(2 * pi * sigma * sigma)

% martrix 3x3 of each elemant to create mask 
mask = ones(3)
power_exp = ones(3)
two_pi_sigmal = ones(3) * two_pi_sigmal_formula

x = [ -1 0 1
      -1 0 1
      -1 0 1 ]

y = [ -1 -1 -1
       0  0  0
       1  1  1 ]

for i = 1:9
    % calculate distance of each pixel from the center pixel
    power_exp(i) = -( x(i)^2 + y(i)^2 ) / ( 2 * (sigma * sigma) )

    % new mask with gaussian formular
    mask(i) = two_pi_sigmal(i) * exp(power_exp(i))
end

% convolution mean filter
% mask for mean filter
h = ones(3)/9
out1 = imfilter(img,h,'conv')

% convolution Gaussian filter
out2 = imfilter(img,mask,'conv')

% plot
subplot(1,3,1), imshow(img), title('Original image')
subplot(1,3,2), imshow(out1), title('Mean filter')
subplot(1,3,3), imshow(out2), title('Gaussian filter')

