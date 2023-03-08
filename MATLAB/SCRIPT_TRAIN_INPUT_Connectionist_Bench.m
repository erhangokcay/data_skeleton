clear outputConnectionist_Bench;
for T=1:size(inpstrConnectionist_Bench,1)
    disp(sprintf('T=%f\n',T))
    clear outArr;
    for n=1:size(inpstrConnectionist_Bench,2)
        disp(n);
        [outArr(n).Train] = STREAM_SKELETON_PERFORMANCE_ALL1_NOSKELETON ( inpstrConnectionist_Bench(T,n) );
        outArr(n).Size_C_TR = size(inpstrConnectionist_Bench(T,n).str.C_TR);
        outArr(n).Size_C_TR_R1 = size(inpstrConnectionist_Bench(T,n).str.C_TR_R1);
        outArr(n).Size_C_TR_R2 = size(inpstrConnectionist_Bench(T,n).str.C_TR_R2);
        outArr(n).Size_C_TR_R3 = size(inpstrConnectionist_Bench(T,n).str.C_TR_R3);
    end
    
    %save MATLAB_HEART_TRAINED_RELOADED.mat        
    
    outputConnectionist_Bench(T)=STREAM_SKELETON_AVE_ALL_V3_CORRECTED(outArr);
end
%save MATLAB_HEART_TRAINED_RELOADED.mat   