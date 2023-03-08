function [out] = STREAM_SKELETON_AVE_ALL ( inp )

Nrad = length(inp(1).knn_1.stat);
Ntest = length(inp);
Nlabel= size(inp(1).knn_1.stat(1).euc_stat,1);

for n=1:length(inp)
   %knn_euc_R1(n,:) = inp(n).knn_1.knn_euc ;    
   %knn_mah_R1(n,:) = inp(n).knn_1.knn_mah ;       
   for r=1:Nrad
        for k=1:Nlabel
            aveV.knn_euc_R1_NORMAL.euc_precision(r,n,k) = inp(n).knn_1.stat(r).euc_stat(k,k) / sum(sum (inp(n).knn_1.stat(r).euc_stat(k,:)));
            aveV.knn_euc_R1_NORMAL.euc_recall(r,n,k) = inp(n).knn_1.stat(r).euc_stat(k,k) / sum(sum (inp(n).knn_1.stat(r).euc_stat(:,k)));

            aveV.knn_euc_R1_REDUCED.euc_precision(r,n,k) = inp(n).knn_1.stat(r).euc_stat_R(k,k) / sum(sum (inp(n).knn_1.stat(r).euc_stat_R(k,:)));
            aveV.knn_euc_R1_REDUCED.euc_recall(r,n,k) = inp(n).knn_1.stat(r).euc_stat_R(k,k) / sum(sum (inp(n).knn_1.stat(r).euc_stat_R(:,k)));

            aveV.knn_euc_R2_NORMAL.euc_precision(r,n,k) = inp(n).knn_2.stat(r).euc_stat(k,k) / sum(sum (inp(n).knn_2.stat(r).euc_stat(k,:)));
            aveV.knn_euc_R2_NORMAL.euc_recall(r,n,k) = inp(n).knn_2.stat(r).euc_stat(k,k) / sum(sum (inp(n).knn_2.stat(r).euc_stat(:,k)));

            aveV.knn_euc_R2_REDUCED.euc_precision(r,n,k) = inp(n).knn_2.stat(r).euc_stat_R(k,k) / sum(sum (inp(n).knn_2.stat(r).euc_stat_R(k,:)));
            aveV.knn_euc_R2_REDUCED.euc_recall(r,n,k) = inp(n).knn_2.stat(r).euc_stat_R(k,k) / sum(sum (inp(n).knn_2.stat(r).euc_stat_R(:,k)));

            aveV.knn_euc_R3_NORMAL.euc_precision(r,n,k) = inp(n).knn_3.stat(r).euc_stat(k,k) / sum(sum (inp(n).knn_3.stat(r).euc_stat(k,:)));
            aveV.knn_euc_R3_NORMAL.euc_recall(r,n,k) = inp(n).knn_3.stat(r).euc_stat(k,k) / sum(sum (inp(n).knn_3.stat(r).euc_stat(:,k)));

            aveV.knn_euc_R3_REDUCED.euc_precision(r,n,k) = inp(n).knn_3.stat(r).euc_stat_R(k,k) / sum(sum (inp(n).knn_3.stat(r).euc_stat_R(k,:)));
            aveV.knn_euc_R3_REDUCED.euc_recall(r,n,k) = inp(n).knn_3.stat(r).euc_stat_R(k,k) / sum(sum (inp(n).knn_3.stat(r).euc_stat_R(:,k)));
  
