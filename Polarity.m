function polarity = Polarity(BW)

BW = medfilt2(BW, [3, 3]);
thresholds = round(numel(BW) * 0.08);
BW_background = bwareaopen(BW, thresholds);
if sum(sum(BW_background == 0)) > 5 * sum(sum(BW_background == 1))
    polarity = 0;
    return;
end

BW_background = bwareaopen(~BW, thresholds);
if sum(sum(BW_background == 0)) > 5 * sum((BW_background == 1))
    polarity = 1;
    return;
end

polarity = (sum(sum(BW == 0)) < sum(sum(BW == 1)));
end
