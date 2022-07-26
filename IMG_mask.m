function img_mask = IMG_mask(size_img, mask)
mask_val = reshape([1:size_img(1) * size_img(2)], size_img);

[y_L, x_L] = find(mask_val == mask(1, 1));
[y_R, x_R] = find(mask_val == mask(1, end));
[p_bl_y, p_bl_x] = find(mask_val == mask(end, 1));
[p_br_y, p_br_x] = find(mask_val == mask(end, end));

x = [x_L(1), x_R(1), p_br_x(1), p_bl_x(1), x_L(1)];
y = [y_L(1), y_R(1), p_br_y(1), p_bl_y(1), y_L(1)];

img_mask = poly2mask(x, y, size_img(1), size_img(2));
end
