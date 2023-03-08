/* ==========================================================================
 * phonebook.c 
 * example for illustrating how to manipulate structure and cell array
 *
 * takes a (MxN) structure matrix and returns a new structure (1x1)
 * containing corresponding fields: for string input, it will be (MxN)
 * cell array; and for numeric (noncomplex, scalar) input, it will be (MxN)
 * vector of numbers with the same classID as input, such as int, double
 * etc..
 *
 * This is a MEX-file for MATLAB.
 * Copyright 1984-2011 The MathWorks, Inc.
 *==========================================================================*/

#include "mex.h"

#include <string>
#include <cmath>
#include <iostream>
#include <vector>

#define MAXCHARS 80   /* max length of string contained in each field */

#define inp(row,col) inp[col*Nfeat+row]

#include "CPP_Skeleton_Similarity_OPTIMIZED_V1_HPP.h"


using namespace std;
struct clustSt {
    mxArray *xy;
    double grp;
    double Tmean;
    double Tvar;
    double Tcef;
    double DCirCef;
    double maxDist;
    double IntCef;
    mxArray *outMAXPointList;
    mxArray *maxListNew;
    mxArray *maxValueNew;
    bool modified;    
} ;      
struct clustId {
    int xy;
    int grp;
    int Tmean;
    int Tvar;
    int Tcef;
    int DCirCef;
    int maxDist;
    int IntCef;
    int outMAXPointList;
    int maxListNew;
    int maxValueNew;
    int modified;    
} ;

//-------------------------------------------------------------------------
	
//[cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( inpData, cefSUMOld, cefMAXOld, maxValuePrev, maxListPrev, xpnew, xpnewIndex, std, mean, statInfo, flag )
//[cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = CPP_Skeleton_Similarity_OPTIMIZED_V1( inpData, maxListPrev, maxValuePrev, xpnew, xpnewIndex, covar, cvinv, cvdet,  mean_m, flag, cefSUMOld, cefMAXOld);

