function [inp_str,inp_data] = getData_ElectricGrid 
    %fname = 'G:\WORKING\ACADEMIC\MATLAB\SKELETON\DataSets_Skeleton\\Audiology (Standardized)\audiology.standardized_combined.data';
   
    total_inp_data=[];
    total_inp_label=[];
    
 
        fname = 'C:\Users\erhan\Documents\Improved Data Skeleton and Performance\DATASETS\Electrical Grid Stability\Data_for_UCI_named.csv';
        fid=fopen(fname,'r');
        % Missing Numeric Fields : ? --> 0 
        A=textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%s','Delimiter',',');
        size(A)
        Nrows = size(A{1},1)
        Ncols = size(A,2)

        % We need to switch rows and columns

        inp_data = zeros(Ncols-1,Nrows);
        %inp_label = zeros(Nrows,1);           
        size(inp_data)
        % Copy numeric data first
        for n=1:13
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
        inp_lbl = A{14};

    % % %     % Replace NaN with average values for each feature
    % % %     for n=1:size(inp_data,1)
    % % %        mv = median(inp_data(n,isfinite(inp_data(n,:))));
    % % %        ind = isnan(inp_data(n,:));
    % % %        %sum(ind)
    % % %        inp_data(n,ind)=mv;
    % % %     end
        fclose(fid);
        
         labels = unique(inp_lbl);
            Nlabels = length(labels);

         for n=1:Nlabels
             ind = strcmp(inp_lbl,labels(n));
             inp_label(ind,1)=n;
         end       
    
        
       
        
    inp_str.inp=CPP_rescale(inp_data,-1,1); 
    inp_str.lbl=inp_label;
        
end