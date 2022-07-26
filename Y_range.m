function range = Y_range(BW)
[H, ~] = size(BW);
high = BW(1:round(H * 0.15), :);
low = BW(round(H * 0.85):end, :);

high_P = sum(high, 2);
low_P = sum(low, 2);

high_tmp = find(high_P < max(high_P) * 0.16);
if isempty(high_tmp)
    y_h = 1;
else
    y_h = max(high_tmp);
end
low_tmp = find(low_P < max(low_P) * 0.16);
if isempty(low_tmp)
    y_l = H;
else
    y_l = min(low_tmp) + round(H * 0.85) - 1;
end
range = [y_h, y_l];
end
