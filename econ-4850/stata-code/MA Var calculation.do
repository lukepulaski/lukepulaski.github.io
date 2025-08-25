***OUTCOME VARIABLES***
gen med_adv = 0
label var med_adv "=1 if respondent is enrolled in Medicare Advantage"
replace med_adv = 1 if mcchoice_a == 1



***CONTROL VARIABLES***
*Year dummies*
gen y2019 = 0
replace y2019 = 1 if srvy_yr == 2019

gen y2020 = 0
replace y2020 = 1 if srvy_yr == 2020

gen y2021 = 0
replace y2021 = 1 if srvy_yr == 2021

gen y2022 = 0
replace y2022 = 1 if srvy_yr == 2022

gen y2023 = 0
replace y2023 = 1 if srvy_yr == 2023


*Age*
gen age = 0
replace age = agep_a

gen u65 = 0
label var u65 "=1 if respondent is under 65 y/o"
replace u65 = 1 if (age < 65)

gen u67 = 0
label var u67 "=1 if respondent is 65 or 66"
replace u67 = 1 if (age < 67 & agep >= 65)

gen o67 = 0
label var o67 "=1 if respondent is over 66"
replace o67 = 1 if (age >= 67)

*Sex*
drop if sex_a == 97 | sex_a == 98 | sex_a == 99
gen female = 0
label var female "=1 if respondent is female"
replace female = 1 if sex_a == 2

*Race dummies*
drop if hispallp_a == 97 | hispallp_a == 98 | hispallp_a == 99
gen hispanic = 0
label var hispanic "respondent identifies as Hispanic"
replace hispanic = 1 if hispallp_a == 1

gen white = 0
label var white "respondent identifies as White"
replace white = 1 if hispallp_a == 2

gen black = 0
label var black "respondent identifies as Black"
replace black = 1 if hispallp_a == 3

gen asian = 0
label var asian "respondent identifies as Asian"
replace asian = 1 if hispallp_a == 4

gen native = 0
label var native "respondent identifies as AI/AN"
replace native = 1 if hispallp_a == 5

gen native_other = 0
label var native_other "respondent identifies as AI/AN and some other race"
replace native_other = 1 if hispallp_a == 6

gen other_race = 0
label var other_race "respondent identifies as other or multiple races"
replace other_race = 1 if (hispallp == 7)

*Urban/rural status*
drop if urbrrl == 97 | urbrrl == 98 | urbrrl == 99
gen rural = 0
label var rural "=1 if respondent lives in nonmetro area"
replace rural = 1 if urbrrl == 4


*Income to FPL*
drop if povrattc_a == 97 | povrattc_a == 98 | povrattc_a == 99
gen income = 0
label var income "ratio of income to FPL (cutoff is 10)"
replace income = povrattc_a
replace income = 10 if povrattc_a > 10

*Educational attainment dummy*
drop if educ_a == 97 | educ_a == 98 | educ_a == 99
gen higher_ed = 0
label var higher_ed "=1 if respondent has completed a bachelor's degree or higher"
replace higher_ed = 1 if educp_a == 8 | educp_a == 9 | educp_a == 10

*Health status*
drop if phstat_a == 7 | phstat_a == 8 | phstat_a == 9
gen health_status = 0
label var health_status "self-reported health status (1 = excellent, 5 = poor)"
replace health_status = phstat_a


***OTHER INSURANCE***
drop if milspc1_a == 7 | milspc1_a == 8 | milspc1_a == 9
gen va_care = 0
label var va_care "=1 if respondent receives care from VA"
replace va_care = 1 if milspc1_a == 1

drop if milspc2_a == 7 | milspc2_a == 8 | milspc2_a == 9
gen tricare = 0
label var tricare "=1 if respondent receives care from Tricare"
replace tricare = 1 if milspc2_a == 1

drop if milspc3_a == 7 | milspc3_a == 8 | milspc3_a == 9
gen champ_va = 0
label var champ_va "=1 if respondent receives care from CHAMPVA"
replace champ_va = 1 if milspc3_a == 1

drop if ihs_a == 7 | ihs_a == 8 | ihs_a == 9
gen ihs_care = 0
label var ihs_care "=1 if respondent receives care from Indian Health Services"
replace ihs_care = 1 if ihs_a == 1


