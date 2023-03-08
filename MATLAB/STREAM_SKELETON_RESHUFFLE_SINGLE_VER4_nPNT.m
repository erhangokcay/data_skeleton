function [clust, changed] = STREAM_SKELETON_RESHUFFLE_SINGLE_VER4_nPNT(clust, var, Tdist, T)

   statInfo = CEF_CALCULATE_STATINFO(size(clust(1).xy),var,0);

    clustOrig= clust;
 % Eliminate single points
 % Test: measure distance (euc,cef?) from single point to clusters. If the shortest
 % is less than a treshold
 %  a) join.
 %  b) collect points from the nearest cluster to single point (How many? %50)
    
    lessT = @(x,Tres) x > Tres ;
    colors = ['b' 'k' 'r' 'm' 'c' 'y' 'g'];
    shapes = [ '.'  'o' 'x' '+' '*' 's' 'd'];
    numC = size(clust,2); % 2 of clusters so far
   
   % Find single point clusters
   k=1;
   singleList = [];
   for n=1:numC     
       if ( size(clust(n).xy,2) == 1 ) 
           singleList(k) = n;
           k = k + 1;
       end
   end
   
   if ( isempty(singleList) )
       changed = false;
       return
   end
   
   remList=1:numC;
   
   % Delete single list points from the list
   remList(singleList) = [];
   % Repeat For all single point clusters
   for n=singleList
       xp = clust(n).xy;
       minVal = 0;
       for m=remList
            val = CEF_local_CPP(xp,clust(m).xy, var, 0, statInfo);
            if ( val > minVal ) 
                minVal = val;
                minInd = m;
            end
       end
       if ( minVal > Tdist )  % Otherwise leave the point as it is
            xReduce = clust(minInd).xy;
            xRLen = size(xReduce,2);
            for k=1:xRLen/2
                [u1,u2]=CPP_Skeleton_ClosestPoints(xp,xReduce);

                [DCirCefn,~,~,~] = EXECUTE_CPP_SKELETON_V1 ( [xp xReduce(:,u2)], var, 0, statInfo );
                if ( DCirCefn > T )
                   xp =  [xp xReduce(:,u2)];
                   xReduce(:,u2) = [];
                else
                    break;
                end            
            end
            clust(minInd).xy = xReduce;
            clust(n).xy = xp;  
            
            [DCirCefn,~,maxDistn,IntCefn] = EXECUTE_CPP_SKELETON_V1 ( clust(n).xy, var, 0, statInfo );
            [DCirCefm,~,maxDistm,IntCefm] = EXECUTE_CPP_SKELETON_V1 ( clust(minInd).xy, var, 0, statInfo );
            clust(n).DCirCef = DCirCefn;
            clust(minInd).DCirCef = DCirCefm;
            clust(n).maxDist = maxDistn;
            clust(minInd).maxDist = maxDistm;
            clust(n).IntCef = IntCefn;
            clust(minInd).IntCef = IntCefm;
  
            
       end
   end
   

    
    changed = false;
    for n=1:numC
        if ( length(clustOrig(n).xy(:)) ~= length(clust(n).xy(:)) )
            changed = true;
            break;
        elseif (clustOrig(n).xy ~= clust(n).xy)
            changed = true;
            break;
        end        
    end
    
end

