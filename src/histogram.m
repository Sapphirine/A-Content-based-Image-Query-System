function [ count, value ] = histogram( srcImg )

d = length(size(srcImg));

if (d == 2)
    vImg = srcImg(:);
else
    vImg = srcImg;
end

[count, value] = hist(vImg, unique(vImg));

end

