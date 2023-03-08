function [clust,numOfClust]=STREAM_SKELETON_VER4_nPNT_OPTIMIZED_V2_MEM_DEBUG1_COND(xy,var,T1,T2,randlist)


    global DEBUG_DISP
%     DBGDISP = 1;
%     if ( exist('DEBUG_DISP','var'))
%         disp('DEBUG')
%         DBGDISP = 1;
%     end
    statInfo = CEF_CALCULATE_STATINFO(size(xy),var,0);

    colors = ['b' 'k' 'r' 'm' 'c' 'y' 'g'];
    shapes = [ '.'  'o' 'x' '+' '*' 's' 'd'];
    %----------------------inline function------------------
    % Tm-Tv <= x <= Tm+Tv
    % within = @(x,Tm,Tv) x >= abs(Tm - Tv)/2 && x <= abs(Tm + Tv)/2;
    lessT = @(x,Tresh) x > Tresh ;
    %------------------------------------------------------
 
    %clf
    %axis([-1 1 -1 1])
    %plot(xy(1,:),xy(2,:),'.');
    %hold on
    
    len = size(xy,2); % # of data points
	if ( length(randlist) == 0 ) 
		rand_len = randperm(len); 
	else
		rand_len = randlist;
	end

   % Create len unique random numbers   
    %rand_len = [ 5     2     6     4     8     7     1     3]; % OK
    %rand_len=[8     2     4     5     3     6     1     7];
    %rand_len = [3 1 4 19 6 20 10  17  16  12  5 14 11  2  9 15 8 7 18 13];
    %rand_len = [1  16  9  5 13 18  6  12  19  14  7  15  2  20  17  11  4  10  3  8];
    %rand_len = [42    38    50    30    13    65     9    78    54    15    51    63    57    75    32    77    25    59    31    14    61    16    64    27    47     8    55    35    40     3    12    44    69    17    80    19    81    45    43    49    53    21    18     1     7    68    66    39    79    56    10    73    23    70    71     2     82    33    28    37    26    72    67    29    76     5    52    58    62    46     11    36    48     4    34    20    41    60    22    74    24     6];
    
    
    
    %%%%rand_len = [10 22 2 14 8 21 9 19 30 4 28 6 7 27 18 3 5 17 26 12 24 25 1 20 23 16 31 29 15 11 13 ] 

    %--- xy4 rand_len = [22 27 31 13 28 20 12 25 21 3 2 10 16 17 23 1 24 8 6 9 19 11 15 18 26 14 5 7 4 29 30 ];

    % xy5 (1 point wrong)
    % rand_len = [3 16 17 2 8 20 10 18 6 4 11 15 7 1 12 9 21 19 13 14 5 ];
    
     % xy5 (2 point wrong, single point)
    % rand_len = [12 8 6 4 18 9 16 17 2 15 19 20 3 10 1 7 5 14 11 21 13 ];
    
    % xy5 (1 point wrong)
    %rand_len = [9 7 10 12 16 2 6 1 5 18 11 20 17 8 4 15 21 14 13 19 3 ];
    
    %17 11 18 3 6 2 19 8 14 16 7 20 1 10 4 21 9 12 15 5 13 
    %21 12 4 5 6 11 9 2 10 8 3 14 17 7 16 1 18 13 19 15 20 
    
    % xy5 (1 point wrong) 10e-50 10e-70 SOLVED  
    % 10e-30 10e-50 single point
    % rand_len = [16 7 14 5 8 4 10 13 2 17 18 15 19 12 6 11 1 20 9 21 3 ];

    % xy5 
    % 10e-30 10e-50 cyclic changes
    %rand_len = [4 19 1 12 3 8 16 21 9 15 17 10 18 5 20 14 7 13 6 11 2 ];

    
    %%%% fprintf('%d ',rand_len)
    %%%% fprintf('\n');
    
    % Allocate memory 
    clust(len).xy = [];
    clust(len).grp = 1; % first group
    %clust(len).Tmean = 0; % initial values are zero
    %clust(len).Tvar = 0;
    %clust(len).Tcef = 0;
    clust(len).DCirCef =  0;
    clust(len).maxDist = 0;
    clust(len).IntCef = 0;
	clust(len).outMAXPointList = [];
  	clust(len).maxListNew = [];
  	clust(len).maxValueNew = 0;
	clust(len).modified=false;
    
    clustEmpty = clust;
    
    
    xyp = xy(:,rand_len(1));
