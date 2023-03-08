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

#include "CPP_Skeleton_Similarity.h"

/*
The Standard Deviation is a measure of how spread out numbers are.

Its symbol is σ (the greek letter sigma)

The formula is easy: it is the square root of the Variance. So now you ask, "What is the Variance?"

*/


   

/* The gateway function */
void mexFunction( int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {                      
    double *cell1,*cell2;
	double *cv,*cvinv;  // covar matrix and inverse
	double cvdet;  // covar determinant
	double *mean; // mean of what?
	double radius;
	
    size_t ncols1,ncols2,nrows;             /* size of matrix */
    
    double *outMatrix;              /* output matrix */    
       

    /* create a pointer to the real data in the input matrix  */
    cell1 = mxGetPr(prhs[0]);

    cv = mxGetPr(prhs[1]);
    cvinv = mxGetPr(prhs[2]);
   
    cvdet = mxGetScalar(prhs[3]);
    mean = mxGetPr(prhs[4]);  
	
	/* get dimensions of the input matrix */
    ncols1 = mxGetN(prhs[0]); // sample size	
    nrows = mxGetM(prhs[0]); // feature length. Should be same as rows of prhs[1]
 
	if ( ncols1 <= 0 ) cout << "ncols1 ERROR:" << ncols1 << endl;
	if ( nrows <= 0 ) cout << "nrows ERROR:" << nrows << endl;

 /* create the output matrix */
    plhs[0] = mxCreateDoubleMatrix((mwSize)1,(mwSize)1,mxREAL);
    plhs[1] = mxCreateDoubleMatrix((mwSize)nrows,(mwSize)ncols1,mxREAL);
    plhs[2] = mxCreateDoubleMatrix((mwSize)1,(mwSize)1,mxREAL);
	plhs[3] = mxCreateDoubleMatrix((mwSize)1,(mwSize)1,mxREAL);

    // mxGetN : col
    // mxGetM : row
    //printf("size = %d %d %d %f",(mwSize)(nrows-2*(sqsz-1)), mxGetM( plhs[0]), mxGetN( plhs[0]), var);
    
    /* get a pointer to the real data in the output matrix */
    outMatrix = mxGetPr(plhs[0]);
	
    double *outMaxList = mxGetPr(plhs[1]);
	
	size_t sizeOutMaxList = mxGetNumberOfElements(plhs[1]);
	// cout << "sizeOutMaxList=" << sizeOutMaxList << endl;
	if (sizeOutMaxList<= 0 ) cout <<  "ERROR sizeOutMaxList=" << sizeOutMaxList << endl;
	
    double *outMaxDist = mxGetPr(plhs[2]);
				
    /* call the computational routine */
    int *maxList = new int [ncols1]; 
    double *sumCEF = mxGetPr(plhs[3]);;
	
    *outMatrix = cef_similarity(cell1,  (mwSize)ncols1,  (mwSize)nrows, cv, cvinv, cvdet, mean, maxList, sumCEF );
	
	// cout << "Returned.....\n";
	// cout << maxList[0] << endl;
	int ii=0;
	for (int i=0;i<ncols1;i++) {
		for (int k=0;k<nrows;k++){			
			ii = maxList[i];
			if ( ii<0 || ii>=nrows*ncols1)cout << "maxListERROR="<<ii<<endl;
			//cout << "ii="<< ii << " " << ii*nrows+k << endl;
			outMaxList[i*nrows+k] = cell1[ii*nrows+k];
		}
	}
	
	double maxDist =  0.0;
	double dist = 0.0;
	double sum = 0.0;
	for (int i1=0;i1<ncols1;i1++) {
		for (int i2=i1+1;i2<ncols1;i2++) {
			sum = 0.0;
			for (int k=0;k<nrows;k++){						
				//cout << "ii="<< ii << " " << ii*nrows+k << endl;
				double d = outMaxList[i1*nrows+k] - outMaxList[i2*nrows+k];
				sum += (d*d);
			}
			sum = sqrt(sum);	
			if ( sum > maxDist ) maxDist = sum;
		}		
	}
	
	*outMaxDist = maxDist;
	
	delete [] maxList;
	
}