***EXPLANATORY VARIABLE - presence of chronic health conditions***

*Hypertension*
gen hyp = 0
label var hyp "=1 if respondent was told they had hypertension in past 12 mos"
replace hyp = 1 if hypev_a == 1 & hyp12m_a == 1

*High cholesterol*
gen chol = 0
label var chol "=1 if respondent was told they had high cholesterol in past 12 mos"
replace chol = 1 if chlev_a == 1 & chl12m_a == 1

*Coronary artery disease (CAD)*
gen cad = 0
label var cad "=1 if respondent has ever had coronary artery disease"
replace cad = 1 if chdev_a == 1

*Chronic obstructive pulmonary disorder*
gen copd = 0
label var copd "=1 if respondent has ever had chronic obstructive pulmonary disorder"
replace copd = 1 if copdev_a == 1

*Asthma*
gen asth = 0
label var asth "=1 if respondent currently has asthma"
replace asth = 1 if asev_a == 1 & astill_a == 1

*Diabetes (diagnosed after age 60)*
gen diab = 0
label var diab "=1 if respondent was diangosed with diabetes within last 5 years"
replace diab = 1 if dibev_a == 1 
*& dibagetc_a > (agep_a - 5)

*Arthritis*
gen arth = 0
label var arth "=1 if respondent has ever had arthritis"
replace arth = 1 if arthev_a == 1

*Cancer variables*
gen blad_can = 0
label var blad_can "=1 if respodent was diagnosed with bladder cancer within the last 5 years"
replace blad_can = 1 if canev_a == 1 & bladdcan_a == 1 & bladdagetc_a > (age - 5)

gen bone_can = 0
label var bone_can "=1 if respodent was diagnosed with bone cancer within the last 5 years"
replace bone_can = 1 if canev_a == 1 & bonecan_a == 1 & boneagetc_a > (age - 5)

gen brain_can = 0
label var brain_can "=1 if respodent was diagnosed with brain cancer within the last 5 years"
replace brain_can = 1 if canev_a == 1 & braincan_a == 1 & brainagetc_a > (age - 5)

gen breast_can = 0
label var breast_can "=1 if respodent was diagnosed with breast cancer within the last 5 years"
replace breast_can = 1 if canev_a == 1 & breascan_a == 1 & breasagetc_a > (age - 5)

gen cerv_can = 0
label var cerv_can "=1 if respodent was diagnosed with cervical cancer within the last 5 years"
replace cerv_can = 1 if canev_a == 1 & cervican_a == 1 & cerviagetc_a > (age - 5)

gen colon_can = 0
label var colon_can "=1 if respodent was diagnosed with colon cancer within the last 5 years"
replace colon_can = 1 if canev_a == 1 & coloncan_a == 1 & colonagetc_a > (age - 5)

gen esoph_can = 0
label var esoph_can "=1 if respodent was diagnosed with esophageal cancer within the last 5 years"
replace esoph_can = 1 if canev_a == 1 & esophcan_a == 1 & esophagetc_a > (age - 5)

gen gall_can = 0
label var gall_can "=1 if respodent was diagnosed with gallbladder cancer within the last 5 years"
replace gall_can = 1 if canev_a == 1 & gallbcan_a == 1 & gallbagetc_a > (age - 5)

gen laryn_can = 0
label var laryn_can "=1 if respodent was diagnosed with laryngial cancer within the last 5 years"
replace laryn_can = 1 if canev_a == 1 & laryncan_a == 1 & larynagetc_a > (age - 5)

gen leuk_can = 0
label var leuk_can "=1 if respodent was diagnosed with leukemia within the last 5 years"
replace leuk_can = 1 if canev_a == 1 & leukecan_a == 1 & leukeagetc_a > (age - 5)

gen liver_can = 0
label var liver_can "=1 if respodent was diagnosed with liver cancer within the last 5 years"
replace liver_can = 1 if canev_a == 1 & livercan_a == 1 & liveragetc_a > (age - 5)

gen lung_can = 0
label var lung_can "=1 if respodent was diagnosed with lung cancer within the last 5 years"
replace lung_can = 1 if canev_a == 1 & lungcan_a == 1 & lungagetc_a > (age - 5)

