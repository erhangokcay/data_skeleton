function [clust, changed] = STREAM_SKELETON_RESHUFFLE_INTCEF_VER4_nPNT(clust, var, nPnt, T)

 % HOW TO STOP CYCLIC CHANGES???? 
 
 % This may work only for nPnt=1. Otherwise any close pair will dominate 
 % the cluster and change the shape in a wrong way.
  clustOrig = clust;
  lessT = @(x,Tres) x > Tres ;
    colors = ['b' 'k' 'r' 'm' 'c' 'y' 'g'];
    shapes = [ '.'  'o' 'x' '+' '*' 's' 'd'];
   numC = size(clust,2); % 2 of clusters so far
       
    if ( numC > 1 )      
        for n=1:numC                       
            for m=n+1:numC
                modified = true;
                while ( modified )
                    modified = false;
                    xy1 = clust(n).xy;
                    xy2 = clust(m).xy;
                    len1 = size(xy1,2);
                    len2 = size(xy2,2);
                    %p1=plot(xy1(1,:),xy1(2,:),'ro');
                    %p2=plot(xy2(1,:),xy2(2,:),'ro');
                    % Copy Points from clust1  to clust2
                    clear u1 u2;
                    xy1Temp = xy1; % Use this to delete the closest points found fo far
                    for k=1:nPnt % # of closest points from clust1   
                        len1 = size(xy1Temp,2);
                        if ( len1 > k ) 
                           [u1(k),u2(k)]=CPP_Skeleton_ClosestPoints(xy1Temp,xy2);
                           xtemp1 = xy1;
                           xtemp1(:,u1) = []; % Delete from clust1
                           xtemp2 = [ xy2 xy1(:,u1)]; % add to clust2
                           [DCirCefn,~,maxDistn,IntCefn] = EXECUTE_CPP_SKELETON ( xtemp1, var, 0 );
                           [DCirCefm,~,maxDistm,IntCefm] = EXECUTE_CPP_SKELETON ( xtemp2, var, 0 );
                           % If the clusters are tigther
                           % cond = lessT(DCirCefn,T) && lessT(DCirCefm,T);
                           if ( (IntCefn > clust(n).IntCef && IntCefm >= clust(m).IntCef) || ...
                                   (IntCefn >= clust(n).IntCef && IntCefm > clust(m).IntCef) ) 
                                clust(n).xy = xtemp1;
                                clust(m).xy = xtemp2;
                                clust(n).DCirCef = DCirCefn;
                                clust(m).DCirCef = DCirCefm;
                                clust(n).maxDist = maxDistn;
                                clust(m).maxDist = maxDistm;
                                clust(n).IntCef = IntCefn;
                                clust(m).IntCef = IntCefm;
                                 
                                modified = true;
                                %%%% fprintf('LOOP1 n= %d m= %d k=%d\n',n,m,k);
                           
                           end
                           xy1Temp(:,u1(k)) = [Inf;Inf]; % Delete the closest point, so that next closest point can be found
                           if ( modified ) 
                               break
                           end
                        else
                            break
                        end
                    end
                end
                % Do it for clust2
                                                
                modified = true;
                while ( modified )
                    modified = false;
                    xy1 = clust(n).xy;
                    xy2 = clust(m).xy;
                    len1 = size(xy1,2);
                    len2 = size(xy2,2);
                    %p1=plot(xy1(1,:),xy1(2,:),'ro');
                    %p2=plot(xy2(1,:),xy2(2,:),'ro');
                    % Copy closest Points from clust2  to clust1
                    clear u1 u2;
                    xy2Temp = xy2; % Use this to delete the closest points found fo far
                    clear u1 u2;
                    for k=1:nPnt % # of closest points from clust1  
                        len2 = size(xy2Temp,2);
                        if ( len2 > k ) 
                           [u1(k),u2(k)]=CPP_Skeleton_ClosestPoints(xy1,xy2Temp);
                           xtemp2 = xy2;
                           xtemp2(:,u2) = []; % Delete from clust1
                           xtemp1 = [ xy1 xy2(:,u2)]; % add to clust2
                           [DCirCefn,~,maxDistn,IntCefn] = EXECUTE_CPP_SKELETON ( xtemp1, var, 0 );
                           [DCirCefm,~,maxDistm,IntCefm] = EXECUTE_CPP_SKELETON ( xtemp2, var, 0 );
                           % If the clusters are tigther
                           % cond = lessT(DCirCefn,T) && lessT(DCirCefm,T);
                           if ( (IntCefn > clust(n).IntCef && IntCefm >= clust(m).IntCef) || ...
                                   (IntCefn >= clust(n).IntCef && IntCefm > clust(m).IntCef) ) 
                                clust(n).xy = xtemp1;
                                clust(m).xy = xtemp2;
                                clust(n).DCirCef = DCirCefn;
                                clust(m).DCirCef = DCirCefm;
                                clust(n).maxDist = maxDistn;
                                clust(m).maxDist = maxDistm;
                                clust(n).IntCef = IntCefn;
                                clust(m).IntCef = IntCefm;
                                 
                                modified = true;
                                %%%% fprintf('LOOP2 n= %d m= %d k=%d\n',n,m,k);                           
                           end
                           xy2Temp(:,u2(k)) = [Inf;Inf]; % Delete the closest point, so that next closest point can be found
                           if ( modified ) 
                               break
                           end
                        else
                            break
                        end
                    end
                end
                a=1;
                %STREAM_SKELETON_PLOT(clust);
                %pause
                % Move only 1-2-3-...? points from one cluster to another                
                
            end
        end
    end
    
    
    changed = false;
    for n=1:numC
        if ( length(clustOrig(n).xy) ~= length(clust(n).xy) )
            changed = true;
            break;
        elseif (clustOrig(n).xy ~= clust(n).xy)
            changed = true;
            break;
        end        
    end
    
end
