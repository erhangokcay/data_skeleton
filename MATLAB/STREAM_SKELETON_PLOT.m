function STREAM_SKELETON_PLOT(clust)
    colors = ['b' 'k' 'r' 'm' 'c' 'y' 'g'];
    shapes = [ 'o'  '+' 'x' '.' '*' 's' 'd'];    
    axis([-1 1 -1 1])    
    hold on
    numC = size(clust,2)
    for n=1:numC
       plot(clust(n).xy(1,:),clust(n).xy(2,:),strcat(colors(mod(n-1,7)+1),shapes(ceil(n/7))),'LineWidth',2);
    end
end

