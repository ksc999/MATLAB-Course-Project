function image_encrypt = encrypt_in_space(I, huff)
    image_encrypt = I;
    [~, W] = size(I);
    index = 1;
    while index < length(huff)
        flag = 1;
        if index + 64 > length(huff)
            block_huff = [huff(index: length(huff)), zeros(1, 63 - length(huff) + index)];
            flag = 0;
        else
            block_huff = huff(index: index + 63);
        end
        k = floor(index / 64);
        W_range = W / 8;
        a = floor(k / W_range);
        b = mod(k, W_range);
        block = I(a * 8 + 1: (a+1) * 8, b * 8 + 1: (b+1) * 8);
        image_encrypt(a * 8 + 1: (a+1) * 8, b * 8 + 1: (b+1) * 8) = block_encrypt_in_space(block, block_huff);
        if flag
            index = index + 64;
        else
            break;
        end
        % imshow(image_encrypt);
    end
end

function block_encrypt = block_encrypt_in_space(block, block_huff)
    block_encrypt = zeros(8, 8);
    for a = 1: 8
        for b = 1: 8
            point = block(a, b);
            point_code = block_huff((a-1) * 8 + b);
            block_encrypt(a, b) = 2 * floor(point / 2) + point_code;
        end
    end
  
end