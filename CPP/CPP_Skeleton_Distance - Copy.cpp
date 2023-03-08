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


#include "CPP_Skeleton_Distance.h"


   

/* The gateway function */
void mexFunction( int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {                      
    double *cell1,*cell2,*xp;
	double radius;
	
    size_t ncols1, ncols2, nxp, Nfeat;             /* size of matrix */
    
    double *outMatrix;              /* output matrix */           

    /* create a pointer to the real data in the input matrix  */
	xp = mxGetPr(prhs[0]);
	cell1 = mxGetPr(prhs[1]);
	cell2 = mxGetPr(prhs[2]);
	
	/* get dimensions of the input matrix */
    nxp = mxGetN(prhs[0]); // sample size
    ncols1 = mxGetN(prhs[1]); // sample size
    ncols2 = mxGetN(prhs[2]); // sample size
    Nfeat = mxGetM(prhs[0]); // feature length. Should be same as rows of prhs[1]
    /* create the output matrix */
    plhs[0] = mxCreateDoubleMatrix((mwSize)1,(mwSize)1,mxREAL);
	outMatrix = mxGetPr(plhs[0]);


    *outMatrix = cef_distance_euc(xp, cell1, cell2, (mwSize)nxp, (mwSize)ncols1, (mwSize)ncols2, (mwSize)Nfeat );

		

	
}