%-----------------------------------------------------------------------------------------------           
            aveV.knn_mah_R1_NORMAL.mah_precision(r,n,k) = inp(n).knn_1.stat(r).mah_stat(k,k) / sum(sum (inp(n).knn_1.stat(r).mah_stat(k,:)));
            aveV.knn_mah_R1_NORMAL.mah_recall(r,n,k) = inp(n).knn_1.stat(r).mah_stat(k,k) / sum(sum (inp(n).knn_1.stat(r).mah_stat(:,k)));

            aveV.knn_mah_R1_REDUCED.mah_precision(r,n,k) = inp(n).knn_1.stat(r).mah_stat_R(k,k) / sum(sum (inp(n).knn_1.stat(r).mah_stat_R(k,:)));
            aveV.knn_mah_R1_REDUCED.mah_recall(r,n,k) = inp(n).knn_1.stat(r).mah_stat_R(k,k) / sum(sum (inp(n).knn_1.stat(r).mah_stat_R(:,k)));

            aveV.knn_mah_R2_NORMAL.mah_precision(r,n,k) = inp(n).knn_2.stat(r).mah_stat(k,k) / sum(sum (inp(n).knn_2.stat(r).mah_stat(k,:)));
            aveV.knn_mah_R2_NORMAL.mah_recall(r,n,k) = inp(n).knn_2.stat(r).mah_stat(k,k) / sum(sum (inp(n).knn_2.stat(r).mah_stat(:,k)));

            aveV.knn_mah_R2_REDUCED.mah_precision(r,n,k) = inp(n).knn_2.stat(r).mah_stat_R(k,k) / sum(sum (inp(n).knn_2.stat(r).mah_stat_R(k,:)));
            aveV.knn_mah_R2_REDUCED.mah_recall(r,n,k) = inp(n).knn_2.stat(r).mah_stat_R(k,k) / sum(sum (inp(n).knn_2.stat(r).mah_stat_R(:,k)));

            aveV.knn_mah_R3_NORMAL.mah_precision(r,n,k) = inp(n).knn_3.stat(r).mah_stat(k,k) / sum(sum (inp(n).knn_3.stat(r).mah_stat(k,:)));
            aveV.knn_mah_R3_NORMAL.mah_recall(r,n,k) = inp(n).knn_3.stat(r).mah_stat(k,k) / sum(sum (inp(n).knn_3.stat(r).mah_stat(:,k)));

            aveV.knn_mah_R3_REDUCED.mah_precision(r,n,k) = inp(n).knn_3.stat(r).mah_stat_R(k,k) / sum(sum (inp(n).knn_3.stat(r).mah_stat_R(k,:)));
            aveV.knn_mah_R3_REDUCED.mah_recall(r,n,k) = inp(n).knn_3.stat(r).mah_stat_R(k,k) / sum(sum (inp(n).knn_3.stat(r).mah_stat_R(:,k)));

        end
   end
end

aveV.knn_euc_R1_NORMAL.euc_precision(isnan(aveV.knn_euc_R1_NORMAL.euc_precision))=0;
aveV.knn_euc_R1_NORMAL.euc_recall(isnan(aveV.knn_euc_R1_NORMAL.euc_recall))=0;
aveV.knn_euc_R1_REDUCED.euc_precision(isnan(aveV.knn_euc_R1_REDUCED.euc_precision))=0;
aveV.knn_euc_R1_REDUCED.euc_recall(isnan(aveV.knn_euc_R1_REDUCED.euc_recall))=0;

aveV.knn_euc_R2_NORMAL.euc_precision(isnan(aveV.knn_euc_R2_NORMAL.euc_precision))=0;
aveV.knn_euc_R2_NORMAL.euc_recall(isnan(aveV.knn_euc_R2_NORMAL.euc_recall))=0;
aveV.knn_euc_R2_REDUCED.euc_precision(isnan(aveV.knn_euc_R2_REDUCED.euc_precision))=0;
aveV.knn_euc_R2_REDUCED.euc_recall(isnan(aveV.knn_euc_R2_REDUCED.euc_recall))=0;

aveV.knn_euc_R3_NORMAL.euc_precision(isnan(aveV.knn_euc_R3_NORMAL.euc_precision))=0;
aveV.knn_euc_R3_NORMAL.euc_recall(isnan(aveV.knn_euc_R3_NORMAL.euc_recall))=0;
aveV.knn_euc_R3_REDUCED.euc_precision(isnan(aveV.knn_euc_R3_REDUCED.euc_precision))=0;
aveV.knn_euc_R3_REDUCED.euc_recall(isnan(aveV.knn_euc_R3_REDUCED.euc_recall))=0;
%--------------------------------------------

