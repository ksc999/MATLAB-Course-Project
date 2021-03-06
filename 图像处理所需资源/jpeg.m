clear, clc;

% load Q, DC, AC from JpegCoeff.mat
info = load('JpegCoeff.mat');
Q = info.QTAB;
DC = info.DCTAB;
AC = info.ACTAB;

% load hall_gray from hall.mat
I = load('snow.mat');
I = I.snow;

% No.1
% choosed_block_1 = I(1: 8, 1: 8);
% % do dct2 first, then sub 128
% tmp_1_1 = dct2(choosed_block_1) - 128;
% % do sub 128 first, then do dct2
% tmp_1_2 = dct2(choosed_block_1 - 128);
% figure(1);
% subplot(1,2,1);
% imshow(tmp_1_1);
% title('do dct2 first, then sub 128');
% set(gca, 'FontSize', 12);
% subplot(1,2,2);
% imshow(tmp_1_2);
% title('do sub 128 first, then do dct2');
% set(gca, 'FontSize', 12);

% No.2
% choosed_block_2 = I(1: 8, 1: 8);
% D_by_matlab_dct2 = dct2(choosed_block_2 - 128);
% D_my_dct2 = my_dct2(choosed_block_2);
% figure(2);
% subplot(1,2,1);
% imshow(D_by_matlab_dct2);
% title('matlab-dct2');
% set(gca, 'FontSize', 12);
% subplot(1,2,2);
% imshow(D_my_dct2);
% title('my-dct2');
% set(gca, 'FontSize', 12);

% No.3
% t1 = 1;
% t2 = 1;
% N = 120;
% choosed_block_3 = I((t1-1)*N+1: t1*N, (t2-1)*N+1: t2*N);
% C = dct2(choosed_block_3 - 128);
% % set the four right columns to zeros
% C(: , 1: round(N/2)) = 0;
% disp(C)
% distorted_block_1 = idct2(C);
% figure(3);
% subplot(1,2,1);
% imshow(choosed_block_3);
% title('origin');
% set(gca, 'FontSize', 12);
% subplot(1,2,2);
% imshow(distorted_block_1);
% title('distorted');
% set(gca, 'FontSize', 12);

% No.4
% t1 = 1;
% t2 = 1;
% N1= 120;
% N2 = 160;
% choosed_block_4 = I((t1-1)*N1+1: t1*N1, (t2-1)*N2+1: t2*N2);
% C_origin = dct2(choosed_block_4 - 128);
% figure(4);   % origin
% subplot(2,2,1);
% imshow(choosed_block_4);
% title('origin');
% set(gca, 'FontSize', 12);
% C_transpose = C_origin'; % transpose
% block_transpose = idct2(C_transpose);
% subplot(2,2,2);
% imshow(block_transpose);
% title('transpose');
% set(gca, 'FontSize', 12);
% C_rotate_90 = rot90(C_origin, 1);   % rotate 90
% block_rotate_90 = idct(C_rotate_90);
% subplot(2,2,3);
% imshow(block_rotate_90);
% title('rotate 90');
% set(gca, 'FontSize', 12);
% C_rotate_180 = rot90(C_origin, 2);   % rotate 180
% block_rotate_180 = idct(C_rotate_180);
% subplot(2,2,4);
% imshow(block_rotate_180);
% title('rotate 180');
% set(gca, 'FontSize', 12);

% No.7
% choosed_block_7 = I(1: 8, 1: 8);
% tmp = zig_zag_code(choosed_block_7);

% No.8
% Z_q = quantify(I, Q);
figure(8);
subplot(2,1,1);
imshow(I);
title('before encode');
set(gca, 'FontSize', 12);

% No.9
% [DC_stream, AC_stream] = encode(Z_q, DC, AC);
% [I_H, I_W] = size(I);
% save('jpegcodes.mat', 'I_H', 'I_W', 'DC_stream', 'AC_stream');

% No.11, No.12, No.13
Q = round(Q / 2);
I_recoverd = jpeg_transmission(I, Q, DC, AC);
% I = reshape(I, 63,315);
subplot(2,1,2);
imshow(I_recoverd);
title('after decode');
set(gca, 'FontSize', 12);
I_recoverd = jpeg_transmission(I, Q, DC, AC);
imshow(I_recoverd);
delta = I_recoverd - I;
MSE = sum(sum(delta .* delta)) / (120 * 168);
PSNR = 10 * log10(255 ^ 2 / MSE);
disp(PSNR);


