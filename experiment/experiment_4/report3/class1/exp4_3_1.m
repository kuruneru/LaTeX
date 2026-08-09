clear all;

Fs = 16000;

% 課題1(440Hz) %
t = 0 : 1 / Fs : 1;

y1_1 = sin(2*pi*440*t);
sound(y1_1, Fs);
pause(2);

subplot(2, 1, 1);
plot(t(1:220), y1_1(1:220));
title('$$ \sin(2 \pi \times 440 t) $$', 'Interpreter', 'latex', 'FontSize', 14);

% 課題1(660Hz) %
y1_2 = sin(2*pi*660*t);
sound(y1_2, Fs);
pause(2);

subplot(2, 1, 2);
plot(t(1:220), y1_2(1:220));
title('$$ \sin(2 \pi \times 660 t) $$', 'Interpreter', 'latex', 'FontSize', 14);

figure;

% 課題2 %
y2_1 = 0.5*sin(2*pi*440*t + 1 / 2*pi);
y2_2 = 0.5*sin(2*pi*440*t + pi);
y2_3 = 0.25*sin(2*pi*440*t + 1 / 2*pi);
y2_4 = 0.25*sin(2*pi*440*t + pi);

sound(y2_1, Fs);
pause(2);
sound(y2_2, Fs);
pause(2);
sound(y2_3, Fs);
pause(2);
sound(y2_4, Fs);
pause(2);

subplot(2,2,1);
plot(t(1:220), y2_1(1:220));
title('$$ 0.5 \cdot \sin(2\pi \cdot 440t + \frac{\pi}{2}) $$', 'Interpreter', 'latex', 'FontSize', 14);

subplot(2,2,2);
plot(t(1:220), y2_2(1:220));
title('$$ 0.5 \sin(2\pi \cdot 440 t + \pi) $$', 'Interpreter', 'latex', 'FontSize', 12);

subplot(2,2,3);
plot(t(1:220), y2_3(1:220));
title('$$ 0.25 \sin\left(2\pi \cdot 440 t + \frac{\pi}{2}\right) $$', 'Interpreter', 'latex', 'FontSize', 12);

subplot(2,2,4);
plot(t(1:220), y2_4(1:220));
title('$$ 0.25 \sin(2\pi \cdot 440 t + \pi) $$', 'Interpreter', 'latex', 'FontSize', 12);
figure;

% 課題3 %
t = 0 : 1 / Fs : 4;
y3 = sin(2 * pi * 440 * t) + sin(2 * pi * 441 * t);
sound(y3, Fs);
pause(2);

plot(t, y3);
title('$$ \sin(2\pi \cdot 440 t) + sin(2\pi \cdot 441 t) $$',  'Interpreter', 'latex', 'FontSize', 12);

% 課題4 %
t = 0 : 1 / Fs : 1;

N_values = [1, 5, 25]; 
figure;

for i = 1:length(N_values)
    N = N_values(i);
    y_sum = zeros(size(t));
    
    for k = 1:N
        y_sum = y_sum + (1 / (2*k - 1)) * sin(2*pi*(2*k - 1)*220*t);
    end
    sound(y_sum, Fs);
    pause(2);
   
    subplot(3, 1, i);
    plot(t(1:220), y_sum(1:220));
    
    title_str = ['$$ f(t) = \sum_{k=1}^{', num2str(N), '} \frac{1}{2k - 1} \sin(2\pi(2k - 1)ft) $$'];
    title(title_str, 'Interpreter', 'latex', 'FontSize', 12);
end

% 課題5 %
Fs = 16000;
t = 0:1 / Fs:1;

noise = 0.2 * randn(1, length(t));
sound(noise, Fs);
pause(2);

figure;

subplot(2, 1, 1);
plot(t, noise);
title('白色ガウス雑音 (\mu=0, \sigma=0.2)');
grid on;

[noise, c] = hist(noise, 50);
subplot(2, 1, 2);
plot(c,noise);

% 発展課題 %
Fs = 15000;
t = 0:1 / Fs:1;

