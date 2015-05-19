function [ q_stats, colorRegions ] = ExtractColorRegion( rgbImg, ms, debug )

%This function is for extract regions from a rgbImg with a give median
%filter ms. It's supposed to be a integer indicating the size 
%of the median filter.

% return value q_stats contains the quantization levels in HSV color space
% colorRegions is an object array, whose first row contains a set of
% regions and second row indicates the colorSet for that set of regions


% some initialization
% start here

% debug ? 1 will output logs

colorRegions = {};

colorNum = 0;
[height, width, channel] = size(rgbImg);

t0 = 1.0 / 24;
t1 = 1.0 / 24;

t0size = t0 * height * width;
t1size = t1 * height * width;

q_size = [4, 2, 2];
quantize_L = q_size .^ 2;
median_area = [ms, ms];

% end here

hsvImg = 255 * rgb2hsv(rgbImg);

[display, quantized_hsvImg] = UniformQuantizer(hsvImg, [0, 255], quantize_L);

med_hsvImg = int16(medianFilter(quantized_hsvImg, median_area));
med_display = medianFilter(display, median_area);

if (debug)
    figure
    imshow(uint8(display));
    figure
    imshow(uint8(med_display))
end

l = length(unique(med_display(:)));

counts = hist(med_display(:), l);

%figure;
%stem(1 : l, counts);

% indexImg = zeros(height, width);
% 
% for i = 1 : height
%     for j = 1 : width
%         indexImg(i, j) = hsv2colorIndex(med_hsvImg(i, j, :), q_size);
%     end
% end

indexImg = hsvImg2IndexedImage(med_hsvImg, q_size);

colors = unique(indexImg(:));
%l = length(unique(colors));
counts = hist(indexImg(:), colors);

mark = ones(length(colors));

counts = counts - t0size;

colors = colors(counts > 0);
mark = mark(counts > 0);
counts = counts(counts > 0);

% generate the pattern for counts # of bits with # of 1's from 1 to n,
% search the valid colorSet

length(counts);

binList = genAllBinNumbyCountofOnes(length(counts));
[r, c] = size(binList);

if (debug)
colors
binList
end

for p = 1 : r
    for i = 2 : binList(p, 1) + 1
        b = de2bi(binList(p, i), r);
        
        iSet = colors(b == 1);
        
        if (debug)
        mark
        b
        iSet
        end
        
        if (sum(b(mark == 0)) > 0)
            continue;
        end
        
        colorSet = index2ColorSet(iSet, q_size);
        regions = extractRegionsbyColorset(indexImg, colorSet, q_size, t0, t1);
        
        % update the histogram by deleting the colors from extracted
        % regions
        region_size = size(regions);
        if (region_size(1, 2) == 0)
            if (debug)
            A = ['fail']
            end
            continue;
        end
        
        for j = 1 : region_size(1, 2)
            tmpImg = indexImg .* regions{j};
            [tmpCount, tmpColor] = histogram(tmpImg);
            for k = 1 : length(tmpColor)
                index = (colors == tmpColor(k));
                counts(index) = counts(index) - tmpCount(k);
            end
        end
        mark(counts < t1size) = 0;
        
        colorNum = colorNum + 1;
        colorRegions{1, colorNum} = regions;
        
        [~, rn] = size(regions);
        hset = {};
        th = zeros(1, 256);
        for k = 1 : rn
            [tc, tv] = histogram(indexImg .* regions{k});
            tv(1) = 1;
            th(tv) = tc;
            th(1) = 0;
            regionSize = sum(sum(regions{k} == 1));
            %hset{k} = 1.0 * th / regionSize;
            hset{k} = 1.0 * th / height / width;
        end
        %colorRegions{2, colorNum} = colorSet;
        colorRegions{2, colorNum} = hset;
    end
end

q_stats = q_size;
size(colorRegions);

end

