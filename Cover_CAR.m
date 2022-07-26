function range = Cover_CAR(h_lines, v_lines)

H_L = sort(arrayfun(@(x) min(x.point1(1), x.point2(1)), h_lines));
H_R = sort(arrayfun(@(x) max(x.point1(1), x.point2(1)), h_lines), 'descend');
H_top = sort(arrayfun(@(x) min(x.point1(2), x.point2(2)), h_lines));
H_bottom = sort(arrayfun(@(x) max(x.point1(2), x.point2(2)), h_lines), 'descend');
V_L = sort(arrayfun(@(x) min(x.point1(1), x.point2(1)), v_lines));
V_R = sort(arrayfun(@(x) max(x.point1(1), x.point2(1)), v_lines), 'descend');

if H_L(1) < V_L(1)
    if H_L(2) < V_L(1)  % --|
        left_most = H_L(2);
    else  % -|-
        left_most = min(H_L(2), V_L(2));
    end
else
    if H_L(1) < V_L(2)  % |-|
        left_most = min(H_L(2), V_L(2));
    else  % ||-
        left_most = min(H_L(1), V_L(3));
    end
end

if H_R(1) > V_R(1)
    if H_R(2) > V_R(1)
        right_most = H_R(2);
    else  % -|-
        right_most = max(H_R(2), V_R(2));
    end
else
    if H_R(1) > V_R(2)
        right_most = max(H_R(2), V_R(2));
    else  % ||-
        right_most = max(H_R(1), V_R(3));
    end
end

Top = H_top(1);
Bottom = H_bottom(1);

range.point1 = [left_most, Top];
range.point2 = [right_most, Bottom];
end
