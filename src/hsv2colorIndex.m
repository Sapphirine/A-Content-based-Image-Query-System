function [ index ] = hsv2colorIndex( color, hsv )

h = hsv(1, 1);
s = hsv(1, 2);
v = hsv(1, 3);

index = min(bitshift(color(1, 1), s + v) + bitshift(color(1, 2), v) + color(1, 3) + 1, 255);

end

