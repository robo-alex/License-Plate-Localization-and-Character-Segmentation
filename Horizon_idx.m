function idx = Horizon_idx(H)
H_max = max(max(H));
H_valid = H .* (H > 0.25 * H_max);
theta = sum(H_valid, 1);
[val_1, idx_1] = max(theta(1:10));
[val_2, idx_2] = max(theta(end - 9:end));
if val_1 > val_2
    idx = idx_1;
else
    idx = length(theta) - (10 - idx_2);
end
end
