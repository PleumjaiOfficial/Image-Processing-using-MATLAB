% Assignment 10
% 62070501030, Thornthan yasukam

% Input image
img = rgb2gray(imread("chessboard.png"))
figure, imshow(img), title('original image')
% img_double =im2double(img)
% figure ,imshow(img_double), title("Image double value")


%% Step 1. Compute horizontal (x) and Vertical (y) derivatives of image
    % Step 1.1: Applying the image derivatives
    % Step 1.2: Compute the image derivatives Ix and Iy
    % Step 1.3: Generate Gaussian filter 'g' of size 9x9 and standard deviation Sigma=2.
    % Step 1.4 Obtain Ix2, Iy2 and IxIy to image derivatives

% Step 1.1
dx = [-1 0 1;
      -1 0 1;
      -1 0 1] % applying image derivatives in the horizontal direction

% Row to Column, Column to Row
dy = [-1 -1 -1;
       0 0 0;
       1 1 1] % applying image derivatives in the vertical direction

% Step 1.2
Ix = filter2(dx,img);
% Ix
Iy = filter2(dy,img);
% Iy

% Step 1.3
h = fspecial('gaussian',[9 9],2);

% Step 1.4
IxIx = Ix.^2; % IxIx
IyIy= Iy.^2; % IyIy
IxIy = Ix.*Iy; % IxIy

IxIx = filter2(h,IxIx);
figure, imshow(IxIx), title('IxIx')

IyIy = filter2(h,IyIy);
figure, imshow(IyIy), title('IyIy')

IxIy = filter2(h,IxIy);
figure, imshow(IxIy), title('IxIy')

%% Step 2. Find Eigen Value in matrix for Scalar cornerness value (R)
[height width]=size(img);
K = 0.01
Rmax = 0

for i = 1:height
    for j = 1:width
        M = [IxIx(i,j) IxIy(i,j); IxIy(i,j) IyIy(i,j)]; 
        % Find Eigen value of Matrix
        EigenValue = eig(M)
        lamda1 = EigenValue(1,1)
        lamda2 = EigenValue(2,1)
        % R(i,j) = det(M)-0.01*(trace(M))^2;
        R(i,j) = (lamda1*lamda2)- K*(lamda1 + lamda2)^2;
        % Keep R max for comparison
        if R(i,j) > Rmax
            Rmax = R(i,j);
        end
    end
end
%% Step 3. Comparison R to keep the result
result = zeros(height,width)
count_point = 0

for i = 2:height-1 % Index must not exceed 221.
    for j = 2:width-1 % Index must not exceed 229.
        if R(i,j) > 0.1*Rmax && R(i,j) > R(i-1,j-1) && R(i,j) > R(i-1,j) && R(i,j) > R(i-1,j+1) && R(i,j) > R(i,j-1) && R(i,j) > R(i,j+1) && R(i,j) > R(i+1,j-1) && R(i,j) > R(i+1,j) && R(i,j) > R(i+1,j+1)
            result(i,j) = 1;
            count_point = count_point + 1
        end
    end
end

%% Step 4. Display Result
[mark_x, mark_y] = find(result == 1);

% background with original image
figure, imshow(img), title("Result of Harris Corner");
hold on;
% mark the bourdary
for i=1:count_point
 	plot(mark_x(i), mark_y(i), 'r*')
end  

%% End
