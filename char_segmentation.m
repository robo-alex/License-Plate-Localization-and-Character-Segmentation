function [img_mask, plate_color, char, x_ranges, y_range] = char_segmentation(img)

img_denoised = Median_Fitering(img);
img_gray = Gray_Trans(img_denoised);
img_eq = adapthisteq(img_gray);
mask = reshape([1:numel(img_eq)], size(img_eq));

% detect edge
thresholds = [0.2 0.6];
img_edge = canny(img_eq, thresholds);
[H, T, ~] = hough(img_edge);
idx = Horizon_idx(H);

% rotating
angle = -sign(T(idx)) * (90 - abs(T(idx)));
img_eq_rot = IMG_rotating(img_eq, angle);
img_color_rot = IMG_rotating(img_denoised, angle);
mask = IMG_rotating(mask, angle, 'nearest');

% fine tune the edge
thresholds_fine = [0.1, 0.3];
edge_fine = canny(img_eq_rot, thresholds_fine);

% extract horizon and vertical
[H, T, R] = hough(edge_fine);
H_horizon = H_Extraction(H, 1, 3);
H_vertical = H_Extraction(H, 91, 3);
v_lines = Vertical(edge_fine, H_vertical, T, R);
h_lines = Horizon(edge_fine, H_horizon, T, R);

% get range of the car
Car_range = Cover_CAR(h_lines, v_lines);
img_rotated = IMG_rotating(img_gray, angle);
img_rotated = img_rotated(Car_range.point1(2):Car_range.point2(2), Car_range.point1(1):Car_range.point2(1), :);
img_car_color = img_color_rot(Car_range.point1(2):Car_range.point2(2), Car_range.point1(1):Car_range.point2(1), :);
img_car_eq = adapthisteq(img_rotated, 'NumTiles', [16 16], 'ClipLimit', 0.01);
% mask
mask = mask(Car_range.point1(2):Car_range.point2(2), Car_range.point1(1):Car_range.point2(1));

% get mask of the plate
car_edge_fine = edge(img_car_eq, 'Canny', [0.2 0.6]);
P_mask = plate_mask(car_edge_fine);

plate_box_rough = Boundary(P_mask);
plate_box_ext = Boundary(P_mask, [1, 1]);
% coarse tuning the car plate
for k = 1: length(plate_box_ext)
    plate_color_coarse = img_car_color(plate_box_rough{k}.point1(2):plate_box_rough{k}.point2(2), plate_box_rough{k}.point1(1):plate_box_rough{k}.point2(1), :);
    figure;
    imshow(plate_color_coarse);

    % extend the car plate
    plate_color_ext = img_car_color(plate_box_ext{k}.point1(2):plate_box_ext{k}.point2(2), plate_box_ext{k}.point1(1):plate_box_ext{k}.point2(1), :);
    mask_tmp = mask(plate_box_ext{k}.point1(2):plate_box_ext{k}.point2(2), plate_box_ext{k}.point1(1):plate_box_ext{k}.point2(1));
    
    
% extract plate
%     plate_box = plate_fine(plate_box_rough, plate_color_ext);
    plate_box = plate_fine(plate_color_ext, plate_color_ext);
%     figure;
%     imshow(plate_box);
    plate_color =  plate_color_ext(plate_box.point1(2):plate_box.point2(2), plate_box.point1(1):plate_box.point2(1), :);
    mask_valid = mask_tmp(plate_box.point1(2):plate_box.point2(2), plate_box.point1(1):plate_box.point2(1));
         
    [char, x_ranges, y_range] = char_pos(plate_color);
    if ~isempty(x_ranges)
        img_mask = IMG_mask(size(img_eq), mask_valid);
        return;
    end
end
end
