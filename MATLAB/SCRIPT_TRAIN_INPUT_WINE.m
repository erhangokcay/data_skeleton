for T=1:size(inpstrWine,1)
    disp(sprintf('T=%f\n',T))
    for n=1:size(inpstrWine,2)
        disp(n);
        [outArr(n).Train] = STREAM_SKELETON_PERFORMANCE_ALL1_NOSKELETON ( inpstrWine(T,n) );
        outArr(n).Size_C_TR = size(inpstrWine(T,n).str.C_TR);
        outArr(n).Size_C_TR_R1 = size(inpstrWine(T,n).str.C_TR_R1);
        outArr(n).Size_C_TR_R2 = size(inpstrWine(T,n).str.C_TR_R2);
        outArr(n).Size_C_TR_R3 = size(inpstrWine(T,n).str.C_TR_R3);
    end
    
    %save MATLAB_WINE_TRAINED.mat        
    
    outputWine(T)=STREAM_SKELETON_AVE_ALL_V3_CORRECTED(outArr);
end
%save MATLAB_WINE_TRAINED.mat      
