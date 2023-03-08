function [inp_str,inp_data] = getData_Ecoli
    % fname = 'D:\ERHAN\CURRENT 4-9-2017\ACADEMIC\PAPERS\TO BE PUBLISHED\Information Theoretic Supervised Classifier\DATASETS\Cylinder Bands\bands.data';
	fname='D:\DATASETS\DATASETS\Ecoli\ecoli.data';
    fid=fopen(fname,'r');
    % Missing Numeric Fields : ? --> 0 
    A=textscan(fid,'%s%f%f%f%f%f%f%f%s','TreatAsEmpty','?');
    size(A)
    Nrows = size(A{1},1)
    Ncols = size(A,2)
     
    % We need to switch rows and columns
      
    inp_data = zeros(Ncols-2,Nrows);
    inp_label = zeros(Nrows,1);           
    size(inp_data)
    % Copy numeric data first
    % inp_data(1,:) = A{4};
    % inp_data(2,:) = A{16};
    % inp_data(3,:) = A{17};
    for n=1:7        
        inp_data(n,:) = A{n+1};
    end
    
    
    % Replace Class Labels
    inp_lbl = A{9};
    labels = unique(inp_lbl);
    Nlabels = length(labels);
     for n=1:Nlabels
         ind =  strcmp(inp_lbl,labels(n));
         inp_label(ind)=n;
    end   
    
    % Replace Other character features
    %list=[1];
    %list
    %cnt = 8;
    %for m=list
    %    inp_feat = A{m};
    %    labels = unique(inp_feat);
    %    Nlabels = length(labels);
    %    for n=1:Nlabels
    %        ind =  strcmp(inp_feat,labels(n));
    %        inp_data(cnt,ind)=n;
    %    end       
    %    cnt = cnt + 1;
    %end
    %cnt  
    % Replace NaN with average values for each feature
    %for n=1:size(inp_data,1)
    %   mv = median(inp_data(n,isfinite(inp_data(n,:))));
    %   ind = isnan(inp_data(n,:));
    %   %sum(ind)
    %   inp_data(n,ind)=mv;
    %end
    
    inp_str.inp=CPP_rescale(inp_data,-1,1); 
    inp_str.lbl=inp_label;
        
end