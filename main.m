relative_path = '01.jpg';
absolute_path = ['images/', relative_path];
img = imread(absolute_path);

[mask, plate_color, char, x_ranges, y_range] = char_segmentation(img);
char_i = length(x_ranges);
figure;
subplot(3, char_i, [1:char_i]);
imshow(plate_color);
for n = 1:length(x_ranges)
    subplot(3, char_i, char_i + n);
    imshow(plate_color(y_range(1):y_range(2), x_ranges{n}(1):x_ranges{n}(2), :));
    subplot(3, char_i, 2 * char_i + n);
    imshow(char(y_range(1):y_range(2), x_ranges{n}(1):x_ranges{n}(2)));
end

