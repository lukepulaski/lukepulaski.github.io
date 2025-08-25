
import excel ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/NATIONAL_MENA_TRACT.xlsx" ///
	, sheet("STATE_CTY_FIPS") ///
	clear firstrow

rename State state
rename FIPSState state_fips
rename CountyName county
rename FIPSCounty county_fips
	
gen st_cty_fips = (1000 * state_fips) + county_fips

save "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/OI Data/OI Outcomes.dta" ///
	, replace

clear



import excel ///
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/NATIONAL_MENA_TRACT.xlsx" ///
	, sheet("MENA_CTY") ///
	clear firstrow

rename ST_CTY_FPS st_cty_fips

rename TOTAL_MENA total_mena
label var total_mena "Total MENA population by county"

rename TOTAL_POP total_pop
label var total_pop "Total county population"

rename PROP_MENA prop_mena
label var prop_mena "Proportion MENA (by county)"

   
merge 1:1 st_cty_fips ///
	using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/OI Data/OI Outcomes.dta" ///
	, force

drop if _merge != 3
drop _merge

save "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/OI Data/OI Outcomes.dta" ///
	, replace
	
	
	
use "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/OI Data/county_outcomes_simple.dta"

gen st_cty_fips = (1000 * state) + county

merge 1:1 st_cty_fips ///
	using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/OI Data/OI Outcomes.dta" ///
	, force
	
drop if _merge != 3
drop _merge

save "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/OI Data/OI Outcomes.dta" ///
	, replace
	
	
	
use "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/OI Data/gender_cty.dta"

rename cty st_cty_fips

merge 1:1 st_cty_fips ///
	using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/OI Data/OI Outcomes.dta" ///
	, force
	
drop if _merge != 3
drop _merge

save "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/OI Data/OI Outcomes.dta" ///
	, replace

	
	
use "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/OI Data/onlinedata3.dta"

rename county_id st_cty_fips

merge 1:1 st_cty_fips ///
	using "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/OI Data/OI Outcomes.dta" ///
	, force
	
drop if _merge != 3
drop _merge

save "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/OI Data/OI Outcomes.dta" ///
	, replace

	
	
	
	
	
	
	
drop county
drop cz
drop czname
drop state
drop state_id


rename county_name county
label var county "County name"

rename statename state
label var state "State name"

label var st_cty_fips "State + county FIPS"

rename csa csa_code
label var csa_code "Combined Statistical Area (CSA) code"

rename csa_name csa
label var csa "Combined Statistical Area (CSA) name"


rename n_ige_rank_8082 total_children
label var total_children "Total number of children in core sample"

rename s_rank_8082 rank_slope
label var rank_slope "Slope of OLS regression of child %ile income rank on parent rank"

rename e_rank_b upward_mobility
label var upward_mobility "Expected rank of children whose parents are in 25th income %ile"



label var kid_fam_inc_mean "Mean family income of children in 1980-82 birth cohort"
label var kid_fam_inc_p25 "25th %ile family income of children in 1980-82 birth cohort"
label var kid_fam_inc_p50 "Median family income of children in 1980-82 birth cohort"
label var kid_fam_inc_p75 "75th %ile family income of children in 1980-82 birth cohort"
label var kid_fam_inc_p90 "90th %ile family income of children in 1980-82 birth cohort"
label var kid_fam_inc_p99 "99th %ile family income of children in 1980-82 birth cohort"

label var par_fam_inc_mean "Mean family income of parents of children in 1980-82 birth cohort"
label var par_fam_inc_p25 "25th %ile family income of parents of children in 1980-82 birth cohort"
label var par_fam_inc_p50 "Median family income of parents of children in 1980-82 birth cohort"
label var par_fam_inc_p75 "75th %ile family income of parents of children in 1980-82 birth cohort"
label var par_fam_inc_p90 "90th %ile family income of parents of children in 1980-82 birth cohort"
label var par_fam_inc_p99 "99th %ile family income of parents of children in 1980-82 birth cohort"





gen urban = 0
replace urban = 1 if csa_code != .
label var urban "=1 if metropolitan county"

