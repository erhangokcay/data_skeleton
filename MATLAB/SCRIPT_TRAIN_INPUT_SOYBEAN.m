clear outputSoybean;
for T=1:size(inpstrSoybean,1)
    disp(sprintf('T=%f\n',T))
    clear outArr;
    for n=1:size(inpstrSoybean,2)
        disp(n);
        [outArr(n).Train] = STREAM_SKELETON_PERFORMANCE_ALL1_NOSKELETON ( inpstrSoybean(T,n) );
        outArr(n).Size_C_TR = size(inpstrSoybean(T,n).str.C_TR);
        outArr(n).Size_C_TR_R1 = size(inpstrSoybean(T,n).str.C_TR_R1);
        outArr(n).Size_C_TR_R2 = size(inpstrSoybean(T,n).str.C_TR_R2);
        outArr(n).Size_C_TR_R3 = size(inpstrSoybean(T,n).str.C_TR_R3);
    end
    
    save MATLAB_SOYBEAN_TRAINED_RELOADED.mat        
    
    outputSoybean(T)=STREAM_SKELETON_AVE_ALL_V3_CORRECTED(outArr);
end
save MATLAB_SOYBEAN_TRAINED_RELOADED.mat   