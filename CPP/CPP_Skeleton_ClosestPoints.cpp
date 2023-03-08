/*==========================================================
 * CPP_cef_local.cpp - calculate cef_local
 *
 * Erhan Gökçay
 * 3.01.2019
 *========================================================*/
/* $Revision: 1.0.0.0 $ */

#include "mex.h"

#include "stdlib.h"   
#include <cmath>
#include <iostream>

#define inp(row,col) inp[col*Nfeat+row]



/*
The Standard Deviation is a measure of how spread out numbers are.

Its symbol is σ (the greek letter sigma)

The formula is easy: it is the square root of the Variance. So now you ask, "What is the Variance?"

*/


   

/* The gateway function */
void mexFunction( int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {                      
    double *cell1,*cell2;
	double radius;
	
    size_t ncols1,ncols2,Nfeat;             /* size of matrix */
    
    double *outIndex1, *outIndex2;              /* output matrix */    
       

    /* create a pointer to the real data in the input matrix  */
	cell1 = mxGetPr(prhs[0]);
	cell2 = mxGetPr(prhs[1]);

 
	
	/* get dimensions of the input matrix */
    ncols1 = mxGetN(prhs[0]); // sample size
    ncols2 = mxGetN(prhs[1]); // sample size
    Nfeat = mxGetM(prhs[0]); // feature length. Should be same as rows of prhs[1]
    /* create the output matrix */
    plhs[0] = mxCreateDoubleMatrix((mwSize)1,(mwSize)1,mxREAL);
    plhs[1] = mxCreateDoubleMatrix((mwSize)1,(mwSize)1,mxREAL);

    // mxGetN : col
    // mxGetM : row
    //printf("size = %d %d %d %f",(mwSize)(nrows-2*(sqsz-1)), mxGetM( plhs[0]), mxGetN( plhs[0]), var);
    
    /* get a pointer to the real data in the output matrix */
    outIndex1 = mxGetPr(plhs[0]);
    outIndex2 = mxGetPr(plhs[1]);	
				
    /* call the computational routine */		
	
	double minDist = FLT_MAX; 
	double dist;
	for (int i = 0; i < ncols1; i++) {  
		for (int j = 0; j < ncols2; j++) {  
			dist = 0.0;
			for (int k=0;k<Nfeat;k++){			
				dist += pow(cell1[i*Nfeat+k] - cell2[j*Nfeat+k],2) ;				
			}	
			if ( dist < minDist ) {
				minDist = dist;
				*outIndex1 = i+1;
				*outIndex2 = j+1;
			}
			
		}
	}			
		

	
}
