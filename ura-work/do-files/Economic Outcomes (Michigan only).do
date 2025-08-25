/*
******************************************************************************
MERGING FUNCTIONS
******************************************************************************
*/

/* Function to rename & restructure tract identifiers for merge */
program define var_change
    syntax , file(string) sheet(string) genvar(string) genexp(string) vars(string)
    import excel "`file'", sheet("`sheet'") clear firstrow
	gen `genvar' = 	`genexp' + (1000 * STATEA)
    tokenize `vars'
    while "`1'" != "" & "`2'" != "" {
        rename `1' `2'
        macro shift 2
    }
    display "Variables renamed successfully"
end

/* Funciton to merge datasets */
program define dataset_merge
    syntax , master(string) using(string) keyvars(string)
    use "`master'", clear
    merge m:m `keyvars' using "`using'", force
	drop _merge
    save "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/MICHIGAN OUTCOMES.dta" ///
	, replace
    display "Datasets merged successfully"
	clear
end




/*
******************************************************************************
MERGING DATASETS
******************************************************************************
*/

/* Open & prep MENA concentration spreadsheet */
import excel ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/NATIONAL_MENA_TRACT.xlsx" ///
	, clear firstrow

save "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/NATIONAL_MENA_TRACT.dta" ///
	, replace

clear


/* Open & prep Median HH Income spreadsheet, merge into Michigan Outcomes dataset */
var_change, ///
	file("/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/ACS Data/Median HH Income.xlsx") ///
	sheet("Sheet1") genvar("COUNTYFP") genexp("COUNTYA") vars("STATEA" "STATEFP" "TRACTA" "TRACTFP")
save "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Outcome Datasets/Median HH Income.dta" ///
	, replace
clear
dataset_merge, ///
master("/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/NATIONAL_MENA_TRACT.dta") ///
using("/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Outcome Datasets/Median HH Income.dta") ///
keyvars("STATEFP" "COUNTYFP" "TRACTFP")


/* Open & prep Labor Market Indicators spreadsheet, merge into Michigan Outcomes dataset */
var_change, ///
	file("/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/ACS Data/Labor Market Indicators.xlsx") ///
	sheet("Sheet1") genvar("COUNTYFP") genexp("COUNTYA") vars("STATEA" "STATEFP" "TRACTA" "TRACTFP")
save "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Outcome Datasets/Labor Market Indicators.dta" ///
	, replace
clear
dataset_merge, ///
master("/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/MICHIGAN OUTCOMES.dta") ///
using("/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Outcome Datasets/Labor Market Indicators.dta") ///
keyvars("STATEFP" "COUNTYFP" "TRACTFP")


/* Open & prep Public Assistance Income spreadsheet, merge into Michigan Outcomes dataset */
var_change, ///
	file("/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/ACS Data/Public assistance income.xlsx") ///
	sheet("Sheet1") genvar("COUNTYFP") genexp("COUNTYA") vars("STATEA" "STATEFP" "TRACTA" "TRACTFP")
save "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Outcome Datasets/Public Assistance Income.dta" ///
	, replace
clear
dataset_merge, ///
master("/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/MICHIGAN OUTCOMES.dta") ///
using("/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Outcome Datasets/Public Assistance Income.dta") ///
keyvars("STATEFP" "COUNTYFP" "TRACTFP")


/* Open & prep Health Insurance spreadsheet, merge into Michigan Outcomes dataset */
var_change, ///
	file("/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/ACS Data/Health Insurance.xlsx") ///
	sheet("Sheet1") genvar("COUNTYFP") genexp("COUNTYA") vars("STATEA" "STATEFP" "TRACTA" "TRACTFP")
save "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Outcome Datasets/Health Insurance.dta" ///
	, replace
clear
dataset_merge, ///
master("/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/MICHIGAN OUTCOMES.dta") ///
using("/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Outcome Datasets/Health Insurance.dta") ///
keyvars("STATEFP" "COUNTYFP" "TRACTFP")


/* Open & prep Opportunity Insights spreadsheet, merge into Michigan Outcomes dataset */
var_change, ///
	file("/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Opportunity Insights Data/Neighborhood Characteristics by Census Tract (OI).xlsx") ///
	sheet("tract_covariates") genvar("COUNTYFP") genexp("COUNTYA") vars("STATEA" "STATEFP" "TRACTA" "TRACTFP")
save "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Outcome Datasets/Opportunity Insights.dta" ///
	, replace
clear
dataset_merge, ///
master("/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/MICHIGAN OUTCOMES.dta") ///
using("/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Outcome Datasets/Opportunity Insights.dta") ///
keyvars("STATEFP" "COUNTYFP" "TRACTFP")


/* Open & prep Educational Attainment spreadsheet, merge into Michigan Outcomes dataset */
var_change, ///
	file("/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/ACS Data/Educational Attainment.xlsx") ///
	sheet("Sheet1") genvar("COUNTYFP") genexp("COUNTYA") vars("STATEA" "STATEFP" "TRACTA" "TRACTFP")
save "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Outcome Datasets/Educational Attainment.dta" ///
	, replace
clear
dataset_merge, ///
master("/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/MICHIGAN OUTCOMES.dta") ///
using("/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Outcome Datasets/Educational Attainment.dta") ///
keyvars("STATEFP" "COUNTYFP" "TRACTFP")


/* Open & prep Housing Costs spreadsheet, merge into Michigan Outcomes dataset */
var_change, ///
	file("/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/ACS Data/Housing Costs.xlsx") ///
	sheet("Sheet1") genvar("COUNTYFP") genexp("COUNTYA") vars("STATEA" "STATEFP" "TRACTA" "TRACTFP")
save "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Outcome Datasets/Housing Costs.dta" ///
	, replace
clear
dataset_merge, ///
master("/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/MICHIGAN OUTCOMES.dta") ///
using("/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Outcome Datasets/Housing Costs.dta") ///
keyvars("STATEFP" "COUNTYFP" "TRACTFP")




/*
******************************************************************************
DATA CLEANING (getting rid of superfluous variables)
******************************************************************************
*/

use "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/MICHIGAN OUTCOMES.dta"

/* Drop all non-Michigan states */
drop if STATEFP != 26


/* Drop all variables except the following:
- MENA concentration ()
- Total census tract population
- Outcome variables */
drop GISJOIN
drop YEAR
drop STUSAB
drop REGIONA
drop DIVISIONA
drop COUSUBA
drop PLACEA
drop BLKGRPA
drop CONCITA
drop AIANHHA
drop RES_ONLYA
drop TRUSTA
drop AIHHTLI
drop AITSCEA
drop ANRCA
drop CBSAA
drop CSAA
drop METDIVA
drop NECTAA
drop CNECTAA
drop NECTADIVA
drop UAA
drop CDCURRA
drop SLDUA
drop SLDLA
drop ZCTA5A
drop SUBMCDA
drop SDELMA
drop SDSECA
drop SDUNIA
drop PCI
drop PUMAA
drop GEOID
drop BTTRA
drop BTBGA
drop GEO_ID
drop AMSQE003
drop AMSSE001
drop AMSSE003
drop AMSTE001
drop AMSTE003

drop cz
drop czname
drop emp2000
drop foreign_share2010
drop frac_coll_plus2000
drop frac_coll_plus2010
drop hhinc_mean2000
drop job_density_2013
drop jobs_highpay_5mi_2015
drop jobs_total_5mi_2015
drop mail_return_rate2010
drop mean_commutetime2000
drop med_hhinc1990
drop med_hhinc2016
drop poor_share1990
drop poor_share2000
drop poor_share2010
drop popdensity2000
drop popdensity2010
drop rent_twobed
drop share_asian2000
drop share_asian2010
drop share_black2000
drop share_black2010
drop share_hisp2000
drop share_hisp2010
drop share_white2000
drop share_white2010
drop singleparent_share1990
drop singleparent_share2000
drop singleparent_share2010
drop traveltime15_2010





