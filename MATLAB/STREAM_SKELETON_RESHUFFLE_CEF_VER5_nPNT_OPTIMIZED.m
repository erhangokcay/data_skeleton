function [clust, changed] = STREAM_SKELETON_RESHUFFLE_CEF_VER5_nPNT_OPTIMIZED(clust, numC, var, nPnt, T)

    statInfo = CEF_CALCULATE_STATINFO(size(clust(1).xy),var,0);
    u1 = zeros(nPnt,1);
    u2 = zeros(nPnt,1);

    clustOrig = clust;
    lessT = @(x,Tres) x > Tres ;
    colors = ['b' 'k' 'r' 'm' 'c' 'y' 'g'];
    shapes = [ '.'  'o' 'x' '+' '*' 's' 'd'];
    %%%%% numC = size(clust,2); % 2 of clusters so far
       
    if ( numC > 1 )      
        nFeat = size(clust(1).xy,1);
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
                    %%%% ==== clear u1 u2;
                    xy1Temp = xy1; % Use this to delete the closest points found fo far
                    for k=1:nPnt % # of closest points from clust1    
                        len1 = size(xy1Temp,2);
                        if ( len1 > k ) 
                           [u1(k),u2(k)]=CPP_Skeleton_ClosestPoints(xy1Temp,xy2);
                           xtemp1 = xy1;
                           xtemp1(:,u1(1:k)) = []; % Delete from clust1
                           xtemp2 = [ xy2 xy1(:,u1(1:k))]; % add to clust2
                           [cefMAXNew1,cefSUMNew1,outMAXPointList1,outMAXDistNew1, maxListNew1, maxValueNew1] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( xtemp1, 0, 0, 0, 0, 0, 0, var, 0, statInfo, 0 );
                           [cefMAXNew2,cefSUMNew2,outMAXPointList2,outMAXDistNew2, maxListNew2, maxValueNew2] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( xtemp2, 0, 0, 0, 0, 0, 0, var, 0, statInfo, 0 );
                           %%%[DCirCefn,~,maxDistn,IntCefn] = EXECUTE_CPP_SKELETON_V1 ( xtemp1, var, 0,statInfo );
                           %%%[DCirCefm,~,maxDistm,IntCefm] = EXECUTE_CPP_SKELETON_V1 ( xtemp2, var, 0,statInfo );
                           % If the clusters are tigther
                           % cond = lessT(DCirCefn,T) && lessT(DCirCefm,T);
                           if ( (cefMAXNew1 > clust(n).DCirCef && cefMAXNew2 >= clust(m).DCirCef) || ...
                                   (cefMAXNew1 >= clust(n).DCirCef && cefMAXNew2 > clust(m).DCirCef) ) 
                                clust(n).xy = xtemp1;
                                clust(m).xy = xtemp2;
      
                                clust(n).DCirCef = cefMAXNew1;  
                                clust(n).maxDist = outMAXDistNew1;
                                clust(n).IntCef = cefSUMNew1;
                                clust(n).outMAXPointList = outMAXPointList1;
                                clust(n).maxListNew = maxListNew1;
                                clust(n).maxValueNew = maxValueNew1;
                                
                                clust(m).DCirCef = cefMAXNew2;  
                                clust(m).maxDist = outMAXDistNew2;
                                clust(m).IntCef = cefSUMNew2;
                                clust(m).outMAXPointList = outMAXPointList2;
                                clust(m).maxListNew = maxListNew2;
                                clust(m).maxValueNew = maxValueNew2;
                                
                                
                                
% %                                 clust(n).DCirCef = DCirCefn;
% %                                 clust(m).DCirCef = DCirCefm;
% %                                 clust(n).maxDist = maxDistn;
% %                                 clust(m).maxDist = maxDistm;
% %                                 clust(n).IntCef = IntCefn;
% %                                 clust(m).IntCef = IntCefm;
                                 
                                modified = true;
                                %%%% fprintf('LOOP1 n= %d m= %d k=%d\n',n,m,k);
                           
                           end
                           xy1Temp(:,u1(k)) = Inf(nFeat,1); % Delete the closest point, so that next closest point can be found
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
                    %%%% ==== clear u1 u2;
                    xy2Temp = xy2; % Use this to delete the closest points found fo far
                   
                    for k=1:nPnt % # of closest points from clust1  
                        len2 = size(xy2Temp,2);
                        if ( len2 > k ) 
                           [u1(k),u2(k)]=CPP_Skeleton_ClosestPoints(xy1,xy2Temp);
                           xtemp2 = xy2;
                           xtemp2(:,u2(1:k)) = []; % Delete from clust1
                           xtemp1 = [ xy1 xy2(:,u2(1:k))]; % add to clust2
                           [cefMAXNew1,cefSUMNew1,outMAXPointList1,outMAXDistNew1, maxListNew1, maxValueNew1] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( xtemp1, 0, 0, 0, 0, 0, 0, var, 0, statInfo, 0 );
                           [cefMAXNew2,cefSUMNew2,outMAXPointList2,outMAXDistNew2, maxListNew2, maxValueNew2] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( xtemp2, 0, 0, 0, 0, 0, 0, var, 0, statInfo, 0 );
                           %%%[DCirCefn,~,maxDistn,IntCefn] = EXECUTE_CPP_SKELETON_V1 ( xtemp1, var, 0,statInfo );
                           %%%[DCirCefm,~,maxDistm,IntCefm] = EXECUTE_CPP_SKELETON_V1 ( xtemp2, var, 0,statInfo );
                           % If the clusters are tigther
                           % cond = lessT(DCirCefn,T) && lessT(DCirCefm,T);
                           if ( (cefMAXNew1 > clust(n).DCirCef && cefMAXNew2 >= clust(m).DCirCef) || ...
                                   (cefMAXNew1 >= clust(n).DCirCef && cefMAXNew2 > clust(m).DCirCef) ) 
                                clust(n).xy = xtemp1;
                                clust(m).xy = xtemp2;
                                
                                clust(n).DCirCef = cefMAXNew1;  
                                clust(n).maxDist = outMAXDistNew1;
                                clust(n).IntCef = cefSUMNew1;
                                clust(n).outMAXPointList = outMAXPointList1;
                                clust(n).maxListNew = maxListNew1;
                                clust(n).maxValueNew = maxValueNew1;
                                
                                clust(m).DCirCef = cefMAXNew2;  
                                clust(m).maxDist = outMAXDistNew2;
                                clust(m).IntCef = cefSUMNew2;
                                clust(m).outMAXPointList = outMAXPointList2;
                                clust(m).maxListNew = maxListNew2;
                                clust(m).maxValueNew = maxValueNew2;
                                
% % %                                 clust(n).DCirCef = DCirCefn;
% % %                                 clust(m).DCirCef = DCirCefm;
% % %                                 clust(n).maxDist = maxDistn;
% % %                                 clust(m).maxDist = maxDistm;
% % %                                 clust(n).IntCef = IntCefn;
% % %                                 clust(m).IntCef = IntCefm;
% % %                                  
                                modified = true;
                                %%%% fprintf('LOOP2 n= %d m= %d k=%d\n',n,m,k);                           
                           end
                           xy2Temp(:,u2(k)) = Inf(nFeat,1); % Delete the closest point, so that next closest point can be found
                           if ( modified ) 
                               break
                           end
                        else
                            break
                        end
                    end
                end                        
                % Move only 1-2-3-...? points from one cluster to another                
                
            end
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