aveV.knn_mah_R1_NORMAL.mah_precision(isnan(aveV.knn_mah_R1_NORMAL.mah_precision))=0;
aveV.knn_mah_R1_NORMAL.mah_recall(isnan(aveV.knn_mah_R1_NORMAL.mah_recall))=0;
aveV.knn_mah_R1_REDUCED.mah_precision(isnan(aveV.knn_mah_R1_REDUCED.mah_precision))=0;
aveV.knn_mah_R1_REDUCED.mah_recall(isnan(aveV.knn_mah_R1_REDUCED.mah_recall))=0;

aveV.knn_mah_R2_NORMAL.mah_precision(isnan(aveV.knn_mah_R2_NORMAL.mah_precision))=0;
aveV.knn_mah_R2_NORMAL.mah_recall(isnan(aveV.knn_mah_R2_NORMAL.mah_recall))=0;
aveV.knn_mah_R2_REDUCED.mah_precision(isnan(aveV.knn_mah_R2_REDUCED.mah_precision))=0;
aveV.knn_mah_R2_REDUCED.mah_recall(isnan(aveV.knn_mah_R2_REDUCED.mah_recall))=0;

aveV.knn_mah_R3_NORMAL.mah_precision(isnan(aveV.knn_mah_R3_NORMAL.mah_precision))=0;
aveV.knn_mah_R3_NORMAL.mah_recall(isnan(aveV.knn_mah_R3_NORMAL.mah_recall))=0;
aveV.knn_mah_R3_REDUCED.mah_precision(isnan(aveV.knn_mah_R3_REDUCED.mah_precision))=0;
aveV.knn_mah_R3_REDUCED.mah_recall(isnan(aveV.knn_mah_R3_REDUCED.mah_recall))=0;


len=length(inp);
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% aveV.knn_euc_R = 0;
% aveV.knn_euc = 0;
% aveV.knn_mah_R = 0;
% aveV.knn_mah  = 0;
% aveV.knn_ker_R = 0;
% aveV.knn_ker = 0;

for n=1:len
    aveV.knn_euc_R1(n,:) = inp(n).knn_1.knn_euc_R;
    aveV.knn_euc_1(n,:)  = inp(n).knn_1.knn_euc;
    aveV.knn_mah_R1(n,:) = inp(n).knn_1.knn_mah_R;
    aveV.knn_mah_1(n,:)  = inp(n).knn_1.knn_mah;
    %aveV.knn_ker_R1(n,:) = inp(n).knn_1.knn_ker_R;
    %aveV.knn_ker_1(n,:)  = inp(n).knn_1.knn_ker;         
end
for n=1:len
    aveV.knn_euc_R2(n,:) = inp(n).knn_2.knn_euc_R;
    aveV.knn_euc_2(n,:)  = inp(n).knn_2.knn_euc;
    aveV.knn_mah_R2(n,:) = inp(n).knn_2.knn_mah_R;
    aveV.knn_mah_2(n,:)  = inp(n).knn_2.knn_mah;
    %aveV.knn_ker_R2(n,:) = inp(n).knn_2.knn_ker_R;
    %aveV.knn_ker_2(n,:)  = inp(n).knn_2.knn_ker;         
end
for n=1:len
    aveV.knn_euc_R3(n,:) = inp(n).knn_3.knn_euc_R;
    aveV.knn_euc_3(n,:)  = inp(n).knn_3.knn_euc;
    aveV.knn_mah_R3(n,:) = inp(n).knn_3.knn_mah_R;
    aveV.knn_mah_3(n,:)  = inp(n).knn_3.knn_mah;
    %aveV.knn_ker_R3(n,:) = inp(n).knn_3.knn_ker_R;
    %aveV.knn_ker_3(n,:)  = inp(n).knn_3.knn_ker;         
end

% for n=1:100
%     aveV.knn_euc_R = aveV.knn_euc_R + inp(n).knn_euc_R;
%     aveV.knn_euc = aveV.knn_euc + inp(n).knn_euc;
%     aveV.knn_mah_R = aveV.knn_mah_R + inp(n).knn_mah_R;
%     aveV.knn_mah  = aveV.knn_mah + inp(n).knn_mah;
%     aveV.knn_ker_R = aveV.knn_ker_R + inp(n).knn_ker_R;
%     aveV.knn_ker = aveV.knn_ker + inp(n).knn_ker;         
% end

