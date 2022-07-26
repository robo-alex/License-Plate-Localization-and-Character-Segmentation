function Box = plate_fine(plate_color_coarse, plate_color_ext)
h = size(plate_color_ext, 1);
w = size(plate_color_ext, 2);
[H, S, V] = rgb2hsv(plate_color_coarse);
    
if sum(S <= 0.05) > numel(S) * 0.35
    V_tmp = V(S <= 0.05);
    V_range = [mean(V_tmp) - 2 * std(V_tmp), mean(V_tmp) + 2 * std(V_tmp)];
    img = in_range(rgb2hsv(plate_color_ext), [0, 0, V_range(1)], [1, 0.05, V_range(2)]);
else
    H_tmp = H(S > 0.05);
    f = figure('visible','off');
    hist_h = histogram(H_tmp(:), [0:1/24:1]);
    [~, idx] = max(hist_h.BinCounts);
    close(f);
    H_range = [(idx - 1) / 24, idx / 24];
    V_tmp = V(S > 0.05 & H > H_range(1) & H < H_range(2));
    V_range = [mean(V_tmp) - 2 * std(V_tmp), mean(V_tmp) + 2 * std(V_tmp)];
    img = in_range(rgb2hsv(plate_color_ext), [H_range(1), 0.05, V_range(1)], [H_range(2), 1, V_range(2)]);
end

% (coarse) get the plate
img_O = imopen(img, [1 1]);

img_C = imclose(img_O, ones(round(h / 4), round(w / 8)));
img_O = imopen(img_C, ones(round(h / 4), round(w / 8)));

img_C = imclose(img_O, ones(round(h / 3), round(w / 6)));
img_O = imopen(img_C, ones(round(h / 3), round(w / 6)));

box = Boundary(img_O, [1.15, 1.02]);
box_id = Box_id(box, 2.5);

if box_id == 0
    Box.point1 = [-1, -1];
    Box.point2 = [-1, -1];
    return;
end

% fine tune and get the plate range
im_gray = adapthisteq(Gray_Trans(plate_color_ext));
im_edge = edge(im_gray, 'Canny', [0.4 0.7]);
im_valid_edge = zeros(h, w);
im_valid_edge(box{box_id}.point1(2):box{box_id}.point2(2), box{box_id}.point1(1):box{box_id}.point2(1)) = 1;
im_valid_edge = im_valid_edge & im_edge;

img_O = img | im_valid_edge;
img_O = imopen(img_O, [1 1]);

img_C = imclose(img_O, ones(round(h / 4), round(w / 8)));
img_O = imopen(img_C, ones(round(h / 4), round(w / 8)));

img_C = imclose(img_O, ones(round(h / 3), round(w / 6)));
img_O = imopen(img_C, ones(round(h / 3), round(w / 6)));

plate_box = Boundary(img_O, [1.01, 1.02]);
box_id = Box_id(plate_box, 2.5);

% point invalid
if box_id == 0
    Box.point1 = [-1, -1];
    Box.point2 = [-1, -1];
    return;
end

Box = plate_box{box_id};
end
