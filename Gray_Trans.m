function img_out = Gray_Trans(img_in)
img_out = 0.229 * img_in(:, :, 1) + 0.587 * img_in(:, :, 2) + 0.114 * img_in(:, :, 3);
end
