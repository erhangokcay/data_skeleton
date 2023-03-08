function [out] = STREAM_SKELETON_AVE_ALL_V3_CORRECTED ( inpData )

Ntest = length(inpData);

for n=1:Ntest
    inp = inpData(n).Train;
    
    Nrad = length(inp.knn_1.stat);
    Nlabel= size(inp.knn_1.stat(1).euc_stat,1);

   
   %knn_euc_R1(n,:) = inp.knn_1.knn_euc ;    
   %knn_mah_R1(n,:) = inp.knn_1.knn_mah ;       
   for r=1:Nrad
        for k=1:Nlabel
            aveV.knn_euc_R1_NORMAL.euc_precision(r,n,k) = inp.knn_1.stat(r).euc_stat(k,k) / sum(sum (inp.knn_1.stat(r).euc_stat(k,:)));
            aveV.knn_euc_R1_NORMAL.euc_recall(r,n,k) = inp.knn_1.stat(r).euc_stat(k,k) / sum(sum (inp.knn_1.stat(r).euc_stat(:,k)));

            aveV.knn_euc_R1_REDUCED.euc_precision(r,n,k) = inp.knn_1.stat(r).euc_stat_R(k,k) / sum(sum (inp.knn_1.stat(r).euc_stat_R(k,:)));
            aveV.knn_euc_R1_REDUCED.euc_recall(r,n,k) = inp.knn_1.stat(r).euc_stat_R(k,k) / sum(sum (inp.knn_1.stat(r).euc_stat_R(:,k)));

            aveV.knn_euc_R2_NORMAL.euc_precision(r,n,k) = inp.knn_2.stat(r).euc_stat(k,k) / sum(sum (inp.knn_2.stat(r).euc_stat(k,:)));
            aveV.knn_euc_R2_NORMAL.euc_recall(r,n,k) = inp.knn_2.stat(r).euc_stat(k,k) / sum(sum (inp.knn_2.stat(r).euc_stat(:,k)));

            aveV.knn_euc_R2_REDUCED.euc_precision(r,n,k) = inp.knn_2.stat(r).euc_stat_R(k,k) / sum(sum (inp.knn_2.stat(r).euc_stat_R(k,:)));
            aveV.knn_euc_R2_REDUCED.euc_recall(r,n,k) = inp.knn_2.stat(r).euc_stat_R(k,k) / sum(sum (inp.knn_2.stat(r).euc_stat_R(:,k)));

            aveV.knn_euc_R3_NORMAL.euc_precision(r,n,k) = inp.knn_3.stat(r).euc_stat(k,k) / sum(sum (inp.knn_3.stat(r).euc_stat(k,:)));
            aveV.knn_euc_R3_NORMAL.euc_recall(r,n,k) = inp.knn_3.stat(r).euc_stat(k,k) / sum(sum (inp.knn_3.stat(r).euc_stat(:,k)));

            aveV.knn_euc_R3_REDUCED.euc_precision(r,n,k) = inp.knn_3.stat(r).euc_stat_R(k,k) / sum(sum (inp.knn_3.stat(r).euc_stat_R(k,:)));
            aveV.knn_euc_R3_REDUCED.euc_recall(r,n,k) = inp.knn_3.stat(r).euc_stat_R(k,k) / sum(sum (inp.knn_3.stat(r).euc_stat_R(:,k)));
  
%-----------------------------------------------------------------------------------------------           
            aveV.knn_mah_R1_NORMAL.mah_precision(r,n,k) = inp.knn_1.stat(r).mah_stat(k,k) / sum(sum (inp.knn_1.stat(r).mah_stat(k,:)));
            aveV.knn_mah_R1_NORMAL.mah_recall(r,n,k) = inp.knn_1.stat(r).mah_stat(k,k) / sum(sum (inp.knn_1.stat(r).mah_stat(:,k)));

            aveV.knn_mah_R1_REDUCED.mah_precision(r,n,k) = inp.knn_1.stat(r).mah_stat_R(k,k) / sum(sum (inp.knn_1.stat(r).mah_stat_R(k,:)));
            aveV.knn_mah_R1_REDUCED.mah_recall(r,n,k) = inp.knn_1.stat(r).mah_stat_R(k,k) / sum(sum (inp.knn_1.stat(r).mah_stat_R(:,k)));

            aveV.knn_mah_R2_NORMAL.mah_precision(r,n,k) = inp.knn_2.stat(r).mah_stat(k,k) / sum(sum (inp.knn_2.stat(r).mah_stat(k,:)));
            aveV.knn_mah_R2_NORMAL.mah_recall(r,n,k) = inp.knn_2.stat(r).mah_stat(k,k) / sum(sum (inp.knn_2.stat(r).mah_stat(:,k)));

            aveV.knn_mah_R2_REDUCED.mah_precision(r,n,k) = inp.knn_2.stat(r).mah_stat_R(k,k) / sum(sum (inp.knn_2.stat(r).mah_stat_R(k,:)));
            aveV.knn_mah_R2_REDUCED.mah_recall(r,n,k) = inp.knn_2.stat(r).mah_stat_R(k,k) / sum(sum (inp.knn_2.stat(r).mah_stat_R(:,k)));

            aveV.knn_mah_R3_NORMAL.mah_precision(r,n,k) = inp.knn_3.stat(r).mah_stat(k,k) / sum(sum (inp.knn_3.stat(r).mah_stat(k,:)));
            aveV.knn_mah_R3_NORMAL.mah_recall(r,n,k) = inp.knn_3.stat(r).mah_stat(k,k) / sum(sum (inp.knn_3.stat(r).mah_stat(:,k)));

            aveV.knn_mah_R3_REDUCED.mah_precision(r,n,k) = inp.knn_3.stat(r).mah_stat_R(k,k) / sum(sum (inp.knn_3.stat(r).mah_stat_R(k,:)));
            aveV.knn_mah_R3_REDUCED.mah_recall(r,n,k) = inp.knn_3.stat(r).mah_stat_R(k,k) / sum(sum (inp.knn_3.stat(r).mah_stat_R(:,k)));

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


