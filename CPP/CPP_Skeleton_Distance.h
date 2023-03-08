#ifndef _CPP_Skeleon_Distance_
#define _CPP_Skeleon_Distance_


#include <algorithm>
#include <vector>
#include <cmath>
#include <limits>  
#include <cfloat>  

using namespace std;



double skeleton_distance_euc_minave (double *xp, double *cell1,  double *cell2, mwSize Nxp, mwSize Ncell1, mwSize Ncell2, mwSize Nfeat, double *ave1, double *ave2){
    double pi = 3.1415926535;
	
	// double const1 = (1.0/( pow(2.0*pi,(Nfeat/2.0))*sqrt(cvdet) ));
	//double const2 = ((Ncell1*(Ncell1-1))/2.0);
	// double const2 = Ncell1*(Ncell1-1);
	
    double *cell, *cellTemp1, *cellTemp2, sum, temp;
    int i,j,k,h;   
    
    // cell = new double[Nfeat];
    // cellTemp1 = new double[Nfeat];
    // cellTemp2 = new double[Nfeat];

	// This pointer should be deleted by the calling function
	// maxList = new int[Ncell1];

	// if(!cell) return 0;
	// if(!cellTemp1)return 0;
	// if(!cellTemp2)return 0;
	
	//mexPrintf("N1=%d \n",Ncell1);
 	//mexPrintf("N2=%d \n",Ncell2);
 	//mexPrintf("Nfeat=%d \n",Nfeat);
    
    sum = 0.0;
	
	//mwSize len2 = (int)rad;
	//len2 = len2 > Ncell2 ? (int)Ncell2 : len2;
	
	//mexPrintf("len2=%d \n",len2);
	
	//cellTemp2 = new double [Nfeat*len2];
	//if(!cellTemp2)return 0; 	
   
	
	
		
	// From each point, calculate CEF to the farthest point only and sum them up.
	// 12.04.2020
	
	double 	minDist;
	double 	aveDist1 = 0.0;
	double 	aveDist2 = 0.0;
			
	
	// MEasure average minimum distance from each xp point to cell1	
	if ( Ncell1 > 0 ) {
		for (i=0;i<Nxp;i++) {		
			// Find the maximum distant point 		
			minDist = FLT_MAX;
			for (j=0;j<Ncell1;j++) { 		    
				double dist = 0.0;
				for (k=0;k<Nfeat;k++){			
					dist += pow(xp[i*Nfeat+k] - cell1[j*Nfeat+k],2) ;				
				}
				dist = sqrt(dist);	
				if ( dist < minDist ) minDist = dist;
			}
			aveDist1 += minDist;
		}
	}
	// Average distance from xp to cell1
	aveDist1 = aveDist1/Nxp;
	

	// MEasure average minimum distance from each xp point to cell1	
	if ( Ncell2 > 0 ) {
		for (i=0;i<Nxp;i++) {		
			// Find the maximum distant point 		
			minDist = FLT_MAX;
			for (j=0;j<Ncell2;j++) { 		    
				double dist = 0.0;
				for (k=0;k<Nfeat;k++){			
					dist += pow(xp[i*Nfeat+k] - cell2[j*Nfeat+k],2) ;				
				}
				dist = sqrt(dist);	
				if ( dist < minDist ) minDist = dist;
			}
			aveDist2 += minDist;
		}
	}
	// Average distance from xp to cell1
	aveDist2 = aveDist2/Nxp;

	*ave1 = aveDist1;
	*ave2 = aveDist2;
	
	if ( aveDist1 > aveDist2 ) return 1;
	return 0;

    //return (sum) /(Ncell1+len2);
        
}
#endif