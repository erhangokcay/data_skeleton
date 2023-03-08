function [inp_str,inp_data] = getData_Audiology 
    fname = 'G:\WORKING\ACADEMIC\MATLAB\SKELETON\DataSets_Skeleton\\Audiology (Standardized)\audiology.standardized_combined.data';
    fid=fopen(fname,'r');
    % Missing Numeric Fields : ? --> 0 
    A=textscan(fid,'%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s','Delimiter',',');
    size(A)
    Nrows = size(A{1},1)
    Ncols = size(A,2)
     
    % We need to switch rows and columns
      
    inp_data = zeros(Ncols-2,Nrows);
    inp_label = zeros(Nrows,1);           
    size(inp_data)
    % Copy numeric data first
% % %     inp_data(1,:) = A{4};
% % %     inp_data(2,:) = A{5};
% % %     inp_data(3,:) = A{9};
% % %     inp_data(4,:) = A{33};
% % %     inp_data(5,:) = A{34};
% % %     inp_data(6,:) = A{35};
% % %     inp_data(7,:) = A{37};
% % %  
 
    
    
    % Replace Class Labels
    inp_lbl = A{71};
    labels = unique(inp_lbl);
    Nlabels = length(labels);
     for n=1:Nlabels
         ind =  strcmp(inp_lbl,labels(n));
         inp_label(ind)=n;
    end   
    
    % Replace Other character features
    list=[1:69];
    list
    cnt = 1;
    for m=list
        inp_feat = A{m};
        labels = unique(inp_feat);
        Nlabels = length(labels);
        for n=1:Nlabels
            ind =  strcmp(inp_feat,labels(n));
            inp_data(cnt,ind)=n;
        end       
        cnt = cnt + 1;
    end
    cnt  
% % %     % Replace NaN with average values for each feature
% % %     for n=1:size(inp_data,1)
% % %        mv = median(inp_data(n,isfinite(inp_data(n,:))));
% % %        ind = isnan(inp_data(n,:));
% % %        %sum(ind)
% % %        inp_data(n,ind)=mv;
% % %     end
    
    inp_str.inp=CPP_rescale(inp_data,-1,1); 
    inp_str.lbl=inp_label;
        
end