for T=1:size(inpstrImageSegmentation,1)
    disp(sprintf('T=%f\n',T))
    for n=1:size(inpstrImageSegmentation,2)
        disp(n);
        [outArr(n).Train] = STREAM_SKELETON_PERFORMANCE_ALL1_NOSKELETON ( inpstrImageSegmentation(T,n) );
        outArr(n).Size_C_TR = size(inpstrImageSegmentation(T,n).str.C_TR);
        outArr(n).Size_C_TR_R1 = size(inpstrImageSegmentation(T,n).str.C_TR_R1);
        outArr(n).Size_C_TR_R2 = size(inpstrImageSegmentation(T,n).str.C_TR_R2);
        outArr(n).Size_C_TR_R3 = size(inpstrImageSegmentation(T,n).str.C_TR_R3);
    end
    
    save MATLAB_IMAGE_SEGMENTATION_TRAINED_RELOADED.mat        
    
    outputImageSegmentation(T)=STREAM_SKELETON_AVE_ALL_V3_CORRECTED(outArr);
end
save MATLAB_IMAGE_SEGMENTATION_TRAINED_RELOADED.mat   