len=length(inpData);
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% aveV.knn_euc_R = 0;
% aveV.knn_euc = 0;
% aveV.knn_mah_R = 0;
% aveV.knn_mah  = 0;
% aveV.knn_ker_R = 0;
% aveV.knn_ker = 0;

% for n=1:100
%     aveV.knn_euc_R = aveV.knn_euc_R + inp.knn_euc_R;
%     aveV.knn_euc = aveV.knn_euc + inp.knn_euc;
%     aveV.knn_mah_R = aveV.knn_mah_R + inp.knn_mah_R;
%     aveV.knn_mah  = aveV.knn_mah + inp.knn_mah;
%     aveV.knn_ker_R = aveV.knn_ker_R + inp.knn_ker_R;
%     aveV.knn_ker = aveV.knn_ker + inp.knn_ker;         
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
% --------------------------------------------
aveVAL.knn_euc_R1_euc_precision_ERR = ( abs(mean([aveVAL.knn_euc_R1_NORMAL.euc_precision],2)-mean([aveVAL.knn_euc_R1_REDUCED.euc_precision],2)))';
aveVAL.knn_euc_R1_euc_recall_ERR = ( abs(mean([aveVAL.knn_euc_R1_NORMAL.euc_recall],2)-mean([aveVAL.knn_euc_R1_REDUCED.euc_recall],2)))';
aveVAL.knn_euc_R2_euc_precision_ERR = ( abs(mean([aveVAL.knn_euc_R2_NORMAL.euc_precision],2)-mean([aveVAL.knn_euc_R2_REDUCED.euc_precision],2)))';
aveVAL.knn_euc_R2_euc_recall_ERR = ( abs(mean([aveVAL.knn_euc_R2_NORMAL.euc_recall],2)-mean([aveVAL.knn_euc_R2_REDUCED.euc_recall],2)))';
aveVAL.knn_euc_R3_euc_precision_ERR = ( abs(mean([aveVAL.knn_euc_R3_NORMAL.euc_precision],2)-mean([aveVAL.knn_euc_R3_REDUCED.euc_precision],2)))';
aveVAL.knn_euc_R3_euc_recall_ERR = ( abs(mean([aveVAL.knn_euc_R3_NORMAL.euc_recall],2)-mean([aveVAL.knn_euc_R3_REDUCED.euc_recall],2)))';

aveVAL.knn_euc_R1_mah_precision_ERR = ( abs(mean([aveVAL.knn_mah_R1_NORMAL.mah_precision],2)-mean([aveVAL.knn_mah_R1_REDUCED.mah_precision],2)))';
aveVAL.knn_euc_R1_mah_recall_ERR    = ( abs(mean([aveVAL.knn_mah_R1_NORMAL.mah_recall],2)   -mean([aveVAL.knn_mah_R1_REDUCED.mah_recall],2)))';
aveVAL.knn_euc_R2_mah_precision_ERR = ( abs(mean([aveVAL.knn_mah_R2_NORMAL.mah_precision],2)-mean([aveVAL.knn_mah_R2_REDUCED.mah_precision],2)))';
aveVAL.knn_euc_R2_mah_recall_ERR    = ( abs(mean([aveVAL.knn_mah_R2_NORMAL.mah_recall],2)   -mean([aveVAL.knn_mah_R2_REDUCED.mah_recall],2)))';
aveVAL.knn_euc_R3_mah_precision_ERR = ( abs(mean([aveVAL.knn_mah_R3_NORMAL.mah_precision],2)-mean([aveVAL.knn_mah_R3_REDUCED.mah_precision],2)))';
aveVAL.knn_euc_R3_mah_recall_ERR    = ( abs(mean([aveVAL.knn_mah_R3_NORMAL.mah_recall],2)   -mean([aveVAL.knn_mah_R3_REDUCED.mah_recall],2)))';
%=================================
stdVAL.knn_euc_R1_euc_precision_ERR = ( abs(std([aveVAL.knn_euc_R1_NORMAL.euc_precision],0,2)-std([aveVAL.knn_euc_R1_REDUCED.euc_precision],0,2)))';
stdVAL.knn_euc_R1_euc_recall_ERR    = ( abs(std([aveVAL.knn_euc_R1_NORMAL.euc_recall],0,2)   -std([aveVAL.knn_euc_R1_REDUCED.euc_recall],0,2)))';
stdVAL.knn_euc_R2_euc_precision_ERR = ( abs(std([aveVAL.knn_euc_R2_NORMAL.euc_precision],0,2)-std([aveVAL.knn_euc_R2_REDUCED.euc_precision],0,2)))';
stdVAL.knn_euc_R2_euc_recall_ERR    = ( abs(std([aveVAL.knn_euc_R2_NORMAL.euc_recall],0,2)   -std([aveVAL.knn_euc_R2_REDUCED.euc_recall],0,2)))';
stdVAL.knn_euc_R3_euc_precision_ERR = ( abs(std([aveVAL.knn_euc_R3_NORMAL.euc_precision],0,2)-std([aveVAL.knn_euc_R3_REDUCED.euc_precision],0,2)))';
stdVAL.knn_euc_R3_euc_recall_ERR    = ( abs(std([aveVAL.knn_euc_R3_NORMAL.euc_recall],0,2)   -std([aveVAL.knn_euc_R3_REDUCED.euc_recall],0,2)))';

