function [ indexedImage ] = hsvImg2IndexedImage( hsvImg, q_size )

[height, width, channel] = size(hsvImg);

indexedImage = zeros(height, width);

for i = 1 : height
    for j = 1 : width
        indexedImage(i, j) = hsv2colorIndex(hsvImg(i, j, :), q_size);
    end
end

end

