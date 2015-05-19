function [Data] = datasetup(imgFolderPath, s, e, ms)

imgFilePath = imgFolderPath;
imgDeffix = '.jpg';

row = 1;

for num = s : e
    if (mod(num, 1000) == 0)
        save Data.mat
    end
    
    index = num;
    srcImg = imread([imgFilePath, num2str(index), imgDeffix]);
    srcImg = imresize(srcImg, [128, 128]);
    
    if numel(size(srcImg)) == 3
        
        [height, width, channel] = size(srcImg);
        
        [q_stats, colorRegions] = ExtractColorRegion(srcImg, ms, 0);
        [r, c] = size(colorRegions);
        
        A = zeros(height, width);
        
        for i = 1 : c
            regions = colorRegions{1, i};
            [tmp, count] = size(regions);
            histSet = colorRegions{2, i};
            res = srcImg;
            for j = 1 : count
                s = regionprops(regions{j}, 'centroid');
                area = regionprops(regions{j}, 'area');
                mbr = regionprops(regions{j}, 'BoundingBox');
               
                    Data{row,1} = num;
                    Data{row,2} = i;
                    Data{row,3} = histSet{j};
                    Data{row,4} = s.Centroid(1);
                    Data{row,5} = s.Centroid(2);
                    Data{row,6} = area.Area(1);
                    Data{row,7} = abs(mbr.BoundingBox(2) - mbr.BoundingBox(1));
                    Data{row,8} = abs(mbr.BoundingBox(4) - mbr.BoundingBox(3));
                    setbin{row} = colorRegions{1,i}{1,j};
                    row = row + 1;
               
            end
        end
    end
end

save Data.mat 