function [inp_str,inp_data] = EEG_EYESTATE_getData (dim)
    fname = 'G:\ERHAN\CURRENT 4-9-2017\ACADEMIC\PAPERS\TO BE PUBLISHED\Information Theoretic Supervised Classifier\DATASETS\EEG Eye State\EEG Eye State numeric.txt';
    fname='G:\WORKING\DATASETS\EEG Eye State\EEG Eye State numeric.txt';
    A=dlmread(fname,',');
    A=A';
    % get input
    %inp_data = inp([1:ind_label-1,ind_label+1:Nrows],:);
    %inp_data = log(A(1:14,:));
    inp_data = A(1:14,:);
    inp_lbl = A(15,:);
    % Convert labels (numeric or others) starting from 1..Nlabels     
    % make this part automatic
    
    inp_label = zeros(size(inp_lbl))';
    
    labels = unique(inp_lbl);
    Nlabels = length(labels);
    for n=1:Nlabels
         ind = ((inp_lbl==labels(n)));
         inp_label(ind)=n;
    end    
    disp('before CPP')
    
    % Cancel outliers ???
    for n=1:size(inp_data,1)
       mv = median(inp_data(n,:));
       ind = inp_data(n,:) > mv*1.2 | inp_data(n,:) < mv*0.8;
       inp_data(n,ind) = mv;
    end
    
    inp_str.inp=CPP_rescale(inp_data,-1,1); 
    inp_str.lbl=inp_label;
        
end