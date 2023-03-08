function [clust, changed] = STREAM_SKELETON_RESHUFFLE_SINGLE_VER4_nPNT_OPTIMIZED(clust, numC, var, Tdist, T)

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
    
    %%%%% numC = size(clust,2); % 2 of clusters so far
   
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
       xpClust = clust(n);
       minVal = 0;
       for m=remList
            val = CEF_local_CPP(xpClust.xy,clust(m).xy, var, 0, statInfo);
            if ( val > minVal ) 
                minVal = val;
                minInd = m;
            end
       end
       if ( minVal > Tdist )  % Otherwise leave the point as it is
            xReduceClust = clust(minInd);
            xRLen = size(xReduceClust.xy,2);
            for k=1:xRLen/2  %% Why divided by 2 ???
                [u1,u2]=CPP_Skeleton_ClosestPoints(xpClust.xy,xReduceClust.xy);
                        
                %%% [cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( clust(m).xy, clust(m).IntCef, clust(m).DCirCef, clust(m).maxValueNew, clust(m).maxListNew, xyp, 0, var, 0, statInfo, 2 );

                if ( size(xpClust.xy,2) == 1 ) 
              		[cefMAXNew1,cefSUMNew1,outMAXPointList1,outMAXDistNew1, maxListNew1, maxValueNew1] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( [xpClust.xy xReduceClust.xy(:,u2)], 0, 0, 0, 0, 0, 0, var, 0, statInfo, 0 );
                    tempXY = xReduceClust.xy;
                    tempXYP = xReduceClust.xy(:,u2);
                    tempXY(:,u2) = [];
                    [cefMAXNew2,cefSUMNew2,outMAXPointList2,outMAXDistNew2, maxListNew2, maxValueNew2] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( tempXY, xReduceClust.IntCef, xReduceClust.DCirCef, xReduceClust.maxValueNew, xReduceClust.maxListNew, tempXYP, u2, var, 0, statInfo, 1 );
                else
                    [cefMAXNew1,cefSUMNew1,outMAXPointList1,outMAXDistNew1, maxListNew1, maxValueNew1] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( xpClust.xy, xpClust.IntCef, xpClust.DCirCef, xpClust.maxValueNew, xpClust.maxListNew, xReduceClust.xy(:,u2), 0, var, 0, statInfo, 2 );
                    tempXY = xReduceClust.xy;
                    tempXYP = xReduceClust.xy(:,u2);
                    tempXY(:,u2) = [];
                    [cefMAXNew2,cefSUMNew2,outMAXPointList2,outMAXDistNew2, maxListNew2, maxValueNew2] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( tempXY, xReduceClust.IntCef, xReduceClust.DCirCef, xReduceClust.maxValueNew, xReduceClust.maxListNew, tempXYP, u2, var, 0, statInfo, 1 );                  
                end
                
                %%% [DCirCefn,~,~,~] = EXECUTE_CPP_SKELETON_V1 ( [xp xReduce(:,u2)], var, 0, statInfo );
                if ( cefMAXNew1 > T )
                   xpClust.xy =  [xpClust.xy xReduceClust.xy(:,u2)];
                   xReduceClust.xy(:,u2) = [];
                   
                   xpClust.DCirCef = cefMAXNew1;  
                   xpClust.maxDist = outMAXDistNew1;
                   xpClust.IntCef = cefSUMNew1;
                   xpClust.outMAXPointList = outMAXPointList1;
                   xpClust.maxListNew = maxListNew1;
                   xpClust.maxValueNew = maxValueNew1;

                   xReduceClust.DCirCef = cefMAXNew2;  
                   xReduceClust.maxDist = outMAXDistNew2;
                   xReduceClust.IntCef = cefSUMNew2;
                   xReduceClust.outMAXPointList = outMAXPointList2;
                   xReduceClust.maxListNew = maxListNew2;
                   xReduceClust.maxValueNew = maxValueNew2;
                
                else
                    break;
                end            
            end
            clust(minInd) = xReduceClust;
            clust(n) = xpClust;  
            
% %             [DCirCefn,~,maxDistn,IntCefn] = EXECUTE_CPP_SKELETON_V1 ( clust(n).xy, var, 0, statInfo );
% %             [DCirCefm,~,maxDistm,IntCefm] = EXECUTE_CPP_SKELETON_V1 ( clust(minInd).xy, var, 0, statInfo );
% %             clust(n).DCirCef = DCirCefn;
% %             clust(minInd).DCirCef = DCirCefm;
% %             clust(n).maxDist = maxDistn;
% %             clust(minInd).maxDist = maxDistm;
% %             clust(n).IntCef = IntCefn;
% %             clust(minInd).IntCef = IntCefm;
  
            
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

