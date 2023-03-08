function [inp_str,inp_data] = getData_Diabetic 
    fname = 'G:\WORKING\DATASETS\Diabetic Retinopathy Debrecen Data Set\messidor_features_numeric.txt';
    %fname = 'D:\ERHAN\CURRENT 4-9-2017\ACADEMIC\PAPERS\TO BE PUBLISHED\Information Theoretic Supervised Classifier\DATASETS\Credit Approval\crx.data';
    A=dlmread(fname ,',');
    
    Nrows = size(A,1);
    Ncols = size(A,2);
    
    % We need to switch rows and columns
    
    inp_data = zeros(Ncols-1,Nrows);
    inp_label = zeros(Nrows,1);           
    
    % Copy numeric data first
    
    for n=1:Ncols-1
        inp_data(n,:)=A(:,n);
    end
       
    % Replace Class Labels
    inp_lbl = A(:,20);
    labels = unique(inp_lbl);
    Nlabels = length(labels);
     for n=1:Nlabels
         ind =  inp_lbl==labels(n);
         inp_label(ind)=n;
    end   
           
    inp_str.inp=CPP_rescale(inp_data,-1,1); 
    inp_str.lbl=inp_label;
        
end