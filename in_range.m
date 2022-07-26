function mask = in_range(img, low, high)
mask = true(size(img, 1), size(img, 2));
for p = 1 : 3
    mask = mask & (img(:, :, p) >= low(p) & img(:, :, p) <= high(p));
end
end

