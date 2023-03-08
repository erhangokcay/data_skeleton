function [inp_str,inp_data] = getData_MovementAAL
    % fname = 'D:\ERHAN\CURRENT 4-9-2017\ACADEMIC\PAPERS\TO BE PUBLISHED\Information Theoretic Supervised Classifier\DATASETS\Cylinder Bands\bands.data';
	fname='D:\DATASETS\MovementAAL';
    
    % READ TARGET     
    fid=fopen([fname '\dataset\MovementAAL_target.csv'],'r');
    T=fscanf(fid,'%f',[2 314]);
    T(1,:) = [];
    fclose(fid);
    
    V = [];
    L = [];
    for n=1:314
        fid=fopen([fname '\test\MovementAAL_RSS_' num2str(n) '.csv'],'r');
        A=textscan(fid,'%f%f%f%f','Delimiter',',','TreatAsEmpty','?');
        fclose(fid)
        Nrows = size(A{1},1);
        Ncols = size(A,2);
        inp = [];
        for m=1:4        
            inp(m,:) = A{m};
        end
        lbl = zeros(1,Nrows);
        lbl(:) = T(n);
        V = [V inp];
        L = [L lbl];
    end                   
    
    ind = L == -1;
    L(ind) = 2;
    inp_str.inp=CPP_rescale(V,-1,1); 
    inp_str.lbl=L;
        
end