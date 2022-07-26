function x_seg = char_cc_seg(BW, thresholds)
x_seg = {};
tmp = regionprops(BW, 'BoundingBox');
for n = 1: length(tmp)
    if tmp(n).BoundingBox(3)< thresholds
        continue;
    end
    x_seg{end + 1} = round([tmp(n).BoundingBox(1), tmp(n).BoundingBox(1) + tmp(n).BoundingBox(3) - 1]);
end
end
