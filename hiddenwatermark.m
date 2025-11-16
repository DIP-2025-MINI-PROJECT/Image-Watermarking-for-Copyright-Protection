%% extract_invisible_hybrid.m
% Extraction of Invisible DWT LL-band Watermark + Validity Metrics

clc; clear; close all;

%% PARAMETERS (must match embedding script)
hostFile = 'italy_background.jpg';
wmFile   = 'watermarked_hybrid.png';   % change to attacked image if needed
logoFile = 'batman.png';
wavelet  = 'haar';
alphaInv = 0.02;                        % must match embedding strength

%% -----------------------------------------
%% STEP 1 — READ IMAGES
%% -----------------------------------------
hostRGB = im2double(imread(hostFile));
wmRGB   = im2double(imread(wmFile));
wmLogo  = im2double(imread(logoFile));    % renamed from "logo" to avoid conflict!

%% Convert host & watermarked images to YCbCr
hostYCbCr = rgb2ycbcr(hostRGB);
wmYCbCr   = rgb2ycbcr(wmRGB);

% Extract Y (luminance) channel where invisible watermark lives
Y_host = hostYCbCr(:,:,1);
Y_wm   = wmYCbCr(:,:,1);

%% -----------------------------------------
%% STEP 2 — APPLY DWT TO BOTH IMAGES
%% -----------------------------------------
[LL_host, ~, ~, ~] = dwt2(Y_host, wavelet);
[LL_wm,   ~, ~, ~] = dwt2(Y_wm,   wavelet);

%% -----------------------------------------
%% STEP 3 — RECOVER INVISIBLE WATERMARK
%% -----------------------------------------
Wrec = (LL_wm - LL_host) / alphaInv;
Wrec = mat2gray(Wrec);             % normalize for visibility

%% Display extracted watermark
figure('Name','Recovered Invisible Watermark','Position',[300 200 500 400]);
imshow(Wrec, []);
title('Recovered Invisible Watermark (LL band difference)');

%% -----------------------------------------
%% STEP 4 — VALIDITY / ACCURACY METRICS
%% -----------------------------------------

% Construct original invisible watermark
origW_raw = rgb2gray(wmLogo);
origW = imresize(origW_raw > 0.5, size(Wrec));
origW = im2double(origW);

% --- MSE ---
mse_val = immse(Wrec, origW);

% --- PSNR ---
psnr_val = psnr(Wrec, origW);

% --- NCC (Normalized Cross Correlation) ---
num = sum(sum(Wrec .* origW));
den = sqrt(sum(sum(Wrec.^2))) * sqrt(sum(sum(origW.^2)));
ncc_val = num / den;

%% Print validity results
fprintf('\n================ WATERMARK VALIDITY METRICS ================\n');
fprintf('MSE  = %.6f  (lower is better)\n', mse_val);
fprintf('PSNR = %.2f dB  (higher is better)\n', psnr_val);
fprintf('NCC  = %.4f  (1.0 = perfect match)\n', ncc_val);
fprintf('============================================================\n\n');
