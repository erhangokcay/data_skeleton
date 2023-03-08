function [out] = STREAM_SKELETON_AVE ( inp )

%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% aveV.knn_euc_R = 0;
% aveV.knn_euc = 0;
% aveV.knn_mah_R = 0;
% aveV.knn_mah  = 0;
% aveV.knn_ker_R = 0;
% aveV.knn_ker = 0;

for n=1:100
    aveV.knn_euc_R(n,:) = inp(n).knn_euc_R;
    aveV.knn_euc(n,:) = inp(n).knn_euc;
    aveV.knn_mah_R(n,:) = inp(n).knn_mah_R;
    aveV.knn_mah(n,:)  = inp(n).knn_mah;
    aveV.knn_ker_R(n,:) = inp(n).knn_ker_R;
    aveV.knn_ker(n,:) = inp(n).knn_ker;         
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

aveVAL.knn_euc_R = mean([aveV.knn_euc_R]);
aveVAL.knn_euc = mean([aveV.knn_euc]);
aveVAL.knn_mah_R = mean([aveV.knn_mah_R]);
aveVAL.knn_mah = mean([aveV.knn_mah]);
aveVAL.knn_ker_R = mean([aveV(:).knn_ker_R]);
aveVAL.knn_ker = mean([aveV(:).knn_ker]);

stdVAL.knn_euc_R = std([aveV.knn_euc_R]);
stdVAL.knn_euc = std([aveV.knn_euc]);
stdVAL.knn_mah_R = std([aveV.knn_mah_R]);
stdVAL.knn_mah = std([aveV.knn_mah]);
stdVAL.knn_ker_R = std([aveV(:).knn_ker_R]);
stdVAL.knn_ker = std([aveV(:).knn_ker]);

out.knn_mean=aveVAL;
out.knn_std=stdVAL;





for n=1:100
    svm(n).outSVMlinear = inp(n).svm.outSVMlinear;      
    svm(n).outSVMlinear_R = inp(n).svm.outSVMlinear_R;    
    svm(n).outSVMrbf = inp(n).svm.outSVMrbf;         
    svm(n).outSVMrbf_R = inp(n).svm.outSVMrbf_R;       
    svm(n).outSVMrbf_1 = inp(n).svm.outSVMrbf_1;       
    svm(n).outSVMrbf_1_R = inp(n).svm.outSVMrbf_1_R;     
    svm(n).outSVMrbf_2 = inp(n).svm.outSVMrbf_2;       
    svm(n).outSVMrbf_2_R = inp(n).svm.outSVMrbf_2_R;
    svm(n).outSVMrbf_3 = inp(n).svm.outSVMrbf_3;       
    svm(n).outSVMrbf_3_R = inp(n).svm.outSVMrbf_3_R;
    svm(n).outSVMrbf_4 = inp(n).svm.outSVMrbf_4;       
    svm(n).outSVMrbf_4_R = inp(n).svm.outSVMrbf_4_R;
end

svmAVE.outSVMlinear = mean([svm(:).outSVMlinear]);      
svmAVE.outSVMlinear_R = mean([svm(:).outSVMlinear_R]);    
svmAVE.outSVMrbf = mean([svm(:).outSVMrbf]);         
svmAVE.outSVMrbf_R = mean([svm(:).outSVMrbf_R]);       
svmAVE.outSVMrbf_1 = mean([svm(:).outSVMrbf_1]);       
svmAVE.outSVMrbf_1_R = mean([svm(:).outSVMrbf_1_R]);     
svmAVE.outSVMrbf_2 = mean([svm(:).outSVMrbf_2]);       
svmAVE.outSVMrbf_2_R = mean([svm(:).outSVMrbf_2_R]);
svmAVE.outSVMrbf_3 = mean([svm(:).outSVMrbf_3]);       
svmAVE.outSVMrbf_3_R = mean([svm(:).outSVMrbf_3_R]);
svmAVE.outSVMrbf_4 = mean([svm(:).outSVMrbf_4]);       
svmAVE.outSVMrbf_4_R = mean([svm(:).outSVMrbf_4_R]);

svmSTD.outSVMlinear = std([svm(:).outSVMlinear]);      
svmSTD.outSVMlinear_R = std([svm(:).outSVMlinear_R]);    
svmSTD.outSVMrbf = std([svm(:).outSVMrbf]);         
svmSTD.outSVMrbf_R = std([svm(:).outSVMrbf_R]);       
svmSTD.outSVMrbf_1 = std([svm(:).outSVMrbf_1]);       
svmSTD.outSVMrbf_1_R = std([svm(:).outSVMrbf_1_R]);     
svmSTD.outSVMrbf_2 = std([svm(:).outSVMrbf_2]);       
svmSTD.outSVMrbf_2_R = std([svm(:).outSVMrbf_2_R]);
svmSTD.outSVMrbf_3 = std([svm(:).outSVMrbf_3]);       
svmSTD.outSVMrbf_3_R = std([svm(:).outSVMrbf_3_R]);
svmSTD.outSVMrbf_4 = std([svm(:).outSVMrbf_4]);       
svmSTD.outSVMrbf_5_R = std([svm(:).outSVMrbf_4_R]);

out.svm_mean=svmAVE;   
out.svm_std=svmSTD;  

out.Rper = 0;
for n=1:100
    out.Rper = out.Rper + 100-100*size(inp(n).str.C_TR_R,2)/size(inp(n).str.C_TR,2);
end
out.Rper = out.Rper / 100;
end

