function [inp_str,inp_data] = CREDIT_APPROVAL_getData 
    fname = 'D:\ERHAN\CURRENT 4-9-2017\ACADEMIC\PAPERS\TO BE PUBLISHED\Information Theoretic Supervised Classifier\DATASETS\Credit Approval\crx.data';
    fid=fopen(fname,'r');
    % Missing Numeric Fields : ? --> 0 
    A=textscan(fid,'%s%f%f%s%s%s%s%f%s%s%f%s%s%f%f%s','Delimiter',',','TreatAsEmpty','?');
    
    Nrows = size(A{1},1);
    Ncols = size(A,2);
    
    % We need to switch rows and columns
    
    inp_data = zeros(Ncols-1,Nrows);
    inp_label = zeros(Nrows,1);
   
    
    
    
    % Copy numeric data first
    inp_data(1,:) = A{2};
    inp_data(2,:) = A{3};
    inp_data(3,:) = A{8};
    inp_data(4,:) = A{11};
    inp_data(5,:) = A{14};
    inp_data(6,:) = A{15};
    
    % Replace Class Labels
    inp_lbl = A{16};
    labels = unique(A{16});
    Nlabels = length(labels);
     for n=1:Nlabels
         ind =  strcmp(inp_lbl,labels(n));
         inp_label(ind)=n;
    end   
    
    % Replace Other character features
    list=[1,4,5,6,7,9,10,12,13];
    
    cnt = 7;
    for m=list
        inp_feat = A{m};
        labels = unique(A{m});
        Nlabels = length(labels);
        for n=1:Nlabels
            ind =  strcmp(inp_feat,labels(n));
            inp_data(cnt,ind)=n;
        end       
        cnt = cnt + 1;
    end
      
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