/*
******************************************************************************
DATA CLEANING (renaming variables)
******************************************************************************
*/

/* Rename and label location vars */
rename STATE state
label var state "State name"

rename STATEFP state_fips
label var state_fips "State FIPS code"

rename COUNTY county
label var county "County name"

rename COUNTYA county_fips
label var county_fips "County FIPS code"

rename TRACTFP tract_fips
label var tract_fips "Tract FIPS code"

rename NAME tract_name
label var tract_name "Census tract name"

rename COUNTYFP state_county_fips
label var state_county_fips "State + county FIPS code"


/* Rename and label MENA & population vars */
rename TotalPopulation total_pop_nmt
label var total_pop_nmt "Total tract population (according to NMT sheet)"

rename AMWQE001 total_pop
label var total_pop "Total tract population (according to ACS)"

rename AMSQE001 total_hh
label var total_hh "Count of households in census tract"

rename pop_16 total_pop_o16
label var total_pop_o16 "Total tract working-age pop. (aged 16+)"

rename AMRZE001 total_pop_o25
label var total_pop_o25 "Total tract pop. aged 25+"

rename AMWQE002 total_pop_u19
label var total_pop_u19 "Total tract population under 19 years old"

rename AMWQE018 total_pop_19_34
label var total_pop_19_34 "Total tract population 19-34 years old"

rename AMWQE034 total_pop_35_64
label var total_pop_35_64 "Total tract population 35-64 years old"

gen total_pop_u65 = total_pop_u19 + total_pop_19_34 + total_pop_35_64
label var total_pop_u65 "Total tract population under 65 years old"

rename AMWQE051 total_pop_o64
label var total_pop_o64 "Total tract population 64 and older"

rename MiddleEasternorNorthAfrican mena_alone
label var mena_alone "Count MENA individuals (MENA alone) in tract"

rename J mena 
label var mena "Count MENA individuals (MENA in any combination) in tract"

rename PercentMENAalone pct_mena_alone
label var pct_mena_alone "% MENA individuals (MENA alone) in tract"

rename PercentMENAaloneorinanycom pct_mena
label var pct_mena "% MENA individuals (MENA in any combination) in tract"


/* Clean & destring MENA vars */
replace mena_alone = "0" if mena_alone == "NO VALUE" | mena_alone == "-888888888"
replace mena = "0" if mena == "NO VALUE" | mena == "-888888888"
replace pct_mena_alone = "0" if pct_mena_alone == "NO VALUE" | pct_mena_alone == "-888888888"
replace pct_mena = "0" if pct_mena == "NO VALUE" | pct_mena == "-888888888"

destring mena_alone, replace
destring mena, replace
destring pct_mena_alone, replace
destring pct_mena, replace


/* Rename and label outcomes vars */
rename AMR8E001 med_hh_income
label var med_hh_income "Median HH income (2020 dollars)"

rename AMSQE002 ssi_inc
label var ssi_inc "Count of households that received SS income in past 12 months"

rename AMSSE002 pa_inc
label var pa_inc "Count of households that received SS income in past 12 months"

rename AMSTE002 snap_inc
label var snap_inc "Count of households that received SNAP benefits or cash public assistance in past 12 months"

label var in_lf "Count of working-age pop. in labor force"

label var civilian_lf "Count of working-age pop. in civilian labor force"

label var employed "Count of working-age individuals employed"

label var unemployed "Count of working-age individuals unemployed"

rename AMWQE003 single_ins_u19
label var single_ins_u19 "No. of individuals under 19 with 1 type of coverage"

rename AMWQE004 eshi_u19
label var eshi_u19 "No. of individuals under 19 with ESHI as sole form of coverage"

rename AMWQE005 priv_ins_u19
label var priv_ins_u19 "No. of individuals under 19 with privately purchased ins. as sole form of coverage"

rename AMWQE006 medicare_u19
label var medicare_u19 "No. of individuals under 19 with Medicare as sole form of coverage"

rename AMWQE007 medicaid_u19
label var medicaid_u19 "No. of individuals under 19 with Medicaid as sole form of coverage"

rename AMWQE008 tricare_u19
label var tricare_u19 "No. of individuals under 19 with Tricare as sole form of coverage"

rename AMWQE009 va_u19
label var va_u19 "No. of individuals under 19 with VA Health Care as sole form of coverage"

rename AMWQE010 multi_ins_u19
label var multi_ins_u19 "No. of individuals under 19 with more than one type of coverage"

rename AMWQE011 eshi_priv_ins_u19
label var eshi_priv_ins_u19 "No. of individuals under 19 with ESHI and private coverage"

rename AMWQE012 eshi_medicare_u19
label var eshi_medicare_u19 "No. of individuals under 19 with ESHI and Medicare coverage"

rename AMWQE013 medicare_medicaid_u19
label var medicare_medicaid_u19 "No. of individuals under 19 with Medicare and Medicaid coverage"

rename AMWQE014 priv_ins_combo_u19
label var priv_ins_combo_u19 "No. of individuals under 19 with a combination of private coverages"

rename AMWQE015 pub_ins_combo_u19
label var pub_ins_combo_u19 "No. of individuals under 19 with a combination of public coverages"

rename AMWQE016 other_ins_combo_u19
label var other_ins_combo_u19 "No. of individuals under 19 with a combination of other coverages"

rename AMWQE017 no_ins_u19
label var no_ins_u19 "No. of individuals under 19 with no insurance coverage"

rename AMWQE019 single_ins_19_34
label var single_ins_19_34 "No. of individuals 19-34 with 1 type of coverage"

rename AMWQE020 eshi_19_34
label var eshi_19_34 "No. of individuals 19-34 with ESHI as sole form of coverage"

rename AMWQE021 priv_ins_19_34
label var priv_ins_19_34 "No. of individuals 19-34 with privately purchased ins. as sole form of coverage"

rename AMWQE022 medicare_19_34
label var medicare_19_34 "No. of individuals 19-34 with Medicare as sole form of coverage"

rename AMWQE023 medicaid_19_34
label var medicaid_19_34 "No. of individuals 19-34 with Medicaid as sole form of coverage"

rename AMWQE024 tricare_19_34
label var tricare_19_34 "No. of individuals 19-34 with Tricare as sole form of coverage"

rename AMWQE025 va_19_34
label var va_19_34 "No. of individuals 19-34 with VA Health Care as sole form of coverage"

rename AMWQE026 multi_ins_19_34
label var multi_ins_19_34 "No. of individuals 19-34 with more than one type of coverage"

rename AMWQE027 eshi_priv_ins_19_34
label var eshi_priv_ins_19_34 "No. of individuals 19-34 with ESHI and private coverage"

rename AMWQE028 eshi_medicare_19_34
label var eshi_medicare_19_34 "No. of individuals 19-34 with ESHI and Medicare coverage"

rename AMWQE029 medicare_medicaid_19_34
label var medicare_medicaid_19_34 "No. of individuals 19-34 with Medicare and Medicaid coverage"

rename AMWQE030 priv_ins_combo_19_34
label var priv_ins_combo_19_34 "No. of individuals 19-34 with a combination of private coverages"

rename AMWQE031 pub_ins_combo_19_34
label var pub_ins_combo_19_34 "No. of individuals 19-34 with a combination of public coverages"

rename AMWQE032 other_ins_combo_19_34
label var other_ins_combo_19_34 "No. of individuals 19-34 with a combination of other coverages"

rename AMWQE033 no_ins_19_34
label var no_ins_19_34 "No. of individuals 19-34 with no insurance coverage"

