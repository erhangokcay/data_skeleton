function [inp_str,inp_data] = getData_CylinderBands 
    fname = 'G:\WORKING\ACADEMIC\MATLAB\SKELETON\DataSets_Skeleton\Annealing\anneal.data';
    fid=fopen(fname,'r');
    % Missing Numeric Fields : ? --> 0 
    A=textscan(fid,'%f%s%s%f%s%s%s%s%s%s%s%s%s%s%s%f%f%s%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%s','Delimiter',',','TreatAsEmpty','?');
    size(A)
    Nrows = size(A{1},1)
    Ncols = size(A,2)
     
    % We need to switch rows and columns
      
    inp_data = zeros(Ncols-2,Nrows);
    inp_label = zeros(Nrows,1);           
    size(inp_data)
    % Copy numeric data first
    inp_data(1,:) = A{4};
    inp_data(2,:) = A{16};
    inp_data(3,:) = A{17};
    for n=20:39        
        inp_data(n-16,:) = A{n};
    end
    
    
    % Replace Class Labels
    inp_lbl = A{40};
    labels = unique(inp_lbl);
    Nlabels = length(labels);
     for n=1:Nlabels
         ind =  strcmp(inp_lbl,labels(n));
         inp_label(ind)=n;
    end   
    
    % Replace Other character features
    list=[2,3,5,6,7,8,9,10,11,12,13,14,15,18,19];
    list
    cnt = 24;
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