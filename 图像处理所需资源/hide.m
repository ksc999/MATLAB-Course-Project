% preparation
info = load('JpegCoeff.mat');
Q = info.QTAB;
DC = info.DCTAB;
AC = info.ACTAB;
% Q = floor(Q ./ 2);
% string = ['Tom is a spy! Amy is also a spy! They are going to kill you on Monday! ',...
%         'I think the best way to prevent this disaster is to eat some ice cream.'...
%         'However, my mom do not think so. She said you should do your homework first.'...
%         'Tom is a spy! Amy is also a spy! They are going to kill you on Monday! ',...
%         'I think the best way to prevent this disaster is to eat some ice cream.',...
%         'However, my mom do not think so. She said you should do your homework first.,'...
%         'Tom is a spy! Amy is also a spy! They are going to kill you on Monday! ',...
%         'I think the best way to prevent this disaster is to eat some ice cream.',...
%         'However, my mom do not think so. She said you should do your homework first.'];
string = 'I love you forever!';
disp('before encrypt:');
disp(string);
huff = info2huff(string, DC);
I = load('hall.mat');
I = I.hall_gray;
[H, W] = size(I);

% No.1
% figure(1);
% subplot(2,1,1);
% imshow(I);
% title('before encrypt');
% set(gca, 'FontSize', 12);
% I_encrypt = encrypt_in_space(I, huff);
% I_recover = jpeg_transmission(I_encrypt, Q, DC, AC);
% subplot(2,1,2);
% imshow(I_recover);
% title('after decrypt');
% set(gca, 'FontSize', 12);
% huff_decrypt = decrypt_in_space(I_recoverd);
% info_decrypt = huff2info(huff_decrypt, DC);
% disp('after_decrypt:');
% disp(info_decrypt);
% delta = I_recover - I;
% MSE = sum(sum(delta .* delta)) / (120 * 168);
% PSNR = 10 * log10(255 ^ 2 / MSE);
% disp(PSNR);

% No.2, No.3, No.4
figure(2);
subplot(2,1,1);
imshow(I);
title('before encrypt');
set(gca, 'FontSize', 12);
I_before_encrypt = quantify_before_encrypt(I, Q);
I_encrypt_in_transform = encrypt_in_transform_3(I_before_encrypt, huff);
Z_q = entropy_encode_after_quantify(I_encrypt_in_transform);
[DC_stream, AC_stream] = encode(Z_q, DC, AC);
DC_decode_array = DC_decode(DC_stream, DC);
AC_decode_array = AC_decode(AC_stream, AC);
I_recoverd = recover(H, W, DC_decode_array, AC_decode_array, Q);
% imshow(I_recoverd);
I_recoverd_before_decrypt = quantify_before_encrypt(I_recoverd, Q);
huff_decrypt = decrypt_in_transform_3(I_recoverd_before_decrypt);
info_decrypt = huff2info(huff_decrypt, DC);
disp('after decrypt:');
disp(info_decrypt);
subplot(2,1,2);
imshow(I_recoverd);
title('after decrypt');
set(gca, 'FontSize', 12);
delta = I_recoverd - I;
MSE = sum(sum(delta .* delta)) / (120 * 168);
PSNR = 10 * log10(255 ^ 2 / MSE);
disp(PSNR);
