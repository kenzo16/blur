I = rgb2gray(imread('pen.jpg'));
I = I(65:128,65:128);
imshow(I);psfsize =9;
load('dataset_M.mat')
count = 91;
for i = 91:90
    H = fspecial('motion',5,i);
    pic = imfilter(I,H,'replicate');
    imshow(pic);
    [k]=deconv_diagfe_filt_sps(pic,psfsize,psfsize,.01,[],0);
    k = cropmatrix(k, 0.00);
    demoimg = imresize(k,[100 100]);
    normA = demoimg - min(demoimg(:));
    normA = normA / sum(normA(:));
    [ agamma, asigma ] = feature_extract2( normA );
    dataset(count+1,1)= agamma;
    dataset(count+1,2)= asigma;
    dataset(count+1,3)= 'M';
    count = count+1;
end
%save('dataset_M.mat','dataset');


I = (imread('123.jpg'));
H = fspecial('disk',2);
pic = imfilter(I,H,'replicate');

imshow(pic);