function [char, x_ranges, y_range] = char_pos(img_plate)
img_gray = Gray_Trans(img_plate);
img_eq = adapthisteq(img_gray, 'NumTiles', [4, 6]);
img_bin = imbinarize(img_eq);
P = Polarity(img_bin);
img_bin = xor(img_bin, P);

[char, x_ranges, y_range] = char_seg(img_bin);
end
