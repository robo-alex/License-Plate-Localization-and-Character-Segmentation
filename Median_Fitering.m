function img_out = Median_Fitering(img_in)
R = medfilt2(img_in(:, :, 1), [3, 3]);
G = medfilt2(img_in(:, :, 2), [3, 3]);
B = medfilt2(img_in(:, :, 3), [3, 3]);
img_out = cat(3, R, G, B);
end