% aveVAL.knn_euc_R = ([aveV(:).knn_euc_R])/100;
% aveVAL.knn_euc = ([aveV(:).knn_euc])/100;
% aveVAL.knn_mah_R = ([aveV(:).knn_mah_R])/100;
% aveVAL.knn_mah = ([aveV(:).knn_mah])/100;
% aveVAL.knn_ker_R = ([aveV(:).knn_ker_R])/100;
% aveVAL.knn_ker = ([aveV(:).knn_ker])/100;
aveVAL.knn_euc_R1_NORMAL.euc_precision=100*reshape(mean( aveV.knn_euc_R1_NORMAL.euc_precision,3),Nrad,Ntest);
aveVAL.knn_euc_R1_REDUCED.euc_precision=100*reshape(mean( aveV.knn_euc_R1_REDUCED.euc_precision,3),Nrad,Ntest);
aveVAL.knn_euc_R1_NORMAL.euc_recall=100*reshape(mean( aveV.knn_euc_R1_NORMAL.euc_recall,3),Nrad,Ntest);
aveVAL.knn_euc_R1_REDUCED.euc_recall=100*reshape(mean( aveV.knn_euc_R1_REDUCED.euc_recall,3),Nrad,Ntest);

aveVAL.knn_euc_R2_NORMAL.euc_precision=100*reshape(mean( aveV.knn_euc_R2_NORMAL.euc_precision,3),Nrad,Ntest);
aveVAL.knn_euc_R2_REDUCED.euc_precision=100*reshape(mean( aveV.knn_euc_R2_REDUCED.euc_precision,3),Nrad,Ntest);
aveVAL.knn_euc_R2_NORMAL.euc_recall=100*reshape(mean( aveV.knn_euc_R2_NORMAL.euc_recall,3),Nrad,Ntest);
aveVAL.knn_euc_R2_REDUCED.euc_recall=100*reshape(mean( aveV.knn_euc_R2_REDUCED.euc_recall,3),Nrad,Ntest);

aveVAL.knn_euc_R3_NORMAL.euc_precision=100*reshape(mean( aveV.knn_euc_R3_NORMAL.euc_precision,3),Nrad,Ntest);
aveVAL.knn_euc_R3_REDUCED.euc_precision=100*reshape(mean( aveV.knn_euc_R3_REDUCED.euc_precision,3),Nrad,Ntest);
aveVAL.knn_euc_R3_NORMAL.euc_recall=100*reshape(mean( aveV.knn_euc_R3_NORMAL.euc_recall,3),Nrad,Ntest);
aveVAL.knn_euc_R3_REDUCED.euc_recall=100*reshape(mean( aveV.knn_euc_R3_REDUCED.euc_recall,3),Nrad,Ntest);

%----------------------------------------------------------------------------------
aveVAL.knn_mah_R1_NORMAL.mah_precision=100*reshape(mean( aveV.knn_mah_R1_NORMAL.mah_precision,3),Nrad,Ntest);
aveVAL.knn_mah_R1_REDUCED.mah_precision=100*reshape(mean( aveV.knn_mah_R1_REDUCED.mah_precision,3),Nrad,Ntest);
aveVAL.knn_mah_R1_NORMAL.mah_recall=100*reshape(mean( aveV.knn_mah_R1_NORMAL.mah_recall,3),Nrad,Ntest);
aveVAL.knn_mah_R1_REDUCED.mah_recall=100*reshape(mean( aveV.knn_mah_R1_REDUCED.mah_recall,3),Nrad,Ntest);

aveVAL.knn_mah_R2_NORMAL.mah_precision=100*reshape(mean( aveV.knn_mah_R2_NORMAL.mah_precision,3),Nrad,Ntest);
aveVAL.knn_mah_R2_REDUCED.mah_precision=100*reshape(mean( aveV.knn_mah_R2_REDUCED.mah_precision,3),Nrad,Ntest);
aveVAL.knn_mah_R2_NORMAL.mah_recall=100*reshape(mean( aveV.knn_mah_R2_NORMAL.mah_recall,3),Nrad,Ntest);
aveVAL.knn_mah_R2_REDUCED.mah_recall=100*reshape(mean( aveV.knn_mah_R2_REDUCED.mah_recall,3),Nrad,Ntest);

