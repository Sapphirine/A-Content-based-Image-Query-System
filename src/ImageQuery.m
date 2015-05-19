function [ resultIndexes ] = ImageQuery( dataSetPath, dataSetSize, queryImagePath )

%datasetup('./indexedGallery/', 1, 2000);
%datasetup('./srcImg/', 239, 251);

if (~exist('data.mat', 'file'))
    datasetup(dataSetPath, queryImagePath, 1, dataSetSize);
end

load 'data.mat'
load AAA.mat

%[row, col] = size(Data);

%imgFilePath = './indexedGallery/';
%imgFilePath = './srcImg/'

%img = imread(queryImagePath);

queryIndex = 4;

img = imread([imgFilePath, num2str(queryIndex), '.jpg']);

resultIndexes = QuerybyImage( img, Data, 11, AAA );

end

