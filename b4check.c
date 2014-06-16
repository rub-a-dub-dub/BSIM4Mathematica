/**** BSIM4.7.0 Released by Darsen Lu 04/08/2011 ****/

/**********
 * Copyright 2006 Regents of the University of California. All rights reserved.
 * File: b4check.c of BSIM4.7.0.
 * Author: 2000 Weidong Liu
 * Authors: 2001- Xuemei Xi, Mohan Dunga, Ali Niknejad, Chenming Hu.
 * Authors: 2006- Mohan Dunga, Ali Niknejad, Chenming Hu
 * Authors: 2007- Mohan Dunga, Wenwei Yang, Ali Niknejad, Chenming Hu
 * Project Director: Prof. Chenming Hu.
 * Modified by Xuemei Xi, 04/06/2001.
 * Modified by Xuemei Xi, 10/05/2001.
 * Modified by Xuemei Xi, 11/15/2002.
 * Modified by Xuemei Xi, 05/09/2003.
 * Modified by Xuemei Xi, 03/04/2004.
 * Modified by Xuemei Xi, 07/29/2005.
 * Modified by Mohan Dunga, 12/13/2006
 * Modified by Mohan Dunga, Wenwei Yang, 05/18/2007.
 * Modified by  Wenwei Yang, 07/31/2008 .
 * Modified by Tanvir Morshed, Darsen Lu 03/27/2011
 **********/

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "bsim4def.h"
#include "mydefs.h"
#include "mathlink.h"

#define ERRPRINTF(x) strcat( totalErrors, x )

