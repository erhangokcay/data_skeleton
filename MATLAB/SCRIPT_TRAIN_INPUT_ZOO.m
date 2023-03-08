clear outputZoo;
for T=1:size(inpstrZoo,1)
    disp(sprintf('T=%f\n',T))
    for n=1:size(inpstrZoo,2)
        disp(n);
        [outArr(n).Train] = STREAM_SKELETON_PERFORMANCE_ALL1_NOSKELETON ( inpstrZoo(T,n) );
        outArr(n).Size_C_TR = size(inpstrZoo(T,n).str.C_TR);
        outArr(n).Size_C_TR_R1 = size(inpstrZoo(T,n).str.C_TR_R1);
        outArr(n).Size_C_TR_R2 = size(inpstrZoo(T,n).str.C_TR_R2);
        outArr(n).Size_C_TR_R3 = size(inpstrZoo(T,n).str.C_TR_R3);
    end
    
    save MATLAB_ZOO_TRAINED_RELOADED.mat        
    
    outputZoo(T)=STREAM_SKELETON_AVE_ALL_V3_CORRECTED(outArr);
end
save MATLAB_ZOO_TRAINED_RELOADED.mat   