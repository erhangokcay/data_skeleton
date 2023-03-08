function [inp_str,inp_data] = getData_IRIS 


    
    load fisheriris;
   
    labels = unique(species);
    Nlabels = length(labels);
  
    inp_label = zeros(Nlabels,1);           
    
    % Copy numeric data first

    inp_data = meas';
    inp_lbl = species;        
    % Replace Class Labels
   

     for n=1:Nlabels
         ind = strcmp(inp_lbl,labels(n));
         inp_label(ind)=n;
    end          
    
    inp_str.inp=CPP_rescale(inp_data,-1,1); 
    inp_str.lbl=inp_label;
        
end