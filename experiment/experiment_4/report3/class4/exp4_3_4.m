%% 課題1
clear;
img = imread("kut.jpg");
gray = 0.3*double(img(:,:,1)) + 0.59*double(img(:,:,2)) + 0.11*double(img(:,:,3));
gray = uint8(gray);
[height, width] = size(gray);

rd_impluse = rand(height, width);
img_impluse = gray;
img_impluse(rd_impluse <= 0.01) = 0;
img_impluse(rd_impluse >= 0.99) = 255;

img_gauss = uint8(double(gray) + 10 * randn(height, width));

figure(1);
imshow(gray); title('Original Grayscale');
figure(2);
imshow(img_impluse); title('Impulse Noise');
figure(3);
imshow(img_gauss); title('Gaussian Noise');

%% 課題2
smoothing_fil = ones(3) / 9;
img_impulse_smoothed = uint8(filter2(smoothing_fil, double(img_impluse), "same"));
img_gauss_smoothed = uint8(filter2(smoothing_fil, double(img_gauss), "same"));

img_impulse_padded = zeros(height+2, width+2);
img_gauss_padded = zeros(height+2, width+2);
img_impulse_padded(2:height+1, 2:width+1) = double(img_impluse(1:height, 1:width));
img_gauss_padded(2:height+1, 2:width+1) = double(img_gauss(1:height, 1:width));

img_impulse_median = zeros(height, width);
img_gauss_median = zeros(height, width);

for h = 1:height
    for w = 1:width
        img_impulse_median(h,w) = median(img_impulse_padded(h:h+2, w:w+2), "all");
        img_gauss_median(h,w) = median(img_gauss_padded(h:h+2, w:w+2), "all");
    end
end

figure(4);
imshow(img_impulse_smoothed); title('Impulse Smoothed');
figure(5);
imshow(img_gauss_smoothed); title('Gauss Smoothed');
figure(6);
imshow(uint8(img_impulse_median)); title('Impulse Median');
figure(7);
imshow(uint8(img_gauss_median)); title('Gauss Median');

%% 課題3
sobel_h = [-1 0 1; -2 0 2; -1 0 1];
sobel_v = [-1 -2 -1; 0 0 0; 1 2 1];

img_sobel_h = filter2(sobel_h, double(gray), "same");
img_sobel_v = filter2(sobel_v, double(gray), "same");

img_sobel_h_norm = 255 * abs(img_sobel_h) / max(abs(img_sobel_h(:)));
img_sobel_v_norm = 255 * abs(img_sobel_v) / max(abs(img_sobel_v(:)));

figure(8);
subplot(1,2,1); imshow(uint8(img_sobel_h_norm)); title('Sobel H');
subplot(1,2,2); imshow(uint8(img_sobel_v_norm)); title('Sobel V');

%% 課題4
lap_fil = [1 1 1; 1 -8 1; 1 1 1];
gray_lap = filter2(lap_fil, double(gray), "same");

img_gray_lap_norm = 255 * abs(gray_lap) / max(abs(gray_lap(:)));

low_thr = prctile(img_gray_lap_norm, 5, "all");
high_thr = prctile(img_gray_lap_norm, 95, "all");

mask_low = img_gray_lap_norm <= low_thr;
mask_high = img_gray_lap_norm >= high_thr;
mask_mid = ~mask_low & ~mask_high;

img_gray_lap_norm_thr = zeros(height, width);
img_gray_lap_norm_thr(mask_high) = 255;
img_gray_lap_norm_thr(mask_mid) = 255 * (img_gray_lap_norm(mask_mid) - low_thr) / (high_thr - low_thr);

figure(9);
subplot(2,2,1); 
imshow(uint8(img_gray_lap_norm)); 
title('Laplacian Norm');

subplot(2,2,2); 
imshow(uint8(img_gray_lap_norm_thr)); 
title('Laplacian Threshold');

subplot(2,2,3); 
histogram(img_gray_lap_norm, 256); 
axis([0 255 0 150000]); 
xlabel('pixel value'); 
ylabel('number of pixels');
title('Histogram');

%% 課題5
clear;
img = imread("so_takahashi.jpg");
img_hsv = rgb2hsv(img);

skin_mask = (img_hsv(:,:,1) >= 0.022) & (img_hsv(:,:,1) <= 0.087) & ...
            (img_hsv(:,:,2) >= 0.301) & (img_hsv(:,:,2) <= 1.000) & ...
            (img_hsv(:,:,3) >= 0.283) & (img_hsv(:,:,3) <= 0.937);

img_out = hsv2rgb(img_hsv .* skin_mask);

figure(10);
imshow(img_out); title('Skin Detection');