rename AMWQE035 single_ins_35_64
label var single_ins_35_64 "No. of individuals 35-64 with 1 type of coverage"

rename AMWQE036 eshi_35_64
label var eshi_35_64 "No. of individuals 35-64 with ESHI as sole form of coverage"

rename AMWQE037 priv_ins_35_64
label var priv_ins_35_64 "No. of individuals 35-64 with privately purchased ins. as sole form of coverage"

rename AMWQE038 medicare_35_64
label var medicare_35_64 "No. of individuals 35-64 with Medicare as sole form of coverage"

rename AMWQE039 medicaid_35_64
label var medicaid_35_64 "No. of individuals 35-64 with Medicaid as sole form of coverage"

rename AMWQE040 tricare_35_64
label var tricare_35_64 "No. of individuals 35-64 with Tricare as sole form of coverage"

rename AMWQE041 va_35_64
label var va_35_64 "No. of individuals 35-64 with VA Health Care as sole form of coverage"

rename AMWQE042 multi_ins_35_64
label var multi_ins_35_64 "No. of individuals 35-64 with more than one type of coverage"

rename AMWQE043 eshi_priv_ins_35_64
label var eshi_priv_ins_35_64 "No. of individuals 35-64 with ESHI and private coverage"

rename AMWQE044 eshi_medicare_35_64
label var eshi_medicare_35_64 "No. of individuals 35-64 with ESHI and Medicare coverage"

rename AMWQE045 priv_ins_medicare_35_64
label var priv_ins_medicare_35_64 "No. of individuals 35-64 with private ins. and Medicare coverage"

rename AMWQE046 medicare_medicaid_35_64
label var medicare_medicaid_35_64 "No. of individuals 35-64 with Medicare and Medicaid coverage"

rename AMWQE047 priv_ins_combo_35_64
label var priv_ins_combo_35_64 "No. of individuals 35-64 with a combination of private coverages"

rename AMWQE048 pub_ins_combo_35_64
label var pub_ins_combo_35_64 "No. of individuals 35-64 with a combination of public coverages"

rename AMWQE049 other_ins_combo_35_64
label var other_ins_combo_35_64 "No. of individuals 35-64 with a combination of other coverages"

rename AMWQE050 no_ins_35_64
label var no_ins_35_64 "No. of individuals 35-64 with no insurance coverage"

rename AMWQE052 single_ins_o64
label var single_ins_o64 "No. of individuals over 64 with 1 type of coverage"

rename AMWQE053 eshi_o64
label var eshi_o64 "No. of individuals over 64 with ESHI as sole form of coverage"

rename AMWQE054 priv_ins_o64
label var priv_ins_o64 "No. of individuals over 64 with privately purchased ins. as sole form of coverage"

rename AMWQE055 medicare_o64
label var medicare_o64 "No. of individuals over 64 with Medicare as sole form of coverage"

rename AMWQE056 tricare_o64
label var tricare_o64 "No. of individuals over 64 with Tricare as sole form of coverage"

rename AMWQE057 va_o64
label var va_o64 "No. of individuals over 64 with VA Health Care as sole form of coverage"

rename AMWQE058 multi_ins_o64
label var multi_ins_o64 "No. of individuals over 64 with more than one type of coverage"

rename AMWQE059 eshi_priv_ins_o64
label var eshi_priv_ins_o64 "No. of individuals over 64 with ESHI and private coverage"

rename AMWQE060 eshi_medicare_o64
label var eshi_medicare_o64 "No. of individuals over 64 with ESHI and Medicare coverage"

rename AMWQE061 priv_ins_medicare_o64
label var priv_ins_medicare_o64 "No. of individuals over 64 with private ins. and Medicare coverage"

rename AMWQE062 medicare_medicaid_o64
label var medicare_medicaid_o64 "No. of individuals over 64 with Medicare and Medicaid coverage"

rename AMWQE063 priv_ins_combo_o64
label var priv_ins_combo_o64 "No. of individuals over 64 with a combination of private coverages"

rename AMWQE064 pub_ins_combo_o64
label var pub_ins_combo_o64 "No. of individuals over 64 with a combination of public coverages"

rename AMWQE065 other_ins_combo_o64
label var other_ins_combo_o64 "No. of individuals over 64 with a combination of other coverages"

rename AMWQE066 no_ins_o64
label var no_ins_o64 "No. of individuals over 64 with no insurance coverage"

rename ann_avg_job_growth_2004_2013 job_growth
label var job_growth "Avg annualized job growth rate. 2004-2013"

rename gsmn_math_g3_2013 math_score
label var math_score "Mean 3rd grade math test scores, 2013"

rename ln_wage_growth_hs_grad hs_grad_wages
label var hs_grad_wages "Natural log of wage grpwth for HS grads 2009-2014"

gen no_hs = AMRZE002 + ///
	AMRZE003 + AMRZE004 + AMRZE005 + ///
	AMRZE006 + AMRZE007 + AMRZE008 + ///
	AMRZE009 + AMRZE010 + AMRZE011 + ///
	AMRZE012 + AMRZE013 + AMRZE014 + ///
	AMRZE015 + AMRZE016
label var no_hs "Count of individuals aged 25+ without a HS diploma"

gen hs_grad = AMRZE017 + AMRZE018
label var hs_grad "Count of individuals aged 25+ whose highest level of ed. is a HS diploma or GED"

gen some_college = AMRZE019 + AMRZE020
label var some_college "Count of individuals aged 25+ with some college but no degree"

rename AMRZE021 a_degree
label var a_degree "Count of individuals aged 25+ whose highest level of ed. is an associates degree"

gen degree = AMRZE022
label var degree  "Count of individuals aged 25+ with a bachelor's degree"

gen b_degree = AMRZE022 + AMRZE023 + AMRZE024 + AMRZE025
label var b_degree  "Count of individuals aged 25+ with at least a bachelor's degree"
	
gen post_grad = AMRZE023 + AMRZE024 + AMRZE025
label var post_grad "Count of individuals aged 25+ with a post-graduate degree (master's, professional, doctorate)"

rename AMVTE001 med_rent
label var med_rent "Median contract rent"

rename AMWBE001 med_hp
label var med_hp "Median owner-occupied house price"





/*
******************************************************************************
VARIABLE CONSTRUCTION 
******************************************************************************
*/

/* MENA concentration variables */
gen prop_mena = pct_mena / 100
label var prop_mena "Prop. MENA individuals (MENA in any combination) in tract"

gen prop_mena_n0 = 0
replace prop_mena_n0 = 1 if prop_mena != 0 & prop_mena != .
label var prop_mena_n0 "=1 if tract's MENA concentration > 0"

* Need to calculate median nonzero MENA conc. for this *
gen mena_group = 0
replace mena_group = 1 if prop_mena == 0
replace mena_group = 2 if prop_mena > 0 & prop_mena <= 0.0518
replace mena_group = 3 if prop_mena > 0.0518
label var mena_group "Categorical var. = 1 if MENA = 0, 2 if MENA < median, 3 if MENA > median"


/* Category variables */
gen detroit = 0
replace detroit = 1 if ///
	county_fips == 87 | ///
	county_fips == 93 | ///
	county_fips == 99 | ///
	county_fips == 125 | ///
	county_fips == 147 | ///
	county_fips == 163  
	label var detroit "=1 if tract is in Detroit metro area (as defined by OMB)"
	/* Includes the following counties:
		Lapeer, Livingston, Macomb, Oakland, St. Clair, Wayne
	*/


/* Generate other variables of interest */
gen l_med_hh_income = log(med_hh_income)
label var l_med_hh_income "Log(Median HH income)"

gen l_rent = log(med_rent)
label var l_rent "Log(Median contract rent)"

gen l_hp = log(med_hp)
label var l_hp "Log(Median home value)"