stdVAL.knn_euc_R1_mah_precision_ERR = ( abs(std([aveVAL.knn_mah_R1_NORMAL.mah_precision],0,2)-std([aveVAL.knn_mah_R1_REDUCED.mah_precision],0,2)))';
stdVAL.knn_euc_R1_mah_recall_ERR    = ( abs(std([aveVAL.knn_mah_R1_NORMAL.mah_recall],0,2)   -std([aveVAL.knn_mah_R1_REDUCED.mah_recall],0,2)))';
stdVAL.knn_euc_R2_mah_precision_ERR = ( abs(std([aveVAL.knn_mah_R2_NORMAL.mah_precision],0,2)-std([aveVAL.knn_mah_R2_REDUCED.mah_precision],0,2)))';
stdVAL.knn_euc_R2_mah_recall_ERR    = ( abs(std([aveVAL.knn_mah_R2_NORMAL.mah_recall],0,2)   -std([aveVAL.knn_mah_R2_REDUCED.mah_recall],0,2)))';
stdVAL.knn_euc_R3_mah_precision_ERR = ( abs(std([aveVAL.knn_mah_R3_NORMAL.mah_precision],0,2)-std([aveVAL.knn_mah_R3_REDUCED.mah_precision],0,2)))';
stdVAL.knn_euc_R3_mah_recall_ERR    = ( abs(std([aveVAL.knn_mah_R3_NORMAL.mah_recall],0,2)   -std([aveVAL.knn_mah_R3_REDUCED.mah_recall],0,2)))';

%--------------------------------------------------------------------------------

for n=1:len
    inp = inpData(n).Train;
    aveV.knn_euc_R1(n,:) = inp.knn_1.knn_euc_R;
    aveV.knn_euc_1(n,:)  = inp.knn_1.knn_euc;
    aveV.knn_mah_R1(n,:) = inp.knn_1.knn_mah_R;
    aveV.knn_mah_1(n,:)  = inp.knn_1.knn_mah;
    %aveV.knn_ker_R1(n,:) = inp.knn_1.knn_ker_R;
    %aveV.knn_ker_1(n,:)  = inp.knn_1.knn_ker;         
end
for n=1:len
      inp = inpData(n).Train;
    aveV.knn_euc_R2(n,:) = inp.knn_2.knn_euc_R;
    aveV.knn_euc_2(n,:)  = inp.knn_2.knn_euc;
    aveV.knn_mah_R2(n,:) = inp.knn_2.knn_mah_R;
    aveV.knn_mah_2(n,:)  = inp.knn_2.knn_mah;
    %aveV.knn_ker_R2(n,:) = inp.knn_2.knn_ker_R;
    %aveV.knn_ker_2(n,:)  = inp.knn_2.knn_ker;         
end
for n=1:len
      inp = inpData(n).Train;
    aveV.knn_euc_R3(n,:) = inp.knn_3.knn_euc_R;
    aveV.knn_euc_3(n,:)  = inp.knn_3.knn_euc;
    aveV.knn_mah_R3(n,:) = inp.knn_3.knn_mah_R;
    aveV.knn_mah_3(n,:)  = inp.knn_3.knn_mah;
    %aveV.knn_ker_R3(n,:) = inp.knn_3.knn_ker_R;
    %aveV.knn_ker_3(n,:)  = inp.knn_3.knn_ker;         
