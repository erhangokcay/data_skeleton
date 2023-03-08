for T=1:size(inpstrHeart,1)
    disp(sprintf('T=%f\n',T))
    for n=1:size(inpstrHeart,2)
        disp(n);
        [outArr(n).Train] = STREAM_SKELETON_PERFORMANCE_ALL1_NOSKELETON ( inpstrHeart(T,n) );
        outArr(n).Size_C_TR = size(inpstrHeart(T,n).str.C_TR);
        outArr(n).Size_C_TR_R1 = size(inpstrHeart(T,n).str.C_TR_R1);
        outArr(n).Size_C_TR_R2 = size(inpstrHeart(T,n).str.C_TR_R2);
        outArr(n).Size_C_TR_R3 = size(inpstrHeart(T,n).str.C_TR_R3);
    end
    
    save MATLAB_HEART_TRAINED_RELOADED.mat        
    
    outputrHeart(T)=STREAM_SKELETON_AVE_ALL_V3_CORRECTED(outArr);
end
save MATLAB_HEART_TRAINED_RELOADED.mat   