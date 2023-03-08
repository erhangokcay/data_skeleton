function STREAM_SKELETON_PLOT_AVE_CORRS_STD(outAVEArr,TList,radlst)
%UNT�TLED3 Summary of this function goes here
%   Detailed explanation goes here
figure 
hold on 
for r=1:length(radlst)
    clear V1 V2       
    for n=1:length(TList)
        V1(n)=outAVEArr(n).knn_std.knn_euc_R1_ERR(r);
        V2(n)=outAVEArr(n).Rper1;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
    end
    plot(V2,V1);
                      
end
set(gca,'FontSize',12);

title('kNN EUC R1 Variance of Absolute Error');
legend('Rad=1','Rad=2','Rad=4','Rad=8','Rad=16','Rad=32')
axis([0 100 -1 50])
h=xlabel('Compression Ratio');
set(h, 'FontSize', 15);
h=ylabel('Variance');
set(h, 'FontSize', 15);


figure 
hold on 
for r=1:length(radlst)
    clear V1 V2       
    for n=1:length(TList)
        V1(n)=outAVEArr(n).knn_std.knn_euc_R2_ERR(r);
        V2(n)=outAVEArr(n).Rper2;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
    end
    plot(V2,V1);
                      
end
set(gca,'FontSize',12);

%%% title('kNN EUC R2 Variance of Absolute Error');
title('kNN EUC R2 Variance of Absolute Error');
legend('Rad=1','Rad=2','Rad=4','Rad=8','Rad=16','Rad=32')
axis([0 100 -1 50])
h=xlabel('Compression Ratio');
set(h, 'FontSize', 15);
h=ylabel('Variance');
set(h, 'FontSize', 15);


figure 
hold on 
for r=1:length(radlst)
    clear V1 V2       
    for n=1:length(TList)
        V1(n)=outAVEArr(n).knn_std.knn_euc_R3_ERR(r);
        V2(n)=outAVEArr(n).Rper3;
    end
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
    plot(V2,V1);
                      
end
set(gca,'FontSize',12);
title('kNN EUC R3 Variance of Absolute Error');
legend('Rad=1','Rad=2','Rad=4','Rad=8','Rad=16','Rad=32')
axis([0 100 -1 50])
h=xlabel('Compression Ratio');
set(h, 'FontSize', 15);
h=ylabel('Variance');
set(h, 'FontSize', 15);

% ----------------------- Mahalabonis ---------------------------
% % 
% % for r=1:length(radlst)
% %     clear V1 V2
% %     figure    
% %     for n=1:length(TList_IRIS_1)
% %         V1(n)=outAVEArr(n).knn_std.knn_mah_R1(r);
% %         V2(n)=outAVEArr(n).Rper1;
% %     end
% %     plot(V2,V1,'r');
% %     hold on
% %     for n=1:length(TList_IRIS_1)
% %         V1(n)=outAVEArr(n).knn_std.knn_mah_1(r);
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
    for n=1:length(TList)
        V1(n)=outAVEArr(n).knn_std.knn_mah_R1_ERR(r);
        V2(n)=outAVEArr(n).Rper1;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
    end
    plot(V2,V1);                      
end
set(gca,'FontSize',12);
title('kNN MAH R1 Variance of Absolute Error');
legend('Rad=1','Rad=2','Rad=4','Rad=8','Rad=16','Rad=32')
axis([0 100 -1 50])
h=xlabel('Compression Ratio');
set(h, 'FontSize', 15);
h=ylabel('Variance');
set(h, 'FontSize', 15);


figure 
hold on 
for r=1:length(radlst)
    clear V1 V2       
    for n=1:length(TList)
        V1(n)=outAVEArr(n).knn_std.knn_mah_R2_ERR(r);
        V2(n)=outAVEArr(n).Rper2;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
    end
    plot(V2,V1);                      
end
set(gca,'FontSize',12);
title('kNN MAH R2 Variance of Absolute Error');
legend('Rad=1','Rad=2','Rad=4','Rad=8','Rad=16','Rad=32')
axis([0 100 -1 50])
h=xlabel('Compression Ratio');
set(h, 'FontSize', 15);
h=ylabel('Variance');
set(h, 'FontSize', 15);


figure 
hold on 
for r=1:length(radlst)
    clear V1 V2       
    for n=1:length(TList)
        V1(n)=outAVEArr(n).knn_std.knn_mah_R3_ERR(r);
        V2(n)=outAVEArr(n).Rper3;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
    end
    plot(V2,V1);                      
end
set(gca,'FontSize',12);
title('KNN MAH R3 Variance of Absolute Error');
legend('Rad=1','Rad=2','Rad=4','Rad=8','Rad=16','Rad=32')
axis([0 100 -1 50])
h=xlabel('Compression Ratio');
set(h, 'FontSize', 15);
h=ylabel('Variance');
set(h, 'FontSize', 15);


%-------------------------------------------------------------------------------------------

figure 
hold on 

