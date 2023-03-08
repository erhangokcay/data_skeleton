% % % data=getData_Diabetic;
% % % % TList_IRIS_1=[1000,500,100,10,1,0.1, 10e-3,10e-4,10e-5,10e-8,10e-25,10e-50,10e-200,10e-350,10e-500]
% % % %TList_IRIS_1=[10e-200,10e-350,10e-500]
% % % cef_var=0.05;
% % % RdSelect = 1;
% % % TEST=STREAM_SKELETON_PERFORMANCE_ALL1 ( data, 0.2, false, 0, 0.025, 10e-700, 10e-700);

data_DIABETIC=getData_Diabetic;
%TList_IRIS_1=[1000,500,100,10,1,0.1, 10e-3,10e-4,10e-5,10e-8,10e-25,10e-50,10e-200,10e-350,10e-500]
TList_DIABETIC_1=[1e11,5e10,2e10,1e10,2e9,1e9, 1e8,1e6,1000,0.1,1e-9,1e-19,1e-99];
TList = TList_DIABETIC_1;
cef_var=0.05;
RdSelect = 1;
clear outArr stroutArr outAVEArr_1 outAVEArr_2
for T=5:length(TList)
    
    for n=1:50
        disp(n);
        [outArr(n)] = STREAM_SKELETON_PERFORMANCE_ALL1 ( data_DIABETIC, 0.2, false, 0, 0.1, TList(T), TList(T));
    end
    memory
    save MATLAB_DIABETICS_28_06_2020.mat
    disp(sprintf('T=%f\n',T))
    % For debugging
    outAll_1(T).out = outArr;
    outAVEArr_1(T)=STREAM_SKELETON_AVE_ALL_V2(outArr);
end

for T=1:length(TList)
    
    for n=1:50
        disp(n);
        [outArr(n)] = STREAM_SKELETON_PERFORMANCE_ALL1 ( data_DIABETIC, 0.2, false, 0, 0.025, TList(T), TList(T));
    end
    memory
    save MATLAB_DIABETICS_28_06_2020.mat
    disp(sprintf('T=%f\n',T))
    % For debugging
    outAll_2(T).out = outArr;
    outAVEArr_2(T)=STREAM_SKELETON_AVE_ALL_V2(outArr);
end