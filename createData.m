
%CREATE DATASET OF BLUR KERNALS FOR BOTH BLUR TYPES
M = 0;
dirname = 'dataset'

M=0;
for i = 1 : 5
    pic = sprintf('%s/O%d.jpg',dirname,i);
    img = (rgb2gray(imread(pic)));
    getDataSet(img , 'O' , M+1,'dataset_O.mat');
    load('dataset_O.mat');
    [M N]=size(dataset);
end

%
%for i = 1 : 7
%    pic = sprintf('%s/M%d.jpg',dirname,i);
%    img = (rgb2gray(imread(pic)));
%    getDataSet(img , 'M' , M+1,'dataset_M.mat');
%    load('dataset_M.mat');
%    [M N]=size(dataset);
%end