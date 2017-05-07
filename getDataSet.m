function [] = getDataSet( img , val , count , file )

%SAME BLIND DECONVOLUTION AND ASSIGNS 'M' or 'O' for Motion blur or Out-of-focus blur respectively
    sig_noise=0.01;
    load test_data/sizeL
    load(file);
    [M N]=size(img);

    n=32; % block size
    m=32; %
    psfsize=5;
    i=0;j=0;
    p=floor(M/m);
    q=floor(N/n);
    

    while i < p
        while j < q
            rightedge = (i+1)*n;
            bottomedge = (j+1)*m;
            
            pic = img(i*n+1:rightedge,j*n+1:bottomedge);

            
            %[k]=deconv_diagfe_filt_sps(pic,psfsize,psfsize,sig_noise,[],0);
            [k]=deconv_freq_filt_gauss(pic,psfsize,psfsize,sig_noise,[],0);

            k = cropmatrix(k, 0.00);

            demoimg = imresize(k,[100 100]);

            %imshow(demoimg);

            %NORMALIZING
            normA = demoimg - min(demoimg(:));
            normA = normA / sum(normA(:));
            
            %feature extraction
            [ gamma, sigma ] = feature_extract2( normA );
            
            dataset(count,1) = gamma;
            dataset(count,2) = sigma;
            dataset(count,3) = val;
            save(file,'dataset');
            count=count+1;
            j=j+1;

        end

        i=i+1;
        j=0;
    end
    save(file,'dataset');
end

