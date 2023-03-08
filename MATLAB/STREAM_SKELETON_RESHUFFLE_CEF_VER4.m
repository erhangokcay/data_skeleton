function [clust] = STREAM_SKELETON_RESHUFFLE_CEF_VER4(clust, var, T)

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
                    p1=plot(xy1(1,:),xy1(2,:),'ro');
                    p2=plot(xy2(1,:),xy2(2,:),'ro');
                    
                    if ( len1 > 1 && len2 > 1 ) 
                        for k=1:len1
                           xtemp1 = xy1(:,[1:k-1,k+1:end]);
                           xtemp2 = [ xy2 xy1(:,k)];
                            [DCirCefn,~,maxDistn,IntCefn] = EXECUTE_CPP_CEF ( xtemp1, var, 0 );
                            [DCirCefm,~,maxDistm,IntCefm] = EXECUTE_CPP_CEF ( xtemp2, var, 0 );
                           % If the clusters are tigther
                           % cond = lessT(DCirCefn,T) && lessT(DCirCefm,T);
                           if ( (DCirCefn > clust(n).DCirCef && DCirCefm >= clust(m).DCirCef) || ...
                                   (DCirCefn >= clust(n).DCirCef && DCirCefm > clust(m).DCirCef) ) 
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
                           if ( modified ) 
                               break
                           end
                        end

                        if ( ~modified ) 
                            for k=1:len2
                               xtemp2 = xy2(:,[1:k-1,k+1:end]);
                               xtemp1 = [ xy1 xy2(:,k)];
                               [DCirCefn,~,maxDistn,IntCefn] = EXECUTE_CPP_CEF ( xtemp1, var, 0 );
                                [DCirCefm,~,maxDistm,IntCefm] = EXECUTE_CPP_CEF ( xtemp2, var, 0 );
                               % If the clusters are tigther
                                %cond = lessT(DCirCefn,T) && lessT(DCirCefm,T);
                            if ( (DCirCefn > clust(n).DCirCef && DCirCefm >= clust(m).DCirCef) || ...
                                   (DCirCefn >= clust(n).DCirCef && DCirCefm > clust(m).DCirCef) ) 
                                    clust(n).xy = xtemp1;
                                    clust(m).xy = xtemp2;
                                    clust(n).DCirCef = DCirCefn;
                                    clust(m).DCirCef = DCirCefm;
                                    clust(n).maxDist = maxDistn;
                                    clust(m).maxDist = maxDistm;
                                    clust(n).IntCef = IntCefn;
                                    clust(m).IntCef = IntCefm;
                                    
                                     modified = true;   
                                    %%%% fprintf('LOOP2 n= %d m= %d \n',n,m);
                               end
                               if ( modified ) 
                                   break
                               end
                            end
                        end
                        
% % %                         numC = size(clust,2);
% % %                         clf;hold on
% % %                         for n=1:numC
% % %                             plot(clust(n).xy(1,:),clust(n).xy(2,:),strcat(colors(mod(n-1,7)+1),shapes(ceil(n/7))),'MarkerSize',10);
% % %                         end
% % %                         pause
                        
                    end
                
                end % while
                % Move only 1-2-3-...? points from one cluster to another                
                
            end
        end
    end
end

