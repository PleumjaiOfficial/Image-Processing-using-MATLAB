% Assignment 9
% Thornthan yasukam 62070501030

img = imread("A.gif");
imshow(img,[])

% Fourier descriptor of image 'A'
% Pre-processing state :
%   1. Get data on region, pixel = 1 (Axe object) by function 'find'; 
%   2. Get list of boudary to assume to contour of shape by function 'bwtraceboundary'; 
%   3. From graph in assignment sampling ~64 pixel and sampling get data with new scale
%       64 pixel should to increate 1 step
%       if 'all pixel in list' should to increate => ('all pixel in list' * 1) / 64
% Processing state :
%   1. Loop 64 round for get complex number
%   2. use function 'fft' for Fourier transform.
%   3. Normalization by dividing maximum fft value that is first value of
%   output fft but in assignment set origin at first value to 0 and Normalization 
%   by next maximum fft value that is second value


% Pre-processing state
[row col] = find(img == 1) % help('find')

frist_row = row(1)
first_col = col(1)
N = 64
count = 1

List_pixel = bwtraceboundary(img, [frist_row, first_col],'N') % 'N' intital search direction is North
% Ref: https://www.mathworks.com/help/images/ref/bwtraceboundary.html#d123e42015

scale_shift = length(List_pixel)/N; % new scale cause sampling


% Processing state
for k=1:N

    % complex number (x + jy)
    b(k) = List_pixel(round(count),2) + j*List_pixel(round(count),1)

    % assignment samping to 64 so increat count by scale_shift
    % count = count + 1 % using when sampling first 64 pixel
    count = count + scale_shift
end

% Normalization
Av = fft(b)
% Av = Av/ abs(Av(1))
Av(1) = 0; % Set origin is 0
Av = Av/abs(Av(2)) % Scale with maximum fourier descripter

% -------------------------------------------------------------------------

% Fourier descriptor of image 'B'
% implement with A process but adding resize and rotage in Pre-processing state
% More Pre-processing state for image 'B' :
%   1. Resize A with function 'imresize'
%   2. Rotage A with function 'imrotate'

% Pre-processing state
% help('imresize')
% https://www.mathworks.com/help/matlab/ref/imresize.html
scale = 1/1.4
J = imresize(img,scale);

% help('imrotate')
% https://www.mathworks.com/help/images/ref/imrotate.html
angle = -40
J_ro = imrotate(J, angle)
figure, imshow(J_ro, [])

[row_ro col_ro] = find(J_ro == 1)

frist_row_ro = row_ro(1)
first_col_ro = col_ro(1)
N = 64
count = 1

List_pixel_ro = bwtraceboundary(J_ro, [frist_row_ro, first_col_ro],'N') 
scale_shift_ro = length(List_pixel_ro)/N;


% Processing state
for k=1:N
    % complex number (x + jy)
    b_ro(k) = List_pixel_ro(round(count),2) + j*List_pixel_ro(round(count),1)

    % subsample to 64 so count pixel  
    count = count + scale_shift_ro
end

% Normalization
Av_ro = fft(b_ro)
% Av_ro = Av_ro/ abs(Av_ro(1))
Av_ro(1) = 0; % Set origin is 0
Av_ro = Av_ro/abs(Av_ro(2)) % Scale with maximum fourier descripter

% -------------------------------------------------------------------------
% Fourier descriptor of image 'C'

img2 = imread("C.gif");
imshow(img2,[])

[row2 col2] = find(img2 == 1)
frist_row2 = row2(1)
first_col2 = col2(1)
N = 64
count = 1

List_pixel2 = bwtraceboundary(img2, [frist_row2, first_col2],'N') % 'N' intital search direction is North

% new scale cause sampling
scale_shift2 = length(List_pixel2)/N;

% complex number format
for k=1:N
    % complex number (x + jy)
    b2(k) = List_pixel2(round(count),2) + j*List_pixel2(round(count),1)
    % count = count + 1
    count = count + scale_shift2
end

Av2 = fft(b2)
% Av = Av/ abs(Av(1))
Av2(1) = 0; % Set origin is 0
Av2 = Av2/abs(Av2(2)) % Scale with maximum fourier descripter

% -------------------------------------------------------------------------
% Plot graph

figure, plot(1:64, abs(Av), 1:64, abs(Av_ro)), title('Fourier descriptor of A and B')
legend('A','A Rotage')
figure, plot(1:64, abs(Av), 1:64, abs(Av2)), title('Fourier descriptor of A and C')
legend('A','C')

