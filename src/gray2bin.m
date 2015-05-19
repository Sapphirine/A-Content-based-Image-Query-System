function [ dstImg ] = gray2bin( T, srcImg )

[height, width] = size(srcImg);

for i = 1 : height
    for j = 1 : width
        if srcImg(i, j) >= T
            dstImg(i, j) = 1;
        else
            dstImg(i, j) = 0;
        end
    end
end

end

