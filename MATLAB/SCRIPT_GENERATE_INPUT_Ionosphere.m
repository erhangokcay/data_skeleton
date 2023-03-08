% % % data=getData_Diabetic;
% % % % TList_IRIS_1=[1000,500,100,10,1,0.1, 10e-3,10e-4,10e-5,10e-8,10e-25,10e-50,10e-200,10e-350,10e-500]
% % % %TList_IRIS_1=[10e-200,10e-350,10e-500]
% % % cef_var=0.05;
% % % RdSelect = 1;
% % % TEST=STREAM_SKELETON_PERFORMANCE_ALL1 ( data, 0.2, false, 0, 0.025, 10e-700, 10e-700);

%data_Ionosphere = getData_Ionosphere;
%TList_IRIS_1=[1000,500,100,10,1,0.1, 10e-3,10e-4,10e-5,10e-8,10e-25,10e-50,10e-200,10e-350,10e-500]
% T=0 means original dataset. Copy by hand, not in the loop
TList_Ionosphere_1=[1e12,1e10,1e7,1e0,1e-10, 1e-50,1e-150,1e-200,1e-250];
TList = TList_Ionosphere_1;
cef_var=0.15;
RdSelect = 1;
% clear outArr stroutArr outAVEArr_1 outAVEArr_2
for T=1:length(TList)    
    for n=1:10
        disp(sprintf('T=%f n=%f\n',T,n))
%        inpstrIonosphere(T,n) = STREAM_SKELETON_INPUT_DATASET_OPTIMIZED ( data_Ionosphere, 0.2, false, [], 0.1, TList(T), TList(T) );
        inpstrIonosphere(T,n) = STREAM_SKELETON_INPUT_DATASET ( data_Ionosphere, 0.2, false, [], 0.15, TList(T), TList(T) );
        save MATLAB_Ionosphere_18_03_2021.mat
        % [outArr(n)] = STREAM_SKELETON_PERFORMANCE_ALL1 ( data_Cardiotocography, 0.2, false, 0, 0.1, TList(T), TList(T));
    end           
    % For debugging
    % outAll_1(T).out = outArr;
    % outAVEArr_1(T)=STREAM_SKELETON_AVE_ALL_V2(outArr);
    
end
save MATLAB_Ionosphere_18_03_2021.mat
