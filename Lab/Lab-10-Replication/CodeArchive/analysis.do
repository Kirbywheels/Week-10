// ==========================================================================

// Lab 10 Analysis

// ==========================================================================

// standard opening options

set more off
set linesize 80

// ==========================================================================

/*
file name - analysis.do

project name - SOC5050: Quantitative Analysis, Fall 2016

purpose - Statistical output and plots for Lab 10

created - 05 Nov 2016

updated - 05 Nov 2016

author - CHRIS
*/

// ==========================================================================

/*
full description -
This do-file exectues analytical commands and creates plots for Lab 10.
*/

/*
updates -
none
*/

// ==========================================================================

/*
superordinates  -
- hsb2.dta
- master.do
*/

/*
subordinates -
none
*/

// ==========================================================================
// ==========================================================================
// ==========================================================================

// start MarkDoc log
quietly log using "$projName/$projName-markdoc.smcl", ///
  replace smcl name(markdoc)

// OFF
// ==========================================================================
// ON

/***
# Lab 11
  - SOC 5050: Quantitative Analysis
  - 05 Nov 2016
  - CHRIS

### Part 1 - One-Sample T-Test
***/

ttest socst==54

//OFF
// set local macros
local t = round(r(t),.001)
local p = round(r(p),.001)

// collapse dataset
collapse (mean) mean = socst (sd) sd = socst (count) n = socst

// caclulate stnadard error
generate se = sd/sqrt(n)

// create categorical indicator
generate cat = 1

// generate plot
serrbar mean se cat, scale(1.96) ///
	yline(54, lcolor(red)) yscale(r(49.9 55.1)) ///
	ylabel(50(1)55, grid) ytitle("Mean Social Studies Score") ///
	xlabel(none) xtitle("") ///
	scheme(s2mono) ///
	graphregion(color("235 235 235")) ///
	plotregion(color("255 255 255")) ///
	bgcolor("235 235 235") ///
  title("One Sample T-Test: Social Studies Score and {&mu}=54") ///
	text(54.1 1 "{&mu}", place(n)) ///
  note("Results: {it:t} = `t', {it:p} = `p'") ///
	caption("Produced by Christopher Prener, Ph.D.; Data via UCLA ATS")

// explort plot
graph export "$projName/Plots/fig1.png", ///
  as(png) width(1000) height(750) replace

// reopen data
use "$projName/$newData", clear

//ON

/***
![fig1](https://raw.githubusercontent.com/slu-soc5050/Week-10/master/Lab/Lab-10-Replication/Plots/fig1.png)
***/

txt "**1.** The results of the one-sample t-test (t = " `t' "; p = " ///
  `p' ") indicate that these data are not drawn from where " ///
  "the average score is 54."

ttest science==54

//OFF
// set local macros for key values
local t = round(r(t),.001)
local p = round(r(p),.001)

// collapse dataset
collapse (mean) mean = science (sd) sd = science (count) n = science

// caclulate stnadard error
generate se = sd/sqrt(n)

// create categorical indicator
generate cat = 1

// generate plot
serrbar mean se cat, scale(1.96) ///
	yline(54, lcolor(red)) yscale(r(49.9 55.1)) ///
	ylabel(50(1)55, grid) ytitle("Mean Science Score") ///
	xlabel(none) xtitle("") ///
	scheme(s2mono) ///
	graphregion(color("235 235 235")) ///
	plotregion(color("255 255 255")) ///
	bgcolor("235 235 235") ///
title("One Sample T-Test: Science Score and {&mu}=54") ///
	text(54.1 1 "{&mu}", place(n)) ///
  note("Results: {it:t} = `t', {it:p} = `p'") ///
	caption("Produced by Christopher Prener, Ph.D.; Data via UCLA ATS")

// export plot
graph export "$projName/Plots/fig2.png", ///
  as(png) width(1000) height(750) replace

// reopen dataset
use "$projName/$newData", clear

//ON

/***
![fig2](https://raw.githubusercontent.com/slu-soc5050/Week-10/master/Lab/Lab-10-Replication/Plots/fig2.png)
***/

txt "**2.** Like question **1**, the results of the one-sample " ///
  "t-test (t = " `t' "; p = " `p' ") indicate that these " ///
  "data are not drawn from where the average score is 54."

/***
### Part 2 - Independent T-Test
***/

sdtest science, by(female)

txt "**3.** The results of the Levene's test (f = " %10.3f r(F) "; p = " ///
  %10.3f r(p) ") indicate that the assumption of homogenetiy of variance" ///
  " holds for these data. The variance of science scores for men is " ///
  "not significantly different from the variance of science scores for women."

ttest science, by(female)

//OFF

// store value of t
local t = round(r(t),.001)

// store value of p
local p = round(r(p),.0001)

//ON

esize twosample science, by(female) cohensd

//OFF
// store value of d
local d = round(r(d),.001)

// collapse dataset
collapse (mean) mean = science (sd) sd = science (count) n = science, by(female)

// calculate standard error
generate se = sd/sqrt(n)