gen lymph_can = 0
label var lymph_can "=1 if respodent was diagnosed with lymphoma within the last 5 years"
replace lymph_can = 1 if canev_a == 1 & lymphcan_a == 1 & lymphagetc_a > (age - 5)

gen melan_can = 0
label var melan_can "=1 if respodent was diagnosed with melanoma within the last 5 years"
replace melan_can = 1 if canev_a == 1 & melancan_a == 1 & melanagetc_a > (age - 5)

gen mouth_can = 0
label var mouth_can "=1 if respodent was diagnosed with mouth/tongue/lip cancer within the last 5 years"
replace mouth_can = 1 if canev_a == 1 & mouthcan_a == 1 & mouthagetc_a > (age - 5)

gen ovary_can = 0
label var ovary_can "=1 if respodent was diagnosed with ovarian cancer within the last 5 years"
replace ovary_can = 1 if canev_a == 1 & ovarycan_a == 1 & ovaryagetc_a > (age - 5)

gen panc_can = 0
label var panc_can "=1 if respodent was diagnosed with pancreatic cancer within the last 5 years"
replace panc_can = 1 if canev_a == 1 & pancrcan_a == 1 & pancragetc_a > (age - 5)

gen prost_can = 0
label var prost_can "=1 if respodent was diagnosed with prostate cancer within the last 5 years"
replace prost_can = 1 if canev_a == 1 & prostcan_a == 1 & prostagetc_a > (age - 5)

gen rect_can = 0
label var rect_can "=1 if respodent was diagnosed with rectal cancer within the last 5 years"
replace rect_can = 1 if canev_a == 1 & rectucan_a == 1 & rectuagetc_a > (age - 5)

gen skin_can = 0
label var skin_can "=1 if respodent was diagnosed with skin cancer within the last 5 years"
replace skin_can = 1 if canev_a == 1 & sknmcan_a == 1 & sknmagetc_a > (age - 5)
replace skin_can = 1 if canev_a == 1 & sknnmcan_a == 1 & sknnmagetc_a > (age - 5)
replace skin_can = 1 if canev_a == 1 & skndkcan_a == 1 & skndkagetc_a > (age - 5)

gen stom_can = 0
label var stom_can "=1 if respodent was diagnosed with stomach cancer within the last 5 years"
replace stom_can = 1 if canev_a == 1 & stomacan_a == 1 & stomaagetc_a > (age - 5)

gen throat_can = 0
label var throat_can "=1 if respodent was diagnosed with throat cancer within the last 5 years"
replace throat_can = 1 if canev_a == 1 & throacan_a == 1 & throaagetc_a > (age - 5)

gen thyr_can = 0
label var thyr_can "=1 if respodent was diagnosed with thyroid cancer within the last 5 years"
replace thyr_can = 1 if canev_a == 1 & thyrocan_a == 1 & thyroagetc_a > (age - 5)

gen uter_can = 0
label var uter_can "=1 if respodent was diagnosed with uterine cancer within the last 5 years"
replace uter_can = 1 if canev_a == 1 & uterucan_a == 1 & uteruagetc_a > (age - 5)

gen head_can = 0
label var head_can "=1 if respodent was diagnosed with head/neck cancer within the last 5 years"
replace head_can = 1 if canev_a == 1 & hdnckcan_a == 1 & hdnckagetc_a > (age - 5)

gen colrct_can = 0
label var colrct_can "=1 if respodent was diagnosed with colorectal cancer within the last 5 years"
replace colrct_can = 1 if canev_a == 1 & colrccan_a == 1 & colrcagetc_a > (age - 5)

gen other_can = 0
label var other_can "=1 if respodent was diagnosed with another kind of cancer within the last 5 years"
replace other_can = 1 if canev_a == 1 & othercanp_a == 1 & otheragetc_a > (age - 5)


