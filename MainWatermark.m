% Visible + Invisible Hybrid DWT Watermarking
clc; clear; close all;
%% Parameters
hostFile = 'italy_background.jpg';
logoFile = 'batman.png';
wavelet  = 'haar';
scaleVisible = 0.25;
opacity      = 0.85;
alphaInv = 0.02;
outFile  = 'watermarked_hybrid.png';
%% Read host image 
hostRGB = im2double(imread(hostFile));
[H, W, ~] = size(hostRGB);
%% Convert to YCbCr (so invisible watermark only affects brightness)
hostYCbCr = rgb2ycbcr(hostRGB);
Y  = hostYCbCr(:,:,1);
Cb = hostYCbCr(:,:,2);
Cr = hostYCbCr(:,:,3);
%% Read logo
[logo, ~, alpha] = imread(logoFile);
logo = im2double(logo);
if size(logo,3)==1, logo = repmat(logo,[1 1 3]); end
if isempty(alpha)
   alpha = 1 - mat2gray(rgb2gray(logo));
end
alpha = im2double(alpha);
%% Resize visible watermark
minDim = min(H,W);
target = round(scaleVisible * minDim);
[lh, lw, ~] = size(logo);
if lh > lw
   newH = target; newW = round(lw*(newH/lh));
else
   newW = target; newH = round(lh*(newW/lw));
end
logoR  = imresize(logo,[newH newW]);
alphaR = imresize(alpha,[newH newW]);
%% Invisible watermark: DWT ONLY ON Y CHANNEL
[LL, LH, HL, HH] = dwt2(Y, wavelet);
invW_raw = rgb2gray(logo);
invW = imresize(invW_raw > 0.5, size(LL));
invW = im2double(invW);
LL_new = LL + alphaInv * invW;
Y_new = idwt2(LL_new, LH, HL, HH, wavelet);
Y_new = imresize(Y_new, [H W]);
Y_new = min(max(Y_new,0),1);
%% Replace Y only, keep color channels
hostYCbCr_new = cat(3, Y_new, Cb, Cr);
baseRGB = ycbcr2rgb(hostYCbCr_new);
baseRGB = min(max(baseRGB,0),1);
%% Add sharp visible watermark
x1 = W - newW - 15;
y1 = H - newH - 15;
visibleRegion = baseRGB(y1:y1+newH-1, x1:x1+newW-1, :);
alphaMask = repmat(alphaR * opacity, [1 1 3]);
visibleRegion = visibleRegion .* (1 - alphaMask) + logoR .* alphaMask;
watermarked = baseRGB;
watermarked(y1:y1+newH-1, x1:x1+newW-1, :) = visibleRegion;
imwrite(watermarked, outFile);
%% Display main output
figure('Position',[100 100 1300 420]);
subplot(1,3,1); imshow(hostRGB);     title('Original Image');
subplot(1,3,2); imshow(logoR);       title('Visible Watermark');
subplot(1,3,3); imshow(watermarked); title('Hybrid Watermarked Image');
%% Robustness Tests
noisy = imnoise(watermarked, 'gaussian', 0, 0.002);
imwrite(watermarked,'temp_q60.jpg','Quality',60);
compressed = imread('temp_q60.jpg');
cropRect = [1 1 floor(0.9*W) floor(0.9*H)];  % crop only 10%
cropped = imcrop(watermarked, cropRect);
figure('Position',[100 100 1300 420]);
subplot(1,3,1); imshow(noisy);      title('Gaussian Noise Attack');
subplot(1,3,2); imshow(compressed); title('JPEG Compression (Q=60)');
subplot(1,3,3); imshow(cropped);    title('Cropping Attack (10%)');