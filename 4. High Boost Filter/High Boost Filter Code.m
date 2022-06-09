% Thornthan yasukam
% Assignment 4 , no3

% 1.input
img = imread("Picture_3.png");
figure, imshow(img), title('Original image')

% 2.mask
h = ones(3)/9

% 3. g(x,y) = f(x,y) + k(fhp) ; fhp = f(x,y) - (low-pass of f(x,y))
lp = imfilter(img,h,'conv')
hp = img - lp

% display result
k=[0 1 5 10 20];

for r=1:length(k)
    output = img + ( r * hp)
    figure, imshow(output);title('Unsharp masking and high-boost filtering');xlabel('k = '),xlabel(k(r));
end