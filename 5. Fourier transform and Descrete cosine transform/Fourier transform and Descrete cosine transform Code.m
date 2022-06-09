% Thornthan yasukam
% Assignment 4 , no4

img = imread("Picture_4.jpg");
%figure, imshow(img), title('Original image')
img = imresize(img, [256 256]); % resize

%-------------------------- fourier transform -----------------------------

% 1. H(u,v) Frequency response
[u, v] = meshgrid(-128:127,-128:127);
r_ft = sqrt(u.^2 + v.^2);
c_ft1 = (r_ft < 25.6); % cutoffs of 0.1 เท่าของภาพ 0.1*256
c_ft2 = (r_ft < 51.2); % cutoffs of 0.1 เท่าของภาพ 0.2*256
c_ft3 = (r_ft < 76.8); % cutoffs of 0.3 เท่าของภาพ 0.3*256

% 2.transform
ft = fft2(img); % transform
ft_shift = fftshift(ft); % shift
% figure, fftshow(ft_shift, 'log'); title('output fourier tranform');

% 3.multiple with Frequency response
ft_shift_with_c_ft1 = ft_shift.*c_ft1;
ft_shift_with_c_ft2 = ft_shift.*c_ft2;
ft_shift_with_c_ft3 = ft_shift.*c_ft3;

% 4.inverse tranform
inverse_ft1 = ifft2(ft_shift_with_c_ft1); 
inverse_ft2 = ifft2(ft_shift_with_c_ft2); 
inverse_ft3 = ifft2(ft_shift_with_c_ft3); 

%--------------------------------------------------------------------------

%-------------------------- cosine transform ------------------------------

% 1. H(u,v) Frequency response
[u, v] = meshgrid(0:255,0:255); % แก้ mesh grid
r_dct = sqrt(u.^2 + v.^2);
c_dct1 = (r_dct < 25.6); % cutoffs of 0.1 เท่าของภาพ 0.1*256
c_dct2 = (r_dct < 51.2); % cutoffs of 0.1 เท่าของภาพ 0.2*256
c_dct3 = (r_dct< 76.8); % cutoffs of 0.3 เท่าของภาพ 0.3*256

% 2.transform
dct = dct2(img); % transform
% figure, fftshow(dct, 'log'); title('output cosine transform ');

% 3.multiple with Frequency response
dct_with_c_dct1 = dct.*c_dct1;
dct_with_c_dct2 = dct.*c_dct2;
dct_with_c_dct3 = dct.*c_dct3;

% 4.inverse tranform
inverse_dct1 = idct2(dct_with_c_dct1); 
inverse_dct2 = idct2(dct_with_c_dct2); 
inverse_dct3 = idct2(dct_with_c_dct3); 

%--------------------------------------------------------------------------

subplot(2,3,1), fftshow(inverse_ft1, 'abs'); title('ft inverse tranform r < 0.1');
subplot(2,3,2), fftshow(inverse_ft2, 'abs'); title('ft inverse tranform r < 0.2');
subplot(2,3,3), fftshow(inverse_ft3, 'abs'); title('ft inverse tranform r < 0.3');
subplot(2,3,4), fftshow(inverse_dct1, 'abs'); title('dct inverse tranform r < 0.1');
subplot(2,3,5), fftshow(inverse_dct2, 'abs'); title('dct inverse tranform r < 0.2');
subplot(2,3,6), fftshow(inverse_dct3, 'abs'); title('dct inverse tranform r < 0.3');

%--------------------------------------------------------------------------
% function fftshow
function fftshow(f,type)
% from:https://ww2.mathworks.cn/matlabcentral/fileexchange/30947-gaussian-bandpass-filter-for-image-processing
% Usage: FFTSHOW(F,TYPE)
%
% Displays the fft matrix F using imshow, where TYPE must be one of
% 'abs' or 'log'. If TYPE='abs', then then abs(f) is displayed; if
% TYPE='log' then log(1+abs(f)) is displayed. If TYPE is omitted, then
% 'log' is chosen as a default.
%
% Example:
% c=imread('cameraman.tif');
% cf=fftshift(fft2(c));
% fftshow(cf,'abs')
%
if nargin<2,
    type='log';
end
if (type=='log')
    fl = log(1+abs(f));
    fm = max(fl(:));
    imshow(im2uint8(fl/fm))
elseif (type=='abs')
    fa=abs(f);
    fm=max(fa(:));
    imshow(fa/fm)
else
    error('TYPE must be abs or log.');
end
end
% -------------------------------------------------------------------------


