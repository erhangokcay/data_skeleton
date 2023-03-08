function [inp_str] = getData_Cardiotocography
    %fname = 'D:\ERHAN\CURRENT 4-9-2017\ACADEMIC\PAPERS\TO BE PUBLISHED\Information Theoretic Supervised Classifier\DATASETS\Dermatology\dermatology_1.data';
    % fname = 'D:\ERHAN\CURRENT 4-9-2017\ACADEMIC\PAPERS\TO BE PUBLISHED\Information Theoretic Supervised Classifier\DATASETS\banknote authentication\data_banknote_authentication.txt';
    fname='G:\WORKING\DATASETS\Cardiotocography\NEW.xlsx';
    
    % Missing Numeric Fields : ? --> 0 
  
    A=xlsread(fname);
    A=A';    
    
    inp_str.inp=CPP_rescale(A(1:end-2,:),-1,1); 
    inp_str.lbl=A(end,:)';
        
end