aveVAL.knn_mah_R3_NORMAL.mah_precision=100*reshape(mean( aveV.knn_mah_R3_NORMAL.mah_precision,3),Nrad,Ntest);
aveVAL.knn_mah_R3_REDUCED.mah_precision=100*reshape(mean( aveV.knn_mah_R3_REDUCED.mah_precision,3),Nrad,Ntest);
aveVAL.knn_mah_R3_NORMAL.mah_recall=100*reshape(mean( aveV.knn_mah_R3_NORMAL.mah_recall,3),Nrad,Ntest);
aveVAL.knn_mah_R3_REDUCED.mah_recall=100*reshape(mean( aveV.knn_mah_R3_REDUCED.mah_recall,3),Nrad,Ntest);


%--------------------------------------------------------------------------------

aveVAL.knn_euc_R1 = mean([aveV.knn_euc_R1]);
aveVAL.knn_euc_1 = mean([aveV.knn_euc_1]);
aveVAL.knn_mah_R1 = mean([aveV.knn_mah_R1]);
aveVAL.knn_mah_1 = mean([aveV.knn_mah_1]);
%aveVAL.knn_ker_R1 = mean([aveV(:).knn_ker_R1]);
%aveVAL.knn_ker_1 = mean([aveV(:).knn_ker_1]);
%
aveVAL.knn_euc_R2 = mean([aveV.knn_euc_R2]);
aveVAL.knn_euc_2  = mean([aveV.knn_euc_2]);
aveVAL.knn_mah_R2 = mean([aveV.knn_mah_R2]);
aveVAL.knn_mah_2  = mean([aveV.knn_mah_2]);
%aveVAL.knn_ker_R2 = mean([aveV(:).knn_ker_R2]);
%aveVAL.knn_ker_2  = mean([aveV(:).knn_ker_2]);
%
aveVAL.knn_euc_R3 = mean([aveV.knn_euc_R3]);
aveVAL.knn_euc_3  = mean([aveV.knn_euc_3]);
aveVAL.knn_mah_R3 = mean([aveV.knn_mah_R3]);
aveVAL.knn_mah_3  = mean([aveV.knn_mah_3]);
%aveVAL.knn_ker_R3 = mean([aveV(:).knn_ker_R3]);
%aveVAL.knn_ker_3  = mean([aveV(:).knn_ker_3]);
%



stdVAL.knn_euc_R1 = std([aveV.knn_euc_R1]);
stdVAL.knn_euc_1 = std([aveV.knn_euc_1]);
stdVAL.knn_mah_R1 = std([aveV.knn_mah_R1]);
stdVAL.knn_mah_1 = std([aveV.knn_mah_1]);
%stdVAL.knn_ker_R1 = std([aveV(:).knn_ker_R1]);
%stdVAL.knn_ker_1 = std([aveV(:).knn_ker_1]);
%
stdVAL.knn_euc_R2 = std([aveV.knn_euc_R2]);
stdVAL.knn_euc_2 = std([aveV.knn_euc_2]);
stdVAL.knn_mah_R2 = std([aveV.knn_mah_R2]);
stdVAL.knn_mah_2 = std([aveV.knn_mah_2]);
%stdVAL.knn_ker_R2 = std([aveV(:).knn_ker_R2]);
%stdVAL.knn_ker_2 = std([aveV(:).knn_ker_2]);
%
stdVAL.knn_euc_R3 = std([aveV.knn_euc_R3]);
stdVAL.knn_euc_3 = std([aveV.knn_euc_3]);
stdVAL.knn_mah_R3 = std([aveV.knn_mah_R3]);
stdVAL.knn_mah_3 = std([aveV.knn_mah_3]);
%stdVAL.knn_ker_R3 = std([aveV(:).knn_ker_R3]);
%stdVAL.knn_ker_3 = std([aveV(:).knn_ker_3]);

