/*
********************************************************************************
SETUP
********************************************************************************
*/

/* Open MSA list sheet */
import excel ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Thesis data (OHSS).xlsx" ///
	, firstrow
	
xtset msa_id year
	
gen immigration = L.lpr / L2.totalpop

