function img_out = IMG_rotating(img_in, angle, method)
if nargin < 3
    method = 'bicubic';
end

H = size(img_in, 1);
W = size(img_in, 2);
img_rot = imrotate(img_in, angle, method, 'crop');

alpha = atand(W / H);
tmp = sqrt(W^2 + H^2) / 2;

angle = abs(angle);
w1 = tmp * sind(alpha + angle) - W / 2;
h1 = H / 2 - tmp * cosd(alpha + angle);
h_cut = ceil(h1 - w1 * tand(angle));

h2 = tmp * cosd(alpha - angle) - H / 2;
w2 = W / 2 - tmp * sind(alpha - angle);
w_cut = ceil(w2 - h2 * tand(angle));

img_out = img_rot(h_cut + 1:H - h_cut, w_cut + 1:W - w_cut, :);
end
