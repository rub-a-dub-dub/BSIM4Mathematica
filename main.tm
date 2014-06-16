#include <stdio.h>
#include <stdlib.h>
#include "mydefs.h"
#include "mathlink.h"
#include "bsim4def.h"

#define PARAMS_MODELSELECTOR 24
#define PARAMS_PROCESSPARAMS 17
#define PARAMS_BASICMODEL 86
#define PARAMS_RDSMODEL 11
#define PARAMS_IMPACTIONIZATION 3
#define PARAMS_GIDL 14
#define PARAMS_GATETUNNELING 26
#define PARAMS_CHARGECAP 20
#define PARAMS_NOISE 15
#define PARAMS_RF 34
#define PARAMS_LAYOUTDEP 12
#define PARAMS_ASYMMETRY 63
#define PARAMS_TEMP 26
#define PARAMS_STRESS 24
#define PARAMS_WPE 10
#define PARAMS_DWDL 16
#define PARAMS_INSTANCES 12

#define ERROR 1
#define OK 0

#define TRUE 1
#define FALSE 0

#define CHECKPARLEN(x) if ( l_numElements != x ) { MLPRINTF( "Incorrect number of parameters passed." ); MLPutSymbol( stdlink, "$Failed" ); return ERROR; }

BSIM4model* mosModel = NULL;
BSIM4instance* mosInst = NULL;
struct bsim4SizeDependParam* mosParams = NULL;
CKTcircuit* mosCircuit = NULL;

int BSIM4checkModel( BSIM4model*, BSIM4instance* );

int main( int argc, char** argv ) {
	int retVal = 0;
	
	mosModel = (BSIM4model *) malloc( sizeof( BSIM4model ) );
	if ( !mosModel ) {
		printf("Cannot get memory for BSIM47 model.\n");
		return ERROR;
	}
	
	mosInst = (BSIM4instance *) malloc( sizeof( BSIM4instance ) );
	if ( !mosInst ) {
		printf("Cannot get memory for BSIM47 instance.\n");
		return ERROR;
	}
	
	mosCircuit = (CKTcircuit *) malloc( sizeof( CKTcircuit ) );
	if ( !mosCircuit ) {
		printf("Cannot get memory for BSIM47 circuit.\n");
		return ERROR;
	}
	
	mosParams = (struct bsim4SizeDependParam *) malloc( sizeof( struct bsim4SizeDependParam ) );
	if ( !mosParams ) {
		printf("Cannot get memory for BSIM47 parameter struct.");
		return ERROR;
	}
	
	mosModel->BSIM4instances = mosInst;
	mosInst->BSIM4nextInstance = NULL;
	mosInst->BSIM4modPtr = mosModel;
	mosInst->pParam = mosParams;
	mosInst->BSIM4states = 0;
	
	retVal = MLMain( argc, argv );
	
	free( mosModel );
	free( mosInst );
	free( mosCircuit );
	return retVal;
}

:Evaluate:	BeginPackage["BSIM47Internal`"]
:Evaluate:	Begin["`Private`"]

:Begin:
:Function:	SetModelSelectors
:Pattern:	SetModelSelectors[ x_List ]
:Arguments:	{x}
:ArgumentTypes:	{RealList}
:ReturnType:	Integer
:End:

:Begin:
:Function:	CheckModelParameters
:Pattern:	CheckModelParameters[ ]
:Arguments:	{}
:ArgumentTypes: Manual
:ReturnType:	Integer
:End:

:Begin:
:Function:	SetProcessParameters
:Pattern:	SetProcessParameters[ x_List ]
:Arguments:	{x}
:ArgumentTypes:	{RealList}
:ReturnType:	Integer
:End:

:Begin:
:Function:	SetBasicParameters
:Pattern:	SetBasicParameters[ x_List ]
:Arguments:	{x}
:ArgumentTypes:	{RealList}
:ReturnType:	Integer
:End:

:Begin:
:Function:	SetRdsParameters
:Pattern:	SetRdsParameters[ x_List ]
:Arguments:	{x}
:ArgumentTypes:	{RealList}
:ReturnType:	Integer
:End:

:Begin:
:Function:	SetImpactIonizationParameters
:Pattern:	SetImpactIonizationParameters[ x_List ]
:Arguments:	{x}
:ArgumentTypes:	{RealList}
:ReturnType:	Integer
:End:

:Begin:
:Function:	SetGIDLParameters
:Pattern:	SetGIDLParameters[ x_List ]
:Arguments:	{x}
:ArgumentTypes:	{RealList}
:ReturnType:	Integer
:End:

:Begin:
:Function:	SetGateTunnelingParameters
:Pattern:	SetGateTunnelingParameters[ x_List ]
:Arguments:	{x}
:ArgumentTypes:	{RealList}
:ReturnType:	Integer
:End:

:Begin:
:Function:	SetChargeCapParameters
:Pattern:	SetChargeCapParameters[ x_List ]
:Arguments:	{x}
:ArgumentTypes:	{RealList}
:ReturnType:	Integer
:End:

:Begin:
:Function:	SetRFParameters
:Pattern:	SetRFParameters[ x_List ]
:Arguments:	{x}
:ArgumentTypes:	{RealList}
:ReturnType:	Integer
:End:

:Begin:
:Function:	SetNoiseParameters
:Pattern:	SetNoiseParameters[ x_List ]
:Arguments:	{x}
:ArgumentTypes:	{RealList}
:ReturnType:	Integer
:End:

