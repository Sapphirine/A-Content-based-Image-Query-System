function [ colorSet ] = colorSet( imgArea, quantized_size )

colorSet = zeros(1, 2 .^ quantized_size(1, 1) * 2 .^ quantized_size(1, 2) * 2 .^ quantized_size(1, 3));

[height, width, channel] = size(imgArea);

for i = 1 : height
    for j = 1 : width
        index = hsv2colorIndex(imgArea(i, j, :), quantized_size);
        colorSet(1, index) = 1;
    end
end

end