function [inp_str,inp_data] = getData_CovType 
    fname = 'G:\WORKING\ACADEMIC\MATLAB\SKELETON\DataSets_Skeleton\\Audiology (Standardized)\audiology.standardized_combined.data';
    fname = 'C:\Users\erhan\Documents\Improved Data Skeleton and Performance\DATASETS\covtype.data\covtype.data';
    fid=fopen(fname,'r');
    % Missing Numeric Fields : ? --> 0 
    A=textscan(fid,'%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d','Delimiter',',');
    size(A)
    Nrows = size(A{1},1)
    Ncols = size(A,2)
     
    % We need to switch rows and columns
      
    inp_data = zeros(Ncols-1,Nrows);
    %inp_label = zeros(Nrows,1);           
    size(inp_data)
    % Copy numeric data first
    for n=1:54
       inp_data(n,:) = A{n}; 
    end
% % %     inp_data(1,:) = A{4};
% % %     inp_data(2,:) = A{5};
% % %     inp_data(3,:) = A{9};
% % %     inp_data(4,:) = A{33};
% % %     inp_data(5,:) = A{34};
% % %     inp_data(6,:) = A{35};
% % %     inp_data(7,:) = A{37};
% % %  
         
    % Replace Class Labels
    inp_label = A{55};
    
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