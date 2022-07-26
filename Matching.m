img_p = imread('images\match.jpg');
img_p_sub = imread('images\∏Ωº”Ã‚\0.bmp');
[m, n] = size(img_p);
[m_tmp, n_tmp] = size(img_p_sub);
ret = zeros(m - m_tmp + 1,n - n_tmp + 1);
vec_sub = double(img_p_sub(:));
norm_sub = norm(vec_sub);
for i=1:m - m_tmp + 1
    for j = 1: n - n_tmp + 1
        matr = img_p(i: i + m_tmp - 1, j: j + n_tmp - 1);
        vec = double(matr(:));
        ret(i, j) = vec' * vec_sub / (norm(vec) * norm_sub + eps);
    end
end

[i_pos_max, j_pos_max] = find(ret == max(ret(:)));
figure;
subplot(1, 2, 1);
imshow(img_p_sub);
title('pattern image');
subplot(1, 2, 2);
imshow(img_p);
title('matching result'),
hold on
plot(j_pos_max, i_pos_max,'-');

plot([j_pos_max,j_pos_max + n_tmp - 1], [i_pos_max, i_pos_max]);
plot([j_pos_max + n_tmp-1, j_pos_max + n_tmp - 1], [i_pos_max, i_pos_max + m_tmp - 1]);
plot([j_pos_max, j_pos_max + n_tmp - 1], [i_pos_max + m_tmp - 1, i_pos_max+m_tmp - 1]);
plot([j_pos_max, j_pos_max], [i_pos_max, i_pos_max + m_tmp - 1]);
