function [inp_str,inp_data] = getData_bach_chorals_harmony 
    fname = 'D:\ERHAN\CURRENT 4-9-2017\ACADEMIC\PAPERS\TO BE PUBLISHED\Information Theoretic Supervised Classifier\DATASETS\Bach Choral Harmony\jsbach_chorals_harmony\jsbach_chorals_harmony.data';
    fid=fopen(fname,'r');
    % Missing Numeric Fields : ? --> 0 
    A=textscan(fid,'%s%f%s%s%s%s%s%s%s%s%s%s%s%s%s%f%s','Delimiter',',','TreatAsEmpty','?');
    size(A)
    Nrows = size(A{1},1)
    Ncols = size(A,2)
     
    % We need to switch rows and columns
      
    inp_data = zeros(Ncols-3,Nrows);
    inp_label = zeros(Nrows,1);           
    size(inp_data)
    % Copy numeric data first
    inp_data(1,:) = A{16};
       
    % Replace Class Labels
    inp_lbl = A{17};
    labels = unique(inp_lbl);
    Nlabels = length(labels);
     for n=1:Nlabels
         ind =  strcmp(inp_lbl,labels(n));
         inp_label(ind)=n;
    end   
    
    % Replace Other character features
    list=3:15;
    list
    cnt = 2;
    for m=list
        inp_feat = A{m};
        labels = unique(inp_feat);
        Nlabels = length(labels);
        for n=1:Nlabels
            ind =  strcmp(inp_feat,labels(n));
            inp_data(cnt,ind)=n;
        end       
        cnt = cnt + 1;
    end
    cnt  
    % Replace NaN with average values for each feature
    for n=1:size(inp_data,1)
       mv = median(inp_data(n,isfinite(inp_data(n,:))));
       ind = isnan(inp_data(n,:));
       %sum(ind)
       inp_data(n,ind)=mv;
    end
    
    inp_str.inp=CPP_rescale(inp_data,-1,1); 
    inp_str.lbl=inp_label;
        
end