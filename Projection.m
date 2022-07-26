function projection = Projection(BW)

[H, W] = size(BW);
sum_X = zeros(1, W);
weight = normpdf([1: H], (1 + H) / 2, H / 6);
for x = 1: W
    sum_X(x) = weight * BW(:, x);
end

projection = Smooth(sum_X, [0.06, 0.08]);
end
