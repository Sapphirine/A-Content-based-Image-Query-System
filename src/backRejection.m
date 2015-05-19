function [ B ] = backRejection( indexImg, c )

[height, width] = size(indexImg);
[s, e] = size(c);

B = zeros(height, width);

for i = 1 : height
    for j = 1 : width
        if (indexImg(i, j) > e)
            continue;
        end
        if c(1, indexImg(i, j)) == 1
            B(i, j) = 1;
        end
    end
end

end

