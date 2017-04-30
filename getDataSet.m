function [] = getDataSet( img , val , count , file )

%SAME BLIND DECONVOLUTION AND ASSIGNS 'M' or 'O' for Motion blur or Out-of-focus blur respectively
    sig_noise=0.01;
    load test_data/sizeL

    [M N]=size(img);

    n=64; % block size
    m=64; %
    psfsize=9;
    i=0;j=0;
    p=floor(M/m);
    q=floor(N/n);
    dataset = zeros(1,3);

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

            
            [k]=deconv_diagfe_filt_sps(pic,psfsize,psfsize,sig_noise,[],0);
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

