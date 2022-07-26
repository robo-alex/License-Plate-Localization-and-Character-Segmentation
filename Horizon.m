function lines = Horizon(edge, H_horizon, T, R)
scale = size(H_horizon, 1);
P_horizon = houghpeaks(H_horizon, 30, 'threshold', ceil(max(H_horizon(:) * 0.15)));
lines = houghlines(edge, T, R, P_horizon, 'FillGap', scale / 190, 'MinLength', scale / 40);
end
