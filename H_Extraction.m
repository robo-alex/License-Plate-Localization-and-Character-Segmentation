function H_valid = H_Extraction(H, idx, bias)
n_idx = size(H, 2);
H_valid = H;
idx_R = idx + bias;
idx_L = idx - bias;
if idx_R >= n_idx
    H_valid(:, mod(idx_R, n_idx) + 1:idx_L - 1) = 0;
elseif idx_L <= 1
    H_valid(:, idx_R + 1:mod(idx_L - 2, n_idx) + 1) = 0;
else
    H_valid(:, 1:idx_L - 1) = 0;
    H_valid(:, idx_R + 1:end) = 0;
end
end
