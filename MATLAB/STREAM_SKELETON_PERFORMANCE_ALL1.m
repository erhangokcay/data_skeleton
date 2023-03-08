%function out = INFORMATION_CLASSIFIER_V0 ( dirName, fName, ind_label, percent, std, mean )
function [out] = STREAM_SKELETON_PERFORMANCE_ALL1 ( inp_str, percent, flag, str, std1,  T1, T2 )

outstr = STREAM_SKELETON_INPUT_DATASET ( inp_str, percent, flag, str, std1, T1, T2 );
disp('SKELETON FINISHED');
% ----------------------------------KNN-----------------------------------------
out_knn = STREAM_SKELETON_PERFORMANCE_KNN_CMP(outstr,1);
o.knn_1 = out_knn;
out_knn = STREAM_SKELETON_PERFORMANCE_KNN_CMP(outstr,2);
o.knn_2 = out_knn;
out_knn = STREAM_SKELETON_PERFORMANCE_KNN_CMP(outstr,3);
o.knn_3 = out_knn;
%--------------------------------------------------------------------------------

% ----------------------------------SVM-----------------------------------------
out_svm = STREAM_SKELETON_PERFORMANCE_SVM_CMP1(outstr,1);
o.svm_1 = out_svm;
out_svm = STREAM_SKELETON_PERFORMANCE_SVM_CMP1(outstr,2);
o.svm_2 = out_svm;
out_svm = STREAM_SKELETON_PERFORMANCE_SVM_CMP1(outstr,3);
o.svm_3 = out_svm;
%--------------------------------------------------------------------------------

out = o;
out.str = outstr;
out.var = std1;
out.T1= T1;
out.T2=T2;
end