:Begin:
:Function:	SetDWDLParameters
:Pattern:	SetDWDLParameters[ x_List ]
:Arguments:	{x}
:ArgumentTypes:	{RealList}
:ReturnType:	Integer
:End:

:Begin:
:Function:	SetWPEParameters
:Pattern:	SetWPEParameters[ x_List ]
:Arguments:	{x}
:ArgumentTypes:	{RealList}
:ReturnType:	Integer
:End:

:Begin:
:Function:	SetStressParameters
:Pattern:	SetStressParameters[ x_List ]
:Arguments:	{x}
:ArgumentTypes:	{RealList}
:ReturnType:	Integer
:End:

:Begin:
:Function:	SetTemperatureParameters
:Pattern:	SetTemperatureParameters[ x_List ]
:Arguments:	{x}
:ArgumentTypes:	{RealList}
:ReturnType:	Integer
:End:

:Begin:
:Function:	SetLayoutDependentParameters
:Pattern:	SetLayoutDependentParameters[ x_List ]
:Arguments:	{x}
:ArgumentTypes:	{RealList}
:ReturnType:	Integer
:End:

:Begin:
:Function:	SetAsymmetricParameters
:Pattern:	SetAsymmetricParameters[ x_List ]
:Arguments:	{x}
:ArgumentTypes:	{RealList}
:ReturnType:	Integer
:End:

:Begin:
:Function:	SetInstanceParameters
:Pattern:	SetInstanceParameters[ x_List ]
:Arguments:	{x}
:ArgumentTypes:	{RealList}
:ReturnType:	Integer
:End:

:Evaluate:	End[]
:Evaluate:	EndPackage[]

/* Parameters are expected in the following order:
 *	LEVEL(e), VERSION(e), BINUNIT, PARAMCHK, MOBMOD, MTRLMOD,
 *	RDSMOD, IGCMOD, IGBMOD, CVCHARGEMOD, CAPMOD, RGATEMOD(i),
 *	RBODYMOD(i), TRNQSMOD(i), ACNQSMOD(i), FNOIMOD, TNOIMOD, DIOMOD,
 *	TEMPMOD, PERMOD, GEOMOD(i), RGEOMOD(i), WPEMOD, GIDLMOD
 *
 *	e: ignored items
 *	i: instance items too
 */

int SetModelSelectors( double *d_params, long l_numElements ) {

	if ( l_numElements != PARAMS_MODELSELECTOR ) {
		MLPRINTF( "Incorrect number of parameters passed." );
		MLPutSymbol( stdlink, "$Failed" );
		return ERROR;
	}

	mosModel->BSIM4mobMod = d_params[4];
	mosModel->BSIM4cvchargeMod = d_params[9];
	mosModel->BSIM4capMod = d_params[10];
	mosModel->BSIM4dioMod = d_params[17];
	mosModel->BSIM4trnqsMod = d_params[13];
	mosModel->BSIM4acnqsMod = d_params[14];
	mosModel->BSIM4fnoiMod = d_params[15];
	mosModel->BSIM4tnoiMod = d_params[16];
	mosModel->BSIM4rdsMod = d_params[6];
	mosModel->BSIM4rbodyMod = d_params[12];
	mosModel->BSIM4rgateMod = d_params[11];
	mosModel->BSIM4perMod = d_params[19];
	mosModel->BSIM4geoMod = d_params[20];
	mosModel->BSIM4mtrlMod = d_params[5];
	mosModel->BSIM4mtrlCompatMod = -1;
	mosModel->BSIM4gidlMod = d_params[23];
	mosModel->BSIM4igcMod = d_params[7];
	mosModel->BSIM4igbMod = d_params[8];
	mosModel->BSIM4tempMod = d_params[18];
	mosModel->BSIM4binUnit = d_params[2];
	mosModel->BSIM4paramChk = d_params[3];
	mosModel->BSIM4version = "4.7.0";
	mosModel->BSIM4instances->BSIM4rgeoMod = d_params[21];

	return OK;
}

/* Parameters are expected in the following order:
 *	EPSROX, TOXE, EOT, TOXP, TOXM, DTOX, XJ, GAMMA1,
 *	GAMMA2, NDEP, NSUB, NGATE, NSD, VBX, XT, RSH, RSHG
 *
 *	e: ignored items
 *	i: instance items too
 */
int SetProcessParameters( double *d_params, long l_numElements ) {

	if ( l_numElements != PARAMS_PROCESSPARAMS ) {
		MLPRINTF( "Incorrect number of parameters passed." );
		MLPutSymbol( stdlink, "$Failed" );
		return ERROR;
	}
	
	mosModel->BSIM4eot = d_params[2];
	mosModel->BSIM4toxe = d_params[1];
	mosModel->BSIM4toxp = d_params[3];
	mosModel->BSIM4toxm = d_params[4];
	mosModel->BSIM4dtox = d_params[5];
	mosModel->BSIM4epsrox = d_params[0];
	mosModel->BSIM4xj = d_params[6];
	mosModel->BSIM4gamma1 = d_params[7];
	mosModel->BSIM4gamma2 = d_params[8];
	mosModel->BSIM4ndep = d_params[9];
	mosModel->BSIM4nsub = d_params[10];
	mosModel->BSIM4ngate = d_params[11];
	mosModel->BSIM4nsd = d_params[12];
	mosModel->BSIM4vbx = d_params[13];
	mosModel->BSIM4xt = d_params[14];
	/* mosModel->BSIM4rsh = d_params[15]; */
	mosModel->BSIM4rshg = d_params[16];
	
	return OK;
	
}

