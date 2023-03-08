for T=1:size(inpstrAustralian,1)
    disp(sprintf('T=%f\n',T))
    for n=1:size(inpstrAustralian,2)
        disp(n);
        [outArr(n).Train] = STREAM_SKELETON_PERFORMANCE_ALL1_NOSKELETON ( inpstrAustralian(T,n) );
        outArr(n).Size_C_TR = size(inpstrAustralian(T,n).str.C_TR);
        outArr(n).Size_C_TR_R1 = size(inpstrAustralian(T,n).str.C_TR_R1);
        outArr(n).Size_C_TR_R2 = size(inpstrAustralian(T,n).str.C_TR_R2);
        outArr(n).Size_C_TR_R3 = size(inpstrAustralian(T,n).str.C_TR_R3);
    end
    
    save MATLAB_AUSTRALIAN_TRAINED.mat        
    
    outputAustralian(T)=STREAM_SKELETON_AVE_ALL_V3(outArr);
end
save MATLAB_AUSTRALIAN_TRAINED.mat   