clustSt CPP_Skeleton_Similarity_OPTIMIZED_V1_HPP( mxArray *_inpData, mxArray *_maxListPrev, mxArray *_maxValuePrev, mxArray *_xpnew, int _xpnewIndex, mxArray *_covar, mxArray *_cvinv, double _cvdet,  mxArray *_mean_m, int _flag, double _cefSUMOld, double _cefMAXOld) {
    
    clustSt retSt;
    
    double *cell1,*cell2;
	double *cv,*cvinv;  // covar matrix and inverse
	double cvdet;  // covar determinant
	double *mean; // mean of what?
	double radius;
	
    size_t Ncell1New,ncols2,Nfeat;             /* size of matrix */
    
    double *cefMAXNew;              /* output matrix */    
       
    /* create a pointer to the real data in the input matrix  */
    cell1 = mxGetPr(_inpData);
	// --------------------------
	double *maxListPrev = mxGetPr(_maxListPrev);
 	double *maxValuePrev = mxGetPr(_maxValuePrev);
	double *xpnew = mxGetPr(_xpnew);
	int xpnewIndex = _xpnewIndex - 1; // C++ indexes start from 0.
	// ---------------------
    cv = mxGetPr(_covar);
    cvinv = mxGetPr(_cvinv);   
    cvdet = _cvdet;
    mean = mxGetPr(_mean_m);

	// -------------==============---------------
	long flag = _flag;
	double cefSUMOld = _cefSUMOld;
	double cefMAXOld = _cefMAXOld;  	  
	// double *outMAXDistPrev = mxGetPr(prhs[12]);  	  
	
	/* get dimensions of the input matrix */
    Ncell1New = mxGetN(_inpData); // sample size	
    Nfeat = mxGetM(_inpData); // feature length. Should be same as rows of prhs[1]
 
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
    //plhs[0] = mxCreateDoubleMatrix((mwSize)1,(mwSize)1,mxREAL); /// cefMAXNew
    //plhs[1] = mxCreateDoubleMatrix((mwSize)1,(mwSize)1,mxREAL); // cefSUMNew
    //plhs[2] = mxCreateDoubleMatrix((mwSize)Nfeat,(mwSize)Ncell1New,mxREAL); // outMaxPointList
	// plhs[3] = mxCreateDoubleMatrix((mwSize)1,(mwSize)1,mxREAL); // outMAXDist
	// --------------------------------------------------------
	// plhs[4] = mxCreateDoubleMatrix((mwSize)1,(mwSize)Ncell1New,mxREAL);  // maxListNew
	// plhs[5] = mxCreateDoubleMatrix((mwSize)1,(mwSize)Ncell1New,mxREAL);  // maxValueNew
	
    // mxGetN : col
    // mxGetM : row
    //printf("size = %d %d %d %f",(mwSize)(nrows-2*(sqsz-1)), mxGetM( plhs[0]), mxGetN( plhs[0]), var);
    
    retSt.xy = mxDuplicateArray(_inpData);
    //-//cout << "IN HPP = #xy="<< mxGetNumberOfElements(retSt.xy) << endl;
    
    /* get a pointer to the real data in the output matrix */
    retSt.DCirCef = 0; // cefMAXNew = 0; // = mxGetPr(plhs[0]);
	retSt.IntCef = 0; // cefSUMNew = 0; // = mxGetPr(plhs[1]);	
	retSt.outMAXPointList = mxCreateDoubleMatrix((mwSize)Nfeat,(mwSize)Ncell1New,mxREAL);
    double *outMaxPointList = mxGetPr(retSt.outMAXPointList);
	
	size_t sizeOutMaxList = mxGetNumberOfElements(retSt.outMAXPointList);
	// cout << "sizeOutMaxList=" << sizeOutMaxList << endl;
	if (sizeOutMaxList <= 0) cout <<  "ERROR sizeOutMaxList=" << sizeOutMaxList << endl;
	
    retSt.maxDist = 0; // outMAXDist = 0; // mxGetPr(plhs[3]);								
				
    /* call the computational routine */
    // int *maxListNew = new int [ncols1]; 
    retSt.maxListNew = mxCreateDoubleMatrix((mwSize)1,(mwSize)Ncell1New,mxREAL); 
	double *maxListNew = mxGetPr(retSt.maxListNew); 
 	 
    retSt.maxValueNew = mxCreateDoubleMatrix((mwSize)1,(mwSize)Ncell1New,mxREAL); 
  	double *maxValueNew = mxGetPr(retSt.maxValueNew); 

	double pi = 3.1415926535;	
	double const1 = (1.0/( pow(2.0*pi,(Nfeat/2.0))*sqrt(cvdet) ));
    		
	/*
	flag : 1   point extracted
	flag : 2	point added
	flag : 0	initial calculation. Ignore maxListPrev(null), xpnew(null) and ncols1Orig (Size of cell1,maxListNew == ncols1)		
	*/
	
 //    *outMatrix = cef_similarity(cell1, sumCEFOld, sumMAXOld, maxValuePrev, maxListPrev, xpnew, xpnewIndex, (mwSize)ncols1Curr, (mwSize)ncols1Prev,  (mwSize)nrows, cv, cvinv, cvdet, mean, sumCEF, (mwSize)ncols1, maxValueNew, maxListNew, flag);
	//retSt.cefMAXNew = cef_similarity( cell1, outMAXDist,  cefSUMOld, cefMAXOld, maxValuePrev, maxListPrev, xpnew, (mwSize)xpnewIndex, (mwSize)Ncell1Curr, (mwSize)Ncell1Prev, (mwSize)Nfeat, cv, cvinv, cvdet, mean, cefSUMNew , (mwSize)Ncell1New, maxValueNew, maxListNew, (mwSize)flag );
	retSt.DCirCef = cef_similarity( cell1, &retSt.maxDist,  &cefSUMOld, &cefMAXOld, maxValuePrev, maxListPrev, xpnew, (mwSize)xpnewIndex, (mwSize)Ncell1Curr, (mwSize)Ncell1Prev, (mwSize)Nfeat, cv, cvinv, cvdet, mean, &retSt.IntCef , (mwSize)Ncell1New, maxValueNew, maxListNew, (mwSize)flag );

	// *********************************************************
	// Eliminate DUPLICATION from maxList 19.11.2020
	// *********************************************************
	    
    //-// cout << "IN HPP = #xy1="<< mxGetNumberOfElements(retSt.xy) << endl;

	// cout << "Returned.....\n";
	// cout << maxList[0] << endl;
	int ii=0;
	if ( flag != 0 ) retSt.DCirCef = 0.0;
		
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
	//-// cout << "Ncell1New=" << Ncell1New << endl;
	for (int i=0;i<Ncell1New;i++) {
            
        //-// cout << "IN HPP = #xy0="<< mxGetNumberOfElements(retSt.xy) << endl;

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
				temp = 	exp(-0.5*temp);
			
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
					temp = 	exp(-0.5*temp);	
				} else {
					for (k=0;k<Nfeat;k++){				
						cellTemp1[k] = cell1[ii*Nfeat+k];
					}			           
					
					for (k=0;k<Nfeat;k++){				
					   cell[k] = (xpnew[k] - cellTemp1[k]) - mean[k];
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
					temp = 	exp(-0.5*temp);	
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
			temp = 	exp(-0.5*temp);				
		}
		retSt.DCirCef += temp;

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
		retSt.DCirCef = (const1*(retSt.DCirCef))/Ncell1New;
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
      
    //-// cout << "IN HPP = #xy2="<< mxGetNumberOfElements(retSt.xy) << endl;
	return retSt;
};

// ----------------------------------------------------------------------

mxArray *getColXY(mxArray *inp, int rowCnt, int clustN, int ind, int fieldInd){   
    
    mxArray *out = mxCreateDoubleMatrix(rowCnt,1,mxREAL);   
    double *outP = mxGetPr(out);
    double *pnt = mxGetPr(mxGetFieldByNumber(inp, clustN,  fieldInd));
        
    //-// printf("getColXY=%d\n", mxGetNumberOfElements(mxGetFieldByNumber(inp, clustN,  fieldInd)));
    if ( (ind*rowCnt+rowCnt) <= mxGetNumberOfElements(mxGetFieldByNumber(inp, clustN,  fieldInd)) ){        
        memcpy(outP,pnt+(ind*rowCnt),sizeof(double)*rowCnt);
    } else {
        cout << "index error" << endl;
    }
    
    return out;
};

mxArray *merge(mxArray *a1, mxArray *a2 ){
    int m[2],n[2],nbytes,bytes_to_copy,destination_offset;
    double *ptr,*newptr;   
    m[0] = mxGetM(a1);
    m[1] = mxGetM(a2);
    n[0] = mxGetN(a1);
    n[1] = mxGetN(a2);
    if(m[0] != m[1]){
           mexErrMsgTxt("Dimension mismatch");
    }
    nbytes = (m[0]) * (n[0] + n[1])* sizeof(double);//size of new array
    destination_offset = m[0] * n[0]; //start offset for copying
    bytes_to_copy = m[1] * n[1] * sizeof(double);
	mxArray *out = mxDuplicateArray(a1);
    ptr = mxGetPr(out);
	newptr = (double *)mxRealloc(ptr, nbytes);//reallocate array
    mxSetPr(out,newptr);
    ptr = mxGetPr(a2);
    memcpy(newptr+destination_offset,ptr,bytes_to_copy);//actual copy
    mxSetN(out,n[0]+n[1]);//fix dimension
    return out;
}
mxArray *readStructArray (const mxArray *p, int nfields, mwSize NStructElems, mwSize *dims,const char **fnames){
    
    //const char **fnames;       /* pointers to field names */
    //mwSize *dims;
    mxArray    *tmp, *fout;
    double *pnt;
    char       *pdata=NULL;
    int        ifield; // , nfields;
    mxClassID  *classIDflags;
    mwIndex    jstruct;
    //mwSize     NStructElems;
    mwSize     ndim;
     

    
   
    //  mwSize dims[2] = {1, NStructElems };
     
    //plhs[0] = mxCreateStructArray(2, dims, nfields, fnames);
    
    //plhs[0] = mxCreateDoubleMatrix((mwSize)1,(mwSize)1,mxREAL);
    //double *outV = mxGetPr(plhs[0]);
    //*outV = 1;
    
    mxArray * c = mxCreateStructArray(2, dims, nfields, fnames);
    
    //clustSt *clust = new clustSt[numC];
        
       
    // if ( !plhs[0] ) return;

       
    /* allocate memory  for storing classIDflags */
    classIDflags = (mxClassID *)mxCalloc(nfields, sizeof(mxClassID));
    
    /* check empty field, proper data type, and data type consistency;
     * and get classID for each field. */
    for(ifield=0; ifield<nfields; ifield++) {
                            
        //-// printf("ifield=%d\n",ifield);           
        
        for(jstruct = 0; jstruct < NStructElems; jstruct++) {
            //-// printf("jstruct=%d\n",jstruct);           

            //printf("-----1\n");
            tmp = mxGetFieldByNumber(p, jstruct, ifield);
                        
            if(tmp == NULL) {
                printf("%s%d\t%s%d\n", "FIELD: ", ifield+1, "STRUCT INDEX :", jstruct+1);
                printf( "MATLAB:phonebook:fieldEmpty","Above field is empty!");
                continue;
            }

            if(jstruct==0) {                                                
                classIDflags[ifield]=mxGetClassID(tmp);    
                //printf("CLASS=%d\n",classIDflags[ifield]);
            }
            
            mwSize  *dimsF = (mwSize *) mxGetDimensions(tmp);
            //-// printf("dimsF= %d %d\n",dimsF[0], dimsF[1]);
                        
            //printf("classID= %d \n",mxDOUBLE_CLASS);
            //printf("classID= %d \n",mxLOGICAL_CLASS);
            if ( classIDflags[ifield] == mxLOGICAL_CLASS )                                
                fout = mxCreateLogicalArray(2, dimsF);
            else
                fout = mxCreateNumericArray(2, dimsF, classIDflags[ifield], mxREAL);
                                     
            pdata = (char *)mxGetData(fout);
                        
                                      
            pnt = mxGetPr(tmp);
            int nPnt = mxGetNumberOfElements(tmp);                         
            
             mwSize     sizebuf;
             sizebuf = mxGetElementSize(tmp)*nPnt;
             
             //-// printf("sizebuf=  %d\n",sizebuf);
             if(sizebuf>0){
                memcpy(pdata, mxGetData(tmp), sizebuf);
             }                        
           
             mxSetFieldByNumber(c,jstruct,ifield,fout);
         }
    }
    
    //mxFree(fnames);            
    mxFree(classIDflags);
    //-// cout << "Before return\n";
    return c;
}

/*  the gateway routine.  */
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[] )
{
   
    
    const char **fnames;       /* pointers to field names */
    mwSize *dims;
    mxArray    *tmp, *fout;
    double *pnt;
    char       *pdata=NULL;
    int        ifield, nfields;
    mxClassID  *classIDflags;
    mwIndex    jstruct;
    mwSize     NStructElems;
    mwSize     ndim;
    
    mxArray *covar;
    mxArray *cvinv;
    double cvdet;
    mxArray *mean_m;
        
    /*
    clust(len).xy = [];
    clust(len).grp = 1; % first group
    clust(len).Tmean = 0; % initial values are zero
    clust(len).Tvar = 0;
    clust(len).Tcef = 0;
    clust(len).DCirCef =  0;
    clust(len).maxDist = 0;
    clust(len).IntCef = 0;
	clust(len).outMAXPointList = [];
  	clust(len).maxListNew = [];
  	clust(len).maxValueNew = 0;     
	clust(len).modified=false;
     ***/
    
    const char *field_names[] = {"xy", "grp", "Tmean", "Tvar", "Tcef", "DCirCef", "maxDist", "IntCef", "outMAXPointList", "maxListNew", "maxValueNew", "modified" };
            
    clustId cId;
    
    clustSt tempSt;
    
    cId.xy = mxGetFieldNumber(prhs[0],"xy"); // Array
    cId.grp = mxGetFieldNumber(prhs[0],"grp");
    cId.Tmean = mxGetFieldNumber(prhs[0],"Tmean");
    cId.Tvar = mxGetFieldNumber(prhs[0],"Tvar");
    cId.Tcef = mxGetFieldNumber(prhs[0],"Tcef");
    cId.DCirCef = mxGetFieldNumber(prhs[0],"DCirCef");
    cId.maxDist = mxGetFieldNumber(prhs[0],"maxDist");
    cId.IntCef = mxGetFieldNumber(prhs[0],"IntCef");
    cId.outMAXPointList = mxGetFieldNumber(prhs[0],"outMAXPointList"); // Array
    cId.maxListNew = mxGetFieldNumber(prhs[0],"maxListNew"); // Array
    cId.maxValueNew = mxGetFieldNumber(prhs[0],"maxValueNew");
    cId.modified = mxGetFieldNumber(prhs[0],"modified");
    
    
    
    //-// cout <<cId.xy<<cId.grp<<cId.Tmean<<cId.Tvar<<cId.Tcef<<cId.DCirCef<< cId.maxDist<<cId.IntCef<<cId.outMAXPointList << cId.maxListNew<< cId.maxValueNew <<cId.modified<<endl;
    
    /* check proper input and output */
    if(nrhs!=5)
        mexErrMsgIdAndTxt( "MATLAB:phonebook:invalidNumInputs",
                "One input required.");
    else if(nlhs > 2)
        mexErrMsgIdAndTxt( "MATLAB:phonebook:maxlhs",
                "Too many output arguments.");
    else if(!mxIsStruct(prhs[0]))
        mexErrMsgIdAndTxt( "MATLAB:phonebook:inputNotStruct",
                "Input must be a structure.");           
    
    /* get input arguments */
    nfields = mxGetNumberOfFields(prhs[0]);
    NStructElems = mxGetNumberOfElements(prhs[0]);
    dims = (mwSize *) mxGetDimensions(prhs[0]);
     
    fnames = (const char **) mxCalloc(nfields, sizeof(*fnames));
        
    /* get field name pointers */
    for (ifield=0; ifield<nfields; ifield++){
        fnames[ifield] = (char *)mxGetFieldNameByNumber(prhs[0],ifield);
        //printf("%c \n", fnames[ifield]);
    }
    //-// cout << "Before Reading Clust=" << mxGetNumberOfElements(prhs[0]) << flush << endl;
    mxArray * clust = readStructArray (prhs[0], nfields, NStructElems, dims, fnames); // Delete clust later   
    //-// cout << "After Reading Clust" << mxGetNumberOfElements(clust) << flush << endl;
    plhs[0] = mxCreateStructArray(2, dims, nfields, fnames); // Return the array. Empty.
    plhs[1] = mxCreateDoubleScalar(0); // Return the array. Empty.

    int numC = mxGetScalar(prhs[1]);
    double var = mxGetScalar(prhs[2]);
    double T = mxGetScalar(prhs[3]);    
    
    // READ stat_info
    int nfields1 = mxGetNumberOfFields(prhs[4]);
    mwSize NStructElems1 = mxGetNumberOfElements(prhs[4]);
    mwSize * dims1 = (mwSize *) mxGetDimensions(prhs[4]);     
    const char **fnames1 = (const char **) mxCalloc(nfields1, sizeof(*fnames1));        
    /* get field name pointers */
    for (ifield=0; ifield<nfields1; ifield++){
        fnames1[ifield] = (char *)mxGetFieldNameByNumber(prhs[4],ifield);
        //fprintf("%c \n", fnames[ifield]);
    }
        
    //-// cout << "Before Reading statInfo" << mxGetNumberOfElements(prhs[4]) << endl;
    mxArray * statInfo = readStructArray (prhs[4], nfields1, NStructElems1, dims1, fnames1); // Delete clust later
    //-// cout << "After Reading statInfo" << mxGetNumberOfElements(statInfo) << endl;
 
    //statInfo.mean_m = mean_m;
    //statInfo.cvinv = cvinv;
    //statInfo.cvdet = cvdet;
    //statInfo.covar = covar;
    
     mean_m =  mxGetFieldByNumber(statInfo, 0,  0);
     cvinv = mxGetFieldByNumber(statInfo, 0,  1);
     cvdet =  mxGetScalar(mxGetFieldByNumber(statInfo, 0,  2));
     covar = mxGetFieldByNumber(statInfo, 0,  3);
    
        
    
    //bool *t = mxGetPr(mxGetFieldByNumber(c, 0, 0));
    //printf("out=%d\n",t[0]);
    if ( mxGetNumberOfElements(mxGetFieldByNumber(clust, 0,  cId.xy)) > 0 ) {
        //-// cout << "OUT=" << mxGetPr(mxGetFieldByNumber(clust, 0,  cId.xy))[0] << endl;
    }
    // Implement ------------------------------------------------
    // [clustOut,outK]=STREAM_SKELETON_RECLUSTER_VER3_OPTIMIZED_MEM_DEBUG1_1(clust,clustOut,numC,var,T)
    // ----------------------------------------------------------
    
    bool break_while=false;
    bool break_loop=false;
    int outK=0;
    
    if ( numC == 1 ) {
        // HOW?? // 
        plhs[0] = mxDuplicateArray(clust); // plhs[0] = clust
        // ----------
        plhs[1] = mxCreateDoubleScalar(1);
        
        mxDestroyArray(clust);
        mxDestroyArray(statInfo);
       // Assign to output (outK)
        return;                    
    }
    
    // double cefMAXNew,cefSUMNew,outMAXDistNew;
    mxArray *outMAXPointList, *maxListNew, *maxValueNew;
        
    //-// cout << "Before while loop" << endl;
    mxArray *emptyArr = mxCreateDoubleMatrix(0,0,mxREAL);
    while (true) {
        break_while = true;
        // numC = size(clust,2); % 2 of clusters so far       

        break_loop = false;
        outK = 1;
         
        for (int n=0; n<numC; n++) {
            //-// cout << "n=" << n << endl;
            for (int m=n+1; m<numC; m++){
                            
                //-// cout << "m=" << m << endl;

				mxLogical *tmpN = mxGetLogicals(mxGetFieldByNumber(clust, n, cId.modified));
				mxLogical *tmpM = mxGetLogicals(mxGetFieldByNumber(clust, m, cId.modified));
                if ( !(*tmpN) && !(*tmpM)) {
                    //-// cout << "continue\n";
                    // if ( numC == 4) cout << "not modified"<<endl;
                    continue;                
                }
                mxArray *clust_n = mxGetFieldByNumber(clust, n, cId.xy);
                mxArray *clust_m = mxGetFieldByNumber(clust, m, cId.xy);
                int mCnt = mxGetNumberOfElements(clust_m);
                int nCnt = mxGetNumberOfElements(clust_n);
                mwSize *dims_n = (mwSize *) mxGetDimensions(clust_n);
                mwSize *dims_m = (mwSize *) mxGetDimensions(clust_m);
                
                 // if ( numC == 4)  cout << " if statement= " << mCnt << " " << nCnt << " " << dims_n[0] << "-" << dims_n[1] << " "<< dims_m[0] << "-"<<dims_m[1]<< endl;

                if ( mCnt>0 && nCnt>0 ){
                    
                    //-// cout << " inside if statement " << endl;
                    
                    //mxArray *nA = mxDuplicateArray (clust_n);
                    //mxArray *mA = mxDuplicateArray (clust_m);
                    mxArray *xymerged = merge(clust_n,clust_m);
                   
                    
                    //-// cout << " if dims " << endl;
                    if ( dims_n[1] == 1 &&  dims_m[1] == 1)  {    
                        //-// cout << " inside if dims " << endl;
                        tempSt = CPP_Skeleton_Similarity_OPTIMIZED_V1_HPP( xymerged, emptyArr, emptyArr, emptyArr, 0, covar, cvinv, cvdet,  mean_m, 0, 0, 0);
                        // clustSt CPP_Skeleton_Similarity_OPTIMIZED_V1( mxArray *_inpData, mxArray *_maxListPrev, mxArray *_maxValuePrev, mxArray *_xpnew, int _xpnewIndex, mxArray *_covar, mxArray *_cvinv, double _cvdet,  mxArray *_mean_m, int _flag, double _cefSUMOld, double _cefMAXOld) {
                        //[cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( inpData, cefSUMOld, cefMAXOld, maxValuePrev, maxListPrev, xpnew, xpnewIndex, std, mean, statInfo, flag )
                        //[cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = CPP_Skeleton_Similarity_OPTIMIZED_V1( inpData, maxListPrev, maxValuePrev, xpnew, xpnewIndex, covar, cvinv, cvdet,  mean_m, flag, cefSUMOld, cefMAXOld);
                        //// [cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( xymerged, 0, 0, 0, 0, 0, 0, var, 0, statInfo, 0 );
                        
                        /*    
                        tempSt.DCirCef = cefMAXNew;
                        tempSt.maxDist = outMAXDistNew;
                        tempSt.IntCef = cefSUMNew;
                        tempSt.outMAXPointList = outMAXPointList;
                        tempSt.maxListNew = maxListNew;
                        tempSt.maxValueNew = maxValueNew;
                        */
                    } else if ( dims_n[1] >= dims_m[1] ) { //       % size > 1
                        //-// cout << " inside else if > dims " << endl;

                        tempSt.xy = clust_n;
                        tempSt.DCirCef = *mxGetPr(mxGetFieldByNumber(clust, n, cId.DCirCef));
                        tempSt.maxDist = *mxGetPr(mxGetFieldByNumber(clust, n, cId.maxDist));
                        tempSt.IntCef = *mxGetPr(mxGetFieldByNumber(clust, n, cId.IntCef));
                        tempSt.outMAXPointList = mxGetFieldByNumber(clust, n, cId.outMAXPointList);
                        tempSt.maxListNew = mxGetFieldByNumber(clust, n, cId.maxListNew);
                        tempSt.maxValueNew = mxGetFieldByNumber(clust, n, cId.maxValueNew);
                        
                                                
                        clustSt tempStNew;

                        for (int h=0; h<dims_m[1]; h++) {
                             
                            //-// cout << " inside else if > dims h_loop=" << h << endl;
                            mwSize *dims_maxList = (mwSize *) mxGetDimensions(tempSt.maxListNew);
                            mxArray *xyp=emptyArr;
                            if ( dims_maxList[1] == 0 ){
                                cout << "4-2 MAXLIST ERROR" << endl;
                                return;
                            } else {

                                //-// cout << "before getColXY" << endl;
                                xyp = getColXY(clust,dims_m[0],m,h, cId.xy);  // #rows:dims_m[0] = dims_n[0] clust(m).xy(:,h);
                                //-// cout << "after getColXY" << endl;
                                if ( tempSt.xy == NULL ) cout << "BEFORE tempSt.xy NULL\n";
                                //-// cout << "1="<<mxGetNumberOfElements(tempSt.xy) << flush << endl;
                                tempStNew  = CPP_Skeleton_Similarity_OPTIMIZED_V1_HPP( tempSt.xy, tempSt.maxListNew, tempSt.maxValueNew, xyp, 0, covar, cvinv, cvdet,  mean_m, 2, tempSt.IntCef, tempSt.DCirCef);
                                //-// cout << "after CPP_Skeleton_Similarity_OPTIMIZED_V1" << endl;
                                //-// cout << tempSt.xy << endl;
                                //-// cout << "2="<<mxGetNumberOfElements(tempSt.xy) << flush << endl;
                                // clustSt CPP_Skeleton_Similarity_OPTIMIZED_V1( mxArray *_inpData, mxArray *_maxListPrev, mxArray *_maxValuePrev, mxArray *_xpnew, int _xpnewIndex, mxArray *_covar, mxArray *_cvinv, double _cvdet,  mxArray *_mean_m, int _flag, double _cefSUMOld, double _cefMAXOld) {
                                //[cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( inpData, cefSUMOld, cefMAXOld, maxValuePrev, maxListPrev, xpnew, xpnewIndex, std, mean, statInfo, flag )
                                //[cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = CPP_Skeleton_Similarity_OPTIMIZED_V1( inpData, maxListPrev, maxValuePrev, xpnew, xpnewIndex, covar, cvinv, cvdet,  mean_m, flag, cefSUMOld, cefMAXOld);
                                //// [cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( xymerged, 0, 0, 00, 0, 0, 0, var, 0, statInfo, 0 );

                                // [cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( temp.xy, temp.IntCef, temp.DCirCef, temp.maxValueNew, temp.maxListNew, xyp, 0, var, 0, statInfo, 2 );
                            }
                            //-// cout << "OUT H LOOP\n";
                            
                            //-// cout << mxGetNumberOfElements(xyp) << endl;
                            
                            
                            if ( tempSt.xy == NULL ) cout << "tempSt.xy NULL\n";
                            if ( xyp == NULL ) cout << "tempSt.xy NULL\n";
                            
                            //-// cout << "After ifffff\n";
                            //-// cout << mxGetNumberOfElements(tempSt.xy) << flush << endl;
                                                        
                           
                            
                            tempStNew.xy = merge(tempSt.xy, xyp);
                            
                            if (h>0) {
                                mxDestroyArray(tempSt.xy);
                                mxDestroyArray(tempSt.outMAXPointList);
                                mxDestroyArray(tempSt.maxValueNew);                                            
                                mxDestroyArray(tempSt.maxListNew);                                
                            }
                            
                            tempSt.xy = mxDuplicateArray(tempStNew.xy);
                            tempSt.DCirCef = tempStNew.DCirCef;
                            tempSt.maxDist = tempStNew.maxDist;
                            tempSt.IntCef = tempStNew.IntCef;
                            tempSt.outMAXPointList = mxDuplicateArray(tempStNew.outMAXPointList);
                            tempSt.maxListNew = mxDuplicateArray(tempStNew.maxListNew);
                            tempSt.maxValueNew = mxDuplicateArray(tempStNew.maxValueNew);      
                            
                            mxDestroyArray(tempStNew.xy);
                            mxDestroyArray(tempStNew.outMAXPointList);
                            mxDestroyArray(tempStNew.maxValueNew);                                            
                            mxDestroyArray(tempStNew.maxListNew);     
                            mxDestroyArray(xyp);
                           
                            //-// cout << "after merge\n";

                            /*
                            tempSt.DCirCef = cefMAXNew;
                            tempSt.maxDist = outMAXDistNew;
                            tempSt.IntCef = cefSUMNew;
                            tempSt.outMAXPointList = outMAXPointList;
                            tempSt.maxListNew = maxListNew;
                            tempSt.maxValueNew = maxValueNew;   
                             **/                     
                        }
                    } else if ( dims_n[1] <  dims_m[1] ) { //        % size > 1
                                                
                        //-// cout << " inside else if < dims " << endl;

                        tempSt.xy = mxGetFieldByNumber(clust, m, cId.xy);
                        tempSt.DCirCef = *mxGetPr(mxGetFieldByNumber(clust, m, cId.DCirCef));
                        tempSt.maxDist = *mxGetPr(mxGetFieldByNumber(clust, m, cId.maxDist)); 
                        tempSt.IntCef = *mxGetPr(mxGetFieldByNumber(clust, m, cId.IntCef)); 
                        tempSt.outMAXPointList = mxGetFieldByNumber(clust, m, cId.outMAXPointList);
                        tempSt.maxListNew = mxGetFieldByNumber(clust, m, cId.maxListNew);
                        tempSt.maxValueNew = mxGetFieldByNumber(clust, m, cId.maxValueNew); 
                        clustSt tempStNew;
                        for (int h=0; h<dims_n[1]; h++) {
                             mwSize *dims_maxList = (mwSize *) mxGetDimensions(tempSt.maxListNew);
                             mxArray *xyp=emptyArr;;
                             
                            if (  dims_maxList[1] == 0 ) {
                                cout << "4-2 MAXLIST ERROR" << endl;
                                return;
                            } else {
                                 xyp = getColXY(clust,dims_n[0],n,h, cId.xy);  // clust(n).xy(:,h);                                                                 
                                 tempStNew = CPP_Skeleton_Similarity_OPTIMIZED_V1_HPP( tempSt.xy, tempSt.maxListNew, tempSt.maxValueNew, xyp, 0, covar, cvinv, cvdet,  mean_m, 2, tempSt.IntCef, tempSt.DCirCef);
                                // [cefMAXNew,cefSUMNew,outMAXPointList,outMAXDistNew, maxListNew, maxValueNew] = EXECUTE_CPP_SKELETON_V1_OPTIMIZED_V1 ( temp.xy, temp.IntCef, temp.DCirCef, temp.maxValueNew, temp.maxListNew, xyp, 0, var, 0, statInfo, 2 );
                            }
                            tempStNew.xy = merge(tempSt.xy, xyp);
                            
                            if (h>0) {
                                mxDestroyArray(tempSt.xy);
                                mxDestroyArray(tempSt.outMAXPointList);
                                mxDestroyArray(tempSt.maxValueNew);                                            
                                mxDestroyArray(tempSt.maxListNew);                                
                            }
                            
                            tempSt.xy = mxDuplicateArray(tempStNew.xy);
                            tempSt.DCirCef = tempStNew.DCirCef;
                            tempSt.maxDist = tempStNew.maxDist;
                            tempSt.IntCef = tempStNew.IntCef;
                            tempSt.outMAXPointList = mxDuplicateArray(tempStNew.outMAXPointList);
                            tempSt.maxListNew = mxDuplicateArray(tempStNew.maxListNew);
                            tempSt.maxValueNew = mxDuplicateArray(tempStNew.maxValueNew);      
                            
                            mxDestroyArray(tempStNew.xy);
                            mxDestroyArray(tempStNew.outMAXPointList);
                            mxDestroyArray(tempStNew.maxValueNew);                                            
                            mxDestroyArray(tempStNew.maxListNew);     
                            mxDestroyArray(xyp);
                            
                            /*
                            tempSt.DCirCef = cefMAXNew;
                            tempSt.maxDist = outMAXDistNew;
                            tempSt.IntCef = cefSUMNew;
                            tempSt.outMAXPointList = outMAXPointList;
                            tempSt.maxListNew = maxListNew;
                            tempSt.maxValueNew = maxValueNew;      
                             **/                  
                        }
                    } else {
                       cout << "INVALID SIZES........" << endl;
                       cout << " INVALID " << mCnt << " " << nCnt << " " << dims_n[0] << "-" << dims_n[1] << " "<< dims_m[0] << "-"<<dims_m[1]<< endl;

                    }

                    //res = cefMAXNew>T?1:0;
                                              
                    // cout << " before cefMAXNew>T = " << tempSt.DCirCef<< endl;

//                    if ( cefMAXNew>T ) {
                    if ( tempSt.DCirCef >T ) {
                        //-//  cout << " inside cefMaxnew>T " << endl;
                        mxSetFieldByNumber(clust, n, cId.xy, mxDuplicateArray(xymerged));
                        *mxGetPr(mxGetFieldByNumber(clust, n, cId.DCirCef)) = tempSt.DCirCef;
                        *mxGetPr(mxGetFieldByNumber(clust, n, cId.maxDist)) =  tempSt.maxDist;
                        *mxGetPr(mxGetFieldByNumber(clust, n, cId.IntCef)) =   tempSt.IntCef;
                        mxSetFieldByNumber(clust, n, cId.outMAXPointList, mxDuplicateArray(tempSt.outMAXPointList));                                                                        
                        
                        mxSetFieldByNumber(clust, n, cId.maxListNew, mxDuplicateArray(tempSt.maxListNew));                        
                        
                        mxSetFieldByNumber(clust, n, cId.maxValueNew, mxDuplicateArray(tempSt.maxValueNew)); 
                                                                        
                        *mxGetLogicals(mxGetFieldByNumber(clust, n, cId.modified)) = true;

                        mxSetFieldByNumber(clust, m, cId.xy, mxCreateDoubleMatrix(0,0,mxREAL)); // ???
                        //clust(m).xy = [];
                        
                        break_loop = true;
                        break_while = false;
                    }
                                            
                    mxDestroyArray(xymerged);
                    mxDestroyArray(tempSt.outMAXPointList);
                    mxDestroyArray(tempSt.maxValueNew);                                            
                    //mxDestroyArray(tempSt.maxValueNew);
                    mxDestroyArray(tempSt.maxListNew);
                    mxDestroyArray(tempSt.xy);

                }
				
				if ( break_loop ) // % Exit from for loop
					break;
            }
                            
            if ( break_loop ) // % Exit from for loop
                break;
        
        }
    
        //-// cout << " Outside for loops" << endl;
    
        if ( break_while ) // % Exit from while loop
            break;
                 
    }
    
   

    outK = 0;

    for (int n=0; n<numC; n++){
        if ( !mxIsEmpty((mxGetFieldByNumber(clust, n, cId.xy))) ) 
            outK = outK + 1;
    }
    //-// cout << "outK = " << outK << endl;
    mwSize dimsout[] = {1, outK};
    plhs[0] =  mxCreateStructArray(2, dimsout, nfields, fnames);
    // ----------
    plhs[1] = mxCreateDoubleScalar(outK);

    outK = 0;
    for (int n=0; n<numC; n++){
        if ( !mxIsEmpty((mxGetFieldByNumber(clust, n, cId.xy))) ) {

            mxSetFieldByNumber(plhs[0], outK, cId.xy, mxDuplicateArray(mxGetFieldByNumber(clust, n, cId.xy)));
            // clustOut(outK).xy = clust(n).xy;

            mxSetFieldByNumber(plhs[0], outK, cId.grp, mxDuplicateArray(mxGetFieldByNumber(clust, n, cId.grp)));
            mxSetFieldByNumber(plhs[0], outK, cId.Tmean, mxDuplicateArray(mxGetFieldByNumber(clust, n, cId.Tmean)));
            mxSetFieldByNumber(plhs[0], outK, cId.Tvar, mxDuplicateArray(mxGetFieldByNumber(clust, n, cId.Tvar)));
            mxSetFieldByNumber(plhs[0], outK, cId.Tcef, mxDuplicateArray(mxGetFieldByNumber(clust, n, cId.Tcef)));


            mxSetFieldByNumber(plhs[0], outK, cId.DCirCef, mxDuplicateArray(mxGetFieldByNumber(clust, n, cId.DCirCef)));
            //clustOut(outK).DCirCef =  clust(n).DCirCef;

            mxSetFieldByNumber(plhs[0], outK, cId.maxDist, mxDuplicateArray(mxGetFieldByNumber(clust, n, cId.maxDist)));
            //clustOut(outK).maxDist =  clust(n).maxDist;


            mxSetFieldByNumber(plhs[0], outK, cId.IntCef, mxDuplicateArray(mxGetFieldByNumber(clust, n, cId.IntCef)));
            //clustOut(outK).IntCef =  clust(n).IntCef;

            mxSetFieldByNumber(plhs[0], outK, cId.outMAXPointList, mxDuplicateArray(mxGetFieldByNumber(clust, n, cId.outMAXPointList)));
            //clustOut(outK).outMAXPointList =  clust(n).outMAXPointList;

            mxSetFieldByNumber(plhs[0], outK, cId.maxListNew, mxDuplicateArray(mxGetFieldByNumber(clust, n, cId.maxListNew)));
            //clustOut(outK).maxListNew =  clust(n).maxListNew;

            mxSetFieldByNumber(plhs[0], outK, cId.maxValueNew, mxDuplicateArray(mxGetFieldByNumber(clust, n, cId.maxValueNew)));
            //clustOut(outK).maxValueNew =  clust(n).maxValueNew;

            mwSize d[]={1,1};
            mxArray *m = mxCreateLogicalArray(2,d);
            mxLogical *p = mxGetLogicals(m);
            *p = false;
            mxSetFieldByNumber(plhs[0], outK, cId.modified, mxDuplicateArray(m));
            
            mxDestroyArray(m);
            //clustOut(outK).modified=false;
            outK = outK + 1;
        }
    }

    mxDestroyArray(emptyArr);
    mxDestroyArray(clust);
    mxDestroyArray(statInfo);
    //mxFree(classIDflags);
    return;
}