// generate plot
serrbar mean se female, scale(1.96)  ///
	ytitle("Mean Science Scores") ///
	xscale(r(-.2 1.2)) ///
	xlabel(0 "male" 1 "female") xtitle("Gender") ///
	scheme(s2mono) ///
	graphregion(color("235 235 235")) ///
	plotregion(color("255 255 255")) ///
	bgcolor("235 235 235") ///
	title("Two Sample T-Test: Science Scores by Gender") ///
	note("Results: {it:t} = `t', {it:p} = `p', Cohen's {it:d} = `d'") ///
	caption("Produced by Christopher Prener, Ph.D.; Data via UCLA ATS")

// export plot
graph export "$projName/Plots/fig3.png", ///
  as(png) width(1000) height(750) replace

// reopen dataset
use "$projName/$newData", clear
//ON

/***
![fig3](https://raw.githubusercontent.com/slu-soc5050/Week-10/master/Lab/Lab-10-Replication/Plots/fig3.png)
***/

txt "**5.** The results of the independent t-test (t = " `t' "; p = " ///
  `p' "; d = " `d' ") indicate that there is not a substantive difference" ///
  " in mean science scores between males and females in this sample."

txt "**6.** The results of the Cohen's d test (d = " `d' ") are " ///
  "consistent with there not being a substantive difference in mean " ///
  "science scores by gender - the reported effect size is small."

/***
### Part 3 - Dependent T-test
***/

ttest write==socst

//OFF

// store value of t
local t = round(r(t),.001)

// store value of p
local p : display %-10.3f r(p)

// store mean, standard deviation, and n for read
local mean1 = r(mu_1)
local sd1 = r(sd_1)
local n1 = r(N_1)

// store mean, standard deviation, and n for write
local mean2 = r(mu_2)
local sd2 = r(sd_2)
local n2 = r(N_2)

// clear loaded dataset
clear

// create simple dataset for summary data
set obs 2

// create variables
generate cat = .
generate mean = .
generate sd = .
generate n = .

// add summary data for write
replace cat = 0 in 1
replace mean = `mean1' in 1
replace sd = `sd1' in 1
replace n = `n1' in 1

// add summary data for social science
replace cat = 1 in 2
replace mean = `mean2' in 2
replace sd = `sd2' in 2
replace n = `n2' in 2

// calculate standard error
generate se = sd/sqrt(n)

// generate plot
serrbar mean se cat, scale(1.96) ///
  yscale(r(49.9 55.1)) ///
  ylabel(50(1)55, grid) ytitle("Mean Scores") ///
	xscale(r(-.2 1.2)) ///
	xlabel(0 "writing" 1 "social science") xtitle("Score Type") ///
	scheme(s2mono) ///
	graphregion(color("235 235 235")) ///
	plotregion(color("255 255 255")) ///
	bgcolor("235 235 235") ///
	title("Dependent Sample T-Test:") ///
  subtitle("Writing and Social Science Scores") ///
	note("Results: {it:t} = `t', {it:p} = `p'") ///
	caption("Produced by Christopher Prener, Ph.D.; Data via UCLA ATS")

// export plot
graph export "$projName/Plots/fig4.png", ///
  as(png) width(1000) height(750) replace

// clear dataset
clear

//ON

/***
![fig4](https://raw.githubusercontent.com/slu-soc5050/Week-10/master/Lab/Lab-10-Replication/Plots/fig4.png)
***/

txt "**8.** The results of the dependent t-test (t = " `t' "; p = " ///
  `p' "; d = " `d' ") indicate that there is not a substantive difference" ///
  " between mean writing and social science scores in this sample."

/***
### Part 4 - Power Analyses
***/

local effectSize = 9.900891*.2
local lowerMean = 53-`effectSize'

power twomeans 53 `lowerMean', sd(9.900891) power(0.8)

txt "**10.** We use the output above in question **5**, we estimate " ///
  "a mean science score for men as 53, for women as " ///
  %10.3f `lowerMean' ", with a standard deviation of " %10.3f r(sd) ", " ///
  "as pilot data to construct the power analysis. To detect a " ///
  "small effect size with a power of 0.8, a sample size of " ///
  r(N) " would be required with a minimum of " r(N1) " in each group."

local effectSize = 9.900891*.5
local lowerMean = 53-`effectSize'

power twomeans 53 `lowerMean', sd(9.900891) power(0.9)

txt "**11.** Based on the output above in question **5**, we estimate " ///
  "a mean science score for men as 53, for women as " ///
  %10.3f `lowerMean' ", with a standard deviation of " %10.3f r(sd) ", " ///
  "as pilot data to construct the power analysis. To detect a " ///
  "moderate effect size with a power of 0.9, a sample size of " ///
  r(N) " would be required with a minimum of " r(N1) " in each group."

local effectSize = 9.900891*.8
local lowerMean = 53-`effectSize'

power twomeans 53 `lowerMean', sd(9.900891) power(0.9)

txt "**12.** Based on the output above in question **5**, we estimate " ///
  "a mean science score for men as 53, for women as " ///
  %10.3f `lowerMean' ", with a standard deviation of " %10.3f r(sd) ", " ///
  "as pilot data to construct the power analysis. To detect a " ///
  "large effect size with a power of 0.8, a sample size of " ///
  r(N) " would be required with a minimum of " r(N1) " in each group."

// OFF
// ==========================================================================

// end MarkDoc log
quietly log close markdoc

// convert MarkDoc log to Markdown
markdoc "$projName/$projName-markdoc", ///
  replace export(md) install

// ==========================================================================
// ==========================================================================
// ==========================================================================

// exit
