function [row, QData] = getimagedata(srcImg, ms)

row = 1;

QData = {};

for num = 1
    index = num;
    
    srcImg = imresize(srcImg, [128 128]);
    if numel(size(srcImg)) == 3
        [height, width, channel] = size(srcImg);
        
        %[counts, X] = imhist(srcImg(:, :, 1));
        
        %hsv2colorIndex(srcImg(1, 1, :), [4, 2, 2]);
        
        [q_stats, colorRegions] = ExtractColorRegion(srcImg, ms, 0);
        [r, c] = size(colorRegions);
        
        %A = zeros(height, width);
        
        for i = 1 : c
            regions = colorRegions{1, i};
            [tmp, count] = size(regions);
            % colorsets = colorRegions{2, i};
            res = srcImg;
            for j = 1 : count
                s = regionprops(regions{j}, 'centroid');
                area =regionprops(regions{j}, 'area');
                mbr = regionprops(regions{j}, 'BoundingBox');
               
                QData{row, 1} = num;
                QData{row, 2} = i;
                QData{row, 3} = colorRegions{2,i}{j};
                QData{row, 4} = s.Centroid(1);
                QData{row, 5} = s.Centroid(2);
                QData{row, 6} = area.Area(1);
                QData{row, 7} = abs(mbr.BoundingBox(2) - mbr.BoundingBox(1));
                QData{row, 8} = abs(mbr.BoundingBox(4) - mbr.BoundingBox(3));
                %setbin{row} = colorRegions{1,i}{1,j};
                row = row + 1;
            end
        end
    end
    
end

row = row - 1;

end