/* Parameters are expected in the following order:
 *	VTHO, DELVTO, VFB, VDDEOT, LEFFEOT, WEFFEOT, TEMPEOT,  
 *	PHIN, EASUB, EPSRSUB, EPSRGATE, NI0SUB, BG0SUB, TBGASUB, TBGBSUB, 
 *	ADOS, BDOS, K1, K2, K3, K3B, W0, LPE0, LPEB, VBM, DVT0, 
 *	DVT1, DVT2, DVTP0, DVTP1, DVTP2, DVTP3, DVTP4, DVTP5, 
 *	DVT0W, DVT1W, DVT2W, U0, UA, UB, UC, UD, UCS, UP, LP, 
 *	EU, VSAT, A0, AGS, B0, B1, KETA, A1, A2, WINT, LINT, 
 *	DWG, DWB, VOFF, VOFFL, MINV, NFACTOR, ETA0, ETAB, DSUB, 
 *	CIT, CDSC, CDSCB, CDSCD, PCLM, PDIBLC1, PDIBLC2, PDIBLCB, 
 *	DROUT, PSCBE1, PSCBE2, PVAG, DELTA, FPROUT, PDITS, PDITSL, 
 *	PDITSD, LAMBDA, VTL, LC, XN 
 */
int SetBasicParameters( double *d_params, long l_numElements ) {

	if ( l_numElements != PARAMS_BASICMODEL ) {
		MLPRINTF( "Incorrect number of parameters passed." );
		MLPutSymbol( stdlink, "$Failed" );
		return ERROR;
	}
	
	mosModel->BSIM4vth0 = d_params[0];
	mosInst->BSIM4delvto = d_params[1];
	mosModel->BSIM4vfb = d_params[2];
	mosModel->BSIM4vddeot = d_params[3];
	mosModel->BSIM4leffeot = d_params[4];
	mosModel->BSIM4weffeot = d_params[5];
	mosModel->BSIM4tempeot = d_params[6];
	mosModel->BSIM4phin = d_params[7];
	mosModel->BSIM4easub = d_params[8];
	mosModel->BSIM4epsrsub = d_params[9];
	mosModel->BSIM4epsrgate = d_params[10];
	mosModel->BSIM4ni0sub = d_params[11];
	mosModel->BSIM4bg0sub = d_params[12];
	mosModel->BSIM4tbgasub = d_params[13];
	mosModel->BSIM4tbgbsub = d_params[14];
	mosModel->BSIM4ados = d_params[15];
	mosModel->BSIM4bdos = d_params[16];
	mosModel->BSIM4k1 = d_params[17];
	mosModel->BSIM4k2 = d_params[18];
	mosModel->BSIM4k3 = d_params[19];
	mosModel->BSIM4k3b = d_params[20];
	mosModel->BSIM4w0 = d_params[21];
	mosModel->BSIM4lpe0 = d_params[22];
	mosModel->BSIM4lpeb = d_params[23];
	mosModel->BSIM4vbm = d_params[24];
	mosModel->BSIM4dvt0 = d_params[25];
	mosModel->BSIM4dvt1 = d_params[26];
	mosModel->BSIM4dvt2 = d_params[27];
	mosModel->BSIM4dvtp0 = d_params[28];
	mosModel->BSIM4dvtp1 = d_params[29];
	mosModel->BSIM4dvtp2 = d_params[30];
	mosModel->BSIM4dvtp3 = d_params[31];
	mosModel->BSIM4dvtp4 = d_params[32];
	mosModel->BSIM4dvtp5 = d_params[33];
	mosModel->BSIM4dvt0w = d_params[34];
	mosModel->BSIM4dvt1w = d_params[35];
	mosModel->BSIM4dvt2w = d_params[36];
	mosModel->BSIM4u0 = d_params[37];
	mosModel->BSIM4ua = d_params[38];
	mosModel->BSIM4ub = d_params[39];
	mosModel->BSIM4uc = d_params[40];
	mosModel->BSIM4ud = d_params[41];
	mosModel->BSIM4ucs = d_params[42];
	mosModel->BSIM4up = d_params[43];
	mosModel->BSIM4lp = d_params[44];
	mosModel->BSIM4eu = d_params[45];
	mosModel->BSIM4vsat = d_params[46];
	mosModel->BSIM4a0 = d_params[47];
	mosModel->BSIM4ags = d_params[48];
	mosModel->BSIM4b0 = d_params[49];
	mosModel->BSIM4b1 = d_params[50];
	mosModel->BSIM4keta = d_params[51];
	mosModel->BSIM4a1 = d_params[52];
	mosModel->BSIM4a2 = d_params[53];
	mosModel->BSIM4Wint = d_params[54];
	mosModel->BSIM4Lint = d_params[55];
	mosModel->BSIM4dwg = d_params[56];
	mosModel->BSIM4dwb = d_params[57];
	mosModel->BSIM4voff = d_params[58];
	mosModel->BSIM4voffl = d_params[59];
	mosModel->BSIM4minv = d_params[60];
	mosModel->BSIM4nfactor = d_params[61];
	mosModel->BSIM4eta0 = d_params[62];
	mosModel->BSIM4etab = d_params[63];
	mosModel->BSIM4dsub = d_params[64];
	mosModel->BSIM4cit = d_params[65];
	mosModel->BSIM4cdsc = d_params[66];
	mosModel->BSIM4cdscb = d_params[67];
	mosModel->BSIM4cdscd = d_params[68];
	mosModel->BSIM4pclm = d_params[69];
	mosModel->BSIM4pdibl1 = d_params[70];
	mosModel->BSIM4pdibl2 = d_params[71];
	mosModel->BSIM4pdiblb = d_params[72];
	mosModel->BSIM4drout = d_params[73];
	mosModel->BSIM4pscbe1 = d_params[74];
	mosModel->BSIM4pscbe2 = d_params[75];
	mosModel->BSIM4pvag = d_params[76];
	mosModel->BSIM4delta = d_params[77];
	mosModel->BSIM4fprout = d_params[78];
	mosModel->BSIM4pdits = d_params[79];
	mosModel->BSIM4pditsl = d_params[80];
	mosModel->BSIM4pditsd = d_params[81];
	mosModel->BSIM4lambda = d_params[82];
	mosModel->BSIM4vtl = d_params[83];
	mosModel->BSIM4lc = d_params[84];
	mosModel->BSIM4xn = d_params[85];
	
	mosModel->BSIM4lambdaGiven = TRUE;
	mosModel->BSIM4vtlGiven = TRUE;
	
	return OK;
	
}

