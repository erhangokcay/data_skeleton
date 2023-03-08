data_IRIS=IRIS_getData;
TList_IRIS_1=[1000,500,100,10,1,0.1, 10e-3,10e-4,10e-5,10e-8,10e-25,10e-50,10e-200,10e-350,10e-500]
%TList_IRIS_1=[10e-200,10e-350,10e-500]
cef_var=0.05;
RdSelect = 1;
clear outArr stroutArr outAVEArr
for T=1:length(TList_IRIS_1)
    
    for n=1:100 
        disp(n);
        [outArr(n)] = STREAM_SKELETON_PERFORMANCE_ALL1 ( data_IRIS, 0.2, false, 0, cef_var, TList_IRIS_1(T), TList_IRIS_1(T));
    end
    % For debugging
    outAll(T).out = outArr;
    outAVEArr(T)=STREAM_SKELETON_AVE_ALL_V1(outArr);
end

stat_IRIS.cef_var = cef_var;
stat_IRIS.TList = TList_IRIS_1;
stat_IRIS.stat = outAVEArr;

% ----------------------- Euclidean ---------------------------
% radlst = outArr(1).radlst;
radlst = [1,2,4,8,16,32];

% % 
% % for r=1:length(radlst)
% %     clear V1 V2
% %     figure    
% %     for n=1:length(TList_IRIS_1)
% %         V1(n)=outAVEArr(n).knn_mean.knn_euc_R1(r);
% %         V2(n)=outAVEArr(n).Rper1;
% %     end
% %     plot(V2,V1,'r');
% %     hold on
% %     for n=1:length(TList_IRIS_1)
% %         V1(n)=outAVEArr(n).knn_mean.knn_euc_1(r);
% %         V2(n)=outAVEArr(n).Rper1;
% %     end
% %     plot(V2,V1,'g');        
% %     
% %     title(['EUC Radius=',sprintf('%d',radlst(r))]);
% %     axis([0 100 0 100])
% % end
% % 

figure 
hold on 
for r=1:length(radlst)
    clear V1 V2       
    for n=1:length(TList_IRIS_1)
        V1(n)=outAVEArr(n).knn_mean.knn_euc_R1_ERR(r);
        V2(n)=outAVEArr(n).Rper1;
    end
    plot(V2,V1);
                      
end
title('kNN EUC R1 Absolute Classification Error vs Radius');
legend('Rad=1','Rad=2','Rad=4','Rad=8','Rad=16','Rad=32')
axis([0 100 -1 15])

figure 
hold on 
for r=1:length(radlst)
    clear V1 V2       
    for n=1:length(TList_IRIS_1)
        V1(n)=outAVEArr(n).knn_mean.knn_euc_R2_ERR(r);
        V2(n)=outAVEArr(n).Rper2;
    end
    plot(V2,V1);
                      
end
title('kNN EUC R2 Absolute Classification Error vs Radius');
legend('Rad=1','Rad=2','Rad=4','Rad=8','Rad=16','Rad=32')
axis([0 100 -1 15])

figure 
hold on 
for r=1:length(radlst)
    clear V1 V2       
    for n=1:length(TList_IRIS_1)
        V1(n)=outAVEArr(n).knn_mean.knn_euc_R3_ERR(r);
        V2(n)=outAVEArr(n).Rper3;
    end
    plot(V2,V1);
                      
end
title('kNN EUC R3 Absolute Classification Error vs Radius');
legend('Rad=1','Rad=2','Rad=4','Rad=8','Rad=16','Rad=32')
axis([0 100 -1 15])
% ----------------------- Mahalabonis ---------------------------
% % 
% % for r=1:length(radlst)
% %     clear V1 V2
% %     figure    
% %     for n=1:length(TList_IRIS_1)
% %         V1(n)=outAVEArr(n).knn_mean.knn_mah_R1(r);
% %         V2(n)=outAVEArr(n).Rper1;
% %     end
% %     plot(V2,V1,'r');
% %     hold on
% %     for n=1:length(TList_IRIS_1)
% %         V1(n)=outAVEArr(n).knn_mean.knn_mah_1(r);
% %         V2(n)=outAVEArr(n).Rper1;
% %     end
% %     plot(V2,V1,'g');        
% %     
% %     title(['EUC Radius=',sprintf('%d',radlst(r))]);
% %     axis([0 100 0 100])
% % end
% % 

figure 
hold on 
for r=1:length(radlst)
    clear V1 V2       
    for n=1:length(TList_IRIS_1)
        V1(n)=outAVEArr(n).knn_mean.knn_mah_R1_ERR(r);
        V2(n)=outAVEArr(n).Rper1;
    end
    plot(V2,V1);                      
end
title('kNN MAH R1 Absolute Error vs Radius');
legend('Rad=1','Rad=2','Rad=4','Rad=8','Rad=16','Rad=32')
axis([0 100 -1 15])

