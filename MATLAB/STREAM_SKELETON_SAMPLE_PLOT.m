function clust = STREAM_SKELETON_SAMPLE_PLOT(xy,std,T1,T2)
    colors = ['b' 'k' 'r' 'm' 'c' 'y' 'g'];
    shapes = [ 'o'  '+' 'x' '.' '*' 's' 'd'];    
    [clust,numOfClust]=STREAM_SKELETON_VER4_nPNT(xy,std,T1,T2);
    for m=1:size(clust,2)        
        C_TR1_n(m).cl = clust(m).meanClust;      
        C_TR2_n(m).cl = clust(m).maxList;      
        C_TR3_n(m).cl = clust(m).R;
      
        C_LB1_n(m).lb = ones(1,size(C_TR1_n(m).cl,2));
        C_LB2_n(m).lb = ones(1,size(C_TR2_n(m).cl,2));
        C_LB3_n(m).lb = ones(1,size(C_TR3_n(m).cl,2));
    end
    C_TR1_.cl = [C_TR1_n(:).cl];
    C_LB1_.lb = [C_LB1_n(:).lb];
    
    C_TR2_.cl = [C_TR2_n(:).cl];
    C_LB2_.lb = [C_LB2_n(:).lb];
    
    C_TR3_.cl = [C_TR3_n(:).cl];
    C_LB3_.lb = [C_LB3_n(:).lb];    
    
    figure
    axis([-1 1 -1 1])    
    n=1;
    plot(xy(1,:),xy(2,:),strcat(colors(mod(n-1,7)+1),shapes(ceil(n/7))),'LineWidth',2);
    title('Original data set')        
    
    figure
    axis([-1 1 -1 1])    
    hold on
    numC = length(clust)
    for n=1:numC
       plot(clust(n).xy(1,:),clust(n).xy(2,:),strcat(colors(mod(n-1,7)+1),shapes(ceil(n/7))),'LineWidth',2);
    end
    title('Sub Clusters')
    
    figure
    axis([-1 1 -1 1])    
    hold on
    for m=1:size(clust,2)  
        plot(C_TR1_n(m).cl(1,:),C_TR1_n(m).cl(2,:),strcat(colors(mod(m-1,7)+1),shapes(ceil(m/7))),'LineWidth',2);
    end
    title('Feature Set-1')

    figure
    axis([-1 1 -1 1])    
    hold on
    for m=1:size(clust,2)  
        plot(C_TR2_n(m).cl(1,:),C_TR2_n(m).cl(2,:),strcat(colors(mod(m-1,7)+1),shapes(ceil(m/7))),'LineWidth',2);
    end
    title('Feature Set-2')

    figure
    axis([-1 1 -1 1])    
    hold on
    for m=1:size(clust,2)  
        plot(C_TR3_n(m).cl(1,:),C_TR3_n(m).cl(2,:),strcat(colors(mod(m-1,7)+1),shapes(ceil(m/7))),'LineWidth',2);
    end
    title('Feature Set-3')
      
    figure
    p1=plot(cl(1).meanClust(1,:),cl(1).meanClust(2,:),'r*','LineWidth',2);
    hold on
    p2=plot(cl(1).maxList(1,:),cl(1).maxList(2,:),'g*','LineWidth',2);
    axis([-0.4 0.4 0 0.6])
    plot(cl(1).xy(1,:),cl(1).xy(2,:),'ko','LineWidth',1);
    legend('Feature-1','Feature-2','Data')
    
end

