dirname='resdir'
addpath(genpath('blindDeconvolution'));

sig_noise=0.01;
load test_data/sizeL

%%INITIALING LOOKUP TABLE
count = 1;
val = zeros(180,2);
for i = 0.2:0.01:3
        val(count,2) = i;
        val(count,1) = guassian_ratio(i);
        count = count + 1;
end
save('lookupTable.mat','val');


img = (rgb2gray(imread('pic.png')));


[M N]=size(img);

n=64; % block size
m=64; %
psfsize=9;
i=0;j=0;
p=floor(M/m);
q=floor(N/n);

 count=1;
 gamma_val = zeros(5,5);
 sigma_val = zeros(5,5);
 
while i <= p
    while j <= q
        rightedge = (i+1)*n;
        bottomedge = (j+1)*m;
        if i == p 
            if (M/m) ~= p
                rightedge = M;
            else 
                break
            end
        end
        if j == q 
            if (N/n) ~= q
                bottomedge = N;
            else 
                break
            end
             
        end
        
        pic = img(i*n+1:rightedge,j*n+1:bottomedge);

        
        [k]=deconv_diagfe_filt_sps(pic,psfsize,psfsize,.01,[],0);
        %[k]=deconv_freq_filt_gauss(pic,psfsize,psfsize,sig_noise,[],0);

        k = cropmatrix(k, 0.05);
        
        demoimg = imresize(k,[100 100]);
        %imshow(demoimg);

        %NORMALIZING
        normA = demoimg - min(demoimg(:));
        normA = normA ./ max(normA(:));
        A = imhist(normA);
        A = A/sum(A);
        
        %feature extraction
        [ gamma, sigma ] = feature_extract( A );

        gamma_val(i+1,j+1) = gamma;
        sigma_val(i+1,j+1) = sigma;

        count=count+1;
        j=j+1;
    end
    
    i=i+1;
    j=0;
end

save('extracted_vals.mat','gamma_val','sigma_val');



