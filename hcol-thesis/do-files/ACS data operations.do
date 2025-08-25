/* If you are interested in utilizing this code, please edit filepaths as needed */

/*
********************************************************************************
SETUP
********************************************************************************
*/

/* Open MSA list sheet */
import excel ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/ACS data (main).xlsx" ///
	, firstrow

	
/* Rename and label existing variables/identifiers */
rename CensusDivision division

rename CensusRegion region

rename DivisionID division_id

rename Education educ_prop
replace educ_prop = educ_prop / 100
label var educ_prop "Prop. of MSA pop. aged 25+ with at least a bachelor's degree"

rename FBPpost2010 fbp_2010
label var fbp_2010 "Foreign-born MSA pop. that entered US after 2010"

rename Foreignbornpopulation fbp
label var fbp "Foreign-born MSA pop."

rename Houseprice home_price
label var home_price "Median MSA house price (nominal)"

rename MedianRealEstateTaxesPaid tax
label var tax "Median real estate taxes paid in last 12 months"

rename MSAName msa_name

rename MSAID msa_id

rename Nativebornpopulation native_pop
label var native_pop "Native-born MSA pop."

rename OccupationGroup1 agro_prop
replace agro_prop = agro_prop / 100
label var agro_prop "Prop. of civilian employed pop. aged 16 and over employed in agriculture, forestry, fishing, hunting, or mining"

rename OccupationGroup2 const_prop
replace const_prop = const_prop / 100
label var const_prop "Prop. of civilian employed pop. aged 16 and over employed in construction"

rename OccupationGroup3 manu_prop
replace manu_prop = manu_prop / 100
label var manu_prop "Prop. of civilian employed pop. aged 16 and over employed in manufacturing"

rename OccupationGroup4 whol_prop
replace whol_prop = whol_prop / 100
label var whol_prop "Prop. of civilian employed pop. aged 16 and over employed in wholesale trade"

rename OccupationGroup5 ret_prop
replace ret_prop = ret_prop / 100
label var ret_prop "Prop. of civilian employed pop. aged 16 and over employed in retail trade"

rename OccupationGroup6 trans_prop
replace trans_prop = trans_prop / 100
label var trans_prop "Prop. of civilian employed pop. aged 16 and over employed in transportation, warehousing, and utilities"

rename OccupationGroup7 info_prop
replace info_prop = info_prop / 100
label var info_prop "Prop. of civilian employed pop. aged 16 and over employed in information"

rename OccupationGroup8 fin_prop
replace fin_prop = fin_prop / 100
label var fin_prop "Prop. of civilian employed pop. aged 16 and over employed in finance, insurance, or real estate"

rename OccupationGroup9 prof_prop
replace prof_prop = prof_prop / 100
label var prof_prop "Prop. of civilian employed pop. aged 16 and over employed in professional, scientific, or management or administrative services"

rename OccupationGroup10 soc_prop
replace soc_prop = soc_prop / 100
label var soc_prop "Prop. of civilian employed pop. aged 16 and over employed in educational, health, or social services"

rename OccupationGroup11 arts_prop
replace arts_prop = arts_prop / 100
label var arts_prop "Prop. of civilian employed pop. aged 16 and over employed in arts, entertainment, or recreation"

rename OccupationGroup12 others_prop
replace others_prop = others_prop / 100
label var others_prop "Prop. of civilian employed pop. aged 16 and over employed in other services"

rename OccupationGroup13 govt_prop
replace govt_prop = govt_prop / 100
label var govt_prop "Prop. of civilian employed pop. aged 16 and over employed in public administration"

rename Percapitaincome income
label var income "Per capita personal MSA income"

rename PrincipalState state
label var state "Principal state of MSA"

rename RegionID region_id

rename Rentalrate rent
label var rent "Median contract rent (nominal)"

rename StateID state_id

rename StockofvacantOOunits oo_units
label var oo_units "Stock of vacant units for sale"

rename Stockofvacantrentalunits rental_units
label var rental_units "Stock of vacant units for rent"

rename Totalpopulation total_pop
label var total_pop "Total MSA population"

rename Unemploymentrate unem_prop
replace unem_prop = unem_prop / 100
label var unem_prop "MSA unemployment rate"

rename Year year


