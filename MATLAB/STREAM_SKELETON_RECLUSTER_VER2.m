function [clust]=STREAM_SKELETON_RECLUSTER_VER2(clust,var,T)    
    disp('STREAM_SKELETON_RECLUSTER ')
    lessT = @(x,Tres) x > Tres ;

    while (true)
    
        numC = size(clust,2); % 2 of clusters so far

        if ( numC == 1 )      
            return
        end
        clear combine
        for p=1:numC
            combine(p).res = false;
        end
        for n=1:numC
            vn = 0;
            

            for m=n+1:numC
                %disp(n)
                %disp(m)   
                % [Dcef,Dmean,Dvar] = STREAM_STAT_WITHIN ([clust(n).xy,clust(m).xy], var, 0 );                      
                DCirCef = EXECUTE_CPP_CEF ( [clust(n).xy,clust(m).xy], var, 0 )


                % cef = (cef_local(clust(n).xy,clust(m).xy,var,1));
                % res = STREAM_LESS(Dcef, T);
                res = lessT(DCirCef, T);
                if ( res ) 
                    disp('true-----------------------')
                     combine(n).res = true;
                     combine(m).res = true;
                end                        
            end
        end

        %if ( length(combine) == 0 ) 
        %    return
        %end

        %     Tm        
        %     [combine(:).res]
        %        [combine(:).val]
        
        mlist = find([combine(:).res]);
        fprintf('MLIST=%d\n',length(mlist));
        size(clust,2);
        if ( length(mlist)>1 )

            curr = mlist(1);
            for k=2:length(mlist)
                %k
                clust(curr).xy = [clust(curr).xy, clust(mlist(k)).xy];                                    
            end

            clust(mlist(2:end))= []; % delete

            % [Dcef,Dmean,Dvar] = STREAM_STAT_WITHIN (clust(curr).xy, var, 0 );          
            DCirCef = EXECUTE_CPP_CEF ( clust(curr).xy, var, 0 );

            %clust(curr).Tcef = Dcef;
            %clust(curr).Tmean = Dmean;
            %clust(curr).Tvar = Dvar;
            clust(curr).DCirCef = DCirCef;

            %[Dm, Dv]= STREAM_DATA_STAT1(clust(curr).xy,var); % this should be incremental
            %clust(curr).Tmean = Dm;
            %clust(curr).Tvar = Dv;                        

        else
            return
        end

        
    end
   
    % disp('STREAM_RECLUSTER END')

end