function [ dstImg ] = medianFilter( srcImg, area )

dstImg(:, :, 1) = medfilt2(srcImg(:, :, 1), area);
dstImg(:, :, 2) = medfilt2(srcImg(:, :, 2), area);
dstImg(:, :, 3) = medfilt2(srcImg(:, :, 3), area);

end