/* Set time variable & establish panel */
xtset msa_id year

/* Creates time dummies */
gen y13 = 0
replace y13 = 1 if year == 2013

gen y14 = 0
replace y14 = 1 if year == 2014

gen y15 = 0
replace y15 = 1 if year == 2015

gen y16 = 0
replace y16 = 1 if year == 2016

gen y17 = 0
replace y17 = 1 if year == 2017

gen y18 = 0
replace y18 = 1 if year == 2018

gen y19 = 0
replace y19 = 1 if year == 2019

gen y20 = 0
replace y20 = 1 if year == 2020

gen y21 = 0
replace y21 = 1 if year == 2021

gen y22 = 0
replace y22 = 1 if year == 2022

/* Creates census region dummies */
gen r1 = 0
replace r1 = 1 if region_id == 1

gen r2 = 0
replace r2 = 1 if region_id == 2

gen r3 = 0
replace r3 = 1 if region_id == 3

gen r4 = 0
replace r4 = 1 if region_id == 4



/* Drop all obs. from Puerto Rico */
drop if mod(msa_id, 1) != 0

/* Drop any MSA with insufficient years of data */
drop if msa_id == 111
drop if msa_id == 279
drop if msa_id == 353




/*
********************************************************************************
IMMIGRATION VARIABLE CONSTRUCTION
********************************************************************************
*/

gen d_fbp_2010 = d.fbp_2010
label var d_fbp_2010 "FD of foreign-born MSA pop. that entered US after 2010"

gen immigration = L.d_fbp_2010 / L2.total_pop
label var immigration "Lagged FBP-post-2010 growth as a proportion of double-lagged total population"


/*
********************************************************************************
OTHER POPULATION VARIABLE CONSTRUCTION
********************************************************************************
*/

gen native_prop = native_pop / total_pop
label var native_prop "Prop. of MSA pop. that is native-born"

gen fb_prop = fbp / total_pop
label var fb_prop "Prop. of MSA pop. that is foreign-born"

gen fb_2010_prop = fbp_2010 / total_pop
label var fb_2010_prop "Prop. of MSA pop. that is foreign-born & entered US after 2010"

gen pop_growth = L.d.total_pop / L2.total_pop
label var pop_growth "Lagged population growth as a proportion of double-lagged total population"

gen nat_pop_growth = L.d.native_pop / L2.total_pop
label var nat_pop_growth "Lagged native population growth as a proportion of double-lagged total population"


/*
********************************************************************************
INFLATION ADJUSTMENT
********************************************************************************
*/

/* Get CPI for all years & inflation adjustment factors */
gen cpi = .
label var cpi "CPI (from FRB of Minneapolis, BY 1983)"
replace cpi = 233 if year == 2013
replace cpi = 236.7 if year == 2014
replace cpi = 237 if year == 2015
replace cpi = 240 if year == 2016
replace cpi = 245.1 if year == 2017
replace cpi = 251.1 if year == 2018
replace cpi = 255.7 if year == 2019
replace cpi = 258.8 if year == 2020
replace cpi = 271 if year == 2021
replace cpi = 292.7 if year == 2022

gen inf_adj = .
label var inf_adj "Inflation adjustment factor (puts all $ values in 2022 $)"
replace inf_adj = 297.7 / 233 if year == 2013
replace inf_adj = 297.7 / 236.7 if year == 2014
replace inf_adj = 297.7 / 237 if year == 2015
replace inf_adj = 297.7 / 240 if year == 2016
replace inf_adj = 297.7 / 245.1 if year == 2017
replace inf_adj = 297.7 / 251.1 if year == 2018
replace inf_adj = 297.7 / 255.7 if year == 2019
replace inf_adj = 297.7 / 258.8 if year == 2020
replace inf_adj = 297.7 / 271 if year == 2021
replace inf_adj = 1 if year == 2022


/* Inflation-adjust necessary variables */
gen r_income = income * inf_adj
label var r_income "Real per capita personal income (2022 $)"

gen r_rent = rent * inf_adj
label var r_rent "Real median contract rent (2022 $)"

gen r_hp = home_price * inf_adj
label var r_hp "Real median home value (2022 $)"

gen r_tax = tax * inf_adj
label var r_tax "Real median real estate taxes paid in last 12 months"