y_a1 = sin(2 * pi * 440 * t);
sound(y_a1, Fs);
pause(1.5);

figure;

subplot(2, 1, 1);
plot(t(1:220), y1_1(1:220));
title('$y(t) \quad (F_s = 16000\mathrm{Hz})$', 'Interpreter', 'latex', 'FontSize', 12);

subplot(2, 1, 2);
plot(t(1:220), y_a1(1:220));
title('$y(t) \quad (F_s = 15000\mathrm{Hz})$', 'Interpreter', 'latex', 'FontSize', 12);

% 発展課題 %
Fs = 8000;
t = 0 : 1/Fs : 0.5;

y = sin(2 * pi * (440 * t + 440 * t.^2));

sound(y, Fs);
pause(1);

figure;

subplot(2, 1, 1);
idx_start = 1 : round(0.02 * Fs); 
plot(t(idx_start), y(idx_start));
title('$y(t)$ at Start (Around 440Hz)', 'Interpreter', 'latex', 'FontSize', 12);

subplot(2, 1, 2);
idx_end = length(t) - round(0.02 * Fs) : length(t); 
plot(t(idx_end), y(idx_end));
title('$y(t)$ at End (Around 880Hz)', 'Interpreter', 'latex', 'FontSize', 12);
grid on;

% 発展課題 %

Fs = 16000;
t = 0 : 1/Fs : 2;

y_a3_1 = sin(2 * pi * 440 * t) + sin(2 * pi * 442 * t);
y_a3_2 = sin(2 * pi * 440 * t) + sin(2 * pi * 438 * t);
y_a3_3 = sin(2 * pi * 440 * t) + sin(2 * pi * 450 * t);

soundsc(y_a3_1, Fs);
pause(2.5);

soundsc(y_a3_2, Fs);
pause(2.5);

soundsc(y_a3_3, Fs);
pause(2.5);

figure;
idx_1sec = 1 : Fs; 

subplot(3, 1, 1);
plot(t(idx_1sec), y_a3_1(idx_1sec));
title('$$ 440\mathrm{Hz} + 442\mathrm{Hz} \quad (\Delta f = 2\mathrm{Hz}) $$', 'Interpreter', 'latex', 'FontSize', 12);
grid on;

subplot(3, 1, 2);
plot(t(idx_1sec), y_a3_2(idx_1sec));
title('$$ 440\mathrm{Hz} + 438\mathrm{Hz} \quad (\Delta f = -2\mathrm{Hz}) $$', 'Interpreter', 'latex', 'FontSize', 12);
grid on;

subplot(3, 1, 3);
plot(t(idx_1sec), y_a3_3(idx_1sec));
title('$$ 440\mathrm{Hz} + 450\mathrm{Hz} \quad (\Delta f = 10\mathrm{Hz}) $$', 'Interpreter', 'latex', 'FontSize', 12);
grid on;

% 発展課題 %

Fs = 16000;
f = 2;               
t = 0 : 1/Fs : 1.5;  

N_values = [1, 5, 25];
figure;

for i = 1:length(N_values)
    N = N_values(i);
    y_tri = zeros(size(t));

    for k = 1:N
        y_tri = y_tri + ((-1)^(k-1) / (2*k - 1)^2) * sin(2 * pi * (2*k - 1) * f * t);
    end

    subplot(2, 3, i);
    plot(t, y_tri);
    title(['$$ \mathrm{Triangle} \quad (N=', num2str(N), ') $$'], 'Interpreter', 'latex', 'FontSize', 12);
    grid on;
end

for i = 1:length(N_values)
    N = N_values(i);
    y_saw = zeros(size(t));

    for k = 1:N
        y_saw = y_saw + ((-1)^(k-1) / k) * sin(2 * pi * k * f * t);
    end

    subplot(2, 3, i + 3);
    plot(t, y_saw);
    title(['$$ \mathrm{Sawtooth} \quad (N=', num2str(N), ') $$'], 'Interpreter', 'latex', 'FontSize', 12);
    grid on;
end