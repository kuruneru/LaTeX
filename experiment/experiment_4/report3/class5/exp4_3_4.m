clear;
h = 256;
w = 256;

%% 課題1 %%
f = [4, 16, 64];
lim_vals = [10, 30, 80];
for f_len = 1:length(f)
    n = 1;
    
    for l = 1:h
        for k = 1:w
            img(l, k) = 1 + sin(2 * pi * f(f_len) * (k-1) / w);
        end
    end
    
    fft_image = fft2(double(img));
    fft_shift_image = fftshift(fft_image);
    fft_shift_abs = abs(fft_shift_image);
    ps = power(fft_shift_abs, 2);
    
    figure(f_len);
    subplot(2,2,1);
    colormap('gray');
    imagesc(img);
    title(['Image (Vertical, f=', num2str(f(f_len)), ')']);
 
    subplot(2,2,2);
    x = [-128:127];
    y = [-128:127];
    colormap('gray');
    imagesc(x, y, ps);
    title('Power Spectrum');
    
    subplot(2,2,3);
    x_low = [-128:127];
    y_low = [-128:127];
    colormap('gray');
    imagesc(x_low, y_low, ps);
    xlim([-lim_vals(f_len),lim_vals(f_len)]);
    ylim([-lim_vals(f_len),lim_vals(f_len)]);
    title('Power Spectrum (Zoom)');
end

%% 課題2 %%
f = [4, 16, 64];
lim_vals = [10, 30, 80];
for f_len = 1:length(f)
    n = 1;
    for l = 1:h
        for k = 1:w
            img(l, k) = 1 + sin(2 * pi * f(f_len) * (l-1) / h);
        end
    end
    fft_image = fft2(double(img));
    fft_shift_image = fftshift(fft_image);
    fft_shift_abs = abs(fft_shift_image);
    ps = power(fft_shift_abs, 2);
    
    figure(f_len + 3);
    subplot(2,2,1);
    colormap('gray');
    imagesc(img);
    title(['Image (Horizontal, f=', num2str(f(f_len)), ')']);
    
    subplot(2,2,2);
    x = [-128:127];
    y = [-128:127];
    colormap('gray');
    imagesc(x, y, ps);
    title('Power Spectrum');
    
    subplot(2,2,3);
    x_low = [-128:127];
    y_low = [-128:127];
    colormap('gray');
    imagesc(x_low, y_low, ps);
    xlim([-lim_vals(f_len),lim_vals(f_len)]);
    ylim([-lim_vals(f_len),lim_vals(f_len)]);
    title('Power Spectrum (Zoom)');
end

%% 課題3 %%
H = 256;
W = 256;
set_num = [0, 60];
for g = 1:length(set_num)
    img = zeros(H, W);
    X = set_num(g);
    Y = set_num(g);
    img(H/2+Y -30/2:H/2+Y+30/2, W/2+X -60/2:W/2+X+60/2) = 255;
    
    fft_img = fft2(img);
    fft_shift_image = fftshift(fft_img);
    fft_shift_abs = abs(fft_shift_image);
    ps = power(fft_shift_abs, 2);
    
    figure(g + 6);
    subplot(1,2,1);
    imagesc(img);
    colormap('gray');
    title(['Rectangle (Shift=', num2str(set_num(g)), ')']);
    
    subplot(1,2,2);
    imagesc(H, W, ps);
    title('Power Spectrum');
end

%% 課題4 %%
img = imread('lena_gray.bmp');
[height, width] = size(img);
fft_img = fft2(img);
fft_shift_img = fftshift(fft_img);

radii = [inf, 10, 50]; 
filter_names = {'No Filter', 'R=10', 'R=50'};

for i = 1:length(radii)
    R = radii(i);
    fil = zeros(height, width);
    x_center = (height / 2) + 1;
    y_center = (width / 2) + 1;
    
    for k = 1:height
        for l = 1:width
            D = sqrt(power(x_center - k, 2) + power(y_center - l, 2));
            if D <= R
                fil(k,l) = 1;
            end
        end
    end
    
    fil_img = fft_shift_img .* fil;
    ifftshift_image = ifftshift(fil_img);
    ifft_image = ifft2(ifftshift_image);
    filter_image = uint8(abs(ifft_image));
    
    figure(8 + i);
    
    subplot(2,3,1);
    imshow(img);
    title(['Original Image (', filter_names{i}, ')']);
    
    subplot(2,3,2);
    x_ax = 1:width;
    y_ax = 1:height;
    imagesc(x_ax, y_ax, log(1 + power(abs(fft_shift_img),2)));
    colormap("gray");
    title('2D Original Spectrum');
    
    subplot(2,3,3);
    imagesc(x_ax, y_ax, fil);
    colormap("gray");
    title(['Low-pass Filter (', filter_names{i}, ')']);
    
    subplot(2,3,4);
    imagesc(x_ax, y_ax, log(1 + power(abs(fil_img), 2)));
    colormap("gray");
    title('2D Filtered Spectrum');
    
    subplot(2,3,5);
    imshow(filter_image);
    title(['Filtered Image (', filter_names{i}, ')']);
end