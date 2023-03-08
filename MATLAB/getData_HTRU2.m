function [inp_str,inp_data] = getData_HTRU2
    %fname = 'D:\ERHAN\CURRENT 4-9-2017\ACADEMIC\PAPERS\TO BE PUBLISHED\Information Theoretic Supervised Classifier\DATASETS\Dermatology\dermatology_1.data';
    % fname = 'D:\ERHAN\CURRENT 4-9-2017\ACADEMIC\PAPERS\TO BE PUBLISHED\Information Theoretic Supervised Classifier\DATASETS\banknote authentication\data_banknote_authentication.txt';
	fname='D:\DATASETS\HTRU2\HTRU_2.csv'
    fid=fopen(fname,'r');
    % Missing Numeric Fields : ? --> 0 
    A=textscan(fid,'%f%f%f%f%f%f%f%f%f', 'Delimiter',',','TreatAsEmpty','?');
    fclose(fid);
    Nrows = size(A{1},1);
    Ncols = size(A,2);
    
    % We need to switch rows and columns
    
    inp_data = zeros(Ncols-1,Nrows);
    inp_label = zeros(Nrows,1);           
    
    % Copy numeric data first
    
    for n=1:Ncols-1
        inp_data(n,:)=A{n};
    end
       
    % Replace Class Labels
    inp_lbl = A{end};
    ind = inp_lbl == 0;
    inp_lbl(ind) = 2;
%     labels = unique(A{end});
%     Nlabels = length(labels);
%      for n=1:Nlabels
%          ind =  strcmp(inp_lbl,labels{n});
%          inp_label(ind)=n;
%     end   
          
    inp_str.inp=CPP_rescale(inp_data,-1,1); 
    inp_str.lbl=inp_lbl;
        
end