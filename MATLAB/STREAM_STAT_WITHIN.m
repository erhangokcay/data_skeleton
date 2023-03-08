%function out = INFORMATION_CLASSIFIER_V0 ( dirName, fName, ind_label, percent, std, mean )
function [o1,o2,o3] = STREAM_STAT_WITHIN ( inpData, stdV, meanV )
        
    % cd 'D:\ERHAN\CURRENT 4-9-2017\ACADEMIC\PAPERS\TO BE PUBLISHED\Information Theoretic Supervised Classifier\DATASETS\EEG Eye State';
    % cd dirName;
    
    %    inp=dlmread('EEG Eye State numeric.txt',',');   
    %    inp = dlmread(fName,',');   
    % Always ????
    %    inp=inp';
    
    % Last column is the label
    % ind_label=15;
    
    % 20 percent is the test set
    % percent = 0.2;            
    % ------------------------------------------
     
    % Nrows : # of dimensions
    % Ncols : # of samples
    [Nrows,Ncols] = size(inpData);
    %inpp=log(inp(1:14,:));         Feature???
    
    % Variance 
    if size(stdV,2)==1
        covar = eye(Nrows)*stdV^2;
    else
        % square of std is taken in the var2cov function. But
        % this creates a confusion. FIX IT LATER
        covar = stdV.^2; % std is assumed to be a matrix
    end
          
    if size(meanV,2)==1
        mean_m = ones(1,Nrows).*meanV;
    else
        mean_m = mean;
    end
    
    cvinv = pinv(covar);   
    cvdet = det(covar);
       
    out = CPP_cef_local_STAT_WITHIN( inpData, covar, cvinv, cvdet,  mean_m);
    o1=sum(out);
    o2=mean(out);
    o3=std(out);
end