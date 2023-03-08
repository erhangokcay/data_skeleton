for T=1:size(inpstrCongressional_Voting,1)
    disp(sprintf('T=%f\n',T))
    for n=1:size(inpstrCongressional_Voting,2)
        disp(n);
        [outArr(n).Train] = STREAM_SKELETON_PERFORMANCE_ALL1_NOSKELETON ( inpstrCongressional_Voting(T,n) );
        outArr(n).Size_C_TR = size(inpstrCongressional_Voting(T,n).str.C_TR);
        outArr(n).Size_C_TR_R1 = size(inpstrCongressional_Voting(T,n).str.C_TR_R1);
        outArr(n).Size_C_TR_R2 = size(inpstrCongressional_Voting(T,n).str.C_TR_R2);
        outArr(n).Size_C_TR_R3 = size(inpstrCongressional_Voting(T,n).str.C_TR_R3);
    end
    
    save MATLAB_VOTE_TRAINED_RELOADED.mat        
    
    outputCongressional_Voting(T)=STREAM_SKELETON_AVE_ALL_V3_CORRECTED(outArr);
end
save MATLAB_VOTE_TRAINED_RELOADED.mat   