gen mena_group = 0
replace mena_group = 1 if prop_mena == 0 & urban == 1
replace mena_group = 2 if prop_mena > 0 & urban == 1
label var mena_group "=0 if no MENA conc. & rural, =1 if urban w/ no MENA conc., =2 if both"


save "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/OI Data/OI Outcomes.dta" ///
	, replace

	
	
	
use "/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/OI Data/OI Outcomes.dta"
	


preserve

	collapse (mean) mean_val = jail_pooled_pooled_p25 ///
		(count) n = jail_pooled_pooled_p25 ///
		(sd) sd_val = jail_pooled_pooled_p25, by(mena_group)

	gen upper = mean_val + invttail(n - 1, 0.025) * sd_val
	gen lower = mean_val - invttail(n - 1, 0.025) * sd_val
	
	list mena_group mean_val sd_val n

	gen bar1 = mean_val if mena_group == 0
	gen bar2 = mean_val if mena_group == 1
	gen bar3 = mean_val if mena_group == 2

	twoway (rcap upper lower mena_group, lcolor(black) lwidth(0.5)) ///
		(bar bar1 mena_group, barwidth(0.5) color(red%50)) ///
		(bar bar2 mena_group, barwidth(0.5) color(blue%50)) ///
		(bar bar3 mena_group, barwidth(0.5) color(green%50)), ///
		title("Incarceration by MENA Concentration", size(4)) ///
		subtitle("Universe: Individuals in 1978-1983 birth cohort with parents at the 25th percentile of HH income distribution", size(2)) ///
		xtitle("") ///
		xlabel(, nolabels noticks nogrid) ///
		ytitle("Prop. incarcerated", size(3)) ///
		yscale(range(0 0.05)) ///
		ylabel(0(0.01)0.05) ///
		legend(order(2 "MENA conc. = 0 & Non-metro county" 3 "MENA conc. = 0 & Metro county" 4 "MENA conc. > 0") size(2.5))

restore

    graph export /// 
		"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/OI Outcomes/25 %ile Jail Bar.png" ///
		, replace
	
	
reg jail_pooled_pooled_p25 prop_mena if prop_mena > 0
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
	
twoway (scatter jail_pooled_pooled_p25 prop_mena if prop_mena > 0, mcolor(navy)) ///
	(lfit jail_pooled_pooled_p25 prop_mena if prop_mena > 0, lcolor(red)), ///
	legend(off) ///
	title("Incarceration & MENA Concentration", size(5)) ///
	subtitle("Universe: Individuals in 1978-1983 birth cohort with parents at the 25th percentile of HH income distribution", size(2)) ///
	xtitle("MENA concentration", size(3)) ///
	ytitle("Prop. incarcerated", size(3)) ///
	xlabel(0(0.015)0.075) ///
	ylabel(0(0.02)0.1) ///
	text(0.05 0.07  "{it:{&beta}} = `beta' (`std_err')`sig'", place(sw) size(3) box margin(small))
graph export /// 
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/OI Outcomes/25 %ile Jail Scatter.png" ///
	, replace
	
	
	
	

	
	

preserve

	collapse (mean) mean_val = rank_slope ///
		(count) n = rank_slope ///
		(sd) sd_val = rank_slope, by(mena_group)

	gen upper = mean_val + invttail(n - 1, 0.025) * sd_val
	gen lower = mean_val - invttail(n - 1, 0.025) * sd_val
	
	list mena_group mean_val sd_val n

	gen bar1 = mean_val if mena_group == 0
	gen bar2 = mean_val if mena_group == 1
	gen bar3 = mean_val if mena_group == 2

	twoway (rcap upper lower mena_group, lcolor(black) lwidth(0.5)) ///
		(bar bar1 mena_group, barwidth(0.5) color(red%50)) ///
		(bar bar2 mena_group, barwidth(0.5) color(blue%50)) ///
		(bar bar3 mena_group, barwidth(0.5) color(green%50)), ///
		title("Relative Mobility by MENA Concentration", size(4)) ///
		subtitle("Universe: Individuals in 1980-1982 birth cohort with parents at the 25th percentile of HH income distribution", size(2)) ///
		xtitle("") ///
		xlabel(, nolabels noticks nogrid) ///
		ytitle("Strength of corr. between parent & child income dist. rank", size(3)) ///
		yscale(range(0 0.6)) ///
		ylabel(0(0.2)0.6) ///
		legend(order(2 "MENA conc. = 0 & Non-metro county" 3 "MENA conc. = 0 & Metro county" 4 "MENA conc. > 0") size(2.5))

