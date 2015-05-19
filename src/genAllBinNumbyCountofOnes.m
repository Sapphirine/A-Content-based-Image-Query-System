function [ map ] = genAllBinNumbyCountofOnes( len )

% construct a map from # of 1's to the bin number
map = zeros(len, len + 1);
e = 2 .^ len - 1;
for i = 1 : e
    bin = de2bi(i);
    index = sum(bin);
    map(index, 1) = map(index, 1) + 1;
    map(index, map(index, 1) + 1) = i;
end

end

