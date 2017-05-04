%loading directories 
addpath(genpath('blindDeconvolution'));

image = 'test_data\motion1.jpg'
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
n=64;m=64;
psfsize=13;
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
        k = cropmatrix(k , 0);
        
        %resized blur kernal to 100x100
        demoimg = imresize(k,[100 100]);
        
        %imshow(demoimg);
        
        %normalizing
        normA = demoimg - min(demoimg(:));
        normA = normA / sum(normA(:));

        %feature extraction
        [ gamma, sigma ] = feature_extract2( normA );
        
        %storing features
        gamma_val(i+1,j+1) = gamma;
        sigma_val(i+1,j+1) = sigma;
        gamma_val
        
        count=count+1;
        j=j+1;
    end
    
    i=i+1;
    j=0;
end

%storing all features
save('extracted_vals1.mat','gamma_val','sigma_val');