out.knn_mean=aveVAL;
out.knn_std=stdVAL;

for n=1:len
    svm(n).outSVMlinear_1 = inp(n).svm_1.outSVMlinear;      
    svm(n).outSVMlinear_R1 = inp(n).svm_1.outSVMlinear_R;    
    svm(n).outSVMrbf_1 = inp(n).svm_1.outSVMrbf;         
    svm(n).outSVMrbf_R1 = inp(n).svm_1.outSVMrbf_R;       
    svm(n).outSVMrbf_1_1 = inp(n).svm_1.outSVMrbf_1;       
    svm(n).outSVMrbf_1_R1 = inp(n).svm_1.outSVMrbf_1_R;     
    svm(n).outSVMrbf_2_1 = inp(n).svm_1.outSVMrbf_2;       
    svm(n).outSVMrbf_2_R1 = inp(n).svm_1.outSVMrbf_2_R;
    svm(n).outSVMrbf_3_1 = inp(n).svm_1.outSVMrbf_3;       
    svm(n).outSVMrbf_3_R1 = inp(n).svm_1.outSVMrbf_3_R;
    svm(n).outSVMrbf_4_1 = inp(n).svm_1.outSVMrbf_4;       
    svm(n).outSVMrbf_4_R1 = inp(n).svm_1.outSVMrbf_4_R;
end
for n=1:len
    svm(n).outSVMlinear_2   = inp(n).svm_2.outSVMlinear;      
    svm(n).outSVMlinear_R2  = inp(n).svm_2.outSVMlinear_R;    
    svm(n).outSVMrbf_2      = inp(n).svm_2.outSVMrbf;         
    svm(n).outSVMrbf_R2     = inp(n).svm_2.outSVMrbf_R;       
    svm(n).outSVMrbf_1_2    = inp(n).svm_2.outSVMrbf_1;       
    svm(n).outSVMrbf_1_R2   = inp(n).svm_2.outSVMrbf_1_R;     
    svm(n).outSVMrbf_2_2    = inp(n).svm_2.outSVMrbf_2;       
    svm(n).outSVMrbf_2_R2   = inp(n).svm_2.outSVMrbf_2_R;
    svm(n).outSVMrbf_3_2    = inp(n).svm_2.outSVMrbf_3;       
    svm(n).outSVMrbf_3_R2   = inp(n).svm_2.outSVMrbf_3_R;
    svm(n).outSVMrbf_4_2    = inp(n).svm_2.outSVMrbf_4;       
    svm(n).outSVMrbf_4_R2   = inp(n).svm_2.outSVMrbf_4_R;
end
for n=1:len
    svm(n).outSVMlinear_3   = inp(n).svm_3.outSVMlinear;      
    svm(n).outSVMlinear_R3  = inp(n).svm_3.outSVMlinear_R;    
    svm(n).outSVMrbf_3      = inp(n).svm_3.outSVMrbf;         
    svm(n).outSVMrbf_R3     = inp(n).svm_3.outSVMrbf_R;       
    svm(n).outSVMrbf_1_3    = inp(n).svm_3.outSVMrbf_1;       
    svm(n).outSVMrbf_1_R3   = inp(n).svm_3.outSVMrbf_1_R;     
    svm(n).outSVMrbf_2_3    = inp(n).svm_3.outSVMrbf_2;       
    svm(n).outSVMrbf_2_R3   = inp(n).svm_3.outSVMrbf_2_R;
    svm(n).outSVMrbf_3_3    = inp(n).svm_3.outSVMrbf_3;       
    svm(n).outSVMrbf_3_R3   = inp(n).svm_3.outSVMrbf_3_R;
    svm(n).outSVMrbf_4_3    = inp(n).svm_3.outSVMrbf_4;       
    svm(n).outSVMrbf_4_R3   = inp(n).svm_3.outSVMrbf_4_R;
end

