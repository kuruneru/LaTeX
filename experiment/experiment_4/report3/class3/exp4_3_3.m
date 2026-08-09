clear;

% 課題1 %
img = imread("kut.jpg");

red_gray = img(:,:,1);
green_gray = img(:,:,2);
blue_gray = img(:,:,3);

figure(1)
subplot(2,2,1);
imshow(uint8(red_gray));
title("赤色チャネル");
subplot(2,2,2);
imshow(uint8(green_gray));
title("緑色チャネル");
subplot(2,2,3);
imshow(uint8(blue_gray));
title("青色チャネル");

[height, width, ch] = size(img);
img_exchange_red_and_blue = zeros(height, width, ch);
img_exchange_red_and_blue(:,:,1) = img(:,:,3);
img_exchange_red_and_blue(:,:,2) = img(:,:,2);
img_exchange_red_and_blue(:,:,3) = img(:,:,1);

subplot(2,2,4);
imshow(uint8(img_exchange_red_and_blue));
title("赤色チャネルと青色チャネル入れ替え");


% 課題2 %
gimg = 0.3 * double(img(:,:,1)) + 0.59 * double(img(:,:,2)) + 0.11 * double(img(:,:,3));

bit8_gimg = uint8(gimg);
bit4_gimg = bitshift(uint8(gimg), -4);
bit2_gimg = bitshift(uint8(gimg), -6);
bit1_gimg = bitshift(uint8(gimg), -7);

figure(2)
subplot(2,2,1);
imshow(bit8_gimg, [0, 255]);
title("8bit");
subplot(2,2,2);
imshow(bit4_gimg, [0, 15]);
title("4bit");
subplot(2,2,3);
imshow(bit2_gimg, [0, 3]);
title("2bit");
subplot(2,2,4);
imshow(bit1_gimg, [0, 1]);
title("1bit");

imwrite(uint8(bit8_gimg), "kut_bit8.png");
imwrite(uint8(bit4_gimg * (255 / 15)), "kut_bit4.png");
imwrite(uint8(bit2_gimg * (255 / 3)), "kut_bit2.png");
imwrite(uint8(bit1_gimg * (255 / 1)), "kut_bit1.png");


% 課題3 %
neg_bit8_gimg = 255 - bit8_gimg;
neg_bit4_gimg = 15 - bit4_gimg;
neg_bit2_gimg = 3 - bit2_gimg;
neg_bit1_gimg = 1 - bit1_gimg;

figure(3)
subplot(2,2,1);
imshow(neg_bit8_gimg, [0, 255]);
title("階調反転 8bit");
subplot(2,2,2);
imshow(neg_bit4_gimg, [0, 15]);
title("階調反転 4bit");
subplot(2,2,3);
imshow(neg_bit2_gimg, [0, 3]);
title("階調反転 2bit");
subplot(2,2,4);
imshow(neg_bit1_gimg, [0, 1]);
title("階調反転 1bit");

imwrite(uint8(neg_bit8_gimg), "kut_neg_bit8.png");
imwrite(uint8(neg_bit4_gimg * (255 / 15)), "kut_neg_bit4.png");
imwrite(uint8(neg_bit2_gimg * (255 / 3)), "kut_neg_bit2.png");
imwrite(uint8(neg_bit1_gimg * (255 / 1)), "kut_neg_bit1.png");


% 課題4 %
thr100 = uint8(gimg >= 100);
thr127 = uint8(gimg >= 127);
thr200 = uint8(gimg >= 200);

gimg100 = thr100 * 255;
gimg127 = thr127 * 255;
gimg200 = thr200 * 255;

figure(4)
subplot(2,2,1);
imshow(uint8(gimg));
title("元画像(グレースケール)");
subplot(2,2,2);
imshow(gimg100);
title("閾値100");
subplot(2,2,3);
imshow(gimg127);
title("閾値127");
subplot(2,2,4);
imshow(gimg200);
title("閾値200");


% 課題5 %
inhist = zeros(1,256);
for k = 0:255
    inhist(1, k+1) = sum(sum(uint8(gimg) == k));
end

figure(5)
plot((0:255), inhist);
axis([0 255 0 7000]);
xlabel('Pixel value');
ylabel('Number of pixel');
title('Histgram');


% 課題6 %
pre_img = imread('prepicture2.jpg');
post_img = imread('postpicture2.jpg');

pre_gray = uint8(0.3 * double(pre_img(:,:,1)) + 0.59 * double(pre_img(:,:,2)) + 0.11 * double(pre_img(:,:,3)));
post_gray = uint8(0.3 * double(post_img(:,:,1)) + 0.59 * double(post_img(:,:,2)) + 0.11 * double(post_img(:,:,3)));

sub_img = abs(double(pre_gray) - double(post_gray));

figure(6)
imshow(uint8(sub_img));
title("背景差分");
imwrite(uint8(sub_img), 'difference.png');