/*
 * Parameters are expected in the following order:
 *	RDSW, RDSWMIN, RDW, RDWMIN, RSW, RSWMIN, PRWG,
 *	PRWB, WR, NRS (i), NRD (i)
 *
 *	i: instance parameter only
 */
int SetRdsParameters( double *d_params, long l_numElements ) {

	CHECKPARLEN( PARAMS_RDSMODEL );
	
	mosModel->BSIM4rdsw = d_params[0];
	mosModel->BSIM4rdswmin = d_params[1];
	mosModel->BSIM4rdw = d_params[2];
	mosModel->BSIM4rdwmin = d_params[3];
	mosModel->BSIM4rsw = d_params[4];
	mosModel->BSIM4rswmin = d_params[5];
	mosModel->BSIM4prwg = d_params[6];
	mosModel->BSIM4prwb = d_params[7];
	mosModel->BSIM4wr = d_params[8];
	mosInst->BSIM4sourceSquares = d_params[9]; 
	mosInst->BSIM4drainSquares = d_params[10]; 
	
	return OK;
	
}

/*
 * Parameters are expected in the following order:
 *	ALPHA0, ALPHA1, BETA0
 */
int SetImpactIonizationParameters( double *d_params, long l_numElements ) {
	
	CHECKPARLEN( PARAMS_IMPACTIONIZATION );
	
	mosModel->BSIM4alpha0 = d_params[0];
	mosModel->BSIM4alpha1 = d_params[1];
	mosModel->BSIM4beta0 = d_params[2];
	
	return OK;
}

/*
 * Parameters are expected in the following order:
 *	AGIDL, BGIDL, CGIDL, EGIDL, RGIDL, KGIDL, FGIDL,
 *	AGISL, BGISL, CGISL, EGISL, RGISL, KGISL, FGISL
 */
int SetGIDLParameters( double *d_params, long l_numElements ) {

	CHECKPARLEN( PARAMS_GIDL );
	
	mosModel->BSIM4agidl = d_params[0];
	mosModel->BSIM4bgidl = d_params[1];
	mosModel->BSIM4cgidl = d_params[2];
	mosModel->BSIM4egidl = d_params[3];
	mosModel->BSIM4rgidl = d_params[4];
	mosModel->BSIM4kgidl = d_params[5];
	mosModel->BSIM4fgidl = d_params[6];
	mosModel->BSIM4agisl = d_params[7];
	mosModel->BSIM4bgisl = d_params[8];
	mosModel->BSIM4cgisl = d_params[9];
	mosModel->BSIM4egisl = d_params[10];
	mosModel->BSIM4rgisl = d_params[11];
	mosModel->BSIM4kgisl = d_params[12];
	mosModel->BSIM4fgisl = d_params[13];
	
	return OK;
}

/*
 * Parameters are expected in the following order:
 *	AIGBACC, BIGBACC, CIGBACC, NIGBACC, AIGBINV, BIGBINV, 
 *	CIGBINV, EIGBINV, NIGBINV, AIGC, BIGC, CIGC, AIGS, BIGS
 *	CIGS, DLCIG, AIGD, BIGD, CIGD, DLCIGD, NIGC, POXEDGE,
 *	PIGCD, NTOX, TOXREF, VFBSDOFF
 */
