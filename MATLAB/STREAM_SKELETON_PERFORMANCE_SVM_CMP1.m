function [out] = STREAM_SKELETON_PERFORMANCE_SVM_CMP1(inp,select)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
str = inp.str;
% Reduced Data
if ( select == 1)
    C_TR_LB_R=str.C_TR_LB_R1;
    C_TR_R=str.C_TR_R1;
elseif(select == 2)
    C_TR_LB_R=str.C_TR_LB_R2;
    C_TR_R=str.C_TR_R2;
elseif(select == 3)
    C_TR_LB_R=str.C_TR_LB_R3;
    C_TR_R=str.C_TR_R3;
end     
% Original Data
C_TR_LB=str.C_TR_LB;
C_TR=str.C_TR;
% Original Test Set
C_TE_LB=str.C_TE_LB;
C_TE=str.C_TE;

Nlabels = length(unique(str.C_TR_LB));

%----------------------ORIGINAL---------------------------------------
try 
    Model=svm.train(C_TR',str.C_TR_LB);
    predict=svm.predict(Model,C_TE');
    if ( size(predict,2) > 1 ) 
        predict = predict';
    end
    out.outSVMlinear=mean(C_TE_LB'==predict)*100;

    outSVMlinear_stat = zeros(Nlabels,Nlabels);
    for n=1:size(C_TE,2)
         outSVMlinear_stat(C_TE_LB(n),predict(n)) = outSVMlinear_stat(C_TE_LB(n),predict(n)) + 1;
    end
    out.outSVMlinear_stat = outSVMlinear_stat;
    
catch me
    disp('LINEAR EXP')
    out.outSVMlinear = NaN;
    out.outSVMlinear_stat = NaN;
end

%----------------------REDUCED---------------------------------------
try 
    Model=svm.train(C_TR_R',C_TR_LB_R);
    predict=svm.predict(Model,C_TE');
    if ( size(predict,2) > 1 ) 
        predict = predict';
    end
    out.outSVMlinear_R=mean(C_TE_LB'==predict)*100;

    outSVMlinear_stat_R = zeros(Nlabels,Nlabels);
    for n=1:size(C_TE,2)
         outSVMlinear_stat_R(C_TE_LB(n),predict(n)) = outSVMlinear_stat_R(C_TE_LB(n),predict(n)) + 1;
    end
    out.outSVMlinear_stat_R = outSVMlinear_stat_R;
    
catch me
    disp('LINEAR EXP')
    out.outSVMlinear_R = NaN;
    out.outSVMlinear_stat_R = NaN;
end

%--------------------------ORIGINAL--------------------------------
try
    Model=svm.train(C_TR',C_TR_LB,'kernel_function','rbf','rbf_sigma',1);
    predict=svm.predict(Model,C_TE');
    if ( size(predict,2) > 1 ) 
        predict = predict';
    end

    out.outSVMrbf=mean(C_TE_LB'==predict)*100;

    outSVMrbf_stat = zeros(Nlabels,Nlabels);
    for n=1:size(C_TE,2)
         outSVMrbf_stat(C_TE_LB(n),predict(n)) = outSVMrbf_stat(C_TE_LB(n),predict(n)) + 1;
    end
    out.outSVMrbf_stat = outSVMrbf_stat;

catch me   
    disp('RBF EXP')
    out.outSVMrbf = NaN;
    out.outSVMrbf_stat = NaN;
end
    
%--------------------------REDUCED--------------------------------
try
    Model=svm.train(C_TR_R',C_TR_LB_R,'kernel_function','rbf','rbf_sigma',1);
    predict=svm.predict(Model,C_TE');
    if ( size(predict,2) > 1 ) 
        predict = predict';
    end

    out.outSVMrbf_R=mean(C_TE_LB'==predict)*100;

    outSVMrbf_stat_R = zeros(Nlabels,Nlabels);
    for n=1:size(C_TE,2)
         outSVMrbf_stat_R(C_TE_LB(n),predict(n)) = outSVMrbf_stat_R(C_TE_LB(n),predict(n)) + 1;
    end
    out.outSVMrbf_stat_R = outSVMrbf_stat_R;

catch me   
    disp('RBF EXP')
    out.outSVMrbf_R = NaN;
    out.outSVMrbf_stat_R = NaN;
end
    
%--------------------------ORIGINAL--------------------------------

try
    Model=svm.train(C_TR',C_TR_LB,'kernel_function','rbf','rbf_sigma',2);
    predict=svm.predict(Model,C_TE');
    if ( size(predict,2) > 1 ) 
        predict = predict';
    end
    
    out.outSVMrbf_1=mean(C_TE_LB'==predict)*100;

    outSVMrbf_1_stat = zeros(Nlabels,Nlabels);
    for n=1:size(C_TE,2)
         outSVMrbf_1_stat(C_TE_LB(n),predict(n)) = outSVMrbf_1_stat(C_TE_LB(n),predict(n)) + 1;
    end
    out.outSVMrbf_1_stat = outSVMrbf_1_stat;
catch me       
    disp('RBF_1 EXP')
    out.outSVMrbf_1 = NaN;
     out.outSVMrbf_1_stat = NaN;
end

%--------------------------REDUCED--------------------------------

try
    Model=svm.train(C_TR_R',C_TR_LB_R,'kernel_function','rbf','rbf_sigma',2);
    predict=svm.predict(Model,C_TE');
    if ( size(predict,2) > 1 ) 
        predict = predict';
    end
    
    out.outSVMrbf_1_R=mean(C_TE_LB'==predict)*100;

    outSVMrbf_1_stat_R = zeros(Nlabels,Nlabels);
    for n=1:size(C_TE,2)
         outSVMrbf_1_stat_R(C_TE_LB(n),predict(n)) = outSVMrbf_1_stat_R(C_TE_LB(n),predict(n)) + 1;
    end
    out.outSVMrbf_1_stat_R = outSVMrbf_1_stat_R;
catch me       
    disp('RBF_1 EXP')
    out.outSVMrbf_1_R = NaN;
     out.outSVMrbf_1_stat_R = NaN;
end

%--------------------------ORIGINAL--------------------------------


try
    Model=svm.train(C_TR',C_TR_LB,'kernel_function','rbf','rbf_sigma',5);
    predict=svm.predict(Model,C_TE');
    if ( size(predict,2) > 1 ) 
        predict = predict';
    end
    
    out.outSVMrbf_2=mean(C_TE_LB'==predict)*100;

    outSVMrbf_2_stat = zeros(Nlabels,Nlabels);
    for n=1:size(C_TE,2)
         outSVMrbf_2_stat(C_TE_LB(n),predict(n)) = outSVMrbf_2_stat(C_TE_LB(n),predict(n)) + 1;
    end
    out.outSVMrbf_2_stat = outSVMrbf_2_stat;

catch me   
    disp('RBF_2 EXP')
    out.outSVMrbf_2 = NaN;       
    out.outSVMrbf_2_stat = NaN;        
end

%--------------------------REDUCED--------------------------------


try
    Model=svm.train(C_TR_R',C_TR_LB_R,'kernel_function','rbf','rbf_sigma',5);
    predict=svm.predict(Model,C_TE');
    if ( size(predict,2) > 1 ) 
        predict = predict';
    end
    
    out.outSVMrbf_2_R=mean(C_TE_LB'==predict)*100;

    outSVMrbf_2_stat_R = zeros(Nlabels,Nlabels);
    for n=1:size(C_TE,2)
         outSVMrbf_2_stat_R(C_TE_LB(n),predict(n)) = outSVMrbf_2_stat_R(C_TE_LB(n),predict(n)) + 1;
    end
    out.outSVMrbf_2_stat_R = outSVMrbf_2_stat_R;

catch me   
    disp('RBF_2 EXP')
    out.outSVMrbf_2_R = NaN;       
    out.outSVMrbf_2_stat_R = NaN;        
end

%---------------------------------------------------------------------------------------
try
    Model=svm.train(C_TR',C_TR_LB,'kernel_function','rbf','rbf_sigma',10);
    predict=svm.predict(Model,C_TE');
    if ( size(predict,2) > 1 ) 
        predict = predict';
    end
    
    out.outSVMrbf_3=mean(C_TE_LB'==predict)*100;

    outSVMrbf_3_stat = zeros(Nlabels,Nlabels);
    for n=1:size(C_TE,2)
         outSVMrbf_3_stat(C_TE_LB(n),predict(n)) = outSVMrbf_3_stat(C_TE_LB(n),predict(n)) + 1;
    end
    out.outSVMrbf_3_stat = outSVMrbf_3_stat;

catch me   
    disp('RBF_3 EXP')
    out.outSVMrbf_3 = NaN;       
    out.outSVMrbf_3_stat = NaN;        
end

%--------------------------REDUCED--------------------------------


try
    Model=svm.train(C_TR_R',C_TR_LB_R,'kernel_function','rbf','rbf_sigma',10);
    predict=svm.predict(Model,C_TE');
    if ( size(predict,2) > 1 ) 
        predict = predict';
    end
    
    out.outSVMrbf_3_R=mean(C_TE_LB'==predict)*100;

    outSVMrbf_3_stat_R = zeros(Nlabels,Nlabels);
    for n=1:size(C_TE,2)
         outSVMrbf_3_stat_R(C_TE_LB(n),predict(n)) = outSVMrbf_3_stat_R(C_TE_LB(n),predict(n)) + 1;
    end
    out.outSVMrbf_3_stat_R = outSVMrbf_3_stat_R;

catch me   
    disp('RBF_3 EXP')
    out.outSVMrbf_3_R = NaN;       
    out.outSVMrbf_3_stat_R = NaN;        
end

%--------------------------------------------------------------------------------------
%---------------------------------------------------------------------------------------
try
    Model=svm.train(C_TR',C_TR_LB,'kernel_function','rbf','rbf_sigma',20);
    predict=svm.predict(Model,C_TE');
    if ( size(predict,2) > 1 ) 
        predict = predict';
    end
    
    out.outSVMrbf_4=mean(C_TE_LB'==predict)*100;

    outSVMrbf_4_stat = zeros(Nlabels,Nlabels);
    for n=1:size(C_TE,2)
         outSVMrbf_4_stat(C_TE_LB(n),predict(n)) = outSVMrbf_4_stat(C_TE_LB(n),predict(n)) + 1;
    end
    out.outSVMrbf_4_stat = outSVMrbf_4_stat;

catch me   
    disp('RBF_4 EXP')
    out.outSVMrbf_4 = NaN;       
    out.outSVMrbf_4_stat = NaN;        
end

%--------------------------REDUCED--------------------------------


try
    Model=svm.train(C_TR_R',C_TR_LB_R,'kernel_function','rbf','rbf_sigma',20);
    predict=svm.predict(Model,C_TE');
    if ( size(predict,2) > 1 ) 
        predict = predict';
    end
    
    out.outSVMrbf_4_R=mean(C_TE_LB'==predict)*100;

    outSVMrbf_4_stat_R = zeros(Nlabels,Nlabels);
    for n=1:size(C_TE,2)
         outSVMrbf_4_stat_R(C_TE_LB(n),predict(n)) = outSVMrbf_4_stat_R(C_TE_LB(n),predict(n)) + 1;
    end
    out.outSVMrbf_4_stat_R = outSVMrbf_4_stat_R;

catch me   
    disp('RBF_4 EXP')
    out.outSVMrbf_4_R = NaN;       
    out.outSVMrbf_4_stat_R = NaN;        
end


end

