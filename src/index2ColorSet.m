function [ colorSet ] = index2ColorSet( colorIndexes, q_size )

colorSet = zeros(1, 2 .^ q_size(1, 1) * 2 .^ q_size(1, 2) * 2 .^ q_size(1, 3));

for i = 1 : length(colorIndexes)
    colorSet(1, colorIndexes(i)) = 1;
end

end

