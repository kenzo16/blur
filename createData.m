
%CREATE DATASET OF BLUR KERNALS FOR BOTH BLUR TYPES
M = 0;
dirname = 'dataset'
addpath(genpath('blindDeconvolution'));
M=120;

for i = 8 : 7
    sprintf('Running on O%d',i);
    pic = sprintf('%s/O%d.jpg',dirname,i);
    img = (rgb2gray(imread(pic)));
    getDataSet(img , 'O' , M+1,'dataset_O.mat');
    load('dataset_O.mat');
    save('i.mat','i');
    [M N]=size(dataset);
end

M=133;
for i = 6 : 6
    sprintf('Running on M%d',i);
    pic = sprintf('%s/M%d.jpg',dirname,i);
    img = (rgb2gray(imread(pic)));
    getDataSet(img , 'M' , M+1,'dataset_M.mat');
    load('dataset_M.mat');
    save('i.mat','i');
    [M N]=size(dataset);
end


%Evalutating Classifier
findThreshold
