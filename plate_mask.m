function mask = plate_mask(edge_car)
[H, W] = size(edge_car);

img_C = imclose(edge_car, ones(round(H / 120), round(W / 40)));
img_O = imopen(img_C, ones(round(H / 120), round(W / 40)));

img_C = imclose(img_O, ones(round(H / 60), round(W / 20)));
img_O = imopen(img_C, ones(round(H / 60), round(W / 20)));

img_C = imclose(img_O, ones(round(H / 45), round(W / 15)));
img_O = imopen(img_C, ones(round(H / 45), round(W / 15)));

img_O = imopen(img_O, ones(round(H / 24), round(W / 8)));
img_C = imclose(img_O, ones(round(H / 24), round(W / 8)));

img_O = imopen(img_C, ones(round(H / 18), round(W / 7)));
img = imclose(img_O, ones(round(H / 18), round(W / 7)));

mask = img;
end
