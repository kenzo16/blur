function [ out ] = cropmatrix( k , threshold )
    %TESTING PART
    %threshold = 0.05  
    %k = [0 0 0 0 0 0 0 0;
    %    0 0 0 0 0 0 0 0;
    %    0 0 0 1 0 0 0 0;
    %    0 0 0 1 0 0 0 0;
    %    0 0 0 1 0 0 0 0;
    %    0 0 0 1 0 0 0 0;
    %    0 0 0 0 0 0 0 0;
    %    0 0 0 0 0 0 0 0;]
    
    
    [A B] = size(k);
        
	if(sum(k(:)) ~= 0)
        border=0;
        for border = [0:A]
            if sum(k(border+1,:)) > threshold
                break;
            end
        end
        row1=border;
        border=0;
        for border = [0:A]
            if sum(k(A-border,:)) > threshold
                break;
            end
        end
        row2=border;
        border=0;
        for border = [0:A]
            if sum(k(:,border+1)) > threshold
                break;
            end
        end
        col1=border;
        border=0;
        for border = [0:A]
            if sum(k(:,A-border)) > threshold
                break;
            end
        end
        col2=border;
        out=k(row1+1:A-row2,col1+1:A-col2);
        [A B] = size(out);
        if A < B   
            zero = zeros(1,B);
            loop = (B-A)/2;
            for i = [1:loop]
                out = [zero;out];
                out = [out;zero];
            end
        else
            if A > B
               zero = zeros(A,1);
                loop = (A-B)/2;
                for i = [1:loop]
                    out = [zero out zero];
                end
            end
        end
        
       
    else
        out = k;
    end
    
end