end
%--------------------------------------------------------------------------------
aveVAL.knn_euc_R1_ERR = (abs(mean([aveV.knn_euc_R1],1)-mean([aveV.knn_euc_1],1)));
% aveVAL.knn_euc_1 = mean([aveV.knn_euc_1]);
aveVAL.knn_mah_R1_ERR = (abs(mean([aveV.knn_mah_R1],1)-mean([aveV.knn_mah_1],1)));
%aveVAL.knn_mah_1 = mean([aveV.knn_mah_1]);
%aveVAL.knn_ker_R1 = mean([aveV(:).knn_ker_R1]);
%aveVAL.knn_ker_1 = mean([aveV(:).knn_ker_1]);
%
aveVAL.knn_euc_R2_ERR = (abs(mean([aveV.knn_euc_R2],1)-mean([aveV.knn_euc_2],1)));
% aveVAL.knn_euc_2  = mean([aveV.knn_euc_2]);
aveVAL.knn_mah_R2_ERR = (abs(mean([aveV.knn_mah_R2],1)-mean([aveV.knn_mah_2],1)));
%aveVAL.knn_mah_2  = mean([aveV.knn_mah_2]);
%aveVAL.knn_ker_R2 = mean([aveV(:).knn_ker_R2]);
%aveVAL.knn_ker_2  = mean([aveV(:).knn_ker_2]);
%
aveVAL.knn_euc_R3_ERR = (abs(mean([aveV.knn_euc_R3],1)-mean([aveV.knn_euc_3],1)));
% aveVAL.knn_euc_3  = mean([aveV.knn_euc_3]);
aveVAL.knn_mah_R3_ERR = (abs(mean([aveV.knn_mah_R3],1)-mean([aveV.knn_mah_3],1)));
%aveVAL.knn_mah_3  = mean([aveV.knn_mah_3]);
%aveVAL.knn_ker_R3 = mean([aveV(:).knn_ker_R3]);
%aveVAL.knn_ker_3  = mean([aveV(:).knn_ker_3]);
%


stdVAL.knn_euc_R1_ERR = (abs(std([aveV.knn_euc_R1])-std([aveV.knn_euc_1])));
% stdVAL.knn_euc_1 = std([aveV.knn_euc_1]);
stdVAL.knn_mah_R1_ERR = (abs(std([aveV.knn_mah_R1])-std([aveV.knn_mah_1])));
% stdVAL.knn_mah_1 = std([aveV.knn_mah_1]);

%stdVAL.knn_ker_R1 = std([aveV(:).knn_ker_R1]);
%stdVAL.knn_ker_1 = std([aveV(:).knn_ker_1]);
%
stdVAL.knn_euc_R2_ERR = (abs(std([aveV.knn_euc_R2])-std([aveV.knn_euc_2])));
% stdVAL.knn_euc_2 = std([aveV.knn_euc_2]);
stdVAL.knn_mah_R2_ERR = (abs(std([aveV.knn_mah_R2])-std([aveV.knn_mah_2])));
%stdVAL.knn_mah_2 = std([aveV.knn_mah_2]);

%stdVAL.knn_ker_R2 = std([aveV(:).knn_ker_R2]);
%stdVAL.knn_ker_2 = std([aveV(:).knn_ker_2]);
%
stdVAL.knn_euc_R3_ERR = (abs(std([aveV.knn_euc_R3])-std([aveV.knn_euc_3])));
% stdVAL.knn_euc_3 = std([aveV.knn_euc_3]);
stdVAL.knn_mah_R3_ERR = (abs(std([aveV.knn_mah_R3])-std([aveV.knn_mah_3])));
% stdVAL.knn_mah_3 = std([aveV.knn_mah_3]);

%stdVAL.knn_ker_R3 = std([aveV(:).knn_ker_R3]);
%stdVAL.knn_ker_3 = std([aveV(:).knn_ker_3]);

out.knn_mean=aveVAL;
out.knn_std=stdVAL;

for n=1:len
      inp = inpData(n).Train;
    svm(n).outSVMlinear_1 = inp.svm_1.outSVMlinear;      
    svm(n).outSVMlinear_R1 = inp.svm_1.outSVMlinear_R;    
    svm(n).outSVMrbf_1 = inp.svm_1.outSVMrbf;         
    svm(n).outSVMrbf_R1 = inp.svm_1.outSVMrbf_R;       
    svm(n).outSVMrbf_1_1 = inp.svm_1.outSVMrbf_1;       
    svm(n).outSVMrbf_1_R1 = inp.svm_1.outSVMrbf_1_R;     
    svm(n).outSVMrbf_2_1 = inp.svm_1.outSVMrbf_2;       
    svm(n).outSVMrbf_2_R1 = inp.svm_1.outSVMrbf_2_R;
    svm(n).outSVMrbf_3_1 = inp.svm_1.outSVMrbf_3;       
    svm(n).outSVMrbf_3_R1 = inp.svm_1.outSVMrbf_3_R;
    svm(n).outSVMrbf_4_1 = inp.svm_1.outSVMrbf_4;       
    svm(n).outSVMrbf_4_R1 = inp.svm_1.outSVMrbf_4_R;