gen lfpr = in_lf / total_pop_o16
label var lfpr "Labor force participation rate"

gen lfpr_pct = lfpr * 100
label var lfpr "Labor force participation rate (as a percentage)"

gen unem_rate = unemployed / in_lf
label var unem_rate "Unemployment rate"

gen unem_pct = unem_rate * 100
label var unem_pct "Unemployment rate (as a percentage)"

gen ssi_rate = ssi_inc / total_hh
label var ssi_rate "Prop. of households that received SS income in past 12 months"

gen ssi_pct = ssi_rate * 100
label var ssi_rate "SSI rate (as a percentage)"

gen pa_inc_rate = pa_inc / total_hh
label var pa_inc_rate "Prop. of households that received public assistance income in past 12 months"

gen pa_pct = pa_inc_rate * 100
label var pa_pct "PAI rate (as a percentage)"

gen snap_inc_rate = snap_inc / total_hh
label var snap_inc_rate "Prop. of households that received SNAP benefits or cash public assistance in past 12 months"

gen snap_pct = snap_inc_rate * 100
label var snap_pct "SNAP rate (as a percentage)"

gen unins_rate = (no_ins_u19 + no_ins_19_34 + no_ins_35_64 + no_ins_o64) / total_pop
label var unins_rate "Prop. of total population without health insurance"

gen medicaid_rate = (medicaid_u19 + medicaid_19_34 + medicaid_35_64 + ///
					medicare_medicaid_u19 + medicare_medicaid_19_34 + medicare_medicaid_35_64) ///
					/ total_pop_u65
label var medicaid_rate "Prop. of population aged 64 and under enrolled in Medicaid"

gen eshi_rate = (eshi_u19 + eshi_19_34 + eshi_35_64 + eshi_o64 + ///
				eshi_medicare_u19 + eshi_medicare_19_34 + eshi_medicare_35_64 + eshi_medicare_o64 + ///
				eshi_priv_ins_u19 + eshi_priv_ins_19_34 + eshi_priv_ins_35_64 + eshi_priv_ins_o64) ///
				/ total_pop
label var eshi_rate "Prop. of population covered by ESHI"

gen no_hs_pct = no_hs / total_pop_o25

gen hs_grad_pct = hs_grad / total_pop_o25

gen a_degree_pct = a_degree / total_pop_o25

gen degree_pct = degree / total_pop_o25

gen post_grad_pct = post_grad / total_pop_o25

gen eshi = (eshi_u19 + eshi_19_34 + eshi_35_64 + eshi_o64) / total_pop

gen private_ins = (priv_ins_u19 + priv_ins_19_34 + priv_ins_35_64 + priv_ins_o64) / total_pop

gen medicare = (medicare_u19 + medicare_19_34 + medicare_35_64 + medicare_o64) / total_pop

gen medicaid = (medicaid_u19 + medicaid_19_34 + medicaid_35_64) / total_pop

gen tricare = (tricare_u19 + tricare_19_34 + tricare_35_64 + tricare_o64) / total_pop

gen va_care = (va_u19 + va_19_34 + va_35_64 + va_o64) / total_pop

gen eshi_priv_ins = (eshi_priv_ins_u19 + eshi_priv_ins_19_34 + eshi_priv_ins_35_64 + eshi_priv_ins_o64) / total_pop

gen eshi_medicare = (eshi_medicare_u19 + eshi_medicare_19_34 + eshi_medicare_35_64 + eshi_medicare_o64) / total_pop

gen medicare_medicaid = (medicare_medicaid_u19 + medicare_medicaid_19_34 + medicare_medicaid_35_64 + medicare_medicaid_o64) / total_pop

gen priv_ins_combo = (priv_ins_combo_u19 + priv_ins_combo_19_34 + priv_ins_combo_35_64 + priv_ins_combo_o64) / total_pop

gen pub_ins_combo = (pub_ins_combo_u19 + pub_ins_combo_19_34 + pub_ins_combo_35_64 + pub_ins_combo_o64) / total_pop

gen other_ins_combo = (other_ins_combo_u19 + other_ins_combo_19_34 + other_ins_combo_35_64 + other_ins_combo_o64) / total_pop

gen no_ins = (no_ins_u19 + no_ins_19_34 + no_ins_35_64 + no_ins_o64) / total_pop



save "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/MICHIGAN OUTCOMES.dta" ///
	, replace




/*
******************************************************************************
SUMMARY STATS
******************************************************************************
*/

sum prop_mena, d

tab county if prop_mena_n0 == 1
	

	
	
/*
******************************************************************************
SCATTERPLOTS - DETROIT ONLY
******************************************************************************
*/
/* Median HH Income */
reg l_med_hh_income prop_mena if detroit == 1
twoway (scatter l_med_hh_income prop_mena if detroit == 1, mcolor(navy)) ///
	(lfit l_med_hh_income prop_mena if detroit == 1, lcolor(red)), ///
	legend(off) ///
	title("Median Household Income & MENA Concentration", size(5)) ///
	subtitle("Universe: Households; Income in 2020 dollars", size(2.5)) ///
	xtitle("MENA concentration", size(3.5)) ///
	ytitle("Log(Median HH Income)", size(3.5)) ///
	xlabel(0(0.2)1) ///
	ylabel(9(1)13, angle(0)) ///
	text(13 1  "Log(Median HH Income) = 10.939*** - 0.304*** MENA", place(sw) size(3))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/ACS Data/Median HH Income & MENA.png" ///
	, replace
	
	

/*
******************************************************************************
BAR CHARTS - DETROIT VS. REST OF MICHIGAN
******************************************************************************
*/

