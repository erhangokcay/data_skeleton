function [inp_str,inp_data] = getData_DefaultOfCreditCardClients
    % fname = 'D:\ERHAN\CURRENT 4-9-2017\ACADEMIC\PAPERS\TO BE PUBLISHED\Information Theoretic Supervised Classifier\DATASETS\Cylinder Bands\bands.data';
	fname= 'D:\DATASETS\DATASETS\default of credit card clients\default of credit card clients.xls';
    % fid=fopen(fname,'r');
    % Missing Numeric Fields : ? --> 0 
    A=xlsread(fname);
    size(A)
	
	A=A';
	
	A(1,:)=[];
    
    % Replace Other character features
    %list=[1];
    %list
    %cnt = 8;
    %for m=list
    %    inp_feat = A{m};
    %    labels = unique(inp_feat);
    %    Nlabels = length(labels);
    %    for n=1:Nlabels
    %        ind =  strcmp(inp_feat,labels(n));
    %        inp_data(cnt,ind)=n;
    %    end       
    %    cnt = cnt + 1;
    %end
    %cnt  
    % Replace NaN with average values for each feature
    %for n=1:size(inp_data,1)
    %   mv = median(inp_data(n,isfinite(inp_data(n,:))));
    %   ind = isnan(inp_data(n,:));
    %   %sum(ind)
    %   inp_data(n,ind)=mv;
    %end
    
    inp_str.inp=CPP_rescale(A(1:end-1),-1,1); 
    inp_str.lbl=A(end,:)+1;
        
end