restore

    graph export /// 
		"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/OI Outcomes/Relative Mobility Bar.png" ///
		, replace	
	

reg rank_slope prop_mena if prop_mena > 0
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
	
twoway ///
	(scatter rank_slope prop_mena if prop_mena > 0, mcolor(navy)) ///
	(lfit rank_slope prop_mena if prop_mena > 0, lcolor(red)), ///
	legend(off) ///
	title("Relative Mobility & MENA Concentration", size(5)) ///
	subtitle("Universe: Individuals & parents of individuals in 1980-1982 birth cohort", size(2)) ///
	xtitle("MENA concentration", size(3)) ///
	ytitle("Strength of corr. between parent & child income dist. rank", size(3)) ///
	xlabel(0(0.015)0.075) ///
	ylabel(0(0.1)0.5) ///
	text(0.22 0.07  "{it:{&beta}} = `beta' (`std_err')`sig'", place(sw) size(3) box margin(small))
graph export /// 
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/OI Outcomes/Relative Mobility Scatter.png" ///
	, replace
	

	
	
	
	
preserve

	collapse (mean) mean_val = upward_mobility ///
		(count) n = upward_mobility ///
		(sd) sd_val = upward_mobility, by(mena_group)

	gen upper = mean_val + invttail(n - 1, 0.025) * sd_val
	gen lower = mean_val - invttail(n - 1, 0.025) * sd_val
	
	list mena_group mean_val sd_val n

	gen bar1 = mean_val if mena_group == 0
	gen bar2 = mean_val if mena_group == 1
	gen bar3 = mean_val if mena_group == 2

	twoway (rcap upper lower mena_group, lcolor(black) lwidth(0.5)) ///
		(bar bar1 mena_group, barwidth(0.5) color(red%50)) ///
		(bar bar2 mena_group, barwidth(0.5) color(blue%50)) ///
		(bar bar3 mena_group, barwidth(0.5) color(green%50)), ///
		title("Absolute Mobility by MENA Concentration", size(4)) ///
		subtitle("Universe: Individuals in 1980-1982 birth cohort with parents at the 25th percentile of HH income distribution", size(2)) ///
		xtitle("") ///
		xlabel(, nolabels noticks nogrid) ///
		ytitle("Expected income percentile of child", size(3)) ///
		yscale(range(0 60)) ///
		ylabel(0(20)60) ///
		legend(order(2 "MENA conc. = 0 & Non-metro county" 3 "MENA conc. = 0 & Metro county" 4 "MENA conc. > 0") size(2.5))

restore

    graph export /// 
		"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/OI Outcomes/Absolute Mobility Bar.png" ///
		, replace
	

reg upward_mobility prop_mena if prop_mena > 0
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
	
twoway ///
	(scatter upward_mobility prop_mena if prop_mena > 0, mcolor(navy)) ///
	(lfit upward_mobility prop_mena if prop_mena > 0, lcolor(red)), ///
	legend(off) ///
	title("Absolute Mobility & MENA Concentration", size(5)) ///
	subtitle("Universe: Individuals in 1980-1982 birth cohort with parents at the 25th percentile of HH income distribution", size(2)) ///
	xtitle("MENA concentration", size(3)) ///
	ytitle("Expected income percentile of child", size(3)) ///
	xlabel(0(0.015)0.075) ///
	ylabel(30(5)55) ///
	text(53 0.07  "{it:{&beta}} = `beta' (`std_err')`sig'", place(sw) size(3) box margin(small))
graph export /// 
	"/Users/lukepulaski/Library/CloudStorage/OneDrive-UniversityofVermont/MENA Research/Graphs/OI Outcomes/Absolute Mobility Scatter.png" ///
	, replace
	
	
	
	
	

	
	
