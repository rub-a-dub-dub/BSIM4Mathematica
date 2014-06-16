#ifndef __MYDEFS_H__
#define __MYDEFS_H__

#include <string.h>

#define CONSTvt0 CONSTboltz * (27 /* deg c */ + CONSTCtoK ) / CHARGE

#define FABS(x) fabs(x)
#define ABS(x) abs(x)
#define MAX(a,b) ((a) > (b) ? (a) : (b))
#define MIN(a,b) ((a) < (b) ? (a) : (b))

#define OK 0
#define E_ORDER (E_PRIVATE+4)
#define E_PRIVATE 100
#define E_METHOD (E_PRIVATE+5)

#define MLFPRINTF(x, y)	MLEvaluateString(stdlink, "Print[\"" y "\"];")
#define MLPRINTF(x) MLFPRINTF( "dmy", x )

typedef struct {

    double *(CKTstates[8]);
#define CKTstate0 CKTstates[0]
#define CKTstate1 CKTstates[1]
#define CKTstate2 CKTstates[2]
#define CKTstate3 CKTstates[3]
#define CKTstate4 CKTstates[4]
#define CKTstate5 CKTstates[5]
#define CKTstate6 CKTstates[6]
#define CKTstate7 CKTstates[7]

    double CKTdelta;
    double CKTdeltaOld[7];
    double CKTtemp;

    double CKTag[7];        /* the gear variable coefficient matrix */

    int CKTorder;           /* the integration method order */
    int CKTintegrateMethod; /* the integration method to be used */

/* known integration methods */
#define TRAPEZOIDAL 1
#define GEAR 2

    int CKTniState;         /* internal state */
    double *CKTrhs;         /* current rhs value - being loaded */
    double *CKTrhsOld;      /* previous rhs value for convergence testing */


/*
 *  symbolic constants for CKTniState
 *      Note that they are bitwise disjoint
 */

#define NISHOULDREORDER 0x1
#define NIREORDERED 0x2
#define NIUNINITIALIZED 0x4
#define NIACSHOULDREORDER 0x10
#define NIACREORDERED 0x20
#define NIACUNINITIALIZED 0x40
#define NIDIDPREORDER 0x100
#define NIPZSHOULDREORDER 0x200


/* defines for the value of  CKTcurrentAnalysis */
/* are in TSKdefs.h */

#define NODENAME(ckt,nodenum) CKTnodName(ckt,nodenum)
    long CKTmode;

/* defines for CKTmode */

/* old 'mode' parameters */
#define MODE 0x3
#define MODETRAN 0x1
#define MODEAC 0x2

/* old 'modedc' parameters */
#define MODEDC 0x70
#define MODEDCOP 0x10
#define MODETRANOP 0x20
#define MODEDCTRANCURVE 0x40

/* old 'initf' parameters */
#define INITF 0x3f00
#define MODEINITFLOAT 0x100
#define MODEINITJCT 0x200
#define MODEINITFIX 0x400
#define MODEINITSMSIG 0x800
#define MODEINITTRAN 0x1000
#define MODEINITPRED 0x2000

/* old 'nosolv' paramater */
#define MODEUIC 0x10000l

    int CKTbypass;
    double CKTabstol;
    double CKTreltol;
    double CKTvoltTol;
    double CKTgmin;
    int CKTnoncon;

} CKTcircuit;

int NIintegrate( CKTcircuit *, double *, double *, double , int );
double DEVlimvds( double, double );
double DEVpnjlim( double, double, double, double, int* );
double DEVfetlim( double, double, double );

#endif
