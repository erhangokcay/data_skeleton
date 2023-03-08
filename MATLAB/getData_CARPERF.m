function [inp_str,inp_data] = getData_CARPERF 

    fname = 'D:\ERHAN\CURRENT 4-9-2017\ACADEMIC\PAPERS\TO BE PUBLISHED\Information Theoretic Supervised Classifier\DATASETS\Dataset for Sensorless Drive Diagnosis\Sensorless_drive_diagnosis.txt';
    fd = fopen(fname,'r');
    A=fscanf(fd,'%f',[49 Inf]);

    %fname = 'D:\ERHAN\CURRENT 4-9-2017\ACADEMIC\PAPERS\TO BE PUBLISHED\Information Theoretic Supervised Classifier\DATASETS\Dermatology\dermatology_1.data';
    %fname = 'D:\ERHAN\CURRENT 4-9-2017\ACADEMIC\PAPERS\TO BE PUBLISHED\Information Theoretic Supervised Classifier\DATASETS\Credit Approval\crx.data';
    %fid=fopen(fname,'r');
    % Missing Numeric Fields : ? --> 0 
    %A=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f', 'Delimiter',',','TreatAsEmpty','?');
    
    Nrows = size(A,1);
    Ncols = size(A,2);
    
    % We need to switch rows and columns
    
    inp_data = zeros(Nrows-1,Ncols);
    inp_label = zeros(Nrows,1);           
    
    % Copy numeric data first
    
    for n=1:Ncols
        inp_data(:,n)=A(1:Nrows-1,n);
    end   
    
    % Replace Class Labels
    inp_lbl = A(Nrows,:);
    labels = unique(inp_lbl);
    Nlabels = length(labels);
     for n=1:Nlabels
         ind =  inp_lbl==labels(n);
         inp_label(ind)=n;
    end   
       
    
    inp_str.inp=CPP_rescale(inp_data,-1,1); 
    inp_str.lbl=inp_label;
        
end