int SetGateTunnelingParameters( double *d_params, long l_numElements ) {
	
	CHECKPARLEN( PARAMS_GATETUNNELING );
	
	mosModel->BSIM4aigbacc = d_params[0];
	mosModel->BSIM4bigbacc = d_params[1];
	mosModel->BSIM4cigbacc = d_params[2];
	mosModel->BSIM4nigbacc = d_params[3];
	mosModel->BSIM4aigbinv = d_params[4];
	mosModel->BSIM4bigbinv = d_params[5];
	mosModel->BSIM4cigbinv = d_params[6];
	mosModel->BSIM4eigbinv = d_params[7];
	mosModel->BSIM4nigbinv = d_params[8];
	mosModel->BSIM4aigc = d_params[9];
	mosModel->BSIM4bigc = d_params[10];
	mosModel->BSIM4cigc = d_params[11];
	mosModel->BSIM4aigs = d_params[12];
	mosModel->BSIM4bigs = d_params[13];
	mosModel->BSIM4cigs = d_params[14];
	mosModel->BSIM4dlcig = d_params[15];
	mosModel->BSIM4aigd = d_params[16];
	mosModel->BSIM4bigd = d_params[17];
	mosModel->BSIM4cigd = d_params[18];
	mosModel->BSIM4dlcigd = d_params[19];
	mosModel->BSIM4nigc = d_params[20];
	mosModel->BSIM4poxedge = d_params[21];
	mosModel->BSIM4pigcd = d_params[22];
	mosModel->BSIM4ntox = d_params[23];
	mosModel->BSIM4toxref = d_params[24];
	mosModel->BSIM4vfbsdoff = d_params[25];
	
	mosModel->BSIM4pigcdGiven = TRUE;
	
	return OK;
}

/*
 * Parameters are expected in the following order:
 *	XPART, CGSO, CGDO, CGBO, CGSL, CGDL, CKAPPAS, CKAPPAD,
 *	CF, CLC, CLE, DLC, DWC, VFBCV, NOFF, VOFFCV, VOFFCVL, 
 *	MINVCV, ACDE, MOIN
 */
int SetChargeCapParameters( double *d_params, long l_numElements ) {

	CHECKPARLEN( PARAMS_CHARGECAP );
	
	mosModel->BSIM4xpart = d_params[0];
	mosModel->BSIM4cgso = d_params[1];
	mosModel->BSIM4cgdo = d_params[2];
	mosModel->BSIM4cgbo = d_params[3];
	mosModel->BSIM4cgsl = d_params[4];
	mosModel->BSIM4cgdl = d_params[5];
	mosModel->BSIM4ckappas = d_params[6];
	mosModel->BSIM4ckappad = d_params[7];
	mosModel->BSIM4cf = d_params[8];
	mosModel->BSIM4clc = d_params[9];
	mosModel->BSIM4cle = d_params[10];
	mosModel->BSIM4dlc = d_params[11];
	mosModel->BSIM4dwc = d_params[12];
	mosModel->BSIM4vfbcv = d_params[13];
	mosModel->BSIM4noff = d_params[14];
	mosModel->BSIM4voffcv = d_params[15];
	mosModel->BSIM4voffcvl = d_params[16];
	mosModel->BSIM4minvcv = d_params[17];
	mosModel->BSIM4acde = d_params[18];
	mosModel->BSIM4moin = d_params[19]; 
	
	return OK;

}

/*
 * Parameters are expected in the following order:
 *	XRCRG1, XRCRG2, RBPB (i), RBPD (i), RBPS (i), RBDB (i), RBSB (i)
 *	GBMIN, RBPS0, RBPSL, RBPSW, RBPSNF, RBPD0, RBPDL, RBPDW, RBPDNF
 *	RBPBX0, RBPBXL, RBPBXW, RBPBXNF, RBPBY0, RBPBYL, RBPBYW, RBPBYNF
 *	RBSBX0, RBSBY0, RBDBX0, RBDBY0, RBSDBXL, RBSDBXW, RBSDBXNF, 
 *	RBSDBYL, RBSDBYW, RBSDBYNF
 *
 *	(i) : is also an instance parameter 
 */
int SetRFParameters( double *d_params, long l_numElements ) {
	
	CHECKPARLEN( PARAMS_RF );
	
	mosModel->BSIM4xrcrg1 = d_params[0];
	mosModel->BSIM4xrcrg2 = d_params[1];
	mosModel->BSIM4rbpb = d_params[2];
	mosModel->BSIM4rbpd = d_params[3];
	mosModel->BSIM4rbps = d_params[4];
	mosModel->BSIM4rbdb = d_params[5];
	mosModel->BSIM4rbsb = d_params[6];
	mosModel->BSIM4gbmin = d_params[7];
	mosModel->BSIM4rbps0 = d_params[8];
	mosModel->BSIM4rbpsl = d_params[9];
	mosModel->BSIM4rbpsw = d_params[10];
	mosModel->BSIM4rbpsnf = d_params[11];
	mosModel->BSIM4rbpd0 = d_params[12];
	mosModel->BSIM4rbpdl = d_params[13];
	mosModel->BSIM4rbpdw = d_params[14];
	mosModel->BSIM4rbpdnf = d_params[15];
	mosModel->BSIM4rbpbx0 = d_params[16];
	mosModel->BSIM4rbpbxl = d_params[17];
	mosModel->BSIM4rbpbxw = d_params[18];
	mosModel->BSIM4rbpbxnf = d_params[19];
	mosModel->BSIM4rbpby0 = d_params[20];
	mosModel->BSIM4rbpbyl = d_params[21];
	mosModel->BSIM4rbpbyw = d_params[22];
	mosModel->BSIM4rbpbynf = d_params[23];
	mosModel->BSIM4rbsbx0 = d_params[24];
	mosModel->BSIM4rbsby0 = d_params[25];
	mosModel->BSIM4rbdbx0 = d_params[26];
	mosModel->BSIM4rbdby0 = d_params[27];
	mosModel->BSIM4rbsdbxl = d_params[28];
	mosModel->BSIM4rbsdbxw = d_params[29];
	mosModel->BSIM4rbsdbxnf = d_params[30];
	mosModel->BSIM4rbsdbyl = d_params[31];
	mosModel->BSIM4rbsdbyw = d_params[32];
	mosModel->BSIM4rbsdbynf = d_params[33];
	
	return OK;
	
}

