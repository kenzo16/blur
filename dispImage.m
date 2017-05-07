function [final] = dispImage( K , img )
    %function for displaying final image with tampered region darkened
    
   
    [M N]=size(img);
    n=32; % block size
    m=32; %
    i=0;j=0;
    p=floor(M/m);
    q=floor(N/n);

    while i < p
        while j < q
            rightedge = (i+1)*n;
            bottomedge = (j+1)*m;
           
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