int
BSIM4checkModel(model, here)
register BSIM4model *model;
register BSIM4instance *here;
{
	struct bsim4SizeDependParam *pParam;
	int Fatal_Flag = 0;
	char* totalErrors = (char *) malloc( sizeof(char)*10000 );
    strcat( totalErrors, "Print[\"" );


	pParam = here->pParam;
	ERRPRINTF("BSIM4: Berkeley Short Channel IGFET Model-4\n");
	ERRPRINTF("Developed by Xuemei (Jane) Xi, Mohan Dunga, Prof. Ali Niknejad and Prof. Chenming Hu in 2003.\n");
	ERRPRINTF("++++++++++ BSIM4 PARAMETER CHECKING BELOW ++++++++++\n");
	
	if ((here->BSIM4rgateMod == 2) || (here->BSIM4rgateMod == 3))
	{   if ((here->BSIM4trnqsMod == 1) || (here->BSIM4acnqsMod == 1))
	{   
		ERRPRINTF("Warning: You've selected both Rg and charge deficit NQS; select one only.\n");
	}
	}
	
	if (model->BSIM4toxp <= 0.0)
	{   
		ERRPRINTF("Fatal: Toxp is not positive.\n");
		Fatal_Flag = 1;
	}
	if (model->BSIM4eot <= 0.0)
	{
		ERRPRINTF("Fatal: EOT is not positive.\n");
		Fatal_Flag = 1;
	}
	if (model->BSIM4epsrgate < 0.0)
	{   
		ERRPRINTF("Fatal: Epsrgate is not positive.\n");
		Fatal_Flag = 1;
	}
	if (model->BSIM4epsrsub < 0.0)
	{
		ERRPRINTF("Fatal: Epsrsub is not positive.\n");
		Fatal_Flag = 1;
	}
	if (model->BSIM4easub < 0.0)
	{
		ERRPRINTF("Fatal: Easub is not positive.\n");
		Fatal_Flag = 1;
	}
	if (model->BSIM4ni0sub <= 0.0)
	{   
		ERRPRINTF("Fatal: Easub is not positive.\n");
		Fatal_Flag = 1;
	}
	
	if (model->BSIM4toxm <= 0.0)
	{   
		ERRPRINTF("Fatal: Toxm is not positive.\n");
		Fatal_Flag = 1;
	}
	
	if (model->BSIM4toxref <= 0.0)
	{  
		ERRPRINTF("Fatal: Toxref is not positive.\n");
		Fatal_Flag = 1;
	}
	
	if (pParam->BSIM4lpe0 < -pParam->BSIM4leff)
	{   
		ERRPRINTF("Fatal: Lpe0 is less than -Leff.\n");
		Fatal_Flag = 1;
	}
	if (model->BSIM4lintnoi > pParam->BSIM4leff/2)
	{   
		ERRPRINTF("Fatal: Lintnoi is too large - Leff for noise is negative.\n");
		Fatal_Flag = 1;
	}
	if (pParam->BSIM4lpeb < -pParam->BSIM4leff)
	{   
		ERRPRINTF("Fatal: Lpeb is less than -Leff.\n");
		Fatal_Flag = 1;
	}
	if (pParam->BSIM4ndep <= 0.0)
	{  
		ERRPRINTF("Fatal: Ndep is not positive.\n");
		Fatal_Flag = 1;
	}
	if (pParam->BSIM4phi <= 0.0)
	{   
		ERRPRINTF("Fatal: Phi is not positive. Please check Phin and Ndep.\n");
		Fatal_Flag = 1;
	}
	if (pParam->BSIM4nsub <= 0.0)
	{   
		ERRPRINTF("Fatal: Nsub is not positive.\n");
		Fatal_Flag = 1;
	}
	if (pParam->BSIM4ngate < 0.0)
	{   
		ERRPRINTF("Fatal: Ngate is not positive.\n");
		Fatal_Flag = 1;
	}
	if (pParam->BSIM4ngate > 1.e25)
	{
		ERRPRINTF("Fatal: Ngate is too high\n");
		Fatal_Flag = 1;
	}
	if (pParam->BSIM4xj <= 0.0)
	{   
		ERRPRINTF("Fatal: Xj is not positive.\n");
		Fatal_Flag = 1;
	}
	
	if (pParam->BSIM4dvt1 < 0.0)
	{   
		ERRPRINTF("Fatal: Dvt1 is negative.\n");   
		Fatal_Flag = 1;
	}
	
	if (pParam->BSIM4dvt1w < 0.0)
	{
		ERRPRINTF("Fatal: Dvt1w is negative.\n");
		Fatal_Flag = 1;
	}
	
	if (pParam->BSIM4w0 == -pParam->BSIM4weff)
	{
		ERRPRINTF("Fatal: (W0 + Weff) = 0 causing divided-by-zero.\n");
		Fatal_Flag = 1;
	}   
	
	if (pParam->BSIM4dsub < 0.0)
	{
		ERRPRINTF("Fatal: Dsub is negative.\n");
		Fatal_Flag = 1;
	}
	if (pParam->BSIM4b1 == -pParam->BSIM4weff)
	{
		ERRPRINTF("Fatal: (B1 + Weff) = 0 causing divided-by-zero.\n");
		Fatal_Flag = 1;
	}  
	if (here->BSIM4u0temp <= 0.0)
	{
		ERRPRINTF("Fatal: u0 at current temperature is not positive.\n");
		Fatal_Flag = 1;
	}
	
	if (pParam->BSIM4delta < 0.0)
	{
		ERRPRINTF("Fatal: Delta is less than zero.\n");
		Fatal_Flag = 1;
	}      
	
	if (here->BSIM4vsattemp <= 0.0)
	{
		ERRPRINTF("Fatal: Vsat at current temperature is not positive.\n");
		Fatal_Flag = 1;
	}
	
	if (pParam->BSIM4pclm <= 0.0)
	{
		ERRPRINTF("Fatal: Pclm is not positive.\n");
		Fatal_Flag = 1;
	}
	
	if (pParam->BSIM4drout < 0.0)
	{
		ERRPRINTF("Fatal: Drout is negative.\n");
		Fatal_Flag = 1;
	}
	
	if (here->BSIM4nf < 1.0)
	{
		ERRPRINTF("Fatal: Number of finger is smaller than one.\n");
		Fatal_Flag = 1;
	}
	
	if((here->BSIM4sa > 0.0) && (here->BSIM4sb > 0.0) && 
	   ((here->BSIM4nf == 1.0) || ((here->BSIM4nf > 1.0) && (here->BSIM4sd > 0.0))) )
	{   
		if (model->BSIM4saref <= 0.0)
		{
			ERRPRINTF("Fatal: SAref is not positive.\n");
			Fatal_Flag = 1;
		}
		if (model->BSIM4sbref <= 0.0)
		{
			ERRPRINTF("Fatal: SBref is not positive.\n");
			Fatal_Flag = 1;
		}
	}
	
	if ((here->BSIM4l + model->BSIM4xl) <= model->BSIM4xgl)
	{
		ERRPRINTF("Fatal: The parameter xgl must be smaller than Ldrawn+XL.\n");
		Fatal_Flag = 1;
	}
	if (here->BSIM4ngcon < 1.0)
	{
		ERRPRINTF("Fatal: The parameter ngcon cannot be smaller than one.\n");
		Fatal_Flag = 1;
	}
	if ((here->BSIM4ngcon != 1.0) && (here->BSIM4ngcon != 2.0))
	{   
		here->BSIM4ngcon = 1.0;
		ERRPRINTF("Warning: Ngcon must be equal to one or two; reset to 1.0.\n");
	}
	
	if (model->BSIM4gbmin < 1.0e-20)
	{
		ERRPRINTF("Warning: Gbmin is too small.\n");
	}
	
	/* Check saturation parameters */
	if (pParam->BSIM4fprout < 0.0)
	{
		ERRPRINTF("Fatal: fprout is negative.\n");
		Fatal_Flag = 1;
	}
	if (pParam->BSIM4pdits < 0.0)
	{
		ERRPRINTF("Fatal: pdits is negative.\n");
		Fatal_Flag = 1;
	}
	if (model->BSIM4pditsl < 0.0)
	{
		ERRPRINTF("Fatal: pditsl is negative.\n");
		Fatal_Flag = 1;
	}
	
	/* Check gate current parameters */
	if (model->BSIM4igbMod) {
		if (pParam->BSIM4nigbinv <= 0.0)
		{
			ERRPRINTF("Fatal: nigbinv is non-positive.\n");
			Fatal_Flag = 1;
		}
		if (pParam->BSIM4nigbacc <= 0.0)
		{
			ERRPRINTF("Fatal: nigbacc is non-positive.\n");
			Fatal_Flag = 1;
		}
	}
	if (model->BSIM4igcMod) {
		if (pParam->BSIM4nigc <= 0.0)
		{
			ERRPRINTF("Fatal: nigc is non-positive.\n");
			Fatal_Flag = 1;
		}
		if (pParam->BSIM4poxedge <= 0.0)
		{
			ERRPRINTF("Fatal: poxedge is non-positive.\n");
			Fatal_Flag = 1;
		}
		if (pParam->BSIM4pigcd <= 0.0)
		{
			ERRPRINTF("Fatal: pigcd is non-positive.\n");
			Fatal_Flag = 1;
		}
	}
	
	/* Check capacitance parameters */
	if (pParam->BSIM4clc < 0.0)
	{
		ERRPRINTF("Fatal: Clc is negative.\n");
		Fatal_Flag = 1;
	}      
	
	/* Check overlap capacitance parameters */
	if (pParam->BSIM4ckappas < 0.02)
	{
		ERRPRINTF("Warning: ckappas is too small.\n");
		pParam->BSIM4ckappas = 0.02;
	}
	if (pParam->BSIM4ckappad < 0.02)
	{
		ERRPRINTF("Warning: ckappad is too small.\n");
		pParam->BSIM4ckappad = 0.02;
	}
	
	if (model->BSIM4vtss < 0.0)
	{
		ERRPRINTF("Fatal: Vtss is negative.\n");
		Fatal_Flag = 1;
	}
	if (model->BSIM4vtsd < 0.0)
	{
		ERRPRINTF("Fatal: Vtsd is negative.\n");
		Fatal_Flag = 1;
	}
	if (model->BSIM4vtssws < 0.0)
	{   
		ERRPRINTF("Fatal: Vtssws is negative.\n");
		Fatal_Flag = 1;
	}
	if (model->BSIM4vtsswd < 0.0)
	{
		ERRPRINTF("Fatal: Vtsswd is negative.\n");
		Fatal_Flag = 1;
	}
	if (model->BSIM4vtsswgs < 0.0)
	{
		ERRPRINTF("Fatal: Vtsswgs is negative.\n");
		Fatal_Flag = 1;
	}
	if (model->BSIM4vtsswgd < 0.0)
	{
		ERRPRINTF("Fatal: Vtsswgd is negative.\n");
		Fatal_Flag = 1;
	}
	
	
	if (model->BSIM4paramChk ==1)
	{
		/* Check L and W parameters */ 
		if (pParam->BSIM4leff <= 1.0e-9)
		{
			ERRPRINTF("Warning: Leff <= 1.0e-9. Recommended Leff >= 1e-8\n");
		}    
		
		if (pParam->BSIM4leffCV <= 1.0e-9)
		{
			ERRPRINTF("Warning: Leff for CV <= 1.0e-9. Recommended LeffCV >=1e-8\n");
		}  
		
		if (pParam->BSIM4weff <= 1.0e-9)
		{
			ERRPRINTF("Warning: Weff <= 1.0e-9. Recommended Weff >=1e-7 \n");
		}             
		
		if (pParam->BSIM4weffCV <= 1.0e-9)
		{
			ERRPRINTF("Warning: Weff for CV <= 1.0e-9. Recommended WeffCV >= 1e-7\n");
		}        
		
		/* Check threshold voltage parameters */
		if (model->BSIM4toxe < 1.0e-10)
		{
			ERRPRINTF("Warning: Toxe is less than 1A. Recommended Toxe >= 5A\n");
		}
		if (model->BSIM4toxp < 1.0e-10)
		{
			ERRPRINTF("Warning: Toxp is less than 1A. Recommended Toxp >= 5A\n");
		}
		if (model->BSIM4toxm < 1.0e-10)
		{
			ERRPRINTF("Warning: Toxm is less than 1A. Recommended Toxm >= 5A\n");
		}
		
		if (pParam->BSIM4ndep <= 1.0e12)
		{
			ERRPRINTF("Warning: Ndep may be too small.\n");
		}
		else if (pParam->BSIM4ndep >= 1.0e21)
		{
			ERRPRINTF("Warning: Ndep may be too large.\n");
		}
		
		if (pParam->BSIM4nsub <= 1.0e14)
		{
			ERRPRINTF("Warning: Nsub may be too small.\n");
		}
		else if (pParam->BSIM4nsub >= 1.0e21)
		{
			ERRPRINTF("Warning: Nsub may be too large.\n");
		}
		
		if ((pParam->BSIM4ngate > 0.0) &&
			(pParam->BSIM4ngate <= 1.e18))
		{
			ERRPRINTF("Warning: Ngate is less than 1.E18cm^-3.\n");
		}
		
		if (pParam->BSIM4dvt0 < 0.0)
		{
			ERRPRINTF("Warning: Dvt0 is negative.\n");   
		}
		
		if (fabs(1.0e-8 / (pParam->BSIM4w0 + pParam->BSIM4weff)) > 10.0)
		{
			ERRPRINTF("Warning: (W0 + Weff) may be too small.\n");
		}
		
		/* Check subthreshold parameters */
		if (pParam->BSIM4nfactor < 0.0)
		{
			ERRPRINTF("Warning: Nfactor is negative.\n");
		}
		if (pParam->BSIM4cdsc < 0.0)
		{
			ERRPRINTF("Warning: Cdsc is negative.\n");
		}
		if (pParam->BSIM4cdscd < 0.0)
		{
			ERRPRINTF("Warning: Cdscd is negative.\n");
		}
		/* Check DIBL parameters */
		if (here->BSIM4eta0 < 0.0)
		{ 
			ERRPRINTF("Warning: Eta0 is negative.\n"); 
		}
		
		/* Check Abulk parameters */	    
		if (fabs(1.0e-8 / (pParam->BSIM4b1 + pParam->BSIM4weff)) > 10.0)
		{
			ERRPRINTF("Warning: (B1 + Weff) may be too small.\n");
		}    
		
		
		/* Check Saturation parameters */
		if (pParam->BSIM4a2 < 0.01)
		{
			ERRPRINTF("Warning: A2 is too small. Set to 0.01.\n");
			pParam->BSIM4a2 = 0.01;
		}
		else if (pParam->BSIM4a2 > 1.0)
		{
			ERRPRINTF("Warning: A2 is larger than 1. A2 is set to 1 and A1 is set to 0.\n");
			pParam->BSIM4a2 = 1.0;
			pParam->BSIM4a1 = 0.0;
		}
		
		if (pParam->BSIM4prwg < 0.0)
		{
			ERRPRINTF("Warning: Prwg is negative. Set to zero.\n");
			pParam->BSIM4prwg = 0.0;
		}
		
		if (pParam->BSIM4rdsw < 0.0)
		{
			ERRPRINTF("Warning: Rdsw is negative. Set to zero.\n");
			pParam->BSIM4rdsw = 0.0;
			pParam->BSIM4rds0 = 0.0;
		}
		
		if (pParam->BSIM4rds0 < 0.0)
		{
			ERRPRINTF("Warning: Rds at current temperature is negative. Set to zero.\n");
			pParam->BSIM4rds0 = 0.0;
		}
		
		if (pParam->BSIM4rdswmin < 0.0)
		{
			ERRPRINTF("Warning: Rdswmin at current temperature is negative. Set to zero.\n");
			pParam->BSIM4rdswmin = 0.0;
		}
		
		if (pParam->BSIM4pscbe2 <= 0.0)
		{
			ERRPRINTF("Warning: Pscbe2 is not positive.\n");
		}
		
		if (pParam->BSIM4vsattemp < 1.0e3)
		{
			ERRPRINTF("Warning: Vsat at current temperature may be too small.\n");
		}
		
		if((model->BSIM4lambdaGiven) && (pParam->BSIM4lambda > 0.0) ) 
		{
			if (pParam->BSIM4lambda > 1.0e-9)
			{
				ERRPRINTF("Warning: Lambda may be too large.\n");
			}
		}
		
		if((model->BSIM4vtlGiven) && (pParam->BSIM4vtl > 0.0) )
		{  
			if (pParam->BSIM4vtl < 6.0e4)
			{
				ERRPRINTF("Warning: Thermal velocity vtl may be too small.\n");
			}
			
			if (pParam->BSIM4xn < 3.0)
			{
				ERRPRINTF("Warning: back scattering coeff xn is too small. Reset to 3.0.\n");
				pParam->BSIM4xn = 3.0;
			}
			
			if (model->BSIM4lc < 0.0)
			{
				ERRPRINTF("Warning: back scattering coeff lc is too small. Reset to 0.0\n");
				pParam->BSIM4lc = 0.0;
			}
		}
		
		if (pParam->BSIM4pdibl1 < 0.0)
		{
			ERRPRINTF("Warning: Pdibl1 is negative.\n");
		}
		if (pParam->BSIM4pdibl2 < 0.0)
		{
			ERRPRINTF("Warning: Pdibl2 is negative.\n");
		}
		
		/* Check stress effect parameters */        
		if((here->BSIM4sa > 0.0) && (here->BSIM4sb > 0.0) && 
		   ((here->BSIM4nf == 1.0) || ((here->BSIM4nf > 1.0) && (here->BSIM4sd > 0.0))) )
		{   
			if (model->BSIM4lodk2 <= 0.0)
			{
				ERRPRINTF("Warning: LODK2 is not positive.\n");
			}
			if (model->BSIM4lodeta0 <= 0.0)
			{
				ERRPRINTF("Warning: LODETA0 is not positive.\n");
			}
		}
		
		/* Check gate resistance parameters */        
		if (here->BSIM4rgateMod == 1)
		{   if (model->BSIM4rshg <= 0.0)
			ERRPRINTF("Warning: rshg should be positive for rgateMod = 1.\n");
		}
		else if (here->BSIM4rgateMod == 2)
		{   if (model->BSIM4rshg <= 0.0)
				ERRPRINTF("Warning: rshg <= 0.0 for rgateMod = 2.\n");
			else if (pParam->BSIM4xrcrg1 <= 0.0)
				ERRPRINTF("Warning: xrcrg1 <= 0.0 for rgateMod = 2.\n");
		}
		if (here->BSIM4rgateMod == 3)
		{   if (model->BSIM4rshg <= 0.0)
				ERRPRINTF("Warning: rshg should be positive for rgateMod = 3.\n");
			else if (pParam->BSIM4xrcrg1 <= 0.0)
				ERRPRINTF("Warning: xrcrg1 should be positive for rgateMod = 3.\n");
		}
		
		/* Check capacitance parameters */
		if (pParam->BSIM4noff < 0.1)
		{
			ERRPRINTF("Warning: Noff is too small.\n");
		}
		
		if (pParam->BSIM4voffcv < -0.5)
		{
			ERRPRINTF("Warning: Voffcv is too small.\n");
		}
		if (pParam->BSIM4moin < 5.0)
		{
			ERRPRINTF("Warning: Moin is too small.\n");
		}
		if (pParam->BSIM4moin > 25.0)
		{
			ERRPRINTF("Warning: Moin is too large.\n");
		}
		if(model->BSIM4capMod ==2) {
			if (pParam->BSIM4acde < 0.1)
			{
				ERRPRINTF("Warning: Acde is too small.\n");
			}
			if (pParam->BSIM4acde > 1.6)
			{
				ERRPRINTF("Warning: Acde is too large.\n");
			}
		}
		
		/* Check overlap capacitance parameters */
		if (model->BSIM4cgdo < 0.0)
		{
			ERRPRINTF("Warning: cgdo is negative. Set to zero.\n");
			model->BSIM4cgdo = 0.0;
		}      
		if (model->BSIM4cgso < 0.0)
		{
			ERRPRINTF("Warning: cgso is negative. Set to zero.\n");
			model->BSIM4cgso = 0.0;
		}      
		if (model->BSIM4cgbo < 0.0)
		{
			ERRPRINTF("Warning: cgbo is negative. Set to zero.\n");
			model->BSIM4cgbo = 0.0;
		}      
		
		/* v4.7 */
		if (model->BSIM4tnoiMod == 1 || model->BSIM4tnoiMod == 2) { 
			if (model->BSIM4tnoia < 0.0) {   
				ERRPRINTF("Warning: tnoia is negative. Set to zero.\n");
				model->BSIM4tnoia = 0.0;
			}
			if (model->BSIM4tnoib < 0.0) {   
				ERRPRINTF("Warning: tnoib is negative. Set to zero.\n");
				model->BSIM4tnoib = 0.0;
			}
			if (model->BSIM4rnoia < 0.0) { 
				ERRPRINTF("Warning: rnoia is negative. Set to zero.\n");
				model->BSIM4rnoia = 0.0;
			}
			if (model->BSIM4rnoib < 0.0) {
				ERRPRINTF("Warning: rnoib is negative. Set to zero.\n");
				model->BSIM4rnoib = 0.0;
			}
		}
		
		/* v4.7 */
		if (model->BSIM4tnoiMod == 2) { 
			if (model->BSIM4tnoic < 0.0) {
				ERRPRINTF("Warning: tnoic is negative. Set to zero.\n");
				model->BSIM4tnoic = 0.0;
			}
			if (model->BSIM4rnoic < 0.0) {
				ERRPRINTF("Warning: rnoic is negative. Set to zero.\n");
				model->BSIM4rnoic = 0.0;
			}
		}
		
		/* Limits of Njs and Njd modified in BSIM4.7 */
		if (model->BSIM4SjctEmissionCoeff < 0.1) {
			ERRPRINTF("Warning: Njs is less than 0.1. Setting Njs to 0.1.\n");
			model->BSIM4SjctEmissionCoeff = 0.1;
		} 
		else if (model->BSIM4SjctEmissionCoeff < 0.7) { 
			ERRPRINTF("Warning: Njs is less than 0.7.\n");
		}
		if (model->BSIM4DjctEmissionCoeff < 0.1) { 
			ERRPRINTF("Warning: Njd is less than 0.1. Setting Njd to 0.1.\n");
			model->BSIM4DjctEmissionCoeff = 0.1;
		}
		else if (model->BSIM4DjctEmissionCoeff < 0.7) {
			ERRPRINTF("Warning: Njd is less than 0.7.\n");
		}
		
		if (model->BSIM4njtsstemp < 0.0)
		{
			ERRPRINTF("Warning: Njts is negative at circuit temperature.\n");
		}
		if (model->BSIM4njtsswstemp < 0.0)
		{
			ERRPRINTF("Warning: Njtssw is negative at circuit temperature.\n");
		}
		if (model->BSIM4njtsswgstemp < 0.0)
		{
			ERRPRINTF("Warning: Njtsswg is negative at circuit temperature.\n");
		}
		
		if (model->BSIM4njtsdGiven && model->BSIM4njtsdtemp < 0.0)
		{
			ERRPRINTF("Warning: Njtsd is negative at circuit temperature.\n");
		}
		if (model->BSIM4njtsswdGiven && model->BSIM4njtsswdtemp < 0.0)
		{
			ERRPRINTF("Warning: Njtsswd is negative at circuit temperature.\n");
		}
		if (model->BSIM4njtsswgdGiven && model->BSIM4njtsswgdtemp < 0.0)
		{
			ERRPRINTF("Warning: Njtsswgd is negative at circuit temperature.\n");
		}
		
		if (model->BSIM4ntnoi < 0.0)
		{
			ERRPRINTF("Warning: ntnoi is negative. Set to zero.\n");
			model->BSIM4ntnoi = 0.0;
		}
		
		/* diode model */
		if (model->BSIM4SbulkJctBotGradingCoeff >= 0.99)
		{
			ERRPRINTF("Warning: MJS is too big. Set to 0.99.\n");
			model->BSIM4SbulkJctBotGradingCoeff = 0.99;
		}
		if (model->BSIM4SbulkJctSideGradingCoeff >= 0.99)
		{
			ERRPRINTF("Warning: MJSWS is too big. Set to 0.99.\n");
			model->BSIM4SbulkJctSideGradingCoeff = 0.99;
		}
		if (model->BSIM4SbulkJctGateSideGradingCoeff >= 0.99)
		{
			ERRPRINTF("Warning: MJSWGS is too big. Set to 0.99.\n");
			model->BSIM4SbulkJctGateSideGradingCoeff = 0.99;
		}
		
		if (model->BSIM4DbulkJctBotGradingCoeff >= 0.99)
		{
			ERRPRINTF("Warning: MJD is too big. Set to 0.99.\n");
			model->BSIM4DbulkJctBotGradingCoeff = 0.99;
		}
		if (model->BSIM4DbulkJctSideGradingCoeff >= 0.99)
		{
			ERRPRINTF("Warning: MJSWD is too big. Set to 0.99.\n");
			model->BSIM4DbulkJctSideGradingCoeff = 0.99;
		}
		if (model->BSIM4DbulkJctGateSideGradingCoeff >= 0.99)
		{
			ERRPRINTF("Warning: MJSWGD is too big. Set to 0.99.\n");
			model->BSIM4DbulkJctGateSideGradingCoeff = 0.99;
		}
		if (model->BSIM4wpemod == 1)
		{
			if (model->BSIM4scref <= 0.0)
			{
				ERRPRINTF("Warning: SCREF is not positive. Set to 1e-6.\n");
				model->BSIM4scref = 1e-6;
			}
		}
	}/* loop for the parameter check for warning messages */      
    
	strcat( totalErrors, "\"];" );
	MLEvaluateString( stdlink, totalErrors );
    return(Fatal_Flag);
}