gen cancer = 0
label var cancer "=1 if respondent was diagnosed with any kind of cancer in last 5 years"
replace cancer = 1 if blad_can == 1
replace cancer = 1 if bone_can == 1
replace cancer = 1 if brain_can == 1
replace cancer = 1 if breast_can == 1
replace cancer = 1 if cerv_can == 1
replace cancer = 1 if colon_can == 1
replace cancer = 1 if esoph_can == 1
replace cancer = 1 if gall_can == 1
replace cancer = 1 if laryn_can == 1
replace cancer = 1 if leuk_can == 1
replace cancer = 1 if liver_can == 1
replace cancer = 1 if lung_can == 1
replace cancer = 1 if lymph_can == 1
replace cancer = 1 if melan_can == 1
replace cancer = 1 if mouth_can == 1
replace cancer = 1 if ovary_can == 1
replace cancer = 1 if panc_can == 1
replace cancer = 1 if prost_can == 1
replace cancer = 1 if rect_can == 1
replace cancer = 1 if skin_can == 1
replace cancer = 1 if stom_can == 1
replace cancer = 1 if throat_can == 1
replace cancer = 1 if thyr_can == 1
replace cancer = 1 if uter_can == 1
replace cancer = 1 if head_can == 1
replace cancer = 1 if colrct_can == 1
replace cancer = 1 if other_can == 1

*Health risk score calculator*
gen ma_risk = 0
label var ma_risk "calculated risk score of respondent (based on Medicare HCCs)"

replace ma_risk = ma_risk + .1949 if (female == 1)
replace ma_risk = ma_risk + .1340 if (female == 0)

gen cancer_9 = 0
label var cancer_9 "Cancer with HCC 9"
replace cancer_9 = 1 if (esoph_can == 1) | (gall_can == 1) | (liver_can == 1) | (lung_can == 1) | (panc_can == 1) | (stom_can == 1)

gen cancer_10 = 0
label var cancer_10 "Cancer with HCC 10"
replace cancer_10 = 1 if (bone_can == 1) | (brain_can == 1) | (leuk_can == 1) | (lymph_can == 1) | (ovary_can == 1) 

gen cancer_11_12 = 0
label var cancer_11_12 "Cancer with HCC 11 or 12"
replace cancer_11_12 = 1 if (cancer == 1) & (cancer_9 == 0) & (cancer_10 == 0)

replace ma_risk = ma_risk + .8743 if (cancer_9 == 1)
replace ma_risk = ma_risk + .6678 if (cancer_10 == 1) & (cancer_9 == 0)
replace ma_risk = ma_risk + .2083 if (cancer_11_12 == 1) & (cancer_10 == 0) & (cancer_9 == 0)

replace ma_risk = ma_risk + .0762 if (copd == 1)

replace ma_risk = ma_risk + .6713 if (cad == 1)

replace ma_risk = ma_risk + .2462 if (arth == 1)

replace ma_risk = ma_risk + .0555 if (diab == 1)

*Calculates # of chronic health conditions an individual has*
gen hcc_count = 0
label var hcc_count "number of chronic conditions an individual has"
replace hcc_count = cad + copd + arth + diab + cancer_9 + cancer_10 + cancer_11_12

replace ma_risk = ma_risk + .0433 if hcc_count == 5
replace ma_risk = ma_risk + .1425 if hcc_count == 6
replace ma_risk = ma_risk + .2854 if hcc_count == 7
replace ma_risk = ma_risk + .4763 if hcc_count == 8


*Risk score normalization (so mean is always 1)*
*Divide every risk score by mean*

gen ma_risk_n = 0
replace ma_risk_n = ma_risk / .4171434 if age >= 65

*Normalization so mean for 65/66 y/os is 1*
gen ma_risk_65 = 0
replace ma_risk_65 = ma_risk / .3468396 if u67 == 1

*Normalization so mean for 67+ y/os is 1*
gen ma_risk_piep = 0
replace ma_risk_piep = ma_risk / .3306414 if u67 == 0


twoway (histogram ma_risk_n if u67 == 1 & nrma == 0 & med_adv == 1, width(.5) frac) ///
(histogram ma_risk_n if u67 == 1 & nrma == 0 & med_adv == 0, width(.5) color(red) frac)



svy: mean hyp if u67 == 1 & no_response_ma == 0 & med_adv == 1
svy: mean hyp if u67 == 1 & no_response_ma == 0 & med_adv == 0

svy: mean chol if u67 == 1 & no_response_ma == 0 & med_adv == 1
svy: mean chol if u67 == 1 & no_response_ma == 0 & med_adv == 0

