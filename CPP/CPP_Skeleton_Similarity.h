#ifndef _CPP_cef_local_radius_func_
#define _CPP_cef_local_radius_func_


#include <algorithm>
#include <vector>
#include <cmath>
#include <limits>  

using namespace std;

double cef_similarity ( double *cell1,  mwSize Ncell1, mwSize Nfeat, double *cv, double *cvinv, double cvdet, double *mean, int *maxList, double *sumC ){
    double pi = 3.1415926535;
	
	double const1 = (1.0/( pow(2.0*pi,(Nfeat/2.0))*sqrt(cvdet) ));
	//double const2 = ((Ncell1*(Ncell1-1))/2.0);
	double const2 = Ncell1*(Ncell1-1);
	
    double *cell, *cellTemp1, *cellTemp2, sum, temp;
    int i,j,k,h;   
    
    cell = new double[Nfeat];
    cellTemp1 = new double[Nfeat];
    cellTemp2 = new double[Nfeat];

	// This pointer should be deleted by the calling function
	// maxList = new int[Ncell1];

	if(!cell) return 0;
	if(!cellTemp1)return 0;
	if(!cellTemp2)return 0;
	
	//mexPrintf("N1=%d \n",Ncell1);
 	//mexPrintf("N2=%d \n",Ncell2);
 	//mexPrintf("Nfeat=%d \n",Nfeat);
    
    sum = 0.0;
	
	//mwSize len2 = (int)rad;
	//len2 = len2 > Ncell2 ? (int)Ncell2 : len2;
	
	//mexPrintf("len2=%d \n",len2);
	
	//cellTemp2 = new double [Nfeat*len2];
	//if(!cellTemp2)return 0; 	
   
	
	
	// Save all cell values in a vector. We can delete individual items easier
	/*
	for (i=0;i<Ncell1;i++) {
		for (k=0;k<Nfeat;k++){			
			cellSt.x[k] = cell1[i*Nfeat+k]
		}
		srt.push_back(cellSt);		
	}
	*/	
		
	// From each point, calculate CEF to the farthest point only and sum them up.
	// 12.04.2020
	
	double 	sumCEF = 0.0;
			
	if ( Ncell1 == 1 ) {
        maxList[0] = 0;
        *sumC = DBL_MAX;
        return DBL_MAX;
    }
		
    for (i=0;i<Ncell1;i++) {
		
		//for (k=0;k<Nfeat;k++){
		//	mexPrintf("cell1=%e \n",cell1[i*Nfeat+k]);
		//}
		
		// Find the maximum distant point 
		double maxDist = 0.0;
		int maxLoc = -1;
		// Multiple calculations. Start from i+1. It will be faster. 10-04-2020
		// 12.04.2020. i+1 is not good. In that case the other side is not counted as 
		// a farthest point
		for (j=0;j<Ncell1;j++) { 
		
			if ( i != j ) {
				// **********************************************
				// Calculate cef from each point to other points
				for (k=0;k<Nfeat;k++){				
					cellTemp1[k] = cell1[j*Nfeat+k];
				}			           
				
				for (k=0;k<Nfeat;k++){				
				   cell[k] = (cell1[i*Nfeat+k] - cellTemp1[k]) - mean[k];
				}
				
				// CALCULATE cell * cvinv * cell'
				for (h=0;h<Nfeat;h++){
					temp = 0.0;
					for (k=0;k<Nfeat;k++){
						temp += cell[k]*cvinv[h*Nfeat+k];
					}	
					cellTemp2[h] = temp;				
				}			
				temp = 0.0;
				for (k=0;k<Nfeat;k++){
					temp += cellTemp2[k]*cell[k];				
				}            
				//cout << "SUMCEF=" << sumCEF  <<"-" << exp(-0.5*temp)<< endl;					
				sumCEF += exp(-0.5*temp);  
				//cout << "SUMCEF=" << sumCEF  <<"-" << exp(-0.5*temp)<< endl;					
			// *********************************************
		
		    // Dont measure distance to itself
		    
				double dist = 0.0;
				for (k=0;k<Nfeat;k++){			
					dist += pow(cell1[i*Nfeat+k] - cell1[j*Nfeat+k],2) ;				
				}	
				if ( dist >= maxDist ) {
					maxDist = dist;
					maxLoc = j;
				}
			}
		}
		
		if ( i>= Ncell1) cout << "Index Error SKELETON:" << i << endl;
		
		maxList[i] = maxLoc;
		// The maximum distant point is at maxLoc. Find cef 

		//cout << "size=" << len2 << " " << rad << endl;		
		
		// cout  << "maxList=" << i << " " << maxList[i] << endl;
		
			//cout << y << " ";
		for (k=0;k<Nfeat;k++){	
			//cout << tc*Nfeat+k << " " << y*Nfeat+k << endl;
			cellTemp1[k] = cell1[maxLoc*Nfeat+k];
			// cout << cell2[y*Nfeat+k] << " ";
		}			           
			
		for (k=0;k<Nfeat;k++){				
		   cell[k] = (cell1[i*Nfeat+k] - cellTemp1[k]) - mean[k];
		}
		
		// CALCULATE cell * cvinv * cell'
		for (h=0;h<Nfeat;h++){
			temp = 0.0;
			for (k=0;k<Nfeat;k++){
				temp += cell[k]*cvinv[h*Nfeat+k];
			}	
			cellTemp2[h] = temp;				
		}			
		temp = 0.0;
		for (k=0;k<Nfeat;k++){
			temp += cellTemp2[k]*cell[k];				
		}            
		sum += exp(-0.5*temp);            
        
		// cout << "SUM=" << sum  << endl;		
    }               
	
	delete [] cell;
	delete [] cellTemp1;
	delete [] cellTemp2;
	
	cellTemp1 = NULL;	
	cell = NULL;
	cellTemp2 = NULL;
    
	//cout << "COEF=" << (1/( pow(2*pi,(Nfeat/2.0))*sqrt(cvdet) )) << endl;
    //cout << const1 << " " << sum << " " << const1*sum << " " << const2 << endl;
	
	*sumC = const1*sumCEF/const2; // This from N points to N points
    return (const1*sum)/Ncell1; // This is calculated once for each point
    //return (sum) /(Ncell1+len2);
        
}
#endif


