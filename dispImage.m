function [final] = dispImage( K )
    %function for displaying final image with tampered region darkened
    img = (rgb2gray(imread('pic.png')));
    [M N]=size(img);
    n=64; % block size
    m=64; %
    psfsize=9;
    i=0;j=0;
    p=floor(M/m);
    q=floor(N/n);

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
            %further modifications required!!!
            %regions blackened for now!!
            if(K(i+1,j+1) == 'M')
                finalimg(i*n+1:rightedge,j*n+1:bottomedge) = img(i*n+1:rightedge,j*n+1:bottomedge)*0;
            else
                finalimg(i*n+1:rightedge,j*n+1:bottomedge) = img(i*n+1:rightedge,j*n+1:bottomedge);
            end
            j=j+1;
        end
        i=i+1;
        j=0;
    end
    final = finalimg;
end

