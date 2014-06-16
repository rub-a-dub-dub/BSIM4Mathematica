(* Mathematica Package *)

(* Created by the Wolfram Workbench 26 janv. 2013 *)

BeginPackage["BSIM4Mathematica`"]
(* Exported symbols added here with SymbolName::usage *) 

SetModelCard::usage = "This function will setup the BSIM4 model for use in simulations. 
	Options not specified will take the default values given in the BSIM 4.7 manual.";
	
SetInstanceCard::usage = "This function specifies instance specific parameters.";

Options[SetModelCard] = {
	(* Appendix A.1: Model Selectors/Controllers *) 
	BINUNIT -> 1, PARAMCHK -> 1, MOBMOD -> 0, MTRLMOD -> 0, RDSMOD -> 0,
	IGCMOD -> 0, IGBMOD -> 0, CVCHARGEMOD -> 2, CAPMOD -> 2, RGATEMOD -> 0, RBODYMOD -> 0, TRNQSMOD -> 0,
	ACNQSMOD -> 0, FNOIMOD -> 1, TNOIMOD -> 0, DIOMOD -> 1, TEMPMOD -> 0, PERMOD -> 1, GEOMOD -> 0, RGEOMOD -> 0,
	WPEMOD -> 0, GIDLMOD -> 0,
	(* Appendix A.2: Process Parameters *)
	EPSROX -> 3.9, TOXE -> 3*10^-9, EOT -> 1.5*10^-9, TOXP -> $Failed, TOXM -> $Failed, DTOX -> 0, XJ -> 1.5*10^-7,
	GAMMA1 -> $Failed, GAMMA2 -> $Failed, NDEP -> 1.7*10^17, NSUB -> 6*10^16, NGATE -> 0, NSD -> 10^20, VBX -> $Failed,
	XT -> 1.55*10^-7, RSH -> 0, RSHG -> 0.1,
	(* Appendix A.3: Basic Parameters *)
	VTHO -> $Failed, DELVTO -> 0, VFB -> -1, VDDEOT -> $Failed, LEFFEOT -> 10^-6, WEFFEOT -> 10*10^-6, TEMPEOT -> 27,
	PHIN -> 0, EASUB ->4.05, EPSRSUB -> 11.7, EPSRGATE -> 11.7, NI0SUB -> 1.45*10^16, BG0SUB -> 1.16, TBGASUB -> 7.02*10^-4,
	TBGBSUB -> 1108, ADOS -> 1, BDOS ->1, K1 -> 0.5, K2 -> 0, K3 -> 80, K3B -> 0, W0 -> 2.5*10^-6, LPE0 -> 1.74*10^-7,
	LPEB -> 0, VBM -> -3, DVT0 -> 2.2, DVT1 -> 0.53, DVT2 -> -0.032, DVTP0 -> 0, DVTP1 -> 0, DVTP2 -> 0, DVTP3 -> 0, DVTP4 -> 0,
	DVTP5 -> 0, DVT0W -> 0, DVT1W -> 5.3*10^6, DVT2W -> -0.032, U0 -> $Failed, UA -> $Failed, UB -> 10^-19, UC -> $Failed, 
	UD -> 0, UCS -> $Failed, UP -> 0, LP -> 10^-8, EU -> $Failed, VSAT -> 8*10^-4, A0 -> 1, AGS -> 0, B0 -> 0, B1 -> 0, KETA -> -0.047,
	A1 -> 0, A2 -> 1, WINT -> 0, LINT -> 0, DWG -> 0, DWB -> 0, VOFF -> -0.08, VOFFL -> 0, MINV -> 0, NFACTOR -> 1, ETA0 -> 0.08,
	ETAB -> -0.07, DSUB -> $Failed, CIT -> 0, CDSC -> 2.4*10^-4, CDSCB -> 0, CDSCD -> 0, PCLM -> 1.3, PDIBLC1 -> 0.39, 
	PDIBLC2 -> 0.0086, PDIBLCB -> 0, DROUT -> 0.56, PSCBE1 -> 4.24*10^8, PSCBE2 -> 10^-5, PVAG -> 0, DELTA -> 0.01, FPROUT -> 0,
	PDITS -> 0, PDITSL -> 0, PDITSD -> 0, LAMBDA -> 0, VTL -> 2.05*10^5, LC -> 0, XN -> 3,
	(* Appendix A.4: Asymmetric and Bias-Dependent Rds Model *)
	RDSW -> 200, RDSWMIN -> 0, RDW -> 100, RDWMIN -> 0, RSW -> 100, RSWMIN -> 0, PRWG -> 1, PRWB -> 0, WR -> 1, NRS -> 1, NRD -> 1,
	(* Appendix A.5: Impact Ionisation *)
	ALPHA0 -> 0, ALPHA1 -> 0, BETA0 -> 0,
	(* Appendix A.6: GIDL *)
	AGIDL -> 0, BGIDL -> 2.3*10^9, CGIDL -> 0.5, EGIDL -> 0.8, RGIDL -> 1, KGIDL -> 0, FGIDL -> 0, AGISL -> $Failed, BGISL -> $Failed,
	CGISL -> $Failed, EGISL -> $Failed, RGISL -> $Failed, KGISL -> $Failed, FGISL -> $Failed,
	(* Appendix A.7: Gate Tunelling *)
	AIGBACC -> 9.49*10^-4, BIGBACC -> 1.71*10^-3, CIGBACC -> 0.075, NIGBACC -> 1, AIGBINV -> 1.11*10^-2, BIGBINV ->9.49*10^-4, 
	CIGBINV -> 0.006, EIGBINV -> 1.1, NIGBINV -> 3, AIGC -> $Failed, BIGC -> $Failed, CIGC -> $Failed, AIGS -> $Failed, BIGS -> $Failed,
	CIGS -> $Failed, DLCIG -> $Failed, AIGD -> $Failed, BIGD -> $Failed, CIGD -> $Failed, DLCIGD -> $Failed, NIGC -> 1, POXEDGE -> 1,
	PIGCD -> 1, NTOX -> 1, TOXREF -> 3*10^-9, VFBSDOFF -> 0,
	(* Appendix A.8: Charge and Capacitance *)
	XPART -> 0, CGSO -> $Failed, CGDO -> $Failed, CGBO -> 0, CGSL -> 0, CGDL -> 0, CKAPPAS -> 0, CKAPPAD -> $Failed, CF -> $Failed, 
	CLC -> 10^-7, CLE -> 0.6, DLC -> $Failed, DWC -> $Failed, VFBCV -> -1, NOFF -> 1, VOFFCV -> 0, VOFFCVL ->0, MINVCV -> 0, ACDE -> 1,
	MOIN -> 15,
	(* Appendix A.9: High Speed/RF Parameters *)
	XRCRG1 -> 12, XRCRG2 -> 1, RBPB -> 50, RBPD -> 50, RBPS -> 50, RBDB -> 50, RBSB -> 50, GBMIN -> 10^-12, RBPS0 -> 50, RBPSL -> 0, 
	RBPSW -> 0, RBPSNF -> 0, RBPD0 -> 50, RBPDL -> 0, RBPDW -> 0, RBPDNF -> 0, RBPBX0 -> 100, RBPBXL -> 0, RBPBXW -> 0, RBPBXNF -> 0,
	RBPBY0 -> 100, RBOBYW -> 0, RBPBYL -> 0, RBPBYNF -> 0, RBSBX0 -> 100, RBSBY0 -> 100, RBDBX0 -> 100, RBDBY0 -> 100, RBSDBXL -> 0, 
	RBSDBXW -> 0, RBSDBXNF -> 0, RBSDBYL -> 0, RBSDBYW ->0, RBSDBYNF -> 0,
	(* Appending A.10: Flicker and Thermal Noise *)
	NOIA -> $Failed, NOIB -> $Failed, NOIC -> 8.75, EM -> 4.1*10^7, AF -> 1, EF -> 1, KF -> 0, LINTNOI -> 0, NTNOI -> 1, TNOIA -> 1.5, 
	TNOIB -> 3.5, TNOIC -> 0, RNOIA -> 0.577, RNOIB -> 0.5164, RNOIC -> 0.395,
	(* Appendix A.11: Layout Dependent *)
	DMCG -> 0, DMCI -> $Failed, DMDG -> 0, DMCGT -> 0, NF -> 1, DWJ -> $Failed, MIN -> 0, XGW -> 0, XGL -> 0, XL -> 0, XW ->0, NGCON -> 1,
	(* Appendix A.12: Asymmetric Source/Drain Junction Diode *)
	IJTHSREV -> 0.1, IJTHDREV -> $Failed, IJTHSFWD -> 0.1, IJTHDFWD -> $Failed, XJBVS -> 1, XJBVD -> $Failed, BVS -> 10, BVD -> $Failed,
	JSS -> 10^-4, JSD -> $Failed, JSWS -> 0, JSWD -> $Failed, JSWGS -> 0, JSWGD -> $Failed, JTSS -> 0, JTSD -> $Failed, JTSSWS -> 0, 
	JTSSWD -> $Failed, JTSSWGS -> 0, JTSSWGD -> $Failed, JTWEFF -> 0, NJTS -> 20, NJTSD -> $Failed, NJTSSW -> 20, NJTSSWD -> $Failed, 
	NJTSWG -> 20, NJTSSWGD -> $Failed, XTSS -> 0.02, XTSD -> 0.02, XTSSWS -> 0.02, XTSSWD -> 0.02, XTSSWGS -> 0.02, XTSSWGD -> 0.02,
	VTSS -> 10, VTSD -> $Failed, VTSSWS -> 10, VTSSWD -> $Failed, VTSSWGS -> 10, VTSSWGD -> $Failed, TNJTS -> 0, TNJTSD -> $Failed,
	TNJTSSW -> 0, TNJTSSWD -> $Failed, TNJTSSWG -> 0, TNJTSSWGD -> $Failed, CJS -> 50*10^-4, CJD -> $Failed, MJS -> 0.5, MJD -> $Failed,
	MJSWS -> 0.33, MJSWD -> $Failed, CJSWS -> 50*10^-10, CJSWD -> $Failed, CJSWGS -> $Failed, CJSWGD -> $Failed, MJSWGS -> $Failed, 
	MJSWGD -> $Failed, PBS -> 1, PBD -> $Failed, PBSWS -> 1, PBSWD -> $Failed, PBSWGS -> $Failed, PBSWGD -> $Failed,
	(* Appendix A.13: Temperature Model *)
	TNOM -> 27, UTE -> -1.5, UCSTE -> -4.775*10^-3, KT1 -> -0.11, KT1L -> 0, KT2 -> 0.022, UA1 -> 10^-9, UB1 -> -10^-18, UC1 -> $Failed,
	UD1 -> 0, AT -> 3.3*10^4, PRT -> 0, NJS -> 1, NJD -> $Failed, XTIS -> 3, XTID -> $Failed, TPB -> 0, TPBSW -> 0, TPBSWG -> 0, TCJ -> 0,
	TCJSW -> 0, TCJSWG -> 0, TVOFF -> 0, TVFBSDOFF -> 0, TNFACTOR ->0, TETA0 -> 0, TVOFFCV -> 0,
	(* Appendix A.14: Stress Effect *)
	SA -> 0, SB -> 0, SD -> 0, SAREF -> 10^-6, SBREF -> 10^-6, WLOD -> 0, KU0 -> 0, KVSAT -> 0, TKU0 -> 0, LKU0 -> 0, WKU0 -> 0,
	PKU0 -> 0, LLODKU0 -> 0, WLODKU0 -> 0, KVTH0 -> 0, LKVTH0 -> 0, WKVTH0 -> 0, PKVTH0 -> 0, LLODVTH -> 0, WLODVTH -> 0, STK2 -> 0,
	LODK2 -> 1, STETA0 -> 0, LODETA0 -> 1,
	(* Appendix A.15: WPE *)
	SCA -> 0, SCB -> 0, SCC -> 0, SC -> 0, WEB -> 0, WEC -> 0, KTH0WE -> 0, K2WE -> 0, KU0WE -> 0, SCREF -> 10^-6, 
	(* Appendix A.16: dW and dL Parameters *)
	WL -> 0, WLN -> 1, WW -> 0, WWN -> 1, WWL -> 0, LL -> 0, LLN -> 1, LW -> 0, LWN -> 1, LWL -> 0, LLC -> $Failed, LWC -> $Failed,
	LWLC -> $Failed, WLC -> $Failed, WWC -> $Failed, WWLC -> $Failed,
	(* These are moved over from instance parameters *) 
	TYPE -> "NMOS"
	};