/*
********************************************************************************
VARIABLE RE-DEFINITION
********************************************************************************
*/

/* Take log of necessary variables */
gen r_lrent = log(r_rent)
label var r_lrent "Log of real rental rates"

gen r_lhp = log(r_hp)
label var r_lhp "Log of real house prices"

gen r_lincome = log(r_income)
label var r_lincome "Log of real per capita personal income"

gen lrunits = log(rental_units)
label var lrunits "Log of stock of vacant rental units"

gen lounits = log(oo_units)
label var lounits "Log of stock of vacant units for sale"

gen r_ltax = log(r_tax)
label var r_ltax "Log of real median real estate taxes paid in last 12 months"


/* First-difference time-variant variables */
gen d_r_lrent = d.r_lrent
label var d_r_lrent "FD of log of real rental rates"

gen d_r_lhp = d.r_lhp
label var d_r_lhp "FD of log of real house prices"

gen d_r_lincome = d.r_lincome
label var d_r_lincome "FD of log of real per capita personal income"

gen d_educ_prop = d.educ_prop
label var d_educ_prop "FD of education variable"

gen d_unem_prop = d.unem_prop
label var d_unem_prop "FD of unemployment variable"

gen d_lrunits = d.lrunits
label var d_lrunits "FD of log of stock of vacant rental units"

gen d_lounits = d.lounits
label var d_lounits "FD of log of stock of vacant units for sale"

gen d_lrtax = log(r_tax)
label var d_lrtax "FD of log of real median real estate taxes paid in last 12 months"

gen d_agro_prop = d.agro_prop
label var d_agro_prop "FD of agro_prop variable"

gen d_const_prop = d.const_prop
label var d_const_prop "FD of const_prop variable"

gen d_manu_prop = d.manu_prop
label var d_manu_prop "FD of manu_prop variable"

gen d_whol_prop = d.whol_prop
label var d_whol_prop "FD of whol_prop variable"

gen d_ret_prop = d.ret_prop
label var d_ret_prop "FD of ret_prop variable"

gen d_trans_prop = d.trans_prop
label var d_trans_prop "FD of trans_prop variable"

gen d_info_prop = d.info_prop
label var d_info_prop "FD of info_prop variable"

gen d_fin_prop = d.fin_prop
label var d_fin_prop "FD of fin_prop variable"

gen d_prof_prop = d.prof_prop
label var d_prof_prop "FD of prof_prop variable"

gen d_soc_prop = d.soc_prop
label var d_soc_prop "FD of soc_prop variable"

gen d_arts_prop = d.arts_prop
label var d_arts_prop "FD of arts_prop variable"

gen d_others_prop = d.others_prop
label var d_others_prop "FD of others_prop variable"

gen d_govt_prop = d.govt_prop
label var d_govt_prop "FD of govt_prop variable"


	
	
/*
********************************************************************************
US-LEVEL SHIFT-SHARE LEVEL INSTRUMENT TESTING
********************************************************************************
*/	

* I calculated predicted immigration in Excel *
gen shift_share = L.pred_imm / L2.total_pop
label var shift_share "US-level shift-share instrument"


* Relevance test - 1st stage regression *
xtreg immigration shift_share ///
	L.d_r_lincome L.d.unem_prop L.d.educ_prop ///
	L.d_agro_prop L.const_prop L.manu_prop, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/IV relevance - 1st stage.doc", append




/*
********************************************************************************
SAVE CHANGES TO DATASET or OPEN DATATEST
********************************************************************************
*/

/* Save changes to sheet */
save "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Main thesis data file (ACS).dta" ///
	, replace
	
use "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Main thesis data file (ACS).dta"
	
	
/*
********************************************************************************
SUMMARY STATS & BASIC CHARTS
********************************************************************************
*/

/* Summary stats */
by msa_id (year), sort: gen rent_change = r_rent - r_rent[_n-1]
by msa_id (year), sort: gen hp_change = r_hp - r_hp[_n-1]

sum d_r_lrent
sum d_r_lhp
sum immigration
sum nat_pop_growth
sum L.d_r_lincome
sum L.unem_prop
sum L.educ_prop
sum L.agro_prop
sum L.const_prop
sum L.manu_prop

	

