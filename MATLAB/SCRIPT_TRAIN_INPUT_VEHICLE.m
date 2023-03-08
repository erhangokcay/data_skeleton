clear outputVehicle;
for T=1:size(inpstrVehicle,1)
    disp(sprintf('T=%f\n',T))
    clear outArr;
    for n=1:size(inpstrVehicle,2)
        disp(n);
        [outArr(n).Train] = STREAM_SKELETON_PERFORMANCE_ALL1_NOSKELETON ( inpstrVehicle(T,n) );
        outArr(n).Size_C_TR = size(inpstrVehicle(T,n).str.C_TR);
        outArr(n).Size_C_TR_R1 = size(inpstrVehicle(T,n).str.C_TR_R1);
        outArr(n).Size_C_TR_R2 = size(inpstrVehicle(T,n).str.C_TR_R2);
        outArr(n).Size_C_TR_R3 = size(inpstrVehicle(T,n).str.C_TR_R3);
    end
    
    save MATLAB_VEHICLE_TRAINED_RELOADED.mat        
    
    outputVehicle(T)=STREAM_SKELETON_AVE_ALL_V3_CORRECTED(outArr);
end
save MATLAB_VEHICLE_TRAINED_RELOADED.mat   