graph bar med_hh_income, ///
	over(detroit) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	title("Median HH Income: Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Income in 2020 dollars", size(2.5)) ///
	ytitle("Median HH Income ($)", size(3.5)) ///
	legend(order(1 "Rest of Michigan" 2 "Detroit metro area")) ///
	blabel(bar, position(outside) format(%9.0fc) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Median HH Income.png" ///
	, replace
	

graph bar med_rent, ///
	over(detroit) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	title("Median Contract Rent: Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Rental rates in 2020 dollars", size(2.5)) ///
	ytitle("Median contract rent ($)", size(3.5)) ///
	legend(order(1 "Rest of Michigan" 2 "Detroit metro area")) ///
	blabel(bar, position(outside) format(%9.0fc) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Median contract rent.png" ///
	, replace
	
	
graph bar med_hp, ///
	over(detroit) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	title("Median Home Value: Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Home values in 2020 dollars", size(2.5)) ///
	ytitle("Median home value ($)", size(3.5)) ///
	ylabel(, format(%9.0fc)) ///
	legend(order(1 "Rest of Michigan" 2 "Detroit metro area")) ///
	blabel(bar, position(outside) format(%9.0fc) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Median home value.png" ///
	, replace
	

graph bar unem_pct, ///
	over(detroit) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	title("Unemployment Rate: Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Universe: Civilian noninstitutionalized pop. aged 16 and older", size(2.5)) ///
	ytitle("Unemployment rate (%)", size(3.5)) ///
	legend(order(1 "Rest of Michigan" 2 "Detroit metro area")) ///
	blabel(bar, position(outside) format(%9.2f) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Unemployment rate.png" ///
	, replace
	

graph bar lfpr_pct, ///
	over(detroit) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	title("LFPR: Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Universe: Civilian noninstitutionalized pop. aged 16 and older", size(2.5)) ///
	ytitle("Labor force participation rate (%)", size(3.5)) ///
	yscale(range(0 80)) ///
	ylabel(0(20)80) ///
	legend(order(1 "Rest of Michigan" 2 "Detroit metro area")) ///
	blabel(bar, position(outside) format(%9.2f) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/LFPR.png" ///
	, replace
	
	
graph bar pa_pct, ///
	over(detroit) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	title("Public Assistance Income (PAI): Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Universe: Households", size(2.5)) ///
	ytitle("Pct. of households that received PAI in past 12 mos.", size(3.5)) ///
	legend(order(1 "Rest of Michigan" 2 "Detroit metro area")) ///
	blabel(bar, position(outside) format(%9.2f) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/PAI.png" ///
	, replace
	
	
graph bar ssi_pct, ///
	over(detroit) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	title("Social Security Income (SSI): Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Universe: Households", size(2.5)) ///
	ytitle("Pct. of households that received SSI in past 12 mos.", size(3.5)) ///
	legend(order(1 "Rest of Michigan" 2 "Detroit metro area")) ///
	blabel(bar, position(outside) format(%9.2f) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/SSI.png" ///
	, replace
	
	
graph bar snap_pct, ///
	over(detroit) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	title("SNAP Income: Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Universe: Households", size(2.5)) ///
	ytitle("Pct. of households with SNAP income in past 12 mos.", size(3.5)) ///
	legend(order(1 "Rest of Michigan" 2 "Detroit metro area")) ///
	blabel(bar, position(outside) format(%9.2f) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/SNAP.png" ///
	, replace
	

graph bar hs_grad_wages, ///
	over(detroit) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	title("Wage Growth for HS Graduates: Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Time period: 2009-2014, not adjusted for inflation", size(2.5)) ///
	ytitle("{&Delta}Log(avg. weekly wage)", size(3.5)) ///
	legend(order(1 "Rest of Michigan" 2 "Detroit metro area")) ///
	blabel(bar, position(outside) format(%9.4f) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Wage growth.png" ///
	, replace
	
	
graph bar math_score, ///
	over(detroit) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	title("Mean 3rd grade math scores: Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Time period: 2013", size(2.5)) ///
	ytitle("Mean score", size(3.5)) ///
	legend(order(1 "Rest of Michigan" 2 "Detroit metro area")) ///
	blabel(bar, position(outside) format(%9.4f) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Math test scores.png" ///
	, replace
	

* I had to manually create these mini datasets that allow me to make a bar chart the way I want it *
sum no_hs_pct if detroit == 0
sum hs_grad_pct if detroit == 0
sum a_degree_pct if detroit == 0
sum degree_pct if detroit == 0
sum post_grad_pct if detroit == 0
sum no_hs_pct if detroit == 1
sum hs_grad_pct if detroit == 1
sum a_degree_pct if detroit == 1
sum degree_pct if detroit == 1
sum post_grad_pct if detroit == 1
clear
graph bar (asis) mean, ///
    over(detroit, label(angle(0))) ///
	over(edu, gap(20) label(angle(45)) relabel( ///
		1 "No HS diploma" 2 "HS Diploma or GED" 3 "Associates degree" 4 "Bachelors degree" 5 "Post-graduate degree")) ///
    asyvars ///
    bar(1, color(red%50)) bar(2, color(blue%50)) ///
    title("Education Attainment: Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Universe: Population aged 25 and over; Outcome: Highest level of ed. attainment", size(2.5)) ///
    ytitle("Proportion", size(3)) ///
    ylabel(, format(%9.2f)) ///
	yscale(range(0 0.35)) ///
    legend(order(1 "Rest of Michigan" 2 "Detroit metro area")) ///
	blabel(bar, position(outside) format(%9.3f) size(2.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Educational attainment.png" ///
	, replace
	
	
sum eshi if detroit == 0
sum private_ins if detroit == 0
sum medicare if detroit == 0
sum medicaid if detroit == 0
sum tricare if detroit == 0
sum va_care if detroit == 0
sum eshi_priv_ins if detroit == 0
sum eshi_medicare if detroit == 0
sum medicare_medicaid if detroit == 0
sum priv_ins_combo if detroit == 0
sum pub_ins_combo if detroit == 0
sum other_ins_combo if detroit == 0
sum no_ins if detroit == 0
sum eshi if detroit == 1
sum private_ins if detroit == 1
sum medicare if detroit == 1
sum medicaid if detroit == 1
sum tricare if detroit == 1
sum va_care if detroit == 1
sum eshi_priv_ins if detroit == 1
sum eshi_medicare if detroit == 1
sum medicare_medicaid if detroit == 1
sum priv_ins_combo if detroit == 1
sum pub_ins_combo if detroit == 1
sum other_ins_combo if detroit == 1
sum no_ins if detroit == 1
clear
graph bar (asis) mean, ///
    over(detroit, label(angle(0))) ///
	over(health_ins, gap(20) label(angle(45)) relabel( ///
		1 "ESHI" 2 "Private ins." 3 "Medicare" ///
		4 "Medicaid" 5 "Tricare" 6 "VA" ///
		7 "ESHI & private ins." 8 "ESHI & Medicare" ///
		9 "Medicare & Medicaid" 10 "Combo of private ins." ///
		11 "Combo of public ins." 12 "Combo of private & public ins." ///
		13 "Uninsured")) ///
    asyvars ///
    bar(1, color(red%50)) bar(2, color(blue%50)) ///
    title("Primary Source of Insurance Coverage: Detroit vs. Rest of Michigan", size(4)) ///
	subtitle("Universe: All individuals", size(2.5)) ///
    ytitle("Proportion", size(3)) ///
    ylabel(, format(%9.1f)) ///
	yscale(range(0 0.35)) ///
    legend(order(1 "Rest of Michigan" 2 "Detroit metro area"))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Health insurance.png" ///
	, replace
	


		
		
		
/*
******************************************************************************
OTHER PLOTS - DETROIT VS. REST OF MICHIGAN
******************************************************************************
*/		
		
twoway ///
    (hist med_hh_income if detroit == 0, percent ///
		color(red%50) width(10000)) ///
    (hist med_hh_income if detroit == 1, percent ///
		color(blue%50) width(10000)), ///
    legend(label(1 "Rest of Michigan") label(2 "Detroit metro area")) ///
    title("Income Distribution: Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Income in 2020 dollars", size(2.5)) ///
    xtitle("Median HH Income ($)", size(3)) ///
	xlabel(0(50000)250000, format(%15.0fc) angle(45)) ///
	ytitle("Percent", size(3))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Income Distribution.png" ///
	, replace
	
	
twoway ///
    (hist med_rent if detroit == 0, percent ///
		color(red%50) width(100)) ///
    (hist med_rent if detroit == 1, percent ///
		color(blue%50) width(100)), ///
    legend(label(1 "Rest of Michigan") label(2 "Detroit metro area")) ///
    title("Rent Distribution: Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Rent in 2020 dollars", size(2.5)) ///
    xtitle("Median contract rent ($)", size(3)) ///
	xlabel(0(500)4000, format(%15.0fc) angle(45)) ///
	ytitle("Percent", size(3))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Rent Distribution.png" ///
	, replace
	
	
twoway ///
    (hist med_hp if detroit == 0, percent ///
		color(red%50) width(25000)) ///
    (hist med_hp if detroit == 1, percent ///
		color(blue%50) width(25000)), ///
    legend(label(1 "Rest of Michigan") label(2 "Detroit metro area")) ///
    title("Home Value Distribution: Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Home values in 2020 dollars", size(2.5)) ///
    xtitle("Median home value ($)", size(3)) ///
	xlabel(0(150000)900000, format(%15.0fc) angle(45)) ///
	ytitle("Percent", size(3))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Home value Distribution.png" ///
	, replace
	
	
	
	
	
	
	
	
	
	
	
	
/*
******************************************************************************
BAR CHARTS - DETROIT VS. REST OF MICHIGAN (w/ intra-Detroit variation)
******************************************************************************
*/

graph bar med_hh_income, ///
	over(detroit) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	title("Median HH Income: Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Income in 2020 dollars", size(2.5)) ///
	ytitle("Median HH Income ($)", size(3.5)) ///
	legend(order(1 "Rest of Michigan" 2 "Detroit metro area")) ///
	blabel(bar, position(outside) format(%9.0fc) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Median HH Income.png" ///
	, replace
	

graph bar med_rent, ///
	over(detroit) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	title("Median Contract Rent: Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Rental rates in 2020 dollars", size(2.5)) ///
	ytitle("Median contract rent ($)", size(3.5)) ///
	legend(order(1 "Rest of Michigan" 2 "Detroit metro area")) ///
	blabel(bar, position(outside) format(%9.0fc) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Median contract rent.png" ///
	, replace
	
	
graph bar med_hp, ///
	over(detroit) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	title("Median Home Value: Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Home values in 2020 dollars", size(2.5)) ///
	ytitle("Median home value ($)", size(3.5)) ///
	ylabel(, format(%9.0fc)) ///
	legend(order(1 "Rest of Michigan" 2 "Detroit metro area")) ///
	blabel(bar, position(outside) format(%9.0fc) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Median home value.png" ///
	, replace
	

graph bar unem_pct, ///
	over(detroit) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	title("Unemployment Rate: Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Universe: Civilian noninstitutionalized pop. aged 16 and older", size(2.5)) ///
	ytitle("Unemployment rate (%)", size(3.5)) ///
	legend(order(1 "Rest of Michigan" 2 "Detroit metro area")) ///
	blabel(bar, position(outside) format(%9.2f) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Unemployment rate.png" ///
	, replace
	

graph bar lfpr_pct, ///
	over(detroit) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	title("LFPR: Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Universe: Civilian noninstitutionalized pop. aged 16 and older", size(2.5)) ///
	ytitle("Labor force participation rate (%)", size(3.5)) ///
	yscale(range(0 80)) ///
	ylabel(0(20)80) ///
	legend(order(1 "Rest of Michigan" 2 "Detroit metro area")) ///
	blabel(bar, position(outside) format(%9.2f) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/LFPR.png" ///
	, replace
	
	
graph bar pa_pct, ///
	over(detroit) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	title("Public Assistance Income (PAI): Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Universe: Households", size(2.5)) ///
	ytitle("Pct. of households that received PAI in past 12 mos.", size(3.5)) ///
	legend(order(1 "Rest of Michigan" 2 "Detroit metro area")) ///
	blabel(bar, position(outside) format(%9.2f) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/PAI.png" ///
	, replace
	
	
graph bar ssi_pct, ///
	over(detroit) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	title("Social Security Income (SSI): Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Universe: Households", size(2.5)) ///
	ytitle("Pct. of households that received SSI in past 12 mos.", size(3.5)) ///
	legend(order(1 "Rest of Michigan" 2 "Detroit metro area")) ///
	blabel(bar, position(outside) format(%9.2f) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/SSI.png" ///
	, replace
	
	
graph bar snap_pct, ///
	over(detroit) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	title("SNAP Income: Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Universe: Households", size(2.5)) ///
	ytitle("Pct. of households with SNAP income in past 12 mos.", size(3.5)) ///
	legend(order(1 "Rest of Michigan" 2 "Detroit metro area")) ///
	blabel(bar, position(outside) format(%9.2f) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/SNAP.png" ///
	, replace
	

graph bar hs_grad_wages, ///
	over(detroit) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	title("Wage Growth for HS Graduates: Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Time period: 2009-2014, not adjusted for inflation", size(2.5)) ///
	ytitle("{&Delta}Log(avg. weekly wage)", size(3.5)) ///
	legend(order(1 "Rest of Michigan" 2 "Detroit metro area")) ///
	blabel(bar, position(outside) format(%9.4f) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Wage growth.png" ///
	, replace
	
	
graph bar math_score, ///
	over(detroit) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	title("Mean 3rd grade math scores: Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Time period: 2013", size(2.5)) ///
	ytitle("Mean score", size(3.5)) ///
	legend(order(1 "Rest of Michigan" 2 "Detroit metro area")) ///
	blabel(bar, position(outside) format(%9.4f) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Math test scores.png" ///
	, replace
	

* I had to manually create these mini datasets that allow me to make a bar chart the way I want it *
sum no_hs_pct if detroit == 0
sum hs_grad_pct if detroit == 0
sum a_degree_pct if detroit == 0
sum degree_pct if detroit == 0
sum post_grad_pct if detroit == 0
sum no_hs_pct if detroit == 1
sum hs_grad_pct if detroit == 1
sum a_degree_pct if detroit == 1
sum degree_pct if detroit == 1
sum post_grad_pct if detroit == 1
clear
graph bar (asis) mean, ///
    over(detroit, label(angle(0))) ///
	over(edu, gap(20) label(angle(45)) relabel( ///
		1 "No HS diploma" 2 "HS Diploma or GED" 3 "Associates degree" 4 "Bachelors degree" 5 "Post-graduate degree")) ///
    asyvars ///
    bar(1, color(red%50)) bar(2, color(blue%50)) ///
    title("Education Attainment: Detroit vs. Rest of Michigan", size(5)) ///
	subtitle("Universe: Population aged 25 and over; Outcome: Highest level of ed. attainment", size(2.5)) ///
    ytitle("Proportion", size(3)) ///
    ylabel(, format(%9.2f)) ///
	yscale(range(0 0.35)) ///
    legend(order(1 "Rest of Michigan" 2 "Detroit metro area")) ///
	blabel(bar, position(outside) format(%9.3f) size(2.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Educational attainment.png" ///
	, replace
	
	
sum eshi if detroit == 0
sum private_ins if detroit == 0
sum medicare if detroit == 0
sum medicaid if detroit == 0
sum tricare if detroit == 0
sum va_care if detroit == 0
sum eshi_priv_ins if detroit == 0
sum eshi_medicare if detroit == 0
sum medicare_medicaid if detroit == 0
sum priv_ins_combo if detroit == 0
sum pub_ins_combo if detroit == 0
sum other_ins_combo if detroit == 0
sum no_ins if detroit == 0
sum eshi if detroit == 1
sum private_ins if detroit == 1
sum medicare if detroit == 1
sum medicaid if detroit == 1
sum tricare if detroit == 1
sum va_care if detroit == 1
sum eshi_priv_ins if detroit == 1
sum eshi_medicare if detroit == 1
sum medicare_medicaid if detroit == 1
sum priv_ins_combo if detroit == 1
sum pub_ins_combo if detroit == 1
sum other_ins_combo if detroit == 1
sum no_ins if detroit == 1
clear
graph bar (asis) mean, ///
    over(detroit, label(angle(0))) ///
	over(health_ins, gap(20) label(angle(45)) relabel( ///
		1 "ESHI" 2 "Private ins." 3 "Medicare" ///
		4 "Medicaid" 5 "Tricare" 6 "VA" ///
		7 "ESHI & private ins." 8 "ESHI & Medicare" ///
		9 "Medicare & Medicaid" 10 "Combo of private ins." ///
		11 "Combo of public ins." 12 "Combo of private & public ins." ///
		13 "Uninsured")) ///
    asyvars ///
    bar(1, color(red%50)) bar(2, color(blue%50)) ///
    title("Primary Source of Insurance Coverage: Detroit vs. Rest of Michigan", size(4)) ///
	subtitle("Universe: All individuals", size(2.5)) ///
    ytitle("Proportion", size(3)) ///
    ylabel(, format(%9.1f)) ///
	yscale(range(0 0.35)) ///
    legend(order(1 "Rest of Michigan" 2 "Detroit metro area"))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Health insurance.png" ///
	, replace
	


		
		
		
/*
******************************************************************************
OTHER PLOTS - DETROIT VS. REST OF MICHIGAN (w/ intra-Detroit variation)
******************************************************************************
*/		

graph bar med_hh_income, ///
	over(mena_group) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	bar(3, color(green%50)) ///
	title("Median HH Income by MENA Concentration", size(5)) ///
	subtitle("Income in 2020 dollars", size(2.5)) ///
	ytitle("Median HH Income ($)", size(3.5)) ///
	yscale(range(0 100000)) ///
	ylabel(0(20000)100000, format(%9.0fc)) ///
	legend(order(1 "MENA conc. = 0" 2 "MENA conc. < median" 3 "MENA conc. > median")) ///
	blabel(bar, position(outside) format(%9.0fc) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Median HH Income 0ab.png" ///
	, replace

	
graph bar med_rent, ///
	over(mena_group) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	bar(3, color(green%50)) ///
	title("Median Contract Rent by MENA concentration", size(5)) ///
	subtitle("Rental rates in 2020 dollars", size(2.5)) ///
	ytitle("Median contract rent ($)", size(3.5)) ///
	yscale(range(0 1200)) ///
	ylabel(0(200)1200, format(%9.0fc)) ///
	legend(order(1 "MENA conc. = 0" 2 "MENA conc. < median" 3 "MENA conc. > median")) ///
	blabel(bar, position(outside) format(%9.0fc) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Median contract rent 0ab.png" ///
	, replace
	

graph bar med_hp, ///
	over(mena_group) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	bar(3, color(green%50)) ///
	title("Median Home Value by MENA Concentration", size(5)) ///
	subtitle("Home values in 2020 dollars", size(2.5)) ///
	ytitle("Median home value ($)", size(3.5)) ///
	yscale(range(0 300000)) ///
	ylabel(0(100000)300000, format(%9.0fc)) ///
	legend(order(1 "MENA conc. = 0" 2 "MENA conc. < median" 3 "MENA conc. > median")) ///
	blabel(bar, position(outside) format(%9.0fc) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Median home value 0ab.png" ///
	, replace
	
	
graph bar lfpr, ///
	over(mena_group) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	bar(3, color(green%50)) ///
	title("LFPR by MENA Concentration", size(5)) ///
	subtitle("Universe: Civilian noninstitutionalized pop. aged 16+", size(2.5)) ///
	ytitle("LFPR", size(3.5)) ///
	yscale(range(0 0.8)) ///
	ylabel(0(0.2)0.8, format(%9.1fc)) ///
	legend(order(1 "MENA conc. = 0" 2 "MENA conc. < median" 3 "MENA conc. > median")) ///
	blabel(bar, position(outside) format(%9.3fc) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/LFPR 0ab.png" ///
	, replace


graph bar unem_rate, ///
	over(mena_group) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	bar(3, color(green%50)) ///
	title("Unemployment Rate by MENA Concentration", size(5)) ///
	subtitle("Universe: Civilian noninstitutionalized pop. aged 16+", size(2.5)) ///
	ytitle("Unemployment rate", size(3.5)) ///
	yscale(range(0 0.1)) ///
	ylabel(0(0.02)0.1, format(%9.2fc)) ///
	legend(order(1 "MENA conc. = 0" 2 "MENA conc. < median" 3 "MENA conc. > median")) ///
	blabel(bar, position(outside) format(%9.3fc) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Unemploymet rate 0ab.png" ///
	, replace
	
	
graph bar pa_inc_rate, ///
	over(mena_group) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	bar(3, color(green%50)) ///
	title("Public Assistance Income by MENA Concentration", size(5)) ///
	subtitle("Universe: Households", size(2.5)) ///
	ytitle("Prop. of households that received PAI in past 12 mos.", size(3.5)) ///
	yscale(range(0 0.04)) ///
	ylabel(0(0.01)0.04, angle(0)) ///
	legend(order(1 "MENA conc. = 0" 2 "MENA conc. < median" 3 "MENA conc. > median")) ///
	blabel(bar, position(outside) format(%9.3fc) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/PAI 0ab.png" ///
	, replace
	
	
graph bar ssi_rate, ///
	over(mena_group) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	bar(3, color(green%50)) ///
	title("SSI by MENA Concentration", size(5)) ///
	subtitle("Universe: Households", size(2.5)) ///
	ytitle("Prop. of households that received SSI in past 12 mos.", size(3.5)) ///
	yscale(range(0 0.4)) ///
	ylabel(0(0.1)0.4, angle(0)) ///
	legend(order(1 "MENA conc. = 0" 2 "MENA conc. < median" 3 "MENA conc. > median")) ///
	blabel(bar, position(outside) format(%9.3fc) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/SSi 0ab.png" ///
	, replace
	
	
graph bar snap_inc_rate, ///
	over(mena_group) ///
	bargap(50) ///
	asyvars ///
	bar(1, color(red%50)) ///
	bar(2, color(blue%50)) ///
	bar(3, color(green%50)) ///
	title("SNAP Benefits by MENA Concentration", size(5)) ///
	subtitle("Universe: Households", size(2.5)) ///
	ytitle("Prop. of households that received SNAP in past 12 mos.", size(3.5)) ///
	yscale(range(0 0.2)) ///
	ylabel(0(0.05)0.2, angle(0)) ///
	legend(order(1 "MENA conc. = 0" 2 "MENA conc. < median" 3 "MENA conc. > median")) ///
	blabel(bar, position(outside) format(%9.3fc) size(3.5))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/SNAP 0ab.png" ///
	, replace
	
	
	
	
/*
*****************************************************************************************************************************************************
SCATTERPLOTS - all MENA-populated tracts in Michigan
*****************************************************************************************************************************************************
*/

/* Median HH Income */
reg l_med_hh_income prop_mena if prop_mena > 0
twoway (scatter l_med_hh_income prop_mena if prop_mena > 0, mcolor(navy) msize(2) ) ///
	(lfit l_med_hh_income prop_mena if prop_mena > 0, lcolor(red)), ///
	legend(off) ///
	title("Median Household Income & MENA Concentration", size(5)) ///
	subtitle("Universe: Households in tracts w/ nonzero MENA conc.; Income in 2020 dollars", size(2.5)) ///
	xtitle("MENA concentration", size(3.5)) ///
	ytitle("Log(Median HH Income)", size(3.5)) ///
	xlabel(0(0.2)1) ///
	ylabel(9(1)13, angle(0)) ///
	text(12.5 0.95  "{it:{&beta}} = -0.946 (0.131)***", size(3) place(sw) box margin(small))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Median HH Income & MENA > 0.png" ///
	, replace
	
/* Rental rates */
reg l_rent prop_mena if prop_mena > 0
twoway (scatter l_rent prop_mena if prop_mena > 0, mcolor(navy) msize(2) ) ///
	(lfit l_rent prop_mena if prop_mena > 0, lcolor(red)), ///
	legend(off) ///
	title("Median Contract Rent & MENA Concentration", size(5)) ///
	subtitle("Universe: Households in tracts w/ nonzero MENA conc.; Rent in 2020 dollars", size(2.5)) ///
	xtitle("MENA concentration", size(3.5)) ///
	ytitle("Log(Median contract rent)", size(3.5)) ///
	xlabel(0(0.2)1) ///
	ylabel(5(1)9, angle(0)) ///
	text(8.8 0.9  "{it:{&beta}} = -0.294 (0.107)***", size(3) place(sw) box margin(small))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Median contract rent & MENA > 0.png" ///
	, replace
	
/* House prices */
reg l_hp prop_mena if prop_mena > 0
twoway (scatter l_hp prop_mena if prop_mena > 0, mcolor(navy) msize(2) ) ///
	(lfit l_hp prop_mena if prop_mena > 0, lcolor(red)), ///
	legend(off) ///
	title("Median Home Value & MENA Concentration", size(5)) ///
	subtitle("Universe: Households in tracts w/ nonzero MENA conc.; Prices in 2020 dollars", size(2.5)) ///
	xtitle("MENA concentration", size(3.5)) ///
	ytitle("Log(Median home value)", size(3.5)) ///
	xlabel(0(0.2)1) ///
	ylabel(9(1)14, angle(0)) ///
	text(13.6 0.9  "{it:{&beta}} = -0.847 (0.169)***", size(3) place(sw) box margin(small))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Median home value & MENA > 0.png" ///
	, replace

/* LFPR */	
reg lfpr prop_mena if prop_mena > 0
twoway (scatter lfpr prop_mena if prop_mena > 0, mcolor(navy)) ///
	(lfit lfpr prop_mena if prop_mena > 0, lcolor(red)), ///
	legend(off) ///
	title("Labor Force Participation Rate (LFPR) & MENA Concentration", size(5)) ///
	subtitle("Universe: Civilian noninstitutionalized pop. aged 16+ in tracts w/ nonzero MENA conc.", size(2.5)) ///
	xtitle("MENA concentration", size(3.5)) ///
	ytitle("LFPR", size(3.5)) ///
	xlabel(0(0.2)1) ///
	yscale(range(0.2 1)) ///
	ylabel(0.2(0.2)1, angle(0)) ///
	text(0.9 0.9  "{it:{&beta}} = -0.250 (0.021)***", size(3) place(sw) box margin(small))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/LFPR & MENA > 0.png" ///
	, replace
	
/* Unemployment rate */
reg unem_rate prop_mena if prop_mena > 0
twoway (scatter unem_rate prop_mena if prop_mena > 0, mcolor(navy)) ///
	(lfit unem_rate prop_mena if prop_mena > 0, lcolor(red)), ///
	legend(off) ///
	title("Unemployment rate & MENA Concentration", size(5)) ///
	subtitle("Universe: Civilian noninstitutionalized pop. aged 16+ in tracts w/ nonzero MENA conc.", size(2.5)) ///
	xtitle("MENA concentration", size(3.5)) ///
	ytitle("Unemployment rate", size(3.5)) ///
	xlabel(0(0.2)1) ///
	yscale(range(0 0.4)) ///
	ylabel(0(0.1)0.4, angle(0)) ///
	text(0.35 0.9  "{it:{&beta}} = 0.061 (0.011)***", size(3) place(sw) box margin(small))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Unemployment rate & MENA > 0.png" ///
	, replace
	
/* Public assistance income */
reg pa_inc_rate prop_mena if prop_mena > 0
twoway (scatter pa_inc_rate prop_mena if prop_mena > 0, mcolor(navy)) ///
	(lfit pa_inc_rate prop_mena if prop_mena > 0, lcolor(red)), ///
	legend(off) ///
	title("Public Assistance Income (PAI) & MENA Concentration", size(5)) ///
	subtitle("Universe: Households in tracts w/ nonzero MENA conc.", size(2.5)) ///
	xtitle("MENA concentration", size(3.5)) ///
	ytitle("Prop. of households that received PAI in past 12 mos.", size(3.5)) ///
	xlabel(0(0.2)1) ///
	yscale(range(0 0.3)) ///
	ylabel(0(0.1)0.3, angle(0)) ///
	text(0.25 0.9  "{it:{&beta}} = 0.070 (0.007)***", size(3) place(sw) box margin(small))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/PAI & MENA > 0.png" ///
	, replace

/* Social Security */
reg ssi_rate prop_mena if prop_mena > 0
twoway (scatter ssi_rate prop_mena if prop_mena > 0, mcolor(navy)) ///
	(lfit ssi_rate prop_mena if prop_mena > 0, lcolor(red)), ///
	legend(off) ///
	title("Social Security Income (SSI) & MENA Concentration", size(5)) ///
	subtitle("Universe: Households in tracts w/ nonzero MENA conc.", size(2.5)) ///
	xtitle("MENA concentration", size(3.5)) ///
	ytitle("Prop. of households that received SSI in past 12 mos.", size(3.5)) ///
	xlabel(0(0.2)1) ///
	yscale(range(0 0.75)) ///
	ylabel(0(0.25)0.75, angle(0)) ///
	text(0.7 0.9  "{it:{&beta}} = 0.035 (0.029)", size(3) place(sw) box margin(small))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/SSI & MENA > 0.png" ///
	, replace

/* SNAP */
reg snap_inc_rate prop_mena if prop_mena > 0
twoway (scatter ssi_rate prop_mena if prop_mena > 0, mcolor(navy)) ///
	(lfit ssi_rate prop_mena if prop_mena > 0, lcolor(red)), ///
	legend(off) ///
	title("SNAP Benefits & MENA Concentration", size(5)) ///
	subtitle("Universe: Households in tracts w/ nonzero MENA conc.", size(2.5)) ///
	xtitle("MENA concentration", size(3.5)) ///
	ytitle("Prop. of households that received SNAP in past 12 mos.", size(3.5)) ///
	xlabel(0(0.2)1) ///
	yscale(range(0 0.75)) ///
	ylabel(0(0.25)0.75, angle(0)) ///
	text(0.7 0.9  "{it:{&beta}} = 0.396 (0.027)***", size(3) place(sw) box margin(small))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/SNAP & MENA > 0.png" ///
	, replace

/* No health insurance */
reg unins_rate prop_mena
twoway (scatter unins_rate prop_mena, mcolor(navy)) ///
	(lfit unins_rate prop_mena, lcolor(red)), ///
	legend(off) ///
	scheme(plain) ///
	title("Rate of Uninsurance & MENA Concentration", size(5)) ///
	subtitle("Universe: Individuals", size(2.5)) ///
	xtitle("MENA concentration", size(3.5)) ///
	ytitle("Prop. of pop. without health insurance", size(3.5)) ///
	xlabel(0(0.2)1) ///
	ylabel(0(0.2)1, angle(0)) ///
	text(1 1  "Prop. uninsured = 0.0566*** - 0.0103 MENA", place(sw) size(3)) ///
	text(0.93 .74  "(0.0008)", place(c) size(2.5)) ///
	text(0.93 .86  "(0.0106)", place(c) size(2.5)) ///
	text(0.885 .8 "Standard errors in parentheses", place(c) size(2)) ///
	text(0.85 .8  "***p < 0.01, **p < 0.05, *p < 0.1", place(c) size(2))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/ACS Data/Median HH Income & MENA.png" ///
	, replace

/* Medicaid enrollment */
reg medicaid_rate prop_mena
twoway (scatter medicaid_rate prop_mena, mcolor(navy)) ///
	(lfit medicaid_rate prop_mena, lcolor(red)), ///
	legend(off) ///
	scheme(plain) ///
	title("Medicaid Enrollment & MENA Concentration", size(5)) ///
	subtitle("Universe: Individuals aged 64 and under", size(2.5)) ///
	xtitle("MENA concentration", size(3.5)) ///
	ytitle("Prop. of pop. enrolled in Medicaid", size(3.5)) ///
	xlabel(0(0.2)1) ///
	ylabel(0(0.2)1, angle(0)) ///
	text(1 1  "Prop. Medicaid = 0.2191*** + 0.2090*** MENA", place(sw) size(3)) ///
	text(0.93 .7  "(0.0032)", place(c) size(2.5)) ///
	text(0.93 .835  "(0.0405)", place(c) size(2.5)) ///
	text(0.885 .77 "Standard errors in parentheses", place(c) size(2)) ///
	text(0.85 .77  "***p < 0.01, **p < 0.05, *p < 0.1", place(c) size(2))
graph export ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/ACS Data/Median HH Income & MENA.png" ///
	, replace
	





