function [clustOut,outK]=STREAM_SKELETON_RECLUSTER_VER3_OPTIMIZED_MEM_DEBUG1_1(clust,clustOut,numC,var,T)

statInfo = CEF_CALCULATE_STATINFO(size(clust(1).xy),var,0);

% disp('STREAM_SKELETON_RECLUSTER VER3 ')
lessT = @(x,Tres) x > Tres ;
modC = 0;
cngC = 0;
calC = 0;
while (true)
    break_while = true;
    %%% numC = size(clust,2); % 2 of clusters so far
    
    if ( numC == 1 )
        clustOut = clust;
        outK = 1;
        return
    end
    
    break_loop = false;
    outK = 1;
    %tic;
    
    for n=1:numC
        for m=n+1:numC
			%%%disp(n)	
			if ( ~(clust(n).modified) && ~(clust(m).modified))
                if ( numC == 4) 
                    disp('not modified');
                end
                modC = modC+1;
				continue
			end
            %disp(n)
            %disp(m)
            if ( numC == 4) 
                    fprintf("SIZE=%d %d %d %d\n",size(clust(n).xy,1),size(clust(n).xy,2),size(clust(m).xy,1),size(clust(m).xy,2));                
            end
            % [Dcef,Dmean,Dvar] = STREAM_STAT_WITHIN ([clust(n).xy,clust(m).xy], var, 0 );
            if ( ~isempty(clust(n).xy) && ~isempty(clust(m).xy))
                
                calC = calC + 1;
                xymerged = [clust(n).xy,clust(m).xy];
                if ( size(clust(n).xy,2) == 1 &&  size(clust(m).xy,2) == 1)                    
                    [cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( xymerged, 0, 0, 0, 0, 0, 0, var, 0, statInfo, 0 );
                    temp.DCirCef = cefMAXNew;
                    temp.maxDist = outMAXDistNew;
                    temp.IntCef = cefSUMNew;
                    temp.outMAXPointList = outMAXPointList;
                    temp.maxListNew = maxListNew;
                    temp.maxValueNew = maxValueNew;

                elseif ( size(clust(n).xy,2) >=  size(clust(m).xy,2) )        % size > 1

                    temp.xy = clust(n).xy;
                    temp.DCirCef = clust(n).DCirCef;
                    temp.maxDist = clust(n).maxDist;
                    temp.IntCef = clust(n).IntCef;
                    temp.outMAXPointList = clust(n).outMAXPointList;
                    temp.maxListNew = clust(n).maxListNew;
                    temp.maxValueNew = clust(n).maxValueNew;
                    for h=1:size(clust(m).xy,2)
                        if ( size(temp.maxListNew,2) == 0 )
                            disp('4-2 MAXLIST ERROR')
                            pause
                        else
                            xyp = clust(m).xy(:,h);
                            [cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( temp.xy, temp.IntCef, temp.DCirCef, temp.maxValueNew, temp.maxListNew, xyp, 0, var, 0, statInfo, 2 );
                        end
                        temp.xy = [temp.xy xyp];
                        temp.DCirCef = cefMAXNew;
                        temp.maxDist = outMAXDistNew;
                        temp.IntCef = cefSUMNew;
                        temp.outMAXPointList = outMAXPointList;
                        temp.maxListNew = maxListNew;
                        temp.maxValueNew = maxValueNew;                        
                    end
                elseif ( size(clust(n).xy,2) <=  size(clust(m).xy,2) )        % size > 1

                    temp.xy = clust(m).xy;
                    temp.DCirCef = clust(m).DCirCef;
                    temp.maxDist = clust(m).maxDist;
                    temp.IntCef = clust(m).IntCef;
                    temp.outMAXPointList = clust(m).outMAXPointList;
                    temp.maxListNew = clust(m).maxListNew;
                    temp.maxValueNew = clust(m).maxValueNew;
                    for h=1:size(clust(n).xy,2)
                        if ( size(temp.maxListNew,2) == 0 )
                            disp('4-2 MAXLIST ERROR')
                            pause
                        else
                            xyp = clust(n).xy(:,h);
                            [cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( temp.xy, temp.IntCef, temp.DCirCef, temp.maxValueNew, temp.maxListNew, xyp, 0, var, 0, statInfo, 2 );
                        end
                        temp.xy = [temp.xy xyp];
                        temp.DCirCef = cefMAXNew;
                        temp.maxDist = outMAXDistNew;
                        temp.IntCef = cefSUMNew;
                        temp.outMAXPointList = outMAXPointList;
                        temp.maxListNew = maxListNew;
                        temp.maxValueNew = maxValueNew;                        
                    end
				else
				   disp('INVALID SIZES........');
                end
                %%%%%%%%%% [DCirCef,~,~,~] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED ( [xyp,clust(m).xy], var, 0, statInfo );
                %%% [cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( [clust(n).xy,clust(m).xy], 0, 0, 0, 0, 0, 0, var, 0, statInfo, 0 );
                
                % DCirCef = EXECUTE_CPP_SKELETON_V1 ( [clust(n).xy,clust(m).xy], var, 0, statInfo );
                %%%%% fprintf('RECL: n=%d m=%d V=%e\n',n,m,DCirCef);
                % cef = (cef_local(clust(n).xy,clust(m).xy,var,1));
                % res = STREAM_LESS(Dcef, T);
                res = lessT(cefMAXNew, T);
                
                %%fprintf("cefMAXNew= %e\n",cefMAXNew);
                if ( res )
                    
                    cngC = cngC + 1;
                    clust(n).xy = xymerged;
                    
                    clust(n).DCirCef = temp.DCirCef;
                    clust(n).maxDist = temp.maxDist;
                    clust(n).IntCef = temp.IntCef;
                    clust(n).outMAXPointList = temp.outMAXPointList;
                    clust(n).maxListNew = temp.maxListNew;
                    clust(n).maxValueNew = temp.maxValueNew;
					
                    clust(n).modified=true;
                    %%[DCirCef,~,maxDist,IntCef] = EXECUTE_CPP_SKELETON_V1 ( clust(n).xy, var, 0, statInfo );
                    %%clust(n).DCirCef = DCirCef;
                    %%clust(n).maxDist = maxDist;
                    %%clust(n).IntCef = IntCef;
                    clust(m).xy = [];
                    break_loop = true;
                    break_while = false;
                end
            end
        end
        if ( break_loop ) % Exit from for loop
            break
        end
        
        if ( break_loop ) % Exit from for loop
            break
        end
    end
    %%% fprintf('RES V1=%f \n',toc);
    
    if ( break_while ) % Exit from while loop
        break
    end
end
outK = 0;

fprintf('total iteration=%d %d %d %d\n',numC*(numC-1)/2,modC,cngC, calC);

for n=1:numC
    if ( ~isempty(clust(n).xy) )
        outK = outK + 1;
        clustOut(outK).xy = clust(n).xy;
        clustOut(outK).DCirCef =  clust(n).DCirCef;
        clustOut(outK).maxDist =  clust(n).maxDist;
        clustOut(outK).IntCef =  clust(n).IntCef;
        clustOut(outK).outMAXPointList =  clust(n).outMAXPointList;
        clustOut(outK).maxListNew =  clust(n).maxListNew;
        clustOut(outK).maxValueNew =  clust(n).maxValueNew;
		
		clustOut(outK).modified=false;
        
    end
end
% disp('STREAM_RECLUSTER END')

end