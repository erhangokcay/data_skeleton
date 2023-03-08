%function out = INFORMATION_CLASSIFIER_V0 ( dirName, fName, ind_label, percent, std, mean )
function [out,strout] = STREAM_SKELETON_PERFORMANCE_V0 ( inp_str, percent, std1, std2, mean, flag, str, T1, T2, select )
        

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
    
    % Variance 
    if size(std1,2)==1
        covar1 = eye(Nrows)*std1^2;
    else
        % square of std is taken in the var2cov function. But
        % this creates a confusion. FIX IT LATER
        covar1 = std1.^2; % std is assumed to be a matrix
    end
    % Variance 
    if size(std2,2)==1
        covar2 = eye(Nrows)*std2^2;
    else
        % square of std is taken in the var2cov function. But
        % this creates a confusion. FIX IT LATER
        covar2 = std2.^2; % std is assumed to be a matrix
    end
      
    if size(mean,2)==1
        mean_m = ones(1,Nrows).*mean;
    else
        mean_m = mean;
    end
    
    cvinv1 = pinv(covar1);
    cvinv2 = pinv(covar2);
    
    cvdet1 = det(covar1);
    cvdet2 = det(covar2);
    
    % ---------------------             
    
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
        strout.inp_train = inp_train;
    else
        C_TE = str.C_TE;
        C_TE_LB = str.C_TE_LB;
        C_TR = str.C_TR;
        C_TR_LB = str.C_TR_LB;
        inp_train = str.inp_train;
         
        strout.C_TE = C_TE;
        strout.C_TE_LB = C_TE_LB;
        strout.C_TR = C_TR;
        strout.C_TR_LB = C_TR_LB;
        strout.inp_train = inp_train;
       
        Nlabels = length(unique([C_TR_LB C_TE_LB]));
        
%         for n=1:Nlabels
%             ind = (C_TR_LB(:)==n);
%             inp_train(n).fs=C_TR(:,ind);
%         end                
    end    
    
%-------------CEF NO WEIGHTS----------------
%
%CPP_cef_local(ones(1,1),ones(1,5),[2].^2,[0.5].^2,det([2].^2),[0,0])
%
%C_TE_TEST = size(C_TE);
%C_TE_IND(1).IND = zeros(cefRad,size(C_TE,2));
%C_TE_IND(2).IND = zeros(cefRad,size(C_TE,2));
 

%out.p1=stat;

%--------------KNN----------------
% CREATE REDUCED DATA SET and TRAIN KNN
for n=1:Nlabels
    ind = (C_TR_LB==n);
    cl = C_TR(:,ind);                        
    
    [clust,numOfClust]=STREAM_SKELETON_VER4_nPNT(cl,std1,T1,T2);
    for m=1:size(clust,2)
        if ( select == 1) 
            C_TR_n(m).cl = clust(m).meanClust;
        elseif ( select == 2)
             C_TR_n(m).cl = clust(m).maxList;
        elseif ( select == 2)
             C_TR_n(m).cl = clust(m).R;
        end
        C_LB_n(m).lb = ones(1,size(C_TR_n(m).cl,2))*n;
    end
    C_TR_(n).cl = [C_TR_n(:).cl];
    C_LB_(n).lb = [C_LB_n(:).lb];
end

% NOT USED. IT SHOULD BE DELETED
% out.C_TR_n = C_TR_n;
% out.C_LB_n = C_LB_n;

C_TR_LB_R=[C_LB_(:).lb];
C_TR_R=[C_TR_(:).cl];
strout.C_TR_R = C_TR_R;
strout.C_TR_LB_R = C_TR_LB_R;

% ----------------------------------KNN-----------------------------------------
out_knn = STREAM_SKELETON_PERFORMANCE_KNN_CMP(inp);
o.knn = out_knn;
%--------------------------------------------------------------------------------

% ----------------------------------SVM-----------------------------------------
out_svm = STREAM_SKELETON_PERFORMANCE_SVM_CMP(inp);
o.svm = out_svm;
%--------------------------------------------------------------------------------

out = o;
end