%loading directories 
dirname='resdir'
addpath(genpath('blindDeconvolution'));
load test_data/sizeL
image = 'pic.png'
save('currentImage','image');

%creating lookup table
count = 1;
val = zeros(180,2);
for i = 0.2:0.01:3
        val(count,2) = i;
        val(count,1) = guassian_ratio(i);
        count = count + 1;
end
save('lookupTable.mat','val');

%loading image
img = (rgb2gray(imread(image)));

%setting up block size
[M N]=size(img);
n=32;m=32;
psfsize=9;
p=floor(M/m);
q=floor(N/n);

%initializations
count=1;
gamma_val = zeros(5,5);
sigma_val = zeros(5,5);
i=0;j=0;
sig_noise=0.01;

%repetetion for each blocks
while i <= p
    while j <= q
        %for non multiples of nxm
        rightedge = (i+1)*n;
        bottomedge = (j+1)*m;
        if i == p 
            if (M/m) ~= p
                rightedge = M;
            else 
                break;
            end
        end
        if j == q 
            if (N/n) ~= q
                bottomedge = N;
            else 
                break;
            end 
        end
        
        %block extracting
        pic = img(i*n+1:rightedge,j*n+1:bottomedge);

        %calling blind deconvolution
        [k]=deconv_diagfe_filt_sps(pic,psfsize,psfsize,.01,[],0);
        %[k]=deconv_freq_filt_gauss(pic,psfsize,psfsize,sig_noise,[],0);
        
        %remove unnecessary black margin from blur kernal
        k = cropmatrix(k, 0.05);
        
        demoimg = imresize(k,[100 100]);
        %resized blur kernal to 100x100
        %imshow(demoimg);

        %normalizing
        normA = demoimg - min(demoimg(:));
        normA = normA ./ max(normA(:));
        A = imhist(normA);
        A = A/sum(A);
        
        %feature extraction
        [ gamma, sigma ] = feature_extract( A );
        
        %storing features
        gamma_val(i+1,j+1) = gamma;
        sigma_val(i+1,j+1) = sigma;

        count=count+1;
        j=j+1;
    end
    
    i=i+1;
    j=0;
end

%storing all features
save('extracted_vals.mat','gamma_val','sigma_val');