/*
 * Parameters are expected in the following order:
 *	NOIA, NOIB, NOIC, EM, AF, EF, KF, LINTNOI, NTNOI, 
 *	TNOIA, TNOIB, TNOIC, RNOIA, RNOIB, RNOIC
 */
int SetNoiseParameters( double *d_params, long l_numElements ) {

	CHECKPARLEN( PARAMS_NOISE );
	
	mosModel->BSIM4oxideTrapDensityA = d_params[0];
	mosModel->BSIM4oxideTrapDensityB = d_params[1];
	mosModel->BSIM4oxideTrapDensityC = d_params[2];
	mosModel->BSIM4em = d_params[3];
	mosModel->BSIM4af = d_params[4];
	mosModel->BSIM4ef = d_params[5];
	mosModel->BSIM4kf = d_params[6];
	mosModel->BSIM4lintnoi = d_params[7];
	mosModel->BSIM4ntnoi = d_params[8];
	mosModel->BSIM4tnoia = d_params[9];
	mosModel->BSIM4tnoib = d_params[10];
	mosModel->BSIM4tnoic = d_params[11];
	mosModel->BSIM4rnoia = d_params[12];
	mosModel->BSIM4rnoib = d_params[13];
	mosModel->BSIM4rnoic = d_params[14];
	
	return OK;
}

/*
 * Parameters are expected in the following order:
 *	DMCG, DMCI, DMDG, DMCGT, NF (oi), DWJ, MIN (oi), XGW (i), XGL, XL, XW, NGCON (i)
 *
 *	oi: only an instance parameter
 *	i: also an instance parameter 
 */
int SetLayoutDependentParameters( double *d_params, long l_numElements ) {

	CHECKPARLEN( PARAMS_LAYOUTDEP );
	
	mosModel->BSIM4dmcg = d_params[0];
	mosModel->BSIM4dmci = d_params[1];
	mosModel->BSIM4dmdg = d_params[2];
	mosModel->BSIM4dmcgt = d_params[3];
	mosInst->BSIM4nf = d_params[4];
	mosModel->BSIM4dwj = d_params[5];
	mosInst->BSIM4min = d_params[6];
	mosModel->BSIM4xgw = d_params[7];
	mosModel->BSIM4xgl = d_params[8];
	mosModel->BSIM4xl = d_params[9];
	mosModel->BSIM4xw = d_params[10];
	mosModel->BSIM4ngcon = d_params[11];
	
	return OK;
	
}

/*
 * Parameters are expected in the following order:
 *	IJTHSREV, IJTHDREV, IJTHSFWD, IJTHDFWD, XJBVS, XJBVD, BVS, BVD
 *	JSS, JSD, JSWS, JSWD, JSWGS, JSWGD, JTSS, JTSD, JTSSWS, JTSSWD,  
 *	JTSSWGS, JTSSWGD, JTWEFF, NJTS, NJTSD, NJTSSW, NJTSSWD, NJTSSWG, 
 *	NJTSSWGD, XTSS, XTSD, XTSSWS, XTSSWD, XTSSWGS, XTSSWGD, VTSS, VTSD, 
 *	VTSSWS, VTSSWD, VTSSWGS, VTSSWGD, TNJTS, TNJTSD, TNJTSSW, TNJTSSWD, 
 *	TNJTSSWG, TNJTSSWGD, CJS, CJD, MJS, MJD, MJSWS, MJSWD, CJSWS, CJSWD,
 *	CJSWGS, CJSWGD, MJSWGS, MJSWGD, PBS, PBD, PBSWS, PBSWD, PBSWGS, PBSWGD 
 */