figure 
hold on 
for r=1:length(radlst)
    clear V1 V2       
    for n=1:length(TList_IRIS_1)
        V1(n)=outAVEArr(n).knn_mean.knn_mah_R2_ERR(r);
        V2(n)=outAVEArr(n).Rper2;
    end
    plot(V2,V1);                      
end
title('kNN MAH R2 Absolute Error vs Radius');
legend('Rad=1','Rad=2','Rad=4','Rad=8','Rad=16','Rad=32')
axis([0 100 -1 15])

figure 
hold on 
for r=1:length(radlst)
    clear V1 V2       
    for n=1:length(TList_IRIS_1)
        V1(n)=outAVEArr(n).knn_mean.knn_mah_R3_ERR(r);
        V2(n)=outAVEArr(n).Rper3;
    end
    plot(V2,V1);                      
end
title('KNN MAH R3 Absolute Error vs Radius');
legend('Rad=1','Rad=2','Rad=4','Rad=8','Rad=16','Rad=32')
axis([0 100 -1 15])

%-------------------------------------------------------------------------------------------

figure 
hold on 

clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=outAVEArr(n).svm_mean.outSVMlinear_R1_ERR;
    V2(n)=outAVEArr(n).Rper1;
end
plot(V2,V1);                      
clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=outAVEArr(n).svm_mean.outSVMrbf_RBF1_R1_ERR;
    V2(n)=outAVEArr(n).Rper1;
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=outAVEArr(n).svm_mean.outSVMrbf_RBF2_R1_ERR;
    V2(n)=outAVEArr(n).Rper1;
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=outAVEArr(n).svm_mean.outSVMrbf_RBF3_R1_ERR;
    V2(n)=outAVEArr(n).Rper1;
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=outAVEArr(n).svm_mean.outSVMrbf_RBF4_R1_ERR;
    V2(n)=outAVEArr(n).Rper1;
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=outAVEArr(n).svm_mean.outSVMrbf_RBF5_R1_ERR;
    V2(n)=outAVEArr(n).Rper1;
end
plot(V2,V1); 
title('SVM R1 Absolute Error vs RBF');
legend('Linear','RBF-1','RBF-2','RBF-3','RBF-4','RBF-5')
axis([0 100 -1 15])

%-------------------------------------------------------------------------------------------

figure 
hold on 

clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=outAVEArr(n).svm_mean.outSVMlinear_R2_ERR;
    V2(n)=outAVEArr(n).Rper2;
end
plot(V2,V1);                      
clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=outAVEArr(n).svm_mean.outSVMrbf_RBF1_R2_ERR;
    V2(n)=outAVEArr(n).Rper2;
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=outAVEArr(n).svm_mean.outSVMrbf_RBF2_R2_ERR;
    V2(n)=outAVEArr(n).Rper2;
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=outAVEArr(n).svm_mean.outSVMrbf_RBF3_R2_ERR;
    V2(n)=outAVEArr(n).Rper2;
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=outAVEArr(n).svm_mean.outSVMrbf_RBF4_R2_ERR;
    V2(n)=outAVEArr(n).Rper2;
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=outAVEArr(n).svm_mean.outSVMrbf_RBF5_R2_ERR;
    V2(n)=outAVEArr(n).Rper2;
end
plot(V2,V1); 
title('SVM R1 Absolute Error vs RBF');
legend('Linear','RBF-1','RBF-2','RBF-3','RBF-4','RBF-5')
axis([0 100 -1 15])

%-------------------------------------------------------------------------------------------

figure 
hold on 

clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=outAVEArr(n).svm_mean.outSVMlinear_R3_ERR;
    V2(n)=outAVEArr(n).Rper3;
end
plot(V2,V1);                      
clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=outAVEArr(n).svm_mean.outSVMrbf_RBF1_R3_ERR;
    V2(n)=outAVEArr(n).Rper3;
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=outAVEArr(n).svm_mean.outSVMrbf_RBF2_R3_ERR;
    V2(n)=outAVEArr(n).Rper3;
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=outAVEArr(n).svm_mean.outSVMrbf_RBF3_R3_ERR;
    V2(n)=outAVEArr(n).Rper3;
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=outAVEArr(n).svm_mean.outSVMrbf_RBF4_R3_ERR;
    V2(n)=outAVEArr(n).Rper3;
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=outAVEArr(n).svm_mean.outSVMrbf_RBF5_R3_ERR;
    V2(n)=outAVEArr(n).Rper3;
end
plot(V2,V1); 
title('SVM R1 Absolute Error vs RBF');
legend('Linear','RBF-1','RBF-2','RBF-3','RBF-4','RBF-5')
axis([0 100 -1 15])

