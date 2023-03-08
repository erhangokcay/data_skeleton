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

#include "CPP_Skeleton_Similarity_OPTIMIZED_V1.h"

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
	
    size_t Ncell1New,ncols2,Nfeat;             /* size of matrix */
    
    double *cefMAXNew;              /* output matrix */    
       
    /* create a pointer to the real data in the input matrix  */
    cell1 = mxGetPr(prhs[0]);
	// --------------------------
	double *maxListPrev = mxGetPr(prhs[1]);
 	double *maxValuePrev = mxGetPr(prhs[2]);
	double *xpnew = mxGetPr(prhs[3]);
	long xpnewIndex = mxGetScalar(prhs[4]) - 1; // C++ indexes start from 0.
	// ---------------------
    cv = mxGetPr(prhs[5]);
    cvinv = mxGetPr(prhs[6]);
   
    cvdet = mxGetScalar(prhs[7]);
    mean = mxGetPr(prhs[8]);

	// -------------==============---------------
	long flag = mxGetScalar(prhs[9]);
	double *cefSUMOld = mxGetPr(prhs[10]);
	double *cefMAXOld = mxGetPr(prhs[11]);  	  
	// double *outMAXDistPrev = mxGetPr(prhs[12]);  	  
	
	/* get dimensions of the input matrix */
    Ncell1New = mxGetN(prhs[0]); // sample size	
    Nfeat = mxGetM(prhs[0]); // feature length. Should be same as rows of prhs[1]
 
	if ( Ncell1New <= 0 ) cout << "Ncell1New ERROR:" << Ncell1New << endl;
	if ( Nfeat <= 0 ) cout << "Nfeat ERROR:" << Nfeat << endl;

	size_t Ncell1Curr = Ncell1New;
	size_t Ncell1Prev = 0;

	if ( flag == 1 ) {   	// One point is extracted from the original (prev) list		
		Ncell1Prev = Ncell1Curr+1; // Previous calculation is done with an extra point. xpnew is already extracted from cell1
	} else if (flag == 2) {	// One point is added from the original (prev) list
		Ncell1New++;
		Ncell1Prev = Ncell1Curr; // The same. xpnew is not yet added to cell1.
	} else if (flag == 0){  // First calculation. No prev result yet!!!!
		
	}
	// ncols1 is the new size
	// cout << "Ncell1Prev=" << Ncell1Prev << "Ncell1New=" << Ncell1New << "Ncell1Curr=" << Ncell1Curr << endl;
 /* create the output matrix */
    plhs[0] = mxCreateDoubleMatrix((mwSize)1,(mwSize)1,mxREAL);
    plhs[1] = mxCreateDoubleMatrix((mwSize)1,(mwSize)1,mxREAL);
    plhs[2] = mxCreateDoubleMatrix((mwSize)Nfeat,(mwSize)Ncell1New,mxREAL);
	plhs[3] = mxCreateDoubleMatrix((mwSize)1,(mwSize)1,mxREAL);
	// --------------------------------------------------------
	plhs[4] = mxCreateDoubleMatrix((mwSize)1,(mwSize)Ncell1New,mxREAL);  // maxListNew
	plhs[5] = mxCreateDoubleMatrix((mwSize)1,(mwSize)Ncell1New,mxREAL);  // maxValueNew
	
    // mxGetN : col
    // mxGetM : row
    //printf("size = %d %d %d %f",(mwSize)(nrows-2*(sqsz-1)), mxGetM( plhs[0]), mxGetN( plhs[0]), var);
    
    /* get a pointer to the real data in the output matrix */
    cefMAXNew = mxGetPr(plhs[0]);
	double *cefSUMNew = mxGetPr(plhs[1]);	
	
    double *outMaxPointList = mxGetPr(plhs[2]);
	
	size_t sizeOutMaxList = mxGetNumberOfElements(plhs[2]);
	// cout << "sizeOutMaxList=" << sizeOutMaxList << endl;
	if (sizeOutMaxList<= 0) cout <<  "ERROR sizeOutMaxList=" << sizeOutMaxList << endl;
	
    double *outMAXDist = mxGetPr(plhs[3]);								
				
    /* call the computational routine */
    // int *maxListNew = new int [ncols1]; 
	double *maxListNew = mxGetPr(plhs[4]); 
 	 
  	double *maxValueNew = mxGetPr(plhs[5]); 

	double pi = 3.1415926535;	
	double const1 = (1.0/( pow(2.0*pi,(Nfeat/2.0))*sqrt(cvdet) ));

    		
	/*
	flag : 1   point extracted
	flag : 2	point added
	flag : 0	initial calculation. Ignore maxListPrev(null), xpnew(null) and ncols1Orig (Size of cell1,maxListNew == ncols1)		
	*/
	
 //    *outMatrix = cef_similarity(cell1, sumCEFOld, sumMAXOld, maxValuePrev, maxListPrev, xpnew, xpnewIndex, (mwSize)ncols1Curr, (mwSize)ncols1Prev,  (mwSize)nrows, cv, cvinv, cvdet, mean, sumCEF, (mwSize)ncols1, maxValueNew, maxListNew, flag);
	*cefMAXNew = cef_similarity( cell1, outMAXDist,  cefSUMOld, cefMAXOld, maxValuePrev, maxListPrev, xpnew, (mwSize)xpnewIndex, (mwSize)Ncell1Curr, (mwSize)Ncell1Prev, (mwSize)Nfeat, cv, cvinv, cvdet, mean, cefSUMNew , (mwSize)Ncell1New, maxValueNew, maxListNew, (mwSize)flag );

	// *********************************************************
	// Eliminate DUPLICATION from maxList 19.11.2020
	// *********************************************************
	
	// cout << "Returned.....\n";
	// cout << maxList[0] << endl;
	int ii=0;
	if ( flag != 0 ) *cefMAXNew = 0.0;
		
    double *cell; 
    double *cellTemp1; 
    double *cellTemp2;
	
	if ( flag != 0 ) {
		cell = new double[Nfeat];
		cellTemp1 = new double[Nfeat];
		cellTemp2 = new double[Nfeat];
	}
	double temp;
	int k,h;
	//cout << "cefMAXNew=" << *cefMAXNew << endl;
	for (int i=0;i<Ncell1New;i++) {
		ii = maxListNew[i];	
		//cout << "ii=" << ii << " " << Ncell1New << endl;
		if ( flag == 2 ) {
		// sumMAXNew calculation. Not optimized in the .h file
			if ( ii == Ncell1New-1 ) { // index of new xpnew
				for (k=0;k<Nfeat;k++){				
					cellTemp1[k] = xpnew[k];
				}			           				
				for (k=0;k<Nfeat;k++){				
				   cell[k] = (cell1[i*Nfeat+k] - cellTemp1[k]) - mean[k];
				}
				
				// CALCULATE cell * cvinv * cell'
				 temp = 0.0;
				for (h=0;h<Nfeat;h++){
					temp += cell[h]*cell[h];
				}			
				
				temp = 	exp(-0.5*temp*cvinv[0]);
			
				// cout << "temp1=" << temp << endl;
			} else {
				if ( i != Ncell1New-1 ) {				
					for (k=0;k<Nfeat;k++){				
						cellTemp1[k] = cell1[ii*Nfeat+k];
					}			           
					
					for (k=0;k<Nfeat;k++){				
					   cell[k] = (cell1[i*Nfeat+k] - cellTemp1[k]) - mean[k];
					}
					
					// CALCULATE cell * cvinv * cell'
					 temp = 0.0;
                    for (h=0;h<Nfeat;h++){
                        temp += cell[h]*cell[h];
                    }			

                    temp = 	exp(-0.5*temp*cvinv[0]);
                
				} else {
					for (k=0;k<Nfeat;k++){				
						cellTemp1[k] = cell1[ii*Nfeat+k];
					}			           
					
					for (k=0;k<Nfeat;k++){				
					   cell[k] = (xpnew[k] - cellTemp1[k]) - mean[k];
					}
					
					// CALCULATE cell * cvinv * cell'
					 temp = 0.0;
                    for (h=0;h<Nfeat;h++){
                        temp += cell[h]*cell[h];
                    }			

                    temp = 	exp(-0.5*temp*cvinv[0]);
				}					
				//cout << "temp2=" << temp << endl;				
			} 
			//cout << "cefMAXNew=" << (const1*(*cefMAXNew))/Ncell1New << " " << temp << endl;
		} else if ( flag == 1 ) {
			for (k=0;k<Nfeat;k++){				
				cellTemp1[k] = cell1[ii*Nfeat+k];
			}			           
			
			for (k=0;k<Nfeat;k++){				
			   cell[k] = (cell1[i*Nfeat+k] - cellTemp1[k]) - mean[k];
			}
			
			// CALCULATE cell * cvinv * cell'
                temp = 0.0;
				for (h=0;h<Nfeat;h++){
					temp += cell[h]*cell[h];
				}			
				
				temp = 	exp(-0.5*temp*cvinv[0]);		
		}
		*cefMAXNew += temp;

		// cout << "ii=" << ii << endl;
		if ( ii<0 || ii>=Nfeat*Ncell1New)cout << "maxListERROR="<<ii<<endl;
		for (int k=0;k<Nfeat;k++){						
			//cout << "ii="<< ii << " " << ii*nrows+k << endl;
			if ( flag == 0 ) {
				outMaxPointList[i*Nfeat+k] = cell1[ii*Nfeat+k];
			} else if ( flag == 2 ) {
				if ( ii == Ncell1New-1 ) 
					outMaxPointList[i*Nfeat+k] = xpnew[k];
				else
					outMaxPointList[i*Nfeat+k] = cell1[ii*Nfeat+k];
			} else if ( flag == 1 ) {
				outMaxPointList[i*Nfeat+k] = cell1[ii*Nfeat+k];
			}
		}
	}
	
	if ( flag != 0 ) {
		delete [] cell;
		delete [] cellTemp1;
		delete [] cellTemp2;
	}
	
	
	if ( flag != 0 ) {
		*cefMAXNew = (const1*(*cefMAXNew))/Ncell1New;
	}
	
	/*
	double maxDist =  0.0;
	double dist = 0.0;
	double sum = 0.0;
	for (int i1=0;i1<Ncell1New;i1++) {
		for (int i2=i1+1;i2<Ncell1New;i2++) {
			sum = 0.0;
			for (int k=0;k<Nfeat;k++){						
				//cout << "ii="<< ii << " " << ii*nrows+k << endl;
				double d = outMaxPointList[i1*Nfeat+k] - outMaxPointList[i2*Nfeat+k];
				sum += (d*d);
			}
			sum = sqrt(sum);	
			if ( sum > maxDist ) maxDist = sum;
		}		
	}
	*/
	// *outMaxDist = *outMAXDistPrev;
	
	// delete [] maxList;
	
}
