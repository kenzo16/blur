
%CREATE DATASET OF BLUR KERNALS FOR BOTH BLUR TYPES
M = 0;
dirname = 'dataset'
addpath(genpath('blindDeconvolution'));
M=120;

for i = 7 : 7
    sprintf('Running on O%d',i);
    pic = sprintf('%s/O%d.jpg',dirname,i);
    img = (rgb2gray(imread(pic)));
    getDataSet(img , 'O' , M+1,'dataset_O.mat');
    load('dataset_O.mat');
    save('i.mat','i');
    [M N]=size(dataset);
end
M=0;
for i = 2 : 1
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
