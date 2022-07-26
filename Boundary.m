function box = Boundary(mask, ext_ratio)
if nargin < 2
    ext_ratio = [1,3]; % default
end

[H, W] = size(mask);
tmp = regionprops(mask, 'BoundingBox');
box = {tmp.BoundingBox};

box = {};

for k = 1:length(box)  
    box{k}.point1 = [max(round(box{k}(1) + 0.5 * box{k}(3) * (1 - ext_ratio(1))), 1), max(round(box{k}(2) + 0.5 * box{k}(4) * (1 - ext_ratio(2))), 1)];
     
    box{k}.point2 = [min(round(box{k}(1) + 0.5 * box{k}(3) * (1 + ext_ratio(1))), W), min(round(box{k}(2) + 0.5 * box{k}(4) * (1 + ext_ratio(2))), H)];
    
end
end
