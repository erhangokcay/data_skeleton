function [inp_str,inp_data] = getData_LetterRecognition
    %fname = 'D:\ERHAN\CURRENT 4-9-2017\ACADEMIC\PAPERS\TO BE PUBLISHED\Information Theoretic Supervised Classifier\DATASETS\Dermatology\dermatology_1.data';
    % fname = 'D:\ERHAN\CURRENT 4-9-2017\ACADEMIC\PAPERS\TO BE PUBLISHED\Information Theoretic Supervised Classifier\DATASETS\banknote authentication\data_banknote_authentication.txt';
	fname='G:\WORKING\DATASETS_NEW\Letter Recognition\letter-recognition.data'
    fid=fopen(fname,'r');
    % Missing Numeric Fields : ? --> 0 
    A=textscan(fid,'%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f', 'Delimiter',',','TreatAsEmpty','?');
    
    Nrows = size(A{1},1);
    Ncols = size(A,2);
    
    % We need to switch rows and columns
    
    inp_data = zeros(Ncols-1,Nrows);
    inp_label = zeros(Nrows,1);           
    
    % Copy numeric data first
    
    for n=2:Ncols
        inp_data(n-1,:)=A{n};
    end
       
    % Replace Class Labels
    inp_lbl = A{1};
    labels = unique(A{1});
    Nlabels = length(labels);
     for n=1:Nlabels
         ind =  strcmp(inp_lbl,labels{n});
         inp_label(ind)=n;
    end   
          
    inp_str.inp=CPP_rescale(inp_data,-1,1); 
    inp_str.lbl=inp_label;
        
end