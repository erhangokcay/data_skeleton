function [clust]=STREAM_SKELETON_RECLUSTER_VER3(clust,var,T)    

    statInfo = CEF_CALCULATE_STATINFO(size(clust(1).xy),var,0);

    % disp('STREAM_SKELETON_RECLUSTER VER3 ')
    lessT = @(x,Tres) x > Tres ;

    while (true)
        break_while = true;
        numC = size(clust,2); % 2 of clusters so far

        if ( numC == 1 )      
            return
        end
        
        break_loop = false;
        for n=1:numC                       
            for m=n+1:numC
                %disp(n)
                %disp(m)   
                % [Dcef,Dmean,Dvar] = STREAM_STAT_WITHIN ([clust(n).xy,clust(m).xy], var, 0 );                      
                DCirCef = EXECUTE_CPP_SKELETON_V1 ( [clust(n).xy,clust(m).xy], var, 0, statInfo );
                %%%%% fprintf('RECL: n=%d m=%d V=%e\n',n,m,DCirCef);
                % cef = (cef_local(clust(n).xy,clust(m).xy,var,1));
                % res = STREAM_LESS(Dcef, T);
                res = lessT(DCirCef, T);
                if ( res )                     
                     clust(n).xy = [clust(n).xy, clust(m).xy];
                     [DCirCef,~,maxDist,IntCef] = EXECUTE_CPP_SKELETON_V1 ( clust(n).xy, var, 0, statInfo );
                     clust(n).DCirCef = DCirCef;
                     clust(n).maxDist = maxDist;
                     clust(n).IntCef = IntCef;
                     clust(m) = [];
                     break_loop = true;
                     break_while = false;
                end 
                 if ( break_loop ) % Exit from while loop
                    break
                 end
            end
            if ( break_loop ) % Exit from while loop
                 break
            end            
        end

       if ( break_while ) % Exit from while loop
           return
       end
    end
   
    % disp('STREAM_RECLUSTER END')

end