end
for n=1:len
      inp = inpData(n).Train;
    svm(n).outSVMlinear_2   = inp.svm_2.outSVMlinear;      
    svm(n).outSVMlinear_R2  = inp.svm_2.outSVMlinear_R;    
    svm(n).outSVMrbf_2      = inp.svm_2.outSVMrbf;         
    svm(n).outSVMrbf_R2     = inp.svm_2.outSVMrbf_R;       
    svm(n).outSVMrbf_1_2    = inp.svm_2.outSVMrbf_1;       
    svm(n).outSVMrbf_1_R2   = inp.svm_2.outSVMrbf_1_R;     
    svm(n).outSVMrbf_2_2    = inp.svm_2.outSVMrbf_2;       
    svm(n).outSVMrbf_2_R2   = inp.svm_2.outSVMrbf_2_R;
    svm(n).outSVMrbf_3_2    = inp.svm_2.outSVMrbf_3;       
    svm(n).outSVMrbf_3_R2   = inp.svm_2.outSVMrbf_3_R;
    svm(n).outSVMrbf_4_2    = inp.svm_2.outSVMrbf_4;       
    svm(n).outSVMrbf_4_R2   = inp.svm_2.outSVMrbf_4_R;
end
for n=1:len
      inp = inpData(n).Train;
    svm(n).outSVMlinear_3   = inp.svm_3.outSVMlinear;      
    svm(n).outSVMlinear_R3  = inp.svm_3.outSVMlinear_R;    
    svm(n).outSVMrbf_3      = inp.svm_3.outSVMrbf;         
    svm(n).outSVMrbf_R3     = inp.svm_3.outSVMrbf_R;       
    svm(n).outSVMrbf_1_3    = inp.svm_3.outSVMrbf_1;       
    svm(n).outSVMrbf_1_R3   = inp.svm_3.outSVMrbf_1_R;     
    svm(n).outSVMrbf_2_3    = inp.svm_3.outSVMrbf_2;       
    svm(n).outSVMrbf_2_R3   = inp.svm_3.outSVMrbf_2_R;
    svm(n).outSVMrbf_3_3    = inp.svm_3.outSVMrbf_3;       
    svm(n).outSVMrbf_3_R3   = inp.svm_3.outSVMrbf_3_R;
    svm(n).outSVMrbf_4_3    = inp.svm_3.outSVMrbf_4;       
    svm(n).outSVMrbf_4_R3   = inp.svm_3.outSVMrbf_4_R;
end

svmAVE.outSVMlinear_R1_ERR = (abs(mean([svm(:).outSVMlinear_1])-mean([svm(:).outSVMlinear_R1])));      
% svmAVE.outSVMlinear_R1 = mean([svm(:).outSVMlinear_R1]);    
svmAVE.outSVMrbf_RBF1_R1_ERR = (abs(mean([svm(:).outSVMrbf_1])-mean([svm(:).outSVMrbf_R1])));         
% svmAVE.outSVMrbf_R1 = mean([svm(:).outSVMrbf_R1]);       
svmAVE.outSVMrbf_RBF2_R1_ERR = (abs(mean([svm(:).outSVMrbf_1_1])-mean([svm(:).outSVMrbf_1_R1])));       
%svmAVE.outSVMrbf_1_R1 = mean([svm(:).outSVMrbf_1_R1]);     
svmAVE.outSVMrbf_RBF3_R1_ERR = (abs(mean([svm(:).outSVMrbf_2_1])-mean([svm(:).outSVMrbf_2_R1])));       
% svmAVE.outSVMrbf_2_R1 = mean([svm(:).outSVMrbf_2_R1]);
svmAVE.outSVMrbf_RBF4_R1_ERR = (abs(mean([svm(:).outSVMrbf_3_1])-mean([svm(:).outSVMrbf_3_R1])));       
%svmAVE.outSVMrbf_3_R1 = mean([svm(:).outSVMrbf_3_R1]);
svmAVE.outSVMrbf_RBF5_R1_ERR = (abs(mean([svm(:).outSVMrbf_4_1])-mean([svm(:).outSVMrbf_4_R1])));       
%svmAVE.outSVMrbf_4_R1 = mean([svm(:).outSVMrbf_4_R1]);
%
svmAVE.outSVMlinear_R2_ERR = (abs(mean([svm(:).outSVMlinear_2])-mean([svm(:).outSVMlinear_R2])));      
% svmAVE.outSVMlinear_R1 = mean([svm(:).outSVMlinear_R1]);    
svmAVE.outSVMrbf_RBF1_R2_ERR = (abs(mean([svm(:).outSVMrbf_2])-mean([svm(:).outSVMrbf_R2])));         
% svmAVE.outSVMrbf_R1 = mean([svm(:).outSVMrbf_R1]);       
svmAVE.outSVMrbf_RBF2_R2_ERR = (abs(mean([svm(:).outSVMrbf_1_2])-mean([svm(:).outSVMrbf_1_R2])));       
%svmAVE.outSVMrbf_1_R1 = mean([svm(:).outSVMrbf_1_R1]);     
svmAVE.outSVMrbf_RBF3_R2_ERR = (abs(mean([svm(:).outSVMrbf_2_2])-mean([svm(:).outSVMrbf_2_R2])));       
% svmAVE.outSVMrbf_2_R1 = mean([svm(:).outSVMrbf_2_R1]);
svmAVE.outSVMrbf_RBF4_R2_ERR = (abs(mean([svm(:).outSVMrbf_3_2])-mean([svm(:).outSVMrbf_3_R2])));       
%svmAVE.outSVMrbf_3_R1 = mean([svm(:).outSVMrbf_3_R1]);
svmAVE.outSVMrbf_RBF5_R2_ERR = (abs(mean([svm(:).outSVMrbf_4_2])-mean([svm(:).outSVMrbf_4_R2])));       
%svmAVE.outSVMrbf_4_R1 = mean([svm(:).outSVMrbf_4_R1]);

