
count = 1;
load('dataset_M.mat');
addpath(genpath('blindDeconvolution'));
I = rgb2gray(imread('pen.jpg'));
%H = fspecial('gaussian',7,10);
%Blur = imfilter(I,H,'replicate');
%Blur = imgaussfilt(I, 2);

dataset = zeros(1)
for i = 20 : 31        
    for j = 30 : 45
            H = fspecial('motion',i,j);
            k = cropmatrix(H, 0.00);
            demoimg = imresize(k,[100 100]);
            normA = demoimg - min(demoimg(:));
            normA = normA / sum(normA(:));
            [ gamma, sigma ] = feature_extract2( normA );
            dataset(count,1) = gamma;
            dataset(count,2) = sigma;
            dataset(count,3) = 'M';
            count=count+1;
            gamma
            sigma
    end
end
save('dataset_M.mat','dataset');
    dataset
   
    
   