
count = 45;
load('dataset_O.mat');
for p = 1:3
I = rgb2gray(imread('new.png'));
H = fspecial('disk',p);
Blur = imfilter(I,H,'replicate');

    
    
    [M N]=size(I);

    n=64; % block size
    m=64; %
    psfsize=9;
    i=0;j=0;
    p=floor(M/m);
    q=floor(N/n);
    
    
    while i < 5
        while j < 10
            rightedge = (i+1)*n;
            bottomedge = (j+1)*m;
            

            pic = Blur(i*n+1:rightedge,j*n+1:bottomedge);

            
            [k]=deconv_diagfe_filt_sps(pic,psfsize,psfsize,0.01,[],0);
            k = cropmatrix(k, 0.00);
            demoimg = imresize(k,[100 100]);
            normA = demoimg - min(demoimg(:));
            normA = normA / sum(normA(:));
            [ gamma, sigma ] = feature_extract2( normA );
            dataset(count,1) = gamma;
            dataset(count,2) = sigma;
            dataset(count,3) = 'O';
            count=count+1;
            j=j+1;

        end

        i=i+1;
        j=0;
    end
    
end
    save('dataset_O.mat','dataset');
    
    
    
    
   