%    plot(xyp(1),xyp(2),'mo');

    clust(1).xy = xyp;
    clust(1).grp = 1; % first group
    %clust(1).Tmean = 0; % initial values are zero
    %clust(1).Tvar = 0;
    %clust(1).Tcef = 0;
    clust(1).DCirCef =  0;
    clust(1).maxDist = 0;
    clust(1).IntCef = 0;
	clust(1).outMAXPointList = [];
  	clust(1).maxListNew = [];
  	clust(1).maxValueNew = 0;
   	clust(1).modified=true;
   
    xyp = xy(:,rand_len(2));
%    plot(xyp(1),xyp(2),'mo');

    clust(2).xy = xyp;
    clust(2).grp = 2; % second group
    %clust(2).Tmean = 0; % initial values are zero
    %clust(2).Tvar = 0;
    %clust(2).Tcef = 0;
    clust(2).DCirCef =  0;
    clust(2).maxDist = 0;
    clust(2).IntCef = 0;
	clust(2).outMAXPointList = [];
  	clust(2).maxListNew = [];
  	clust(2).maxValueNew = 0;
	clust(2).modified=true;

%     globalTmean = (cef_local(clust(1).xy , clust(2).xy , var,1))
%     globalTvar = 0.0;
   
    numC = 2; % 2 of clusters so far
    numOfClust(1)=2;
   
    %%%%% [cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED ( inpData, cefSUMOld, cefMAXOld, maxValuePrev, maxListPrev, xpnew, xpnewIndex, std, mean, statInfo, flag )

   
    % Third RANDOM point from the stream
    xyp = xy(:,rand_len(3));
%    plot(xyp(1),xyp(2),'ro');
    % Find closest cluster if any which is less than T
    
    % Allocatre memory
    combine(len).res = 0;
    combine(len).DCirCef = 0;  
    combine(len).maxDist = 0;
    combine(len).IntCef = 0;
    combine(len).outMAXPointList = [];
    combine(len).maxListNew = [];
    combine(len).maxValueNew = 0;
    
    for n=1:numC
        % [Dcef,Dmean,Dvar] = STREAM_STAT_WITHIN ([xyp,clust(n).xy], var, 0 );
       
		[cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( [clust(n).xy,xyp], 0, 0, 0, 0, 0, 0, var, 0, statInfo, 0 );

        %%%%%%% [DCirCef,~,~,~] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED ( [xyp,clust(n).xy], var, 0, statInfo );
        
        % cef = (cef_local(xyp,clust(n).xy,var,1));
        %%%%%%% combine(n).res = lessT ((DCirCef), T1); % We can improve this test with Dmean,Dvar
        combine(n).res = lessT ((cefMAXNew), T1); % We can improve this test with Dmean,Dvar
        %combine(n).valDcef = Dcef;
        %combine(n).valDmean = Dmean;
        %combine(n).valDvar = Dvar;
        
        combine(n).DCirCef = cefMAXNew;  
        combine(n).maxDist = outMAXDistNew;
        combine(n).IntCef = cefSUMNew;
        combine(n).outMAXPointList = outMAXPointList;
        combine(n).maxListNew = maxListNew;
        combine(n).maxValueNew = maxValueNew;

        %combine(n).maxDist = 0;

        % DO I need this????
%         if (cef > max) 
%             max = cef;
%             cnum = n;
%         end        
    end
    %[combine(:).res]
    %[combine(:).val]
    %disp('--------------')
    list = find([combine(1:numC).res]);
    
    if ( isempty(list) )
        %max <= abs(globalTmean/2 - globalTvar) && max >= abs(globalTmean/2 + globalTvar)  ) % Create another cluster
        clust(3).xy = xyp;        
        clust(3).grp = 3; % third group
        %clust(3).Tcef = 0; % initial values are zero??
        %clust(3).Tmean = 0; % initial values are zero
        %clust(3).Tvar = 0;   
        clust(3).DCirCef =  0;
        clust(3).maxDist = 0;
        clust(3).IntCef = 0;
		clust(3).outMAXPointList = [];
		clust(3).maxListNew = [];
		clust(3).maxValueNew = 0;
  		clust(3).modified=true;

        numC = 3;

    else
        if ( length(list) == 1 ) % Join point to the group
            cn = list(1);
            clust(cn).xy(:,2) = xyp; %add the point to the list        
                       
            %[Dcef,Dmean,Dvar] = STREAM_STAT_WITHIN (clust(n).xy, var, 0 );
           
			%%%%% [cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( [clust(cn).xy], 0, 0, 0, 0, 0, 0, var, 0, statInfo, 0 );
            %%%%%%%%%% [DCirCef,~,maxDist,IntCef] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED ( clust(cn).xy, var, 0, statInfo );

            %[Dm, Dv]= STREAM_DATA_STAT(clust(cn).xy,var); % this should be incremental
            %clust(cn).Tcef = Dcef;
            %clust(cn).Tmean = Dmean;
            %clust(cn).Tvar = Dvar;
            clust(cn).DCirCef = combine(cn).DCirCef;  
            clust(cn).maxDist =  combine(cn).maxDist;
            clust(cn).IntCef = combine(cn).IntCef;
			clust(cn).outMAXPointList = combine(cn).outMAXPointList;
			clust(cn).maxListNew = combine(cn).maxListNew;
			clust(cn).maxValueNew = combine(cn).maxValueNew ;
 
        else % join the point to the group with largest (compact) internal CEF (join to a single group)
            
            maxV = combine(list(1)).DCirCef ;
            maxInd = list(1);
            % curr = list(1);
            for k=2:length(list)
               if ( combine(list(k)).DCirCef > maxV ) 
                    maxV = combine(list(k)).DCirCef ;
                    maxInd = list(k);
               end
            end
                          
            % clust(list(2:end))= []; % delete cluster                            
            clust(maxInd).xy = [clust(maxInd).xy, xyp]; % finally add the point
            
            %[Dcef,Dmean,Dvar] = STREAM_STAT_WITHIN (clust(curr).xy, var, 0 );  
 
            
			%%% [cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( [clust(maxInd).xy], 0, 0, 0, 0, 0, 0, var, 0, statInfo, 0 );
 
			%%%%%%%%%%  [DCirCef,~,maxDist,IntCef] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED ( clust(maxInd).xy, var, 0, statInfo );

            %clust(curr).Tcef = Dcef;
            %clust(curr).Tmean = Dmean;
            %clust(curr).Tvar = Dvar;
            
            clust(maxInd).DCirCef = combine(maxInd).DCirCef;  
            clust(maxInd).maxDist =  combine(maxInd).maxDist;
            clust(maxInd).IntCef = combine(maxInd).IntCef;
			clust(maxInd).outMAXPointList = combine(maxInd).outMAXPointList;
			clust(maxInd).maxListNew = combine(maxInd).maxListNew;
			clust(maxInd).maxValueNew = combine(maxInd).maxValueNew ;
            clust(maxInd).modified=true;
 
            
            %[Dm, Dv]= STREAM_DATA_STAT(clust(curr).xy,var); % this should be incremental
            %clust(curr).Tmean = Dm;
            %clust(curr).Tvar = Dv;
        end
    end
    
    %disp('P=1');STREAM_SKELETON_PLOT(clust)
    %pause

    % globalTmean, globalTvar are not useful at this point. Use T2 to recluster.
    %[globalTmean, globalTvar]= STREAM_CLUSTER_STAT(clust,var) % this should be incremental
        
    %%%%----%%%%%[clust,numC]=STREAM_SKELETON_RECLUSTER_VER3_OPTIMIZED_MEM_DEBUG1_1(clust,clustEmpty,numC,var,T2) ;
    [clust,numC]=CPP_Recluster_fast(clust(1:numC),numC,var,T2,statInfo) ;
    
    
    %[globalTmean, globalTvar]= STREAM_CLUSTER_STAT(clust,var); % this should be incremental
        
    %disp('P=2');STREAM_SKELETON_PLOT(clust)
    %pause

    numOfClust(2)=numC;    
% % %     disp('F1')
% % %     for k=1:size(clust,2)
% % %         disp(clust(k).DCirCef)
% % %     end

    
    % Now calculate for the rest of the points as a stream    
    
    ttoc = 0;
    for n=4:len
        %if (DEBUG_DISP==1 && mod(n,100)==0 ) 
            fprintf('n=%d numC=%d ==============================\n',n,numC); 
        %end
        xyp = xy(:,rand_len(n)); % get the point from the stream
        % pf=plot(xyp(1),xyp(2),'o');
%        plot(xyp(1),xyp(2),'ro');
        %%% numC = size(clust,2); % get number of generated clusters
         
         % Find closest cluster if any which is less than T
      
        for m=1:numC
            %[Dcef,Dmean,Dvar] = STREAM_STAT_WITHIN ([xyp,clust(m).xy], var, 0 );     

            if ( size(clust(m).xy,2) == 1 )
                 
				 [cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( [clust(m).xy,xyp], 0, 0, 0, 0, 0, 0, var, 0, statInfo, 0 );
                
            else % size > 1
              
                   if ( size(clust(m).maxListNew,2) == 0 ) 
                        disp('4-2 MAXLIST ERROR')
                        pause
                   else
                         
                         [cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1_FAST ( clust(m).xy, clust(m).IntCef, clust(m).DCirCef, clust(m).maxValueNew, clust(m).maxListNew, xyp, 0, var, 0, statInfo, 2 );
                   end
            end	
			%%%%%%%%%% [DCirCef,~,~,~] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED ( [xyp,clust(m).xy], var, 0, statInfo );

            combine(m).res = lessT (cefMAXNew, T1); % We can improve this test with Dmean,Dvar
            %combine(m).valDcef = Dcef;
            %combine(m).valDmean = Dmean;
            %combine(m).valDvar = Dvar;
            combine(m).DCirCef = cefMAXNew;  
            combine(m).maxDist = outMAXDistNew;
            combine(m).IntCef = cefSUMNew;
            combine(m).outMAXPointList = outMAXPointList;
            combine(m).maxListNew = maxListNew;
            combine(m).maxValueNew = maxValueNew;
            %combine(m).maxDist = maxDist;
        
            % cef = (cef_local(xyp,clust(m).xy,var,1));
            % combine(m).res = lessT ((cef), globalTmean, globalTvar);
            % combine(m).val = cef;             
        end
        %[combine(:).res];
        %[combine(:).val];
        %disp('--------------')
        %disp(n)
        list = find([combine(1:numC).res]);

        if ( isempty(list) )
            %max <= abs(globalTmean/2 - globalTvar) && max >= abs(globalTmean/2 + globalTvar)  ) % Create another cluster
            clust(numC+1).xy = xyp;
            clust(numC+1).grp = 3; % third group
            %clust(numC+1).Tmean = 0; % initial values are zero
            %clust(numC+1).Tvar = 0;   
            %clust(numC+1).Tcef = 0;   
            clust(numC+1).DCirCef = 0;
            clust(numC+1).maxDist = 0;
            clust(numC+1).IntCef = 0;
			clust(numC+1).outMAXPointList = [];
			clust(numC+1).maxListNew = [];
			clust(numC+1).maxValueNew = 0;
            clust(numC+1).modified=true;

            numC = numC + 1;
        else
            if ( length(list) == 1 ) % Join point to the group
                cn = list(1);
                %%%%%%%%%%%%%  clust(cn).xy =  [clust(cn).xy, xyp]; %add the point to the list        

% % % % 				if ( size(clust(cn).xy,2) == 1 )
% % % %                     
% % % % 					 [cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( [clust(cn).xy,xyp], 0, 0, 0, 0, 0, 0, var, 0, statInfo, 0 );
% % % % 				else % size > 1
% % % %                     
% % % %                     if ( size(clust(cn).maxListNew,2) == 0 ) 
% % % %                         disp('5-2 MAXLIST ERROR')
% % % %                         pause
% % % %                     else
% % % %                          [cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( clust(cn).xy, clust(cn).IntCef, clust(cn).DCirCef, clust(cn).maxValueNew, clust(cn).maxListNew, xyp, 0, var, 0, statInfo, 2 );
% % % %                     end
% % % %                 end	
 				clust(cn).xy =  [clust(cn).xy, xyp];
				
                clust(cn).DCirCef = combine(cn).DCirCef;  
                clust(cn).maxDist =  combine(cn).maxDist;
                clust(cn).IntCef = combine(cn).IntCef;
                clust(cn).outMAXPointList = combine(cn).outMAXPointList;
                clust(cn).maxListNew = combine(cn).maxListNew;
                clust(cn).maxValueNew = combine(cn).maxValueNew ;
				clust(cn).modified=true;
				
                
% % %                 disp('F2')
% % %                 disp(clust(cn).DCirCef)
% % %              

                %[Dcef,Dmean,Dvar] = STREAM_STAT_WITHIN (clust(cn).xy, var, 0 );  
				
                %%%%%%%%%%%%  [DCirCef,~,maxDist,IntCef] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED ( clust(cn).xy, var, 0, statInfo );

                %clust(cn).Tmean = Dmean;
                %clust(cn).Tvar = Dvar;
                %clust(cn).Tcef = Dcef;
                %%%%%%%%%%%%% clust(cn).DCirCef = DCirCef;
                %%%%%%%%%%%%% clust(cn).maxDist = maxDist;
                %%%%%%%%%%%%% clust(cn).IntCef = IntCef;
            
                %[Dm, Dv]= STREAM_DATA_STAT(clust(cn).xy,var); % this should be incremental
                %clust(cn).Tmean = Dm;
                %clust(cn).Tvar = Dv;
                % TEST FOR DIVISON
%                 [ val,val2,lst,extra] = P6_find_GRP_NO(clust(cn).xy,var,1);
%                 
%                 [mval, mind] = max(val);
%                 if ( ~lessT(mval, clust(cn).Tmean, clust(cn).Tvar) )
%                     %Divide the current cluster into 2
%                     clust(cn).xy = lst(mind).xy1;
%                     [Dm, Dv]= STREAM_DATA_STAT(clust(cn).xy,var); % this should be incremental
%                     clust(cn).Tmean = Dm;
%                     clust(cn).Tvar = Dv;
% 
%                     clust(numC+1).xy = lst(mind).xy2;
%                     [Dm, Dv]= STREAM_DATA_STAT(clust(numC+1).xy,var); % this should be incremental
%                     clust(numC+1).Tmean = Dm;
%                     clust(numC+1).Tvar = Dv;
%                                         
%                 end
            else % join the point to the most compact group
                maxV = combine(list(1)).DCirCef ;
                maxInd = list(1);
                % curr = list(1);
                for k=2:length(list)
                   if ( combine(list(k)).DCirCef > maxV ) 
                        maxV = combine(list(k)).DCirCef ;
                        maxInd = list(k);
                   end
                end

                % clust(list(2:end))= []; % delete cluster                            
                 % finally add the point

                %[Dcef,Dmean,Dvar] = STREAM_STAT_WITHIN (clust(curr).xy, var, 0 );  
% % % % 				if ( size(clust(maxInd).xy,2) == 1 )
% % % %                     
% % % % 					 [cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( [clust(maxInd).xy,xyp], 0, 0, 0, 0, 0, 0, var, 0, statInfo, 0 );
% % % % 				else % size > 1
% % % %                    
% % % %                    if ( size(clust(maxInd).maxListNew,2) == 0 ) 
% % % %                         disp('6-2 MAXLIST ERROR')
% % % %                         pause
% % % %                    else                    
% % % %                         [cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( clust(maxInd).xy, clust(maxInd).IntCef, clust(maxInd).DCirCef, clust(maxInd).maxValueNew, clust(maxInd).maxListNew, xyp, 0, var, 0, statInfo, 2 );
% % % %                    end
% % % % 				end	

				clust(maxInd).xy = [clust(maxInd).xy, xyp];

                clust(maxInd).DCirCef = combine(maxInd).DCirCef;  
                clust(maxInd).maxDist =  combine(maxInd).maxDist;
                clust(maxInd).IntCef = combine(maxInd).IntCef;
                clust(maxInd).outMAXPointList = combine(maxInd).outMAXPointList;
                clust(maxInd).maxListNew = combine(maxInd).maxListNew;
                clust(maxInd).maxValueNew = combine(maxInd).maxValueNew ;
				clust(maxInd).modified=true;
				
% % % % 				clust(maxInd).DCirCef = cefMAXNew;
% % % % 				clust(maxInd).maxDist = outMAXDistNew;
% % % % 				clust(maxInd).IntCef = cefSUMNew;
% % % % 				clust(maxInd).outMAXPointList = outMAXPointList;
% % % % 				clust(maxInd).maxListNew = maxListNew;
% % % % 				clust(maxInd).maxValueNew = maxValueNew;

                %%%% disp('F3')               
                %%%% disp(clust(maxInd).DCirCef)
              

                %%%%%%%%%%%%%%  [DCirCef,~,maxDist,IntCef] = EXECUTE_CPP_SKELETON_V1 ( clust(maxInd).xy, var, 0, statInfo );

                %clust(curr).Tcef = Dcef;
                %clust(curr).Tmean = Dmean;
                %clust(curr).Tvar = Dvar;
                %%%%%%%%%%% clust(maxInd).DCirCef = DCirCef;
                %%%%%%%%%%% clust(maxInd).maxDist = maxDist;
                %%%%%%%%%%% clust(maxInd).IntCef = IntCef;
 
                
                % [Dm, Dv]= STREAM_DATA_STAT(clust(curr).xy,var); % this should be incremental
                % clust(curr).Tmean = Dm;
                % clust(curr).Tvar = Dv;
                % TEST FOR DIVISION
                % numC = size(clust,2); % numbers changed   

%                 [ val,val2,lst,extra] = P6_find_GRP_NO(clust(curr).xy,var,1);
%                 [mval, mind] = max(val);
%                 if ( ~lessT(mval, clust(curr).Tmean, clust(curr).Tvar) )
%                     %Divide the current cluster into 2
%                     clust(curr).xy = lst(mind).xy1;
%                     [Dm, Dv]= STREAM_DATA_STAT(clust(curr).xy,var); % this should be incremental
%                     clust(curr).Tmean = Dm;
%                     clust(curr).Tvar = Dv;
% 
%                     clust(numC+1).xy = lst(mind).xy2;
%                     [Dm, Dv]= STREAM_DATA_STAT(clust(numC+1).xy,var); % this should be incremental
%                     clust(numC+1).Tmean = Dm;
%                     clust(numC+1).Tvar = Dv;                    
%                     
%                 end                                
            end
        end
 
        %disp('P=3');STREAM_SKELETON_PLOT(clust)
        %pause
        
       %[globalTmean, globalTvar]= STREAM_CLUSTER_STAT(clust,var); % this should be incremental
       
       %if ( mod(n,5000)==0 ) 
       % [clust,numC]=STREAM_SKELETON_RECLUSTER_VER3_OPTIMIZED_MEM_DEBUG1_1(clust,clustEmpty, numC, var,T2);
       %end
       %%%%%% ---------------------- START ---------------------------------
       
       
       %%%%%%% -------------------------- END -------------------------------
       
       %fprintf('RES=%f \n',toc);
       %[globalTmean, globalTvar]= STREAM_CLUSTER_STAT(clust,var); % this should be incremental 
       
       %disp('P=4');STREAM_SKELETON_PLOT(clust)
       %pause
% % %         disp('F4')
% % %         for k=1:size(clust,2)
% % %             disp(clust(k).DCirCef)
% % %         end

        numOfClust(n-1)=numC;
        %disp(size(clust,2))
%         % INCREMENTAL VARIANCE AND MEAN !!!!!
%         
%         % Find closest cluster to the point
%         max = 0;
%         cnum = 0;
%         for n=1:numC
%             cef = cef_local(xycurr),clust(n).xy,var);
%             if (cef > max ) 
%                 max = cef;
%                 cnum = n;
%             end        
%         end
                    
        %clust = STREAM_SKELETON_RESHUFFLE_DIST_VER4_nPNT(clust,var, 2, 0);
        %clust = STREAM_SKELETON_RESHUFFLE_CEF_VER4_nPNT(clust,var, 2, 0);
        %clust = STREAM_SKELETON_RESHUFFLE_INTCEF_VER4_nPNT(clust,var, 2, 0);

        if ( n < 200 )              
            [clust, c] = STREAM_SKELETON_RESHUFFLE_SINGLE_VER4_nPNT_OPTIMIZED(clust, numC,var, 10e-25, T2);  
           %%%%%[clust,numC]=STREAM_SKELETON_RECLUSTER_VER3_OPTIMIZED_MEM_DEBUG1_1(clust,clustEmpty, numC, var,T2);
            [clust,numC]=CPP_Recluster_fast(clust(1:numC),numC,var,T2,statInfo) ;

            [clust, c] = STREAM_SKELETON_RESHUFFLE_DIST_VER5_nPNT_OPTIMIZED_FAST(clust,numC,var, 2, 0);
            [clust, c] = STREAM_SKELETON_RESHUFFLE_SINGLE_VER4_nPNT_OPTIMIZED(clust, numC,var, 10e-25, T2);
             %%%%%[clust,numC]=STREAM_SKELETON_RECLUSTER_VER3_OPTIMIZED_MEM_DEBUG1_1(clust,clustEmpty, numC, var,T2);
            [clust,numC]=CPP_Recluster_fast(clust(1:numC),numC,var,T2,statInfo) ;

            [clust, c] = STREAM_SKELETON_RESHUFFLE_CEF_VER5_nPNT_OPTIMIZED(clust,numC,var, 2, 0);
            [clust, c] = STREAM_SKELETON_RESHUFFLE_SINGLE_VER4_nPNT_OPTIMIZED(clust, numC,var, 10e-25, T2);
            %%%%%[clust,numC]=STREAM_SKELETON_RECLUSTER_VER3_OPTIMIZED_MEM_DEBUG1_1(clust,clustEmpty, numC, var,T2);
            [clust,numC]=CPP_Recluster_fast(clust(1:numC),numC,var,T2,statInfo) ;

            %%% ??? 
            [clust,c] = STREAM_SKELETON_RESHUFFLE_MINDIST_VER5_nPNT_OPTIMIZED(clust,numC,var, 2, 0);
            [clust, c] = STREAM_SKELETON_RESHUFFLE_SINGLE_VER4_nPNT_OPTIMIZED(clust, numC,var, 10e-25, T2);
            %%%%[clust,numC]=STREAM_SKELETON_RECLUSTER_VER3_OPTIMIZED_MEM_DEBUG1_1(clust,clustEmpty, numC, var,T2);
            [clust,numC]=CPP_Recluster_fast(clust(1:numC),numC,var,T2,statInfo) ;

            [clust, c] = STREAM_SKELETON_RESHUFFLE_CEF_VER5_nPNT_OPTIMIZED(clust,numC,var, 2, 0);
            [clust, c] = STREAM_SKELETON_RESHUFFLE_SINGLE_VER4_nPNT_OPTIMIZED(clust, numC,var, 10e-25, T2);
            %%%%%[clust,numC]=STREAM_SKELETON_RECLUSTER_VER3_OPTIMIZED_MEM_DEBUG1_1(clust,clustEmpty, numC, var,T2);
            [clust,numC]=CPP_Recluster_fast(clust(1:numC),numC,var,T2,statInfo) ;
   
        end
    % Try to maximize clusters by exchanging points between clusters
    % Do it only for closest clusters. NOT DONE YET
   
    end
    

    disp('==================================================')
   
   
   %clust = clust(1:numC); %% We can exclude memory saving from this point
   
   
   %%--%%[clust, c] = STREAM_SKELETON_RESHUFFLE_SINGLE_VER4_nPNT_OPTIMIZED(clust, numC,var, 10e-25, T2);  
   %%%%%[clust,numC]=STREAM_SKELETON_RECLUSTER_VER3_OPTIMIZED_MEM_DEBUG1_1(clust,clustEmpty, numC, var,T2);
   %%--%%[clust,numC]=CPP_Recluster_fast(clust,numC,var,T2,statInfo) ;

   %%--%%[clust, c] = STREAM_SKELETON_RESHUFFLE_DIST_VER5_nPNT_OPTIMIZED(clust,numC,var, 2, 0);
   %%--%%[clust, c] = STREAM_SKELETON_RESHUFFLE_SINGLE_VER4_nPNT_OPTIMIZED(clust, numC,var, 10e-25, T2);
   %%%%%[clust,numC]=STREAM_SKELETON_RECLUSTER_VER3_OPTIMIZED_MEM_DEBUG1_1(clust,clustEmpty, numC, var,T2);
   %%--%%[clust,numC]=CPP_Recluster_fast(clust,numC,var,T2,statInfo) ;

   %%--%%[clust, c] = STREAM_SKELETON_RESHUFFLE_CEF_VER5_nPNT_OPTIMIZED(clust,numC,var, 2, 0);
   %%--%%[clust, c] = STREAM_SKELETON_RESHUFFLE_SINGLE_VER4_nPNT_OPTIMIZED(clust, numC,var, 10e-25, T2);
   %%%%%[clust,numC]=STREAM_SKELETON_RECLUSTER_VER3_OPTIMIZED_MEM_DEBUG1_1(clust,clustEmpty, numC, var,T2);
   %%--%%[clust,numC]=CPP_Recluster_fast(clust,numC,var,T2,statInfo) ;

   %%% ??? 
   %%--%%[clust,c] = STREAM_SKELETON_RESHUFFLE_MINDIST_VER5_nPNT_OPTIMIZED(clust,numC,var, 2, 0);
   %%--%%[clust, c] = STREAM_SKELETON_RESHUFFLE_SINGLE_VER4_nPNT_OPTIMIZED(clust, numC,var, 10e-25, T2);
   %%%%[clust,numC]=STREAM_SKELETON_RECLUSTER_VER3_OPTIMIZED_MEM_DEBUG1_1(clust,clustEmpty, numC, var,T2);
   %%--%%[clust,numC]=CPP_Recluster_fast(clust,numC,var,T2,statInfo) ;

   %%--%%[clust, c] = STREAM_SKELETON_RESHUFFLE_CEF_VER5_nPNT_OPTIMIZED(clust,numC,var, 2, 0);
   %%--%%[clust, c] = STREAM_SKELETON_RESHUFFLE_SINGLE_VER4_nPNT_OPTIMIZED(clust, numC,var, 10e-25, T2);
   %%%%%[clust,numC]=STREAM_SKELETON_RECLUSTER_VER3_OPTIMIZED_MEM_DEBUG1_1(clust,clustEmpty, numC, var,T2);
   %%--%%[clust,numC]=CPP_Recluster_fast(clust,numC,var,T2,statInfo) ;

    clust = clust(1:numC);
   % STREAM_SKELETON_PLOT(clust);

% % %    return
% % %     
% % %     % RUNNING these after the loop, produces better results
% % %     modified = true;
% % %     onlyonce = true;
% % %     while(modified)
% % %         modified = false;
% % %         disp('RESHUFFLE_SINGLE_VER4_nPNT')
% % %         [clust, c] = STREAM_SKELETON_RESHUFFLE_SINGLE_VER4_nPNT(clust, var, 10e-25, T2)
% % %         if ( c ) 
% % %             modified = true;
% % %             clust=STREAM_SKELETON_RECLUSTER_VER3(clust,var,T2); 
% % %         end
% % %         disp('RESHUFFLE_DIST_VER4_nPNT')
% % %         [clust, c] = STREAM_SKELETON_RESHUFFLE_DIST_VER4_nPNT(clust,var, 2, 0);
% % %         if ( c ) 
% % %             modified = true;
% % %             clust=STREAM_SKELETON_RECLUSTER_VER3(clust,var,T2); 
% % %         end
% % %         disp('RESHUFFLE_CEF_VER4_nPNT')
% % %         [clust, c] = STREAM_SKELETON_RESHUFFLE_CEF_VER4_nPNT(clust,var, 2, 0);
% % %         if ( c ) 
% % %             modified = true;
% % %             clust=STREAM_SKELETON_RECLUSTER_VER3(clust,var,T2); 
% % %         end
% % %         % INTERNAL CEF is not a good measure for compactness of a cluster
% % %         %disp('RESHUFFLE_INTCEF_VER4_nPNT')
% % %         %[clust,c] = STREAM_SKELETON_RESHUFFLE_INTCEF_VER4_nPNT(clust,var, 2, 0);
% % %         %if ( c ) 
% % %         %    modified = true;
% % %         %    clust=STREAM_SKELETON_RECLUSTER_VER3(clust,var,T2); 
% % %         %end
% % %         if ( onlyonce )
% % %             onlyonce = false;
% % %             disp('RESHUFFLE_MINDIST_VER4_nPNT')
% % %             [clust,c] = STREAM_SKELETON_RESHUFFLE_MINDIST_VER4_nPNT(clust,var, 2, 0);
% % %             if ( c ) 
% % %                 modified = true;
% % %                 clust=STREAM_SKELETON_RECLUSTER_VER3(clust,var,T2); 
% % %             end
% % %         end
% % % 
% % %         
% % %         
% % %         
% % %     end
    %clust=STREAM_SKELETON_DEL_SINGLE_VER3(clust,var,T2); 
    if ( numC ~= size(clust,2) )
        disp('NUMC MISMATCH')
    end
    for n=1:size(clust,2)
%%%		[cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( clust(n).xy, 0, 0, 0, 0, 0, 0, var, 0, statInfo, 0 );
        %%%%%%%%%% [DCirCef,maxList,maxDist,IntCef] = EXECUTE_CPP_SKELETON_V1 ( clust(n).xy, var, 0, statInfo );
        %%%%%%%%%% clust(n).DCirCef = DCirCef;
        %%%%%%%%%% clust(n).maxDist = maxDist;
        %%%%%%%%%% clust(n).IntCef = IntCef;
		
% % 		clust(n).DCirCef = cefMAXNew;
% % 		clust(n).maxDist = outMAXDistNew;
% % 		clust(n).IntCef = cefSUMNew;
% % 		clust(n).outMAXPointList = outMAXPointList;
% % 		clust(n).maxListNew = maxListNew;
% % 		clust(n).maxValueNew = maxValueNew;

        clust(n).maxList = unique(clust(n).outMAXPointList','row')';
        clust(n).meanClust = mean(clust(n).xy,2);
        clust(n).R = unique([clust(n).maxList , clust(n).meanClust]','row')';
    end       
     
end