svmAVE.outSVMlinear_R3_ERR = (abs(mean([svm(:).outSVMlinear_3])-mean([svm(:).outSVMlinear_R3])));      
% svmAVE.outSVMlinear_R1 = mean([svm(:).outSVMlinear_R1]);    
svmAVE.outSVMrbf_RBF1_R3_ERR = (abs(mean([svm(:).outSVMrbf_3])-mean([svm(:).outSVMrbf_R3])));         
% svmAVE.outSVMrbf_R1 = mean([svm(:).outSVMrbf_R1]);       
svmAVE.outSVMrbf_RBF2_R3_ERR = (abs(mean([svm(:).outSVMrbf_1_3])-mean([svm(:).outSVMrbf_1_R3])));       
%svmAVE.outSVMrbf_1_R1 = mean([svm(:).outSVMrbf_1_R1]);     
svmAVE.outSVMrbf_RBF3_R3_ERR = (abs(mean([svm(:).outSVMrbf_2_3])-mean([svm(:).outSVMrbf_2_R3])));       
% svmAVE.outSVMrbf_2_R1 = mean([svm(:).outSVMrbf_2_R1]);
svmAVE.outSVMrbf_RBF4_R3_ERR = (abs(mean([svm(:).outSVMrbf_3_3])-mean([svm(:).outSVMrbf_3_R3])));       
%svmAVE.outSVMrbf_3_R1 = mean([svm(:).outSVMrbf_3_R1]);
svmAVE.outSVMrbf_RBF5_R3_ERR = (abs(mean([svm(:).outSVMrbf_4_3])-mean([svm(:).outSVMrbf_4_R3])));       
%svmAVE.outSVMrbf_4_R1 = mean([svm(:).outSVMrbf_4_R1]);

% % svmAVE.outSVMlinear_2   = mean([svm(:).outSVMlinear_2]);      
% % svmAVE.outSVMlinear_R2  = mean([svm(:).outSVMlinear_R2]);    
% % svmAVE.outSVMrbf_2      = mean([svm(:).outSVMrbf_2]);         
% % svmAVE.outSVMrbf_R2     = mean([svm(:).outSVMrbf_R2]);       
% % svmAVE.outSVMrbf_1_2    = mean([svm(:).outSVMrbf_1_2]);       
% % svmAVE.outSVMrbf_1_R2   = mean([svm(:).outSVMrbf_1_R2]);     
% % svmAVE.outSVMrbf_2_2    = mean([svm(:).outSVMrbf_2_2]);       
% % svmAVE.outSVMrbf_2_R2   = mean([svm(:).outSVMrbf_2_R2]);
% % svmAVE.outSVMrbf_3_2    = mean([svm(:).outSVMrbf_3_2]);       
% % svmAVE.outSVMrbf_3_R2   = mean([svm(:).outSVMrbf_3_R2]);
% % svmAVE.outSVMrbf_4_2    = mean([svm(:).outSVMrbf_4_2]);       
% % svmAVE.outSVMrbf_4_R2   = mean([svm(:).outSVMrbf_4_R2]);
% % %
% % svmAVE.outSVMlinear_3 = mean([svm(:).outSVMlinear_3]);      
% % svmAVE.outSVMlinear_R3 = mean([svm(:).outSVMlinear_R3]);    
% % svmAVE.outSVMrbf_3 = mean([svm(:).outSVMrbf_3]);         
% % svmAVE.outSVMrbf_R3 = mean([svm(:).outSVMrbf_R3]);       
% % svmAVE.outSVMrbf_1_3 = mean([svm(:).outSVMrbf_1_3]);       
% % svmAVE.outSVMrbf_1_R3 = mean([svm(:).outSVMrbf_1_R3]);     
% % svmAVE.outSVMrbf_2_3 = mean([svm(:).outSVMrbf_2_3]);       
% % svmAVE.outSVMrbf_2_R3 = mean([svm(:).outSVMrbf_2_R3]);
% % svmAVE.outSVMrbf_3_3 = mean([svm(:).outSVMrbf_3_3]);       
% % svmAVE.outSVMrbf_3_R3 = mean([svm(:).outSVMrbf_3_R3]);
% % svmAVE.outSVMrbf_4_3 = mean([svm(:).outSVMrbf_4_3]);       
% % svmAVE.outSVMrbf_4_R3 = mean([svm(:).outSVMrbf_4_R3]);


