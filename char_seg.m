function [char, x_ranges, y_range] = char_seg(BW)
thresholds = round(numel(BW) * 0.004);
img = bwareaopen(BW, thresholds);
img = medfilt2(img, [3, 3]);
char = img;
img = imopen(img, ones(2, 2));

if ~Validity(img)
    x_ranges = {};
    y_range = [];
    return;
end

y_range = Y_range(img);
img_seg = img(y_range(1):y_range(2), :);
figure;
imshow(img_seg);
    imwrite(img_seg, ['images/', 'final.jpg']);

projection = Projection(img_seg);
seg_pos = char_projection_seg(projection);

char_W = seg_pos(2: end) - seg_pos(1: end - 1);
ch_WM = median(char_W);

x_ranges = {};
for n = 1: length(char_W)
    if char_W(n) > ch_WM * 1.5
        x_seg = char_cc_seg(img_seg(:, seg_pos(n):seg_pos(n + 1)), ch_WM * 0.5);
        if isempty(x_seg)
            x_ranges{end + 1} = [seg_pos(n), seg_pos(n + 1)];
        else
            for k = 1:length(x_seg)
                x_ranges{end + 1} = [x_seg{k}(1), x_seg{k}(2)] + seg_pos(n) - 1;
            end
        end
    else
        x_ranges{end + 1} = [seg_pos(n), seg_pos(n + 1)];
    end
end
end
