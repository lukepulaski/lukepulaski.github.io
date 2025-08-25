/*
******************************************************************************
MERGING DATASETS
******************************************************************************
*/

import excel ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/NATIONAL_MENA_TRACT.xlsx" ///
	, clear firstrow

save "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Health Outcomes (Michigan).dta" ///
	, replace

clear


local var_names ///
	colo_cancer ///
	dental ///
	disability ///
	cog_dis ///
	hear_dis ///
	ind_dis ///
	mob_dis ///
	sc_dis ///
	vis_dis ///
	poor_health ///
	isolation ///
	food_insecure ///
	high_bp ///
	bp_med ///
	chol_screen ///
	high_chol ///
	home_insecure ///
	asthma ///
	cad ///
	cancer ///
	diabetes ///
	smoking ///
	no_teeth ///
	arthritis ///
	drinking ///
	copd ///
	mammogram ///
	no_sleep ///
	stroke ///
	no_ins ///
	depression ///
	mental_stress ///
	phys_stress ///
	checkup ///
	teeth_65

local i = 1

foreach file in ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Colorectal cancer screening (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Dental care in last 12 mos (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Disability statistics (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Cognitive disability (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Hearing disability (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Independent living disability (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Mobility disability (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Self-care disability (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Vision disability (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Fair or poor health status (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Feeling socially isolated (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Food insecurity (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/High blood pressure (2021).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Taking blood pressure medication (2021).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Cholesterol screening (2021).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/High cholesterol (2021).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Housing insecurity (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Prevalence of asthma (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Prevalence of CAD (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Prevalence of cancer (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Prevalence of diabetes (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Prevalence of smoking (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Rate of all teeth missing (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Rate of arthritis (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Rate of binge drinking (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Rate of COPD (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Rate of mammography (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Rate of short sleep duration (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Rate of stroke (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Rate of uninsurance (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Rates of depression (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Rates of mental distress (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Rates of physical distress (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Routine checkup rates (2022).xlsx" ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/CDC Data/Teeth lost at age 65+ (2022).xlsx" {
	
	
	local newvar : word `i' of `var_names'
	
    import excel "`file'", firstrow clear
	
	rename CountyFIPS COUNTYFP
	
	gen TRACTFP = LocationName - (COUNTYFP * 1000000)
	
	replace Data_Value = Data_Value / 100
	rename Data_Value `newvar'
	
	duplicates drop COUNTYFP TRACTFP, force

    save "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Temp health data.dta" ///
		, replace

	use "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Health Outcomes (Michigan).dta", clear

    merge 1:1 COUNTYFP TRACTFP ///
	using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Temp health data.dta" ///
		, force

    drop _merge

    save "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Health Outcomes (Michigan).dta" ///
		, replace

    local ++i

    
}





/*
******************************************************************************
Data cleaning & variable labelling
******************************************************************************
*/

drop GEOID
drop STATE
drop COUNTY
drop Year
drop StateAbbr
drop StateDesc
drop CountyName
drop LocationName
drop DataSource
drop Category
drop Measure
drop Data_Value_Unit
drop Data_Value_Type
drop Data_Value_Footnote
drop Data_Value_Footnote_Symbol
drop Low_Confidence_Limit
drop High_Confidence_Limit
drop Geolocation
drop LocationID
drop CategoryID
drop MeasureId
drop DataValueTypeID
drop Short_Question_Text


rename NAME tract_name
label var tract_name "Tract/county/state name"

rename STATEFP state
label var state "State FIPS code"

rename COUNTYFP county
label var county "County FIPS code"

rename TRACTFP tract
label var tract "Tract FIPS code (minus state and county codes)"

rename TotalPopulation total_pop
label var total_pop "Total tract population"

rename TotalPop18plus total_pop_o18
label var total_pop_o18 "Total tract population aged 18 and up"

rename MiddleEasternorNorthAfrican mena
label var mena "Tract MENA count"

rename J mena_alone
label var mena_alone "Tract MENA count for individuals that identify as MENA alone"

rename PercentMENAalone prop_mena_alone
label var prop_mena_alone "Prop. of tract population that is MENA alone"

rename PercentMENAaloneorinanycom prop_mena
label var prop_mena "Prop. of tract population that is MENA (main measure of MENA concentration)"

replace mena_alone = "0" if mena_alone == "NO VALUE" | mena_alone == "-888888888"
replace mena = "0" if mena == "NO VALUE" | mena == "-888888888"
replace prop_mena_alone = "0" if prop_mena_alone == "NO VALUE" | prop_mena_alone == "-888888888"
replace prop_mena = "0" if prop_mena == "NO VALUE" | prop_mena == "-888888888"
destring mena_alone, replace
destring mena, replace
destring prop_mena_alone, replace
destring prop_mena, replace

replace prop_mena_alone = prop_mena_alone / 100
replace prop_mena = prop_mena / 100


label var arthritis "Prop. of adult pop. with arthritis"
label var asthma "Prop. of adult pop. with asthma"
label var bp_med "Prop. of adult pop. w/ high BP that takes medication for high BP"
label var cad "Prop. of adult pop. with coronary artery disease (CAD)"
label var cancer "Prop. of adult pop. that have had cancer"
label var checkup "Prop. of adult pop. that has had a routine physical in past 12 mos."
label var chol_screen "Prop. of adults aged 45-75 that has been screened for high cholesterol"
label var cog_dis "Prop. of adult pop. w/ cognitive disability"
label var colo_cancer "Prop. of adult pop. that has been screened for colorectal cancer"
label var copd "Prop. of adult pop. with chronic obstructive pulmonary disorder (COPD)"
label var dental "Prop. of adult pop. that has obtained dental care in past 12 mos."
label var depression "Prop. of adult pop. with depression"
label var diabetes "Prop. of adult pop. with diabetes"
label var disability "Prop. of adult pop. w/ disability (any kind)"
label var drinking "Prop. of adult pop. that has reported binge drinking"
label var food_insecure "Prop. of adult pop. reporting food insecurity in past 12 mos."
label var hear_dis "Prop. of adult pop. w/ auditory disability"
label var high_bp "Prop. of adult pop. with high blood pressure"
label var high_chol "Prop. of adult pop. with high cholesterol"
label var home_insecure "Prop. of adult pop. reporting housing insecurity in past 12 mos."
label var ind_dis "Prop. of adult pop. w/ indepdent living disability"
label var isolation "Prop. of adult pop. reporting feelings of social isolation"
label var mammogram "Prop. of women aged 50-74 that have had a mammogram"
label var mental_stress "Prop. of adult pop. reporting frequent mental distress"
label var mob_dis "Prop. of adult pop. w/ mobility disability"
label var no_ins "Prop. of adult pop. that is uninsured"
label var no_sleep "Prop. of adult pop. reporting sleeping very little"
label var no_teeth "Prop. of adult pop. missing all of their teeth"
label var poor_health "Prop. of adult pop. reporting 'fair' or 'poor' health"
label var phys_stress "Prop, of adult pop. reporting frequent physical distress"
label var sc_dis "Prop. of adult pop. w/ self-care disability"
label var smoking "Prop. of adult pop. that has reported smoking"
label var stroke "Prop. of adult pop. that has had a stroke"
label var teeth_65 "Prop. of adult pop. aged 65+ missing all of their teeth"
label var vis_dis  "Prop. of adult pop. w/ visual disability"


gen mena_group_mi = 1 if state == 26
replace mena_group_mi = 2 if prop_mena > 0 & prop_mena <= 0.0518 & state == 26
replace mena_group_mi = 3 if prop_mena > 0.0518 & state == 26
label var mena_group_mi "=1 if MENA = 0, =2 if MENA < median, =3 if MENA > median (for Michigan)"


save "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Health Outcomes (Michigan).dta" ///
		, replace




/*
******************************************************************************
Charts
******************************************************************************
*/

use "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Health Outcomes (Michigan).dta"


local all_items ///
    colo_cancer `"Colorectal Cancer Screening"' `"Universe: All adults; Year: (2022)"' `"Prop. ever screened for colorectal cancer"' ///
    dental `"Dental Care"' `"Universe: All adults; Year: (2022)"' `"Prop. had dental care in past year"' ///
    disability `"Disability"' `"Universe: All adults; Year: (2022)"' `"Prop. with any disability"' ///
    cog_dis `"Cognitive Disability"' `"Universe: All adults; Year: (2022)"' `"Prop. with cognitive disability"' ///
    hear_dis `"Hearing Disability"' `"Universe: All adults; Year: (2022)"' `"Prop. with hearing disability"' ///
    ind_dis `"Independent Living Disability"' `"Universe: All adults; Year: (2022)"' `"Prop. with independent living disability"' ///
    mob_dis `"Mobility Disability"' `"Universe: All adults; Year: (2022)"' `"Prop. with mobility disability"' ///
    sc_dis `"Self-Care Disability"' `"Universe: All adults; Year: (2022)"' `"Prop. with self-care disability"' ///
    vis_dis `"Vision Disability"' `"Universe: All adults; Year: (2022)"' `"Prop. with vision disability"' ///
    poor_health `"Fair/Poor Health Status"' `"Universe: All adults; Year: (2022)"' `"Prop. reporting fair/poor health"' ///
    isolation `"Feelings of Social Isolation"' `"Universe: All adults; Year: (2022)"' `"Prop. reporting feeling socially isolated"' ///
    food_insecure `"Food Insecurity"' `"Universe: All adults; Year: (2022)"' `"Prop. faced food insecurity in past 12 mos."' ///
    high_bp `"High Blood Pressure"' `"Universe: All adults; Year: (2022)"' `"Prop. with high blood pressure"' ///
    bp_med `"Blood Pressure Medication Use"' `"Universe: Adults with high BP; Year: (2021)"' `"Prop. on BP medication"' ///
    chol_screen `"Cholesterol Screening"' `"Universe: Adults aged 45-75; Year: (2021)"' `"Prop. ever screened for high cholesterol"' ///
    high_chol `"High Cholesterol"' `"Universe: All adults; Year: (2021)"' `"Prop. with high cholesterol"' ///
    home_insecure `"Housing Insecurity"' `"Universe: All adults; Year: (2022)"' `"Prop. faced housing insecurity in past 12 mos."' ///
    asthma `"Asthma"' `"Universe: All adults; Year: (2022)"' `"Prop. with asthma"' ///
    cad `"Coronary Artery Disease (CAD)"' `"Universe: All adults; Year: (2022)"' `"Prop. with CAD"' ///
    cancer `"Cancer"' `"Universe: All adults; Year: (2022)"' `"Prop. ever diagnosed with cancer"' ///
    diabetes `"Diabetes"' `"Universe: All adults; Year: (2022)"' `"Prop. with diabetes"' ///
    smoking `"Smoking"' `"Universe: All adults; Year: (2022)"' `"Prop. reporting smoking"' ///
    no_teeth `"Loss of All Teeth"' `"Universe: All adults; Year: (2022)"' `"Prop. missing all teeth"' ///
    arthritis `"Arthritis"' `"Universe: All adults; Year: (2022)"' `"Prop. with arthritis"' ///
    drinking `"Binge Drinking"' `"Universe: All adults; Year: (2022)"' `"Prop. reporting binge drinking"' ///
    copd `"COPD"' `"Universe: All adults; Year: (2022)"' `"Prop. with COPD"' ///
    mammogram `"Mammography"' `"Universe: Women aged 50-74; Year: (2022)"' `"Prop. who had a mammogram"' ///
    no_sleep `"Short Sleep Duration"' `"Universe: All adults; Year: (2022)"' `"Prop. reporting short sleep duration"' ///
    stroke `"Stroke"' `"Universe: All adults; Year: (2022)"' `"Prop. ever had stroke"' ///
    no_ins `"Uninsurance"' `"Universe: All adults; Year: (2022)"' `"Prop. without health insurance"' ///
    depression `"Depression"' `"Universe: All adults; Year: (2022)"' `"Prop. with depression"' ///
    mental_stress `"Mental Distress"' `"Universe: All adults; Year: (2022)"' `"Prop. reporting frequent mental distress"' ///
    phys_stress `"Physical Distress"' `"Universe: All adults; Year: (2022)"' `"Prop. reporting frequent physical distress"' ///
    checkup `"Routine Checkup"' `"Universe: All adults; Year: (2022)"' `"Prop. had routine checkup in past 12 mos."' ///
    teeth_65 `"Loss of All Teeth"' `"Universe: Adults aged 65+; Year: (2022)"' `"Prop. missing all teeth"'


tokenize `all_items'

while "`1'" != "" {
    
    local varname `1'
    local title `2'
    local subtitle `3'
    local ytitle `4'

	* Bar chart *
	preserve

	collapse (mean) mean_val = `varname' (count) n = `varname', by(mena_group_mi)

	gen std_err = sqrt((mean_val * (1 - mean_val)) / n)  

	gen upper = mean_val + invttail(_N-1, 0.025) * std_err
	gen lower = mean_val - invttail(_N-1, 0.025) * std_err

	gen bar1 = mean_val if mena_group_mi == 1
	gen bar2 = mean_val if mena_group_mi == 2
	gen bar3 = mean_val if mena_group_mi == 3
	
	egen max_val = max(upper)
	summarize max_val
	local max_pt = r(max)
	local max_pt_rd = ceil(`max_pt' * 5) / 5
	local scale = `max_pt_rd' / 5

	twoway (rcap upper lower mena_group_mi, lcolor(black) lwidth(0.5)) ///
		(bar bar1 mena_group_mi, barwidth(0.5) color(red%50)) ///
		(bar bar2 mena_group_mi, barwidth(0.5) color(blue%50)) ///
		(bar bar3 mena_group_mi, barwidth(0.5) color(green%50)), ///
		title("`title' by MENA Concentration") ///
		subtitle("`subtitle'") ///
		xtitle("") ///
		xlabel(, nolabels noticks nogrid) ///
		ytitle("`ytitle'") ///
		ylabel(0(`scale')`max_pt_rd', format(%9.2f)) ///
		yscale(range(0 `max_pt_rd')) ///
		legend(order(2 "MENA conc. = 0" 3 "MENA conc. < median" 4 "MENA conc. > median"))

	restore

    graph export /// 
		"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Health Outcomes/`varname' Bar.png" ///
		, replace
	
		
	* Scatter plot *
	reg `varname' prop_mena if prop_mena > 0 & state == 26
		local beta = _b[prop_mena]
			local beta = string(`beta', "%9.3f")
		local std_err = _se[prop_mena]
			local std_err = string(`std_err', "%9.3f")

		local t = `beta' / `std_err'
		local p_val = 2 * (ttail(597, abs(`t')))

		local sig = ""
		if `p_val' < 0.01 {
			local sig "***"
		}
		else if `p_val' < 0.05 {
			local sig "**"
		}
		else if `p_val' < 0.1 {
			local sig "*"
		}
	
	su `varname' if prop_mena > 0 & state == 26, meanonly
	local max_val = r(max)
	
	twoway (scatter `varname' prop_mena if prop_mena > 0 & state == 26, mcolor(navy) msize(1.5) ) ///
	(lfit `varname' prop_mena if prop_mena > 0 & state == 26, lcolor(red)), ///
	legend(off) ///
	title("`title' & MENA Concentration", size(5)) ///
	subtitle("`subtitle'", size(2.5)) ///
	xtitle("MENA concentration", size(3.5)) ///
	ytitle("`ytitle'", size(3.5)) ///
	xlabel(0(0.2)1) ///
	text(`max_val' 0.95 "{it:{&beta}} = `beta' (`std_err')`sig'", size(3) place(sw) box margin(small))

	graph export ///
		"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/Health Outcomes/`varname' Scatter.png" ///
		, replace

    macro shift 4
}


 









