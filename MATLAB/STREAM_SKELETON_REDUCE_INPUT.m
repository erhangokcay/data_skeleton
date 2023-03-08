function outArr = STREAM_SKELETON_REDUCE_INPUT(data, var, TList)
%UNTÝTLED2 Summary of this function goes here
%   Detailed explanation goes here
    for T=length(TList):-1:1
        for n=1:10
            disp(sprintf('T=%f n=%f\n',T,n))
            %%% [outArr(T,n)] = STREAM_SKELETON_INPUT_DATASET ( data, percent, flag, str, std1, T1, T2 );
            [outArr(T,n)] = STREAM_SKELETON_INPUT_DATASET_OPTIMIZED ( data, 0.2, false, [] , var, TList(T), TList(T) );
            %%%% STREAM_SKELETON_PERFORMANCE_ALL1 ( data, 0.2, false, 0, var, TList(T), TList(T));
        end
    end
    
end

