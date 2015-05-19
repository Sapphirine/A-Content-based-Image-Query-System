function [ candidateImgIndex ] = QuerybyImage( srcImg, Data, ms, AAA, type )

% type = 1 is one-region query which will only account one best region
% type = others is multi-regions query which will account all the regions

candidateImgIndex = [];

[row, col] = size(Data);

imageNum = Data{row, 1} - Data{1, 1} + 1;

[r, QData] = getimagedata(srcImg, ms);

dist = 10000 * ones(r, imageNum);

for j = 1 : r
    for i = 1 : row
        colorset1 = Data{i, 3};
        centroid1 = [Data{i, 4}, Data{i, 5}];
        area1 = Data{i, 6};
        mbr1 = [Data{i, 7}, Data{i, 8}];
        
        colorset2 = QData{j, 3};
        centroid2 = [QData{j, 4}, QData{j, 5}];
        area2 = QData{j, 6};
        mbr2 = [QData{j, 7}, QData{j, 8}];
            
        d = distance(colorset1, colorset2, centroid1, centroid2, area1, area2, mbr1, mbr2, 1, 0, 0, 0, AAA);

        if (d < 0)
            d
            asdsadsa
        end
        
        imgIndex = Data{i, 1} - Data{1, 1} + 1;
        if dist(j, imgIndex) > d
            dist(j, imgIndex) = d;
        end
%         dist(j, i) = d;
    end
end

% score based on the dist matrix dist
raw_score = [ones(imageNum, 1), zeros(imageNum, r)];
thefirstN = 10;
factor = 2;

% A = zeros(r, imageNum);
A = zeros(r, thefirstN * factor);
score = zeros(1, imageNum);

for i = 1 : r
    [B, I] = sort(dist(i, :));
    %A(i, :) = dist(i, :) / B(2);
    A(i, :) = I(1 : thefirstN * factor);
end

A

[h, w] = size(A);

% if (h == 1)
%     scores = A;
% else
%     if type == 1
%         scores = min(A);
%     else
%         scores = sum(A);
%     end
% end

% [B, I] = sort(scores);
% B(1 : 10)
% 
% I(1 : thefirstN)
% candidateImgIndex = I(1 : thefirstN);

[count, value] = hist(A(:), unique(A(:)));

[B, I] = sort(count, 'descend');

B(1 : thefirstN)

candidateImgIndex = value(I(1 : thefirstN))

end

