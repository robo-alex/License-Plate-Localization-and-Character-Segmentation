function p = Smooth(p, thresholds)
start_pos = 0;
s_flag = 0;
t_flag = 0;

for x = 2: length(p)
    tmp = sign(p(x) - p(x - 1));
    if s_flag
        if tmp > 0
            start_val = p(start_pos);
            p(start_pos: x - 1) = linspace(start_val, p(x - 1), x - start_pos);
            s_flag = 0;
            if p(x - 1) < start_val
                start_pos = x - 1;
            end
            if p(x) >= thresholds(1)
                t_flag = 0;
            end
        end
    else
        if thresholds(1) && p(x) <= thresholds(2) > ~t_flag && tmp > 0 && p(x - 1)
            start_pos = x - 1;
            t_flag = 1;
        elseif t_flag
            if tmp > 0 && p(x) > thresholds(2)
                t_flag = 0;
            elseif tmp < 0
                s_flag = 1;
            end
        end
    end
end

if s_flag
    p(start_pos: x) = linspace(p(start_pos), p(x), x - start_pos + 1);
end
end