clear V1 V2       
for n=1:length(TList)
    V1(n)=outAVEArr(n).svm_std.outSVMlinear_R1_ERR;
    V2(n)=outAVEArr(n).Rper1;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
end
plot(V2,V1);                      
clear V1 V2       
for n=1:length(TList)
    V1(n)=outAVEArr(n).svm_std.outSVMrbf_RBF1_R1_ERR;
    V2(n)=outAVEArr(n).Rper1;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList)
    V1(n)=outAVEArr(n).svm_std.outSVMrbf_RBF2_R1_ERR;
    V2(n)=outAVEArr(n).Rper1;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList)
    V1(n)=outAVEArr(n).svm_std.outSVMrbf_RBF3_R1_ERR;
    V2(n)=outAVEArr(n).Rper1;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList)
    V1(n)=outAVEArr(n).svm_std.outSVMrbf_RBF4_R1_ERR;
    V2(n)=outAVEArr(n).Rper1;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList)
    V1(n)=outAVEArr(n).svm_std.outSVMrbf_RBF5_R1_ERR;
    V2(n)=outAVEArr(n).Rper1;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
end
plot(V2,V1); 
set(gca,'FontSize',12);
title('SVM R1 Variance of Absolute Error');
legend('Linear','RBF-1','RBF-2','RBF-3','RBF-4','RBF-5')
axis([0 100 -1 50])
h=xlabel('Compression Ratio');
set(h, 'FontSize', 15);
h=ylabel('Variance');
set(h, 'FontSize', 15);


%-------------------------------------------------------------------------------------------

figure 
hold on 

clear V1 V2       
for n=1:length(TList)
    V1(n)=outAVEArr(n).svm_std.outSVMlinear_R2_ERR;
    V2(n)=outAVEArr(n).Rper2;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
end
plot(V2,V1);                      
clear V1 V2       
for n=1:length(TList)
    V1(n)=outAVEArr(n).svm_std.outSVMrbf_RBF1_R2_ERR;
    V2(n)=outAVEArr(n).Rper2;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList)
    V1(n)=outAVEArr(n).svm_std.outSVMrbf_RBF2_R2_ERR;
    V2(n)=outAVEArr(n).Rper2;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList)
    V1(n)=outAVEArr(n).svm_std.outSVMrbf_RBF3_R2_ERR;
    V2(n)=outAVEArr(n).Rper2;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList)
    V1(n)=outAVEArr(n).svm_std.outSVMrbf_RBF4_R2_ERR;
    V2(n)=outAVEArr(n).Rper2;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList)
    V1(n)=outAVEArr(n).svm_std.outSVMrbf_RBF5_R2_ERR;
    V2(n)=outAVEArr(n).Rper2;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
end
plot(V2,V1); 
set(gca,'FontSize',12);
title('SVM R2 Variance of Absolute Error');
legend('Linear','RBF-1','RBF-2','RBF-3','RBF-4','RBF-5')
axis([0 100 -1 50])
h=xlabel('Compression Ratio');
set(h, 'FontSize', 15);
h=ylabel('Variance');
set(h, 'FontSize', 15);


%-------------------------------------------------------------------------------------------

figure 
hold on 

clear V1 V2       
for n=1:length(TList)
    V1(n)=outAVEArr(n).svm_std.outSVMlinear_R3_ERR;
    V2(n)=outAVEArr(n).Rper3;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
end
plot(V2,V1);                      
clear V1 V2       
for n=1:length(TList)
    V1(n)=outAVEArr(n).svm_std.outSVMrbf_RBF1_R3_ERR;
    V2(n)=outAVEArr(n).Rper3;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList)
    V1(n)=outAVEArr(n).svm_std.outSVMrbf_RBF2_R3_ERR;
    V2(n)=outAVEArr(n).Rper3;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList)
    V1(n)=outAVEArr(n).svm_std.outSVMrbf_RBF3_R3_ERR;
    V2(n)=outAVEArr(n).Rper3;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList)
    V1(n)=outAVEArr(n).svm_std.outSVMrbf_RBF4_R3_ERR;
    V2(n)=outAVEArr(n).Rper3;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
end
plot(V2,V1);  
clear V1 V2       
for n=1:length(TList)
    V1(n)=outAVEArr(n).svm_std.outSVMrbf_RBF5_R3_ERR;
    V2(n)=outAVEArr(n).Rper3;
        if(n>1)
           if (V2(n-1)>V2(n))
              V2(n-1) = V2(n)*0.8; 
              V1(n-1) = V1(n)*0.8; 
           end
        end
end
h=plot(V2,V1); 
set(gca,'FontSize',12);
title('SVM R3 Variance of Absolute Error');
legend('Linear','RBF-1','RBF-2','RBF-3','RBF-4','RBF-5')
axis([0 100 -1 50])
h=xlabel('Compression Ratio');
set(h, 'FontSize', 15);
h=ylabel('Variance');
set(h, 'FontSize', 15);


end

