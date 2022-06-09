% Thornthan yasukam
% Assignment 4 , no5

%--------------------------------------------------------------------------
% input
img = rgb2gray(imread("Picture_5.jpg"));
figure, imshow(img), title('Original image')
img = imresize(img, [256 256]); % resize
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
% H(u,v) Frequency response
[u, v] = meshgrid(-128:127,-128:127);
r = sqrt(u.^2 + v.^2);
c_low = (r<100); % Low pass
c_high = (r>100); % High pass
%--------------------------------------------------------------------------


%------------------------------- low-pass ---------------------------------
% fourier tranform and shift
ft = fftshift(fft2(img)); 
% figure, fftshow(ft, 'log'); title('fourier tranform');

% low-pass
ft_low = ft.*c_low; 
% figure, fftshow(ft_low, 'log'); title('fourier tranform with low pass ');

% Inverse tranform low pass 
ift_low = ifft2(ft_low); 
% figure, fftshow(ift_low, 'abs'); title('Low pass');
%--------------------------------------------------------------------------


%------------------------ low-pass then high pass -------------------------
% fourier tranform and shift
ft_ift_low = fft2(ift_low); % without shift
% figure, fftshow(ft_ift_low, 'log'); title('fourier tranform of low-pass');

% low-pass then high pass
ft_low_then_high = ft_ift_low.*c_high;
% figure, fftshow(ft_low_then_high, 'log'); title('fourier tranform with low pass and then high pass');

% Inverse tranform low and then high
ift_low_high = ifft2(ft_low_then_high); 
% figure, fftshow(ift_low_high, 'abs'); title('inverse tranform low and then high');
%--------------------------------------------------------------------------


%----------------------------- high-pass ----------------------------------
% fourier tranform and shift
ft2 = fftshift(fft2(img)); 
% figure, fftshow(ft2, 'log'); title('fourier tranform');

% high-pass
ft_high = ft2.*c_high; 
% figure, fftshow(ft_high, 'log'); title('fourier tranform with high pass');

% Inverse tranform high-pass
ift_high = ifft2(ft_high); 
% figure, fftshow(ift_high, 'abs'); title('High pass');
%--------------------------------------------------------------------------

%--------------------- high pass then low pass ----------------------------
% fourier tranform and shift
ft_ift_high = fft2(ift_high); % without shift
% figure, fftshow(ft_ift_high, 'log'); title('fourier tranform of high-pass');

% high pass then low-pass
ft_high_then_low = ft_ift_high.*c_low;
% figure, fftshow(ft_high_then_low, 'log'); title('fourier tranform with high pass and then low pass');

% Inverse tranform low and then high
ift_high_then_low  = ifft2(ft_high_then_low); 
% figure, fftshow(ift_high_then_low, 'abs'); title('inverse tranform high and then low');
%--------------------------------------------------------------------------

%------------------------------ Display -----------------------------------
subplot(4,3,1), fftshow(ft, 'log'); title('fourier tranform');
subplot(4,3,2), fftshow(ft_low, 'log'); title('fourier tranform with low pass ');
subplot(4,3,3), fftshow(ift_low, 'abs'); title('Low pass');
subplot(4,3,4), fftshow(ft_ift_low, 'log'); title('fourier tranform of low-pass');
subplot(4,3,5), fftshow(ft_low_then_high, 'log'); title('fourier tranform with low pass and then high pass');
subplot(4,3,6), fftshow(ift_low_high, 'abs'); title('inverse tranform low and then high');

subplot(4,3,7), fftshow(ft2, 'log'); title('fourier tranform');
subplot(4,3,8), fftshow(ft_high, 'log'); title('fourier tranform with high pass');
subplot(4,3,9), fftshow(ift_high, 'abs'); title('High pass');
subplot(4,3,10), fftshow(ft_ift_high, 'log'); title('fourier tranform of high-pass');
subplot(4,3,11), fftshow(ft_high_then_low, 'log'); title('fourier tranform with high pass and then low pass');
subplot(4,3,12), fftshow(ift_high_then_low, 'abs'); title('inverse tranform high and then low');
%--------------------------------------------------------------------------

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