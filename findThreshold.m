    %for evaluating the threshold for the classification
    load('W.mat');
    w = w';
    load('dataset_M.mat');
    data1 = dataset;
    load('dataset_O.mat');
    data = [data1 ; dataset];
    [a, b] = size(data);

    tempval = zeros(1);
    T = zeros(1,1);

    for i = 1:a
        tempval(i) = w * [data(i,1)  data(i,2)]';
    end
    
    count = 1;
    for thres = 0.0 : -.001 : -1.0
        TPOS = 0; FPOS = 0; TNEG = 0; FNEG = 0;
        for i = 1:a
            A(i,1) = tempval(i);
            A(i,2) = data(i,3);
            if data(i,3) == 'M'
                if tempval(i) < thres
                    TPOS = TPOS + 1;
                else
                    FPOS = FPOS + 1;
                end
            else
                if tempval(i) >= thres
                    TNEG = TNEG + 1;
                else
                    FNEG = FNEG + 1;
                end
            end 
        end
        sens = TPOS*100/(TPOS+FPOS);
        spec = TNEG*100/(TNEG+FNEG);
        T(count,1) = thres;
        T(count,2) = sens + spec - 1;
        count = count + 1;
    end
    
    [a, loc]=max(T(:,2));
    threshold = T(loc);

    save('threshold','threshold');
