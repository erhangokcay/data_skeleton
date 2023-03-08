function [inp_str,inp_data] = getData_Datasets_Healthy_Older_People 
    %fname = 'G:\WORKING\ACADEMIC\MATLAB\SKELETON\DataSets_Skeleton\\Audiology (Standardized)\audiology.standardized_combined.data';
    dname = 'C:\Users\erhan\Documents\Improved Data Skeleton and Performance\DATASETS\Datasets_Healthy_Older_People\S1_Dataset\';
     
    flist = dir('d*');
    
    fCnt = size(flist,1),
    
    total_inp_data=[];
    total_inp_label=[];
    
    for f=1:fCnt
        fname = strcat(dname,flist(f).name);
        fid=fopen(fname,'r');
        % Missing Numeric Fields : ? --> 0 
        A=textscan(fid,'%f%f%f%f%f%f%f%f%d','Delimiter',',');
        size(A)
        Nrows = size(A{1},1)
        Ncols = size(A,2)

        % We need to switch rows and columns

        inp_data = zeros(Ncols-1,Nrows);
        %inp_label = zeros(Nrows,1);           
        size(inp_data)
        % Copy numeric data first
        for n=1:8
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
        inp_label = A{9};

    % % %     % Replace NaN with average values for each feature
    % % %     for n=1:size(inp_data,1)
    % % %        mv = median(inp_data(n,isfinite(inp_data(n,:))));
    % % %        ind = isnan(inp_data(n,:));
    % % %        %sum(ind)
    % % %        inp_data(n,ind)=mv;
    % % %     end
        fclose(fid);
        
        total_inp_data = [total_inp_data, inp_data];
        total_inp_label = [total_inp_label; inp_label];
    end
    inp_str.inp=CPP_rescale(total_inp_data,-1,1); 
    inp_str.lbl=total_inp_label;
        
end