svmAVE.outSVMlinear_1 = mean([svm(:).outSVMlinear_1]);      
svmAVE.outSVMlinear_R1 = mean([svm(:).outSVMlinear_R1]);    
svmAVE.outSVMrbf_1 = mean([svm(:).outSVMrbf_1]);         
svmAVE.outSVMrbf_R1 = mean([svm(:).outSVMrbf_R1]);       
svmAVE.outSVMrbf_1_1 = mean([svm(:).outSVMrbf_1_1]);       
svmAVE.outSVMrbf_1_R1 = mean([svm(:).outSVMrbf_1_R1]);     
svmAVE.outSVMrbf_2_1 = mean([svm(:).outSVMrbf_2_1]);       
svmAVE.outSVMrbf_2_R1 = mean([svm(:).outSVMrbf_2_R1]);
svmAVE.outSVMrbf_3_1 = mean([svm(:).outSVMrbf_3_1]);       
svmAVE.outSVMrbf_3_R1 = mean([svm(:).outSVMrbf_3_R1]);
svmAVE.outSVMrbf_4_1 = mean([svm(:).outSVMrbf_4_1]);       
svmAVE.outSVMrbf_4_R1 = mean([svm(:).outSVMrbf_4_R1]);
%
svmAVE.outSVMlinear_2   = mean([svm(:).outSVMlinear_2]);      
svmAVE.outSVMlinear_R2  = mean([svm(:).outSVMlinear_R2]);    
svmAVE.outSVMrbf_2      = mean([svm(:).outSVMrbf_2]);         
svmAVE.outSVMrbf_R2     = mean([svm(:).outSVMrbf_R2]);       
svmAVE.outSVMrbf_1_2    = mean([svm(:).outSVMrbf_1_2]);       
svmAVE.outSVMrbf_1_R2   = mean([svm(:).outSVMrbf_1_R2]);     
svmAVE.outSVMrbf_2_2    = mean([svm(:).outSVMrbf_2_2]);       
svmAVE.outSVMrbf_2_R2   = mean([svm(:).outSVMrbf_2_R2]);
svmAVE.outSVMrbf_3_2    = mean([svm(:).outSVMrbf_3_2]);       
svmAVE.outSVMrbf_3_R2   = mean([svm(:).outSVMrbf_3_R2]);
svmAVE.outSVMrbf_4_2    = mean([svm(:).outSVMrbf_4_2]);       
svmAVE.outSVMrbf_4_R2   = mean([svm(:).outSVMrbf_4_R2]);
%
svmAVE.outSVMlinear_3 = mean([svm(:).outSVMlinear_3]);      
svmAVE.outSVMlinear_R3 = mean([svm(:).outSVMlinear_R3]);    
svmAVE.outSVMrbf_3 = mean([svm(:).outSVMrbf_3]);         
svmAVE.outSVMrbf_R3 = mean([svm(:).outSVMrbf_R3]);       
svmAVE.outSVMrbf_1_3 = mean([svm(:).outSVMrbf_1_3]);       
svmAVE.outSVMrbf_1_R3 = mean([svm(:).outSVMrbf_1_R3]);     
svmAVE.outSVMrbf_2_3 = mean([svm(:).outSVMrbf_2_3]);       
svmAVE.outSVMrbf_2_R3 = mean([svm(:).outSVMrbf_2_R3]);
svmAVE.outSVMrbf_3_3 = mean([svm(:).outSVMrbf_3_3]);       
svmAVE.outSVMrbf_3_R3 = mean([svm(:).outSVMrbf_3_R3]);
svmAVE.outSVMrbf_4_3 = mean([svm(:).outSVMrbf_4_3]);       
svmAVE.outSVMrbf_4_R3 = mean([svm(:).outSVMrbf_4_R3]);




