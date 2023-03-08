for T=2:size(inpstrCardio,1)
    disp(sprintf('T=%f\n',T))
    for n=1:size(inpstrCardio,2)
        disp(sprintf('n=%f\n',n));
        [outArr(n).Train] = STREAM_SKELETON_PERFORMANCE_ALL1_NOSKELETON ( inpstrCardio(T,n) );
        outArr(n).Size_C_TR = size(inpstrCardio(T,n).str.C_TR);
        outArr(n).Size_C_TR_R1 = size(inpstrCardio(T,n).str.C_TR_R1);
        outArr(n).Size_C_TR_R2 = size(inpstrCardio(T,n).str.C_TR_R2);
        outArr(n).Size_C_TR_R3 = size(inpstrCardio(T,n).str.C_TR_R3);
    end
    
    %save MATLAB_IMAGE_SEGMENTATION_TRAINED.mat        
    
    outputCardio(T)=STREAM_SKELETON_AVE_ALL_V3_CORRECTED(outArr);
end
%save MATLAB_IMAGE_SEGMENTATION_TRAINED.mat   