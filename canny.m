function img_out = canny(img_out, thresholds)
img_out = edge(img_out, 'Canny', thresholds);
img_out(1:3, :) = 0;
img_out(end - 2:end, :) = 0;
img_out(:, 1:3) = 0;
img_out(:, end - 2:end) = 0;
end
