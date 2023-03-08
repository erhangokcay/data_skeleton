for T=1:size(inpstrHorseColic,1)
    disp(sprintf('T=%f\n',T))
    for n=1:size(inpstrHorseColic,2)
        disp(n);
        [outArr(n).Train] = STREAM_SKELETON_PERFORMANCE_ALL1_NOSKELETON ( inpstrHorseColic(T,n) );
        outArr(n).Size_C_TR = size(inpstrHorseColic(T,n).str.C_TR);
        outArr(n).Size_C_TR_R1 = size(inpstrHorseColic(T,n).str.C_TR_R1);
        outArr(n).Size_C_TR_R2 = size(inpstrHorseColic(T,n).str.C_TR_R2);
        outArr(n).Size_C_TR_R3 = size(inpstrHorseColic(T,n).str.C_TR_R3);
    end
    
    save MATLAB_HORSECOLIC_TRAINED_RELOADED.mat        
    
    outputHorseColic(T)=STREAM_SKELETON_AVE_ALL_V3_CORRECTED(outArr);
end
save MATLAB_HORSECOLIC_TRAINED_RELOADED.mat   