svy: mean cad if u67 == 1 & no_response_ma == 0 & med_adv == 1
svy: mean cad if u67 == 1 & no_response_ma == 0 & med_adv == 0

svy: mean copd if u67 == 1 & no_response_ma == 0 & med_adv == 1
svy: mean copd if u67 == 1 & no_response_ma == 0 & med_adv == 0

svy: mean asth if u67 == 1 & no_response_ma == 0 & med_adv == 1
svy: mean asth if u67 == 1 & no_response_ma == 0 & med_adv == 0

svy: mean diab if u67 == 1 & no_response_ma == 0 & med_adv == 1
svy: mean diab if u67 == 1 & no_response_ma == 0 & med_adv == 0

svy: mean arth if u67 == 1 & no_response_ma == 0 & med_adv == 1
svy: mean arth if u67 == 1 & no_response_ma == 0 & med_adv == 0

svy: mean cancer if u67 == 1 & no_response_ma == 0 & med_adv == 1
svy: mean cancer if u67 == 1 & no_response_ma == 0 & med_adv == 0



gen mar_1 = 0
gen mar_2 = 0
gen mar_3 = 0
gen mar_4 = 0
gen mar_5 = 0
gen mar_6 = 0
gen mar_7 = 0
gen mar_8 = 0

replace mar_1 = 1 if ma_risk_n < 0.5
replace mar_2 = 1 if ma_risk_n >= 0.5 & ma_risk_n < 1
replace mar_3 = 1 if ma_risk_n >= 1 & ma_risk_n < 1.5
replace mar_4 = 1 if ma_risk_n >= 1.5 & ma_risk_n < 2
replace mar_5 = 1 if ma_risk_n >= 2 & ma_risk_n < 2.5
replace mar_6 = 1 if ma_risk_n >= 2.5 & ma_risk_n < 3
replace mar_7 = 1 if ma_risk_n >= 3 & ma_risk_n < 4
replace mar_8 = 1 if ma_risk_n >= 4



svy: logistic med_adv hyp ///
female white black hispanic asian native native_other ///
higher_ed income ///
va_care tricare champ_va ihs_care ///
y2019 y2020 y2021 y2022 ///
if no_response_ma == 0
margins, dydx(*)

svy: logistic med_adv chol ///
female white black hispanic asian native native_other ///
higher_ed income ///
va_care tricare champ_va ihs_care ///
y2019 y2020 y2021 y2022 ///
if no_response_ma == 0
margins, dydx(*)

svy: logistic med_adv cad ///
female white black hispanic asian native native_other ///
higher_ed income ///
va_care tricare champ_va ihs_care ///
y2019 y2020 y2021 y2022 ///
if no_response_ma == 0
margins, dydx(*)

svy: logistic med_adv copd ///
female white black hispanic asian native native_other ///
higher_ed income ///
va_care tricare champ_va ihs_care ///
y2019 y2020 y2021 y2022 ///
if no_response_ma == 0
margins, dydx(*)

svy: logistic med_adv asth ///
female white black hispanic asian native native_other ///
higher_ed income ///
va_care tricare champ_va ihs_care ///
y2019 y2020 y2021 y2022 ///
if no_response_ma == 0
margins, dydx(*)

svy: logistic med_adv diab ///
female white black hispanic asian native native_other ///
higher_ed income ///
va_care tricare champ_va ihs_care ///
y2019 y2020 y2021 y2022 ///
if no_response_ma == 0
margins, dydx(*)

svy: logistic med_adv arth ///
female white black hispanic asian native native_other ///
higher_ed income ///
va_care tricare champ_va ihs_care ///
y2019 y2020 y2021 y2022 ///
if no_response_ma == 0
margins, dydx(*)

svy: logistic med_adv cancer ///
female white black hispanic asian native native_other ///
higher_ed income ///
va_care tricare champ_va ihs_care ///
y2019 y2020 y2021 y2022 ///
if no_response_ma == 0
margins, dydx(*)






svy: logistic med_adv ma_risk_n ///
female white black hispanic asian native native_other ///
higher_ed income ///
va_care tricare champ_va ihs_care ///
y2019 y2020 y2021 y2022 ///
if no_response_ma == 0
margins, dydx(*)










