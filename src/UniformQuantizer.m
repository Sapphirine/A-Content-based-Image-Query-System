function [ dstImg, levels ] = UniformQuantizer( srcImg, range, L )
% this is a uniform quantizer

[height, width, channel] = size(srcImg);

dstImg = zeros(height, width, channel);
levels = zeros(height, width, channel);

minValue = range(1, 1);
maxValue = range(1, 2);

% this is the step size
q(1) = 1.0 * (maxValue - minValue + 1) / L(1, 1);
q(2) = 1.0 * (maxValue - minValue + 1) / L(1, 2);
q(3) = 1.0 * (maxValue - minValue + 1) / L(1, 3);

% map each pixel a new quantized value
for i = 1 : height
    for j = 1 : width
        for k = 1 : channel
            levels(i, j, k) = int16((srcImg(i, j, k) - minValue) / q(k));
            dstImg(i, j, k) = q(k) * double(levels(i, j, k)) + minValue + q(k) / 2;
        end
    end
end

end