int SetAsymmetricParameters( double *d_params, long l_numElements ) {
	
	CHECKPARLEN( PARAMS_ASYMMETRY );
	
	mosModel->BSIM4ijthsrev = d_params[0];
	mosModel->BSIM4ijthdrev = d_params[1];
	mosModel->BSIM4ijthsfwd = d_params[2];
	mosModel->BSIM4ijthdfwd = d_params[3];
	mosModel->BSIM4xjbvs = d_params[4];
	mosModel->BSIM4xjbvd = d_params[5];
	mosModel->BSIM4bvs = d_params[6];
	mosModel->BSIM4bvd = d_params[7];
	mosModel->BSIM4SjctSatCurDensity = d_params[8];
	mosModel->BSIM4DjctSatCurDensity = d_params[9];
	mosModel->BSIM4SjctSidewallSatCurDensity = d_params[10];
	mosModel->BSIM4DjctSidewallSatCurDensity = d_params[11];
	mosModel->BSIM4SjctGateSidewallSatCurDensity = d_params[12];
	mosModel->BSIM4DjctGateSidewallSatCurDensity = d_params[13];
	mosModel->BSIM4jtss = d_params[14];
	mosModel->BSIM4jtsd = d_params[15];
	mosModel->BSIM4jtssws = d_params[16];
	mosModel->BSIM4jtsswd = d_params[17];
	mosModel->BSIM4jtsswgs = d_params[18];
	mosModel->BSIM4jtsswgd = d_params[19];
	mosModel->BSIM4jtweff = d_params[20];
	mosModel->BSIM4njts = d_params[21];
	mosModel->BSIM4njtsd = d_params[22];
	mosModel->BSIM4njtssw = d_params[23];
	mosModel->BSIM4njtsswd = d_params[24];
	mosModel->BSIM4njtsswg = d_params[25];
	mosModel->BSIM4njtsswgd = d_params[26];
	mosModel->BSIM4xtss = d_params[27];
	mosModel->BSIM4xtsd = d_params[28];
	mosModel->BSIM4xtssws = d_params[29];
	mosModel->BSIM4xtsswd = d_params[30];
	mosModel->BSIM4xtsswgs = d_params[31];
	mosModel->BSIM4xtsswgd = d_params[32];
	mosModel->BSIM4vtss = d_params[33];
	mosModel->BSIM4vtsd = d_params[34];
	mosModel->BSIM4vtssws = d_params[35];
	mosModel->BSIM4vtsswd = d_params[36];
	mosModel->BSIM4vtsswgs = d_params[37];
	mosModel->BSIM4vtsswgd = d_params[38];
	mosModel->BSIM4tnjts = d_params[39];
	mosModel->BSIM4tnjtsd = d_params[40];
	mosModel->BSIM4tnjtssw = d_params[41];
	mosModel->BSIM4tnjtsswd = d_params[42];
	mosModel->BSIM4tnjtsswg = d_params[43];
	mosModel->BSIM4tnjtsswgd = d_params[44];
	mosModel->BSIM4SunitAreaJctCap = d_params[45];
	mosModel->BSIM4DunitAreaJctCap = d_params[46];
	mosModel->BSIM4SbulkJctBotGradingCoeff = d_params[47]; 
	mosModel->BSIM4DbulkJctBotGradingCoeff = d_params[48];
	mosModel->BSIM4SbulkJctSideGradingCoeff = d_params[49]; 
	mosModel->BSIM4DbulkJctSideGradingCoeff = d_params[50]; 
	mosModel->BSIM4SunitLengthSidewallJctCap = d_params[51]; 
	mosModel->BSIM4DunitLengthSidewallJctCap = d_params[52];
	mosModel->BSIM4SunitLengthGateSidewallJctCap = d_params[53]; 
	mosModel->BSIM4DunitLengthGateSidewallJctCap = d_params[54]; 
	mosModel->BSIM4SbulkJctGateSideGradingCoeff = d_params[55]; 
	mosModel->BSIM4DbulkJctGateSideGradingCoeff = d_params[56]; 
	mosModel->BSIM4SbulkJctPotential = d_params[57]; 
	mosModel->BSIM4DbulkJctPotential = d_params[58];
	mosModel->BSIM4SsidewallJctPotential = d_params[59];
	mosModel->BSIM4DsidewallJctPotential = d_params[60]; 
	mosModel->BSIM4SGatesidewallJctPotential = d_params[61]; 
	mosModel->BSIM4DGatesidewallJctPotential = d_params[62];
	
	return OK;

}

/*
 * Parameters are expected in the following order:
 *	TNOM, UTE, UCSTE, KT1, KT1L, KT2, UA1, UB1, UC1, UD1, AT, PRT, NJS, NJD,
 *	XTIS, XTID, TPB, TPBSW, TPBSWG, TCJ, TCJSW, TCJSWG, TVOFF, TVFBSDOFF, TNFACTOR,
 *	TETA0, TVOFFCV
 */
int SetTemperatureParameters( double *d_params, long l_numElements ) {

	CHECKPARLEN( PARAMS_TEMP );
	
	mosModel->BSIM4tnom = d_params[0];
	mosModel->BSIM4ute = d_params[1];
	mosModel->BSIM4ucste = d_params[2];
	mosModel->BSIM4kt1 = d_params[3];
	mosModel->BSIM4kt1l = d_params[4];
	mosModel->BSIM4ua1 = d_params[5];
	mosModel->BSIM4ub1 = d_params[6];
	mosModel->BSIM4uc1 = d_params[7];
	mosModel->BSIM4ud1 = d_params[8];
	mosModel->BSIM4at = d_params[9];
	mosModel->BSIM4prt = d_params[10];
	mosModel->BSIM4SjctEmissionCoeff = d_params[11];
	mosModel->BSIM4DjctEmissionCoeff = d_params[12];
	mosModel->BSIM4SjctTempExponent = d_params[13];
	mosModel->BSIM4DjctTempExponent = d_params[14];
	mosModel->BSIM4tpb = d_params[15];
	mosModel->BSIM4tpbsw = d_params[16];
	mosModel->BSIM4tpbswg = d_params[17];
	mosModel->BSIM4tcj = d_params[18];
	mosModel->BSIM4tcjsw = d_params[19];
	mosModel->BSIM4tcjswg = d_params[20];
	mosModel->BSIM4tvoff = d_params[21];
	mosModel->BSIM4tvfbsdoff = d_params[22];
	mosModel->BSIM4tnfactor = d_params[23];
	mosModel->BSIM4teta0 = d_params[24];
	mosModel->BSIM4tvoffcv = d_params[25];
	
	return OK;

}

