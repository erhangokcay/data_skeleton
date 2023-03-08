% % % data=getData_Diabetic;
% % % % TList_IRIS_1=[1000,500,100,10,1,0.1, 10e-3,10e-4,10e-5,10e-8,10e-25,10e-50,10e-200,10e-350,10e-500]
% % % %TList_IRIS_1=[10e-200,10e-350,10e-500]
% % % cef_var=0.05;
% % % RdSelect = 1;
% % % TEST=STREAM_SKELETON_PERFORMANCE_ALL1 ( data, 0.2, false, 0, 0.025, 10e-700, 10e-700);

data_Cardiotocography=getData_Cardiotocography;
%TList_IRIS_1=[1000,500,100,10,1,0.1, 10e-3,10e-4,10e-5,10e-8,10e-25,10e-50,10e-200,10e-350,10e-500]
TList_Cardiotocography_1=[1e12,1e10, 1e8, 10000, 1000, 100,0.1, 1e-5,1e-10,1e-20,1e-30,1e-50];
TList = TList_Cardiotocography_1;
cef_var=0.1;
RdSelect = 1;
clear outArr stroutArr outAVEArr_1 outAVEArr_2
for T=1:length(TList)
    
    for n=1:20
        disp(sprintf('T=%f n=%f\n',T,n))
        [outArr(n)] = STREAM_SKELETON_PERFORMANCE_ALL1 ( data_Cardiotocography, 0.2, false, 0, 0.1, TList(T), TList(T));
    end
           
    % For debugging
    outAll_1(T).out = outArr;
    outAVEArr_1(T)=STREAM_SKELETON_AVE_ALL_V2(outArr);
    save MATLAB_Cardiotocography_09_08_2020.mat
end

