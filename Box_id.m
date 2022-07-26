function box_id = Box_id(box, thresholds)

area = 0;
box_id = 0;

for k = 1: length(box)
    box_W = box{k}.point2(1) - box{k}.point1(1);
    box_H = box{k}.point2(2) - box{k}.point1(2);
    if nargin > 1 && box_W / box_H < thresholds
%         continue;
    end
    
    area_tmp = box_W * box_H;
    if area_tmp > area
        box_id = k;
        area = area_tmp;
    end
end
end
