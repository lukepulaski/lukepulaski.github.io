
use "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/ACS data (reduced sample).dta"

/*
MSAs NOT DROPPED:
Atlanta
Austin
Baltimore
Boston
Bridgeport
Charlotte
Chicago
Cincinnati
Cleveland
Columbus
Dallas
Denver
Detroit
El Paso
Fresno
Hartford
Houston
Indianapolis
Jacksonville
Kansas City
Las Vegas
Los Angeles
McAllen
Miami
Minneapolis
Nashville
New York
Orlando
Philadelphia
Phoenix
Portland
Providence
Raleigh
Riverside
Sacramento
Salt Lake City
San Antonio
San Diego
San Francisco
San Jose
Seattle
Stockton
Tampa
Urban Honolulu
Washington DC
Worcester
*/

drop if ///
	msa_id != 18 & ///
	msa_id != 22 & ///
	msa_id != 24 & ///
	msa_id != 43 & ///
	msa_id != 47 & ///
	msa_id != 65 & ///
	msa_id != 69 & ///
	msa_id != 71 & ///
	msa_id != 74 & ///
	msa_id != 82 & ///
	msa_id != 87 & ///
	msa_id != 96 & ///
	msa_id != 98 & ///
	msa_id != 110 & ///
	msa_id != 128 & ///
	msa_id != 152 & ///
	msa_id != 160 & ///
	msa_id != 164 & ///
	msa_id != 170 & ///
	msa_id != 181 & ///
	msa_id != 198 & ///
	msa_id != 211 & ///
	msa_id != 222 & ///
	msa_id != 226 & ///
	msa_id != 231 & ///
	msa_id != 246 & ///
	msa_id != 250 & ///
	msa_id != 261 & ///
	msa_id != 270 & ///
	msa_id != 271 & ///
	msa_id != 277 & ///
	msa_id != 281 & ///
	msa_id != 286 & ///
	msa_id != 292 & ///
	msa_id != 299 & ///
	msa_id != 308 & ///
	msa_id != 310 & ///
	msa_id != 311 & ///
	msa_id != 312 & ///
	msa_id != 313 & ///
	msa_id != 321 & ///
	msa_id != 339 & ///
	msa_id != 343 & ///
	msa_id != 355 & ///
	msa_id != 366 & ///
	msa_id != 379
	
xtset msa_id year

gen shift_share = L.pred_imm / L2.total_pop
label var shift_share "US-level shift-share instrument"
	
gen immigration_ohss = L.lpr / L2.total_pop

gen shift_share_ohss = L.pred_imm_ohss / L2.total_pop

gen shift_share_ohss_oc = L.pred_imm_ohss_oc / L2.total_pop


twoway (scatter immigration_ohss immigration) ///
	(function y = x, range(0 0.015) lpattern(dash)), ///
	xtitle("{&Delta}Immigration{sub:i, t-1} / Population{sub:i, t-2}") ///
	ytitle("{&Delta}LPR{sub:i, t-1} / Population{sub:i, t-2}") ///
	legend(off)
	
twoway (scatter var3 var1) ///
	(function y = x, range(0 0.12) lpattern(dash)), ///
	xtitle("Cumulative {&Delta}FBP_2010") ///
    xscale(range(0 0.12)) ///
	xlabel(0 0.04 0.08 0.12) ///
    ytitle("Cumulative {&Delta}LPR") ///
    yscale(range(0 0.12)) ///
	ylabel(0 0.04 0.08 0.12) ///
    legend(off)



xtreg d_r_lrent immigration ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Instrument robustness (Rents).doc", append 

xtivreg2 d_r_lrent (immigration = shift_share) ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Instrument robustness (Rents).doc", append 
	
xtreg d_r_lrent immigration_ohss ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Instrument robustness (Rents).doc", append 	

xtivreg2 d_r_lrent (immigration_ohss = shift_share_ohss) ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Instrument robustness (Rents).doc", append 
	
xtivreg2 d_r_lrent (immigration_ohss = shift_share_ohss_oc) ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Instrument robustness (Rents).doc", append 

	
xtreg d_r_lhp immigration ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Instrument robustness (HP).doc", append 

xtivreg2 d_r_lhp (immigration = shift_share) ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Instrument robustness (HP).doc", append 
	
xtreg d_r_lhp immigration_ohss ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Instrument robustness (HP).doc", append 	

xtivreg2 d_r_lhp (immigration_ohss = shift_share_ohss) ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Instrument robustness (HP).doc", append 
	
xtivreg2 d_r_lhp (immigration_ohss = shift_share_ohss_oc) ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Instrument robustness (HP).doc", append 
	
	


xtreg immigration shift_share ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Instrument robustness (1st stage).doc", append 

xtreg immigration_ohss shift_share_ohss ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Instrument robustness (1st stage).doc", append 
	
xtreg immigration_ohss shift_share_ohss_oc ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Instrument robustness (1st stage).doc", append 





xtreg d_r_lrent shift_share_ohss ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/OHSS Instrument validity (Reduced form).doc", append 

xtreg d_r_lrent shift_share_ohss_oc ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/OHSS Instrument validity (Reduced form).doc", append 

xtreg d_r_lhp shift_share_ohss ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/OHSS Instrument validity (Reduced form).doc", append 

xtreg d_r_lhp shift_share_ohss_oc ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/OHSS Instrument validity (Reduced form).doc", append 








	
	
save "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/ACS data (reduced sample).dta", replace
