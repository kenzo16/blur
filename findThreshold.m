%function [threshold] = findThreshold( )
    threshold = -2.31;
    load('W.mat');
    w = w';
    load('dataset_M.mat');
    data1 = dataset;
    load('dataset_O.mat');
    data = [data1 ; dataset];
    [a, b] = size(data);

    TPOS = 1; FPOS = 1; TNEG = 1; FNEG = 1;
    for i = 1:a
       
            tempval = w * [data(i,1)  data(i,2)]';
            disp(tempval);
            if tempval >= threshold 
                if data(i,3) == 'M'
                    TPOS = TPOS + 1;
                else
                    FPOS = FPOS + 1;
                end
            else
                if data(i,3) == 'O'
                    TNEG = TNEG + 1;
                else
                    FNEG = FNEG + 1;
                end
            end 
    end
    disp(TPOS*100/(TPOS+FPOS));
    disp(TNEG*100/(TNEG+FNEG));
%end