svmSTD.outSVMlinear_R1_ERR = (abs(std([svm(:).outSVMlinear_1])-std([svm(:).outSVMlinear_R1])));      
% svmAVE.outSVMlinear_R1 = mean([svm(:).outSVMlinear_R1]);    
svmSTD.outSVMrbf_RBF1_R1_ERR = (abs(std([svm(:).outSVMrbf_1])-std([svm(:).outSVMrbf_R1])));         
% svmAVE.outSVMrbf_R1 = mean([svm(:).outSVMrbf_R1]);       
svmSTD.outSVMrbf_RBF2_R1_ERR = (abs(std([svm(:).outSVMrbf_1_1])-std([svm(:).outSVMrbf_1_R1])));       
%svmAVE.outSVMrbf_1_R1 = mean([svm(:).outSVMrbf_1_R1]);     
svmSTD.outSVMrbf_RBF3_R1_ERR = (abs(std([svm(:).outSVMrbf_2_1])-std([svm(:).outSVMrbf_2_R1])));       
% svmAVE.outSVMrbf_2_R1 = mean([svm(:).outSVMrbf_2_R1]);
svmSTD.outSVMrbf_RBF4_R1_ERR = (abs(std([svm(:).outSVMrbf_3_1])-std([svm(:).outSVMrbf_3_R1])));       
%svmAVE.outSVMrbf_3_R1 = mean([svm(:).outSVMrbf_3_R1]);
svmSTD.outSVMrbf_RBF5_R1_ERR = (abs(std([svm(:).outSVMrbf_4_1])-std([svm(:).outSVMrbf_4_R1])));       
%svmAVE.outSVMrbf_4_R1 = mean([svm(:).outSVMrbf_4_R1]);
%
svmSTD.outSVMlinear_R2_ERR = (abs(std([svm(:).outSVMlinear_2])-std([svm(:).outSVMlinear_R2])));      
% svmAVE.outSVMlinear_R1 = mean([svm(:).outSVMlinear_R1]);    
svmSTD.outSVMrbf_RBF1_R2_ERR = (abs(std([svm(:).outSVMrbf_2])-std([svm(:).outSVMrbf_R2])));         
% svmAVE.outSVMrbf_R1 = mean([svm(:).outSVMrbf_R1]);       
svmSTD.outSVMrbf_RBF2_R2_ERR = (abs(std([svm(:).outSVMrbf_1_2])-std([svm(:).outSVMrbf_1_R2])));       
%svmAVE.outSVMrbf_1_R1 = mean([svm(:).outSVMrbf_1_R1]);     
svmSTD.outSVMrbf_RBF3_R2_ERR = (abs(std([svm(:).outSVMrbf_2_2])-std([svm(:).outSVMrbf_2_R2])));       
% svmAVE.outSVMrbf_2_R1 = mean([svm(:).outSVMrbf_2_R1]);
svmSTD.outSVMrbf_RBF4_R2_ERR = (abs(std([svm(:).outSVMrbf_3_2])-std([svm(:).outSVMrbf_3_R2])));       
%svmAVE.outSVMrbf_3_R1 = mean([svm(:).outSVMrbf_3_R1]);
svmSTD.outSVMrbf_RBF5_R2_ERR = (abs(std([svm(:).outSVMrbf_4_2])-std([svm(:).outSVMrbf_4_R2])));       
%svmAVE.outSVMrbf_4_R1 = mean([svm(:).outSVMrbf_4_R1]);

svmSTD.outSVMlinear_R3_ERR = (abs(std([svm(:).outSVMlinear_3])-std([svm(:).outSVMlinear_R3])));      
% svmAVE.outSVMlinear_R1 = mean([svm(:).outSVMlinear_R1]);    
svmSTD.outSVMrbf_RBF1_R3_ERR = (abs(std([svm(:).outSVMrbf_3])-std([svm(:).outSVMrbf_R3])));         
% svmAVE.outSVMrbf_R1 = mean([svm(:).outSVMrbf_R1]);       
svmSTD.outSVMrbf_RBF2_R3_ERR = (abs(std([svm(:).outSVMrbf_1_3])-std([svm(:).outSVMrbf_1_R3])));       
%svmAVE.outSVMrbf_1_R1 = mean([svm(:).outSVMrbf_1_R1]);     
svmSTD.outSVMrbf_RBF3_R3_ERR = (abs(std([svm(:).outSVMrbf_2_3])-std([svm(:).outSVMrbf_2_R3])));       
% svmAVE.outSVMrbf_2_R1 = mean([svm(:).outSVMrbf_2_R1]);
svmSTD.outSVMrbf_RBF4_R3_ERR = (abs(std([svm(:).outSVMrbf_3_3])-std([svm(:).outSVMrbf_3_R3])));       
%svmAVE.outSVMrbf_3_R1 = mean([svm(:).outSVMrbf_3_R1]);
svmSTD.outSVMrbf_RBF5_R3_ERR = (abs(std([svm(:).outSVMrbf_4_3])-std([svm(:).outSVMrbf_4_R3])));       
%svmAVE.outSVMrbf_4_R1 = mean([svm(:).outSVMrbf_4_R1]);