/*
 * Parameters are expected in the following order:
 *	SA (i), SB (i), SD (i), SAref, SBref, WLOD, KU0, KVSAT,
 *	TKU0, LKU0, WKU0, PKU0, LLODKU0, WLODKU0, KVTH0, LKVTH0, 
 *	WKVTH0, PKVTH0, LLODVTH, WLODVTH, STK2, LODK2, STETA0, LODETA0
 *
 *	(i) : instance parameter
 */
int SetStressParameters( double *d_params, long l_numElements ) {

	CHECKPARLEN( PARAMS_STRESS );
	
	mosInst->BSIM4sa = d_params[0];
	mosInst->BSIM4sb = d_params[1];
	mosInst->BSIM4sd = d_params[2];
	mosModel->BSIM4saref = d_params[3];
	mosModel->BSIM4sbref = d_params[4];
	mosModel->BSIM4wlod = d_params[5];
	mosModel->BSIM4ku0 = d_params[6];
	mosModel->BSIM4kvsat = d_params[7];
	mosModel->BSIM4tku0 = d_params[8];
	mosModel->BSIM4lku0 = d_params[9];
	mosModel->BSIM4wku0 = d_params[10];
	mosModel->BSIM4pku0 = d_params[11];
	mosModel->BSIM4llodku0 = d_params[12];
	mosModel->BSIM4wlodku0 = d_params[13];
	mosModel->BSIM4kvth0 = d_params[14];
	mosModel->BSIM4lkvth0 = d_params[15];
	mosModel->BSIM4wkvth0 = d_params[16];
	mosModel->BSIM4pkvth0 = d_params[17];
	mosModel->BSIM4llodvth = d_params[18];
	mosModel->BSIM4wlodvth = d_params[19];
	mosModel->BSIM4stk2 = d_params[20];
	mosModel->BSIM4lodk2 = d_params[21];
	mosModel->BSIM4steta0 = d_params[22];
	mosModel->BSIM4lodeta0 = d_params[23];
	
	return OK;

}

/*
 * Parameters are expected in the following order:
 *	SCA (i), SCB (i), SCC (i), SC (i), WEB, WEC, KVTH0WE,
 *	K2WE, KU0WE, SCREF
 *
 *	(i): instance parameter 
 */
int SetWPEParameters( double *d_params, long l_numElements ) {

	CHECKPARLEN( PARAMS_WPE );
	
	mosInst->BSIM4sca = d_params[0];
	mosInst->BSIM4scb = d_params[1];
	mosInst->BSIM4scc = d_params[2];
	mosInst->BSIM4sc = d_params[3];
	mosModel->BSIM4web = d_params[4];
	mosModel->BSIM4wec = d_params[5];
	mosModel->BSIM4kvth0we = d_params[6];
	mosModel->BSIM4k2we = d_params[7];
	mosModel->BSIM4ku0we = d_params[8];
	mosModel->BSIM4scref = d_params[9];
	
	return OK;

}

/*
 * Parameters are expected in the following order:
 *	WL, WLN, WW, WWN, WWL, LL, LLN, LW, LWN, LWL, LLC, LWC,
 *	LWLC, WLC, WWC, WWLC
 */
int SetDWDLParameters( double *d_params, long l_numElements ) {

	CHECKPARLEN( PARAMS_DWDL );
	
	mosModel->BSIM4Wl = d_params[0];
	mosModel->BSIM4Wln = d_params[1];
	mosModel->BSIM4Ww = d_params[2];
	mosModel->BSIM4Wwn = d_params[3];
	mosModel->BSIM4Wwl = d_params[4];
	mosModel->BSIM4Ll = d_params[5];
	mosModel->BSIM4Lln = d_params[6];
	mosModel->BSIM4Lw = d_params[7];
	mosModel->BSIM4Lwn = d_params[8];
	mosModel->BSIM4Lwl = d_params[9];
	mosModel->BSIM4Llc = d_params[10];
	mosModel->BSIM4Lwc = d_params[11];
	mosModel->BSIM4Lwlc = d_params[12];
	mosModel->BSIM4Wlc = d_params[13];
	mosModel->BSIM4Wwc = d_params[14];
	mosModel->BSIM4Wwlc = d_params[15];
	
	return OK;

}

/*
 * Parameters are expected in the following order:
 *	W, L, AS, AD, PS, PD, OFF, IC_VDS, IC_VGS,
 *	IC_VBS, NGCON, TYPE
 */
int SetInstanceParameters( double *d_params, long l_numElements ) {

	CHECKPARLEN( PARAMS_INSTANCES );
	
	mosInst->BSIM4w = d_params[0];
	mosInst->BSIM4l = d_params[1];
	mosInst->BSIM4sourceArea = d_params[2];
	mosInst->BSIM4drainArea = d_params[3];
	mosInst->BSIM4sourcePerimeter = d_params[4];
	mosInst->BSIM4drainPerimeter = d_params[5];
	mosInst->BSIM4off = d_params[6];
	mosInst->BSIM4icVDS = d_params[7];
	mosInst->BSIM4icVGS = d_params[8];
	mosInst->BSIM4icVBS = d_params[9];
	mosInst->BSIM4ngcon = d_params[10];
	mosModel->BSIM4type = d_params[11];
	
	return OK;

}

int CheckModelParameters( void ) {

	if ( BSIM4checkModel( mosModel, mosInst ) ) {
		MLPutSymbol( stdlink, "$Failed" );
		return ERROR;
	}
	return OK;
}