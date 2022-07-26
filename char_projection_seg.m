function seg_pos = char_projection_seg(projection)
len = length(projection);
char_len = 0.1 * len;
thresholds = 0.95;

while 1
    sec = get_sections(projection, thresholds);
    if length(sec) >= 6
        seg_pos = [];

        if sec{1}(1) > char_len
            seg_pos(end + 1) = 1;
        end

        for sec_id = 2: length(sec)
            if min_middle(sec{sec_id}) - min_middle(sec{sec_id - 1}) > char_len
                seg_pos(end + 1) = min_middle(sec{sec_id - 1});
            end
        end

        seg_pos(end + 1) = min_middle(sec{sec_id});

        if len - sec{end}(2) + 1 > char_len
            seg_pos(end + 1) = len;
        end

        if length(seg_pos) >= 8
            break;
        end   
    end
    
    thresholds = thresholds + 0.005;
    if thresholds > 0.2
        break;
    end
end

seg_pos = round(seg_pos);

    function pos_M = min_middle(section)
        [val, pos] = min(projection(section(1): section(2)));
        pos = section(1) + pos - 1;
        E_pos = pos + 1;
        while E_pos < section(2) && projection(E_pos) == val
            E_pos = E_pos + 1;
        end
        E_pos = E_pos - 1;
        pos_M = round((pos + E_pos) / 2);
    end
end

function sections = get_sections(p, threshold)
sections = {};
len = length(p);

S_pos = 0;
for x = 1: len
    if S_pos == 0 && p(x) <= threshold
        S_pos = x;
    elseif S_pos ~= 0 && p(x) > threshold
        sections{end + 1} = [S_pos, x - 1];
        S_pos = 0;
    end
end

if S_pos ~= 0
    sections{end + 1} = [S_pos, x];
end
end