% 
% svmSTD.outSVMlinear_1   = std([svm(:).outSVMlinear_1]);      
% svmSTD.outSVMlinear_R_1 = std([svm(:).outSVMlinear_R1]);    
% svmSTD.outSVMrbf_1      = std([svm(:).outSVMrbf_1]);         
% svmSTD.outSVMrbf_R_1    = std([svm(:).outSVMrbf_R1]);       
% svmSTD.outSVMrbf_1_1    = std([svm(:).outSVMrbf_1_1]);       
% svmSTD.outSVMrbf_1_R_1  = std([svm(:).outSVMrbf_1_R1]);     
% svmSTD.outSVMrbf_2_1    = std([svm(:).outSVMrbf_2_1]);       
% svmSTD.outSVMrbf_2_R_1  = std([svm(:).outSVMrbf_2_R1]);
% svmSTD.outSVMrbf_3_1    = std([svm(:).outSVMrbf_3_1]);       
% svmSTD.outSVMrbf_3_R_1  = std([svm(:).outSVMrbf_3_R1]);
% svmSTD.outSVMrbf_4_1    = std([svm(:).outSVMrbf_4_1]);       
% svmSTD.outSVMrbf_5_R_1  = std([svm(:).outSVMrbf_4_R1]);
% %
% svmSTD.outSVMlinear_2   = std([svm(:).outSVMlinear_2]);      
% svmSTD.outSVMlinear_R_2 = std([svm(:).outSVMlinear_R2]);    
% svmSTD.outSVMrbf_2      = std([svm(:).outSVMrbf_2]);         
% svmSTD.outSVMrbf_R_2    = std([svm(:).outSVMrbf_R2]);       
% svmSTD.outSVMrbf_1_2    = std([svm(:).outSVMrbf_1_2]);       
% svmSTD.outSVMrbf_1_R_2  = std([svm(:).outSVMrbf_1_R2]);     
% svmSTD.outSVMrbf_2_2    = std([svm(:).outSVMrbf_2_2]);       
% svmSTD.outSVMrbf_2_R_2  = std([svm(:).outSVMrbf_2_R2]);
% svmSTD.outSVMrbf_3_2    = std([svm(:).outSVMrbf_3_2]);       
% svmSTD.outSVMrbf_3_R_2  = std([svm(:).outSVMrbf_3_R2]);
% svmSTD.outSVMrbf_4_2    = std([svm(:).outSVMrbf_4_2]);       
% svmSTD.outSVMrbf_5_R_2  = std([svm(:).outSVMrbf_4_R2]);
% %
% svmSTD.outSVMlinear_3   = std([svm(:).outSVMlinear_3]);      
% svmSTD.outSVMlinear_R_3 = std([svm(:).outSVMlinear_R3]);    
% svmSTD.outSVMrbf_3      = std([svm(:).outSVMrbf_3]);         
% svmSTD.outSVMrbf_R_3    = std([svm(:).outSVMrbf_R3]);       
% svmSTD.outSVMrbf_1_3    = std([svm(:).outSVMrbf_1_3]);       
% svmSTD.outSVMrbf_1_R_3  = std([svm(:).outSVMrbf_1_R3]);     
% svmSTD.outSVMrbf_2_3    = std([svm(:).outSVMrbf_2_3]);       
% svmSTD.outSVMrbf_2_R_3  = std([svm(:).outSVMrbf_2_R3]);
% svmSTD.outSVMrbf_3_3    = std([svm(:).outSVMrbf_3_3]);       
% svmSTD.outSVMrbf_3_R_3  = std([svm(:).outSVMrbf_3_R3]);
% svmSTD.outSVMrbf_4_3    = std([svm(:).outSVMrbf_4_3]);       
% svmSTD.outSVMrbf_5_R_3  = std([svm(:).outSVMrbf_4_R3]);


out.svm_mean=svmAVE;   
out.svm_std=svmSTD;  

out.Rper1 = 0;
for n=1:len
    out.Rper1 = out.Rper1 + 100-100*inpData(n).Size_C_TR_R1(2)/inpData(n).Size_C_TR(2);
end
out.Rper1 = out.Rper1 / len;

out.Rper2 = 0;
for n=1:len
    out.Rper2 = out.Rper2 + 100-100*inpData(n).Size_C_TR_R2(2)/inpData(n).Size_C_TR(2);
end
out.Rper2 = out.Rper2 / len;


out.Rper3 = 0;
for n=1:len
    out.Rper3 = out.Rper3 + 100-100*inpData(n).Size_C_TR_R3(2)/inpData(n).Size_C_TR(2);
end
out.Rper3 = out.Rper3 / len;

% out.var = inp.var;
% out.T1 = inp.T1;
% out.T2 = inp.T2;

end

