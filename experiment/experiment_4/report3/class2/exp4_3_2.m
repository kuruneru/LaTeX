clear all;
% サンプリング周波数から時間軸の作成
Fs = 8192;
t = 0:1 / Fs:1;

%% 課題1 %%
% 周波数440HzよりAの音を作成
f = 440;
signal_A = sin(2 * pi * f * t);
signal_B = (1:1024);
for k = signal_B
    if mod(floor(k / 129), 2) == 0
        signal_B(k) = 0;
    else
        signal_B(k) = 1;
    end
end
fft_signal_A = fft(signal_A);
fft_signal_B = fft(signal_B);
fft_shift_A = fftshift(fft_signal_A);
fft_shift_B = fftshift(fft_signal_B);

figure(1);
T_A = length(signal_A) / Fs;
faxis_A = [-Fs/2: 1/T_A: Fs/2-1/T_A];
subplot(1, 2, 1);
plot(faxis_A, abs(fft_shift_A));
xlim([0 4500]);
title('振幅スペクトル：正弦波 (440Hz)'); % 追記：タイトル
xlabel('Frequency [Hz]');                % 追記：横軸ラベル
ylabel('Amplitude');                     % 追記：縦軸ラベル
grid on;                                 % 追記：グリッド線

T_B = length(signal_B) / Fs;
faxis_B = [-Fs/2: 1/T_B: Fs/2-1/T_B];
subplot(1, 2, 2);
plot(faxis_B, abs(fft_shift_B));
xlim([0 200]);
title('振幅スペクトル：矩形波');         % 追記：タイトル
xlabel('Frequency [Hz]');                % 追記：横軸ラベル
ylabel('Amplitude');                     % 追記：縦軸ラベル
grid on;                                 % 追記：グリッド線

%% 課題2 %%
t = 0: 1/Fs : 0.25 - 1/Fs;
C = sin(2 * pi * 261.38 * t);
D = sin(2 * pi * 293.67 * t);
E = sin(2 * pi * 329.63 * t);
F = sin(2 * pi * 349.23 * t);
G = sin(2 * pi * 392.00 * t);
A = sin(2 * pi * 440.00 * t);
B = sin(2 * pi * 493.88 * t);
hi_C = sin(2 * pi * 523.23 * t);
melody = [C, D, E, F, G, A, B, hi_C];
fft_melody = fft(melody);
fft_shift_melody = fftshift(fft_melody);
T_melody = length(melody) / Fs;
faxis_melody = -Fs/2: 1/T_melody: Fs/2-1/T_melody;

figure(2);
subplot(2,2,1);
plot(faxis_melody, abs(fft_shift_melody));
xlim([200 600]);
title('振幅スペクトル：原信号 (メロディ)'); % 追記：タイトル
xlabel('Frequency [Hz]');                   % 追記：横軸ラベル
ylabel('Amplitude');                        % 追記：縦軸ラベル
grid on;                                    % 追記：グリッド線

cut_off_sig = 357;
for k = 1:length(melody)
    if faxis_melody(k) < cut_off_sig
        fft_shift_melody(k) = 0;
    end
end

subplot(2, 2, 2);
plot(faxis_melody, abs(fft_shift_melody));
xlim([200 600]);
title('振幅スペクトル：フィルタ適用後');    % 追記：タイトル
xlabel('Frequency [Hz]');                   % 追記：横軸ラベル
ylabel('Amplitude');                        % 追記：縦軸ラベル
grid on;                                    % 追記：グリッド線

ifft_shift_melody = ifftshift(fft_shift_melody);
ifft_melody = ifft(ifft_shift_melody);
t_total = (0 : length(ifft_melody) - 1) / Fs;

subplot(2, 2, 3);
plot(t_total, real(ifft_melody));
title('時間波形：フィルタ適用後');          % 追記：タイトル
xlabel('Time [s]');                         % 追記：横軸ラベル
ylabel('Amplitude');                        % 追記：縦軸ラベル
grid on;                                    % 追記：グリッド線