/* Scatter plot of immigration variable on housing market outcomes */
xtreg r_rent fb_2010_prop
twoway (scatter r_rent fb_2010_prop, mcolor(navy)) ///
	(lfit r_rent fb_2010_prop, lcolor(red)), ///
	legend(off) ///
	scheme(plain) ///
	title("Rent & Immigrant Concentration", size(5)) ///
	subtitle("Rent in 2022 dollars", size(2.5)) ///
	xtitle("Immigrant concentration", size(3.5)) ///
	ytitle("Median gross rent", size(3.5)) ///
	xlabel(0(0.05)0.15) ///
	ylabel(500(500)2500, angle(0))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Immigration-rents scatterplot.png" ///
	, replace
	
xtreg r_hp fb_2010_prop
twoway (scatter r_hp fb_2010_prop, mcolor(navy)) ///
	(lfit r_hp fb_2010_prop, lcolor(red)), ///
legend(off) ///
	scheme(plain) ///
	title("Home Value & Immigrant Concentration", size(5)) ///
	subtitle("Home value in 2022 dollars", size(2.5)) ///
	xtitle("Immigrant concentration", size(3.5)) ///
	ytitle("Median home value", size(3.5)) ///
	xlabel(0(0.05)0.15) ///
	ylabel(0(250000)1500000, angle(0))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Immigration-HP scatterplot.png" ///
	, replace
	
	
	
	
/*
********************************************************************************
REGRESSIONS
********************************************************************************
*/

/* OLS results */
xtreg d_r_lrent immigration i.year, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/OLS results.doc", append

xtreg d_r_lrent immigration L.d_r_lincome L.unem_prop L.educ_prop i.year, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/OLS results.doc", append

xtreg d_r_lrent immigration ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop i.year, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/OLS results.doc", append


xtreg d_r_lhp immigration i.year, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/OLS results.doc", append

xtreg d_r_lhp immigration L.d_r_lincome L.unem_prop L.educ_prop i.year, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/OLS results.doc", append

xtreg d_r_lhp immigration ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop i.year, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/OLS results.doc", append


/* IV results */
xtivreg2 d_r_lrent (immigration = shift_share) ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/IV results.doc", append 

xtivreg2 d_r_lhp (immigration = shift_share) ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/IV results.doc", append


/* IV results - test for native outmigration */
* If we reject that B (immigration) = 0, the previous estimators may have been picking up effects from native migration *
xtivreg2 d_r_lrent (immigration = shift_share) ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Partial Fx results (Rent).doc", append 

xtivreg2 d_r_lrent (pop_growth = shift_share) ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Partial Fx results (Rent).doc", append 

xtivreg2 nat_pop_growth (immigration = shift_share) ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Partial Fx results (Rent).doc", append 


xtivreg2 d_r_lhp (immigration = shift_share) ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Partial Fx results (HP).doc", append 

xtivreg2 d_r_lhp (pop_growth = shift_share) ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Partial Fx results (HP).doc", append 

xtivreg2 nat_pop_growth (immigration = shift_share) ///
	L.d_r_lincome L.unem_prop L.educ_prop ///
	L.agro_prop L.const_prop L.manu_prop ///
	y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 ///
	, fe cluster(msa_id)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Partial Fx results (HP).doc", append 


/* IV quantile regressions */
gen lag_inc = L.d_r_lincome
gen lag_unem = L.unem_prop
gen lag_educ = L.educ_prop
gen lag_agro = L.agro_prop
gen lag_const = L.const_prop
gen lag_manu = L.manu_prop

bysort msa_id: egen mean_x = mean(immigration)
gen x_demeaned = immigration - mean_x

ivqregress iqr d_r_lrent (x_demeaned = shift_share) ///
	lag_inc lag_unem lag_educ ///
    lag_agro lag_const lag_manu ///
	i.year ///
	, quantile(0.05 0.25 0.5 0.75 0.95)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Quantile regs (Rent).doc", append

ivqregress iqr d_r_lhp (x_demeaned = shift_share) ///
	lag_inc lag_unem lag_educ ///
    lag_agro lag_const lag_manu ///
	i.year ///
	, quantile(0.05 0.25 0.5 0.75 0.95)
outreg2 using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/THESIS/Results/Quantile regs (HP).doc", append

	
	
/* End */
clear