svmSTD.outSVMlinear_1   = std([svm(:).outSVMlinear_1]);      
svmSTD.outSVMlinear_R_1 = std([svm(:).outSVMlinear_R1]);    
svmSTD.outSVMrbf_1      = std([svm(:).outSVMrbf_1]);         
svmSTD.outSVMrbf_R_1    = std([svm(:).outSVMrbf_R1]);       
svmSTD.outSVMrbf_1_1    = std([svm(:).outSVMrbf_1_1]);       
svmSTD.outSVMrbf_1_R_1  = std([svm(:).outSVMrbf_1_R1]);     
svmSTD.outSVMrbf_2_1    = std([svm(:).outSVMrbf_2_1]);       
svmSTD.outSVMrbf_2_R_1  = std([svm(:).outSVMrbf_2_R1]);
svmSTD.outSVMrbf_3_1    = std([svm(:).outSVMrbf_3_1]);       
svmSTD.outSVMrbf_3_R_1  = std([svm(:).outSVMrbf_3_R1]);
svmSTD.outSVMrbf_4_1    = std([svm(:).outSVMrbf_4_1]);       
svmSTD.outSVMrbf_5_R_1  = std([svm(:).outSVMrbf_4_R1]);
%
svmSTD.outSVMlinear_2   = std([svm(:).outSVMlinear_2]);      
svmSTD.outSVMlinear_R_2 = std([svm(:).outSVMlinear_R2]);    
svmSTD.outSVMrbf_2      = std([svm(:).outSVMrbf_2]);         
svmSTD.outSVMrbf_R_2    = std([svm(:).outSVMrbf_R2]);       
svmSTD.outSVMrbf_1_2    = std([svm(:).outSVMrbf_1_2]);       
svmSTD.outSVMrbf_1_R_2  = std([svm(:).outSVMrbf_1_R2]);     
svmSTD.outSVMrbf_2_2    = std([svm(:).outSVMrbf_2_2]);       
svmSTD.outSVMrbf_2_R_2  = std([svm(:).outSVMrbf_2_R2]);
svmSTD.outSVMrbf_3_2    = std([svm(:).outSVMrbf_3_2]);       
svmSTD.outSVMrbf_3_R_2  = std([svm(:).outSVMrbf_3_R2]);
svmSTD.outSVMrbf_4_2    = std([svm(:).outSVMrbf_4_2]);       
svmSTD.outSVMrbf_5_R_2  = std([svm(:).outSVMrbf_4_R2]);
%
svmSTD.outSVMlinear_3   = std([svm(:).outSVMlinear_3]);      
svmSTD.outSVMlinear_R_3 = std([svm(:).outSVMlinear_R3]);    
svmSTD.outSVMrbf_3      = std([svm(:).outSVMrbf_3]);         
svmSTD.outSVMrbf_R_3    = std([svm(:).outSVMrbf_R3]);       
svmSTD.outSVMrbf_1_3    = std([svm(:).outSVMrbf_1_3]);       
svmSTD.outSVMrbf_1_R_3  = std([svm(:).outSVMrbf_1_R3]);     
svmSTD.outSVMrbf_2_3    = std([svm(:).outSVMrbf_2_3]);       
svmSTD.outSVMrbf_2_R_3  = std([svm(:).outSVMrbf_2_R3]);
svmSTD.outSVMrbf_3_3    = std([svm(:).outSVMrbf_3_3]);       
svmSTD.outSVMrbf_3_R_3  = std([svm(:).outSVMrbf_3_R3]);
svmSTD.outSVMrbf_4_3    = std([svm(:).outSVMrbf_4_3]);       
svmSTD.outSVMrbf_5_R_3  = std([svm(:).outSVMrbf_4_R3]);


out.svm_mean=svmAVE;   
out.svm_std=svmSTD;  

out.Rper1 = 0;
for n=1:100
    out.Rper1 = out.Rper1 + 100-100*size(inp(n).str.str.C_TR_R1,2)/size(inp(n).str.str.C_TR,2);
end
out.Rper1 = out.Rper1 / 100;

out.Rper2 = 0;
for n=1:100
    out.Rper2 = out.Rper2 + 100-100*size(inp(n).str.str.C_TR_R2,2)/size(inp(n).str.str.C_TR,2);
end
out.Rper2 = out.Rper2 / 100;


out.Rper3 = 0;
for n=1:100
    out.Rper3 = out.Rper3 + 100-100*size(inp(n).str.str.C_TR_R3,2)/size(inp(n).str.str.C_TR,2);
end
out.Rper3 = out.Rper3 / 100;
end

