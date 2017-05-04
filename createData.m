
%CREATE DATASET OF BLUR KERNALS FOR BOTH BLUR TYPES
M = 0;
dirname = 'test_data'
addpath(genpath('blindDeconvolution'));
M=42;

for i = 3 : 2
    sprintf('Running on O%d',i);
    pic = sprintf('%s/focus%d.jpg',dirname,i);
    img = (rgb2gray(imread(pic)));
    getDataSet(img , 'O' , M+1,'dataset_O.mat');
    load('dataset_O.mat');
    [M N]=size(dataset);
end

M=42;
for i = 1 : 2
    sprintf('Running on M%d',i);
    pic = sprintf('%s/motion%d.jpg',dirname,i);
    img = (rgb2gray(imread(pic)));
    getDataSet(img , 'M' , M+1,'dataset_M.mat');
    load('dataset_M.mat');
    [M N]=size(dataset);
end


%Evalutating Classifier
findThreshold
