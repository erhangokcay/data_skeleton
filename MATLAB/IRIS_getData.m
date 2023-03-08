function inp_str = IRIS_getData
    load fisheriris        
    % get input
    %inp_data = inp([1:ind_label-1,ind_label+1:Nrows],:);
    inp_data = meas';
    
    % Convert labels (numeric or others) starting from 1..Nlabels     
    % make this part automatic
    
    inp_label = zeros(size(species));
    
    labels = unique(species);
    Nlabels = length(labels);
    for n=1:Nlabels
         ind = (strcmp(species,labels(n)));
         inp_label(ind)=n;
    end    
    
    inp_str.inp=CPP_rescale(inp_data,-1,1); 
    inp_str.lbl=inp_label;
        
end