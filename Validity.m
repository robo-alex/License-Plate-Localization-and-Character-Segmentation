function flag = Validity(BW)
[H, W] = size(BW);
Y_tmp = [round(H * 0.3), round(H * 0.5), round(H * 0.7)];
X = round(W * 0.1);
status = [BW(Y_tmp(1), X), BW(Y_tmp(2), X), BW(Y_tmp(3), X)];
flip = [0, 0, 0];
for x = X: round(W * 0.9)
    for y = 1: length(Y_tmp)
        if BW(Y_tmp(y), x) ~= status(y)
            status(y) = BW(Y_tmp(y), x);
            flip(y) = flip(y) + 1;
        end
    end
end
flag = all(flip < 30); 
end
