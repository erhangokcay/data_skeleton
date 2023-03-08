%function out = INFORMATION_CLASSIFIER_V0 ( dirName, fName, ind_label, percent, std, mean )
function [out] = STREAM_SKELETON_INPUT_DATASET ( inp_str, percent, flag, str, std1, T1, T2 )
        

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
               
     if ( flag==false )  
    % Nrows : # of dimensions
    % Ncols : # of samples
        [Nrows,Ncols] = size(inp_str.inp);
     else
        [Nrows,Ncols] = size(str.C_TR);
     end
    %inpp=log(inp(1:14,:));         Feature???
            
    
    % get input
%     inp_data = inp([1:ind_label-1,ind_label+1:Nrows],:);
%     
%     % Convert labels (numeric or others) starting from 1..Nlabels     
%     % make this part automatic
%     
%     inp_label = inp(ind_label,:);
%     
%     labels = unique(inp_label);
%     Nlabels = length(labels);
%     for n=1:Nlabels
%          ind = (labels==labels(n));
%          inp_label(ind)=n;
%     end    
%     
%     inp_scaled=CPP_rescale(inp_data,-1,1);    
    if ( flag==false )   
        inp_scaled = inp_str.inp;
        inp_label = inp_str.lbl;
        Nlabels = length(unique(inp_label));
        
        for n=1:Nlabels
            ind = (inp_label==n);

            NN=sum(ind);
            % NN=6000; What if samples are not same?

            randNN = randperm(NN); % 20% from each class
            rd = floor(percent*NN);

            % samples from one class
            inp_features_class = inp_scaled(:,ind); 
            inp_labels_class = inp_label(ind);

            % test and train sets
            input_test(n).fs=inp_features_class(:,randNN(1:rd));
            inp_test_labels(n).lb = inp_labels_class(randNN(1:rd))'; %make it row vector

            inp_train(n).fs=inp_features_class(:,randNN(rd+1:end));   
            
            % NOT USED ???
            inp_train_labels(n).lb = inp_labels_class(randNN(rd+1:end))';  %make it row vector  

            %w(n).ww=[ones(NN-rd,1)*cons(n)]';    
        end

        C_TE = [input_test(:).fs];
        C_TE_LB = [inp_test_labels(:).lb];

        % C_TE(1:14,:) = C_TE(1:14,:) + myC;

        C_TR = [inp_train(:).fs];
        C_TR_LB = [inp_train_labels(:).lb];
        
        strout.C_TE = C_TE;
        strout.C_TE_LB = C_TE_LB;
        strout.C_TR = C_TR;
        strout.C_TR_LB = C_TR_LB;
        % strout.inp_train = inp_train;
    else
        C_TE = str.C_TE;
        C_TE_LB = str.C_TE_LB;
        C_TR = str.C_TR;
        C_TR_LB = str.C_TR_LB;
        % inp_train = str.inp_train;
         
        strout.C_TE = C_TE;
        strout.C_TE_LB = C_TE_LB;
        strout.C_TR = C_TR;
        strout.C_TR_LB = C_TR_LB;
        % strout.inp_train = inp_train;
       
        Nlabels = length(unique([C_TR_LB C_TE_LB]));
        
    end
%--------------KNN----------------
% CREATE REDUCED DATA SET and TRAIN KNN
for n=1:Nlabels
    fprintf('label=%d\n',n);
    ind = (C_TR_LB==n);
    cl = C_TR(:,ind);                        
    clear C_TR1_n C_TR2_n C_TR3_n C_LB1_n C_LB2_n C_LB3_n
    [clust,numOfClust]=STREAM_SKELETON_VER4_nPNT(cl,std1,T1,T2,[]);
    for m=1:size(clust,2)        
        C_TR1_n(m).cl = clust(m).meanClust;      
        C_TR2_n(m).cl = clust(m).maxList;      
        C_TR3_n(m).cl = clust(m).R;
      
        C_LB1_n(m).lb = ones(1,size(C_TR1_n(m).cl,2))*n;
        C_LB2_n(m).lb = ones(1,size(C_TR2_n(m).cl,2))*n;
        C_LB3_n(m).lb = ones(1,size(C_TR3_n(m).cl,2))*n;
    end
    C_TR1_(n).cl = [C_TR1_n(:).cl];
    C_LB1_(n).lb = [C_LB1_n(:).lb];
    
    C_TR2_(n).cl = [C_TR2_n(:).cl];
    C_LB2_(n).lb = [C_LB2_n(:).lb];
    
    C_TR3_(n).cl = [C_TR3_n(:).cl];
    C_LB3_(n).lb = [C_LB3_n(:).lb];
end

% NOT USED. IT SHOULD BE DELETED
%out.C_TR_n = C_TR_n;
%out.C_LB_n = C_LB_n;

C_TR_LB_R1=[C_LB1_(:).lb];
C_TR_R1=[C_TR1_(:).cl];

C_TR_LB_R2=[C_LB2_(:).lb];
C_TR_R2=[C_TR2_(:).cl];

C_TR_LB_R3=[C_LB3_(:).lb];
C_TR_R3=[C_TR3_(:).cl];

strout.C_TR_R1 = C_TR_R1;
strout.C_TR_LB_R1 = C_TR_LB_R1;

strout.C_TR_R2 = C_TR_R2;
strout.C_TR_LB_R2 = C_TR_LB_R2;

strout.C_TR_R3 = C_TR_R3;
strout.C_TR_LB_R3 = C_TR_LB_R3;

out.str = strout;
out.percent = percent;
out.var=std1;
out.T1=T1;
out.T2=T2;

end