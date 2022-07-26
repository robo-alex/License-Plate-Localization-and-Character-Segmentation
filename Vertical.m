function lines = Vertical(edge, H_vertical, T, R)
scale = size(H_vertical, 1);
P_vertical = houghpeaks(H_vertical, 30, 'threshold', ceil( max(H_vertical(:) * 0.30)));
lines = houghlines(edge, T, R, P_vertical, 'FillGap', scale / 250, 'MinLength', scale / 85);
end
