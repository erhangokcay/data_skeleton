#ifndef _CPP_cef_local_radius_func_
#define _CPP_cef_local_radius_func_


#include <algorithm>
#include <vector>
#include <cmath>
#include <limits>  

using namespace std;

double cef_similarity ( double *cell1,  double *outMAXDist,  double *cefSUMOld, double *cefMAXOld, double *maxValuePrev, double *maxListPrev, double *xpnew, mwSize xpnewIndex, mwSize Ncell1Curr, mwSize Ncell1Prev, mwSize Nfeat, double *cv, double *cvinv, double cvdet, double *mean, double *cefSUMNew , mwSize Ncell1New, double *maxValueNew, double *maxListNew, mwSize flag ){
    double pi = 3.1415926535;
	
	double const1 = (1.0/( pow(2.0*pi,(Nfeat/2.0))*sqrt(cvdet) ));
	//double const2 = ((Ncell1Prev*(Ncell1Prev-1))/2.0);
	double const2 = Ncell1New*(Ncell1New-1);
	double const2Prev = 0;
	 
	// if flag = 0 => NCell1New = NCell1Curr 
	 	 
	if ( flag != 0 ) {		
		const2Prev = Ncell1Prev*(Ncell1Prev-1);
	}
	
	// cout << "Nnew" << Ncell1New << " " << "Nprev" << Ncell1Prev << endl;
	
    double *cell, *cellTemp1, *cellTemp2, sumMAXNew, temp;
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
    
    sumMAXNew = 0.0;
	
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
	int maxLoc;
	// cout << "Ncell1Prev=" << Ncell1Prev << " Ncell1New=" << Ncell1New << endl;
	if ( Ncell1Curr <= 1 && flag == 0 ) {
        maxListNew[0] = 0;
        *cefSUMNew = DBL_MAX;
        return DBL_MAX;
    }
	
	if ( Ncell1New == 1 && flag == 1 ) { // Remove a point and a single point left
        maxListNew[0] = 0;
        *cefSUMNew = DBL_MAX;
        return DBL_MAX;
    }	
	
		
	if ( flag == 0 ) {
		*outMAXDist  = 0.0;
		for (i=0;i<Ncell1Curr;i++) {
			
			//for (k=0;k<Nfeat;k++){
			//	mexPrintf("cell1=%e \n",cell1[i*Nfeat+k]);
			//}
			
			// Find the maximum distant point 
			double maxDist = 0.0;
			maxLoc = -1;
			double cefMAXtemp=0.0;
			// Multiple calculations. Start from i+1. It will be faster. 10-04-2020
			// 12.04.2020. i+1 is not good. In that case the other side is not counted as 
			// a farthest point
			for (j=0;j<Ncell1Curr;j++) { 
			
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
					temp = 	exp(-0.5*temp);
					//cout << "SUMCEF=" << sumCEF  <<"-" << exp(-0.5*temp)<< endl;					
					sumCEF += temp;  
					//cout << "SUMCEF=" << sumCEF  <<"-" << exp(-0.5*temp)<< endl;					
				// *********************************************
			
				// Dont measure distance to itself
				
					double dist = 0.0;
					for (k=0;k<Nfeat;k++){			
						dist += pow(cell1[i*Nfeat+k] - cell1[j*Nfeat+k],2) ;				
					}	
					double distS = sqrt(dist);
					if ( distS >= maxDist ) {
						maxDist = distS;
						maxLoc = j;
						cefMAXtemp = temp;
					}										
				}
			}
			
			if ( maxLoc>= Ncell1Curr) cout << "maxLoc1 Error SKELETON:" << maxLoc << endl;
			if ( i>= Ncell1Curr) cout << "Index Error SKELETON:" << i << endl;
			if ( maxLoc < 0) cout << "maxLoc2 Error SKELETON:" << maxLoc << endl;
			
			maxListNew[i] = maxLoc;
			maxValueNew[i] = maxDist;
			
			if ( maxDist >= *outMAXDist ) {
				*outMAXDist = maxDist;
			}
			// The maximum distant point is at maxLoc. Find cefMAX 
			
			// maxLoc = maxListNew[i];
			
			/*
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
			*/			
			// sumMAXNew += exp(-0.5*temp);  
			
			sumMAXNew += cefMAXtemp;
			
			//cout << "cefMAXNew=" << (const1*(sumMAXNew))/Ncell1New << " " << cefMAXtemp << endl;

			// cout << "cefMAXTemp=" << cefMAXtemp << " " << sumMAXNew << endl;
		}
	
	} else {
		
		// Copy old value to new ones
		if ( flag == 2 ) { // Point added  : Ncell1New = Ncell1Prev + 1
			for (j=0;j<Ncell1Prev;j++) { 
			    // cout << "LOOP=" << maxValuePrev[j] << " " << maxListPrev[j] << endl;
				maxValueNew[j] = maxValuePrev[j];
				maxListNew[j] = maxListPrev[j];
			}				
		} else if ( flag == 1 ) { // Point removed				
			// Copy Prev to New except xpnew Point (xpnewIndex). New list is shorter
			int t=0;
			for (j=0;j<Ncell1Prev;j++) { 
				if ( j != xpnewIndex ) {					
					maxValueNew[t] = maxValuePrev[j];
					maxListNew[t] = maxListPrev[j];
					t++;
				}
			}						
		}
		
		// Old value without constants
		// sumMAXNew = ((*cefMAXOld) * Ncell1Prev) / const1;
		
		double maxDistTemp=0.0;
		int maxLocTemp = -1;
		double sumCEFPoint = 0.0;
		// cout << " Ncell1Curr=" << Ncell1Curr << " " << "Ncell1Prev=" << Ncell1Prev << endl;
		for (j=0;j<Ncell1Curr;j++) { 
			
			// **********************************************
			// Calculate cef from xpnew to other points
			for (k=0;k<Nfeat;k++){				
				cellTemp1[k] = cell1[j*Nfeat+k];
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
			//cout << "SUMCEF=" << sumCEF  <<"-" << exp(-0.5*temp)<< endl;	
			temp = exp(-0.5*temp); 
			sumCEF += temp;  			// The contribution of the new point to the total sum
			
			// Measure distance from xpnew to all the points
			if ( flag == 2 ) { // Point added
				double distTemp = 0.0;
				for (k=0;k<Nfeat;k++){			
					distTemp += pow(xpnew[k] - cell1[j*Nfeat+k],2) ;				
				}	
				double distS = sqrt(distTemp);
				if ( distS >= maxDistTemp ) {
					maxDistTemp = distS;
					maxLocTemp = j;
					// sumCEFPoint = temp;  // The contribution of the new point to the MAX sum
				}
								
				// The new distance is greater for the point-j
//				if ( distTemp > maxValuePrev[j] ) {
				if ( distS > maxValuePrev[j] ) {
					/*
					double oldValue;
					// Calculate the old cef distance from j --> tempIndex (max point from j)
					int tempIndex = maxListPrev[j];
					for (k=0;k<Nfeat;k++){				
						cellTemp1[k] = cell1[j*Nfeat+k];
					}			           
					
					for (k=0;k<Nfeat;k++){				
					   cell[k] = (cell1[tempIndex*Nfeat+k] - cellTemp1[k]) - mean[k];
					}
					
					// CALCULATE cell * cvinv * cell'
					for (h=0;h<Nfeat;h++){
						oldValue = 0.0;
						for (k=0;k<Nfeat;k++){
							oldValue += cell[k]*cvinv[h*Nfeat+k];
						}	
						cellTemp2[h] = oldValue;				
					}			
					oldValue = 0.0;
					for (k=0;k<Nfeat;k++){
						oldValue += cellTemp2[k]*cell[k];				
					}            
					//cout << "SUMCEF=" << sumCEF  <<"-" << exp(-0.5*temp)<< endl;	
					oldValue = exp(-0.5*oldValue); 
					cout << "sumMAXNew1=" << sumMAXNew << " " << temp << " " << oldValue << endl;					
					cout << sumMAXNew - oldValue + temp << endl;
					cout << sumMAXNew + temp - oldValue  << endl;
					// Remove old value and add the new one for Point j
					sumMAXNew = sumMAXNew-oldValue+temp;
					cout << "sumMAXNew2=" << sumMAXNew << " " << temp << " " << oldValue << endl;
					//maxValueNew[j] = distTemp;
					*/
					maxValueNew[j] = distS;
					maxListNew[j] = Ncell1New-1;  // location of xpnew										
				}	
				
				if ( maxValueNew[j] >= *outMAXDist ) {
					*outMAXDist = maxValueNew[j];
				}
	
			} else if ( flag == 1 ) { // Point removed		
				// cout << "maxListNew=" << i << " " << maxListNew[j] << endl;	
					// If the xpnew is used in the list, we have to remove it and recalculate the maximum point for that point
				if ( maxListNew[j] > xpnewIndex ) {	 // The indexes after xpnewIndex should be decremented by one. We are missing one point.
					maxListNew[j] = maxListNew[j] - 1;
				} else if ( maxListNew[j] == xpnewIndex ) {
					double maxDistZ = 0.0;
					int maxLocZ = 0;
					
					/*
					// **********************************************
					// Calculate cef from each point to other points
					for (k=0;k<Nfeat;k++){				
						cellTemp1[k] = cell1[j*Nfeat+k];
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
					double tempZ = 0.0;
					for (k=0;k<Nfeat;k++){
						tempZ += cellTemp2[k]*cell[k];				
					}            
					//cout << "SUMCEF=" << sumCEF  <<"-" << exp(-0.5*temp)<< endl;					
					double sumCEFz = exp(-0.5*tempZ);  
					*/
					
					// cout << "SUMCEFz=" << sumCEFz  << endl;					
				// *********************************************
					
				// Dont measure distance to itself
					for (int z=0;z<Ncell1Curr;z++) { 			
						if ( z != j ) {						
							double distZ = 0.0;
							for (k=0;k<Nfeat;k++){			
								distZ += pow(cell1[z*Nfeat+k] - cell1[j*Nfeat+k],2) ;				
							}	
							distZ = sqrt(distZ);
							if ( distZ >= maxDistZ ) {
								maxDistZ = distZ;
								maxLocZ = z;
							}
						}
					}
					
					
					/*
					for (k=0;k<Nfeat;k++){				
						cellTemp1[k] = cell1[j*Nfeat+k];
					}			           
					
					for (k=0;k<Nfeat;k++){				
					   cell[k] = (cell1[maxLocZ*Nfeat+k] - cellTemp1[k]) - mean[k];
					}
					
					// CALCULATE cell * cvinv * cell'
					for (h=0;h<Nfeat;h++){
						temp = 0.0;
						for (k=0;k<Nfeat;k++){
							temp += cell[k]*cvinv[h*Nfeat+k];
						}	
						cellTemp2[h] = temp;				
					}			
					tempZ = 0.0;
					for (k=0;k<Nfeat;k++){
						tempZ += cellTemp2[k]*cell[k];				
					}   

										
					//cout << "SUMCEF=" << sumCEF  <<"-" << exp(-0.5*temp)<< endl;					
					double sumCEFzNew = exp(-0.5*tempZ);  
					// cout << "SUMCEFzNew=" << sumCEFzNew  << endl;			
					*/
					// sumMAXNew = sumMAXNew-sumCEFz+sumCEFzNew;
					// Update the Point-j with new maximum values
					maxListNew[j]  = maxLocZ;
					maxValueNew[j]  = maxDistZ;	
				}
				
				// calculate maximum distance
							
				if ( maxValueNew[j] >= *outMAXDist ) {
					*outMAXDist = maxValueNew[j];
				}
			}			
		}
				
		if ( flag == 2 ) { // Point added  : Ncell1New = Ncell1Prev + 1

			// cout << "maxLoc SKELETON:" << maxLocTemp << endl;

			// maxList CEF calculations
			// Update maxList for xpnew.
			maxValueNew[Ncell1New-1] = maxDistTemp;
			maxListNew[Ncell1New-1] = maxLocTemp;
			
			// The contribution of the new point xpnew
			// sumMAXNew += sumCEFPoint;
								
		} else if ( flag == 1 ) { // Point removed  : Ncell1New = Ncell1Prev - 1
			
			// The contribution of the old point xpnew is removed
			// sumMAXNew -= sumCEFPoint;
		}
		
		// Total CEF calculation
	    // cout << "sumCEFPREV=" << (*cefSUMOld)*const2Prev/const1 << endl;

		if ( flag == 2 ) 
			sumCEF = (*cefSUMOld)*const2Prev/const1 + 2*sumCEF;
		else // flag = 1
			sumCEF = (*cefSUMOld)*const2Prev/const1 - 2*sumCEF;
	} 	
	
	delete [] cell;
	delete [] cellTemp1;
	delete [] cellTemp2;
	
	cellTemp1 = NULL;	
	cell = NULL;
	cellTemp2 = NULL;
    
	//cout << "COEF=" << (1/( pow(2*pi,(Nfeat/2.0))*sqrt(cvdet) )) << endl;
    // cout << "sumCEF=" << sumCEF << endl;
	
	*cefSUMNew = const1*sumCEF/const2; // This from N points to N points
    return (const1*sumMAXNew)/Ncell1New; // This is calculated once for each point cefMAXNew
    //return 0; // This is calculated once for each point cefMAXNew
    //return (sum) /(Ncell1Prev+len2);
        
}
#endif