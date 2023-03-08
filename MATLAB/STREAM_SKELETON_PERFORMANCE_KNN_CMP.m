%function out = INFORMATION_CLASSIFIER_V0 ( dirName, fName, ind_label, percent, std, mean )
function [out] = STREAM_SKELETON_PERFORMANCE_KNN_CMP (inp,select)        

inp_str=inp.str;
% Reduced Data
if ( select == 1)
    C_TR_LB_R=inp_str.C_TR_LB_R1;
    C_TR_R=inp_str.C_TR_R1;
elseif(select == 2)
    C_TR_LB_R=inp_str.C_TR_LB_R2;
    C_TR_R=inp_str.C_TR_R2;
elseif(select == 3)
    C_TR_LB_R=inp_str.C_TR_LB_R3;
    C_TR_R=inp_str.C_TR_R3;
end        
% Original Data
C_TR_LB=inp_str.C_TR_LB;
C_TR=inp_str.C_TR;
% Original Test Set
C_TE_LB=inp_str.C_TE_LB;
C_TE=inp_str.C_TE;

rad_list = [1,2,4,8,16,32];
Nlabels = length(unique([C_TR_LB C_TE_LB]));

for zN=1:length(rad_list) 
    fprintf('rad1= %d\n',zN);
        euc_stat = zeros(Nlabels,Nlabels);

        %C_TE(1:14,:) = C_TE(1:14,:) - myC;
        try
            mdlKNN = ClassificationKNN.fit(C_TR_R',C_TR_LB_R,'NumNeighbors' ,rad_list(zN) ,'Distance', 'euclidean' );
        catch me
            disp('---------------------Euc exception R----------------------')
            disp(rad_list(zN))
        end
        outKNN=predict(mdlKNN,C_TE');       

        for n=1:size(C_TE,2)
            euc_stat(C_TE_LB(n),outKNN(n)) = euc_stat(C_TE_LB(n),outKNN(n)) + 1;
        end
        o.stat(zN).euc_stat_R = euc_stat;
        o.knn_euc_R(zN) = (100*sum(diag(euc_stat))/size(C_TE,2));

        %disp(100*sum(diag(stat))/size(C_TE,2))
end

% Use REGULAR DATA SET ansd TRAIN KNN
for zN=1:length(rad_list) 
        fprintf('rad2= %d\n',zN);

        euc_stat = zeros(Nlabels,Nlabels);

        %C_TE(1:14,:) = C_TE(1:14,:) - myC;
        try
            mdlKNN = ClassificationKNN.fit(C_TR',C_TR_LB,'NumNeighbors' ,rad_list(zN) ,'Distance', 'euclidean' );
         catch me
            disp('-------------------Euc exception-----------------------')
            disp(rad_list(zN))
        end
        outKNN=predict(mdlKNN,C_TE');       

        for n=1:size(C_TE,2)
            euc_stat(C_TE_LB(n),outKNN(n)) = euc_stat(C_TE_LB(n),outKNN(n)) + 1;
        end
        o.stat(zN).euc_stat = euc_stat;
        o.knn_euc(zN) = (100*sum(diag(euc_stat))/size(C_TE,2));

        %disp(100*sum(diag(stat))/size(C_TE,2))
end

%=======================================================================

for zN=1:length(rad_list) 
        fprintf('rad3= %d\n',zN);

        mah_stat = zeros(Nlabels,Nlabels);
        %unique(C_TR_LB)
        %size(C_TR)
        %C_TE(1:14,:) = C_TE(1:14,:) - myC;
        try 
            mdlKNN = ClassificationKNN.fit(C_TR_R',C_TR_LB_R,'NumNeighbors' ,rad_list(zN),'Distance', 'mahalanobis' );
            outKNN=predict(mdlKNN,C_TE');
       
            for n=1:size(C_TE,2)
                mah_stat(C_TE_LB(n),outKNN(n)) = mah_stat(C_TE_LB(n),outKNN(n)) + 1;
            end
        
            o.stat(zN).mah_stat_R = mah_stat;
        
            o.knn_mah_R(zN) = (100*sum(diag(mah_stat))/size(C_TE,2));
        catch me
            disp('----------------------Mahalabonis exception R-----------------')
            disp(me);
            disp(rad_list(zN))
            o.knn_mah_R(zN) = NaN;
            o.stat(zN).mah_stat_R = mah_stat;
        end

        %disp(100*sum(diag(stat))/size(C_TE,2))
end


for zN=1:length(rad_list) 
        fprintf('rad4= %d\n',zN);

        mah_stat = zeros(Nlabels,Nlabels);
        %unique(C_TR_LB)
        %size(C_TR)
        %C_TE(1:14,:) = C_TE(1:14,:) - myC;
        try 
            mdlKNN = ClassificationKNN.fit(C_TR',C_TR_LB,'NumNeighbors' ,rad_list(zN),'Distance', 'mahalanobis' );
        catch me
            disp('------------------------Mahalabonis exception----------------')
            disp(rad_list(zN))
        end
        outKNN=predict(mdlKNN,C_TE');
       
        for n=1:size(C_TE,2)
            mah_stat(C_TE_LB(n),outKNN(n)) = mah_stat(C_TE_LB(n),outKNN(n)) + 1;
        end
        
        o.stat(zN).mah_stat = mah_stat;
        
        o.knn_mah(zN) = (100*sum(diag(mah_stat))/size(C_TE,2));

        %disp(100*sum(diag(stat))/size(C_TE,2))
end

% -----------------------------------------NOT USED HERE----------------------------------------------
% % 
% % for zN=1:length(rad_list) 
% %         ker_stat = zeros(Nlabels,Nlabels);
% %  
% %         %C_TE(1:14,:) = C_TE(1:14,:) - myC;
% %         try
% %             mdlKNN = ClassificationKNN.fit(C_TR_R',C_TR_LB_R,'NumNeighbors' ,rad_list(zN) ,'Distance', @KNN_DIST_FUNC );
% %          catch me
% %             disp('--------------------Kernel exception R----------------------')
% %             disp(rad_list(zN))
% %         end
% %         outKNN=predict(mdlKNN,C_TE');       
% % 
% %         for n=1:size(C_TE,2)
% %             ker_stat(C_TE_LB(n),outKNN(n)) = ker_stat(C_TE_LB(n),outKNN(n)) + 1;
% %         end
% %         
% %         o.stat(zN).ker_stat_R = ker_stat;
% %         
% %         o.knn_ker_R(zN) = (100*sum(diag(ker_stat))/size(C_TE,2));
% % 
% %         %disp(100*sum(diag(stat))/size(C_TE,2))
% % end
% % 
% % for zN=1:length(rad_list) 
% %         ker_stat = zeros(Nlabels,Nlabels);
% %  
% %         %C_TE(1:14,:) = C_TE(1:14,:) - myC;
% %         try
% %             mdlKNN = ClassificationKNN.fit(C_TR',C_TR_LB,'NumNeighbors' ,rad_list(zN) ,'Distance', @KNN_DIST_FUNC );
% %          catch me
% %             disp('-----------------------Kernel exception---------------------')
% %             disp(rad_list(zN))
% %         end
% %         outKNN=predict(mdlKNN,C_TE');       
% % 
% %         for n=1:size(C_TE,2)
% %             ker_stat(C_TE_LB(n),outKNN(n)) = ker_stat(C_TE_LB(n),outKNN(n)) + 1;
% %         end
% %         
% %         o.stat(zN).ker_stat = ker_stat;
% %         
% %         o.knn_ker(zN) = (100*sum(diag(ker_stat))/size(C_TE,2));
% % 
% %         %disp(100*sum(diag(stat))/size(C_TE,2))
% % end
% % 


o.radlst = rad_list;

out = o;
end