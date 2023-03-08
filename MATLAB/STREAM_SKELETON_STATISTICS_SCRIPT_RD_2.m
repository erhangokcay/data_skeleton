% data_IRIS=IRIS_getData;
% NO RANDOM GENERATION. GET DATA FROM STREAM_SKELETON_STATISTICS_SCRIPT_RD_1.m
outAll_Temp=outALL;
TList_IRIS_1=[1000,500,100,10,1,0.1, 10e-3,10e-4,10e-5,10e-8,10e-25,10e-50]
cef_var=0.05;
RdSelect = 2;
clear outArr stroutArr outAVEArr
for T=1:length(TList_IRIS_1)
    for n=1:100 
        disp(n);
        [outArr2(n),stroutArr2(n)] = STREAM_SKELETON_PERFORMANCE_V0 ( 0, 0.2, cef_var, cef_var, 0, true, outAll_Temp(T).out(n).str, TList_IRIS_1(T), TList_IRIS_1(T),RdSelect );
    end
    outAll2(T).out = outArr2;
    outAVEArr2(T)=STREAM_SKELETON_AVE(outArr2);
end

stat_IRIS.cef_var = cef_var;
stat_IRIS.TList = TList_IRIS_1;
stat_IRIS.RdSelect = RdSelect;
stat_IRIS.stat = outAVEArr;

% ----------------------- Euclidean ---------------------------
radlst = outArr(1).radlst;
for r=1:length(radlst)
    clear V1 V2
    figure    
    for n=1:length(TList_IRIS_1)
        V1(n)=outAVEArr2(n).knn_mean.knn_euc_R(r);
        V2(n)=outAVEArr2(n).Rper;
    end
    plot(V2,V1,'r');
    hold on
    for n=1:length(TList_IRIS_1)
        V1(n)=outAVEArr2(n).knn_mean.knn_euc(r);
        V2(n)=outAVEArr2(n).Rper;
    end
    plot(V2,V1,'g');
    
    
    
    title(['EUC Radius=',sprintf('%d',radlst(r))]);
    axis([0 100 0 100])
end

figure 
hold on 
for r=1:length(radlst)
    clear V1 V2       
    for n=1:length(TList_IRIS_1)
        V1(n)=(abs(outAVEArr2(n).knn_mean.knn_euc_R(r) - outAVEArr2(n).knn_mean.knn_euc(r)));
        V2(n)=outAVEArr2(n).Rper;
    end
    plot(V2,V1);
                      
end
title('Absolute Classification Error vs Radius');
legend('Rad=1','Rad=2','Rad=4','Rad=8','Rad=16','Rad=32')
axis([0 100 -1 50])

% ----------------------- Mahalabonis ---------------------------
radlst = outArr(1).radlst;
for r=1:length(radlst)
    clear V1 V2
    figure    
    for n=1:length(TList_IRIS_1)
        V1(n)=outAVEArr2(n).knn_mean.knn_mah_R(r);
        V2(n)=outAVEArr2(n).Rper;
    end
    plot(V2,V1,'r');
    hold on
    for n=1:length(TList_IRIS_1)
        V1(n)=outAVEArr2(n).knn_mean.knn_mah(r);
        V2(n)=outAVEArr2(n).Rper;
    end
    plot(V2,V1,'g');        
    
    title(['EUC Radius=',sprintf('%d',radlst(r))]);
    axis([0 100 0 100])
end

figure 
hold on 
for r=1:length(radlst)
    clear V1 V2       
    for n=1:length(TList_IRIS_1)
        V1(n)=(abs(outAVEArr2(n).knn_mean.knn_mah_R(r) - outAVEArr2(n).knn_mean.knn_mah(r)));
        V2(n)=outAVEArr2(n).Rper;
    end
    plot(V2,V1);                      
end
title('Absolute Error vs Radius');
legend('Rad=1','Rad=2','Rad=4','Rad=8','Rad=16','Rad=32')
axis([0 100 -1 50])

figure 
hold on 

clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=(abs(outAVEArr2(n).svm_mean.outSVMlinear - outAVEArr2(n).svm_mean.outSVMlinear_R));
    V2(n)=outAVEArr2(n).Rper;
end
plot(V2,V1);                      
clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=(abs(outAVEArr2(n).svm_mean.outSVMrbf - outAVEArr2(n).svm_mean.outSVMrbf_R));
    V2(n)=outAVEArr2(n).Rper;
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=(abs(outAVEArr2(n).svm_mean.outSVMrbf_1 - outAVEArr2(n).svm_mean.outSVMrbf_1_R));
    V2(n)=outAVEArr2(n).Rper;
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=(abs(outAVEArr2(n).svm_mean.outSVMrbf_2 - outAVEArr2(n).svm_mean.outSVMrbf_2_R));
    V2(n)=outAVEArr2(n).Rper;
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=(abs(outAVEArr2(n).svm_mean.outSVMrbf_3 - outAVEArr2(n).svm_mean.outSVMrbf_3_R));
    V2(n)=outAVEArr2(n).Rper;
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList_IRIS_1)
    V1(n)=(abs(outAVEArr2(n).svm_mean.outSVMrbf_4 - outAVEArr2(n).svm_mean.outSVMrbf_4_R));
    V2(n)=outAVEArr2(n).Rper;
end
plot(V2,V1); 
title('SVM LINEAR Absolute Error vs Radius');
legend('Linear','RBF-1','RBF-2','RBF-3','RBF-4','RBF-5')
axis([0 100 -1 50])