(* The following parameters are not supported 
	Level, Version
*)

Options[SetInstanceCard] = {
	W -> 200*10^-9, L -> 20*10^-9, SourceArea -> 70*10^-9*200*10^-9, DrainArea -> 70*10^-9*200*10^-9,
	SourcePerimeter -> 2*270*10^-9, DrainPerimeter -> 2*270*10^-9, NGCON -> 1 
	};
(* The following parameters are not supported
	OFF, IC_VDS, IC_VGS, IC_VBS, TYPE (in model card)
*)

Begin["`Private`"]
(* Implementation of the package *)

MathLinkToModel = Null;			(* used to communicate with the C binary *)
DeviceType = 0;					(* used to store the model type (PMOS/NMOS) *)

Options[ OpenMathLink ] = {
	BinaryLocation -> "/Users/crossbow/Dropbox/git/BSIM4Mathematica/build/Debug/BSIM4Mathematica"
};

(*
	This function will let the user indirectly call the underlying C binary, setting model related options.
	The function has the following steps:
		1. Process all parameters filling in all missing values
		2. Perform sanity checks on all parameters (as per BSIM4.7 manual)
		3. Set model parameters through the link (converting all to Real in the process)
		4. Alert the user of any failures including messages from the link
*)
SetModelCard[ OptionsPattern[] ] := Block[ 
	{ A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, final,
		toxp, toxm, gamma1, gamma2, vbx, coxe, eps0 = 8.854*10^-12, q = 1.602*10^-19, phis, kB=1.3806503*10^-23, T=273+27, 
		ni, eg, vt, vth0, vddeot, u0, ua, uc, ucs, dsub, eu, agisl, bgisl, cgisl, egisl, fgisl, kgisl, rgisl,
		aigc, bigc, cigc, aigs, bigs, cigs, dlcig, aigd, bigd, cigd, dlcigd, dlc, dwc, cgso, cgdo, cgbo, cf, ckappad,
		noia, noib, dwj, dmci},
		
	A1 = { 47, 4.7, OptionValue[BINUNIT], OptionValue[PARAMCHK], OptionValue[MOBMOD], OptionValue[MTRLMOD], OptionValue[RDSMOD],
			OptionValue[IGCMOD], OptionValue[IGBMOD], OptionValue[CVCHARGEMOD], OptionValue[CAPMOD], OptionValue[RGATEMOD],
			OptionValue[RBODYMOD], OptionValue[TRNQSMOD], OptionValue[ACNQSMOD], OptionValue[FNOIMOD], OptionValue[TNOIMOD],
			OptionValue[DIOMOD], OptionValue[TEMPMOD], OptionValue[PERMOD], OptionValue[GEOMOD], OptionValue[RGEOMOD],
			OptionValue[WPEMOD], OptionValue[GIDLMOD] } // N;
			
	(*
	EPSROX -> 3.9, TOXE -> 3*10^-9, EOT -> 1.5*10^-9, TOXP -> $Failed, TOXM -> $Failed, DTOX -> 0, XJ -> 1.5*10^-7,
	GAMMA1 -> $Failed, GAMMA2 -> $Failed, NDEP -> 1.7*10^17, NSUB -> 6*10^16, NGATE -> 0, NSD -> 10^20, VBX -> $Failed,
	XT -> 1.55*10^-7, RSH -> 0, RSHG -> 0.1,
	*)
	vt = kB*T/q; (* used for ni *)
	coxe = OptionValue[EPSROX]*eps0/OptionValue[TOXE];
	toxp = If[ OptionValue[TOXP] == $Failed, OptionValue[TOXE], OptionValue[TOXP] ];
	toxm = If[ OptionValue[TOXM] == $Failed, OptionValue[TOXE], OptionValue[TOXM] ];
	eg[temp_] = If[ OptionValue[MTRLMOD],
			OptionValue[BG0SUB]-(OptionValue[TBGASUB]*temp^2)/(temp+OptionValue[TBGBSUB]),
			1.16 - (7.02*10^-4*temp^2)/(temp+1108)
			]; (* pg. 112 *)
	ni = If[ OptionValue[MTRLMOD],
			OptionValue[NI0SUB](OptionValue[TNOM]/300.15)^3/2*Exp[(eg[300.15]-eg[OptionValue[TNOM]])/(2 vt)],
			1.45*10^10*OptionValue[TNOM]/300.15*Sqrt[OptionValue[TNOM]/300.15]*Exp[21.5565981-q*eg[OptionValue[TNOM]]/(2*kB*T)]]; (* pg. 121 *)
	phis = 0.4 + kB*T/q*Log[OptionValue[NDEP]/ni]+OptionValue[PHIN]; (* pg. 20 *)
	gamma1 = If[ OptionValue[GAMMA1] == $Failed, 
				Sqrt[2*q*OptionValue[EPSRSUB]*OptionValue[NDEP]*eps0]/coxe, 
				OptionValue[GAMMA1] ];
	gamma2 = If[ OptionValue[GAMMA2] == $Failed, 
				Sqrt[2*q*OptionValue[EPSRSUB]*OptionValue[NSUB]*eps0]/coxe, 
				OptionValue[GAMMA2] ];
	vbx = If[ OptionValue[VBX] == $Failed,
				phis-(q OptionValue[NDEP] (OptionValue[XT]^2)/(2 eps0 OptionValue[EPSRSUB])),
				OptionValue[VBX]
			];
	A2 = { OptionValue[EPSROX], OptionValue[TOXE], OptionValue[EOT], toxp, toxm, OptionValue[DTOX], OptionValue[XJ],
		gamma1, gamma2, OptionValue[NDEP], OptionValue[NSUB], OptionValue[NGATE], OptionValue[NSD], vbx,
		OptionValue[XT], OptionValue[RSH], OptionValue[RSHG] } // N;

	(* VTHO -> $Failed, DELVTO -> 0, VFB -> -1, VDDEOT -> $Failed, LEFFEOT -> 10^-6, WEFFEOT -> 10*10^-6, TEMPEOT -> 27,
	PHIN -> 0, EASUB ->4.05, EPSRSUB -> 11.7, EPSRGATE -> 11.7, NI0SUB -> 1.45*10^16, BG0SUB -> 1.16, TBGASUB -> 7.02*10^-4,
	TBGBSUB -> 1108, ADOS -> 1, BDOS ->1, K1 -> 0.5, K2 -> 0, K3 -> 80, K3B -> 0, W0 -> 2.5*10^-6, LPE0 -> 1.74*10^-7,
	LPEB -> 0, VBM -> -3, DVT0 -> 2.2, DVT1 -> 0.53, DVT2 -> -0.032, DVTP0 -> 0, DVTP1 -> 0, DVTP2 -> 0, DVTP3 -> 0, DVTP4 -> 0,
	DVTP5 -> 0, DVT0W -> 0, DVT1W -> 5.3*10^6, DVT2W -> -0.032, U0 -> $Failed, UA -> $Failed, UB -> 10^-19, UC -> $Failed, 
	UD -> 0, UCS -> $Failed, UP -> 0, LP -> 10^-8, EU -> $Failed, VSAT -> 8*10^-4, A0 -> 1, AGS -> 0, B0 -> 0, B1 -> 0, KETA -> -0.047,
	A1 -> 0, A2 -> 1, WINT -> 0, LINT -> 0, DWG -> 0, DWB -> 0, VOFF -> -0.08, VOFFL -> 0, MINV -> 0, NFACTOR -> 1, ETA0 -> 0.08,
	ETAB -> -0.07, DSUB -> $Failed, CIT -> 0, CDSC -> 2.4*10^-4, CDSCB -> 0, CDSCD -> 0, PCLM -> 1.3, PDIBLC1 -> 0.39, 
	PDIBLC2 -> 0.0086, PDIBLCB -> 0, DROUT -> 0.56, PSCBE1 -> 4.24*10^8, PSCBE2 -> 10^-5, PVAG -> 0, DELTA -> 0.01, FPROUT -> 0,
	PDITS -> 0, PDITSL -> 0, PDITSD -> 0, LAMBDA -> 0, VTL -> 2.05*10^5, LC -> 0, XN -> 3, *)
	vth0 = If[ OptionValue[VTHO] == $Failed,
			If[ OptionValue[TYPE] == "NMOS", 0.7, -0.7 ],
			OptionValue[VTHO] 
		 ];
	vddeot = If[ OptionValue[VDDEOT] == $Failed,
			If[ OptionValue[TYPE] == "NMOS", 1.5, -1.5 ],
			OptionValue[VDDEOT]
	];
	u0 = If[ OptionValue[U0] == $Failed,
			If[ OptionValue[TYPE] == "NMOS", 0.067, 0.025 ],
			OptionValue[U0]
	];
	ua = If[ OptionValue[UA] == $Failed,
			If[ (OptionValue[MOBMOD] == 0) || (OptionValue[MOBMOD] == 1), 10^-9, 10^-15 ],
			OptionValue[UA]
	];
	uc = If[ OptionValue[UC] == $Failed,
			If[ (OptionValue[MOBMOD] == 0) || (OptionValue[MOBMOD] == 2), -0.0465*10^-9, -0.0465 ],
			OptionValue[UC]
	];
	ucs = If[ OptionValue[UCS] == $Failed,
			If[ OptionValue[TYPE] == "NMOS", 1.67, 1 ],
			OptionValue[UCS]
	];
	eu = If[ OptionValue[EU] == $Failed,
			If[ OptionValue[TYPE] == "NMOS", 1.67, 1 ],
			OptionValue[EU]
	];
	dsub = If[ OptionValue[DSUB] == $Failed,
			OptionValue[DROUT],
			OptionValue[DSUB]
	];
	A3 = { vth0, OptionValue[DELVTO], OptionValue[VFB], vddeot, OptionValue[LEFFEOT], OptionValue[WEFFEOT], OptionValue[TEMPEOT],
		OptionValue[PHIN], OptionValue[EASUB], OptionValue[EPSRSUB], OptionValue[EPSRGATE], OptionValue[NI0SUB], OptionValue[BG0SUB],
		OptionValue[TBGASUB], OptionValue[TBGBSUB], OptionValue[ADOS], OptionValue[BDOS], OptionValue[K1], OptionValue[K2], 
		OptionValue[K3], OptionValue[K3B], OptionValue[W0], OptionValue[LPE0], OptionValue[LPEB], OptionValue[VBM], OptionValue[DVT0],
		OptionValue[DVT1], OptionValue[DVT2], OptionValue[DVTP0], OptionValue[DVTP1], OptionValue[DVTP2], OptionValue[DVTP3],
		OptionValue[DVTP4], OptionValue[DVTP5], OptionValue[DVT0W], OptionValue[DVT1W], OptionValue[DVT2W], u0, ua, OptionValue[UB],
		uc, OptionValue[UD], ucs, OptionValue[UP], OptionValue[LP], eu, OptionValue[VSAT], OptionValue[A0], OptionValue[AGS],
		OptionValue[B0], OptionValue[B1], OptionValue[KETA], OptionValue[A1], OptionValue[A2], OptionValue[WINT], OptionValue[LINT],
		OptionValue[DWG], OptionValue[DWB], OptionValue[VOFF], OptionValue[VOFFL], OptionValue[MINV], OptionValue[NFACTOR], 
		OptionValue[ETA0], OptionValue[ETAB], dsub, OptionValue[CIT], OptionValue[CDSC], OptionValue[CDSCB], OptionValue[CDSCD], 
		OptionValue[PCLM], OptionValue[PDIBLC1], OptionValue[PDIBLC2], OptionValue[PDIBLCB], OptionValue[DROUT], OptionValue[PSCBE1],
		OptionValue[PSCBE2], OptionValue[PVAG], OptionValue[DELTA], OptionValue[FPROUT], OptionValue[PDITS], OptionValue[PDITSL],
		OptionValue[PDITSD], OptionValue[LAMBDA], OptionValue[VTL], OptionValue[LC], OptionValue[XN] };
		
	(* RDSW -> 200, RDSWMIN -> 0, RDW -> 100, RDWMIN -> 0, RSW -> 100, RSWMIN -> 0, PRWG -> 1, PRWB -> 0, WR -> 1, NRS -> 1, NRD -> 1, *)
	A4 = { OptionValue[RDSW], OptionValue[RDSWMIN], OptionValue[RDW], OptionValue[RDWMIN], OptionValue[RSW], OptionValue[RSWMIN],
		OptionValue[PRWG], OptionValue[PRWB], OptionValue[WR], OptionValue[NRS], OptionValue[NRD] };
	
	(* ALPHA0 -> 0, ALPHA1 -> 0, BETA0 -> 0, *)
	A5 = { OptionValue[ALPHA0], OptionValue[ALPHA1], OptionValue[BETA0] };
	
	(* AGIDL -> 0, BGIDL -> 2.3*10^9, CGIDL -> 0.5, EGIDL -> 0.8, RGIDL -> 1, KGIDL -> 0, FGIDL -> 0, AGISL -> $Failed, BGISL -> $Failed,
	CGISL -> $Failed, EGISL -> $Failed, RGISL -> $Failed, KGISL -> $Failed, FGISL -> $Failed, *)
	agisl = If[ OptionValue[AGISL] == $Failed, OptionValue[AGIDL], OptionValue[AGISL] ];
	bgisl = If[ OptionValue[BGISL] == $Failed, OptionValue[BGIDL], OptionValue[BGISL] ];
	cgisl = If[ OptionValue[CGISL] == $Failed, OptionValue[CGIDL], OptionValue[CGISL] ];
	egisl = If[ OptionValue[EGISL] == $Failed, OptionValue[EGIDL], OptionValue[EGISL] ];
	fgisl = If[ OptionValue[FGISL] == $Failed, OptionValue[FGIDL], OptionValue[FGISL] ];
	kgisl = If[ OptionValue[KGISL] == $Failed, OptionValue[KGIDL], OptionValue[KGISL] ];
	rgisl = If[ OptionValue[RGISL] == $Failed, OptionValue[RGIDL], OptionValue[RGISL] ];
	A6 = { OptionValue[AGIDL], OptionValue[BGIDL], OptionValue[CGIDL], OptionValue[EGIDL], OptionValue[RGIDL], OptionValue[KGIDL], 
		OptionValue[FGIDL], agisl, bgisl, cgisl, egisl, rgisl, kgisl, fgisl };
	
	(* AIGBACC -> 9.49*10^-4, BIGBACC -> 1.71*10^-3, CIGBACC -> 0.075, NIGBACC -> 1, AIGBINV -> 1.11*10^-2, BIGBINV ->9.49*10^-4, 
	CIGBINV -> 0.006, EIGBINV -> 1.1, NIGBINV -> 3, AIGC -> $Failed, BIGC -> $Failed, CIGC -> $Failed, AIGS -> $Failed, BIGS -> $Failed,
	CIGS -> $Failed, DLCIG -> $Failed, AIGD -> $Failed, BIGD -> $Failed, CIGD -> $Failed, DLCIGD -> $Failed, NIGC -> 1, POXEDGE -> 1,
	PIGCD -> 1, NTOX -> 1, TOXREF -> 3*10^-9, VFBSDOFF -> 0, *)
	aigc = If[ OptionValue[AIGC] == $Failed,
			If[ OptionValue[TYPE] == "NMOS", 1.36*10^-2, 9.8*10^-3 ],
			OptionValue[AIGC]
	];
	bigc = If[ OptionValue[BIGC] == $Failed,
			If[ OptionValue[TYPE] == "NMOS", 1.71*10^-3, 7.59*10^-4 ],
			OptionValue[BIGC]
	];
	cigc = If[ OptionValue[CIGC] == $Failed,
			If[ OptionValue[TYPE] == "NMOS", 0.075, 0.03 ],
			OptionValue[CIGC]
	];
	aigs = If[ OptionValue[AIGS] == $Failed,
			If[ OptionValue[TYPE] == "NMOS", 1.36*10^-2, 9.8*10^-3 ],
			OptionValue[AIGS]
	];
	bigs = If[ OptionValue[BIGS] == $Failed,
			If[ OptionValue[TYPE] == "NMOS", 1.71*10^-3, 7.59*10^-4 ],
			OptionValue[BIGS]
	];
	cigs = If[ OptionValue[CIGS] == $Failed,
			If[ OptionValue[TYPE] == "NMOS", 0.075, 0.03 ],
			OptionValue[CIGS]
	];
	aigd = If[ OptionValue[AIGD] == $Failed,
			If[ OptionValue[TYPE] == "NMOS", 1.36*10^-2, 9.8*10^-3 ],
			OptionValue[AIGD]
	];
	bigd = If[ OptionValue[BIGD] == $Failed,
			If[ OptionValue[TYPE] == "NMOS", 1.71*10^-3, 7.59*10^-4 ],
			OptionValue[BIGD]
	];
	cigd = If[ OptionValue[CIGD] == $Failed,
			If[ OptionValue[TYPE] == "NMOS", 0.075, 0.03 ],
			OptionValue[CIGD]
	];
	dlcig = If[ OptionValue[DLCIG] == $Failed, OptionValue[LINT], OptionValue[DLCIG] ];
	dlcigd = If[ OptionValue[DLCIGD] == $Failed, OptionValue[LINT], OptionValue[DLCIGD] ];
	A7 = { OptionValue[AIGBACC], OptionValue[BIGBACC], OptionValue[CIGBACC], OptionValue[NIGBACC], OptionValue[AIGBINV], OptionValue[BIGBINV],
	OptionValue[CIGBINV], OptionValue[EIGBINV], OptionValue[NIGBINV], aigc, bigc, cigc, aigs, bigs, cigs, dlcig, aigd, bigd, cigd, 
	dlcigd, OptionValue[NIGC], OptionValue[POXEDGE], OptionValue[PIGCD], OptionValue[NTOX], OptionValue[TOXREF], OptionValue[VFBSDOFF]};
	
	(* XPART -> 0, CGSO -> $Failed, CGDO -> $Failed, CGBO -> 0, CGSL -> 0, CGDL -> 0, CKAPPAS -> 0, CKAPPAD -> $Failed, CF -> $Failed, 
	CLC -> 10^-7, CLE -> 0.6, DLC -> $Failed, DWC -> $Failed, VFBCV -> -1, NOFF -> 1, VOFFCV -> 0, VOFFCVL ->0, MINVCV -> 0, ACDE -> 1,
	MOIN -> 15, *)
	dwc = If[ OptionValue[DWC] == $Failed, OptionValue[WINT], OptionValue[DWC] ];
	dlc = If[ OptionValue[DLC] == $Failed, OptionValue[LINT], OptionValue[DLC] ];
	cgso = If[ ( OptionValue[DLC] != $Failed ) && ( OptionValue[DLC] > 0 ),
		 OptionValue[DLC]*coxe - OptionValue[CGSL],
		 0.6*OptionValue[XJ]*coxe
	];
	cgso = If[ cgso < 0, 0, cgso ];
	ckappad = If[ OptionValue[CKAPPAD] == $Failed, OptionValue[CKAPPAS], OptionValue[CKAPPAD] ];
	cf = 0; (* This needs to be set! *)
	cgdo = 0; (* This needs to be set! *)
	A8 = { OptionValue[XPART], cgso, cgdo, OptionValue[CGBO], OptionValue[CGSL], OptionValue[CGDL], OptionValue[CKAPPAS], ckappad, cf,
	OptionValue[CLC], OptionValue[CLE], dlc, dwc, OptionValue[VFBCV], OptionValue[NOFF], OptionValue[VOFFCV], OptionValue[VOFFCVL],
	OptionValue[MINVCV], OptionValue[ACDE], OptionValue[MOIN] };
	
	(* XRCRG1 -> 12, XRCRG2 -> 1, RBPB -> 50, RBPD -> 50, RBPS -> 50, RBDB -> 50, RBSB -> 50, GBMIN -> 10^-12, RBPS0 -> 50, RBPSL -> 0, 
	RBPSW -> 0, RBPSNF -> 0, RBPD0 -> 50, RBPDL -> 0, RBPDW -> 0, RBPDNF -> 0, RBPBX0 -> 100, RBPBXL -> 0, RBPBXW -> 0, RBPBXNF -> 0,
	RBPBY0 -> 100, RBOBYW -> 0, RBPBYL -> 0, RBPBYNF -> 0, RBSBX0 -> 100, RBSBY0 -> 100, RBDBX0 -> 100, RBDBY0 -> 100, RBSDBXL -> 0, 
	RBSDBXW -> 0, RBSDBXNF -> 0, RBSDBYL -> 0, RBSDBYW ->0, RBSDBYNF -> 0, *)
	A9 = { OptionValue[XRCRG1], OptionValue[XRCRG2], OptionValue[RBPB], OptionValue[RBPD], OptionValue[RBPS], OptionValue[RBDB],
		OptionValue[RBSB], OptionValue[GBMIN], OptionValue[RBPS0], OptionValue[RBPSL], OptionValue[RBPSW], OptionValue[RBPSNF], 
		OptionValue[RBPD0], OptionValue[RBPDL], OptionValue[RBPDW], OptionValue[RBPDNF], OptionValue[RBPBX0], OptionValue[RBPBXL],
		OptionValue[RBPBXW], OptionValue[RBPBXNF], OptionValue[RBPBY0], OptionValue[RBOBYW], OptionValue[RBPBYL], OptionValue[RBPBYNF],
		OptionValue[RBSBX0], OptionValue[RBSBY0], OptionValue[RBDBX0], OptionValue[RBDBY0], OptionValue[RBSDBXL], OptionValue[RBSDBXW],
		OptionValue[RBSDBXNF], OptionValue[RBSDBYL], OptionValue[RBSDBYW], OptionValue[RBSDBYNF] };
		
	(* NOIA -> $Failed, NOIB -> $Failed, NOIC -> 8.75, EM -> 4.1*10^7, AF -> 1, EF -> 1, KF -> 0, LINTNOI -> 0, NTNOI -> 1, TNOIA -> 1.5, 
	TNOIB -> 3.5, TNOIC -> 0, RNOIA -> 0.577, RNOIB -> 0.5164, RNOIC -> 0.395, *)
	noia = If[ OptionValue[NOIA] == $Failed, If[ OptionValue[TYPE] == "NMOS", 6.25*10^41, 6.188*10^40 ], OptionValue[NOIA] ];
	noib = If[ OptionValue[NOIB] == $Failed, If[ OptionValue[TYPE] == "NMOS", 3.125*10^26 1.5*10^25 ], OptionValue[NOIB] ];
	A10 = { noia, noib, OptionValue[NOIC], OptionValue[EM], OptionValue[AF], OptionValue[EF], OptionValue[KF], OptionValue[LINTNOI],
	OptionValue[NTNOI], OptionValue[TNOIA], OptionValue[TNOIB], OptionValue[TNOIC], OptionValue[RNOIA], OptionValue[RNOIB],
	OptionValue[RNOIC] };
	
	(* DMCG -> 0, DMCI -> $Failed, DMDG -> 0, DMCGT -> 0, NF -> 1, DWJ -> $Failed, MIN -> 0, XGW -> 0, XGL -> 0, XL -> 0, XW ->0, NGCON -> 1, *)
	dmci = If[ OptionValue[DMCI] == $Failed, OptionValue[DMCG], OptionValue[DMCI] ];
	dwj = If[ OptionValue[DWJ] == $Failed, OptionValue[DWC], OptionValue[DWJ] ];
	A11 = { OptionValue[DMCG], dmci, OptionValue[DMDG], OptionValue[DMCGT], OptionValue[NF], dwj, OptionValue[MIN], OptionValue[XGW],
		OptionValue[XGL], OptionValue[XL], OptionValue[XW], OptionValue[NGCON] };
		
	(* IJTHSREV -> 0.1, IJTHDREV -> $Failed, IJTHSFWD -> 0.1, IJTHDFWD -> $Failed, XJBVS -> 1, XJBVD -> $Failed, BVS -> 10, BVD -> $Failed,
	JSS -> 10^-4, JSD -> $Failed, JSWS -> 0, JSWD -> $Failed, JSWGS -> 0, JSWGD -> $Failed, JTSS -> 0, JTSD -> $Failed, JTSSWS -> 0, 
	JTSSWD -> $Failed, JTSSWGS -> 0, JTSSWGD -> $Failed, JTWEFF -> 0, NJTS -> 20, NJTSD -> $Failed, NJTSSW -> 20, NJTSSWD -> $Failed, 
	NJTSWG -> 20, NJTSSWGD -> $Failed, XTSS -> 0.02, XTSD -> 0.02, XTSSWS -> 0.02, XTSSWD -> 0.02, XTSSWGS -> 0.02, XTSSWGD -> 0.02,
	VTSS -> 10, VTSD -> $Failed, VTSSWS -> 10, VTSSWD -> $Failed, VTSSWGS -> 10, VTSSWGD -> $Failed, TNJTS -> 0, TNJTSD -> $Failed,
	TNJTSSW -> 0, TNJTSSWD -> $Failed, TNJTSSWG -> 0, TNJTSSWGD -> $Failed, CJS -> 50*10^-4, CJD -> $Failed, MJS -> 0.5, MJD -> $Failed,
	MJSWS -> 0.33, MJSWD -> $Failed, CJSWS -> 50*10^-10, CJSWD -> $Failed, CJSWGS -> $Failed, CJSWGD -> $Failed, MJSWGS -> $Failed, 
	MJSWGD -> $Failed, PBS -> 1, PBD -> $Failed, PBSWS -> 1, PBSWD -> $Failed, PBSWGS -> $Failed, PBSWGD -> $Failed, *)
	ijthdrev = 0;
	ijthdwfd = 0;
	xjbvd = 0;
	bvd = 0;
	jsd = 0;
	jswd = 0;
	jswgd = 0;
	jtsd = 0;
	jtsswd = 0;
	jtsswgd = 0;
	njtsd = 0;
	njtsswd = 0;
	njtsswgd = 0;
	vtsd = 0;
	vtsswd = 0;
	vtsswgd = 0;
	tnjtsd = 0;
	tnjtsswd = 0;
	tnjtsswgd = 0;
	cjd = 0;
	mjd = 0;
	mjswd = 0;
	cjswgs = 0;
	cjswgd = 0;
	mjswgs = 0;
	mjswgd = 0;
	pbd = 0;
	pbswd = 0;
	pbswgs = 0;
	pbswgd = 0;
	A12 = { OptionValue[IJTHSREV], ijthdrev, OptionValue[IJTHSFWD], ijthdfwd, OptionValue[XJBVS], xjbvd, OptionValue[BVS], bvd, OptionValue[JSS],
	jsd, OptionValue[JSWS], jswd, OptionValue[JSWGS], jswgd, OptionValue[JTSS], jtsd, OptionValue[JTSSWS], jtsswd, OptionValue[JTSSWGS],
	jtsswgd, OptionValue[JTWEFF], OptionValue[NJTS], njtsd, OptionValue[NJTSSW], njtsswd, OptionValue[NJTSWG], njtsswgd, OptionValue[XTSS],
	OptionValue[XTSD], OptionValue[XTSSWS], OptionValue[XTSSWD], OptionValue[XTSSWGS], OptionValue[XTSSWGD], OptionValue[VTSS], vtsd,
	OptionValue[VTSSWS], vtsswd, OptionValue[VTSSWGS], vtsswgd, OptionValue[TNJTS], tnjtsd, OptionValue[TNJTSSW], tnjtsswd, 
	OptionValue[TNJTSSWG], tnjtsswgd, OptionValue[CJS], cjd, OptionValue[MJS], mjd, OptionValue[MJSWS], mjswd, OptionValue[CJSWS], cjswd,
	OptionValue[CJSWGS], cjswgd, mjswgs, mjswgd, OptionValue[PBS], pbd, OptionValue[PBSWS], pbswd, pbswgs, pbswgd };
	
	(* If[ BSIM47Internal`SetModelPerameters[ A1 ] == 1,
		Message[BSIM4Mathematica::A1];
		Return[$Failed];
	] *)
	
	{A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12}
];

(*
	This function will let the user set parameters for the MOS instance they would like to simulate.
	The function has the following steps:
		1.	Process all parameters, filling in missing values that the C routine expects
		2. 	Perform sanity checks on all parameters
		3.	Convert all parameters to Real and send through the link
		4.	Alert the user to success or failure of the link
*)
SetInstanceCard[ OptionsPattern[] ] := Block[ {},
	True
];

(*
	This is an internal function that is used to open the link to communicate with the C binary.
	The function has the following steps:
		1. Check that the link object is not NULL
			a. If the link object is NULL then continue with 2)
			b. Check that the link is valid and running. If not, continue with 2) otherwise return success.
		2.	Open a link to the binary and update the link object
		3.	Return successfully if the link could be created
*)
OpenMathLink[ OptionsPattern[] ] := Block[ {},
	True
];

(*
	This internal function closes an open MathLink connection with the C binary.
	The following steps are performed:
		1.	Check that the link object is not NULL
			a. If it is NULL, return successfully
		2.	Check that the link object is valid
			a. If it is not valid, reset the link object to NULL and return successfully
		3.	Close the link object and return successfully.
*)
CloseMathLink[ OptionsPattern[] ] := Block[ {},
	True
];

End[]

EndPackage[]

